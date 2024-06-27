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
				Format = "Percent"
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
				Multiplier = 40/30,
			},
			Epic =
			{
				Multiplier = 50/30,
			},
			Heroic =
			{
				Multiplier = 60/30,
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
				Format = "Percent"
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
				Format = "Percent",
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
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 1.75,
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
					Modifier = { BaseValue = 1.20, SourceIsMultiplier = true},
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
				Format = "PercentDelta",
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
			FirstHitOnly = true,
			Args = 
			{
				ProjectileName = "ArtemisSupportingFire",
				DamageMultiplier = { BaseValue = 1.0 },
				Cooldown = 0.167,
				--FizzleOldestProjectileCount = 2,
				ProjectileCap = 3,
				StartAngle = 180,
				Scatter = 20,
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
})