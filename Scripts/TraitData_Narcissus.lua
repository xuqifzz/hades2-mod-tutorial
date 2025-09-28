OverwriteTableKeys( TraitData, {
	-- Narcissus
	NarcissusA =
	{
		BlockStacking = true,
		BlockInRunRarify = true,
		Icon = "Boon_Narcissus_01",
		AcquireFunctionName = "GiveRandomConsumables",
		AcquireFunctionArgs =
		{ 
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 170,
			AngleIncrement = 40,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "PlantFMolyDrop",
					Overrides =
					{
						AddResources =
						{
							PlantFMoly = 2,
						},
					},
				},
				{
					Name = "PlantFNightshadeDrop",
					Overrides =
					{
						AddResources =
						{
							PlantFNightshade = 3,
						},
					},
				},
				{
					Name = "StoreRewardRandomStack",
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "PlantFMoly",
				Format = "ResourceAmount",
				ExtractAs = "TotalMoly",
			},
			{
				Key = "PlantFNightshade",
				Format = "ResourceAmount",
				ExtractAs = "TotalNightshade",
			},
		},
	},
	NarcissusB =
	{
		InheritFrom = { "NarcissusA", },
		Icon = "Boon_Narcissus_02",
		AcquireFunctionArgs =
		{ 
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 180,
			AngleIncrement = 60,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "MetaCardPointsCommonDrop",
					Overrides =
					{
						AddResources =
						{
							MetaCardPointsCommon = 10,
						},
					},	

				},
				{
					Name = "HealDropMajor",
				},
			}
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
				External = true,
				BaseType = "ConsumableData",
				BaseName = "HealDropMajor",
				Format = "FlatHeal",
				BaseProperty = "HealFixed",
				ExtractAs = "HealDropAmount"
			},
			{
				Key = "MetaCardPointsCommon",
				Format = "ResourceAmount",
				ExtractAs = "TotalMetaCardPointsCommon",
			},
		},
	},
	NarcissusC =
	{
		InheritFrom = { "NarcissusA", },
		Icon = "Boon_Narcissus_03",
		AcquireFunctionArgs =
		{ 
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 200,
			MultiplyMoney = true,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "OreFSilverDrop",
					Overrides =
					{
						AddResources =
						{
							OreFSilver = 6,
						},
					},
				},
				{
					Name = "Currency",
					Amount = 100,
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "OreFSilver",
				Format = "ResourceAmount",
				ExtractAs = "TotalSilver",
			},
		},
	},
	NarcissusD =
	{
		InheritFrom = { "NarcissusA", },
		Icon = "Boon_Narcissus_04",
		AcquireFunctionArgs =
		{ 
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 180,
			AngleIncrement = 60,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "MemPointsCommonDrop",
					Overrides =
					{
						AddResources =
						{
							MemPointsCommon = 20,
						},
					},
				},
				{
					Name = "MaxManaDrop",
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "MemPointsCommon",
				Format = "ResourceAmount",
				ExtractAs = "TotalMemPointsCommon",
			},
		},
	},
	NarcissusE =
	{
		InheritFrom = { "NarcissusA", },
		Icon = "Boon_Narcissus_05",
		AcquireFunctionArgs =
		{ 
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 180,
			AngleIncrement = 60,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "MetaCurrencyDrop",
					Overrides =
					{
						AddResources =
						{
							MetaCurrency = 50,
						},
					},
				},
				{
					Name = "MaxHealthDrop",
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "MetaCurrency",
				Format = "ResourceAmount",
				ExtractAs = "TotalMetaCurrency",
			},
		},
	},
	NarcissusF =
	{
		InheritFrom = { "NarcissusA", },
		Icon = "Boon_Narcissus_06",
		AcquireFunctionArgs =
		{
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 180,
			AngleIncrement = 60,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "MetaFabricDrop",
					Overrides =
					{
						AddResources =
						{
							MetaFabric = 2,
						},
					},
				},
				{
					Name = "RerollDrop",
					Overrides =
					{
						AddRerolls = 2
					},
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "MetaFabric",
				Format = "ResourceAmount",
				ExtractAs = "TotalMetaFabric",
			},
		},
	},
	NarcissusG =
	{
		InheritFrom = { "NarcissusA", },
		Icon = "Boon_Narcissus_07",
		GameStateRequirements =
		{
			-- see NarcissusBenefitChoices =
		},
		CodexGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NarcissusGrantsReward01" },
			},
		},
		AcquireFunctionArgs =
		{
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 170,
			AngleIncrement = 40,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "Mixer5CommonDrop",
				},
				{
					Name = "ElementalBoost",
					Total = 2, -- used for text
				},
				{
					Name = "ElementalBoost",
				},
			}
		},
		FlavorText = "NarcissusG_FlavorText",
		ExtractValues =
		{
			{
				Key = "Mixer5Common",
				Format = "ResourceAmount",
				ExtractAs = "TotalMixer5Common",
			},
		},
	},
	NarcissusH =
	{
		InheritFrom = { "NarcissusA", },
		Icon = "Boon_Narcissus_08",
		AcquireFunctionArgs =
		{
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 180,
			AngleIncrement = 60,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "LastStandDrop",
					Overrides = 
					{
						CanDuplicate = false,
					}
				},
				{
					Name = "PlantGLotusDrop",
					Overrides =
					{
						AddResources =
						{
							PlantGLotus = 2,
						},
					},
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "PlantGLotus",
				Format = "ResourceAmount",
				ExtractAs = "TotalLotus",
			},
		},
	},
	NarcissusI =
	{
		InheritFrom = { "NarcissusA", },
		Icon = "Boon_Narcissus_09",
		AcquireFunctionArgs =
		{
			Delay = 0.5,
			NotRequiredPickup = true,
			ForceToValidLocation = false,
			RunProgressUpgradeEligible = true,
			DestinationId = 591878,
			Range = 0,
			Force = 280,
			UpwardForce = 600,
			Angle = 180,
			AngleIncrement = 60,
			DropFunctionName = "NarcissusDropPresentation",
			LootOptions =
			{
				{
					Name = "BlindBoxLoot",
					Overrides =
					{
						BlockBoughtTextLines = true,
					},
				},
				{
					Name = "SeedMysteryDrop",
					Overrides =
					{
						AddResources =
						{
							SeedMystery = 1,
						},
					},
				},
			}
		},
		ExtractValues =
		{
			{
				Key = "SeedMystery",
				Format = "ResourceAmount",
				ExtractAs = "TotalSeedMystery",
			},
		},
	},
})