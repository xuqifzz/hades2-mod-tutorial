TraitSetData.Talents =
{
	LegendaryTalent = 
	{
		DebugOnly = true,
		RarityLevels =
		{
			Legendary =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
		},
	},
	
	OlympianSpellCountTalent  =
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_132",
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
		OlympianSpellCountBossAddition = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "OlympianSpellCountBossAddition",
				ExtractAs = "Charge",
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
		MaxCount = 1,
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
			SpellUsedMultiplier=
			{
				BaseValue = 1.05,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedDamageBoost = "SpellUsedMultiplier"},
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
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckPotionClearCast",
			FunctionArgs = 
			{
				EffectName = "ClearCast",
				DataProperties = 
				{
					Duration = 5,
					ReportValues = { ClearCastDuration = "Duration" }
				},
			},
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
		Using =
		{
			"CirceCrystalRotateFront1", "CirceCrystalRotateFront2", "CirceCrystalRotateFront3", "CirceCrystalRotateFront4", "CirceCrystalRotateFront5",
			"CirceCrystalRotateBack1", "CirceCrystalRotateBack2", "CirceCrystalRotateBack3", "CirceCrystalRotateBack4", "CirceCrystalRotateBack5",
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
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HealingReductionNotice",
			},
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
	PotionExCastTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_121",
		CritChance = 100, -- used only for text
		ManaSpendCostModifiers = 
		{
			Add = 20,
			ReportValues = { ReportedManaCost = "Add" }
		},
		AddOutgoingCritModifiers = 
		{
			PotionCastCritChance = 1,
		},
		PotionExCast = true,
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
				ChangeValue = 1,
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
	
	PotionPoseidonTalent = 
	{
		InheritFrom = {"LegendaryTalent", "SpellTalentTrait"},
		Icon = "Boon_Selene_130",
		
		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "PoseidonUpgrade",
		SpeakerNames = { "Poseidon", },

		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "PoseidonUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForcePoseidonBoonKeepsake" },
					},
				},
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = {"WeaponSpellPotion" },
			FunctionName = "PotionPoseidonDrops",
			FunctionArgs = 
			{
				Duration = 10,
				EffectName = "PotionBuff",
				HealPerSecond = 4,
				ManaRegenPerSecond = 50,
				ReportValues = 
				{
					ReportedDuration = "Duration",
					ReportedHeal = "HealPerSecond",
					ReportedMana = "ManaRegenPerSecond",
				}
			},
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HealingReductionNotice",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
			},
			{
				Key = "ReportedHeal",
				ExtractAs = "Heal",
				Format = "FlatHeal",
			},
			{
				Key = "ReportedMana",
				ExtractAs = "Mana",
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
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HealingReductionNotice",
			},
		},
		ExtractValues =
		{
			{
				Key = "BonusSpellHeal",
				ExtractAs = "HealAmount",
				Format = "FlatHeal",
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
			HealthOnly = true,
			SpellUsedMultiplier=
			{
				BaseValue = 0.98,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedDefense = "SpellUsedMultiplier"},
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
			AddDuration = { BaseValue = 0.5 },
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
				Chance = 0.1,
				ReportValues = { ReportedChance = "Chance" }
			}
		},
		OnTimeSlowEndFunction = 
		{
			Name = "EndTimeSlowCrit",
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
				Key = "ReportedChance",
				ExtractAs = "CritBonus",
				Format = "LuckModifiedPercent",
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
		TimeSlowModifier = 0.25,
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

	TimeSlowDemeterTalent = 
	{
		InheritFrom = {"LegendaryTalent", "SpellTalentTrait"},
		Icon = "Boon_Selene_127",
	
		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "DemeterUpgrade",
		SpeakerNames = { "Demeter", },
		
		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "DemeterUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceDemeterBoonKeepsake" },
					},
				},
			},
		},
		OnTimeSlowStartFunction = 
		{
			Name = "StartTimeSlowFreeze",
			Args = 
			{
				EffectName = "DemeterTickEffect"
			}
		},
		OnTimeSlowEndFunction = 
		{
			Name = "EndTimeSlowFreeze",
			Args = 
			{
				EffectName = "DemeterTickEffect"
			}
		},
		OnEnemySpawnFunction =
		{
			FunctionName = "CheckSpawnFreeze",
			Args = 
			{
				EffectName = "DemeterTickEffect",
			}
		},
		OnEnemyDamagedAction = 
		{
			ValidEffectName = "DemeterTickEffect",
			EffectName = "LegacyChillEffect",
		},
		ExtractValues = 
		{
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "DemeterTickEffect",
				BaseProperty = "Amount",
				ExtractAs = "Damage",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "DemeterTickEffect",
				BaseProperty = "Cooldown",
				ExtractAs = "Interval",
				DecimalPlaces = 1,
			},
		}
	},

	-- Laser Talents --
	LaserCrystalTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_74",
		
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
					MaxAdjustRate = math.rad(40),
					AutoAdjustForTarget = true,
				},
			},
		},
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
			Add = 90,
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
	LaserStartAoETalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_119",
		LaserStartProjectile = "SpellLaserStartAoE",
		ExtractValues = 
		{
			{
				ExtractAs = "Damage",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "SpellLaserStartAoE",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Fuse",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "SpellLaserStartAoE",
				BaseProperty = "ImmunityDuration",
				DecimalPlaces = 2,
				SkipAutoExtract = true,
			},
		}
	},
	LaserFirstHitDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_120",
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = { "WeaponSpellLaser" },
			FirstHitBaseDamageAddition = 500,
			ReportValues = { ReportedAmage = "FirstHitBaseDamageAddition" }
		},
		
		SetupFunction = 
		{
			Name = "ResetFirstHitTalent",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedAmage",
				ExtractAs = "Damage",
			},
		}
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
		DefenseDuringLaser = { BaseValue = 10 },
		
		Invincible = true,
		CostumeTrait = true,
		IsRenewableArmor = true,

		ExtractValues = 
		{
			{
				Key = "DefenseDuringLaser",
				ExtractAs = "Defense",
				HideSigns = true,
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
	--
	LaserApolloTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_123",
		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "ApolloUpgrade",
		SpeakerNames = { "Apollo", },

		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "ApolloUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceApolloBoonKeepsake" },
					},
				},
			},
		},
		OnWeaponChargeFunctions =
		{
			ValidWeapons = { "WeaponSpellLaser" },
			FunctionName = "CheckFirstTimeLaserFire",
			FunctionArgs = 
			{
				AddOutgoingDamageModifiers =
				{
					Name = "ApolloLaser",
					ValidBaseDamageAddition = 50,
					ValidWeapons = { "WeaponSpellLaser" },
					ReportValues = { ReportedDamageBoost = "ValidBaseDamageAddition"},
				},
				PropertyChanges = 
				{
					{
						WeaponName = "WeaponSpellLaser",
						ProjectileProperty = "Range",
						ChangeValue = 200,
						ChangeType = "Add",
					},
					{
						WeaponName = "WeaponSpellLaser",
						ProjectileProperty = "Graphic",
						ChangeValue = "MoonLaserLoop_Apollo",
					},
					{
						WeaponName = "WeaponSpellLaser",
						ProjectileProperty = "DissipateFx",
						ChangeValue = "MoonLaserEnd_Apollo",
					},
					{
						WeaponName = "WeaponSpellLaser",
						ProjectileProperty = "ArcSize",
						ChangeValue = 75,
						ChangeType = "Add",
					},
				},
			}
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
	-- Polymorph Talents --
	PolymorphBossDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_67",
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
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "MorphDamageProjectile" },
			BossBaseDamageAddition = { BaseValue = 400 },
			ReportValues = { ReportedDamage = "BossBaseDamageAddition"}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamage",
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
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
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
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
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
		PolymorphDamageMultiplier = 1.1,	--For Circe ExPolymorphBoon
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
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
			},
		}
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
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
			},
		}
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
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"TalentManaCostAdditionStatline",
				"HealingReductionNotice",
			},
		},
		ExtractValues =
		{
			{
				Key = "PolymorphSandwichChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
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
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
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
		SetupFunction = 
		{
			Name = "BuildValidEffects",
			Args = 
			{
				StatusTraitNames = 
				{
					DamageEchoEffect = LinkedTraitData.ZeusEchoTraits,
					BurnEffect = LinkedTraitData.HestiaBurnTraits,
					ChillEffect = LinkedTraitData.DemeterRootTraits,
					LegacyChillEffect = { "DemeterSprintBoon", "CastNovaBoon", "StormSpawnBoon" },
					AmplifyKnockbackEffect = { "PoseidonStatusBoon", "PoseidonCastBoon" },
					WeakEffect = LinkedTraitData.AphroditeWeakTraits,
					DamageShareEffect = LinkedTraitData.HeraLinkTraits,
					BlindEffect = LinkedTraitData.ApolloBlindTraits,
					DelayedKnockbackEffect = { "MassiveKnockupBoon" },
				},
			}
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
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSpellPolymorph",
				ProjectileProperty = "NumJumps",
				ChangeValue = 10,
				ChangeType = "Add",
				ReportValues = { ReportedCount = "ChangeValue" },
			},
			{
				WeaponName = "WeaponSpellPolymorph",
				ProjectileProperty = "Fuse",
				ChangeValue = 2,
				ChangeType = "Add",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "JumpCount",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
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
		PolymorphDuration = 2,	--For Circe ExPolymorphBoon
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
	PolymorphZeusTalent = 
	{
		InheritFrom = {"LegendaryTalent", "SpellTalentTrait"},
		Icon = "Boon_Selene_124",
		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "ZeusUpgrade",
		SpeakerNames = { "Zeus", },

		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "ZeusUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceZeusBoonKeepsake" },
					},
				},
			},
		},
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = {"ProjectileSpellPolymorph"},
			Name = "ZeusStrikeNearProjectile",
			Args = 
			{
				ProjectileName = "ZeusPolymorphStrike",
				Range = 300,
				Targets = 2,
				Interval = 0.25,
				FollowUpDelay = 0.05,
				ReportValues = { ReportedInterval = "Interval" }
			},
		},
		
		PropertyChanges =
		{
			{
				WeaponName = "WeaponSpellPolymorph",
				ProjectileProperty = "JumpType",
				ChangeValue = "UNIT_PREFERENCE",
			},
			{
				WeaponName = "WeaponSpellPolymorph",
				ProjectileProperty = "AllowRepeatedJumpHit",
				ChangeValue = true,
			},
			{
				WeaponName = "WeaponSpellPolymorph",
				ProjectileProperty = "IgnoreProjectilesNeverJump",
				ChangeValue = true,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				DecimalPlaces = 1,
			},
			{
				ExtractAs = "Damage",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ZeusPolymorphStrike",
				BaseProperty = "Damage",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
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
			SpeedMultiplier = { BaseValue = 1.6, SourceIsMultiplier = true },
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

	SummonTeleportTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_94",
		
		OnWeaponFiredFunctions =
		{
			ValidWeapons = {"WeaponCast" },
			FunctionName = "SummonCastTeleport",
		},
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
			NotDamagingRetaliate = true,
			Name = "SummonTakeDamage",
			FunctionArgs = 
			{
				-- We don't actually redirect the damage in the reduction stage, we extrapolate back out
				Multiplier = 0.25, -- Equal to  (1 - multiplier)/multiplier
			}
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
				ExtractAs = "SummonDefense",
				Format = "NegativePercentDelta",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		}
	},
	SummonPermanenceTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent" },
		Icon = "Boon_Selene_91",

		ExtractValues = 
		{
		}
	},

	SummonExplodeTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_95",
		AllyDataModifiers = 
		{			
			AddOutgoingDamageModifiers =
			{
				{
					FirstSummonHitDamageAddition = 500,
					FirstSummonHitDamagePresentation = 
					{
						FunctionName = "FirstSummonHitPresentation",
						HitPresentationIgnoresOwnership = true,
						HitSimSlowParameters =
						{
							{ ScreenPreWait = 0.02, Fraction = 0.13, LerpTime = 0 },
							{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.05 },
						},
					},
					ReportValues = { ReportedBonus = "FirstSummonHitDamageAddition" }
				}
			}
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
				Key = "ReportedBonus",
				ExtractAs = "Damage",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		},
		Using = { "AresMissingDamageFx", },
	},
	
	SummonHeraTalent = 
	{
		InheritFrom = {"LegendaryTalent", "SpellTalentTrait"},
		Icon = "Boon_Selene_125",
		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "HeraUpgrade",
		SpeakerNames = { "Hera", },

		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "HeraUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceHeraBoonKeepsake" },
					},
				},
			},
		},
		AllyDataModifiers = 
		{
			FirstOnly = true,
			SpeedMultiplier = 1.25,
			ScaleMultiplier = 1.1,
			OutlineColor = Color.HeraDamage,
			CreateAnimation = "HeraSprintLoop",
			OutgoingCritModifiers =
			{
				{
					Chance = 0.3,
					ReportValues = { ReportedCritChance = "Chance" },
				},
			},
			ReportValues = { ReportedSpeedMultiplier = "SpeedMultiplier" },
		},
		
		ExtractValues = 
		{
			{
				Key = "ReportedCritChance",
				ExtractAs = "CritChance",
				Format = "LuckModifiedPercent",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedSpeedMultiplier",
				ExtractAs = "Speed",
				Format = "PercentDelta",
				SkipAutoExtract = true,
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
		Invincible = true,
		CostumeTrait = true,
		IsRenewableArmor = true,

		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponSpellMeteor"},
			FunctionName = "MeteorCheckInvulnerability",
			FunctionArgs = 
			{
				Armor = 50,
				ReportValues = { ReportedArmor = "Armor" }
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
				Key = "ReportedArmor",
				ExtractAs = "ReportedArmor"
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		}
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
	MeteorChargeTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_122",
		OnEnemyDamagedAction = 
		{
			ValidWeapons = {"WeaponSpellMeteor"},
			FunctionName = "CheckSpellForceCharge",
			Args = 
			{
				ManaCharge = 30,
				ReportValues = { ReportedCharge = "ManaCharge"}
			},	
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCharge",
				ExtractAs = "BossCharge",
			},
		}
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
	MeteorHestiaTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_126",
		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "HestiaUpgrade",
		SpeakerNames = { "Hestia", },

		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "HestiaUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceHestiaBoonKeepsake" },
					},
				},
			},
		},
		OnEnemySpawnFunction =
		{
			FunctionName = "StartReverseBurn",
			Args = 
			{
				StartStacks = 1200,
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponSpellMeteor"},
			FunctionName = "CheckBurnAll",
			FunctionArgs = 
			{
				EffectName = "BurnEffect",
				StartStacks = 1200,
			},
		},
		ExtractValues = 
		{
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
		}
	},
	-- Leap
	
	LeapCooldownSpeedTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_45",
		HexUsedMoveSpeedBuff = { BaseValue = 1.05, SourceIsMultiplier = true },
		
		ExtractValues =
		{
			{
				Key = "HexUsedMoveSpeedBuff",
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
			HealthBufferDamageMultiplier = { BaseValue = 1.2, SourceIsMultiplier = true },
			ValidWeapons = { "WeaponSpellLeap" },
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
		LeapArmor = 20,
		LeapArmorDuration = 3,
		Invincible = true,
		CostumeTrait = true,
		IsRenewableArmor = true,

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
				Key = "LeapArmor",
				ExtractAs = "Armor",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
			{
				Key = "LeapArmorDuration",
				ExtractAs = "Duration",
				DecimalPlaces = 1,
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
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
		},
	},
	LeapHephaestusTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_129",
		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "HephaestusUpgrade",
		SpeakerNames = { "Hephaestus", },
		
		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "HephaestusUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceHephaestusBoonKeepsake" },
					},
				},
			},
		},
		SpellLeapModifiers = 
		{
			ProjectileName = "HephLeapBlast",
			ProjectileStartDelay = 0.5,
			StartFx = "HephMassiveHitHammerTalent",
			StartFxDelay = 0.8,
		},
		ExtractValues =
		{
			{
				ExtractAs = "Damage",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "HephLeapBlast",
				BaseProperty = "Damage",
			},
		},
	},

	-- Transform
	TransformDurationTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_57",
		TransformDurationIncrease = { BaseValue = 0.5 },
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
	TransformCooldownDodgeTalent = 
	{
		InheritFrom = {"SpellTalentTrait"},
		Icon = "Boon_Selene_55",
		HexUsedDodgeBuff = { BaseValue = 0.01 },
		
		ExtractValues =
		{
			{
				Key = "HexUsedDodgeBuff",
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
			ValidProjectiles = WeaponSets.CastProjectileNames,
			WeaponOrProjectileRequirement = true,
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
				Key = "ReportedCritBonus",
				ExtractAs = "CritRate",
				Format = "Percent",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
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
				AttackSpeed = 1.25,
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
		PropertyChanges = 
		{
			StartTransformFunctionName = "TransformCheckApolloBoon",
			Args = 
			{
				TraitName = "ApolloSpecialBoon",
				WeaponName = "WeaponTransformSpecial",
				ProjectileProperty = "ProjectileScaleMultiplier",
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
		},
	},
	TransformExCastTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_62",
		TransformFunctionNames = 
		{
			StartTransformFunctionName = "DisableCastArm",
			EndTransformFunctionName = "EnableCastArm",
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
	TransformAphroditeTalent = 
	{
		InheritFrom = {"LegendaryTalent", "SpellTalentTrait"},
		Icon = "Boon_Selene_128",
		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "AphroditeUpgrade",
		SpeakerNames = { "Aphrodite", },

		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "AphroditeUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceAphroditeBoonKeepsake" },
					},
				},
			},
		},
		TransformFunctionNames = 
		{
			StartTransformFunctionName = "StartTransformBurst",
			EndTransformFunctionName = "EndTransformBurst",
		},
		OnProjectileDeathFunction = 
		{
			Name = "TransformRespawnBurst",
			ValidProjectiles = {"AphroditeBurst"},
			Args = 
			{
				Delay = 0.15,
				ProjectileName = "AphroditeBurst",
				DamageMultiplier = 1.0,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
				}
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "AphroditeBurst",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "AphroditeBurst",
				BaseProperty = "Fuse",
			},
		}
	},
	-- Moon Beam

	MoonBeamTalentTrait =
	{
		CodexGameStateRequirements =
		{
			NamedRequirements = { "SuitAspectsRevealed" },
		},
		DebugOnly = true,
	},

	MoonBeamVulnerabilityTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait"},
		Icon = "Boon_Selene_113",
		MoonBeamVulnerabilityBonus = {BaseValue = 0.05},
		ExtractValues = 
		{
			{
				Key = "MoonBeamVulnerabilityBonus",
				ExtractAs = "ReportedMoonBeamVulnerabilityBonus",
				Format = "Percent",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "MoonBeamVulnerability",
				BaseProperty = "Modifier",
				Format = "PercentDelta",
				ExtractAs = "MoonBeamVulnerability",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "MoonBeamVulnerability",
				BaseProperty = "Duration",
				ExtractAs = "MoonBeamDuration",
				SkipAutoExtract = true,
			},
		},
	},
	MoonBeamDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait"},
		Icon = "Boon_Selene_112",

		AddOutgoingDamageModifiers =
		{
			ValidBaseDamageAddition =
			{
				BaseValue = 10,
			},
			ValidWeapons = { "WeaponSpellMoonBeam" },
			ReportValues = { ReportedMoonBeamDamageBoost = "ValidBaseDamageAddition"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMoonBeamDamageBoost",
				ExtractAs = "DamageBoost",
			},
		}
	},
	MoonBeamCountTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait"},
		Icon = "Boon_Selene_111",
		MoonBeamCountBonus = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "MoonBeamCountBonus",
				ExtractAs = "MoonBeamBonus",
			},
		}
	},
	MoonBeamDefenseTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait"},
		Icon = "Boon_Selene_115",
		AddIncomingDamageModifiers = 
		{ 
			MoonBeamActiveMultiplier = 0.8,
			HealthOnly = true,
			ReportValues = { ReportedDefense = "MoonBeamActiveMultiplier"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDefense",
				ExtractAs = "DefenseBonus",
				Format = "NegativePercentDelta",
			},
		}
	},
	MoonBeamTargetTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait"},
		Icon = "Boon_Selene_116",
		MoonBeamTargetCountBonus = 2,
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
				Key = "MoonBeamTargetCountBonus",
				ExtractAs = "MoonBeamTargetCountBonus",
			},
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaAddition",
				SkipAutoExtract = true,
				IncludeSigns = true,
			},
		}
	},
	MoonBeamPrimaryTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait"},
		Icon = "Boon_Selene_118",
		AddOutgoingDamageModifiers = 
		{
			BossDamageMultiplier = 1.3,
			ReportValues = { ReportedDamageMultiplier = "BossDamageMultiplier"}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageMultiplier",
				ExtractAs = "DamageBonus",
				Format = "PercentDelta"
			},
		}
	},
	MoonBeamConsecutiveDamageTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait"},
		Icon = "Boon_Selene_114",
		OnEnemyDamagedAction = 
		{
			ValidWeapons = {"WeaponSpellMoonBeam"},
			FunctionName = "CheckMoonBeamConsecutiveDamage",
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = {"WeaponSpellMoonBeam"},
			ConsecutivePercentDamage = 0.5,
			ReportValues = { ReportedBonus = "ConsecutivePercentDamage" }
		},
		ExtractValues = 
		{
			{
				Key = "ReportedBonus",
				ExtractAs = "ConsecutiveHitBonus",
				Format = "Percent",
			},
		}
	},
	MoonBeamExBeamBonusTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait"},
		Icon = "Boon_Selene_117",
		
		OnWeaponFiredFunctions =
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CheckAutoMoonBeam",
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
		}
	},
	MoonBeamAresTalent = 
	{
		InheritFrom = {"SpellTalentTrait", "MoonBeamTalentTrait", "LegendaryTalent"},
		Icon = "Boon_Selene_131",

		IsDuoBoon = true,
		Frame = "Duo",
		LinkedGod = "AresUpgrade",
		SpeakerNames = { "Ares", },

		GameStateRequirements = 
		{
			NamedRequirements = { "SeleneDuosUnlocked" },
			OrRequirements =
			{
				{
					{
						PathTrue = { "CurrentRun", "Hero", "MetGods", "AresUpgrade" },
					},
				},
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceAresBoonKeepsake" },
					},
				},
			},
		},
		ReplaceMoonBeam = 
		{
			ProjectileName = "ProjectileBloodMoonBeam"
		},
		AddOutgoingDamageModifiers =
		{
			ValidBaseDamageAddition = EffectData.AresStatus.BonusBaseDamageOnInflict,
			ValidProjectiles = { "ProjectileBloodMoonBeam" },
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = {"ProjectileBloodMoonBeam"},
			FunctionName = "SpellBloodMoonBeamHitPresentation",
			Args = 
			{
				EffectName = "AresStatus",
				HitSimSlowParameters =
				{
					{ ScreenPreWait = 0.02, Fraction = 0.13, LerpTime = 0 },
					{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.05 },
				},
			},	

		},
		
		ExtractValues =
		{
			{
				ExtractAs = "AresCurseDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "AresStatus",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "AresCursePowerBonus",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "AresStatus",
				BaseProperty = "BonusBaseDamageOnInflict",
			},
		},
	},
}


OverwriteTableKeys( TraitData, TraitSetData.Talents )