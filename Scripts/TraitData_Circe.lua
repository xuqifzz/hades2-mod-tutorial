OverwriteTableKeys( TraitData, {
		-- Circe
	BaseCirce =
	{
		IsCirceBoon = true,
	},
	RandomArcanaTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_06",
		
		AcquireFunctionName = "CirceRandomMetaUpgrade",
		AcquireFunctionArgs = 
		{
			Count = 1, 
			ReportValues = { ReportedCount = "Count" }
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			},
		}
	},
	RemoveShrineTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_07",
		
		AcquireFunctionName = "CirceRemoveShrineUpgrades",
		AcquireFunctionArgs = 
		{
			Count = 1, 
			ReportValues = { ReportedCount = "Count" }
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			},
		}
	},
	DoubleFamiliarTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_04",
		
		AcquireFunctionName = "CircePetMultiplier",
		AcquireFunctionArgs = 
		{
			BonusMultiplier = 1, 
			ReportValues = { ReportedBonus = "BonusMultiplier" }
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedBonus",
				ExtractAs = "Bonus",
				Format = "Percent",
			},
		}
	},
	HealAmplifyTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_05",
		CustomTrayText = "HealAmplifyTrait_Tray",
		AcquireFunctionName = "CirceHeal",
		AcquireFunctionArgs = 
		{
			HealFraction = 0.5,
			ReportValues = { ReportedHeal = "HealFraction" }
		},
		TraitHealingBonus = 1.25,
		ExtractValues =
		{
			{
				Key = "TraitHealingBonus",
				ExtractAs = "Bonus",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedHeal",
				ExtractAs = "Healing",
				Format = "PercentHeal",
			},
		}
	},
	ArcanaRarityTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_01",
		
		AcquireFunctionName = "CirceMetaUpgradeRarity",
		AcquireFunctionArgs = 
		{
			Count = 1, 
			ReportValues = { ReportedCount = "Count" }
		},
	},
	CirceEnlargeTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_02",
		BaseChipmunkValue = -1,
		SetupFunction = 
		{
			Name = "CirceEnlarge",
			Args = 
			{
				ScaleMultiplier = 1.25,
				InitialPresentationFunctionName = "CirceEnlargePresentation",
				ReportValues = 
				{
					ReportedScale = "Scale",
				},
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeaponMultiplier = 1.15,
			ReportValues = {ReportedMultiplier = "ValidWeaponMultiplier"}
		},
		
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Bonus",
				Format = "PercentDelta",
			},
		}
	},
	CirceShrinkTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_03",
		BaseChipmunkValue = 0.75,
		SetupFunction = 
		{
			Name = "CirceShrink",
			Args = 
			{
				ScaleMultiplier = 0.75,
				InitialPresentationFunctionName = "CirceShrinkPresentation",
				ReportValues = 
				{
					ReportedScale = "Scale",
				},
			},
		},
		
		PropertyChanges =
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.15,
				ChangeType = "Add",
				DataValue = false,
				ReportValues = { ReportedDodgeChance = "ChangeValue"},
			},
			{
				UnitProperty = "Speed",
				ChangeType = "Multiply",
				ChangeValue = 1.15,
				SourceIsMultiplier = true,
				ReportValues = { ReportedBaseSpeed = "ChangeValue" },
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedBaseSpeed",
				ExtractAs = "Bonus",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedDodgeChance",
				ExtractAs = "Dodge",
				Format = "Percent",
			},
		}
	},
})