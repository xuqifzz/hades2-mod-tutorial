TraitSetData.MetaUpgrade =
{

	-- Base MetaUpgradeTraits
	MetaUpgradeTrait = 
	{
		MetaUpgrade = true,
		Hidden = true,
		Icon = "Membership_Card",
		DebugOnly = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 2
			},
			Epic =
			{
				Multiplier = 3
			},
			Heroic =
			{
				Multiplier = 4
			},
		},
	},

	ChannelSlowMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{

			Common =
			{
				Multiplier = 20/20,
			},
			Rare =
			{
				Multiplier = 25/20,
			},
			Epic =
			{
				Multiplier = 30/20,
			},
			Heroic =
			{
				Multiplier = 35/20,
			},
		},
		
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroAllWeaponsAndSprint,
			Value = 
			{
				BaseValue = 0.80,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponStaffSwing5", "WeaponDagger5", "WeaponLobChargedPulse", "WeaponCastArm", "WeaponAxeSpecialSwing" },
				BaseValue = 0.8,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ExcludeLinked = true,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		}
	},
	ManaOverTimeMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait", "ManaOverTimeSource"},
		CustomTrayText = "ManaOverTimeMetaUpgrade_Tray",
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
		SetupFunction =
		{
			Name = "ManaRegenSetup",
			Args =
			{
				Name = "ManaOverTimeMetaUpgrade",
				ManaRegenPerSecond = { BaseValue = 6 },
				ReportValues = { ReportedManaRecovery = "ManaRegenPerSecond" }
			},
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

	DoorHealMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "DoorHealMetaUpgrade_Tray",
		DoorHealThreshold = 
		{
			FixedHeal = { BaseValue = 3 },
			ReportValues = 
			{
				Heal = "FixedHeal",
			}
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.34
			},
			Epic =
			{
				Multiplier = 1.67
			},
			Heroic =
			{
				Multiplier = 2.0
			},
		},
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
				Key = "Heal",
				ExtractAs = "TooltipHealthRecovery",
				Format = "FlatHeal",
			},
		},
	},
	InsideCastBuffMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.25
			},
			Epic =
			{
				Multiplier = 1.5
			},
			Heroic =
			{
				Multiplier = 1.75
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeaponMultiplier = { BaseValue = 1.2, SourceIsMultiplier = true },
			ValidActiveEffects = {"ImpactSlow"},
			ReportValues = { ReportedModifier = "ValidWeaponMultiplier" }
		},
		ExtractValues =
		{
			{
				Key = "ReportedModifier",
				ExtractAs = "TooltipMultiplier",
				Format = "PercentDelta"
			},
		},

	},

	LowManaDamageMetaupgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "LowManaDamageMetaupgrade_Tray",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0.6,
			},
			Rare =
			{
				Multiplier = 0.8,
			},
			Epic =
			{
				Multiplier = 1.0,
			},
			Heroic =
			{
				Multiplier = 1.2,
			},
		},
		
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			LowManaThreshold = 0.99,
			-- next line used for trait text
			FullManaThreshold = 100,
			NonExLowManaDamageMultiplier = 
			{
				BaseValue = 1.5,
				SourceIsMultiplier = true,
			},
			ReportValues = 
			{ 
				ReportedThreshold = "LowManaThreshold",
				ReportedDamageBoost = "NonExLowManaDamageMultiplier",
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "DamageBoost",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedThreshold",
				ExtractAs = "ManaThreshold",
				Format = "Percent",
				SkipAutoExtract = true,
			},
		}
	},

	StartingGoldMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait"},

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.25
			},
			Epic =
			{
				Multiplier = 1.5
			},
			Heroic =
			{
				Multiplier = 1.75
			},
		},

		BonusMoney = { BaseValue = 200 },
		
		ExtractValues = 
		{
			{
				Key = "BonusMoney",
				ExtractAs = "StartingGold",
				IncludeSigns = true,
			},
		}
	},

	SprintShieldMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "SprintShieldMetaUpgrade_Tray",
		--SprintShields = 1,
		--ActiveVfx = "EurydiceDefenseFront",

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 7/5
			},
			Epic =
			{
				Multiplier = 10/5
			},
			Heroic =
			{
				Multiplier = 13/5
			},
		},

		OnSprintStartAction = 
		{
			FunctionName = "StartSprintPhasing",
			Args = 
			{
				EffectName = "SprintStasisEffect",
				--Interrupt = true,
				--InterruptProjectile = "ProjectileSprintStrike",
				Range = 120,
				ScaleY = 0.6,
				Cooldown = 0.5,
			}
		},
		
		OnSprintEndAction = 
		{
			FunctionName = "EndSprintPhasing",
		},
		OnBlinkEndAction = 
		{
			FunctionName = "EndSprintPhasing",
			FunctionArgs = { CheckSprint = true },
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponSprint"},
				WeaponProperty = "SelfVelocity",
				BaseValue = 99,
				ChangeType = "Add",
				ExcludeLinked = true,
				ReportValues = { ReportedBaseSpeed = "ChangeValue" },
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				BaseValue = 44.5,
				ChangeType = "Add",
				ExcludeLinked = true,
			},

			{
				WeaponName = "WeaponSprint",
				EffectName = "SprintMetaUpgradeAddedControl",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "SprintSpeed",
				Format = "PercentOfBase",
				BaseType = "Weapon",
				BaseName = "WeaponSprint",
				BaseProperty = "SelfVelocity",
				DecimalPlaces = 1,
				HideSigns = true,
			},
			--[[
			{
				Key = "SprintShields",
				ExtractAs = "ShieldNum",
				SkipAutoExtract = true,
			}
			]]
		}
	},

	BossShieldMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "ChanneledBlock_Tray",
		BossEncounterShieldHits = { BaseValue = 1 },
		BossShieldFx = "MelShieldFront",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 2
			},
			Epic =
			{
				Multiplier = 3
			},
			Heroic =
			{
				Multiplier = 4
			},
		},

		ExtractValues = 
		{
			{
				Key = "BossEncounterShieldHits",
				ExtractAs = "ShieldNum",
			}
		}
	},
	LastStandSlowTimeMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "LastStand_Tray",
		AddMetaUpgradeLastStands = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "AddMetaUpgradeLastStands",
				ExtractAs = "ReportedLastStands",
				IncludeSigns = true,
			},
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Duration",
				ExtractAs = "LastStandDuration",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "HeroData",
				BaseName = "LastStandData",
				BaseProperty = "Modifier",
				Format = "NegativePercentDelta",
				ExtractAs = "LastStandSlow",
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
	CastDamageMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "CastCount_Tray",
		RarityLevels =
		{

			Common =
			{
				Multiplier = 0.8
			},
			Rare =
			{
				Multiplier = 1.0
			},
			Epic =
			{
				Multiplier = 1.2
			},
			Heroic =
			{
				Multiplier = 1.4
			},
		},
		
		OnWeaponChargeFunctions =
		{
			ValidWeapons = { "WeaponStaffSwing5", "WeaponDagger5", "WeaponStaffBall", "WeaponDaggerThrow", "WeaponAxeSpecialSwing", "WeaponAxeSpin", "WeaponTorch", "WeaponTorchSpecial", "WeaponLob", "WeaponLobSpecial", "WeaponCastArm", "WeaponCastProjectileHades", "WeaponCastProjectile", "WeaponAnywhereCast", "WeaponCastLob", "WeaponSuitCharged", "WeaponSuitRanged"},
			FunctionName = "CheckWeaponCastChannelSlow",
			FunctionArgs =
			{
				Modifier = 0.6,
				Duration = { BaseValue = 1.0 },
				ReportValues = { ReportedSlow = "Modifier", ReportedSlowDuration = "Duration" }
			},
			ExcludeLinked = true,
		},
		ExtractValues =
		{
			{
				Key = "ReportedSlow",
				ExtractAs = "TooltipSlow",
				Format = "NegativePercentDelta",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedSlowDuration",
				ExtractAs = "TooltipSlowDuration",
				DecimalPlaces = 1,
			},
		},
	},
	 
	MagicCritMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0.9,
			},
			Rare =
			{
				Multiplier = 1.2,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic = 
			{
				Multiplier = 1.8,
			}
		},
		CustomTrayText = "MagicCritMetaUpgrade_Tray",
		AddOutgoingCritModifiers =
		{
			IsEx = true,
			DifferentOmegaChance = { BaseValue = 0.10 },
			ReportValues = { ReportedCritBonus = "DifferentOmegaChance"}
		},
		OnProjectileDeathFunction = 
		{
			Name = "RemoveOmegaCritVolley",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = WeaponSets.HeroAllWeaponsAndSprint,
			FunctionName = "CheckDifferentOmegaCrit",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCritBonus",
				ExtractAs = "CritBonusAmount",
				Format = "LuckModifiedPercent",
			},
		}
	},

	--[[
	CastProtectionMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CastModifier = true,
		PropertyChanges =
		{
			{
				WeaponName = "WeaponCast",
				EffectName = "CastInvulnerable",
				EffectProperty = "Active",
				ChangeValue = true,
			},
			{
				WeaponName = "WeaponCast",
				EffectName = "CastInvulnerable",
				EffectProperty = "Duration",
				BaseValue = 0.5,
				ChangeType = "Absolute",
				ReportValues = { ReportedTime = "ChangeValue" },
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedTime",
				ExtractAs = "ShieldTime",
				DecimalPlaces = 1,
			},
		}
	},
	]]
	
	ChamberHealthMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "MaxHealthPerRoom_Tray",
		PriorityDisplay = true,
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 4/3,
			},
			Epic =
			{
				Multiplier = 5/3,
			},
			Heroic = 
			{
				Multiplier = 2,
			}
		},
		SetupFunction = 
		{
			RequiredContext = "EnterRoom",
			Threaded = true,
			Name = "RoomStatGrowth",
			Args = 
			{
				Amount = 5,
				MaxHealth =  { BaseValue = 3 },
				MaxMana = { BaseValue = 3 },
				ReportValues = 
				{ 
					ReportedGrowth = "MaxHealth", 
					BonusAmount = "Amount",
				},

			}
		},
		CurrentRoom = 0,
		ExtractValues = 
		{
			{
				Key = "ReportedGrowth",
				ExtractAs = "GrowthValue",
				IncludeSigns = true,
			},
			{
				Key = "BonusAmount",
				ExtractAs = "RoomInterval",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "MetaUpgradeRequirement",
				BaseName = "MaxHealthPerRoom",
				BaseProperty = "HasCostsThrough",
				ExtractAs = "Requirement",
				SkipAutoExtract = true,
			},
		},
	},

	DoorRerollMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "DoorReroll_Tray",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 2
			},
			Epic =
			{
				Multiplier = 3
			},
			Heroic =
			{
				Multiplier = 4
			},
		},
		RerollCount = { BaseValue = 1 },
		AllowDoorReroll = true,
		ExtractValues = 
		{
			{
				Key = "RerollCount",
				ExtractAs = "Rerolls",
				IncludeSigns = true,
			}
		},
	},
	PanelRerollMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "ScreenReroll_Tray",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 2
			},
			Epic =
			{
				Multiplier = 3
			},
			Heroic =
			{
				Multiplier = 4
			},
		},
		RerollCount = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "RerollCount",
				ExtractAs = "Rerolls",
				IncludeSigns = true,
			}
		},
	},
	RerollTradeOffMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		RerollCount = { BaseValue = 2 },
		--[[
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				ChangeValue = -15,
				ChangeType = "Add",
				ReportValues = { ReportedHealthPenalty = "ChangeValue"}
			},
			{
				LuaProperty = "MaxMana",
				ChangeValue = -15,
				ChangeType = "Add",
				ReportValues = { ReportedManaPenalty = "ChangeValue"}
			},
		},
		]]
		ExtractValues = 
		{
			{
				Key = "RerollCount",
				ExtractAs = "Rerolls",
				IncludeSigns = true,
			},
			--[[
			{
				Key = "ReportedManaPenalty",
				ExtractAs = "ManaPenalty",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedHealthPenalty",
				ExtractAs = "HealthPenalty",
				SkipAutoExtract = true,
			},
			]]
		},
	},

	RarityBoostMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
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
			}
		},
		CustomTrayText = "RarityBoostMetaUpgrade_Tray",
		RarityBonus =
		{
			Rare = { BaseValue = 0.30 },
			--Epic = { BaseValue = 0.20 },
			--Duo = { BaseValue = 0.50 },
			--Legendary = { BaseValue = 0.50 },
			ReportValues = { ReportedRarityBonus = "Rare"}			
		},
		MultiplicativeRarityBonus = 
		{
			Legendary = { BaseValue = 1.3, SourceIsMultiplier = true }
		},
		ExtractValues = 
		{
			{
				Key = "ReportedRarityBonus",
				ExtractAs = "RarityBonus",
				Format = "Percent",
			},
		}
	},
	DuoRarityBoostMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "DuoRarityBoostMetaUpgrade_Tray",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00
			},
			Rare =
			{
				Multiplier = 1.34
			},
			Epic =
			{
				Multiplier = 1.67
			},
			Heroic =
			{
				Multiplier = 2.00
			},
		},
		RarityBonus =
		{
			Duo = { BaseValue = 0.06 },
			ReportValues = { ReportedRarityBonus = "Duo"}			
		},
		ExtractValues = 
		{
			{
				Key = "ReportedRarityBonus",
				ExtractAs = "RarityBonus",
				Format = "Percent",
			},
		}
	},
	EpicRarityBoostMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "EpicRarityBoostMetaUpgrade_Tray",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0
			},
			Rare =
			{
				Multiplier = 2.0
			},
			Epic =
			{
				Multiplier = 3.0
			},
			Heroic =
			{
				Multiplier = 4.0
			},
		},
		RarityBonus =
		{
			Epic = { BaseValue = 0.05 },
			ReportValues = { ReportedRarityBonus = "Epic"}			
		},
		ExtractValues = 
		{
			{
				Key = "ReportedRarityBonus",
				ExtractAs = "RarityBonus",
				Format = "Percent",
			},
		}
	},
	
	DodgeBonusMetaUpgrade =
	{
		PreEquipWeapons = { "WeaponCastBlink"},
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00
			},
			Rare =
			{
				Multiplier = 1.20
			},
			Epic =
			{
				Multiplier = 1.40,
			},
			Heroic =
			{
				Multiplier = 1.60,
			},
		},
		CustomTrayText = "BonusDodgeMetaUpgrade_Tray",
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponCast",
				EffectName = "WeaponCastSelfSlow",
				EffectProperty = "Active",
				ChangeValue = false,
			}
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = { "WeaponCastProjectileHades", "WeaponAnywhereCast", "WeaponCastProjectile", "WeaponCastLob" },
			FunctionName = "CheckChargeCastBuffs"
		},
		CastInvulnerableDuration = 0.3,
		CastChargeBuffDuration = 0.55,
		CastChargeGripDuration = 0.8, 
		CastChargeSpeedMultiplier = { BaseValue = 1.5, SourceIsMultiplier = true },
		
		ExtractValues = 
		{
			{
				Key = "CastChargeSpeedMultiplier",
				ExtractAs = "SpeedBoost",
				Format = "PercentDelta",
				HideSigns = true,
			},
			{
				Key = "CastChargeBuffDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			}
		}
	},

	HealthManaBonusMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 20,
				ChangeType = "Add",
				ReportValues = { ReportedHealthBonus = "ChangeValue"}
			},
			{
				LuaProperty = "MaxMana",
				BaseValue = 20,
				ChangeType = "Add",
				ReportValues = { ReportedManaBonus = "ChangeValue"}
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedManaBonus",
				ExtractAs = "ManaBonus",
				IncludeSigns = true,
			},
			{
				Key = "ReportedHealthBonus",
				ExtractAs = "HealthBonus",
				IncludeSigns = true,
			},
			--[[
			{
				External = true,
				BaseType = "MetaUpgradeRequirement",
				BaseName = "BonusHealth",
				BaseProperty = "HasCostsThrough",
				ExtractAs = "Requirement",
				SkipAutoExtract = true,
			},
			]]
		},
	},
	
	EffectVulnerabilityMetaUpgrade =
	{
		InheritFrom = { "MetaUpgradeTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
		},
		CustomTrayText = "EffectVulnerabilityMetaUpgrade_Tray",

		AddOutgoingDamageModifiers =
		{
			MinRequiredVulnerabilityEffects = 2,
			VulnerabilityMultiplier = 
			{
				BaseValue = 1.25,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedDamageBoost = "VulnerabilityMultiplier"},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedDamageBoost",
				ExtractAs = "DamageBoost",
				Format = "PercentDelta",
			},
		}
	},

	SorceryRegenMetaUpgrade = 
	{
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
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
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "SorceryRegenMetaUpgrade_Tray",
		SetupFunction =
		{
			Threaded = true,
			Name = "SorceryChargeSetup",
			Args =
			{
				Name = "MetaUpgrade",
				ChargePerSecond = { BaseValue = 1 },
				ReportValues = { ReportedCharge = "ChargePerSecond" }
			},
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCharge",
				ExtractAs = "ChargePerSecond"
			}
		},
	},

	LowHealthBuffMetaUpgrade = 
	{
		InheritFrom = { "MetaUpgradeTrait" },
		CustomTrayText = "LowHealthBuffMetaUpgrade_Tray",
		ShowLastStandWarning = true,
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
		CustomUpgradeText = "LowHealthBonus_Upgrade",
		AddIncomingDamageModifiers = 
		{
			HealthOnly = true,
			NoLastStandDamageTakenMultiplier = { BaseValue = 0.7, SourceIsMultiplier = true },
			ReportValues = 
			{ 
				ReportedLowHealthResistance = "NoLastStandDamageTakenMultiplier",
			}

		},
		AddOutgoingDamageModifiers = 
		{
			NoLastStandDamageOutputMultiplier = 1.20,
			ReportValues = { ReportedModifier = "NoLastStandDamageOutputMultiplier" }
		},
		ExtractValues = 
		{
			{
				Key = "ReportedModifier",
				ExtractAs = "EnhanceMultiplier",
				Format = "FlatPercentDelta",
			},
			{
				Key = "ReportedLowHealthResistance",
				ExtractAs = "BlockMultiplier",
				Format = "FlatPercentDelta",
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
		},
	},
	MetaToRunMetaUpgrade = 
	{
		InheritFrom = {"MetaUpgradeTrait" },
		CustomTrayText = "MetaToRunMetaUpgrade_Tray",
		MetaConversionUses = { BaseValue = 1 },
		ExtractValues = 
		{
			{
				Key = "MetaConversionUses",
				ExtractAs = "MetaConversionUse",
			}
		},
	},
	BossProgressionMetaUpgrade = 
	{
		InheritFrom = {"MetaUpgradeTrait" },
		CustomTrayText = "BossProgressionMetaUpgrade_Tray",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 4/3,
			},
			Epic =
			{
				Multiplier = 5/3,
			},
			Heroic = 
			{
				Multiplier = 2,
			}
		},
		PostBossCards = { BaseValue = 3 },
		ExtractValues = 
		{
			{
				Key = "PostBossCards",
				ExtractAs = "CardNum",
			}
		},
	},
}


OverwriteTableKeys( TraitData, TraitSetData.MetaUpgrade )