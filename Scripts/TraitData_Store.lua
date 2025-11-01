TraitSetData.Store =
{
	ShopTrait =
	{
		NoFrame = true,
		InfoBackingAnimation = "ShopSlotBase",
		TrayTextBackingAnimation = "TraitTray_LevelBacking_Alt",
		TrayTextBackingOffsetY = 9,
		PinAnimationIn = "TraitPinIn_Keepsake",
		PinAnimationOut = "TraitPinOut_Keepsake",
		TrayHighlightAnimScale = 1.2,
		HideInRunHistory = true,
		DebugOnly = true,
	},
	ExtendedShopTrait = 
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Seal",
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
			TemporaryEmptySlotDamageTrait = true,
		},
		BossExtension = {BaseValue = 2},
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
			"StoreUsesRemainingDisplay2",
		},
		ExtractValues =
		{
			{
				Key = "DoorHeal",
				ExtractAs = "TooltipHeal",
				Format = "PercentHeal",
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
		Icon = "Shop_Mark",
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
		Icon = "Shop_Scales",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 30,
		},
		RemainingUses = 5,
		UsesAsEncounters = true,
		AddIncomingDamageModifiers =
		{
			HealthOnly = true,
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
			ValidWeapons = WeaponSets.HeroRangedWeapons,
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
	TemporaryEmptySlotDamageTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_TemporaryEmptySlotDamageTrait",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Jar",
		ResourceCosts =
		{
			Money = 10,
		},
		RemainingUses = 6,
		UsesAsEncounters = true,
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "SlottedTraits" },
				NotHasAll = {"Melee", "Secondary" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "TemporaryEmptySlotDamageTrait" },
			},
		},
		AddOutgoingDamageModifiers =
		{
			EmptySlotMultiplier = 3,
			EmptySlotValidData =
			{
				Melee = WeaponSets.HeroPrimaryWeapons,
				Secondary = WeaponSets.HeroSecondaryWeapons,
			},
			ReportValues = { ReportedWeaponMultiplier = "EmptySlotMultiplier"},
		},
		StatLines = 
		{
			"StoreUsesRemainingDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedWeaponMultiplier",
				ExtractAs = "TooltipBonus",
				Format = "PercentDelta",
				SkipAutoExtract = true
			},
		}
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
			GodLootOnly = true,
			Rare = 1,
			Epic = 0.25,
			Duo = 0.1,
			Legendary = 0.1,
		},
		RemainingUses = 1,
	},
	TemporaryForcedSecretDoorTrait =
	{
		InheritFrom = { "ShopTrait" },
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosFirstPickUp" },
			},
		},
		Icon = "Shop_Lamp",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		ResourceCosts =
		{
			Money = 55,
		},
		RemainingUses = 1,
		ForceSecretDoor = true,
	},
	TemporaryDiscountTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_Deal",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Crystal",
		ResourceCosts =
		{
			Money = 80,
		},
		BoonInfoIgnoreRequirements = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "TemporaryDiscountTrait" },
			},
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
		Icon = "Shop_Hope",
		OnPurchaseSound = "/Leftovers/Menu Sounds/WellPurchase_Fabric",
		ResourceCosts =
		{
			Money = 115,
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
	},
	FirstHitHealTrait =
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_FirstHitHeal",
		ResourceCosts =
		{
			Money = 15,
		},
		SetupFunction =
		{
			Name = "FirstHealHitSetup",
			Args =
			{
				HealPercent = 1,
				CombatText = "FirstHitHeal_CombatText",
				Vfx = "WrathFire",
				SoundName = "/SFX/GyroHealthPickupMunch",
				ReportValues = { ReportedHealPercent = "HealPercent" }
			},
		},
		IncreaseUsesOnStack = true,
		RemainingUses = 1,
		StatLines = 
		{
			"HitsRemainingDisplay1",
		},
		CustomStatLinesWithShrineUpgrade = 
		{
			ShrineUpgradeName = "HealingReductionShrineUpgrade",
			StatLines = 
			{
				"HitsRemainingDisplay1",
				"HealingReductionNotice",
			}
		},
		ExtractValues =
		{
			{
				Key = "ReportedHealPercent",
				ExtractAs = "TooltipHeal",
				Format = "PercentHeal",
			}
		}
	},
	ManaOverTimeRefundTrait = 
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_LimitedManaRegenDrop",
		ShowInHUD = true,
		TotalManaRecovered = { BaseValue = 500 },
		ResourceCosts =
		{
			Money = 5,
		},
		SetupFunction =
		{
			Name = "ManaRegenSetup",
			Args =
			{
				Name = "ManaOverTimeRefundKeepsake",
			},
			RunOnce = true
		},
		OnManaSpendAction = 
		{
			ManaDrainTriggers = true,
			FunctionName = "CheckOverTimeManaRefund",
			FunctionArgs = 
			{
				Duration = 3,
				Interval = 0.5,
				ReportValues = 
				{ 
					ReportedDuration = "Duration",
				}
			}
		},
		ExtractValues =
		{
			{
				Key = "TotalManaRecovered",
				ExtractAs = "TooltipManaRecovery",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipDuration",
				DecimalPlaces = 1,
			},
		},
	},
	
	LimitedSwapBonusTrait = 
	{
		InheritFrom = { "ShopTrait" },
		Icon = "Shop_LimitedSwapTraitDrop",
		ShowInHUD = true,
		Uses = 1,
		ForceSwaps = true,		
		BlockStacking = true,
		ExchangeLevelBonus = 2,
		ResourceCosts =
		{
			Money = 20,
		},
		ExtractValues = 
		{
			{
				Key = "ExchangeLevelBonus",
				ExtractAs = "Levels",
			},
		}
	},
}


OverwriteTableKeys( TraitData, TraitSetData.Store )