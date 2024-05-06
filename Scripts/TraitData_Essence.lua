
TraitSetData.Essence =
{
	EssenceTrait = 
	{
		Frame = "Hammer",
	},

	MinorDodgeEssence =
	{
		InheritFrom = { "EssenceTrait" },
		Icon = "Boon_Hermes_04",

		PropertyChanges =
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.01,
				ChangeType = "Add",
				DataValue = false,
				ReportValues = { ReportedDodgeChance = "ChangeValue"},
			},
		},
		
		StatLines =
		{
			"DodgeChanceStatDisplay1",
		},
		ExtractValues =
		{
			{
					Key = "ReportedDodgeChance",
					ExtractAs = "TooltipDodgeBonus",
					Format = "Percent",
			},
		}
	},
	DamageEssence = 
	{
		InheritFrom = { "EssenceTrait" },
		Icon = "Boon_Hermes_04",
		AddOutgoingDamageModifiers =
		{
			NonExMultiplier =
			{
				BaseValue = 1.01,
				SourceIsMultiplier = true,
			},
			ValidWeapons = WeaponSets.HeroAllWeapons,
			ReportValues = { ReportedWeaponMultiplier = "NonExMultiplier"},
		},
		StatLines =
		{
			"AttackDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		}

	},
	ExDamageEssence = 
	{
		InheritFrom = { "EssenceTrait" },
		Icon = "Boon_Hermes_04",
		AddOutgoingDamageModifiers =
		{
			ExMultiplier =
			{
				BaseValue = 1.01,
				SourceIsMultiplier = true,
			},
			ValidWeapons = WeaponSets.HeroAllWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ExMultiplier"},
		},
		StatLines =
		{
			"AttackDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		}
	},
	MinorHitShieldBoon = 
	{
		Icon = "Boon_Hermes_05",
		SuppliesHitShields = true,
		RemainingUses = 1,
		HitShieldAnimation = "TempHitShield",
		SetupFunction =
		{
			Name = "StartHitShield",
			Args =
			{
				Vfx = "TempHitShield"
			}
		},
		StatLines =
		{
			"CurrentHitShieldsStatDisplay1",
		},
	},
	MinorArmorBoon = 
	{
		InheritFrom = { "CostumeTrait" },
		Hidden = true,
		Icon = "Boon_Hermes_05",
		SetupFunction =
		{
			Name = "CostumeArmor",
			Args =
			{
				Source = "Essence", 
				BaseAmount = 10,
				ReportValues = 
				{ 
					ReportedArmor = "BaseAmount",
				}
			},
		},
		StatLines =
		{
			"CurrentArmorStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "CurrentArmor",
				ExtractAs = "TooltipCurrentArmor",
			},
		}
	},
	ElementalEssence = 
	{
		Elements = { "Air", "Fire", "Earth", "Water" },
		Hidden = true,
	},
	AirEssence = 
	{
		InheritFrom = {"AirBoon"},
		Hidden = true,
	},
	FireEssence = 
	{
		InheritFrom = {"FireBoon"},
		Hidden = true,
	},
	EarthEssence = 
	{
		InheritFrom = {"EarthBoon"},
		Hidden = true,
	},
	WaterEssence = 
	{
		InheritFrom = {"WaterBoon"},
		Hidden = true,
	},
}


OverwriteTableKeys( TraitData, TraitSetData.Essence )