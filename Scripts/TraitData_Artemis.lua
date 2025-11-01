OverwriteTableKeys( TraitData, {
	-- Artemis
	InsideCastCritBoon = 
	{
		Icon = "Boon_Artemis_30",
		InheritFrom = { "InPersonOlympianTrait", "EarthBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.3,
			},
			Epic =
			{
				Multiplier = 1.6,
			},
			Heroic =
			{
				Multiplier = 1.9,
			},
		},
		AddOutgoingCritModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimaryWeapons,
			Chance = { BaseValue = 0.10 },
			ValidActiveEffects = {"ImpactSlow"},
			ReportValues = { ReportedCritBonus = "Chance"},
		},
		StatLines =
		{
			"CriticalChanceDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonus",
				Format = "LuckModifiedPercent"
			},
		},
	},
	OmegaCastVolleyBoon = 
	{
		Icon = "Boon_Artemis_31",
		InheritFrom = { "InPersonOlympianTrait", "AirBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 60/50,
			},
			Epic =
			{
				Multiplier = 70/50,
			},
			Heroic =
			{
				Multiplier = 80/50,
			},
		},
		
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckCastVolley",
			ValidWeapons = {"WeaponCast"},
			Args = 
			{
				ProjectileName = "ArtemisCastVolley",
				ProjectileCap = 5,
				SpawnDistance = 2600,
				Delay = 0.04,
				DamageMultiplier = { BaseValue = 1.0 },
				ReportValues = 
				{ 
					ReportedCap = "ProjectileCap",
					ReportedMultiplier = "DamageMultiplier",
				}
			},
		},
	
		OnProjectileDeathFunction = 
		{
			Name = "RemoveCastVolleyProjectile",
		},
		StatLines =
		{
			"SupportFireDamageDisplay2",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ArtemisCastVolley",
				BaseProperty = "Damage",
			},
			{
				Key = "ReportedCap",
				ExtractAs = "Cap",
				SkipAutoExtract = true,
			},
		}
	},
	HighHealthCritBoon = 
	{
		Icon = "Boon_Artemis_29",
		InheritFrom = { "InPersonOlympianTrait", "EarthBoon" },
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
		AddOutgoingCritModifiers =
		{
			TargetHighHealthChance = { BaseValue = 0.15 },
			TargetHighHealthPercentThreshold = 0.8,
			ReportValues = 
			{ 
				ReportedCritBonus = "TargetHighHealthChance",
				ReportedThreshold = "TargetHighHealthPercentThreshold",
			},
		},
		StatLines =
		{
			"CriticalChanceDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonus",
				Format = "LuckModifiedPercent"
			},
			{
				Key = "ReportedThreshold",
				ExtractAs = "HealthThreshold",
				Format = "Percent",
				SkipAutoExtract = true
			},
		},
	},
	CritBonusBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "EarthBoon" },
		Icon = "Boon_Artemis_27",
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
			},
		},				

		AddOutgoingCritModifiers =
		{
			Chance = { BaseValue = 0.03 },
			ReportValues = { ReportedCritBonus = "Chance"}
		},

		StatLines =
		{
			"CriticalChanceDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonus",
				Format = "LuckModifiedPercent",
			},
		},
	},
	DashOmegaBuffBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Artemis_28",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
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
		OnSprintAction = 
		{
			FunctionName = "ApplyOmegaBuff",
			RunOnce = true,
			Args = 
			{
				EffectName = "OmegaDamageBuffEffect",
				EffectArgs = { 
					Modifier = { BaseValue = 0.10 },
					Duration = 2,
					ReportValues = 
					{
						ReportedDuration = "Duration",
						ReportedModifier = "Modifier",
					}
				}
			}
		},
		StatLines =
		{
			"DashOmegaDamageDisplay1",
		},
		
		ExtractValues = 
		{
			{
				Key = "ReportedModifier",
				ExtractAs = "DamageBonus",
				Format = "LuckModifiedPercent",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
		},
	},
	SupportingFireBoon =
	{
		InheritFrom = { "BaseTrait", "LegacyTrait", "AirBoon" },
		Icon = "Boon_Artemis_32",
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
			FunctionName = "CheckSupportingFire",
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,	
			Args = 
			{
				ProjectileName = "ArtemisSupportingFire",
				DamageMultiplier = { BaseValue = 1.0 },
				Cooldown = 0.167,
				--FizzleOldestProjectileCount = 2,
				ProjectileCap = 3,
				StartAngle = 180,
				Scatter = 20,
				MultihitProjectileWhitelist = 
				{
					"ProjectileStaffSingle",
				},
				MultihitProjectileConditions = 
				{
					ProjectileStaffSingle = { Window = 0.25, Count = 3, },
				},
				ReportValues = 
				{ 
					ReportedMultiplier = "DamageMultiplier",
				}
			},
		},
	
		StatLines =
		{
			"SupportFireDamageDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "ArtemisSupportingFire",
				BaseProperty = "Damage",
			},
		}
	},
	TimedCritVulnerabilityBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Artemis_33",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
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
			},
		},		
		OnEnemyCrittedFunction =
		{
			Name = "MarkRandomNearby",
			Args = { Range = 1200 }
		},
		
		SetupFunction =
		{
			Name = "PeriodicMark",
			Threaded = true,
			Args =
			{
				StartDelay = 3,
				Interval = { BaseValue = 20 },
				ReportValues = 
				{ 
					ReportedInterval = "Interval",
				}
			},
		},
	
		StatLines =
		{
			"MarkIntervalStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				Format = "SpeedModifiedDuration",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "ArtemisBoonHuntersMark",
				BaseProperty = "Duration",
				ExtractAs = "TooltipMarkDuration",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "ArtemisBoonHuntersMark",
				BaseProperty = "CritVulnerability",
				ExtractAs = "CritRate",
				Format = "Percent",
				SkipAutoExtract = true,
			}
		}
	},
	FocusCritBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Artemis_34",
		BlockStacking = true,
		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
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
		SetupFunction =
		{
			Name = "TraitReserveMana",
			Args =
			{
				Name = "FocusSpecialCritChance",
				ManaReservationCost = 40,
				ReportValues = 
				{ 
					ReportedCost = "ManaReservationCost",
				}
			},
		},
		OnExpire = 
		{
			FunctionName = "TraitUnreserveMana",
			FunctionArgs = { Name = "FocusSpecialCritChance" },
		},
		AddOutgoingCritModifiers =
		{
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			Chance = { BaseValue = 0.10 },
			ReportValues = { ReportedCritBonus = "Chance"},
		},
		StatLines =
		{
			"CriticalSpecialsChanceDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonus",
				Format = "LuckModifiedPercent",
				IncludeSigns = true,
			},
			{
				Key = "ReportedCost",
				ExtractAs = "TooltipCost",
				SkipAutoExtract = true,
			},
		}
	},
	SorceryCritBoon = 
	{
		InheritFrom = { "AirBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 0.35/0.3,
			},
			Epic =
			{
				Multiplier = 0.4/0.3,
			},
			Heroic =
			{
				Multiplier = 0.45/0.3,
			},
		},
		Icon = "Boon_Artemis_35",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = 
				{
					"SpellLaserTrait",
					"SpellLeapTrait",
					"SpellSummonTrait",
					"SpellMeteorTrait",
					"SpellTransformTrait",
					"SpellMoonBeamTrait",
					"SpellPolymorphTrait"
				},
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGrantsReward01" },
			},
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisGrantsReward01" },
			},
		},
		FirstTimeEntranceAnimation = "BoonEntranceNew",
		PriorityRequirements =
		{
			{
				PathFalse = { "GameState", "TraitsSeen", "SorceryCritBoon" },
			},
		},
		AllyDataModifiers = 
		{			
			OutgoingCritModifiers =
			{
				{
					Chance = {BaseValue = 0.3},
				},
			},
		},
		AddOutgoingCritModifiers =
		{
			-- Match this to above ally data modifier too!
			ValidProjectiles = WeaponSets.SpellProjectileNames,
			Chance = {BaseValue = 0.3},
			ReportValues = { ReportedChance = "Chance"},
		},
		StatLines = 
		{
			"SorceryCritChanceDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "LuckModifiedPercent",
			},
		},
		FlavorText = "SorceryCritBoon_FlavorText",
	},
})