OverwriteTableKeys( TraitData, {
	CastLobBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "CastProjectileBoon", "CastAnywhereBoon", "HadesCastProjectileBoon", "PoseidonCastBoon", "CastAttachBoon" },
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
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.50,
			},
			Heroic =
			{
				Multiplier = 1.75,
			},
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 80,
				ChangeType = "Add",
				ReportValues = { ReportedMaxLife = "ChangeValue"}
			},
		},
		
		StatLines =
		{
			"HiddenMaxHealthStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMaxLife",
				ExtractAs = "TooltipLife",
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
	RandomDuoBoon = 
	{
		InheritFrom = { "BaseTrait", "WaterBoon" },
		Icon = "Boon_Dionysus_33",
		
		AcquireFunctionName = "GrantEligibleDuo",
		AcquireFunctionArgs = 
		{
			SkipRequirements = true,		-- Skip prereq traits
			Count = 1,
			BlockedTraits = 
			{
				SuperSacrificeBoonHera = true,
				SuperSacrificeBoonZeus = true,
			},
			ReportValues = { ReportedCount = "Count"}
		},
		
		StatLines =
		{
			"DuoBoonCountStatLine",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			},
		}
	},
	PowerDrinkBoon = 
	{
		Icon = "Boon_Dionysus_29",
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
		DrinkCritVfx = "DaggerBlockActiveFx",
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
				DecimalPlaces = 2,
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
		EncounterHealMultiplier = { BaseValue = 0.5 },
		StatLines =
		{
			"EncounterHealStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "EncounterHealMultiplier",
				ExtractAs = "EncounterHeal",
				Format =  "Percent",
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
	}
})