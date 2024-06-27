OverwriteTableKeys( TraitData, {
	-- Elementals
	ElementalUnifiedBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Hermes_38",
		ActivationRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Fire" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "Hero", "Elements", "Earth" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "Hero", "Elements", "Air" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "Hero", "Elements", "Water" },
				Comparison = ">=",
				Value = 2,
			},
		},
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Fire" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "CurrentRun", "Hero", "Elements", "Earth" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "CurrentRun", "Hero", "Elements", "Air" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "CurrentRun", "Hero", "Elements", "Water" },
				Comparison = ">=",
				Value = 1,
			},
		},
		AddOutgoingDamageModifiers = 
		{
			GameStateMultiplier =
			{
				BaseValue = 1.20,
				SourceIsMultiplier = true,
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				},
			},
			ReportValues = 
			{ 
				ReportedTotalDamageChange = "GameStateMultiplier",
			}
		},
		StatLines =
		{
			"GlobalDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedTotalDamageChange",
				ExtractAs = "TooltipTotalDamageBonus",
				Format = "PercentDelta",
			},
		},
	},
	ElementalDamageBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Hephaestus_34",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Earth" },
				Comparison = ">=",
				Value = 2,
			},
		},
		ElementalMultipliers = 
		{
			Earth = true,
		},		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
			NonExMultiplier =
			{
				BaseValue = 1.05,
				SourceIsMultiplier = true,
				MultipliedByElement = "Earth",
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				},
			},
			ReportValues = 
			{ 
				ReportedTotalDamageChange = "NonExMultiplier",
			}
		},
		-- Display variable only! Match this with the above valid weapon multiplier!
		ReportedDamageChange = 
		{ 
			BaseValue = 1.05, 
			SourceIsMultiplier = true,
			IdenticalMultiplier =
			{
				Value = DuplicateMultiplier,
			}, 
		},
		StatLines =
		{
			"EarthDamageStatDisplay1",
		},
		TrayStatLines = 
		{
			"EarthTotalDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedTotalDamageChange",
				ExtractAs = "TooltipTotalDamageBonus",
				SkipAutoExtract = true,
				Format = "PercentDelta",
			},
			{
				Key = "ReportedDamageChange",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		},
	},
	ElementalBaseDamageBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Hestia_33",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Fire" },
				Comparison = ">=",
				Value = 2,
			},
		},
		ElementalMultipliers = 
		{
			Fire = true,
		},		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},
		PropertyChanges = 
		{
			{
				WeaponNames = WeaponSets.HeroPrimarySecondaryWeapons,
				ProjectileProperty = "Damage",
				BaseValue = 2,
				ChangeType = "Add",
				MultipliedByElement = "Fire",
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				}, 
				ReportValues = 
				{ 
					ReportedTotalDamageChange = "ChangeValue",
				},
			},
		},
		-- Display variable only! Match this with the above valid change value!
		ReportedDamageChange = 
		{ 
			BaseValue = 2,
			IdenticalMultiplier =
			{
				Value = DuplicateMultiplier,
			}, 
		},
		StatLines =
		{
			"FireDamageStatDisplay1",
		},
		TrayStatLines = 
		{
			"FireTotalDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedTotalDamageChange",
				ExtractAs = "TooltipTotalDamageBonus",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDamageChange",
				ExtractAs = "TooltipDamageBonus",
			},
		},
	},
	ElementalRallyBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Apollo_34",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Fire" },
				Comparison = ">=",
				Value = 2,
			},
		},
		ActivationRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Fire" },
				Comparison = ">=",
				Value = 3,
			},
		},
		
		OnSelfDamagedFunction = 
		{
			Name = "FireRallyHeal",
			FunctionArgs = 
			{
				Duration = 5,
				Multiplier = { BaseValue = 0.3 },
				--[[IdenticalMultiplier =
				{
					Value = DuplicateWeakMultiplier,
				},]]
				ReportValues = { ReportedMultiplier = "Multiplier", ReportedDuration = "Duration"},
			}
		},
		StatLines =
		{
			"HealOverTimeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipMultiplier",
				Format = "Percent",
				HideSigns = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				SkipAutoExtract = true
			},
		}
	},	
	ElementalDamageFloorBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Zeus_31",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Air" },
				Comparison = ">=",
				Value = 3,
			},
		},
		ActivationRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Air" },
				Comparison = ">=",
				Value = 5,
			},
		},
		ActivatedDamageFloor = 
		{ 
			BaseValue = 30,
			AsInt = true,
			IdenticalMultiplier =
			{
				Value = DuplicateWeakMultiplier,
			},
		},
		StatLines =
		{
			"DamageFloorStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ActivatedDamageFloor",
				ExtractAs = "TooltipFloor",
			},
		}
	},
	ElementalRarityUpgradeBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Hera_34",
		BlockStacking = true,
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Earth" },
				Comparison = ">=",
				Value = 2,
			},
		},
		ActivationRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Earth" },
				Comparison = ">=",
				Value = 3,
			},
		},
		OnActivationFunction = 
		{
			Name = "UpgradeAllCommon",
			Args = 
			{
				PresentationDelay = 1.5,
				ActivatedValues = 
				{
					RarityBonus =
					{
						GodLootOnly = true,
						Rare = 1,
					},
				}
			}
		},
		StatLines =
		{
			"ElementalRarityStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ActivatedDamageCap",
				ExtractAs = "TooltipCap",
			},
		}
	},
	ElementalDamageCapBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Demeter_37",
		BlockStacking = true,
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Water" },
				Comparison = ">=",
				Value = 4,
			},
		},
		ActivationRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Water" },
				Comparison = ">=",
				Value = 6,
			},
		},
		ActivatedDamageCap = 
		{ 
			BaseValue = 15, 
			AsInt = true,
			MinValue = -1,
			MinMultiplier = -2,
			IdenticalMultiplier =
			{
				Value = -1,
			},
		},
		StatLines =
		{
			"DamageCapStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ActivatedDamageCap",
				ExtractAs = "TooltipCap",
			},
		}
	},
	ElementalHealthBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Poseidon_34",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Water" },
				Comparison = ">=",
				Value = 2,
			},
		},
		ElementalMultipliers = 
		{
			Water = true,
		},		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},
		PropertyChanges = 
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 15,
				ChangeType = "Add",
				MultipliedByElement = "Water",
				ReportValues = 
				{ 
					ReportedTotalHealthBonus = "ChangeValue",
					ReportedHealthBonus = "BaseValue",
				},
			},
		},
		StatLines =
		{
			"MaxLifeStatDisplay1",
		},
		TrayStatLines =
		{
			"TotalMaxLifeStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedTotalHealthBonus",
				ExtractAs = "TooltipTotalHealthBonus",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedHealthBonus",
				ExtractAs = "TooltipDamageBonus",
			},
		},
	},
	ElementalDodgeBoon = 
	{
		InheritFrom = {"UnityTrait"},
		Icon = "Boon_Aphrodite_33",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Air" },
				Comparison = ">=",
				Value = 2,
			},
		},
		ElementalMultipliers = 
		{
			Air = true,
		},		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},
		PropertyChanges = 
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.03,
				ChangeType = "Add",
				MultipliedByElement = "Air",
				DataValue = false,
				ReportValues = 
				{ 
					ReportedTotalDodgeBonus = "ChangeValue",
					ReportedDodgeBonus = "BaseValue",
				},
			},
		},
		StatLines =
		{
			"ElementalDodgeStatDisplay1",
		},
		TrayStatLines = 
		{
			"TotalDodgeChanceStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedTotalDodgeBonus",
				ExtractAs = "TooltipTotalDodgeBonus",
				Format = "Percent",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDodgeBonus",
				ExtractAs = "TooltipDodgeBonus",
				Format = "Percent",
			},
		},
	},
})