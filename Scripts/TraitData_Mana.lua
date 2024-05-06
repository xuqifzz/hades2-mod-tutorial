OverwriteTableKeys( TraitData, {
	-- ManaTrait	
	ManaTrait =
	{
		--	Frame = "Hammer",
		Icon = "Boon_Chaos_01",
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,
			},
			Epic =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Heroic =
			{
				MinMultiplier = 2.5,
				MaxMultiplier = 2.5,
			},
			Legendary =
			{
				MinMultiplier = 3.0,
				MaxMultiplier = 3.0,
			},
		},
	},
	
	ManaOverTimeSource = 
	{
		ManaOverTimeSource = true,
	},

	ManaOverTimeTrait = 
	{
		InheritFrom = {"ManaTrait", "ManaOverTimeSource"},
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
		SetupFunction =
		{
			Name = "ManaRegenSetup",
			Args =
			{
				Name = "ManaOverTimeTrait",
				ManaRegenPerSecond = { BaseValue = 2 },
				ReportValues = { ReportedManaRecovery = "ManaRegenPerSecond" }
			},
			RunOnce = true
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		
		},
	},
	IdleManaOverTimeTrait = 
	{
		InheritFrom = {"ManaTrait", "ManaOverTimeSource"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.6,
			},
			Epic =
			{
				Multiplier = 2.2,
			},
			Heroic =
			{
				Multiplier = 2.8,
			},
		},
		SetupFunction =
		{
			Name = "IdleManaRegenSetup",
			Args =
			{
				ManaRegenPerSecond = { BaseValue = 5 },
				MovePenaltyDuration = 1,
				ReportValues = { ReportedManaRecovery = "ManaRegenPerSecond" }
			},
			RunOnce = true
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		}
	},

	ManaOnCastTrait = 
	{
		InheritFrom = {"ManaTrait"},
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
		OnWeaponFiredFunctions =
		{
			ValidWeapons = { "WeaponCast" },
			FunctionName = "CheckManaRefund",
			FunctionArgs = 
			{
				ManaGain = { BaseValue = 10 },
				Chance = 0.25,
				ReportValues = { ReportedManaGain = "ManaGain", ReportedChance = "Chance"}
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaGain",
				ExtractAs = "TooltipManaRecovery",
			},
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "Percent",
			},
		}
	},

	ManaOnPrimaryTrait = 
	{
		InheritFrom = {"ManaTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 3.0,
			},
			Rare =
			{
				Multiplier = 4.0,
			},
			Epic =
			{
				Multiplier = 5.0,
			},
			Heroic =
			{
				Multiplier = 6.0,
			},
		},
	
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckManaOnHit",
			Args = 
			{
				FirstHitOnly = true,
				ValidWeapons = WeaponSets.HeroPrimaryWeapons,
				ManaGain = { BaseValue = 1 },
				ReportValues = { ReportedManaRecovery = "ManaGain" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		}
	},
	
	ManaOnSecondaryTrait = 
	{
		InheritFrom = {"ManaTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 3.0,
			},
			Rare =
			{
				Multiplier = 4.0,
			},
			Epic =
			{
				Multiplier = 5.0,
			},
			Heroic =
			{
				Multiplier = 6.0,
			},
		},
	
		OnEnemyDamagedAction = 
		{
			FunctionName = "CheckManaOnHit",
			Args = 
			{
				FirstHitOnly = true,
				ValidWeapons = WeaponSets.HeroSecondaryWeapons,
				ManaGain = { BaseValue = 1 },
				ReportValues = { ReportedManaRecovery = "ManaGain" }
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		}
	},

	ManaDropOnKillTrait = 
	{
		InheritFrom = {"ManaTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
		DropOnKill = {
			RoomCap = 5,
			Chance = { BaseValue = 0.20 },
			Name = "ManaDropMinor",
			ReportValues = { ReportedDropChance = "Chance" }
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedDropChance",
				ExtractAs = "TooltipManaRecovery",
				Format = "Percent"
			},
			{
				External = true,
				BaseType = "ConsumableData",
				BaseName = "ManaDropMinor",
				BaseProperty = "AddMana",
				ExtractAs = "ManaDropRecovery",
				SkipAutoExtract = true,
			}
		}
	},
	
	ManaBonusTrait =
	{
		InheritFrom = { "ManaTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
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
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				BaseValue = 30,
				ChangeType = "Add",
				ReportValues = { ReportedManaBonus = "ChangeValue"}
			},
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedManaBonus",
				ExtractAs = "TooltipMana",
			},
		}
	},
	
	RevengeManaTrait =
	{
		InheritFrom = { "ManaTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.50,
			},
			Epic =
			{
				Multiplier = 2.00,
			},
			Heroic =
			{
				Multiplier = 2.50,
			},
		},	
		OnDamagedManaConversion = { BaseValue = 5 },
		
		ExtractValues =
		{
			{
				Key = "OnDamagedManaConversion",
				ExtractAs = "TooltipMana",
				Format = "Percent"
			},
		}
	},
})