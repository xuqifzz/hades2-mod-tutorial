OverwriteTableKeys( TraitData, {
	-- Medea
	BaseCurse = 
	{
		IsCurse = true,
		DebugOnly = true,
	},
	HealingOnDeathCurse = 
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Medea_03",
		DropOnKill = {
			Chance = { BaseValue = 0.2 },
			DropCap = 1,
			Name = "HealDropMinor",
			ReportValues = 
			{ 
				ReportedDropRate = "Chance",
				ReportedCap = "DropCap",
			},
		},
		StatLines = {},
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
				Key = "ReportedDropRate",
				ExtractAs = "TooltipDropChance",
				Format = "LuckModifiedPercent"
			},
			{
				Key = "ReportedCap",
				ExtractAs = "TooltipDropCap",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "ConsumableData",
				BaseName = "HealDropMinor",
				BaseProperty = "HealFixed",
				Format = "FlatHeal",
				ExtractAs = "Heal",
				SkipAutoExtract = true,
			}
		}
	},
	MoneyOnDeathCurse = 
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Medea_05",
		DropOnKill = {
			Chance = { BaseValue = 0.10 },
			DropCap = 2,
			Name = "MedeaMoneyTinyDrop",
			ReportValues = 
			{ 
				ReportedDropRate = "Chance",
				ReportedDropCount = "DropCap",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDropRate",
				ExtractAs = "TooltipDropChance",
				Format = "LuckModifiedPercent"
			},
			{
				Key = "ReportedDropCount",
				ExtractAs = "TooltipDropCount",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "ConsumableData",
				BaseName = "MedeaMoneyTinyDrop",
				BaseProperty = "DropMoney",
				ExtractAs = "Money",
				SkipAutoExtract = true,
			}
		}
	},
	ManaOverTimeCurse = 
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Medea_04",
		
		RoomsPerUpgrade = 
		{ 
			Amount = 1,
			MaxMana = 5,
			ReportValues = 
			{ 
				ReportedGrowth = "MaxMana", 
			},

		},
		CurrentRoom = 0,
		ExtractValues = 
		{
			{
				Key = "ReportedGrowth",
				ExtractAs = "GrowthValue",
				IncludeSigns = true,
			},
		},
	},
	SpawnDamageCurse = 
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Medea_07",
		OnEnemySpawnFunction =
		{
			FunctionName = "CheckSpawnCurseDamage",
			Args = 
			{
				Vfx = "ThanatosDeathsHead_Small",
				SkipOnDamagedPowers = true,
				DamageArgs =
				{
					-- Rolls chances from top down
					{
						Chance = 0.04,
						MinDamage = 999,
						MaxDamage = 999,
						ReportValues = 
						{ 
							ReportedMax = "MaxDamage", 
						}
					},
					{
						Chance = 0.08,
						MinDamage = 100,
						MaxDamage = 998,
					},
					{
						MinDamage = 1,
						MaxDamage = 99,
						ReportValues = 
						{ 
							ReportedMin = "MinDamage", 
						}
					}
				}
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMin",
				ExtractAs = "Min",
			},
			{
				Key = "ReportedMax",
				ExtractAs = "Max",
			},
		}
	},
	ArmorPenaltyCurse = 
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Medea_01",
		
		OnEnemySpawnFunction =
		{
			FunctionName = "CheckSpawnArmorDamage",
			Args = 
			{
				Vfx = "ThanatosDeathsHead_Small",
				Multiplier = 0.5,
				ReportValues = 
				{ 
					ReportedMultiplier = "Multiplier",
				}
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Multiplier",
				Format = "Percent"
			},
		}
	},
	SlowProjectileCurse =
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Medea_06",
		EnemyProjectileSpeedMultiplier = 0.60,
		ExtractValues = 
		{
			{
				Key = "EnemyProjectileSpeedMultiplier",
				ExtractAs = "Multiplier",
				Format = "NegativePercentDelta"
			},
		}
	},
	DeathDefianceRetaliateCurse =
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Medea_02",
		OnLastStandFunction = 
		{
			Name = "CurseRetaliate",
			FunctionArgs = 
			{
				HealthDamageMultiplier = 0.15,
				Vfx = "ThanatosDeathsHead_Small",
				ReportValues = { ReportedMultiplier = "HealthDamageMultiplier"},
			}
		},
		ExtractValues = 
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "HealthThreshold",
				Format = "Percent"
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
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Duration",
				ExtractAs = "LastStandDuration",
				SkipAutoExtract = true,
			},
		}
	},
	NewStatusDamage = 
	{
		InheritFrom = { "BaseCurse"},
		Icon = "Boon_Medea_08",
		ShowInHUD = true,
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaAboutConcoctionQuestComplete01" },
			},
		},

		OnEffectApplyFunction = 
		{
			FunctionName = "CheckNewStatusDamage",
			FunctionArgs = 
			{
				ProjectileName = "MedeaStatusStrike",
				Cooldown = 1,
				ReportValues = { ReportedInterval = "Cooldown" }
			},
		},
		
		ExtractValues = 
		{
			{
				Key = "ReportedInterval",
				ExtractAs = "Interval",
				SkipAutoExtract = true,
			},
			{
				ExtractAs = "Damage",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MedeaStatusStrike",
				BaseProperty = "Damage",
			},
		},
		FlavorText = "NewStatusDamage_FlavorText",
	}
})