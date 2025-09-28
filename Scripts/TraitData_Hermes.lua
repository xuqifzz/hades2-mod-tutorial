OverwriteTableKeys( TraitData, {
	-- Hermes
	HermesWeaponBoon =
	{
		Icon = "Boon_Hermes_40",
		InheritFrom = { "BaseTrait", "LegacyTrait", "EarthBoon" },
		ApplyAfterHammerTraits = true,
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
		PropertyChanges = {
			{
				WeaponNames = WeaponSets.HeroNonExWeapons,
				WeaponProperty = "FireFx2",
				ChangeValue = "HermesSwipeLineC_Sword3",
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = WeaponSets.HeroNonExWeapons,
				BaseValue = 0.9,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ExcludeLinked = true,
				ReportValues = { ReportedWeaponMultiplier = "ChangeValue" }
			},
		},
		StatLines =
		{
			"NonOmegaSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "NegativePercentDelta",
			},
		}
	},
	HermesSpecialBoon =
	{
		Icon = "Boon_Hermes_35",
		InheritFrom = { "BaseTrait", "LegacyTrait", "EarthBoon" },
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
				Multiplier = 2.0,
			},
		},
		
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroAllWeaponsAndSprint,
			Value = 
			{
				BaseValue = 0.85,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponStaffSwing5", "WeaponDagger5", "WeaponLobChargedPulse", "WeaponCastArm", "WeaponAxeSpecialSwing" },
				BaseValue = 0.9,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ExcludeLinked = true,
			},
		},
		StatLines =
		{
			"OmegaSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedWeaponMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "NegativePercentDelta",
			},
		}
	},
	SlowProjectileBoon = 
	{
		InheritFrom = { "AirBoon" },
		Icon = "Boon_Hermes_41",
		
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
				Multiplier = 6/3,
			}
		},	
		EnemyProjectileSpeedMultiplier = { BaseValue = 0.7, SourceIsMultiplier = true },
		
		StatLines =
		{
			"SlowProjectileStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "EnemyProjectileSpeedMultiplier",
				ExtractAs = "TooltipDodgeBonus",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		}
	},
	MoneyMultiplierBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
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
			}
		},	
		Icon = "Boon_Hermes_33",
		CustomTrayText = "MoneyMultiplierBoon_Tray",
		MoneyMultiplier = { BaseValue = 1.2, 
				SourceIsMultiplier = true},
		
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements = 
		{					
			{
				Path = { "CurrentRun", "CurrentRoom" },
				HasNone = { "BlockGiftBoons" },
			},
		},
		AcquireFunctionName = "GiveRandomConsumables",
		AcquireFunctionArgs =
		{ 
			Delay = 0.2,
			NotRequiredPickup = true,
			ForceToValidLocation = true,
			KeepCollision = true,
			LootOptions =
			{
				{
					Name = "RoomMoneyDrop",
				},
			}
		},
		StatLines =
		{
			"MoneyMultiplierStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "MoneyMultiplier",
				ExtractAs = "TooltipCashBonus",
				Format = "PercentDelta",
			},
		}
	},
	DodgeChanceBoon =
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Hermes_37",
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
			}
		},
		CallSetupOnTraitAdded = true,
		SetupFunction = 
		{
			Name = "MultipliedSpeedDodgeSetup",
			Args =
			{
				SpeedDodgePerBoon = 
				{
					BaseValue = 0.005,
					DecimalPlaces = 4,
				}, 
				ReportValues = { ReportedDodgeChance = "SpeedDodgePerBoon" ,}
			},
		},
		StatLines =
		{
			"MultipliedEvasionStatDisplay1",
		},
		TrayStatLines =
		{
			"MultipliedEvasionStatDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDodgeChance",
				ExtractAs = "TooltipDodgeBonus",
				Format = "Percent",
				DecimalPlaces = 2,
				SkipAutoExtract = true
			},
			{
				Key = "ReportedDodgeChance",
				ExtractAs = "TooltipTotalDodgeBonus",
				Format = "Percent",
				MultiplyByOlympianBoonCount = true,
				DecimalPlaces = 2,
			},
		}
	},
	HermesCastDiscountBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hermes_31",
		CastModifier = true,
		BlockStacking = true,
		RarityLevels =
		{
			-- change the 225/250/275 number to be the percent increase at each rarity
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = (1-(100/225))/0.50,
			},
			Epic =
			{
				Multiplier = (1-(100/250))/0.50,
			},
			Heroic =
			{
				Multiplier = (1-(100/275))/0.50,
			}
		},
		WeaponDataOverride = 
		{
			WeaponCastArm = 
			{
				MinWeaponChargeTime = 0
			}
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroRangedWeapons,
			Value = 
			{
				BaseValue = 0.5,
				DecimalPlaces = 4,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedSpeedMultiplier = "Value" }
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "FuseStart",
				BaseValue = 0.50,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				DeriveSource = "DeriveSource",
			},
			{
				WeaponName = "WeaponCastArm",
				WeaponProperty = "ChargeTime",
				DeriveValueFrom = "DeriveSource",
			},
			{
				WeaponName = "WeaponCast",
				ProjectileProperty = "Fuse",
				DeriveValueFrom = "DeriveSource",
			},
		},
		StatLines =
		{
			"CastSpeedStatDisplay1",
		},
		ExtractValues = 
		{
			{
				Key = "ReportedSpeedMultiplier",
				ExtractAs = "Speed",
				Format = "PercentReciprocalDelta",
			},
			--[[
			{
				Key = "ReportedBonus",
				ExtractAs = "BonusCasts",
				SkipAutoExtract = true,
			},
			]]
		}
	},
	SorcerySpeedBoon = 
	{
		InheritFrom = { "BaseTrait", "EarthBoon" },
		Icon = "Boon_Hermes_28",
		BoonInfoIgnoreRequirements = true,

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.00,
			},
			Rare =
			{
				Multiplier = 1.15384,
			},
			Epic =
			{
				Multiplier = 1.2962,
			},
			Heroic =
			{
				Multiplier = 1.425000,
			}
		},
		PropertyChanges =
		{
			{
				WeaponNames = WeaponSets.HeroBlinkWeapons,
				WeaponProperty = "ClipRegenInterval",
				BaseValue = 0.8,
				SourceIsMultiplier = true,
				DecimalPlaces = 3,
				ChangeType = "Multiply",
				ReportValues = { ReportedReduction = "ChangeValue"},
			},
		},
		StatLines =
		{
			"DashRechargeStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedReduction",
				ExtractAs = "TooltipMultiplier",
				Format = "PercentReciprocalDelta",
			},
		},
	},
	TimedKillBuffBoon = 
	{
		InheritFrom = { "BaseTrait", "AirBoon" },
		Icon = "Boon_Hermes_36",
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
		ShowInHUD = true,
		SetupFunction = 
		{
			Name = "RestoreLastRoomKillBuff",
		},
		CustomLabel = 
		{
			DisplayType = "SessionMapStateValue",
			Key = "TimedBuff",
			MultiplyByRarity = true,
			Text = "UI_TimedKillBuff"
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			UseSessionMapStateValue = "TimedBuff",
			SessionMapStateMultiplier = {BaseValue = 0.01, DecimalPlaces = 3 },
			ReportValues = { ReportedMultiplier = "SessionMapStateMultiplier" }
		},
		OnEnemyDeathFunction = 
		{
			Name = "CheckTimedKillBuff",
			FunctionArgs = 
			{
				Duration = 45,
				ReportValues = { ReportedDuration = "Duration" },
				Fx = "HermesWingsBuff",
			}
		},
		StatLines =
		{
			"TimedDamageBonusStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Multiplier",
				DecimalPlaces = 1,
				Format = "Percent",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			}
		}
	},
	SprintShieldBoon =
	{
		Icon = "Boon_Hermes_42",
		InheritFrom = { "BaseTrait", "FireBoon"},
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
		SetupFunction =
		{
			Name = "SprintShieldSetup",
			Args =
			{
				SprintShields = { BaseValue = 1 },
				ActiveVfx = "HermesSprintShieldFx",
				TraitName = "SprintShieldBoon",
				ReportValues = { ReportedShields = "SprintShields" ,}
			},
			RunOnce = true
		},
		OnSprintStartAction = 
		{
			FunctionName = "SprintShieldPresentation",
		},
		
		OnSprintEndAction = 
		{
			FunctionName = "SprintShieldEndPresentation",
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponSprint", "WeaponBlink" },
				WeaponProperty = "SelfVelocity",
				ChangeValue = 297,
				ChangeType = "Add",
				ExcludeLinked = true,
				ReportValues = {ReportedBaseSpeed = "ChangeValue"},
			},
			{
				WeaponNames = { "WeaponSprint", "WeaponBlink" },
				WeaponProperty = "SelfVelocityCap",
				ChangeValue = 133.5,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponSprint",
				EffectName = "ApolloControl",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
		},
		
		StatLines =
		{
			"SprintShieldStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedShields",
				ExtractAs = "TooltipShields",
			},
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "TooltipSpeed",
				Format = "PercentOfBase",
				BaseType = "Weapon",
				BaseName = "WeaponSprint",
				BaseProperty = "SelfVelocity",
			},
		}
	},
	RestockBoon =
	{
		Icon = "Boon_Hermes_32",
		InheritFrom = { "BaseTrait", "FireBoon"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 2.0,
			},
			Epic =
			{
				Multiplier = 3.0,
			},
			Heroic =
			{
				Multiplier = 4.0,
			},
		},
		FirstPurchaseDiscount = { BaseValue = 0.95, SourceIsMultiplier = true },
		
		StatLines =
		{
			"DiscountStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "FirstPurchaseDiscount",
				ExtractAs = "TooltipDiscount",
				Format = "NegativePercentDelta",
				HideSigns = true,
			},
		}
	},

	LuckyBoon =
	{
		Icon = "Boon_Hermes_34",
		InheritFrom = { "BaseTrait", "WaterBoon"},
		BlockStacking = true,
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
		LuckMultiplier =
		{
			BaseValue = 1.3,
			SourceIsMultiplier = true,
		},
		StatLines =
		{
			"LuckStatDisplay",
		},
		PropertyChanges = 
		{
			{
				TraitName = "DoubleStrikeChanceBoon",
				WeaponNames = 
				{
					"WeaponStaffSwing",
					"WeaponStaffSwing2",
					"WeaponStaffSwing3",
					"WeaponStaffDash",
					
					"WeaponAxe",
					"WeaponAxe2",
					"WeaponAxe3",
					"WeaponAxeDash",
					
					"WeaponDagger",
					"WeaponDagger2",
					"WeaponDaggerDouble",
					"WeaponDaggerMultiStab",
					"WeaponDaggerDash",

					"WeaponTorch",
		
					"WeaponLob",

					"WeaponSuit",
				},
				ExcludeLinked = true,
				WeaponProperty = "AdditionalProjectileWaveChance",
				BaseValue =  1.3,
				ChangeType = "Multiply",
				SourceIsMultiplier = true,
			}
		},
		ExtractValues =
		{
			{
				Key = "LuckMultiplier",
				ExtractAs = "TooltipLuck",
				Format = "PercentDelta",
				HideSigns = true,
			},
			{
				ExtractAs = "BlindChance",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "BlindEffect",
				BaseProperty = "MissChance",
				Format = "Percent",
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

	TimeStopLastStandBoon = -- Legendary
	{
		InheritFrom = { "LegendaryTrait", "AirBoon" },
		Icon = "Boon_Hermes_39",

		-- see MoneyShieldBlockPresentation
		MoneyShieldData = 
		{
			Multiplier = 3,
			DamagedFxOverride = "PlayerHitSpark_NoBlood",
			ReportValues = { ReportedMultiplier = "Multiplier" }
		},
		
		StatLines =
		{
			"MoneyDrainStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipShields",
			},
		},
		FlavorText = "TimeStopLastStandBoon_FlavorText",
	},
})