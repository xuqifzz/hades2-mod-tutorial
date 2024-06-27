TraitSetData.Talents =
{
	LegendaryTalent = 
	{
		RarityLevels =
		{
			Legendary =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
		},
	},
	PreChargeTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_43",
		MaxCount = 2,						--How many maximum times this can be served in a tree
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		SpellPreCharge = { BaseValue = 0.4 },
		ExtractValues = 
		{
			{
				Key = "SpellPreCharge",
				ExtractAs = "Charge",
				Format = "Percent",
				HideSigns = true,
			},
		},
	},
	ChargeRegenTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_35",
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SorceryChargeSetup",
			Args =
			{
				Name = "Talent",
				ChargePerSecond = { BaseValue = 1 },
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
	CooldownDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_36",
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			SpellCooldownMultiplier=
			{
				BaseValue = 1.05,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedDamageBoost = "SpellCooldownMultiplier"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		},
	},
	
	MinorManaDiscountTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_43",
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,
			},
			Epic =	
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Heroic =
			{
				MinMultiplier = 2.5,
				MaxMultiplier = 2.5,
			},
		},
	
		ManaSpendCostModifiers = 
		{
			Add = { BaseValue = -5 },
			ReportValues = { ReportedManaCost = "Add" }
		},
		ExtractValues = 
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaReduction",
			},
		}
	},
	
	ManaDiscountTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_35",
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,
			},
			Epic =	
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Heroic =
			{
				MinMultiplier = 2.5,
				MaxMultiplier = 2.5,
			},
		},
	
		ManaSpendCostModifiers = 
		{
			Add = { BaseValue = -10 },
			ReportValues = { ReportedManaCost = "Add" }
		},
		ExtractValues = 
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaReduction",
			},
		}
	},

	ChargeSpeedTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_10",
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 0.93,
				MaxMultiplier = 0.93,
			},
			Epic =	
			{
				MinMultiplier = 0.86,
				MaxMultiplier = 0.86,
			},
			Heroic =
			{
				MinMultiplier = 0.79,
				MaxMultiplier = 0.79,
			},
			Legendary =
			{
				MinMultiplier = 0.72,
				MaxMultiplier = 0.72,
			},
		},
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroSpellWeapons,
				WeaponProperty = "ChargeTime",
				BaseValue = 0.7,
				ChangeType = "Multiply",
				ReportValues = { AttackSpeed = "BaseValue" },
			},
			{
				WeaponNames = WeaponSets.HeroSpellWeapons,
				WeaponProperty = "ClipRegenInterval",
				BaseValue = 0.7,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ReportValues = { ReportedReduction = "BaseValue" }
			},
		},
		ExtractValues =
		{
			{
				Key = "AttackSpeed",
				ExtractAs = "ChangeValue",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
			{
				Key = "ReportedReduction",
				ExtractAs = "TooltipMultiplier",
				Format = "NegativePercentDelta"
			},
		},
	},
	PotionManaRestoreTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_49",
		PotionManaRestored = {BaseValue = 50},
		ExtractValues =
		{
			{
				Key = "PotionManaRestored",
				ExtractAs = "ManaRestored",
			},
		},
	},
	PotionUsesTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_50",
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
			},
			Heroic =
			{
				Multiplier = 4,
			},
			Legendary =
			{
				Multiplier = 5,
			},
		},
		AcquireFunctionName = "GrantPotionBonusCharges",
		AcquireFunctionArgs = 
		{
			BonusCharges = 1,
		},
		BonusSpellUses = { BaseValue = 1 },
		
		ExtractValues =
		{
			{
				Key = "BonusSpellUses",
				ExtractAs = "BonusUses",
			},
		},
	},

	RolloverUsesTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_87",
		RolloverSpellUses = true,
	},

	CurrencyUseTalent = 
	{
		InheritFrom = {"SpellTalentTrait" },
		Icon = "Boon_Selene_47",
		MoneyOnSpell = { BaseValue = 15 },
		ExtractValues =
		{
			{
				Key = "MoneyOnSpell",
				ExtractAs = "BonusMoney",
			},
		},
	},

	ClearCastTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_88",
		OnManaSpendAction = 
		{
			FunctionName = "CheckClearCastManaRefund",
			FunctionArgs = 
			{
				AnimationName = "ManaRegenFlashFx",
				Duration = 1,
			}
		},
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "ClearCastDuration",
				ExtractAs = "Duration",
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "ClearCast",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "ExDamageMultiplier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				Format = "PercentDelta",
				BaseName = "ClearCast",
				BaseProperty = "Amount",
				DecimalPlaces = 1,
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	
	HealRetaliateTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_89",
		-- Driven via HeroHasTrait
		OnSelfDamagedFunction = 
		{
			Name = "RecordLastDamaged",
		},
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	HealLastTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_86",
		OnSelfDamagedFunction = 
		{
			Name = "RecordDamageInWindow",
			FunctionArgs = 
			{
				HealWindowDuration = 2.0,
				ReportValues = { ReportedWindow = "HealWindowDuration"}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedWindow",
				ExtractAs = "Duration",
			},
		},
	},

	DamageBuffTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_85",
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 0.8,
				MaxMultiplier = 0.8,
			},
			Rare =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Epic =	
			{
				MinMultiplier = 1.2,
				MaxMultiplier = 1.2,
			},
			Heroic =
			{
				MinMultiplier = 1.4,
				MaxMultiplier = 1.4,
			},
			Legendary =
			{
				MinMultiplier = 1.6,
				MaxMultiplier = 1.6,
			},
		},
		
		OnWeaponFiredFunctions =
		{
			ValidWeapons = WeaponSets.HeroSpellWeapons,
			FunctionName = "ApplySelfBuff",
			FunctionArgs = 
			{
				Modifier = 1.5,
				Duration = { BaseValue = 5 },
				ReportValues = 
				{ 
					ReportedDuration = "Duration",
					ReportedBonus = "Modifier" 
				},
				EffectName = "SelfBuffOutput"
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
			},
			{
				Key = "ReportedBonus",
				ExtractAs = "DamageBonus",
				Format = "PercentDelta",
				SkipAutoExtract = true,
			},
		}
	},

	ShieldTalent = 
	{
		InheritFrom = { "SpellTalentTrait" },
		Icon = "Boon_Selene_84",
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
		
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroSpellWeapons,
				EffectName = "BuffInvulnerable",
				EffectProperty = "Active",
				ChangeValue = true
			},
			{
				WeaponNames = WeaponSets.HeroSpellWeapons,
				EffectName = "BuffInvulnerable",
				EffectProperty = "Duration",
				ChangeValue = 2,
				ReportValues = { ReportedDuration = "ChangeValue"}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
			},
		}

	},
	-- Heal Talents = 
	HealAmountTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_48",
		BonusSpellHeal = { BaseValue = 10, AsInt = true },
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,
			},
			Epic =	
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Heroic =
			{
				MinMultiplier = 2.5,
				MaxMultiplier = 2.5,
			},
			Legendary =
			{
				MinMultiplier = 3.0,
				MaxMultiplier = 3.0,
			},
		},
		ExtractValues =
		{
			{
				Key = "BonusSpellHeal",
				ExtractAs = "HealAmount",
			},
		}
	},
	-- Time Slow Talents
	
	CooldownDefenseTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_37",
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		AddIncomingDamageModifiers =
		{
			SpellCooldownMultiplier=
			{
				BaseValue = 0.95,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedDefense = "SpellCooldownMultiplier"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDefense",
				ExtractAs = "Defense",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		},
	},

	TimeSlowAmountTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_38",
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Epic =	
			{
				MinMultiplier = 3.0,
				MaxMultiplier = 3.0,
			},
			Heroic =
			{
				MinMultiplier = 4.0,
				MaxMultiplier = 4.0,
			},
			Legendary =
			{
				MinMultiplier = 5.0,
				MaxMultiplier = 5.0,
			},
		},
		TimeSlowModifiers = 
		{ 
			ValidWeapons = WeaponSets.HeroSpellWeapons,
			AddDuration = { BaseValue = 1 },
			ReportValues = { AddDuration = "AddDuration" }
		},
		
		ExtractValues =
		{
			{
				Key = "AddDuration",
				ExtractAs = "DurationAmount",
				DecimalPlaces = 2,
			},
		}
	},
	
	TimeSlowSpeedTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_61",
		TimeSlowSpeed = { BaseValue = 0.7, SourceIsMultiplier = true },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.0,
			},
			Epic =	
			{
				Multiplier = 1.0,
			},
			Heroic =
			{
				Multiplier = 1.0,
			},
			Legendary =
			{
				Multiplier = 1.0,
			},
		},
		ExtractValues =
		{
			{
				Key = "TimeSlowSpeed",
				ExtractAs = "SpeedBonus",
				Format = "NegativePercentDelta",
			},
		}
	},
	TimeSlowCritTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_63",
		OnTimeSlowStartFunction = 
		{
			Name = "StartTimeSlowCrit",
			Args = 
			{
				Chance = 0.2,
				ReportValues = { ReportedChance = "Chance" }
			}
		},
		OnTimeSlowEndFunction = 
		{
			Name = "EndTimeSlowCrit",
		},
		ManaSpendCostModifiers = 
		{
			Add = 40,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "CritBonus",
				Format = "Percent",
				IncludeSigns = true,
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	TimeSlowDestroyProjectilesTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_59",
		OnTimeSlowStartFunction = 
		{
			Name = "TimeSlowDestroyProjectiles",
		},
	},
	TimeSlowFreezeTimeTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_64",
		TimeSlowModifier = 0.05,
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues = 
		{
			{
				Key = "TimeSlowModifier",
				ExtractAs = "TimeSlow",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	SpellChargeBonusTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_62",
		SpellChargeModifiers = 
		{
			ValidSource = "WeaponCastArm",
			Multiplier = 1.2,
			ReportValues = { ReportedMultiplier = "Multiplier" }
		},
		ManaSpendCostModifiers = 
		{
			Add = 30,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Multiplier",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	TimeSlowCumulativeBuffTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_58",
		AddOutgoingDamageModifiers =
		{
			UseTraitValue = "TimeSlowDamageBonus",
		},
		OnTimeSlowStartFunction = 
		{
			Name = "TimeSlowResetBuff",
		},
		TimeSlowDamageBonus = 1,
		OnEnemyDeathFunction = 
		{
			Name = "TimeSlowDamageBonus",
			FunctionArgs = {
				DamageIncrease = 0.01,
				ReportValues = 
				{ 
					ReportedDamageBonus = "DamageIncrease",
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageBonus",
				Format = "Percent",
			},
			{
				Key = "TimeSlowDamageBonus",
				ExtractAs = "CurrentBonus",
				Format = "PercentDelta",
			},
		}

	},
	TimeSlowLastStandRechargeTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_105",
		RechargeSpellOnLastStand = true,
		ExtractValues =
		{
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
	TimeSlowDashTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_15",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 2.00,
			},
			Epic =
			{
				Multiplier = 3.00,
			},
			Heroic =
			{
				Multiplier = 4.00,
			},
			Legendary =
			{
				Multiplier = 5.00,
			},
		},
		TimeSlowDashes = {BaseValue = 1, AsInt = true },
		ExtractValues =
		{
			{
				Key = "TimeSlowDashes",
				ExtractAs = "DashAmount",
			},
		}
	},

	TimeSlowProtectionTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_16",
	},

	-- Laser Talents --
	LaserCrystalTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_74",
		
		SetupFunction =
		{
			Name = "LaserMatchDuration",
		},
		ManaSpendCostModifiers = 
		{
			Add = 60,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellLaser",
				WeaponProperties = 
				{
					FullyAutomatic = false,
					RefreshProjectileOnFire = false,
					--ChargeTime = 0.1,
					--OnlyChargeOnce = false,
					--ChargeCancelGraphic = "MelinoeSpellMovingFire",
					--FireGraphic = "MelinoeSpellFireHold",
					--TriggerReleaseGraphic = "MelinoeSpellFireCancellable",
				}
			},
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperties = 
				{
					AttachToOwner = false,
					MaxAdjustRate = math.rad(6),
					AutoAdjustForTarget = true,
				},
			},
		},
	},
	LaserPatienceTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_15",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "TimeThreshold",
				ChangeValue = 1.0,
				ReportValues = { ReportedTimeThreshold = "ChangeValue" }
			},
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "ArcSizeTimeThresholdMultiplier",
				ChangeValue = 5,
				SourceIsMultiplier = true,
				ChangeType = "Absolute",
				ReportValues = { ReportedArcSizeMultiplier = "ChangeValue" }
			},
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "DamageTimeThresholdMultiplier",
				BaseValue = 2,
				SourceIsMultiplier = true,
				ChangeType = "Absolute",
				ReportValues = { ReportedDamageMultiplier = "ChangeValue" }
			},

		},
		ExtractValues =
		{
			{
				Key = "ReportedTimeThreshold",
				ExtractAs = "TimeThreshold",
			},
			{
				Key = "ReportedArcSizeMultiplier",
				ExtractAs = "SizeMultiplier",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedDamageMultiplier",
				ExtractAs = "DamageMultiplier",
				Format = "PercentDelta",
			},
		}
	},
	LaserSpeedTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_16",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellLaser",
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.35,
				ChangeType = "Multiply"
			},
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "DamagePerConsecutiveHit",
				BaseValue = 1.0,
				ChangeType = "Absolute",
				ReportValues = { ReportedDamageRamp = "ChangeValue" }
			},

			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "ConsecutiveHitWindow",
				ChangeValue = 0.15,
				ChangeType = "Absolute",
			},

		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageRamp",
				ExtractAs = "DamageRamp",
			},
		}
	},
	LaserTripleTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_77",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellLaser",
				WeaponProperty = "NumProjectiles",
				ChangeValue = 3,
				ReportValues = { ReportedProjectiles = "ChangeValue" }
			},
		},
		ManaSpendCostModifiers = 
		{
			Add = 60,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "ReportedProjectiles",
				ExtractAs = "Projectiles",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		}
	},
	LaserAoETalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_73",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "DamageRadius",
				ChangeValue = 260,
			},
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "BlastSpeed",
				ChangeValue = 3000,
			},
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "DamageRadiusScaleY",
				ChangeValue = 0.5,
			},
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "ExpandBlastDuringDetonation",
				ChangeValue = true,
			},
		},
	},
	LaserDurationTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_72",
		LaserDurationBonus = { BaseValue = 1 },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1,
			},
			Heroic =
			{
				Multiplier = 1,
			},
		},
		ExtractValues = 
		{
			{
				Key = "LaserDurationBonus",
				ExtractAs = "Time",
			},
		},
	},
	LaserDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_41",
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidBaseDamageAddition =
			{
				BaseValue = 4,
			},
			ValidWeapons = { "WeaponSpellLaser" },
			ReportValues = { ReportedDamageBoost = "ValidBaseDamageAddition"},
		},
		
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				Format = "DamageOverTime",
				BaseName = "ProjectileSpellLaser",
				BaseProperty = "Fuse",
				ExtractAs = "Damage",
			},
		},
	},
	LaserDefenseTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_42",
		DefenseDuringLaser = { BaseValue = 0.1 },
		
		ExtractValues = 
		{
			{
				Key = "DefenseDuringLaser",
				ExtractAs = "Defense",
				Format = "Percent",
				HideSigns = true,
			},
		},
	},
	LaserPrimaryTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_76",
		AddWeaponsToTraits = 
		{
			WeaponName = "WeaponSpellLaser",
			Slot = "Melee",
		},
		PropertyChanges = 
		{
			{
				TraitName = "ApolloWeaponBoon",
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "ArcSize",
				ChangeValue = 2,
				ChangeType = "Multiply",
			},
		},
		ExtractValues = 
		{
			{
				ExtractAs = "SlotBoon",
				Slot = "Melee",
				Format = "SlottedBoon"
			},
		},
	},
	LaserPenetrationTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_75",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellLaser",
				ProjectileProperty = "UnlimitedUnitPenetration",
				ChangeValue = true,
			},
		}
	},
	-- Polymorph Talents --
	PolymorphBossDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_67",
		PolymorphBossDamage = { BaseValue = 200 },
		ExtractValues = 
		{
			{
				Key = "PolymorphBossDamage",
				ExtractAs = "Damage",
			},
		},
	},
	PolymorphTeleportCastTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_69",
		OnWeaponFiredFunctions =
		{
			ValidWeapons = {"WeaponCast" },
			FunctionName = "PolymorphCastTeleport",
		},
		ExtractValues =
		{
			{		
				External = true,
				BaseName = "PolymorphTag",
				BaseType = "Effect",
				WeaponName = "WeaponSpellPolymorph",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "Duration",
			},
		}
	},
	PolymorphHealthCrushTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_68",
		PolymorphHealthMultiplier = 0.95,
		ExtractValues =
		{
			{
				Key = "PolymorphHealthMultiplier",
				ExtractAs = "Multiplier",
				Format = "NegativePercentDelta",
				HideSigns = true
			},
			{		
				External = true,
				BaseName = "PolymorphTag",
				BaseType = "Effect",
				WeaponName = "WeaponSpellPolymorph",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "Duration",
			},
		}
	},
	PolymorphAoETalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_14",
	
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 0.8,
			},
			Epic =
			{
				Multiplier = 0.6,
			},
			Heroic =
			{
				Multiplier = 0.4,
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellPolymorph",
				WeaponProperties = 
				{
					ChargeStartAnimation = "Melinoe_Cast_Fire",
					ChargeStartFx = "ShieldCharge",
					ChargeFinishFx = "RadialNova",
					FireOnRelease = true,
					ChargeRadiusMultiplier = 50,
					MinChargeToFire = 0.01,
				},
			},
			{
				WeaponName = "WeaponSpellPolymorph",
				ProjectileProperties = 
				{
					DamageRadius = 10,
				},
			},
			{
				WeaponName = "WeaponSpellPolymorph",
				WeaponProperty = "ChargeTime",
				BaseValue = 3,
				ReportValues = { ReportedChargeTime = "ChangeValue" }
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedChargeTime",
				ExtractAs = "ChargeTime",
			},
			{		
				External = true,
				BaseName = "PolymorphTag",
				BaseType = "Effect",
				WeaponName = "WeaponSpellPolymorph",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "Duration",
			},
		}
	},
	PolymorphDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_40",
	
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
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellPolymorph",
				EffectName = "PolymorphDamageTaken",
				EffectProperty = "Modifier",
				BaseValue = 1.1,
				SourceIsMultiplier = true,
				ReportValues = { ReportedDamageTaken = "ChangeValue" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageTaken",
				ExtractAs = "DamageTaken",
				Format = "PercentDelta",
			},
			{		
				External = true,
				BaseName = "PolymorphTag",
				BaseType = "Effect",
				WeaponName = "WeaponSpellPolymorph",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "Duration",
			},
		}
	
	},
	PolymorphManaTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_16",
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
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
		},
		SetupFunction =
		{
			Name = "PolymorphManaRegenSetup",
			Args =
			{
				Name = "PolymorphManaTalent",
				ManaRegenPerSecond = { BaseValue = 2 },
				RequiredPolymorphTargets = 2,
				ReportValues = 
				{ 
					ReportedManaRecovery = "ManaRegenPerSecond",
					ReportedTargetRequirement = "RequiredPolymorphTargets" 
				}
			},
			RunOnce = true
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "Mana",
				DecimalPlaces = 1,
			},
			{
				Key = "ReportedTargetRequirement",
				ExtractAs = "Targets",
			},
			{		
				External = true,
				BaseName = "PolymorphTag",
				BaseType = "Effect",
				WeaponName = "WeaponSpellPolymorph",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "Duration",
			},
		},
	},
	PolymorphDeathExplodeTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_65",

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.0,
			},
			Epic =
			{
				Multiplier = 1.0,
			},
			Heroic =
			{
				Multiplier = 1.0,
			},
		},
		OnEnemyDeathFunction = 
		{
			Name = "CheckPolymorphDeathExplosion",
			FunctionArgs = 
			{
				ProjectileName = "PolymorphNova",
				ProjectileDamageMultiplier = { BaseValue = 1.0 },
				ReportValues = { ReportedDamageMultiplier = "ProjectileDamageMultiplier"}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "PolymorphNova",
				BaseProperty = "Damage",
			},
			{		
				External = true,
				BaseName = "PolymorphTag",
				BaseType = "Effect",
				WeaponName = "WeaponSpellPolymorph",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "Duration",
			},
		},
	},
	PolymorphSandwichTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_71",
		PolymorphSandwichChance = { BaseValue = 0.2 },
		PolymorphRoomCap = 1,
		ReportedSandwichHealValue = 10,
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "PolymorphSandwichChance",
				ExtractAs = "Chance",
				Format = "Percent",
				DecimalPlaces = 2,
			},
			{
				Key = "PolymorphRoomCap",
				ExtractAs = "RoomCap",
			},
			{
				Key = "ReportedSandwichHealValue",
				ExtractAs = "SnackHealth",
				SkipAutoExtract = true,
				Format = "FlatHeal",
			},
			{		
				External = true,
				BaseName = "PolymorphTag",
				BaseType = "Effect",
				WeaponName = "WeaponSpellPolymorph",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "Duration",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	PolymorphCurseTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_70",
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
		OnEffectApplyFunction = 
		{
		
			FunctionName = "PolymorphCopyStatus",
			FunctionArgs = 
			{
				ValidStatusNames = 
				{
					DamageEchoEffect = true,
					BurnEffect = "ApplyBurn",
					ChillEffect = "ApplyRoot",
					LegacyChillEffect = true,
					AmplifyKnockbackEffect = true,
					WeakEffect = "ApplyAphroditeVulnerability",
					DamageShareEffect = "ApplyDamageShare",
					BlindEffect = true,
					DelayedKnockbackEffect = true,
				},
			}
		}
	},
	PolymorphTauntTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_66",
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.0,
			},
			Epic =
			{
				Multiplier = 1.0,
			},
			Heroic =
			{
				Multiplier = 1.0,
			},
		},

		PolymorphTauntChance = { BaseValue = 0.5 },
		ExtractValues =
		{
			{
				Key = "PolymorphTauntChance",
				ExtractAs = "Chance",
				Format = "Percent",
			},
			{		
				External = true,
				BaseName = "PolymorphTag",
				BaseType = "Effect",
				WeaponName = "WeaponSpellPolymorph",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "Duration",
			},
		}
	},
	PolymorphDurationTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_39",
		SpellModifier = true,
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1,
			},
			Heroic =
			{
				Multiplier = 1,
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellPolymorph",
				EffectName = "PolymorphTag",
				EffectProperty = "Duration",
				BaseValue = 2,
				ChangeType = "Add",
				ReportValues = { ReportedDuration = "ChangeValue" },
				DeriveSource = "DeriveSource",
			},
			{
				WeaponName = "WeaponSpellPolymorph",
				EffectName = "PolymorphDamageTaken",
				EffectProperty = "Duration",
				DeriveValueFrom = "DeriveSource"
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
			},
		}
	},
	-- Summon Talents --
	SummonDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_51",
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
			},
			Heroic =
			{
				Multiplier = 4,
			},
		},
		AllyDataModifiers = 
		{			
			AddOutgoingDamageModifiers =
			{
				{
					NonPlayerMultiplier = { BaseValue = 1.1, SourceIsMultiplier = true },
					ReportValues = { ReportedDamageBoost = "NonPlayerMultiplier"}
				},
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		}
	},

	SummonSpeedTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_93",
		AllyDataModifiers = 
		{
			SpeedMultiplier = { BaseValue = 1.5, SourceIsMultiplier = true },
			ReportValues = { ReportedSpeedMultiplier = "SpeedMultiplier"}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedSpeedMultiplier",
				ExtractAs = "Speed",
				Format = "PercentDelta"
			},
		}
	},
	
	SummonTurretTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_16",
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
			},
			Heroic =
			{
				Multiplier = 4,
			},
		},
		AllyDataModifiers = 
		{	
			AddOutgoingDamageModifiers =
			{
				{
					ValidSummons = { "SwarmerSummon" },
					NonPlayerMultiplier = { BaseValue = 1.0 },
					ReportValues = { ReportedDamageBoost = "NonPlayerMultiplier"}
				},
			},
			WeaponOptionsOverride = 
			{
					ValidSummons = { "SwarmerSummon" }, 
					WeaponNames = { "SpellSummonRanged" }
			},
		},
		EnemyPropertyChanges =
		{
			{
				LegalUnits = { "SwarmerSummon" },
				UnitProperty = "Speed",
				ChangeValue = 0,
				ChangeType = "Multiply",
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "RangedDamage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "SpellSummonRanged",
				BaseProperty = "Damage",
				ExtractAs = "RangedDamage",

			},
		}
	},
	
	SummonSelfDestructTalent = 
	{
	
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_17",
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

		AllyDataModifiers = 
		{	
			AddOutgoingDamageModifiers =
			{
				{
					ValidSummons = { "SummonSelfDestruct" },
					NonPlayerMultiplier = { BaseValue = 1.0 },
					ReportValues = { ReportedDamageBoost = "NonPlayerMultiplier"}
				},
			},
		},
		WeaponDataOverride =
		{
			WeaponSpellSummon =
			{
				FullChargeOverride = "SummonSelfDestruct",
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "RangedDamage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "SummonDeathWeapon",
				BaseProperty = "Damage",
				ExtractAs = "Damage",

			},
		}
	},

	SummonTeleportTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_94",

		SprintTeleportAllies = 
		{
			Count = 1,
			Delay = 0.2,
		},
	
		ExtractValues = 
		{
			{
				Key = "TeleportAlliesPostDash",
				ExtractAs = "Allies",
			},
		}
	},
	SummonRetaliateTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_92",		
	},
	SummonDamageSplitTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_90",
		
		AddIncomingDamageModifiers =
		{
			HasSummonMultiplier = 0.8,
			ReportValues = 
			{
				ReportedMultiplier = "HasSummonMultiplier"
			},
		},
		OnSelfDamagedFunction = 
		{
			Name = "SummonTakeDamage",
			FunctionArgs = 
			{
				-- We don't actually redirect the damage in the reduction stage, we extrapolate back out
				Multiplier = 0.25, -- Equal to  (1 - multiplier)/multiplier
			}
		},
		
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "SummonDefense",
				Format = "NegativePercentDelta",
			},
		}
	},
	SummonPermanenceTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_91",

		ExtractValues = 
		{
			{
				Key = "TeleportAlliesPostDash",
				ExtractAs = "Allies",
			},
		}
	},

	SummonSpecialTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_96",
	
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		},
		AddSummonWeaponsToTraits = 
		{
			Slot = "Secondary",
		},
		ManaSpendCostModifiers = 
		{
			Add = 10,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues = 
		{
			{
				ExtractAs = "SlotBoon",
				Slot = "Secondary",
				Format = "SlottedBoon"
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},

	SummonExplodeTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_95",
		OnSummonReplaceFunction = 
		{
			Name = "DetonateSummon",
			Args = 
			{
				ProjectileName = "SummonDeathWeapon",
				DamageMultiplier = 1,
				ReportValues = { ReportedDamageMultiplier = "DamageMultiplier" }
			},
		},
		ManaSpendCostModifiers = 
		{
			Add = 10,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "SummonDeathWeapon",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	-- Meteor
	MeteorSizeTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_53",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellMeteor",
				ProjectileProperty = "DamageRadius",
				BaseValue = 1.2,
				ChangeType = "Multiply",
				SourceIsMultiplier = true,
				ReportValues = { ReportedSizeChange = "ChangeValue" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSizeChange",
				ExtractAs = "SizeChange",
				Format = "PercentDelta",
				HideSigns = true,
			},
		}
	},
	MeteorDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_52",
		AddOutgoingDamageModifiers =
		{
			ValidBaseDamageAddition =
			{
				BaseValue = 100,
			},
			ValidWeapons = { "WeaponSpellMeteor" },
			ReportValues = { ReportedDamageBoost = "ValidBaseDamageAddition"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "Damage",
			},
		},
	},
	MeteorInvulnerableChargeTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_97",
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponSpellMeteor"},
			FunctionName = "MeteorCheckInvulnerability",
		},
	},
	MeteorVulnerabilityDecalTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_100",
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponSpellMeteor"},
			FunctionName = "MeteorStartVulnerability",
			FunctionArgs = 
			{
				EffectName = "MeteorVulnerabilityEffect",
				Modifier = 1.3,
				ReportValues = { ReportedValue = "Modifier" }
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedValue",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		},
	},
	MeteorSlowDecalTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_99",
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponSpellMeteor"},
			FunctionName = "MeteorStartVulnerability",
			FunctionArgs = 
			{
				EffectName = "MeteorSlowEffect",
				AdditionalEffect = "MeteorGripEffect",
				Modifier = 0.2,
				ReportValues = { ReportedValue = "Modifier" }
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedValue",
				ExtractAs = "Damage",
				Format = "PercentDelta",
				HideSigns = true,
			},
		},
	},
	MeteorShowerTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_98",
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponSpellMeteor"},
			FunctionName = "MeteorFirePreattack",
			FunctionArgs = 
			{
				ProjectileName = "ProjectileSpellMiniMeteor",
				Count = 3,
				Radius = 300,
				Interval = 0.5,
				DamageMultiplier = 1,
				ReportValues = 
				{ 
					ReportedDamageMultiplier = "DamageMultiplier", 
					ReportedCount = "Count", 
					ReportedInterval = "Interval",
				}
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ProjectileSpellMiniMeteor",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
				SkipAutoExtract = true
			},
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				DecimalPlaces = 1,
				SkipAutoExtract = true
			},
		},
	},
	MeteorDoubleTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_101",
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellMeteor",
				WeaponProperty = "NumProjectiles",
				ChangeValue = 2,
			},
			{
				WeaponName = "WeaponSpellMeteor",
				WeaponProperty = "ProjectileIntervalStart",
				ChangeValue = 2,
				ReportValues = { ReportedInterval = "ChangeValue"}
			},
			{
				WeaponName = "WeaponSpellMeteor",
				WeaponProperty = "ProjectileInterval",
				ChangeValue = 2,
			}
		},
		ManaSpendCostModifiers = 
		{
			Add = 50,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	MeteorExCastTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_102",
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "MeteorExCast",
			ValidProjectiles = {"ProjectileSpellMeteor"},
		},
	},
	-- Leap
	
	LeapCooldownSpeedTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_45",
		HexCooldownMoveSpeedBuff = 1.05,
		
		ExtractValues =
		{
			{
				Key = "HexCooldownMoveSpeedBuff",
				ExtractAs = "MoveSpeed",
				Format = "PercentDelta",
				HideSigns = true,
			},
		}
	},
	LeapDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_46",
		AddOutgoingDamageModifiers =
		{
			ValidBaseDamageAddition =
			{
				BaseValue = 50,
			},
			ValidWeapons = { "WeaponSpellLeap" },
			ReportValues = { ReportedDamageBoost = "ValidBaseDamageAddition"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "Damage",
			},
		},
	},
	LeapArmorDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_44",
		AddOutgoingDamageModifiers =
		{
			HealthBufferDamageMultiplier = 1.20,
			ValidWeapons = { "WeaponStaffDash" },
			ReportValues = { ReportedWeaponMultiplier = "HealthBufferDamageMultiplier"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
		},
	},
	LeapAoETalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_78",
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSpellLeap",
				ProjectileProperty = "DamageRadius",
				ChangeValue = 1.5,
				ChangeType = "Multiply",
				ReportValues = { ReportedAoEIncrease = "ChangeValue"},
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedAoEIncrease",
				ExtractAs = "AoE",
				Format = "PercentDelta",
				HideSigns = true,
			},
		},
	},
	LeapLaunchAoETalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_80",
		-- Checked with HasTrait

	},
	LeapShieldTalent = 
	{
		InheritFrom = { "SpellTalentTrait" },
		Icon = "Boon_Selene_81",
		LeapInvulnerability = 1,
		ExtractValues =
		{
			{
				Key = "LeapInvulnerability",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
			},
		}
	},
	LeapCritTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_79",
		LeapCritCount = 1,
		LeapCritVfx = "DaggerBlockActiveFx",
		AddOutgoingCritModifiers =
		{
			ValidLeapVolleyChance = 1,
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveLeapCritVolley",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			FunctionName = "CheckLeapCritCharges",
		},
		ExtractValues =
		{
			{
				Key = "LeapCritCount",
				ExtractAs = "CritCount",
			},
		}
	},
	LeapTwiceTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_83",
		SpellMultiuse = 1,
		MultiuseTimeout = 3,
		ManaSpendCostModifiers = 
		{
			Add = 15,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "MultiuseTimeout",
				ExtractAs = "Window",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	LeapSprintTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_82",
		
		OnEnemyDamagedAction = 
		{
			ValidWeapons = {"WeaponSpellLeap"},
			FunctionName = "ApplyLeapSprint",
			Args = 
			{
				MaximumCount = 5,
				ReportValues = { ReportedCount = "MaximumCount"},
			},
		},
		ManaSpendCostModifiers = 
		{
			Add = 10,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			},
			{
				ExtractAs = "SlotBoon",
				Slot = "Rush",
				Format = "SlottedBoon",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},

	-- Transform
	TransformDurationTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_57",
		TransformDurationIncrease = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "TransformDurationIncrease",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
			},
		},
	},
	TransformDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_56",
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.2,
				SourceIsMultiplier = true,
			},
			ValidWeapons = WeaponSets.HeroTransformWeapons,
			ReportValues = { ReportedDamageBoost = "ValidWeaponMultiplier"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		},
	},
	TransformBossDamageTalent  = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_54",
		AddOutgoingDamageModifiers =
		{
			BossDamageMultiplier =
			{
				BaseValue = 1.1,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedDamageBoost = "BossDamageMultiplier"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
		},
	},
	TransformCooldownDodgeTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_55",
		HexCooldownDodgeBuff = 0.01,
		
		ExtractValues =
		{
			{
				Key = "HexCooldownDodgeBuff",
				ExtractAs = "DodgeChance",
				Format = "Percent",
			},
		}
	},
	TransformCastDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_104",
		AddOutgoingDamageModifiers =
		{
			TransformedMultiplier = 1.3,
			ValidWeapons = WeaponSets.HeroRangedWeapons,
			ReportValues = { ReportedDamageBoost = "TransformedMultiplier"},
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "DamageBonus",
				Format = "PercentDelta",
			},
		}
	},
	TransformSpecialCritTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_106",
		
		AddOutgoingCritModifiers =
		{
			ValidWeapons = {"WeaponTransformSpecial"},
			DistanceThresholdChance = 1,
			DistanceThreshold = 430,
			ReportValues = { ReportedCritBonus = "DistanceThresholdChance"},
		},
		ExtractValues =
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritRate",
				Format = "Percent",
			},
		}
	},
	TransformAttackSpeedTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_103",

		TransformFunctionNames = 
		{
			StartTransformFunctionName = "AddTransformAttackSpeed",
			EndTransformFunctionName = "RemoveTransformAttackSpeed",
			Args = 
			{
				AttackSpeed = 1.20,
				ReportValues = { ReportedSpeed = "AttackSpeed" },
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeed",
				ExtractAs = "AttackSpeed",
				Format = "PercentDelta",
				HideSigns = true,
			},
		}
	},
	TransformLastStandRechargeTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_105",
		RechargeSpellOnLastStand = true,
		ExtractValues =
		{
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
	TransformPrimaryTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_108",
		AddWeaponsToTraits = 
		{
			WeaponName = "WeaponTransformAttack",
			Slot = "Melee",
		},
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		PropertyChanges = 
		{
			{
				TraitName = "ApolloWeaponBoon",
				WeaponName = "WeaponTransformAttack",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
		},
		ExtractValues = 
		{
			{
				ExtractAs = "SlotBoon",
				Slot = "Melee",
				Format = "SlottedBoon"
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	TransformSpecialTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_109",
		AddWeaponsToTraits = 
		{
			WeaponName = "WeaponTransformSpecial",
			Slot = "Secondary",
		},
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		PropertyChanges = 
		{
			{
				TraitName = "ApolloSpecialBoon",
				WeaponName = "WeaponTransformSpecial",
				WeaponProperty = "ProjectileScaleMultiplier",
				ChangeValue = 1.4,
				ChangeType = "Multiply",
			},
		},
		ExtractValues = 
		{
			{
				ExtractAs = "SlotBoon",
				Slot = "Secondary",
				Format = "SlottedBoon"
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
	},
	TransformExCastTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_107",
		TransformFunctionNames = 
		{
			StartTransformFunctionName = "DisableCastArm",
			EndTransformFunctionName = "EnableCastArm",
		},
		ManaSpendCostModifiers = 
		{
			Add = 30,
			ReportValues = { ReportedManaCost = "Add" }
		},
		StatLines =
		{
			"TalentManaCostAdditionStatline",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  WeaponSets.HeroNonPhysicalWeapons,
			FunctionName = "TransformArmCast",
			FunctionArgs = {},
		},
		
	},
}


OverwriteTableKeys( TraitData, TraitSetData.Talents )