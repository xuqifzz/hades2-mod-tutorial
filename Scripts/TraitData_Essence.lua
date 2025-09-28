
TraitSetData.Essence =
{
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
		ShowElementGain = true,
		ElementGainSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh",
	},
	FireEssence = 
	{
		InheritFrom = {"FireBoon"},
		Hidden = true,
		ShowElementGain = true,
		ElementGainSound = "/SFX/HellFireImpact",
	},
	EarthEssence = 
	{
		InheritFrom = {"EarthBoon"},
		Hidden = true,
		ShowElementGain = true,
		ElementGainSound = "/SFX/WallSlamMeatyRocks",
	},
	WaterEssence = 
	{
		InheritFrom = {"WaterBoon"},
		Hidden = true,
		ShowElementGain = true,
		ElementGainSound = "/SFX/Player Sounds/PoseidonWaterDashImpact",
	},
}


OverwriteTableKeys( TraitData, TraitSetData.Essence )