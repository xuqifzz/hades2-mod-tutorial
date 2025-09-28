OverwriteTableKeys( TraitData, {
	CastLobBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "CastProjectileBoon", "CastAnywhereBoon", "HadesCastProjectileBoon", "SelfCastBoon" },
			},
		},
		Icon = "Boon_Dionysus_27",

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
		

		PreEquipWeapons = { "WeaponCastLob" },
		OverrideWeaponFireNames =
		{
			RangedWeapon = "nil",
			WeaponCastLob = "WeaponCast",
		},
		WeaponDataOverride = 
		{
			WeaponCast = 
			{
				UnarmedCastCompleteGraphic = "nil",
				Sounds = 
				{
					FireSounds = 
					{
						-- { Name = "/VO/MelinoeEmotes/EmoteCasting" },
						{ Name = "/Leftovers/SFX/WyrmCastAttack" },
					}
				}
			}
		},
		SetupFunction =
		{
			Name = "SetupLobCast",
			RunOnce = true,
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				WeaponProperties = 
				{
					IgnoreOwnerAttackDisabled = true,
					Cooldown = 0,
					ChargeTime = 0,
					SelfVelocity = 0,
					FireGraphic = "null",
					AllowMultiFireRequest = true,
					RootOwnerWhileFiring = false,
					ChargeStartAnimation = "null",
					SetCompleteAngleOnFire = true,
					IgnoreForceCooldown = true,
					AllowExternalForceRelease = false,
					AddOnFire = "null",
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponCastLob",
				ProjectileProperty = "Damage",
				BaseValue = 300,
				ChangeType = "Absolute",
				ReportValues = { ReportedDamage = "ChangeValue" },
				IdenticalMultiplier =
				{
					Value = -0.75,
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastAttackDisable",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastSelfSlow2",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge",
				ChangeValue = "WeaponCastLob",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd",
				ChangeValue = "WeaponCastLob",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "RemoveControlOnCharge",
				ChangeValue = "WeaponCastLob",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "AddControlOnFire",
				ChangeValue = "WeaponCastLob",
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperty = "AddControlOnChargeCancel",
				ChangeValue = "WeaponCastLob",
			}
		},
		StatLines =
		{
			"DetonateDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
		}
	},
	HiddenMaxHealthBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Dionysus_32",
		HideHealth = true,
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
				Multiplier = 1.8,
			},
			Heroic =
			{
				Multiplier = 2.2,
			},
		},
		AcquireFunctionName = "GrantRandomMaxHealth",
		AcquireFunctionArgs = 
		{
			MinHealth = {BaseValue = 50},
			MaxHealth = 
			{
				CustomRarityMultiplier = 
				{
					Common = { Multiplier = 1.0 },
					Rare = { Multiplier = 1.25 },
					Epic = { Multiplier = 1.5 },
					Heroic = { Multiplier = 1.75 }
				},
				BaseValue = 80
			},
			ReportValues = 
			{
				ReportedMin = "MinHealth",
				ReportedMax = "MaxHealth",
			}
		},
		
		StatLines =
		{
			"HiddenMaxHealthStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMin",
				ExtractAs = "TooltipLifeMin",
				IncludeSigns = true,
			},
			{
				Key = "ReportedMax",
				ExtractAs = "TooltipLifeMax",
				IncludeSigns = true,
			},
		}
	},
	FirstHangoverBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Dionysus_30",
		
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
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeaponsAndSprint,
			FunctionName = "CheckDionysusDebuff",
			Args = 
			{
				EffectName = "DamageOverTime",
				Damage = { BaseValue = 50 },
				ReportValues = { ReportedDamage = "Damage"}
			}
		},
		StatLines =
		{
			"DamageOverTimeStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
			},
			{		
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageOverTime",
				BaseProperty = "Cooldown",
				SkipAutoExtract = true,
				ExtractAs = "DamageOverTimeFuse",
				DecimalPlaces = 2,
			},
			{		
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageOverTime",
				BaseProperty = "Duration",
				SkipAutoExtract = true,
				ExtractAs = "DamageOverTimeDuration",
			},
		}
	},
	PowerDrinkBoon = 
	{
		Icon = "Boon_Dionysus_33",
		InheritFrom = { "BaseTrait", "WaterBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 9/10,
			},
			Epic =
			{
				Multiplier = 8/10,
			},
			Heroic =
			{
				Multiplier = 7/10,
			},
		},
		DrinkCritCount = 1,
		DrinkCritVfx = "PowerDrinkFx",
		SetupFunction =
		{
			Name = "CheckDrinkSpawn",
			Threaded = true,
			RunOnce = true,
			Args =
			{
				ConsumableName = "PowerDrinkDrop",
				Interval = 
				{
					BaseValue = 10,
				},
				MinRange = 450,
				MaxRange = 1200,
				DespawnRange = 2500,
				
				ThreadName = "DrinkBoonRespawn",
				Vfx = "BoonDropFrontFlare",
				Sound = "/SFX/Menu Sounds/KeepsakeEurydiceAcorn",
				ReportValues = { ReportedInterval = "Interval" },
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidDrinkBaseDamage = 100,
			ReportValues = { ReportedDamage = "ValidDrinkBaseDamage" },
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveDrinkCritVolley",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeaponsAndSprint,
			FunctionName = "CheckDrinkCritCharges",
		},
		StatLines = 
		{
			"ManaRespawnIntervalStatDisplay1"
		},
		ExtractValues =
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Amount",
				DecimalPlaces = 1,
				Format = "SpeedModifiedDuration",
			},
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				SkipAutoExtract = true,
			}
		}
	},

	CombatEncounterHealBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Dionysus_28",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.2,
			},
			Epic =
			{
				Multiplier = 1.4,
			},
			Heroic =
			{
				Multiplier = 1.6,
			},
		},
		OnEncounterStartFunction =
		{
			Name = "RecordDamageSnapshot",
		},
		EncounterEndFunctionName = "EndEncounterHeal",
		EncounterEndFunctionArgs =
		{
			EncounterHealMultiplier = { BaseValue = 0.5 },
			ReportValues = { ReportedEncounterHealMultiplier = "EncounterHealMultiplier" }
		},
		StatLines =
		{
			"EncounterHealStatDisplay1",
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"EncounterHealStatDisplay1",
				"HealingReductionNotice",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedEncounterHealMultiplier",
				ExtractAs = "EncounterHeal",
				Format =  "PercentHeal",
				HideSigns = true,
			},
		}
	},

	FogDamageBonusBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Dionysus_31",
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
		AddOutgoingDamageModifiers =
		{
			RequiredSelfEffectsMultiplier =
			{
				BaseValue = 1.30,
				SourceIsMultiplier = true,
			},
			RequiredEffects = { "WineEmpower" },
			ReportValues = { ReportedMultiplier = "RequiredSelfEffectsMultiplier"},
		},
		SetupFunction =
		{
			Name = "RandomFogSpawn",
			Threaded = true,
			RunOnce = true,
			Args =
			{
				ProjectileName = "DionysusField",
				Range = 600,
				ScaleY = 0.5,
				Interval = 8,
				ReportValues = { ReportedInterval = "Interval" },
			},
		},
		StatLines =
		{
			"FogDamageStatLine",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta"
			},
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				SkipAutoExtract = true,
				Format = "SpeedModifiedDuration",
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DionysusField",
				BaseProperty = "TotalFuse",
			},
		}
	},

	BankBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		CustomTrayText = "BankBoon_Tray",
		Icon = "Boon_Dionysus_34",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 400/300,
			},
			Epic =
			{
				Multiplier = 500/300,
			},
			Heroic =
			{
				Multiplier = 600/300,
			},
		},
		AcquireFunctionName = "BankGold",
		AcquireFunctionArgs = 
		{
			ReturnGold = { BaseValue = 300 },
			ReportValues = { ReportedGold = "ReturnGold" }
		},
		StoredGold = 0,
		OnLevelOrRarityChangeFunctionName = "CreditMissingGold",
		StatLines =
		{
			"BankStatLine1",
		},
		TrayStatLines =
		{
			"TrayBankStatLine1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedGold",
				ExtractAs = "AmountGained",
			},
			{
				Key = "StoredGold",
				ExtractAs = "TooltipGold",
				SkipAutoExtract = true
			},
		}
	},

	RandomBaseDamageBoon = 
	{
		InheritFrom = { "WaterBoon" },
		Icon = "Boon_Dionysus_29",

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 7/5,
			},
			Epic =
			{
				Multiplier = 9/5,
			},
			Heroic =
			{
				Multiplier = 11/5,
			},
		},
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DionysusPostTrueEnding01" },
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DionysusPostTrueEnding01" },
			},
		},
		FirstTimeEntranceAnimation = "BoonEntranceNew",
		PriorityRequirements =
		{
			{
				PathFalse = { "GameState", "TraitsSeen", "RandomBaseDamageBoon" },
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			RandomizedBaseDamage = 
			{
				-- Rolls chance from top to bottom
				{
					Value = 555,
					Chance = {BaseValue = 0.05},
					DamagePresentationFunctionName =  "HighRollHitPresentation",
					TriggerArgsKey = "RandomHighRoll",
					ReportValues = 
					{
						ReportedHighestDamage = "Value",
						ReportedChance = "Chance",
					}
				},
				{
					Value = 55,
					ReportValues = 
					{
						ReportedMiddleDamage = "Value",
					},
					Chance = 0.5,
				},
				{
					Value = 5,
					ReportValues = 
					{
						ReportedLowestDamage = "Value",
					}
				}
			}
		},
		StatLines =
		{
			"RandomDamageStatLine",
		},
		ExtractValues =
		{
			{
				Key = "ReportedLowestDamage",
				ExtractAs = "MinDamage",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedMiddleDamage",
				ExtractAs = "MidDamage",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedHighestDamage",
				ExtractAs = "MaxDamage",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
				HideSigns = true,
			},
		},
		FlavorText = "RandomBaseDamageBoon_FlavorText",
	}
})