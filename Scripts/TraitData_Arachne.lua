OverwriteTableKeys( TraitData, {
	-- Arachne	
	AgilityCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Athena_03",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorC",
		WeaponSpeedMultiplier =
		{
			WeaponNames = { "WeaponTorch", "WeaponTorchSpecial", "WeaponLob", "WeaponLobSpecial", "WeaponAxeBlock2", "WeaponAxeSpin", "WeaponCastArm", "WeaponStaffBall", "WeaponStaffSwing5", "WeaponDaggerThrow", "WeaponDagger5" },
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
				WeaponNames = { "WeaponLobSpecial", "WeaponCastArm", "WeaponStaffBall", "WeaponStaffSwing5", "WeaponDaggerThrow", "WeaponDagger5" },
				BaseValue = 0.6,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
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
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
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
		Icon = "Boon_Athena_01",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorD",
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroRangedWeapons,
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
				BaseAmount = 10,
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
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
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
		Icon = "Boon_Athena_01",
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
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
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
		Icon = "Boon_Athena_02",
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
		ExtractValues =
		{
			{
				Key = "ReportedArmor",
				ExtractAs = "TooltipAmount",
			},
			{
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
			},
			{
				Key = "DoorHealFixed",
				ExtractAs = "TooltipHeal",
			},
		}
	},
	HighArmorCostume = 
	{
		InheritFrom = { "CostumeTrait" },
		Icon = "Boon_Athena_02",
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
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
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
		Icon = "Boon_Athena_02",
		Costume = "Models/Melinoe/Melinoe_ArachneArmorE",
		DoorCash = { BaseValue = 5 },
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Robe",
				Delay = 0.75,
				BaseAmount = 20,
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
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
			},
			{
				Key = "DoorCash",
				ExtractAs = "TooltipCash",
			},
		}
	},
})