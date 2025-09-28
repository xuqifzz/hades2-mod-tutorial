OverwriteTableKeys( TraitData, {
	-- Arachne	
	AgilityCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Arachne_01",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorC",
		WeaponSpeedMultiplier =
		{
			WeaponNames = WeaponSets.HeroAllWeaponsAndSprint,
			Value = 
			{
				BaseValue = 0.60,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		PropertyChanges = 
		{
			{
				WeaponNames = { "WeaponCastArm", "WeaponStaffSwing5", "WeaponDagger5", "WeaponAxeSpecialSwing" },
				BaseValue = 0.6,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ExcludeLinked = true,
			}
		},
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Robe",
				Delay = 0.75,
				BaseAmount = 30,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipSpeed",
				Format = "NegativePercentDelta"
			},
		}
	},
	CastDamageCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Arachne_07",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorD",
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroRangedWeapons,
			ValidProjectiles = WeaponSets.CastProjectileNames,
			WeaponOrProjectileRequirement = true,
			ValidWeaponMultiplier = 2,
			ReportValues = 
			{ 
				ReportedDamageBonus = "ValidWeaponMultiplier",
			}
		},
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Robe",
				BaseAmount = 20,
				Delay = 0.75,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "TooltipDamage",
				Format = "PercentDelta",
			},
		}
	},
	ManaCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		ManaOverTimeSource = true,
		Icon = "Boon_Arachne_02",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorB",
		SetupFunctions =
		{
			{
				Name = "ManaRegenSetup",
				Args =
				{
					Name = "ManaCostume",
					ManaRegenPerSecond = { BaseValue = 5 },
					ReportValues = { ReportedManaRecovery = "ManaRegenPerSecond" }
				},
				RunOnce = true
			},
			{
				Name = "CostumeArmor",
				Args =
				{
					Source = "Robe",
					Delay = 0.75,
					BaseAmount = 40,
					ReportValues = 
					{ 
						ReportedArmor = "BaseAmount",
					}
				},
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "ReportedManaRecovery",
				ExtractAs = "TooltipManaRecovery",
				DecimalPlaces = 1,
			},
		}
	},
	VitalityCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Arachne_03",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorA",
		DoorHealFixed = { BaseValue = 2 },
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Robe",
				Delay = 0.75,
				BaseAmount = 50,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
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
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "DoorHealFixed",
				ExtractAs = "TooltipHeal",
				Format = "FlatHeal",
			},
		}
	},
	HighArmorCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Arachne_06",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorF",
		AcquireFunctionName = "GiveRandomConsumables",
		AcquireFunctionArgs =
		{ 
			Delay = 1.6,
			NotRequiredPickup = true,
			ForceToValidLocation = true,
			LootOptions =
			{
				{
					Name = "MetaFabricDrop",
					Amount = 1,
					Interval = 0.35,
					ReportValues = { ReportedResource = "Amount"},
				},
			}
		},
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Robe",
				Delay = 0.75,
				BaseAmount = 60,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "ReportedResource",
				ExtractAs = "ResourceCount",
			},
		}
	},
	IncomeCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Arachne_08",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorE",
		DoorCash = { BaseValue = 5 },
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Robe",
				Delay = 0.75,
				BaseAmount = 10,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "DoorCash",
				ExtractAs = "TooltipCash",
			},
		}
	},

	SpellCostume =
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Arachne_05",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorG",
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Robe",
				Delay = 0.75,
				BaseAmount = 55,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},
		ManaSpendCostModifiers =
		{
			Multiplier = 0.70,
			ReportValues = 
			{
				ReportedMultiplier = "Multiplier"
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Multiplier",
				Format = "PercentDelta",
			},
		}
	},
	-- Legendary
	EscalatingCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Arachne_04",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorH",
		TrayStatLines = 
		{
			"EscalatingCostumeStatDisplay1",
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArachneGrantsReward01" },
			},
		},
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Robe",
				Delay = 0.75,
				BaseAmount = 5,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},
		AddOutgoingDamageModifiers =
		{
			UseTraitValue = "EscalatingCostumeValue",
			IsMultiplier = true,
		},
		EscalatingCostumeValueGrowthPerRoom = 0.03,
		EscalatingCostumeValue = 1.0,
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
				SkipAutoExtract = true
			},
			{
				Key = "EscalatingCostumeValueGrowthPerRoom",
				ExtractAs = "IncreasePerRoom",
				Format = "Percent",
				DecimalPlaces = 1,
				SkipAutoExtract = true
			},
			{
				Key = "EscalatingCostumeValue",
				ExtractAs = "CurrentBonus",
				Format = "PercentDelta",
				DecimalPlaces = 1,
			},
		},
		FlavorText = "EscalatingCostume_FlavorText",
	},
})