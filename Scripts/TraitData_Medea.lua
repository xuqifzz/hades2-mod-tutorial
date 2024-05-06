OverwriteTableKeys( TraitData, {
	-- Medea
	BaseCurse = 
	{
		IsCurse = true,
	},
	HealingOnDeathCurse = 
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Chaos_01",
		DropOnKill = {
			Chance = { BaseValue = 0.05 },
			DropCap = 1,
			Name = "HealDropMinor",
			ReportValues = 
			{ 
				ReportedDropRate = "Chance",
				ReportedCap = "DropCap",
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedDropRate",
				ExtractAs = "TooltipDropChance",
				Format = "Percent"
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
				ExtractAs = "Heal",
				SkipAutoExtract = true,
			}
		}
	},
	MoneyOnDeathCurse = 
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Chaos_02",
		DropOnKill = {
			Chance = { BaseValue = 0.10 },
			DropCap = 2,
			Name = "RoomMoneyTinyDrop",
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
				Format = "Percent"
			},
			{
				Key = "ReportedDropCount",
				ExtractAs = "TooltipDropCount",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "ConsumableData",
				BaseName = "RoomMoneyTinyDrop",
				BaseProperty = "DropMoney",
				ExtractAs = "Money",
				SkipAutoExtract = true,
			}
		}
	},
	ManaOverTimeCurse = 
	{
		InheritFrom = {"BaseCurse"},
		Icon = "Boon_Chaos_03",
		
		RoomsPerUpgrade = 
		{ 
			Amount = 1,
			MaxMana = 10,
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
		Icon = "Boon_Chaos_04",
		OnEnemySpawnFunction =
		{
			FunctionName = "CheckSpawnCurseDamage",
			Args = 
			{
				Vfx = "ThanatosDeathsHead_Small",
				DamageArgs =
				{
					-- Rolls chances from top down
					{
						Chance = 0.005,
						MinDamage = 999,
						MaxDamage = 999,
						ReportValues = 
						{ 
							ReportedMax = "MaxDamage", 
						}
					},
					{
						Chance = 0.01,
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
		Icon = "Boon_Chaos_05",
		
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
		Icon = "Boon_Chaos_06",
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
		Icon = "Boon_Chaos_07",
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
})