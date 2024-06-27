
TraitSetData.Chaos =
{

	ChaosCurse =
	{
		Icon = "Shop_Vial",
	},

	ChaosCurseRemainingEncounters =
	{
		RemainingUses =
		{
			BaseMin = 3,
			BaseMax = 5,
			AsInt = true,
		},
		UsesAsEncounters = true,
	},

	ChaosBlessing =
	{
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
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Heroic = 
			{
				MinMultiplier = 2.5,
				MaxMultiplier = 2.5,
			},
		},
	},

	ChaosLegacyTrait =
	{
		GameStateRequirements =
		{
			NamedRequirements = { "ChaosLegacyTraitsAvailable" },
		},
	},
	
	ChaosWeaponBlessing =
	{
		InheritFrom = { "ChaosBlessing", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_44",
		CustomName = "ChaosWeaponBlessing_Complete",
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier = { BaseMin = 1.2, BaseMax = 1.5, SourceIsMultiplier = true },
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier"}
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		}
	},
	ChaosSpecialBlessing =
	{
		InheritFrom = { "ChaosBlessing", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_45",
		CustomName = "ChaosSpecialBlessing_Complete",
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier = { BaseMin = 1.3, BaseMax = 1.6, SourceIsMultiplier = true },
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier"}
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		}
	},

	ChaosCastBlessing = 
	{
		InheritFrom = { "ChaosBlessing" },
		Icon = "Boon_Chaos_46",
		CustomName = "ChaosCastBlessing_Complete",
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier = { BaseMin = 1.2, BaseMax = 1.5, SourceIsMultiplier = true },
			ValidWeapons = WeaponSets.HeroRangedWeapons,
			ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier"}
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		}
	},
	
	ChaosHealthBlessing =
	{
		InheritFrom = { "ChaosBlessing", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_47",
		CustomName = "ChaosHealthBlessing_Complete",

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
			}
		},

		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseMin = 26,
				BaseMax = 35,
				ChangeType = "Add",
				ReportValues = { ReportedHealth = "ChangeValue"}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedHealth",
				Format = "MaxHealthIgnoreCap",
				ExtractAs = "TooltipHealth",
			},
		}
	},
	
	ChaosRarityBlessing =
	{
		InheritFrom = { "ChaosBlessing", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_48",
		CustomName = "ChaosRarityBlessing_Complete",

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
				Multiplier = 2.0,
			}
		},

		RarityBonus =
		{
			Rare =
			{
				BaseMin = 0.40,
				BaseMax = 0.50,
			},
			Epic = 0.1,
			Legendary = 0.1,
			ReportValues = { ReportedRarity = "Rare"}
		},
		ExtractValues =
		{
			{
				Key = "ReportedRarity",
				ExtractAs = "TooltipBonusChance",
				Format = "Percent",
			}
		}
	},
	
	ChaosMoneyBlessing =
	{
		InheritFrom = { "ChaosBlessing", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_49",
		CustomName = "ChaosMoneyBlessing_Complete",
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
			}
		},
		MoneyMultiplier =
		{
			BaseMin = 1.4,
			BaseMax = 1.6,
			ToNearest = 0.05,
			SourceIsMultiplier = true,
		},
		ExtractValues =
		{
			{
				Key = "MoneyMultiplier",
				ExtractAs = "TooltipMoneyRewardIncrease",
				Format = "PercentDelta",
			},
		}
	},
	
	ChaosLastStandBlessing =
	{
		InheritFrom = { "ChaosBlessingTrait", "ChaosLegacyTrait" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = 
				{ 
					"ChaosWeaponBlessing", "ChaosSpecialBlessing", "ChaosCastBlessing", "ChaosHealthBlessing", 
					"ChaosRarityBlessing", "ChaosMoneyBlessing", "ChaosLastStandBlessing", "ChaosManaBlessing", 
					"ChaosManaOverTimeBlessing", "ChaosExSpeedBlessing", "ChaosElementalBlessing", "ChaosManaCostBlessing",
					"ChaosSpeedBlessing", "ChaosDoorHealBlessing", "ChaosHarvestBlessing",
					"ChaosOmegaDamageBlessing"
				},
			},
		},
		ChanceToPlay = 0.1,
		RarityLevels =
		{
			Legendary =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
		},
		Icon = "Boon_Chaos_59",
		CustomName = "ChaosLastStandBlessing_Complete",
		AddLastStand =
		{
			Icon = "ExtraLifeChaos",
			HealFraction = 0.4,
			ManaFraction = 0.4,
			IncreaseMax = true,
		},
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
	
	ChaosManaBlessing =
	{
		InheritFrom = { "ChaosBlessing" },
		Icon = "Boon_Chaos_50",
		CustomName = "ChaosManaBlessing_Complete",
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				BaseMin = 30,
				BaseMax = 40,
				ChangeType = "Add",
				AsInt = true,
				ReportValues = { ReportedMana = "ChangeValue"}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedMana",
				ExtractAs = "TooltipMana",
			},
		}
	},
	
	ChaosManaOverTimeBlessing = 
	{
		InheritFrom = {"ChaosBlessing", "ManaOverTimeSource"},
		Icon = "Boon_Chaos_51",
		CustomName = "ChaosManaOverTimeBlessing_Complete",
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
			}
		},
		AcquireFunctionName = "SetManaRegenUnique",
		SetupFunction =
		{
			Name = "ManaRegenSetup",
			Args =
			{
				Name = "ChaosManaOverTimeBlessing",
				ManaRegenPerSecond = { BaseMin = 4, BaseMax = 6, ToNearest = 0.5 },
				ReportValues = { ReportedManaRecovery = "ManaRegenPerSecond" }
			},
			RunOnce = true
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

	ChaosExSpeedBlessing = 
	{
		InheritFrom = { "ChaosBlessing" },
		Icon = "Boon_Chaos_52",
		CustomName = "ChaosExSpeedBlessing_Complete",

		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
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

		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponLobSpecial", "WeaponCastArm", "WeaponStaffBall", "WeaponStaffSwing5", "WeaponDaggerThrow", "WeaponDagger5" },
				BaseMin = 0.85,
				BaseMax = 0.90,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			}
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponTorch", "WeaponTorchSpecial", "WeaponLob", "WeaponLobSpecial", "WeaponAxeBlock2", "WeaponAxeSpin", "WeaponCastArm", "WeaponStaffBall", "WeaponStaffSwing5", "WeaponDaggerThrow", "WeaponDagger5" },
			Value = 
			{
				BaseMin = 0.85,
				BaseMax = 0.90,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipSpeed",
				Format = "NegativePercentDelta"
			},
		}
	},
	
	ChaosElementalBlessing = 
	{
		InheritFrom = { "ChaosBlessing" },
		
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1,
				MaxMultiplier = 1,
			},
			Rare =
			{
				MinMultiplier = 2,
				MaxMultiplier = 2,
			},
			Epic =
			{
				MinMultiplier = 3,
				MaxMultiplier = 3,
			},
			Heroic = 
			{
				MinMultiplier = 4,
				MaxMultiplier = 4,
			},
		},
		Elements = {},
		Icon = "Boon_Chaos_53",
		AddAllElements = {BaseValue = 1},
		CustomName = "ChaosElementalBlessing_Complete",
		ExtractValues =
		{
			{
				Key = "AddAllElements",
				ExtractAs = "ElementCount",
			},
		}
	},

	ChaosManaCostBlessing = 
	{
		InheritFrom = { "ChaosBlessing" },
		Icon = "Boon_Chaos_54",
		CustomName = "ChaosManaCostBlessing_Complete",
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
			}
		},
		
		ManaCostModifiers = 
		{
			ManaCostMultiplier = { BaseMin = 0.7, BaseMax = 0.8, ToNearest = 0.05, SourceIsMultiplier = true },
			ReportValues = { ReportedManaCost = "ManaCostMultiplier" }
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaCost",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		}
	},
	
	ChaosSpeedBlessing =
	{
		InheritFrom = { "ChaosBlessing" },
		Icon = "Boon_Chaos_55",
		CustomName = "ChaosSpeedBlessing_Complete",

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
			},
		},

		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocity",
				BaseValue = 297,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				BaseValue = 133.5,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "ChaosControl",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
			{
				UnitProperty = "Speed",
				ChangeType = "Multiply",
				BaseValue = 1.15,
				SourceIsMultiplier = true,
				ReportValues = { ReportedBaseSpeed = "ChangeValue" },
			},
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "TooltipSpeed",
				Format = "PercentDelta",
			},
		}
	},

	ChaosDoorHealBlessing =
	{
		InheritFrom = { "ChaosBlessing" },
		Icon = "Boon_Chaos_56",
		CustomName = "ChaosDoorHealBlessing_Complete",
		DoorHealFixed = { BaseMin = 3, BaseMax = 4, AsInt = true },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 3,
			},
			Epic = 
			{
				Multiplier = 5,
			},
			Heroic = 
			{
				Multiplier = 7,
			}
		},
		ExtractValues =
		{
			{
				Key = "DoorHealFixed",
				ExtractAs = "TooltipHeal",
			},
		}
	},
	ChaosHarvestBlessing =
	{
		InheritFrom = { "ChaosBlessing" },
		Icon = "Boon_Chaos_57",
		CustomName = "ChaosHarvestBlessing_Complete",
		DoubleToolRewardChance = { BaseMin = 0.40, BaseMax = 0.50, MaximumValue = 1},
		DoubleRewardValue = 100, -- used for text
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.4,
			},
			Rare =
			{
				Multiplier = 1.6,
			},
			Epic = 
			{
				Multiplier = 1.8,
			},
			Heroic = 
			{
				Multiplier = 2.0,
			}
		},
		ExtractValues =
		{
			{
				Key = "DoubleToolRewardChance",
				ExtractAs = "TooltipBonus",
				Format = "Percent",
			},
		}
	},
	ChaosOmegaDamageBlessing =
	{
		InheritFrom = {"UnityTrait", "ChaosBlessing" },
		Icon = "Boon_Chaos_58",
		CustomName = "ChaosOmegaDamageBlessing_Complete",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Aether" },
				Comparison = ">=",
				Value = 1,
			},
		},
		ElementalMultipliers = 
		{
			Aether = true,
		},		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.2
			},
			Epic = 
			{
				Multiplier = 1.4,
			},
			Heroic = 
			{
				Multiplier = 1.6,
			}
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			ExMultiplier =
			{
				BaseValue = 1.3,
				MultipliedByElement = "Aether",
				SourceIsMultiplier = true,
			},
			ReportValues = 
			{ 
				ReportedTotalDamageChange = "ExMultiplier",
			}
		},
		-- Display variable only! Match this with the above valid weapon multiplier!
		ReportedDamageChange = 
		{ 
			BaseValue = 1.3, 
			SourceIsMultiplier = true,
		},
		TrayStatLines = 
		{
			"ChaosTotalExDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedTotalDamageChange",
				ExtractAs = "TooltipTotalDamageBonus",
				SkipAutoExtract = true,
				Format = "PercentDelta",
			},
			{
				Key = "ReportedDamageChange",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		},
	},
	-- Curses
	ChaosNoMoneyCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_28",
		BlockMoney = true,
	},
	ChaosHealthCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_27",
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseMin = -29,
				BaseMax = -20,
				MaintainDelta = true,
				ChangeType = "Add",
				AsInt = true,
				ReportValues = 
				{
					ReportedHealth = "ChangeValue"
				},
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedHealth",
				Format = "MaxHealth",
				ExtractAs = "TooltipHealthCurse",
				SkipAutoExtract = true,
			},
		}
	},
	ChaosHiddenRoomRewardCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_29",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "F" },
			},
			{
				PathFalse = { "CurrentRun", "BiomesReached", "I" },
			},
		},
		HiddenRoomReward = true,
		UsesAsRooms = true,
		RemainingUses =
		{
			BaseMin = 4,
			BaseMax = 6,
			AsInt = true,
		}
	},
	ChaosDamageCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_30",
		AddIncomingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseMin = 1.2,
				BaseMax = 1.5,
				SourceIsMultiplier = true,
				
			},
			ReportValues = 
			{
				ReportedMultiplier = "ValidWeaponMultiplier"
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamageCurse",
				Format = "PercentDelta",
			},
		}
	},
	ChaosPrimaryAttackCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_31",
		DamageOnFireWeapons =
		{
			WeaponNames = WeaponSets.HeroPrimaryWeapons,
			Damage =
			{
				BaseMin = 3,
				BaseMax = 6,
				AsInt = true,
			},
			ReportValues = 
			{
				ReportedDamage = "Damage"
			},
		},
			ExtractValues =
			{
				{
					Key = "ReportedDamage",
					ExtractAs = "TooltipDamage",
				},
			}
	},

	ChaosSecondaryAttackCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_32",
		DamageOnFireWeapons =
		{
			WeaponNames = WeaponSets.HeroSecondaryWeapons,
			ExcludeLinked = true,
			Damage =
			{
				BaseMin = 3,
				BaseMax = 6,
				AsInt = true,
			},
			ReportValues = 
			{
				ReportedDamage = "Damage"
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipDamage",
			},
		}
	},

	ChaosDeathWeaponCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters", "ChaosLegacyTrait" },
		Icon = "Boon_Chaos_33",
		AddEnemyOnDeathProjectile =
		{
			EnemyBombs = true,
		},
	},

	ChaosSpeedCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters" },
		RelativeSprintModifier = true,
		Icon = "Boon_Chaos_34",
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocity",
				ChangeValue = 0.9,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				ChangeValue = 0.8,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				TraitName = "ApolloSprintBoon",
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocity",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				TraitName = "ApolloSprintBoon",
	
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				ChangeValue = 0.5,
				ChangeType = "Multiply",
				ExcludeLinked = true,
			},
			{
				UnitProperty = "Speed",
				ChangeType = "Multiply",
				BaseMin = 0.40,
				BaseMax = 0.60,
				SourceIsMultiplier = true,
				ReportValues = { ReportedBaseSpeed = "ChangeValue" },
			},
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "TooltipSpeed",
				Format = "NegativePercentDelta",
			},
		}
	},

	ChaosExAttackCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters" },
		Icon = "Boon_Chaos_35",
		DamageOnFireWeapons =
		{
			WeaponNames = WeaponSets.HeroAllWeapons,
			IsEx = true,
			Damage =
			{
				BaseMin = 5,
				BaseMax = 8,
				AsInt = true,
			},
			ReportValues = 
			{
				ReportedDamage = "Damage"
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipDamage",
			},
		}
	},

	ChaosCommonCurse = 
	{
		InheritFrom = { "ChaosCurse" },
		Icon = "Boon_Chaos_36",
		RemainingUses = { BaseMin = 2, BaseMax = 3, AsInt = true },
		ForceCommon = true,
		ExtractValues =
		{
			{
				Key = "RemainingUses",
				ExtractAs = "ReportedUses",
			},
		}
	},

	ChaosCastCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters" },
		Icon = "Boon_Chaos_37",
		DamageOnFireWeapons =
		{
			WeaponNames = WeaponSets.HeroRangedWeapons,
			ExcludeLinked = true,
			Damage =
			{
				BaseMin = 3,
				BaseMax = 6,
				AsInt = true,
			},
			ReportValues = 
			{
				ReportedDamage = "Damage"
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipDamage",
			},
		}
	},
	ChaosDashCurse =
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters" },
		Icon = "Boon_Chaos_38",
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  {"WeaponBlink"},
			ExcludeLinked = true,
			FunctionName = "ChaosManaDrain",
			FunctionArgs =
			{
				Cost = { BaseMin = 3, BaseMax = 6, AsInt = true},
				ReportValues = 
				{
					ReportedDrain = "Cost"
				},
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDrain",
				ExtractAs = "TooltipDrain",
			},
		}
	},

	ChaosManaFocusCurse = 
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters" },
		Icon = "Boon_Chaos_39",
	},

	ChaosRestrictBoonCurse = 
	{
		InheritFrom = { "ChaosCurse", },
		Icon = "Boon_Chaos_40",
		RemainingUses = { BaseMin = 2, BaseMax = 4, AsInt = true },
		RestrictBoonChoices = true,
		ExtractValues =
		{
			{
				Key = "RemainingUses",
				ExtractAs = "ReportedUses",
			},
		}
	},

	ChaosStunCurse = 
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters" },
		Icon = "Boon_Chaos_41",
		
		OnSelfDamagedFunction = 
		{
			Name = "ChaosStunSelf",
			FunctionArgs = 
			{
				EffectName = "ChaosStun",
				Cooldown = 1.5,
				DataProperties = 
				{
					Duration = { BaseMin = 0.5, BaseMax = 1.4 },
					ReportValues = { ReportedDuration= "Duration" },
				}
			}
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
	ChaosTimeCurse = 
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters" },
		Icon = "Boon_Chaos_42",
		RemainingUses = { BaseMin = 2, BaseMax = 3, AsInt = true },
		StartingTime = 120,
		Damage = 500,
		AcquireFunctionName = "StartChaosTimer",
		ExtractValues =
		{
			{
				Key = "StartingTime",
				ExtractAs = "Duration",
			},
			{
				Key = "Damage",
				ExtractAs = "Damage",
			},
		}
	},
	
	ChaosMetaUpgradeCurse = 
	{
		InheritFrom = { "ChaosCurse", "ChaosCurseRemainingEncounters" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = 
				{ 
					"ChaosWeaponBlessing", "ChaosSpecialBlessing", "ChaosCastBlessing", "ChaosHealthBlessing", 
					"ChaosRarityBlessing", "ChaosMoneyBlessing", "ChaosLastStandBlessing", "ChaosManaBlessing", 
					"ChaosManaOverTimeBlessing", "ChaosExSpeedBlessing", "ChaosElementalBlessing", "ChaosManaCostBlessing",
					"ChaosSpeedBlessing", "ChaosDoorHealBlessing", "ChaosHarvestBlessing",
					"ChaosOmegaDamageBlessing"
				},
			},
		},
		ChanceToPlay = 0.1,
		UpgradePairedRarity = true,
		Icon = "Boon_Chaos_43",
		AcquireFunctionName = "RemoveArcana",
		RemainingUses =
		{
			BaseMin = 7,
			BaseMax = 11,
			AsInt = true,
		},
		OnExpire = 
		{
			AddMetaUpgrades = true
		}
	}
}


OverwriteTableKeys( TraitData, TraitSetData.Chaos )