ScreenData.MarketScreen =
{
	Components = {},
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/GeneralWhooshMENULoud",
	CloseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

	NumSales = 0,
	NumItems = 0,

	CategoryStartX = 349,
	CategoryStartY = 208,
	CategorySpacingX = 94,

	CategoryIconScale = 0.46,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ItemStartX = 756,
	ItemStartY = 335,
	ItemSpacingY = 118,
	ItemTextBoxOffsetX = 480,
	IconOffsetX = -375,
	IconOffsetY = 0,
	ItemsPerPage = 5,
	ScrollOffset = 0,

	NewIconOffsetX = 0,
	NewIconOffsetY = -30,

	TooltipOffsetX = 725,

	ItemKeys =
	{
		"CurrentAmount",
		"SellText",
	},

	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_Overlay",
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 4,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ItemCategories =
	{
		{
			Name = "MarketScreen_Resources",
			Icon = "GUI\\Screens\\Inventory\\Icon-Resources",
			CurrencyResourceName = "MetaCurrency",
			RefreshOncePerRun = true,
			GameStateRequirements =
			{
				-- None
			},
			--[[
			{ 
				BuyName = "OreFSilver", BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 10,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			]]
			{ 
				BuyName = "MetaCardPointsCommon", BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 15,
				},
				Priority = true, 
				PurchaseSound = "/SFX/AshRewardDrop",
			},

			{ 
				BuyName = "MemPointsCommon", BuyAmount = 5,
				Cost =
				{
					MetaCurrency = 30,
				},
				Priority = true, 
				PurchaseSound = "/SFX/Player Sounds/PsycheRewardPickup",
			},
			--[[
			{ 
				BuyName = "MixerFBoss", BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 80,
				},
				Priority = true,
				PurchaseSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},


					{ 
				BuyName = "OreNBronze", BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 100,
				},
				Priority = true,
				PurchaseSound = "/SFX/SuperGemPickup",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
			]]
			{ 
				BuyName = "MetaFabric", BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 60,
				},
				Priority = true, 
				PurchaseSound = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
			},
			-- Limited Time Trades
			--[[
			{ 
				BuyName = "OreFSilver", BuyAmount = 5,
				Cost =
				{
					MetaCurrency = 50,
				},
				PurchaseSound = "/SFX/KeyPickup",
			},
			]]

			{ 
				BuyName = "CardUpgradePoints",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 3,
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 80,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY",
			},

			{ 
				BuyName = "Mixer5Common",
				GameStateRequirements =
				{
					-- if this changes, also update it in ResourceData
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer5Common" },
						Comparison = ">=",
						Value = 3,
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 600,
				},
				PurchaseSound = "/Leftovers/Menu Sounds/TalismanPowderUpLEGENDARY",
			},

			{ 
				BuyName = "WeaponPointsRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 1000,
				},
				PurchaseSound = "/SFX/TitanBloodPickupSFX",
			},
		},

		{
			Name = "MarketScreen_Gifts",
			Icon = "GUI\\Screens\\ResourceShop\\Icon-ExoticGoods",
			CurrencyResourceName = "MetaCurrency",
			RefreshOncePerRun = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGiftsShop", },
				},
			},
			{ 
				BuyName = "GiftPoints",
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 30,
				},
				PurchaseSound = "/SFX/GiftAmbrosiaBottlePickup",
			},
			{ 
				BuyName = "GiftPointsRare",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse"}
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 50,
				},
				PurchaseSound = "/Leftovers/Menu Sounds/TalismanPowderDownLEGENDARY",
			},

			{ 
				BuyName = "GiftPointsEpic",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint"}
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 100,
				},
				PurchaseSound = "/SFX/SuperGemPickup",
			},
			{ 
				BuyName = "SuperGiftPoints",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna"}
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 500,
				},
				PurchaseSound = "/SFX/GiftAmbrosiaBottlePickup",
			},
		},

		{
			Name = "MarketScreen_Sell",
			Icon = "GUI\\Screens\\ResourceShop\\Icon-PawnShop",
			CurrencyResourceName = "MetaCurrency",
			FlipSides = true,
			HideUnaffordable = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSellShop", },
				},
			},

			{ 
				BuyName = "MetaCurrency", BuyAmount = 15,
				Cost =
				{
					PlantMoney = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},			
			{
				BuyName = "MetaCurrency", BuyAmount = 20,
				Cost =
				{
					FishFCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 40,
				Cost =
				{
					FishFRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 75,
				Cost =
				{
					FishFLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 24,
				Cost =
				{
					FishGCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 48,
				Cost =
				{
					FishGRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 84,
				Cost =
				{
					FishGLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 28,
				Cost =
				{
					FishHCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 56,
				Cost =
				{
					FishHRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 98,
				Cost =
				{
					FishHLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 32,
				Cost =
				{
					FishICommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 64,
				Cost =
				{
					FishIRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 112,
				Cost =
				{
					FishILegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 20,
				Cost =
				{
					FishNCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 40,
				Cost =
				{
					FishNRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 75,
				Cost =
				{
					FishNLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 24,
				Cost =
				{
					FishOCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 48,
				Cost =
				{
					FishORare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 84,
				Cost =
				{
					FishOLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 28,
				Cost =
				{
					FishPCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 56,
				Cost =
				{
					FishPRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 98,
				Cost =
				{
					FishPLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 24,
				Cost =
				{
					FishBCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 48,
				Cost =
				{
					FishBRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 84,
				Cost =
				{
					FishBLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 66,
				Cost =
				{
					FishChaosCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 132,
				Cost =
				{
					FishChaosRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 231,
				Cost =
				{
					FishChaosLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
		},

		{
			Name = "MarketScreen_Exchange",
			Icon = "GUI\\Screens\\ResourceShop\\Icon-Recycling",
			CurrencyResourceName = "CosmeticsPoints",
			FlipSides = true,
			HideUnaffordable = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "WorldUpgrades", },
					HasAll = { "WorldUpgradeExchangeShop", },
				},
			},

			-- TrashPoints
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 1,
				GameStateRequirements =
				{
					-- None
				},
				Cost =
				{
					TrashPoints = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/TrashPickup",
				ExchangeVoiceLines =
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					PreLineWait = 0.45,
					UsePlayerSource = true,
					SkipAnim = true,
					SuccessiveChanceToPlayAll = 0.25,
					GameStateRequirements =
					{
						{
							Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
							Comparison = "==",
							Value = 4,
						}
					},
					Cooldowns =
					{
						{ Name = "MelMarketInteraction", Time = 8 },
					},

					{ Cue = "/VO/Melinoe_3771", Text = "Rubbish for recycling." },
					{ Cue = "/VO/Melinoe_3772", Text = "On behalf of Eris." },
				},
			},

			-- Ash
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 2,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "MetaUpgradeState", "ChanneledCast", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "HealthRegen", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "CastCount", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "CastBuff", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "BonusHealth", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "BonusDodge", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "ManaOverTime", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "MagicCrit", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "SprintShield", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "LastStand", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "StartingGold", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "RarityBoost", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "BonusRarity", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "TradeOff", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "ScreenReroll", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "EpicRarityBoost", "Unlocked" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "CardDraw", "Unlocked" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "LobAmmoBoostAspect5", "ToolPickaxe", "ToolExorcismBook2", },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll = { "WorldUpgradeQuestLog", "WorldUpgradeSellShop", "WorldUpgradeCardUpgradeSystem", "WorldUpgradeMetaCardPointsCommonRunProgress", },
					},
				},
				Cost =
				{
					MetaCardPointsCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},

			-- Psyche (Exorcism)
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 3,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeLimitLevel", },
						Comparison = ">=",
						Value = 15,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "BaseStaffAspect5", "ToolExorcismBook2" },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll = { "WorldUpgradeShadeMercs", "WorldUpgradeElementalBoons" },
					},
				},
				Cost =
				{
					MemPointsCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			-- Bones (Fish)
			--[[
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 7,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll = { "WorldUpgradeGiftsShop", },
					},
				},
				Cost =
				{
					MetaCurrency = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			]]

			-- MetaFabric ?
			-- CardUpgradePoints ?

			-- Picked Plants
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 12,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "ChanneledCast", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeBountyBoard",
							"WorldUpgradeHarvestUpgrade",
							--"WorldUpgradeGardenTent",
							--"WorldUpgradeGardenTaverna",
							"WorldUpgradeAltRunDoor",
							"WorldUpgradeNarcissusWaters",
							"WorldUpgradePostBossWellShops",
							--"WorldUpgradePauseChronosFight",
							"WorldUpgradePostBossGiftRack",
							"WorldUpgradeBathHouse",
							"WorldUpgradeQuestLog",
							"WorldUpgradePinning",
							"WorldUpgradeResourceFinder",
							"WorldUpgradeWellShops",
							"WorldUpgradeErebusReprieve",
							"WorldUpgradeFountainUpgrade1",
							"WorldUpgradeToolsShop",
							"WorldUpgradeGarden",
						},
					},
				},
				Cost =
				{
					PlantFMoly = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 14,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "LowManaDamageBonus", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "StaffClearCastAspect", },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeFountainUpgrade1",
							"WorldUpgradeBathHouse",
							"WorldUpgradeOceanusReprieve",
							"WorldUpgradePostBossGiftRack",
							"WorldUpgradeErebusSafeZones",
							"WorldUpgradeSurfacePenaltyCure",
							"WorldUpgradeHarvestUpgrade",
							"WorldUpgradeGardenT2",
							"WorldUpgradeFamiliarSystem",
						},
					},
				},
				Cost =
				{
					PlantGLotus = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 16,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "SorceryRegenUpgrade", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeFieldsRewardFinder",
							"WorldUpgradeRelationshipBar",
						},
					},
				},
				Cost =
				{
					PlantHMyrtle = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 20,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "ScreenReroll", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "DaggerHomingThrowAspect", },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeTartarusReprieve",
							"WorldUpgradeGameStats",
						},
					},
				},
				Cost =
				{
					PlantIShaderot = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 12,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "MagicCrit", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "LobImpulseAspect", },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeEphyraZoomOut",
							"WorldUpgradeSurfacePenaltyCure",
							"WorldUpgradeHarvestUpgrade",
						},
					},
				},
				Cost =
				{
					PlantNMoss = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 14,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "TorchSprintRecallAspect", "ToolFishingRod2", },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeFishingPoint",
							"WorldUpgradeSurfaceShops",
							"WorldUpgradeThessalyReprieve",
						},
					},
				},
				Cost =
				{
					PlantODriftwood = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 16,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeOlympusReprieve",
							"WorldUpgradeErebusSafeZones",
							"WorldUpgradeKeepsakeSaveFirst",
						},
					},
					{
						Path = { "GameState", "MetaUpgradeState", "BonusRarity", "Level" },
						Comparison = ">=",
						Value = 3,
					},
				},
				Cost =
				{
					PlantPIris = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},

			-- Grown Plants
			{
				BuyName = "CosmeticsPoints", BuyAmount = 48,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "CastBuff", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "LobCloseAttackAspect", },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeMorosUnlock",
							"WorldUpgradeSellShop",
							"WorldUpgradeWellShops",
							"WorldUpgradeBathHouse",
							"WorldUpgradeFountainUpgrade2",
							"WorldUpgradeShadeMercs",
							"WorldUpgradeChallengeSwitches1",
							"WorldUpgradeSurfacePenaltyCure",
						},
					},
				},
				Cost =
				{
					PlantFNightshade = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{
				BuyName = "CosmeticsPoints", BuyAmount = 56,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "BonusDodge", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeFishingPoint",
							"WorldUpgradePostBossWellShops",
							"WorldUpgradeFountainUpgrade2",
							"WorldUpgradeMetaCardPointsCommonRunProgress",
							"WorldUpgradeGardenT2",
							"WorldUpgradeNarcissusWaters",
						},
					},
				},
				Cost =
				{
					PlantGCattail = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 64,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeMetaCurrencyRunProgress",
							"WorldUpgradeGardenT3",
							"WorldUpgradeFamiliarRest",
						},
					},
				},
				Cost =
				{
					PlantHWheat = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 80,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "LowHealthBonus", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "LobImpulseAspect", },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeGameStats",
							"WorldUpgradeBoonList",
						},
					},
				},
				Cost =
				{
					PlantIPoppy = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 48,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeTaverna",
							"WorldUpgradePostBossSurfaceShops",
							"WorldUpgradeGiftDropRunProgress",
							"WorldUpgradeGardenT3",
						},
					},
				},
				Cost =
				{
					PlantNGarlic = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 56,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "MetaToRunUpgrade", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll = { "ToolShovel2", },
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradePostBossSurfaceShops",
							"WorldUpgradeErebusSafeZones",
							"WorldUpgradeSafeZoneSpellCharge",
							"WorldUpgradeMemPointsCommonRunProgress",
							"WorldUpgradeNarcissusWaters",
						},
					},
				},
				Cost =
				{
					PlantOMandrake = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 64,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeMetaUpgradeSaveLayout",
							"WorldUpgradeFamiliarRest",
						},
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"ToolShovel",
							"ToolShovel2",
						},
					},
					{
						Path = { "GameState", "MetaUpgradeState", "StatusVulnerability", "Level" },
						Comparison = ">=",
						Value = 3,
					},
				},
				Cost =
				{
					PlantPOlive = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 88,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeSurfacePenaltyCure",
						},
					},
				},

				Cost =
				{
					PlantChaosThalamus = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},

			-- Ores
			{
				BuyName = "CosmeticsPoints", BuyAmount = 27,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "HealthRegen", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"WeaponDagger",
							"WeaponTorch",
							"WeaponAxe",
							"WeaponSuit",
							"StaffClearCastAspect",
							"DaggerBlockAspect",
							"BaseStaffAspect5",
							"DaggerBackstabAspect5",
							"AxeRecoveryAspect5",
							"TorchSpecialDurationAspect5",
							"ToolExorcismBook",
							"ToolShovel",
						},
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeQuestLog",
							"WorldUpgradeErebusReprieve",
						},
					},
				},
				Cost =
				{
					OreFSilver = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 32,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "MagicCrit", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"StaffSelfHitAspect",
							"LobAmmoBoostAspect5",
						},
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeOceanusReprieve",
							"WorldUpgradeBreakableValue1",
							"WorldUpgradeUnusedWeaponBonus",
							"WorldUpgradePostBossGiftRack",
							"WorldUpgradeChallengeSwitches1",
						},
					},
				},
				Cost =
				{
					OreGLime = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 36,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "MaxHealthPerRoom", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"WeaponLob",
							"DaggerBlockAspect",
							"AxePerfectCriticalAspect",
							"ToolPickaxe2",
						},
					},
				},
				Cost =
				{
					OreHGlassrock = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 45,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "StartingGold", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"ToolExorcismBook2",
						},
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeTartarusReprieve",
							"WorldUpgradeRunHistory",
							"WorldUpgradeToolUpgradeSystem",
						},
					},
				},
				Cost =
				{
					OreIMarble = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 27,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "BonusHealth", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"WeaponLob",
							"TorchDetonateAspect",
							"AxeRecoveryAspect5",
							"ToolFishingRod",
							"ToolShovel2",
						},
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeWeaponUpgradeSystem",
							"WorldUpgradeToolUpgradeSystem",
						},
					},
				},
				Cost =
				{
					OreNBronze = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 32,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeState", "ChanneledBlock", "Level" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"LobCloseAttackAspect",
							"ToolPickaxe2",
						},
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeThessalyReprieve",
							"WorldUpgradeToolUpgradeSystem",
						},
					},
				},
				Cost =
				{
					OreOIron = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 36,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "MetaUpgradeState", "StartingGold", "Unlocked" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"SuitBaseAspect5",
						},
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeOlympusReprieve",
							"WorldUpgradeChallengeSwitchesExtra1",
						},
					},
				},
				Cost =
				{
					OrePAdamant = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 177,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked", },
						HasAll =
						{
							"SuitMarkCritAspect",
						},
					},
					{
						Path = { "GameState", "WorldUpgrades", },
						HasAll =
						{
							"WorldUpgradeBountyBoardRepeat",
						},
					},
				},
				Cost =
				{
					OreChaosProtoplasm = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},


			-- GiftPoints, GiftPointsRare, GiftPointsEpic ?
		},
	},

	--[[
	CategoryFormat =
	{
		FontSize = 22,
		Color = Color.CodexTitleUnselected,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Center",
	},
	]]

	ItemNameFormat =
	{
		FontSize = 24,
		OffsetX = -285, OffsetY = 0,
		Width = 720,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		VerticalJustification = "Center",
		LuaKey = "TempTextData",
		LineSpacingBottom = 20,
		TextSymbolScale = 0.8,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemBuyAmountFormat =
	{
		Text = "MarketScreen_BuyAmount",
		FontSize = 16,
		OffsetX = -316, OffsetY = 33,
		Width = 720,
		Font = "LatoBold",
		Color = Color.White,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Center",
		VerticalJustification = "Center",
		LuaKey = "TempTextData",
		LineSpacingBottom = 20,
		TextSymbolScale = 0.8,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemSellAmountFormat =
	{
		Text = "MarketScreen_SellAmount",
		FontSize = 16,
		OffsetX = -316, OffsetY = 33,
		Width = 720,
		Font = "LatoBold",
		Color = Color.White,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Center",
		VerticalJustification = "Center",
		LuaKey = "TempTextData",
		LineSpacingBottom = 20,
		TextSymbolScale = 0.8,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemAmountFormat =
	{
		OffsetX = 80, OffsetY = 0,
		Width = 650,
		Justification = "Left",
		LuaKey = "TempTextData",
		TextSymbolScale = 0.8,
		Font = "LatoBold",
		FontSize = 18,
		Color = { 232, 232, 232, 125 },
		VerticalJustification = "Right",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinOffsetX = 385,
	CostTextOffsetX = 333,
	CostTextOffsetY = -20,
	CostUnaffordableColor = Color.CostUnffordableShop,

	CostTextArgs =
	{
		TextSymbolScale = 0.8,
		FontSize = 22,
		Justification = "Right",
		VerticalJustification = "Center",
		Font = "LatoBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		OffsetY = 0,
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,
		
		Order =
		{
			"BackgroundDim",
			"BackgroundBacking",
			"ActionBarBackground",
			"Background",
		},
		
		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = Color.Black,
			Alpha = 0.0,
			AlphaTarget = 0.75,
			AlphaTargetDuration = 0.3,
		},

		BackgroundBacking = 
		{
			Graphic = "BlankObstacle",
			Animation = "ResourceShopBackground",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			Graphic = "BlankObstacle",
			Animation = "ResourceShopItemsBackground",
			X = ScreenCenterX,
			Y = ScreenCenterY,

			ChildrenOrder =
			{
				"MetaCurrencyBacking",
				"BasicResourceButton",
			},

			Children = 
			{
				--[[
				TitleText = 
				{
					Text = "ResourceShopScreen_Title",
					TextArgs =
					{
						FontSize = 26,
						OffsetX = -260, OffsetY = -488,
						Color = Color.White,
						Font = "P22UndergroundSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
						OutlineThickness = 3,
						Justification = "Center",
					}
				},

				HintText = 
				{
					Text = "MarketScreen_Hint",
					TextArgs =
					{
						FontSize = 19,
						OffsetX = 0, OffsetY = -443,
						Width = 840,
						Color = {120, 120, 120, 255},
						Font = "LatoItalic",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
						Justification = "Center",
					},
				}, ]]

				CategoryTitleText = 
				{
					TextArgs =
					{
						FontSize = 26,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						OffsetX = -640, OffsetY = -400,
						DataProperties =
						{
							OpacityWithOwner = true,
						},
					},
				},

				MetaCurrencyBacking =
				{
					Graphic = "BlankObstacle",
					Animation = "GUI\\Screens\\ResourceShop\\ResourceBacking",
					Scale = 1.0,
					OffsetX = 550,
					OffsetY = -418,
				},

				BasicResourceButton =
				{
					Graphic = "BlankInteractableObstacle",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.7,
					OffsetX = 638,
					OffsetY = -334,
					Data =
					{
						--OnMouseOverFunctionName = "MouseOverResourceItem",
						--OnMouseOffFunctionName = "MouseOffResourceItem",
					},
					InteractProperties =
					{
						FreeFormSelectable = false,
					},
					TextArgs =
					{
						Font = "LatoBold",
						FontSize = 28,
						Color = Color.White,
						ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
						OutlineThickness = 0, OutlineColor = {1, 1, 1, 1},
						OffsetX = -36, OffsetY = 2,
						Justification = "Right",
						FadeTarget = 1.0, FadeOpacity = 1.0,
					},
				},
			},
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			GroupName = "Combat_Menu_Overlay",
			X = 760,
			Y = 240,
			Alpha = 0.0,
			Scale = 1,
			Data =
			{
				OnPressedFunctionName = "WeaponShopScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		ScrollDown =
		{
			Graphic = "ButtonCodexDown",
			GroupName = "Combat_Menu_Overlay",
			X = 760,
			Y = 920,
			Alpha = 0.0,
			Scale = 1,
			Data =
			{
				OnPressedFunctionName = "WeaponShopScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
			UseScreenScaleX = true,
		},

		ActionBar =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"ScrollRight",
				"ScrollLeft",
				"SelectButton",
				"SellAllButton",
			},

			Children = 
			{
				SellAllButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "MarketScreenShowSellAllPrompt",
						ControlHotkeys = { "ItemPin", },
					},
					Text = "Menu_SellAll",
					AltTexts = { "Menu_ExchangeAll" },
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				SelectButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_Buy",
					AltTexts = { "Menu_Sell", "Menu_Exchange" },
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollLeft =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "MarketScreenPrevCategory",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_PrevCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "MarketScreenNextCategory",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseMarketScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},

	},
}