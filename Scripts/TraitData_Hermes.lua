OverwriteTableKeys( TraitData, {
	-- Hermes
	HermesWeaponBoon =
	{
		Icon = "Boon_Hermes_27",
		InheritFrom = { "BaseTrait", "LegacyTrait", "EarthBoon" },
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
		PropertyChanges = {
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				WeaponProperty = "FireFx2",
				ChangeValue = "HermesSwipeLineC_Sword3",
				ChangeType = "Absolute",
			},
			{
				WeaponNames = WeaponSets.HeroPrimaryWeapons,
				BaseValue = 0.9,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			}
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroPrimaryWeapons,
			Value = 
			{
				BaseValue = 0.9,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		
		AllyDataModifiers = 
		{
			SpeedMultiplier = { BaseValue = 1.10, SourceIsMultiplier = true },
		},
		StatLines =
		{
			"AttackSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "NegativePercentDelta",
			},
		}
	},
	HermesSpecialBoon =
	{
		Icon = "Boon_Hermes_30",
		InheritFrom = { "BaseTrait", "LegacyTrait", "EarthBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.5,
			},
			Rare =
			{
				Multiplier = 1.8,
			},
			Epic =
			{
				Multiplier = 2.1,
			},
			Heroic =
			{
				Multiplier = 2.4,
			},
		},
		PropertyChanges = {
			{
				WeaponNames = WeaponSets.HeroSecondaryWeapons,
				WeaponProperty = "FireFx2",
				ChangeValue = "HermesSwipeLineC_Sword3",
				ChangeType = "Absolute",
			},
			{
				WeaponNames = WeaponSets.HeroSecondaryWeapons,
				BaseValue = 0.9,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			}
		},
		
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroSecondaryWeapons,
			Value = 
			{
				BaseValue = 0.9,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		StatLines =
		{
			"SpecialSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "NegativePercentDelta",
			},
		}
	},
	HexCooldownBuffBoon = 
	{
		InheritFrom = {"AirBoon"},
		Icon = "Boon_Hermes_32",
		HexCooldownSpeedBuff = { BaseValue = 0.85, SourceIsMultiplier = true },
		RequiredSlottedTrait = "Spell",
		RequiredFalseTraits = { "SpellPotionTrait" },
		
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
			},
		},
		StatLines =
		{
			"HexCooldownBuffBoonDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "HexCooldownSpeedBuff",
				ExtractAs = "TooltipSpeedBonus",
				Format = "NegativePercentDelta",
			},
		}
	},
	SlowProjectileBoon = 
	{
		InheritFrom = { "AirBoon" },
		Icon = "Boon_Hermes_34",
		
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
				Multiplier = 6/3,
			}
		},	
		EnemyProjectileSpeedMultiplier = { BaseValue = 0.7, SourceIsMultiplier = true },
		
		StatLines =
		{
			"SlowProjectileStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "EnemyProjectileSpeedMultiplier",
				ExtractAs = "TooltipDodgeBonus",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		}
	},
	MoneyMultiplierBoon = 
	{
		InheritFrom = { "AirBoon" },
		Icon = "Boon_Hermes_33",
		CustomTrayText = "MoneyMultiplierBoon_Tray",
		MoneyMultiplier = { BaseValue = 1.2, SourceIsMultiplier = true },
		
		GameStateRequirements = 
		{					
			{
				Path = { "CurrentRun", "CurrentRoom" },
				HasNone = { "BlockGiftBoons" },
			},
		},
		AcquireFunctionName = "GiveRandomConsumables",
		AcquireFunctionArgs =
		{ 
			Delay = 0.2,
			NotRequiredPickup = true,
			ForceToValidLocation = true,
			LootOptions =
			{
				{
					Name = "RoomMoneyDrop",
				},
			}
		},
		StatLines =
		{
			"MoneyMultiplierStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "MoneyMultiplier",
				ExtractAs = "TooltipCashBonus",
				Format = "PercentDelta",
			},
		}
	},
	DodgeChanceBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "AirBoon" },
		Icon = "Boon_Hermes_37",
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
		PropertyChanges =
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.10,
				ChangeType = "Add",
				DataValue = false,
				ReportValues = { ReportedDodgeChance = "ChangeValue"},
			},
		},
		
		StatLines =
		{
			"DodgeChanceStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedDodgeChance",
					ExtractAs = "TooltipDodgeBonus",
					Format = "Percent",
			},
		}
	},
	BonusDashBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "AirBoon" },
		BlockStacking = true,
		Icon = "Boon_Hermes_01",
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
			}
		},		
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroBlinkWeapons,
				WeaponProperty = "ClipSize",
				BaseValue = 1,
				ChangeType = "Add",
				ReportValues = { ReportedBonusSprint = "ChangeValue"},
			},
		},
		
		StatLines =
		{
			"BonusDashStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedBonusSprint",
					ExtractAs = "TooltipSprintBonus",
			},
		}
	},
	HermesCastDiscountBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hermes_31",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.20,
			},
			Epic =
			{
				Multiplier = 1.40,
			},
			Heroic =
			{
				Multiplier = 1.60,
			}
		},
		--[[
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponCastProjectile", "WeaponCast" },
				WeaponProperty = "ActiveProjectileCap",
				ChangeValue = 2,
				ChangeType = "Add",
				ReportValues = { ReportedBonus = "ChangeValue" },
			},
		},
		]]
		ManaCostModifiers = 
		{
			WeaponNames = WeaponSets.HeroRangedWeapons,
			ManaCostMultiplier = { BaseValue = 0.5, SourceIsMultiplier = true } ,
			ReportValues = { ReportedManaCost = "ManaCostMultiplier" },
		},
		StatLines =
		{
			"CastManaReductionStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedManaCost",
				ExtractAs = "ManaReduction",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
			--[[
			{
				Key = "ReportedBonus",
				ExtractAs = "BonusCasts",
				SkipAutoExtract = true,
			},
			]]
		}
	},
	SorcerySpeedBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hermes_35",
		SpellModifier = true,

		RequiredSlottedTrait = "Spell",
		RequiredFalseTraits = { "SpellPotionTrait" },

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
		ManaSpendCostModifiers = 
		{
			Multiplier = {BaseValue = 0.85, SourceIsMultiplier = true},
			ReportValues = {ReportedReduction = "Multiplier"}
		},
		StatLines =
		{
			"SpellSpendStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedReduction",
				ExtractAs = "TooltipMultiplier",
				Format = "PercentDelta"
			},
		},
	},
	PerfectDodgeSlowBoon = 
	{
		Icon = "Boon_Hermes_02",
		InheritFrom = { "BaseTrait", "AirBoon" },
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
		AddRush =
		{
			FunctionName = "TimeSlowPerfectDash",
			RunOnce = true,
			FunctionArgs =
			{
				Modifier = 0.1,
				Cooldown = 4.0,
				Duration = { BaseValue = 1, },
				ReportValues = { ReportedDuration = "Duration"},
			},
		},
		StatLines =
		{
			"SlowDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				DecimalPlaces = 1,
			},

		}
	},
	TimedKillBuffBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Hermes_36",
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
		ShowInHUD = true,
		CustomLabel = 
		{
			DisplayType = "SessionMapStateValue",
			Key = "TimedBuff",
			MultiplyByRarity = true,
			Text = "UI_TimedKillBuff"
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			UseSessionMapStateValue = "TimedBuff",
			SessionMapStateMultiplier = {BaseValue = 0.01, DecimalPlaces = 3 },
			ReportValues = { ReportedMultiplier = "SessionMapStateMultiplier" }
		},
		OnEnemyDeathFunction = 
		{
			Name = "CheckTimedKillBuff",
			FunctionArgs = 
			{
				Duration = 30,
				ReportValues = { ReportedDuration = "Duration" },
				Fx = "ErisPowerUpFx",
			}
		},
		StatLines =
		{
			"TimedDamageBonusStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Multiplier",
				DecimalPlaces = 1,
				Format = "Percent",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			}
		}
	},
	SprintShieldBoon =
	{
		Icon = "Boon_Hermes_28",
		InheritFrom = { "BaseTrait", "FireBoon"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
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
		SetupFunction =
		{
			Name = "SprintShieldSetup",
			Args =
			{
				SprintShields = { BaseValue = 1 },
				ActiveVfx = "EurydiceDefenseFront",
				ReportValues = { ReportedShields = "SprintShields" ,}
			},
			RunOnce = true
		},

		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponSprint", "WeaponBlink" },
				WeaponProperty = "SelfVelocity",
				ChangeValue = 297,
				ChangeType = "Add",
				ExcludeLinked = true,
				ReportValues = {ReportedBaseSpeed = "ChangeValue"},
			},
			{
				WeaponNames = { "WeaponSprint", "WeaponBlink" },
				WeaponProperty = "SelfVelocityCap",
				ChangeValue = 133.5,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "ApolloControl",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
		},
		
		StatLines =
		{
			"SprintShieldStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedShields",
				ExtractAs = "TooltipShields",
			},
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "TooltipSpeed",
				Format = "PercentOfBase",
				BaseType = "Weapon",
				BaseName = "WeaponSprint",
				BaseProperty = "SelfVelocity",
			},
		}
	},
	TimeStopLastStandBoon = -- Legendary
	{
		InheritFrom = { "LegendaryTrait", "AirBoon" },
		Icon = "Boon_Hermes_39",
		
		AddLastStand =
		{
			Icon = "ExtraLifeChaos",
			HealFraction = 0.4,
			ManaFraction = 0.4,
			IncreaseMax = true,
			FunctionName = "LastStandTimeSlow",
			FunctionArgs = 
			{
				Duration = 8,
				Modifier = 0.1,
				ReportValues = 
				{
					ReportedDuration = "Duration",
					ReportedModifier = "Modifier",
				}
			},
		},
		StatLines =
		{
			"SlowTimeDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
			},
			{
				Key = "ReportedModifier",
				ExtractAs = "Modifier",
				Format = "NegativePercentDelta",
				HideSigns = true,
				SkipAutoExtract = true
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
})