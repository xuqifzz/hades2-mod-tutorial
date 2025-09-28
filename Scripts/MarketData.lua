ScreenData.MarketScreen =
{
	Components = {},
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/BrokerMenuOpen",
	CloseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

	NumSales = 0,
	NumItems = 0,

	CategoryStartX = 349,
	CategoryStartY = 208,
	CategorySpacingX = 94,

	CategoryIconScale = 0.46,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ItemStartX = 734,
	ItemStartY = 335,
	ItemSpacingY = 118,
	ItemTextBoxOffsetX = 480,
	IconOffsetX = -353,
	IconOffsetY = 0,
	ItemsPerPage = 5,
	ScrollOffset = 0,

	NewTabIconOffsetX = 0,
	NewTabIconOffsetY = -30,

	NewIconOffsetX = 400,
	NewIconOffsetY = 0,
	PinOffsetX = 400,

	TooltipOffsetX = 725,

	NeededResourceBannerIcon = "GUI\\Icons\\CauldronBanner",
	LimitedOfferBannerIcon = "MarketLimitedOffer",
	BannerIconOffsetX = -393,
	BannerIconOffsetY = -32,

	CurrentFlipSides = false,

	CloseAnimation = "MarketScreenOutBuy",
	FadeOutTime = 0.20,
	CloseDestroyWait = 0.35,

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
			FlipSides = false,
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
				PurchaseSound = "/SFX/Menu Sounds/KeepsakeArachneSash",
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

			-- Moon Dust
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
				PurchaseSound = "/Leftovers/Menu Sounds/MoonDustSFX2",
			},
			-- Nightmare
			{ 
				BuyName = "WeaponPointsRare",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
						Comparison = ">=",
						Value = 5,
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 1200,
				},
				PurchaseSound = "/SFX/NightmarePickup",
			},
			-- Star Dust
			{ 
				BuyName = "Mixer5Common",
				GameStateRequirements =
				{
					-- if this changes, also update it in ResourceData
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer5Common" },
						Comparison = ">=",
						Value = 9,
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 1500,
				},
				PurchaseSound = "/SFX/Menu Sounds/StardustPickup",
			},
		},

		{
			Name = "MarketScreen_Gifts",
			Icon = "GUI\\Screens\\ResourceShop\\Icon-ExoticGoods",
			CurrencyResourceName = "MetaCurrency",
			FlipSides = false,
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
					MetaCurrency = 450,
				},
				PurchaseSound = "/SFX/SuperGiftAmbrosiaBottlePickup",
			},
		},

		{
			Name = "MarketScreen_Sell",
			Icon = "GUI\\Screens\\ResourceShop\\Icon-PawnShop",
			CurrencyResourceName = "MetaCurrency",
			FlipSides = true,
			HideUnaffordable = true,
			PurchaseSound = "/Leftovers/SFX/CurLandSlime",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSellShop", },
				},
			},

			{
				BuyName = "MetaCurrency", BuyAmount = 20,
				Cost =
				{
					FishFCommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 40,
				Cost =
				{
					FishFRare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 75,
				Cost =
				{
					FishFLegendary = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 24,
				Cost =
				{
					FishGCommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 48,
				Cost =
				{
					FishGRare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 84,
				Cost =
				{
					FishGLegendary = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 28,
				Cost =
				{
					FishHCommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 56,
				Cost =
				{
					FishHRare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 98,
				Cost =
				{
					FishHLegendary = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 32,
				Cost =
				{
					FishICommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 64,
				Cost =
				{
					FishIRare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 112,
				Cost =
				{
					FishILegendary = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 20,
				Cost =
				{
					FishNCommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 40,
				Cost =
				{
					FishNRare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 75,
				Cost =
				{
					FishNLegendary = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 24,
				Cost =
				{
					FishOCommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 48,
				Cost =
				{
					FishORare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 84,
				Cost =
				{
					FishOLegendary = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 28,
				Cost =
				{
					FishPCommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 56,
				Cost =
				{
					FishPRare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 98,
				Cost =
				{
					FishPLegendary = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 32,
				Cost =
				{
					FishQCommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 64,
				Cost =
				{
					FishQRare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 112,
				Cost =
				{
					FishQLegendary = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 66,
				Cost =
				{
					FishChaosCommon = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 132,
				Cost =
				{
					FishChaosRare = 1,
				},
				Priority = true,
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 231,
				Cost =
				{
					FishChaosLegendary = 1,
				},
				Priority = true,
			},
		},

		{
			Name = "MarketScreen_Exchange",
			Icon = "GUI\\Screens\\ResourceShop\\Icon-Recycling",
			CurrencyResourceName = "CosmeticsPoints",
			FlipSides = true,
			HideUnaffordable = true,
			ShowItemsWithUnmetRequirements = true,
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
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
					},
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
					TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

					{ Cue = "/VO/Melinoe_3771", Text = "Rubbish for recycling." },
					{ Cue = "/VO/Melinoe_3772", Text = "On behalf of Eris." },
				},
			},

			-- Ash
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 2,
				GameStateRequirements =
				{
					NamedRequirements = { "HasAllMetaCardsUnlocked", "HasAllMetaCardsMaxed", },
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
					NamedRequirements = { "HasAllMetaCardsUnlocked", "HasAllMetaCardsMaxed", },
					{
						Path = { "GameState", "MetaUpgradeLimitLevel", },
						Comparison = ">=",
						Value = 15,
					},
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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

			-- Gems
			{
				BuyName = "CosmeticsPoints", BuyAmount = 5,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
					},
				},
				Cost =
				{
					GemPoints = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/GoldCoinPickup",
				RapidPurchaseSound = "/SFX/GoldCoinPickup",
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
					TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

					{ Cue = "/VO/Melinoe_4512", Text = "Some Gemstones for the cause.", PlayFirst = true },
					{ Cue = "/VO/Melinoe_4513", Text = "Gemstones for you, Broker." },
					{ Cue = "/VO/Melinoe_4514", Text = "More Gemstones here." },
					{ Cue = "/VO/Melinoe_4515", Text = "Dropping these off." },
				},
			},

			-- MetaFabric ?
			-- CardUpgradePoints ?

			-- Picked Plants
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 12,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
					NamedRequirements =
					{
						"HasAllFrogUpgrades",
						"HasAllCatUpgrades",
						"HasAllRavenUpgrades",
						"HasAllHoundUpgrades",
						"HasAllPolecatUpgrades",
					},
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
						FunctionName = "HasAllWorldUpgradesRequiringResource",
					},
				},
				Cost =
				{
					PlantPIris = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 20,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
					},
				},
				Cost =
				{
					PlantQFang = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},

			-- Grown Plants
			{
				BuyName = "CosmeticsPoints", BuyAmount = 80,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 100,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 120,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 140,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 80,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 100,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 120,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 140,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
					},
				},
				Cost =
				{
					PlantQSnakereed = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 99,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 33,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 40,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 47,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 33,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 40,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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
				BuyName = "CosmeticsPoints", BuyAmount = 47,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
					},
				},
				Cost =
				{
					OreQScales = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "CosmeticsPoints", BuyAmount = 177,
				GameStateRequirements =
				{
					{
						FunctionName = "HasAllWorldUpgradesRequiringResource",
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

	ItemNameFormat =
	{
		FontSize = 24,
		OffsetX = -263, OffsetY = 0,
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

	UnmetRequirementsItemNameFormat =
	{
		FontSize = 24,
		OffsetX = -263, OffsetY = 0,
		Width = 720,
		Font = "P22UndergroundSCMedium",
		Color = Color.Gray,
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
		OffsetX = -294, OffsetY = 33,
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
		OffsetX = -294, OffsetY = 33,
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
		OffsetX = 102, OffsetY = 0,
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

	CostTextOffsetX = 355,
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
			AnimationName = "MarketScreenIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,

			ChildrenOrder =
			{
				--"MetaCurrencyBacking",
				"BasicResourceButton",
			},

			Children = 
			{
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

				--[[
				MetaCurrencyBacking =
				{
					Graphic = "BlankObstacle",
					Animation = "GUI\\Screens\\ResourceShop\\ResourceBacking",
					Scale = 1.0,
					OffsetX = 550,
					OffsetY = -418,
				},
				]]

				BasicResourceButton =
				{
					Graphic = "BlankInteractableObstacle",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					AlphaTarget = 1.0,
					AlphaTargetDuration = 0.6,
					Scale = 0.7,
					OffsetX = 615,
					OffsetY = -330,
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
			Y = 250,
			Alpha = 0.0,
			Scale = 1.2,
			Data =
			{
				OnPressedFunctionName = "WeaponShopScrollUp",
				ControlHotkey = "MenuUp",
			},
		},

		ScrollDown =
		{
			Graphic = "ButtonCodexDown",
			GroupName = "Combat_Menu_Overlay",
			X = 760,
			Y = 900,
			Alpha = 0.0,
			Scale = 1.2,
			Data =
			{
				OnPressedFunctionName = "WeaponShopScrollDown",
				ControlHotkey = "MenuDown",
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
			UseScreenScaleX = true,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.1,
		},

		ActionBarLeft =
		{
			X = UIData.ContextualButtonXLeft,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Left",

			ChildrenOrder =
			{
				"ScrollLeft",
				"ScrollRight",
			},

			Children = 
			{
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
					TextArgs = UIData.ContextualButtonFormatLeft,
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
					TextArgs = UIData.ContextualButtonFormatLeft,
				},
			},
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

-- Market / Broker / Wretched Broker
GlobalVoiceLines.OpenedMarketVoiceLines =
{
	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "BrokerSellShop",
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeSellShop" },
			},
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasNone = { "WorldUpgradeExchangeShop" },
			},
		},
		{ Cue = "/VO/Melinoe_3763", Text = "I can now trade some of my findings for more Bones." },
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "BrokerExchangeShop",
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeExchangeShop" },
			},
		},
		{ Cue = "/VO/Melinoe_3764", Text = "Whatever I no longer need, I can recycle now." },
	},

	{
		SkipAnim = true,
		PlayOnce = true,
		PlayOnceContext = "BrokerSellShop",
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAny = { "WorldUpgradeSellShop" },
			},
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasNone = { "WorldUpgradeExchangeShop" },
			},
		},
		{ Cue = "/VO/Melinoe_3763", Text = "I can now trade some of my findings for more Bones." },
	},

	{
		SkipAnim = true,
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },
			},
			{
				FunctionName = "IsMarketItemInStock",
				FunctionArgs = { Name = "CardUpgradePoints" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelMarketIntroSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_3987", Text = "You carry Moon Dust now..." },
	},
	{
		SkipAnim = true,
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		GameStateRequirements =
		{
			{
				FunctionName = "IsMarketItemInStock",
				FunctionArgs = { Name = "WeaponPointsRare" },
			},
		},
		Cooldowns =
		{
			{ Name = "MelMarketIntroSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_3986", Text = "Nightmare on offer..." },
	},
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 0.6,
		Cooldowns =
		{
			{ Name = "MelMarketIntroSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_0552", Text = "Hail, Broker.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2345", Text = "Good evening, Broker." },
		{ Cue = "/VO/Melinoe_2346", Text = "Broker." },
		{ Cue = "/VO/Melinoe_2347", Text = "Just checking up on you." },
		{ Cue = "/VO/Melinoe_2348", Text = "What do I need..." },
	},
}
GlobalVoiceLines.TradedMarketItemVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "MelMarketInteraction", Time = 12 },
	},
	-- recycling
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SkipAnim = true,
		SuccessiveChanceToPlay = 0.75,
		GameStateRequirements =
		{
			{
				Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
				Comparison = "==",
				Value = 4,
			}
		},

		{ Cue = "/VO/Melinoe_3765", Text = "Returning to the Earth.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3766", Text = "This is for return." },
		{ Cue = "/VO/Melinoe_3767", Text = "Back to Gaia." },
		{ Cue = "/VO/Melinoe_3768", Text = "Recycle please, Broker." },
		{ Cue = "/VO/Melinoe_3769", Text = "Some more recycling." },
		{ Cue = "/VO/Melinoe_3770", Text = "For recycling." },
	},
	-- selling
	{
		GameStateRequirements =
		{
			{
				Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
				Comparison = "==",
				Value = 3,
			}
		},

		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SkipAnim = true,
		SuccessiveChanceToPlay = 0.75,

		{ Cue = "/VO/Melinoe_0558", Text = "Here you are." },
		{ Cue = "/VO/Melinoe_0559", Text = "Fair trade." },
		{ Cue = "/VO/Melinoe_4249", Text = "Catch of the night." },
		{ Cue = "/VO/Melinoe_4250", Text = "Tonight's catch." },
		{ Cue = "/VO/Melinoe_4251", Text = "Freshly caught." },
		{ Cue = "/VO/Melinoe_4252", Text = "Freshly caught... more or less." },
		{ Cue = "/VO/Melinoe_4253", Text = "Careful with this one." },
		{ Cue = "/VO/Melinoe_4254", Text = "Could use the Bones." },
		{ Cue = "/VO/Melinoe_4255", Text = "Take care of this one please." },
		{ Cue = "/VO/Melinoe_4256", Text = "Here's a big one." },
	},
	-- buying
	{
		GameStateRequirements =
		{
			{
				Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
				Comparison = "!=",
				Value = 3,
			},
			{
				Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
				Comparison = "!=",
				Value = 4,
			},
			{
				PathFromArgs = true,
				PathFalse = { "ItemData", "Priority" },
			},
		},
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SkipAnim = true,
		SuccessiveChanceToPlayAll = 0.15,

		{ Cue = "/VO/Melinoe_3983", Text = "I'll take the Special." },
		{ Cue = "/VO/Melinoe_3984", Text = "Appreciate the deal." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
				Comparison = "!=",
				Value = 3,
			},
			{
				Path = { "ActiveScreens", "MarketScreen", "ActiveCategoryIndex" },
				Comparison = "!=",
				Value = 4,
			}
		},

		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SkipAnim = true,
		SuccessiveChanceToPlay = 0.75,

		{ Cue = "/VO/Melinoe_0554", Text = "I'll take it." },
		{ Cue = "/VO/Melinoe_0555", Text = "One, please." },
		{ Cue = "/VO/Melinoe_0556", Text = "This one." },
		{ Cue = "/VO/Melinoe_0558", Text = "Here you are." },
		{ Cue = "/VO/Melinoe_0559", Text = "Fair trade." },
		{ Cue = "/VO/Melinoe_2349", Text = "Here are the Bones." },
		{ Cue = "/VO/Melinoe_2350", Text = "Trade you." },
		{ Cue = "/VO/Melinoe_2351", Text = "I've need of that." },
		{ Cue = "/VO/Melinoe_2352", Text = "Should be of use." },
	},
}
GlobalVoiceLines.ClosedMarketVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.1,
		PlayOnceFromTableThisRun = true,
		PreLineWait = 0.45,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_0560", Text = "Farewell." },
		{ Cue = "/VO/Melinoe_2353", Text = "Be well." },
		{ Cue = "/VO/Melinoe_2354", Text = "Take care, then." },
	},
}