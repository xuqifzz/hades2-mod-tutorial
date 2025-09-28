OverwriteTableKeys( TraitData, {
	-- Circe
	BaseCirce =
	{
		IsCirceBoon = true,
		DebugOnly = true,
		PackageName = "NPC_Circe_01",
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
		HideStatLinesInCodex = true,
		AcquireFunctionName = "CircePetMultiplier",
		AcquireFunctionArgs = 
		{
			BonusMultiplier = 1, 
			ReportValues = { ReportedBonus = "BonusMultiplier" }
		},
		StatLines = 
		{
			"FamiliarBoostStatLine",
		},
		TrayStatLines = 
		{
			"FamiliarBoostTrayStatLine",
		},
		MergeTooltipDataFromSession = 
		{
			Old = "OldFamiliarTrait",
			New = "NewFamiliarTrait",
		},
		ExtractValues =
		{
			{
				Key = "ReportedBonus",
				ExtractAs = "Bonus",
				Format = "Percent",
			},
			{
				IsExternal = true,
				Format = "TotalHeroTraitValue",
				Key = "FamiliarLastStandHealAmount",
				ExtractAs = "TooltipLastStandHealth",
			}
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
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HealingReductionNotice",
			},
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
			Count = 2, 
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
	CirceEnlargeTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_02",
		BaseChipmunkValue = -0.43,
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
				PortraitOverrides =
				{
					Scale = 1.2,
					OffsetX = -50,
					OffsetY = -40,
				},
			},
		},
		MaxHealthMultiplier = 1.15, 
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
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
			{
				Key = "MaxHealthMultiplier",
				ExtractAs = "HealthBonus",
				Format = "PercentDelta",
			},
		}
	},
	CirceShrinkTrait = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_03",
		BaseChipmunkValue = 0.33,
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
				PortraitOverrides =
				{
					Scale = 0.75,
					OffsetX = -20,
					OffsetY = 105,
				},
			},
		},
		
		PropertyChanges =
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.10,
				ChangeType = "Add",
				DataValue = false,
				ReportValues = { ReportedDodgeChance = "ChangeValue"},
			},
			{
				UnitProperty = "Speed",
				ChangeType = "Multiply",
				ChangeValue = 1.10,
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
	CirceSorceryDamageBoon = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_08",
		AllyDataModifiers = 
		{			
			AddOutgoingDamageModifiers =
			{
				{
					NonPlayerMultiplier = 1.3
				},
			},
		},
		AddOutgoingDamageModifiers = 
		{
			-- Match this to above ally data modifier too!
			ValidProjectiles = WeaponSets.SpellProjectileNames,
			ValidWeaponMultiplier = 1.3,
			ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier"},
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

	ExPolymorphBoon = 
	{
		InheritFrom = {"BaseCirce"},
		Icon = "Boon_Circe_09",
		ShowInHUD = true,
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CirceAboutScyllaQuestComplete01" },
			},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = WeaponSets.HeroAllWeapons,
			FunctionName = "CircePolymorph",
			Args = 
			{
				Chance = 0.15,
				Cooldown = 10,
				ReportValues = 
				{ 
					ReportedChance = "Chance", 
					ReportedCooldown = "Cooldown",
				}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Chance",
				Format = "Percent",
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "PolymorphTag",
				BaseProperty = "Duration",
				ExtractAs = "PolymorphDuration",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "MorphDamageProjectile",
				BaseProperty = "Damage",
				ExtractAs = "PolymorphDamage",
				SkipAutoExtract = true,
			},
		},
		Using = { Effects = {"PolymorphTag", "PolymorphDamageTaken"}, },
		FlavorText = "ExPolymorphBoon_FlavorText",
	},
})