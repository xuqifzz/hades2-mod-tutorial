TraitSetData.Store =
{
	ShopTrait =
	{
		--Frame = "Shop"
	},
	ExtendedShopTrait = 
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Stein",
		RemainingUses = 1,
		ResourceCosts =
		{
			Money = 90,
		},
		ValidPermanentItemsLookup = 
		{
			TemporaryDoorHealTrait = true,
			TemporaryImprovedSecondaryTrait = true,
			TemporaryImprovedCastTrait = true,
			TemporaryMoveSpeedTrait = true,
			TemporaryImprovedExTrait = true,
			TemporaryImprovedDefenseTrait = true,
			TemporaryDiscountTrait = true,
		},
		BossExtension = {BaseValue = 2},
		PermanentItemBadgeAnimationName = "Keepsake_13",
		ExtractValues = 
		{
			{
				Key = "BossExtension",
				ExtractAs = "Boss",
			},
		},
	},
	TemporaryDoorHealTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Stein",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		RemainingUses = 3,
		UsesAsRooms = true,
		DoorHeal = 0.10,
		ResourceCosts =
		{
			Money = 45,
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"StoreUsesRemainingDisplay1",
				"HealingReductionNotice",
			}
		},
		StatLines = 
		{
			"StoreUsesRemainingDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "DoorHeal",
				ExtractAs = "TooltipHeal",
				Format = "PercentHeal",
			},
			{
				ExtractAs = "HealingReduction",
				Format = "TotalMetaUpgradeChangeValue",
				MetaUpgradeName = "HealingReductionShrineUpgrade"
			}
		},
	},
	TemporaryImprovedWeaponTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Jerky",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 40,
		},
		RemainingUses = 5,
		UsesAsEncounters = true,
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier = 1.3,
			ValidWeapons = WeaponSets.HeroPhysicalWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"}
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		},
	},
	TemporaryImprovedSecondaryTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Sweet_Jerky",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 35,
		},
		RemainingUses = 5,
		UsesAsEncounters = true,
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier = 1.4,
			ValidWeapons = WeaponSets.HeroSecondaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"}
		},
		StatLines = 
		{
			"StoreUsesRemainingDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		},
	},
	TemporaryImprovedExTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Sweet_Jerky",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 45,
		},
		RemainingUses = 6,
		UsesAsEncounters = true,
		AddOutgoingDamageModifiers =
		{
			ExMultiplier = 1.5,
			ReportValues = { ReportedWeaponMultiplier = "ExMultiplier"}
		},
		StatLines = 
		{
			"StoreUsesRemainingDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		},
	},
	TemporaryImprovedDefenseTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Sweet_Jerky",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 30,
		},
		RemainingUses = 5,
		UsesAsEncounters = true,
		AddIncomingDamageModifiers =
		{
			ValidWeaponMultiplier = 0.9,
			ReportValues = 
			{
				ReportedMultiplier = "ValidWeaponMultiplier"
			},
		},
		StatLines = 
		{
			"StoreUsesRemainingDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "TooltipDamageReduction",
				Format = "NegativePercentDelta",
			},
		}
	},
	TemporaryImprovedCastTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Braid",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 30,
		},
		RemainingUses = 5,
		UsesAsEncounters = true,
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier = 1.35,
			ValidWeapons = WeaponSets.HeroNonPhysicalWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"}
		},
		StatLines = 
		{
			"StoreUsesRemainingDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipDamageBonus",
				Format = "PercentDelta",
			},
		},
	},
	TemporaryMoveSpeedTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Vial",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		ResourceCosts =
		{
			Money = 10,
		},
		RemainingUses = 8,
		UsesAsEncounters = true,
		StatLines = 
		{
			"StoreUsesRemainingDisplay1",
		},
		PropertyChanges =
		{
			{
				UnitProperty = "Speed",
				ChangeValue = 1.2,
				ChangeType = "Multiply",
				ReportValues = { ReportedSpeed = "ChangeValue"}
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeed",
				ExtractAs = "TooltipSpeed",
				Format = "PercentDelta",
			}
		}
	},
	TemporaryBoonRarityTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Yarn",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 70,
		},
		RarityBonus =
		{
			Rare = 1,
			Epic = 0.25,
			Legendary = 0.1,
		},
		RemainingUses = 1,
	},
	TemporaryForcedSecretDoorTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Lamp",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		ResourceCosts =
		{
			Money = 55,
		},
		RemainingUses = 1,
		ForceSecretDoor = true,
		RequiredTextLines = { "ChaosFirstPickUp", },
	},
	TemporaryDiscountTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Yarn",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		ResourceCosts =
		{
			Money = 80,
		},
		StoreCostMultiplier = 0.7,
		RemainingUses = 6,
		UsesAsEncounters = true,
		StatLines = 
		{
			"StoreUsesRemainingDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "StoreCostMultiplier",
				ExtractAs = "TooltipDiscount",
				Format = "NegativePercentDelta",
				HideSigns = true,
			}
		}
	},
	TemporaryHealExpirationTrait = 
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Sweet_Jerky",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 50,
		},
		RemainingUses = 4,
		UsesAsEncounters = true,
		
		OnExpire = 
		{
			FunctionName = "TemporaryHealExpirationPresentation",
			HealFraction = 0.5,
			ReportValues = { ReportedHeal = "HealFraction" }
			
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"StoreUsesRemainingDisplay1",
				"HealingReductionNotice",
			}
		},
		StatLines = 
		{
			"EffectCountdownDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedHeal",
				ExtractAs = "TooltipHeal",
				Format = "PercentHeal",
			},
		}
	}

}


OverwriteTableKeys( TraitData, TraitSetData.Store )