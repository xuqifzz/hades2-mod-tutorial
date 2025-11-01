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
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
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
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast", "MassiveSlamBlastCast", "HephLeapBlast" },
			Name = "QueueManaBurst",
			Args = 
			{
				ProjectileName = "AphroditeBurst",
				DamageMultiplier = 2.0,
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
		},

		PackageName = "AphroditeUpgrade"
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
		},

		PackageName = "AphroditeUpgrade"
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
		},
		PackageName = "HestiaUpgrade",
	},
	AllCloseBoon = -- Aphrodite x Poseidon
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Poseidon_41",
		AddIncomingDamageModifiers =
		{
			HealthOnly = true,
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
				DamageMultiplier = 1.8,
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
				Format = "PercentDelta",
				HideSigns = true,
				ExtractAs = "BlitzMultiplier",
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
		},

		PackageName = "ZeusUpgrade"
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
				TargetProjectileNames = { "DemeterSprintStorm", "DemeterCastStorm" },
				ProjectileName = "DemeterMiniStorm",
				ProjectileCap = 2,
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
		},

		PackageName = "DemeterUpgrade"
	},
	BlindClearBoon = -- Apollo x Hephaestus
	{
		Icon = "Boon_Apollo_43",
		InheritFrom = {"SynergyTrait"},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast", "MassiveSlamBlastCast", "HephLeapBlast"  },
			ValidActiveEffects = {"BlindEffect"},
			ValidBaseDamageAddition = 300,
			ReportValues = { ReportedDamageAddition = "ValidBaseDamageAddition"}
		},
		StatLines =
		{
			"BlindClearBoonStatDisplay1",
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "HephSprintBlast", "MassiveSlamBlast", "MassiveSlamBlastCast", "HephLeapBlast"  },
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
		},
		PackageName = "HeraUpgrade"
	},
	CoverRegenerationBoon = -- Apollo x Hestia
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Hestia_42",
		
		OnDodgeFunction = 
		{
			FunctionName = "DodgeHeal",
			RunOnce = true,
			FunctionArgs =
			{
				Amount = 10,
				ReportValues = { ReportedHeal = "Amount" }
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
				Key = "ReportedHeal",
				ExtractAs = "Heal",
				Format = "FlatHeal",
			},
			{
				ExtractAs = "BlindDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "Duration",
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
				StartingDamageMultiplier = 0.30,
				DamageMultiplier = 1,
				ChargeRadiusTime = 1.5,
				Speed = 1550, -- Maximum speed of orb while following
				Offset = 80, -- How far behind the player the orb trails
				StartScale = 0.1,
				EndScale = 1.0,
				MaxAdjustTime = 0.5,
				AdjustRate = 360,
				ChargePushbackForce = 600, -- Degree of knockback when ball hits enemies while sprinting
				ChargePushbackRadius = 80, --Multiplied by scale of ball
				ChargePushbackFx = "PoseidonWaveCurlImpact",
				ChargePushbackSound = "/SFX/Player Sounds/DemeterRushImpactPoof",
				ChargeRadiusMultiplier = 2.4,
				ReportValues = 
				{
					ReportedMultiplier = "DamageMultiplier",
					ReportedTime = "ChargeRadiusTime",	
				}
			},
		},
		OnSprintEndAction = 
		{
			FunctionName = "PoseidonSprintBlastDetach",
		},
		StatLines = 
		{
			"MaxDetonateDamageStatDisplay1",
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
		},
		PackageName = "PoseidonUpgrade",
	},
	ApolloSecondStageCastBoon = -- Apollo x Zeus
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Zeus_41",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ApolloExCastBoon" },
			}
		},
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
					OnNoManaForceRelease = "NoManaCastSecondStageForceRelease"
				},
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 15,
						Wait = 0.7,
					},
					{ 
						RequiredTraitName = "ApolloExCastBoon",
						ManaCost = 45,
						Wait = 1.2,
						ForceRelease = true,
						ResetIndicator = true,
					}
				},
			},
		},
		
		ChargeStageModifiers = 
		{
			ValidWeapons = { "WeaponCastProjectileHades", "WeaponAnywhereCast", "WeaponCastProjectile", "WeaponCastLob" },
			AddChargeStage = 
			{ 
				TraitName = "ApolloExCastBoon",
				ManaCost = 45,
				ResetIndicator = true,
				Wait = 1.5,
				SuperCharge = true,
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = { "ApolloCastRapid",},	
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
				TraitName = "ApolloExCastBoon",
				WeaponName = "WeaponCastArm",
				WeaponProperty = "ForceMaxChargeRelease",
				ChangeValue = false,
			},
			{
				TraitName = "ApolloExCastBoon",
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
		},
		PackageName = "ZeusUpgrade",
	},
	ClearRootBoon = -- Demeter x Hephaestus
	{
		InheritFrom = { "SynergyTrait", },
		Icon = "Boon_Demeter_43",
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "MassiveSlamBlast", "HephSprintBlast", "MassiveSlamBlastCast", "HephLeapBlast" },
			ActiveRootMultiplier = 1.5,
			ReportValues = { ReportedWeaponMultiplier = "ActiveRootMultiplier"},
		},
		StatLines =
		{
			"ClearRootStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
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
		},
		PackageName = "DemeterUpgrade",
	},
	KeepsakeLevelBoon = -- Demeter x Hera
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Demeter_41",
		BlockOfferIfPreviouslyPicked = true,
		KeepsakeLevelBonus =  1,
		AcquireFunctionName = "AttemptAdvanceKeepsake",
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
	BurnConsumeBoon = -- Demeter x Hestia
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
				EffectBlockDuration = 2,
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
		},
	},

	GoodStuffBoon = -- Demeter x Poseidon
	{
		Icon = "Boon_Poseidon_42",
		InheritFrom = { "SynergyTrait" },
		GameStateRequirements =
		{
			{
				FunctionName = "PommableSlottedTraitCountAtLeast",
				FunctionArgs = { 
					Count = 1, 
					Slots = 
					{ 
						Secondary = true,
						Rush = true, 
						Ranged = true, 
						Melee = true, 
						Mana = true, 
					}
				},
			},
		},
		AcquireFunctionName = "DistributeLevels",
		AcquireFunctionArgs = 
		{
			Slots = { "Secondary", "Rush", "Ranged", "Melee", "Mana" },
			LevelBonus = 8,
			ReportValues = { ReportedLevelBonus = "LevelBonus" }
		},
		StatLines =
		{
			"RarityStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedLevelBonus",
				ExtractAs = "Level",
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
				Interval = 0.50,
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
		},

		PackageName = "ZeusUpgrade"
	},
	ManaShieldBoon = -- Hephaestus x Hera
	{
		InheritFrom = { "SynergyTrait" },
		Icon = "Boon_Hephaestus_41",
		ManaShieldData = 
		{
			DamageBlocked = 0.3,					 --Percent of damage that is redirected
			ManaPerDamageBlocked =	10,			-- Amount of mana burned per damage blocked
			ReportValues = 
			{ 
				ReportedDamageBlocked = "DamageBlocked",
				ReportedManaConversion = "ManaPerDamageBlocked",
			}
		},
		
		StatLines =
		{
			"ManaShieldStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaConversion",
				ExtractAs = "TooltipManaConversion",
			},
			{
				Key = "ReportedDamageBlocked",
				ExtractAs = "TooltipDamageBlocked",
				Format = "Percent",
				SkipAutoExtract = true,
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
		OlympianRechargeMultiplier = 1/1.35,
		StatLines =
		{
			"RechargeSpeedStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "OlympianRechargeMultiplier",
				ExtractAs = "RechargeMultiplier",
				Format = "PercentReciprocalDelta",
			},
		},
	},
	ReboundingSparkBoon = -- Hephaestus x Zeus
	{
		Icon = "Boon_Zeus_45",
		InheritFrom = { "SynergyTrait" },
		-- Checked from script with HasTrait
		AddOutgoingDamageModifiers = 
		{
			ProjectileName = "ProjectileZeusSpark",
			JumpMultiplier = 0.15,
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
	MoneyDamageBoon = -- Hera x Poseidon
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Poseidon_44",
		DoubleOlympianProjectileChance = 0.30,
		DoubleOlympianProjectileInterval = 0.15,
		StatLines =
		{
			"GoldDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "DoubleOlympianProjectileChance",
				ExtractAs = "TooltipPercentIncrease",
				Format = "LuckModifiedPercent",
			}
		}
	},
	SuperSacrificeBoonHera = -- Hera x Zeus
	{
		Icon = "Boon_Hera_47",
		InheritFrom = {"SynergyTrait"},
		CustomTrayText = "SuperSacrificeBoonHera_Tray",
		AcquireFunctionName = "SacrificeAllBoon",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "MetGods", "HeraUpgrade" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "MetGods", "ZeusUpgrade" },
			}
		},
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
		},

		PackageName = "HeraUpgrade"
	},
	SuperSacrificeBoonZeus = -- Hera x Zeus
	{
		Icon = "Boon_Zeus_47",
		InheritFrom = {"SynergyTrait"},
		CustomTrayText = "SuperSacrificeBoonZeus_Tray",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "MetGods", "HeraUpgrade" },
			},
			{
				PathTrue = { "CurrentRun", "Hero", "MetGods", "ZeusUpgrade" },
			}
		},
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
		},

		PackageName = "ZeusUpgrade"
	},
	SteamBoon = -- Hestia x Poseidon
	{
		Icon = "Boon_Hestia_46",
		InheritFrom = {"SynergyTrait"},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = {"ProjectileCastFireball", "ProjectileFireball", "HestiaSprintPuddle" },
			AllEffectsTrigger = true,
			FunctionName = "CheckSteam",
			Args = 
			{
				ValidEffect = "BurnEffect",
				EffectName = "AmplifyKnockbackEffect",
				ProjectileName = "SteamBlast",
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
				BaseProperty = "TotalFuse",
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
			{
				ExtractAs = "FontChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "AmplifyKnockbackEffect",
				BaseProperty = "Chance",
				Format = "LuckModifiedPercent"
			},
			{
				External = true,
				ExtractAs = "FontDamage",
				BaseType = "ProjectileBase",
				BaseName = "PoseidonEffectFont",
				BaseProperty = "Damage",
			},
		},
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
				NumStacks = 160,
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
		},
		PackageName = "HestiaUpgrade",
	},
	LightningVulnerabilityBoon = -- Zeus x Poseidon
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
			{
				ExtractAs = "FontChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "AmplifyKnockbackEffect",
				BaseProperty = "Chance",
				Format = "LuckModifiedPercent"
			},
			{
				External = true,
				ExtractAs = "FontDamage",
				BaseType = "ProjectileBase",
				BaseName = "PoseidonEffectFont",
				BaseProperty = "Damage",
			},
		},
		PackageName = "ZeusUpgrade",
	},
	
	ManaRestoreDamageBoon =  -- Hera x Hestia
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Hestia_41",
		SetupFunction =
		{
			Threaded = true,
			RequiredContext = "StartRoom",
			Name = "ManaRestoreDamage",
			Args =
			{
				ProjectileName = "ManaRestoreBlast",
				EffectName = "DamageShareEffect",
				Interval = 0.2,			-- Highest rate of fire
				ManaThreshold = 5,		-- How much mana regen to 'accumulate' before firing.
				DamageMultiplier = 5,	-- Mana regenerated to damage conversion
				ReportValues = 
				{ 
					ReportedInterval = "Interval",
					ReportedMultiplier = "DamageMultiplier",
				},
			},
		},
		StatLines = 
		{
			"ManaRestoreStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "DamageMultiplier",
				Format = "Percent",
				HideSigns = true,
			},
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "DamageShareDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "DamageShareAmount",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "DamageShareEffect",
				BaseProperty = "Amount",
				Format = "Percent",
			},
		},
	},

	SelfCastBoon = -- Demeter x Ares
	{
		InheritFrom = {"SynergyTrait"},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary", },
				HasNone = { "CastProjectileBoon", "CastAnywhereBoon", "HadesCastProjectileBoon", "CastLobBoon" },
			},
		},
		Icon = "Boon_Ares_42",
		OnProjectileArmFunction =
		{
			FunctionName = "OnDemeterCastArmed",
			FunctionArgs = 
			{
				Speed = 1000,
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponCast"},
			FunctionName = "CheckArmImput",
		},
		OnWeaponChargeCanceledFunctions = 
		{
			ValidWeapons = {"WeaponCastArm"},
			FunctionName = "CheckCastDetach",
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "AttachToOwner",
				ChangeValue = true,
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "IgnoreCancelAttachedProjectiles",
				ChangeValue = true,
			}
		},
		AddOutgoingDamageModifiers =
		{
			ValidProjectiles = {"ProjectileCast"},
			ValidWeaponMultiplier =
			{
				BaseValue = 2.00,
				SourceIsMultiplier = true,
			},
			
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidWeaponMultiplier" 
			},
		},
		StatLines = 
		{
			"ExCastDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "TooltipDamage",
				Format = "PercentDelta",
			},
		},
	},

	AutoRevengeBoon = -- Zeus x Ares
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Ares_43",
		
		OnEffectApplyFunction = 
		{
			FunctionName = "CheckAutoRevenge",
			FunctionArgs = 
			{
				EffectName = "AresStatus",
				Cooldown = 6,
				ReportValues = {ReportedInterval = "Cooldown"}
			},
		},
		StatLines = 
		{
			"RevengeTimerStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				DecimalPlaces = 1,
				Format = "SpeedModifiedDuration",
			},
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
		PackageName = "AresUpgrade",
	},

	BloodRetentionBoon = -- Hera x Ares
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Ares_44",
		CustomTrayText = "BloodRetentionBoon_Tray",
		SetupFunction =
		{
			Threaded = true,
			RequiredContext = "StartRoom",
			Name = "CarryOverBloodDropBonus",
			Args =
			{
				Multiplier = 1,
				Cap = 20,
				ReportValues = { ReportedValue = "Cap"},
			}
		},
		StatLines = 
		{
			"BloodRetainStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedValue",
				ExtractAs = "BloodCount",
			},
		},
	},

	RapidSwordBoon = -- Hephaestus x Ares
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Ares_45",
		AresSwordModifiers = 
		{
			Fuse = 0.35,
		},
		AddOutgoingDamageModifiers = 
		{
			ValidProjectiles = { "ProjectileAresSwordWake", "ProjectileAresSwordCast", "ProjectileAresSwordEx" },
			ValidBaseDamageAddition = 25,
			ReportValues = { ReportedDamageAddition = "ValidBaseDamageAddition"}
		},
		PropertyChanges = 
		{
			{
				TraitName = "AresSprintBoon",
				WeaponName = "WeaponBlink",
				ProjectileName = "ProjectileAresSwordWake",
				ProjectileProperty = "FuseStart",
				ChangeValue = 0.35,
				ExcludeLinked = true,
			},
			{
				TraitName = "AresSprintBoon",
				WeaponName = "WeaponBlink",
				ProjectileName = "ProjectileAresSwordWake",
				ProjectileProperty = "Fuse",
				ChangeValue = 0.35,
				ExcludeLinked = true,
			},
		},
		StatLines =
		{
			"FallSwordDamageStatDisplay",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageAddition",
				ExtractAs = "DamageAddition",
				IncludeSigns = true,
			},
		}
	},

	DoubleSplashBoon = -- Poseidon x Ares
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Ares_46",
		NumHits = 2, -- used only for text
		ConeModifier = 
		{
			DoubleWaveChance = 0.25,
			DoubleWaveGraphic = "PoseidonRedConeFxEmitterLarge",
			ReportValues = {ReportedChance = "DoubleWaveChance"}
		},
		StatLines =
		{
			"DoubleSplashStatDisplay",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
				HideSigns = true
			},
		}
	},

	DoubleSwordBoon = -- Apollo x Ares
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Ares_47",
		AresSwordModifiers = 
		{
			AoEMuliplier = 1.5,
			AddCount = 1,
			ReportValues = {ReportedAoEIncrease = "AoEMuliplier"}
		},
		StatLines =
		{
			"FallSwordAoEStatDisplay",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedAoEIncrease",
				ExtractAs = "Increase",
				Format = "PercentDelta",
			},
		}
	},

	FireballRendBoon = -- Hestia x Ares
	{
		InheritFrom = {"SynergyTrait"},
		Icon = "Boon_Ares_48",
		AddOutgoingDamageModifiers =
		{
			ValidProjectiles = {"ProjectileCastFireball", "ProjectileFireball" },
			MissingEffectDamage = EffectData.AresStatus.BonusBaseDamageOnInflict * 6,
			MissingEffectName = "AresStatus",
			MissingDamagePresentation = 
			{
				TextStartColor = Color.AresDamageLight,
				TextColor = Color.AresDamage,
				FunctionName = "AresRendApplyPresentation",
				SimSlowDistanceThreshold = 180,
				HitSimSlowCooldown = 0.8,
				HitSimSlowParameters =
				{
					{ ScreenPreWait = 0.02, Fraction = 0.13, LerpTime = 0 },
					{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.05 },
				},
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidProjectiles = {"ProjectileCastFireball", "ProjectileFireball" },
			EffectName = "AresStatus",
		},
		ReportedRendBonus = 250,		-- Display variable, matches multiplier above to MissingEffectDamage
		StatLines =
		{
			"FireballRendStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedRendBonus",
				ExtractAs = "RendBonus",
				IncludeSigns = true,
			},
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

	BloodManaBurstBoon = -- Aphrodite x Ares
	{
		Icon = "Boon_Ares_49",
		InheritFrom = { "SynergyTrait" },
		DropManaBurstChance = 0.35,
		ManaBurstArgs = 
		{
			ProjectileName = "AphroditeBurst",
			DamageMultiplier = 1.0,
			StartDelay = 0.15,
			ReportValues = 
			{ 
				ReportedMultiplier = "DamageMultiplier",
			}
		},
		
		StatLines =
		{
			"ManaBurstChanceStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "DropManaBurstChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
				HideSigns = true,
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "AphroditeBurst",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "AphroditeBurst",
				BaseProperty = "Fuse",
			},
		},

		PackageName = "AphroditeUpgrade"
	}
})