OverwriteTableKeys( TraitData, {
	-- Duo
	ManaBurstCountBoon = -- Aphrodite x Apollo
	{
		Icon = "Boon_Apollo_42",
		InheritFrom = { "SynergyTrait" },
		-- Done via lua in CheckManaBurst
		BurstCount = 2,
		StatLines =
		{
			"BurstCountStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "BurstCount",
				ExtractAs = "Count",
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
	MaxHealthDamageBoon = -- Aphrodite x Demeter
	{
		Icon = "Boon_Demeter_42",
		InheritFrom = {"SynergyTrait"},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			MaxHealthMultiplier = 0.0010,
			ReportValues = {ReportedMultiplier = "MaxHealthMultiplier"}
		},
		InflationIndex = 100,
		StatLines =
		{
			"HealthDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipPercentIncrease",
				Format = "TimesOneHundredPercent",
			}
		}
	},

	SlamManaBurstBoon = -- Aphrodite x Hephaestus
	{
		Icon = "Boon_Hephaestus_42",
		InheritFrom = { "SynergyTrait" },
		OnProjectileCreationFunction = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast" },
			Name = "QueueManaBurst",
			Args = 
			{
				ProjectileName = "AphroditeBurst",
				DamageMultiplier = 1,
				StartDelay = 0.15,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
				}
			}
		},
		
		StatLines =
		{
			"ManaBurstDamageStatDisplay1",
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
	
	CharmCrowdBoon =  -- Aphrodite x Hera
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Aphrodite_41",
		
		SetupFunction =
		{
			Threaded = true,
			Name = "CharmCrowd",
			Args =
			{
				Minimum = 2,
				ReportValues = { ReportedMinimum = "Minimum"},
				EffectName = "Charm",
			},
		},
		StatLines = 
		{
			"CharmSizeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMinimum",
				ExtractAs = "TooltipMinimum",
			}
		}
	},

	BurnRefreshBoon = -- Aphrodite x Hestia
	{
		Icon = "Boon_Hestia_45",
		InheritFrom = {"SynergyTrait"},
		EternalBurnRequirements = 
		{
			RequiredEffect = "WeakEffect",
		},
		StatLines = 
		{
			"BurnRefreshStatDisplay",
		},
		ExtractValues = 
		{
			{
				ExtractAs = "TooltipWeakDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "TooltipWeakModifier",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "WeakEffect",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta"
			},
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
	AllCloseBoon = -- Aphrodite x Poseidon
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Poseidon_41",
		AddIncomingDamageModifiers =
		{
			ValidWeaponMultiplier = 0.85,
			ReportValues = { DamageTakenMultiplier = "ValidWeaponMultiplier"},
		},
		StatLines =
		{
			"CloseDefenseStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "DamageTakenMultiplier",
				ExtractAs = "TooltipDamageReduction",
				Format = "NegativePercentDelta",
			},
		}
	},
	SprintEchoBoon = -- Aphrodite x Zeus
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Zeus_46",
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponBlink", "WeaponSprint"},
			FunctionName = "CheckSprintBlitz",
			FunctionArgs = 
			{
				Range = 280,
				DamageMultiplier = 2,
				ReportValues = {ReportedMultiplier = "DamageMultiplier" }
			}
		},
		StatLines =
		{
			"SprintEchoStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				Format = "Percent",
				HideSigns = true,
				ExtractAs = "BlitzMultiplier",
			},
			{
				BaseType = "Projectile",
				BaseName = "ZeusEchoStrike",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "EchoDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "EchoThreshold",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "DamageThreshold",
			},
		}
	},
	StormSpawnBoon =  -- Apollo x Demeter
	{
		Icon = "Boon_Apollo_41",
		InheritFrom = {"SynergyTrait"},
		
		SetupFunction =
		{
			Threaded = true,
			Name = "CheckDemeterStormSpawn",
			Args =
			{
				SpawnInterval = 0.3,
				TargetProjectileName = "DemeterSprintStorm",
				ProjectileName = "DemeterMiniStorm",
				ProjectileCap = 6,
				ReportValues = {ReportedInterval= "SpawnInterval" }
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "DemeterMiniStorm" },
			EffectName = "LegacyChillEffect",
		},
		StatLines = 
		{
			"StormSpawnDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				DecimalPlaces = 2,
				SkipAutoExtract = true,
			},
			{
				External = true,
				ExtractAs = "Damage",
				BaseType = "ProjectileBase",
				BaseName = "DemeterMiniStorm",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Fuse",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterMiniStorm",
				BaseProperty = "Fuse",
				DecimalPlaces = 2,
			},
			{
				ExtractAs = "ChillAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "LegacyChillEffect",
				BaseProperty = "ElapsedTimeMultiplier",
				Format = "NegativePercentDelta",
			},
			{
				ExtractAs = "ProjectileSlow",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterSprintDefense",
				BaseProperty = "SpeedMultiplierOfEnemyProjectilesInside",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "ChillDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "LegacyChillEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "Duration",
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "DemeterSprintStorm",
				BaseProperty = "TotalFuse",
				DecimalPlaces = 2,
				SkipAutoExtract = true,
			},
		}
	},
	BlindClearBoon = -- Apollo x Hephaestus
	{
		Icon = "Boon_Apollo_43",
		InheritFrom = {"SynergyTrait"},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast" },
			ValidActiveEffects = {"BlindEffect"},
			ValidBaseDamageAddition = 220,
			ReportValues = { ReportedDamageAddition = "ValidBaseDamageAddition"}
		},
		StatLines =
		{
			"BlindClearBoonStatDisplay1",
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast" },
			FunctionName = "ClearBlindEffect",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageAddition",
				ExtractAs = "DamageAddition",
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent"
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
			},
		}
	},
	RaiseDeadBoon = -- Apollo x Hera
	{
		Icon = "Boon_Apollo_44",
		InheritFrom = { "SynergyTrait" },
		OnEnemyDeathFunction = {
			Name = "RaiseKilledEnemy",
			FunctionArgs = {
				DamageMultiplier = 3,
				PlayerMultiplier = 0.1,
				ReportValues = 
				{ 
					ReportedDamageBonus = "DamageMultiplier",
				},
				UsingEffectName = "Charm"
			}
		},
		StatLines =
		{
			"SummonStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "DamageBonus",
				Format = "PercentDelta",
			},
		}
	},
	CoverRegenerationBoon = -- Apollo x Hestia
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Hestia_42",
		
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "InterruptRegen",
		},
		SetupFunction = 
		{
			Name = "OutOfCombatRegenSetup",
			Args = 
			{
				Timeout = 3, -- Time before regen kicks in
				Regen = 3, -- Per second regen
				RegenStartFx = nil,
				RegenStartSound = nil,
				ReportValues =
				{
					ReportedTimeout = "Timeout",
					ReportedRegen = "Regen",
				}
			}
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				ChangeValue = -100,
				ChangeType = "Add",
				AsInt = true,
				ReportValues = { ReportedHealthPenalty = "ChangeValue"},
			},
		},
		StatLines = 
		{
			"CoverRegenStatDisplay1",
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"CoverRegenStatDisplay1",
				"HealingReductionNotice",
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedRegen",
				ExtractAs = "Regen",
				Format = "FlatHeal",
			},
			{
				Key = "ReportedTimeout",
				ExtractAs = "Timeout",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedHealthPenalty",
				ExtractAs = "MaxHealthReduction",
				AbsoluteValue = true,
				SkipAutoExtract = true,
			},
		}
	},
	PoseidonSplashSprintBoon = -- Apollo x Poseidon
	{
		Icon = "Boon_Poseidon_45",
		InheritFrom = {"SynergyTrait"},

		OnWeaponFiredFunctions =
		{
			ValidWeapons =  {"WeaponSprint"},
			FunctionName = "PoseidonSprintBall",
			FunctionArgs =
			{
				ProjectileName = "ProjectileSprintBall",
				DamageMultiplier = 1,
				ChargeRadiusTime = 2,
				Speed = 1000, -- Maximum speed of orb while following
				Offset = 80, -- How far behind the player the orb trails
				StartScale = 0.1,
				EndScale = 1.0,
				MaxAdjustTime = 0.5,
				AdjustRate = 360,
				ChargePushbackForce = 600, -- Degree of knockback when ball hits enemies while sprinting
				ChargePushbackRadius = 80, --Multiplied by scale of ball
				ChargePushbackFx = "PoseidonWaveCurlImpact",
				ChargePushbackSound = "/SFX/Player Sounds/DemeterRushImpactPoof",
				ChargeRadiusMultiplier = 1.5,
				ReportValues = 
				{
					ReportedMultiplier = "DamageMultiplier",
					ReportedTime = "ChargeRadiusTime",	
				}
			},
		},
		StatLines = 
		{
			"DetonateDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ProjectileSprintBall",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedTime",
				ExtractAs = "Time",
				SkipAutoExtract = true,
			}
		}
	},
	ApolloSecondStageCastBoon = -- Apollo x Zeus
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Zeus_41",
		
		ReportedDifference = 30, -- display variable for charge difference
		WeaponDataOverrideTraitRequirement = "ApolloExCastBoon",
		WeaponDataOverride =
		{
			WeaponCastArm = 
			{
				ManaCost = 0,
				OnChargeFunctionNames = { "DoWeaponCharge" },
				ChargeWeaponData =
				{
					OnStageReachedFunctionName = "CastChargeStage",
					EmptyChargeFunctionName = "EmptyCastCharge",
				},
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 15,
						Wait = 0.7,
					},
					{ 
						ManaCost = 45,
						Wait = 1.5,
						ForceRelease = true,
						ResetIndicator = true,
					}
				},
			},
		},
		
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponCastProjectileHades", "WeaponAnywhereCast", "WeaponCastProjectile" },
			AddChargeStage = 
			{ 
				TraitName = "ApolloExCastBoon",
				ManaCost = 45,
				ResetIndicator = true,
				Wait = 0.7,
				SuperCharge = true,
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "ApolloCast",},	
			FunctionName = "RecordSecondStageApolloCast",
			Args = 
			{
				ProjectileName = "ZeusApolloSynergyStrike",
				RequiredTrait = "ApolloExCastBoon",
				DamageMultiplier = 1
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponCastArm",
				WeaponProperty = "ForceMaxChargeRelease",
				ChangeValue = false,
			},
			{
				WeaponName = "WeaponCastArm",
				WeaponProperty = "ChargeTime",
				ChangeValue = 0.7, -- Needs to match charge time of above 
			}
		},
		StatLines =
		{
			"BoltDamageStatDisplay3",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDifference",
				ExtractAs = "Cost",
				SkipAutoExtract = true,
			},
			{
				External = true,
				ExtractAs = "Damage",
				BaseType = "ProjectileBase",
				BaseName = "ZeusApolloSynergyStrike",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Fuse",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ApolloCast",
				BaseProperty = "Fuse",
				DecimalPlaces = 2,
			},
		}
	},
	ClearRootBoon = -- Demeter x Hephaestus
	{
		InheritFrom = { "SynergyTrait", },
		Icon = "Boon_Demeter_43",
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "MassiveSlamBlast", "HephSprintBlast"},
			FunctionName = "ClearRoot",
			Args = 
			{
				EffectName = "ChillEffect",
			},

		},
		StatLines =
		{
			"ClearRootStatDisplay",
		},
		ExtractValues =
		{
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
	KeepsakeLevelBoon = -- Demeter x Hera
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Demeter_41",
		KeepsakeLevelBonus =  1,
		StatLines =
		{
			"KeepsakeStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "KeepsakeLevelBonus",
				ExtractAs = "LevelBonus",
				IncludeSigns = true,
			},
		}
	},
	BurnConsumeBoon = 
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Hestia_43",
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckBurnConsumption",
			FunctionArgs = 
			{
				Delay = 0.1,
				EffectName = "ChillEffect",
				ClearEffectName = "BurnEffect",
				ConsumptionDamage = 2, -- Multiplier
				ProjectileName = "HestiaBurnConsumeStrike",
				ReportValues = 
				{
					ReportedDamage = "ConsumptionDamage",
				}
			},
		},
		StatLines =
		{
			"BurnConsumeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				Format = "Percent",
				HideSigns = true,
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
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
	GoodStuffBoon = -- Demeter x Poseidon
	{
		Icon = "Boon_Poseidon_42",
		InheritFrom = { "SynergyTrait" },
		
		RarityBonus =
		{
			Rare = 0.45,
			Epic = 0.20,
			Legendary = 0.15,
			ReportValues = { ReportedRarity = "Rare"}
		},
		StatLines =
		{
			"RarityStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedRarity",
				ExtractAs = "Rarity",
				Format = "Percent",
			},
		}
	},
	RootStrikeBoon = -- Demeter x Zeus
	{
		Icon = "Boon_Zeus_42",
		InheritFrom = {"SynergyTrait"},
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckRootStrike",
			FunctionArgs = 
			{
				Interval = 0.25,
				ProjectileName = "ZeusRootStrike",
				ReportValues = { ReportedInterval = "Interval"}
			}
		},
		StatLines =
		{
			"RootStrikeDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				External = true,
				ExtractAs = "Damage",
				BaseType = "ProjectileBase",
				BaseName = "ZeusRootStrike",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
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
	EmptySlotDamageBoon = -- Hephaestus x Hera
	{
		InheritFrom = { "SynergyTrait" },
		Icon = "Boon_Hephaestus_41",
		VisualActivationRequirements = 
		{
			{
				{
					PathFalse = { "CurrentRun", "Hero", "SlottedTraits", "Melee" },
				},
			},
			{
				{
					PathFalse = { "CurrentRun", "Hero", "SlottedTraits", "Secondary" },
				},
			},

		},
		AddOutgoingDamageModifiers =
		{
			EmptySlotMultiplier = {
				BaseValue = 3,
				SourceIsMultiplier = true,
			},
			EmptySlotValidData =
			{
				--Ranged = WeaponSets.HeroNonPhysicalWeapons,
				Melee = WeaponSets.HeroPrimaryWeapons,
				Secondary = WeaponSets.HeroSecondaryWeapons,
			},
			ReportValues = { ReportedWeaponMultiplier = "EmptySlotMultiplier"},
		},
		StatLines =
		{
			"BoonlessStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipBonus",
				Format = "PercentDelta",
			},
		}
	},
	DoubleMassiveAttackBoon = -- Hephaestus x Hestia
	{
		Icon = "Boon_Hestia_44",
		InheritFrom = {"SynergyTrait"},
		DoubleAttackInterval = 2,
		NumAttacks = 2, -- used for trait description only
		StatLines =
		{
			"AdditionalStrikeStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "DoubleAttackInterval",
				ExtractAs = "Interval",
				DecimalPlaces = 2,
			}
		}
	},
	MassiveCastBoon = -- Hephaestus x Poseidon
	{
		Icon = "Boon_Poseidon_43",
		InheritFrom = {"SynergyTrait"},
		
		SetupFunction =
		{
			Name = "MassiveAttackSetup",
			Args = 
			{
				TraitName = "PoseidonCastBoon",
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroNonPhysicalWeapons,
			FunctionName = "CheckMassiveAttack",
			Args = 
			{
				ExcludeLinked = true,
				Name = "MassiveCast",
				TraitName = "PoseidonCastBoon",
				ProjectileName = "MassiveSlamBlastCast",
				Cooldown = 6,
				BlastDelay = 0.26,
				DamageMultiplier = 2.5,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown"
				},
			}
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
	ReboundingSparkBoon = -- Hephaestus x Zeus
	{
		Icon = "Boon_Zeus_45",
		InheritFrom = { "SynergyTrait" },
		-- Checked from script with HasTrait
		AddOutgoingDamageModifiers = 
		{
			ProjectileName = "ProjectileZeusSpark",
			JumpMultiplier = 0.20,
			ReportValues = { ReportedWeaponMultiplier = "JumpMultiplier"},
		},
		StatLines =
		{
			"JumpStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "Percent",
			},
		},
	},
	AllElementalBoon = -- Hera x Hestia
	{
		Icon = "Boon_Hestia_41",
		InheritFrom = {"SynergyTrait"},
		Elements = { "Aether", "Earth", "Air", "Fire", "Water" }, 
		AcquireFunctionName = "GrantBoons",
		AcquireFunctionArgs = 
		{
			BoonSets = 
			{	
				-- Earth
				{ "ElementalDamageBoon", "ElementalRarityUpgradeBoon", },
				-- Fire
				{ "ElementalBaseDamageBoon", "ElementalRallyBoon" },
				-- Air
				{ "ElementalDamageFloorBoon", "ElementalDodgeBoon" },
				-- Water
				{ "ElementalHealthBoon", "ElementalDamageCapBoon" },
			},
		},
		StatLines =
		{
			"AllElementStatDisplay",
		},
	},
	MoneyDamageBoon = -- Hera x Poseidon
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Poseidon_44",
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			GoldMultiplier = 0.10,
			ReportValues = {ReportedMultiplier = "GoldMultiplier"}
		},
		InflationIndex = 100,
		StatLines =
		{
			"GoldDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipPercentIncrease",
				Format = "TimesOneHundred",
			}
		}
	},
	SuperSacrificeBoonHera = -- Hera x Zeus
	{
		Icon = "Boon_Hera_47",
		InheritFrom = {"SynergyTrait"},
		CustomTrayText = "SuperSacrificeBoonHera_Tray",
		AcquireFunctionName = "SacrificeAllBoon",
		AcquireFunctionArgs = 
		{
			RemoveGod = "ZeusUpgrade",
			BuffGod = "HeraUpgrade",
			LevelBonus = 4,
			ReportValues = { ReportedLevelBonus = "LevelBonus" }
		},
		StatLines =
		{
			"LevelsGainedStatDisplay_Zeus",
		},
		TrayStatLines = 
		{
			"LevelsGainedStatDisplay_Tray"
		},
		ExtractValues =
		{
			{
				Key = "ReportedLevelBonus",
				ExtractAs = "Amount",
			},
		}
	},
	SuperSacrificeBoonZeus = -- Hera x Zeus
	{
		Icon = "Boon_Zeus_47",
		InheritFrom = {"SynergyTrait"},
		CustomTrayText = "SuperSacrificeBoonZeus_Tray",
		AcquireFunctionName = "SacrificeAllBoon",
		AcquireFunctionArgs = 
		{
			RemoveGod = "HeraUpgrade",
			BuffGod = "ZeusUpgrade",
			LevelBonus = 4,
			ReportValues = { ReportedLevelBonus = "LevelBonus" }
		},
		StatLines =
		{
			"LevelsGainedStatDisplay_Hera",
		},
		TrayStatLines = 
		{
			"LevelsGainedStatDisplay_Tray"
		},
		ExtractValues =
		{
			{
				Key = "ReportedLevelBonus",
				ExtractAs = "Amount",
			},
		}
	},
	SteamBoon = -- Hestia x Poseidon
	{
		Icon = "Boon_Hestia_46",
		InheritFrom = {"SynergyTrait"},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = {"ProjectileCastFireball", "ProjectileFireball", "ShadeMercFireball", "HestiaSprintPuddle" },
			AllEffectsTrigger = true,
			FunctionName = "CheckSteam",
			Args = 
			{
				ValidEffect = "BurnEffect",
				EffectName = "AmplifyKnockbackEffect",
				ProjectileName = "SteamBlast",
				DamageMultiplier = 1.2,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown"
				},
			},
		},
		StatLines =
		{
			"SteamStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "SteamBlast",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Fuse",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "SteamBlast",
				BaseProperty = "ImmunityDuration",
				DecimalPlaces = 2,
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "SteamBlast",
				BaseProperty = "BlastDuration",
			},
			{
				ExtractAs = "KnockbackAmplifyDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "AmplifyKnockbackEffect",
				BaseProperty = "Duration",
				DecimalPlaces = 1,
			},
		}
	},
	EchoBurnBoon = -- Hestia x Zeus
	{
		Icon = "Boon_Zeus_43",
		InheritFrom = { "SynergyTrait" },
		
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "ZeusEchoStrike" },
			FunctionName = "ApplyBurn",
			Args = 
			{
				EffectName = "BurnEffect",
				NumStacks = 80,
				ReportValues = {ReportedDamage = "NumStacks"}
			},	
		},
		StatLines =
		{
			"BurnDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedDamage",
					ExtractAs = "TooltipDamage",
			},
			{
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
			{
				ExtractAs = "EchoDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "EchoThreshold",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageEchoEffect",
				BaseProperty = "DamageThreshold",
			},
		}
	},
	LightningVulnerabilityBoon = -- Poseidon x Zeus
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Zeus_44",
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = 
			{
				"ZeusEchoStrike",
				"ZeusCastStrike",
				"ZeusRootStrike",
				"ZeusSprintStrike",
				"ProjectileZeusSpark",
				"ZeusZeroManaStrike",
				"ZeusRetaliateStrike",
			},
			ValidActiveEffects = {"AmplifyKnockbackEffect"},
			ValidWeaponMultiplier = 1.30,
			ReportValues = {ReportedMultiplier = "ValidWeaponMultiplier"}
		},
		StatLines =
		{
			"LightningDamageTakenStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipVulnerability",
				Format = "PercentDelta",
			},
			{
				ExtractAs = "KnockbackAmplifyDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "AmplifyKnockbackEffect",
				BaseProperty = "Duration",
				DecimalPlaces = 1,
			},
		}
	},
})