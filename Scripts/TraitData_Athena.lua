OverwriteTableKeys( TraitData, {
	-- Athena
	InvulnerabilityDashBoon = 
	{
		Icon = "Boon_Athena_31",
		InheritFrom = { "BaseTrait", "LegacyTrait", "FireBoon" },

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
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "AthenaFirstMeeting"}
			}
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons =  {"WeaponBlink"},
			ExcludeLinked = true,
			FunctionName = "AthenaDeflect",
			FunctionArgs =
			{
				DamageMultiplier = {BaseValue = 1},
				Duration = 0.175,
				EffectNames = {"AthenaInvulnerable", "AthenaProjectileDefense"},
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponBlink",

				WeaponProperties = 
				{
					BlinkDetonateOnInterval = 60,
					Projectile = "AthenaRushProjectile",
				},
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponBlink",
				ProjectileProperty = "Damage",
				BaseValue = 10,
				ReportValues = {ReportedDamage = "ChangeValue"},
				AbsoluteStackValues =
				{
					[1] = 5,
					[2] = 3,
					[3] = 2,
				},
				AsInt = true,
			},
		},
		StatLines =
		{
			"DashDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "BlinkDamage",
			},
		}
	},
	RetaliateInvulnerabilityBoon = 
	{
		Icon = "Boon_Athena_32",
		InheritFrom = { "BaseTrait", "FireBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 13/10,
			},
			Rare =
			{
				Multiplier = 11/10,
			},
			Epic =
			{
				Multiplier = 9/10,
			},
			Heroic =
			{
				Multiplier = 7/10,
			},
		},
		ShowInHUD = true,
		OnSelfDamagedFunction = 
		{
			Name = "AthenaRetaliate",
			FunctionArgs = 
			{
				Cooldown = {BaseValue = 10},
				EffectName = "AthenaInvulnerable",
				Duration = 2,
				ReportValues = 
				{ 
					ReportedCooldown = "Cooldown",
					ReportedDuration = "Duration",
				},
			}
		},
		SetupFunction =
		{
			Name = "AthenaInvulnerabilitySetup",
		},
		StatLines =
		{
			"RechargeTimeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
				Format = "SpeedModifiedDuration",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
		},
	},
	FocusLastStandBoon =
	{
		Icon = "Boon_Athena_29",
		InheritFrom = { "BaseTrait", "FireBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 150/150,
			},
			Rare =
			{
				Multiplier = 125/150,
			},
			Epic =
			{
				Multiplier = 100/150,
			},
			Heroic =
			{
				Multiplier = 75/150,
			},
		},
		SetupFunction =
		{
			Name = "LastStandManaReserve",
			Args =
			{
				ManaReservationCost =
				{
					BaseValue = 150,
				},
				ReportValues = { ReportedManaReservationCost = "ManaReservationCost" }
			},
		},
		AcquireFunctionName = "AddLastStand",
		AcquireFunctionArgs = {
			Name = "Athena",
			Icon = "ExtraLifeAthena",
			HealFraction = 0.4,
			ManaFraction = 0.4,
			ValidityFunctionName = "IsLastStandManaReserveEligible",
			IncreaseMax = true,
			Priority = true,
		},
		OnLevelOrRarityChangeFunctionName = "RestoreLastStandManaReserve",
		StatLines =
		{
			"ReserveManaStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaReservationCost",
				ExtractAs = "TooltipManaReservation",
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
	AthenaProjectileBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "FireBoon" },
		Icon = "Boon_Athena_27",
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
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "AthenaFirstMeeting"}
			}
		},
		ShowInHUD = true,
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,	
			FunctionName = "CheckAthenaProjectile",
			FunctionArgs = 
			{
				ProjectileName = "AthenaDeflectingProjectile",
				DamageMultiplier = { BaseValue = 1.0 },
				Cooldown = 2,
				--ProjectileCap = 2,
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedCooldown = "Cooldown",
				}
			},
		},
	
		StatLines =
		{
			"ProjectileDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "AthenaDeflectingProjectile",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
				Format = "SpeedModifiedDuration",
				DecimalPlaces = 1,
				SkipAutoExtract = true,
			},
		}
	},
	DeathDefianceRefillBoon = 
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "FireBoon" },
		Icon = "Boon_Athena_28",
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
		CustomTrayText = "DeathDefianceRefillBoon_Tray",
		GameStateRequirements =
		{
			NamedRequirements = { "MissingLastStand", },
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "AthenaFirstMeeting"}
			}
		},
		LastStandHealFraction = {BaseValue = 0.1 },
		AcquireFunctionName = "AthenaRefillLastStands",
		StatLines =
		{
			"LastStandHealStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "LastStandHealFraction",
				ExtractAs = "BonusHeal",
				Format = "Percent",
			},
			{
				Key = "LastStandHealFraction",
				ExtractAs = "LastStandHeal",
				Format = "Percent",
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
	InvulnerabilityCastBoon = 
	{
		Icon = "Boon_Athena_30",
		InheritFrom = { "BaseTrait", "LegacyTrait", "FireBoon" },

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
		
		OnWeaponChargeFunctions =
		{
			ValidWeapons =  {"WeaponCast"},
			ExcludeLinked = true,
			FunctionName = "AthenaDeflect",
			FunctionArgs =
			{
				IsCast = true,
				Cooldown = 3,
				ProjectileName = "AthenaCastProjectile",
				DamageMultiplier = { BaseValue = 1 },
				Duration = 0.5,
				EffectNames = {"AthenaInvulnerable", "AthenaProjectileDefense"},
				ReportValues = { ReportedMultiplier = "DamageMultiplier"},
			},
		},

		OnWeaponFiredFunctions =
		{
			ValidWeapons =  {"WeaponCast"},
			ExcludeLinked = true,
			FunctionName = "CheckIndirectCastAthenaDeflect",
		},
		StatLines =
		{
			"CastDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "AthenaCastProjectile",
				BaseProperty = "Damage",
			},
		}
	},
	ManaSpearBoon = 
	{
		Icon = "Boon_Athena_33",
		InheritFrom = { "BaseTrait", "FireBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 200/150,
			},
			Epic =
			{
				Multiplier = 250/150,
			},
			Heroic =
			{
				Multiplier = 300/150,
			},
		},

		OnManaSpendAction = 
		{
			FunctionName = "CheckManaSpear",
			FunctionArgs = 
			{
				ManaCost = 90,
				Range = 1100,
				ProjectileName = "ProjectileAthenaManaSpear",
				TargetCount = 3,
				DamageMultiplier = 
				{
					BaseValue = 1,
					DecimalPlaces = 3,
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
					ReportedMana = "ManaCost",
					ReportedTargets = "TargetCount",
				}
			}
		},
		StatLines =
		{
			"SpearDamageStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ProjectileAthenaManaSpear",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedMana",
				ExtractAs = "Mana",
				SkipAutoExtract = true
			},
			{
				Key = "ReportedTargets",
				ExtractAs = "Count",
				SkipAutoExtract = true
			},
		}
	},

	OlympianSpellCountBoon =
	{
		Icon = "Boon_Athena_34",
		ShowInHUD = true,
		InheritFrom = { "FireBoon" },
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
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AthenaGrantsReward01" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = 
				{
					"PolymorphZeusTalent",
					"MeteorHestiaTalent",
					"TransformAphroditeTalent",
					"LeapHephaestusTalent",
					"LaserApolloTalent",
					"SummonHeraTalent",
					"TimeSlowDemeterTalent",
					"PotionPoseidonTalent",
					"MoonBeamAresTalent",
				},
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AthenaGrantsReward01" },
			},
		},
		FirstTimeEntranceAnimation = "BoonEntranceNew",
		PriorityRequirements =
		{
			{
				PathFalse = { "GameState", "TraitsSeen", "OlympianSpellCountBoon" },
			},
		},
		OlympianSpellCountAddition = { BaseValue = 1 },
		StatLines = 
		{
			"RarifyBoonStatLine1",
		},
		ExtractValues = 
		{
			{
				Key = "OlympianSpellCountAddition",
				ExtractAs = "Uses",
			},
		},
		FlavorText = "OlympianSpellCountBoon_FlavorText",
	},
})