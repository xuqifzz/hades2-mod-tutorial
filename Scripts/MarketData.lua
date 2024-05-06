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
	ItemSpacingY = 120,
	ItemTextBoxOffsetX = 480,
	IconOffsetX = -387,
	IconOffsetY = -3,
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
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ItemCategories =
	{
		{
			Name = "MarketScreen_Resources",
			Icon = "GUI\\Screens\\Inventory\\Icon-Resources",
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
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer5Common" },
						Comparison = ">=",
						Value = 3,
					},
				},
				BuyAmount = 1,
				Cost =
				{
					MetaCurrency = 800,
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
			FlipSides = true,
			HideUnaffordable = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSellShop", },
				},
			},
			--[[
			{ 
				BuyName = "MetaCurrency", BuyAmount = 1,
				Cost =
				{
					PlantNMoss = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 2,
				Cost =
				{
					PlantFMoly = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 4,
				Cost =
				{
					PlantGLotus = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			]]
			--[[
			{ 
				BuyName = "MetaCurrency", BuyAmount = 8,
				Cost =
				{
					PlantHMyrtle = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 10,
				Cost =
				{
					PlantIShaderot = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			]]
			{ 
				BuyName = "MetaCurrency", BuyAmount = 10,
				Cost =
				{
					PlantFNightshade = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 12,
				Cost =
				{
					PlantGCattail = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 14,
				Cost =
				{
					PlantHWheat = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 16,
				Cost =
				{
					PlantIPoppy = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 10,
				Cost =
				{
					PlantNGarlic = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 12,
				Cost =
				{
					PlantOMandrake = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
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
				BuyName = "MetaCurrency", BuyAmount = 19,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				Cost =
				{
					PlantChaosThalamus = 1,
				},
				Priority = true,
				PurchaseSound = "/Leftovers/World Sounds/Caravan Interior/MushroomLogInteract",
			},
			
			{ 	
				BuyName = "MetaCurrency", BuyAmount = 21,
				Cost =
				{
					FishFCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 32,
				Cost =
				{
					FishFRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 55,
				Cost =
				{
					FishFLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 23,
				Cost =
				{
					FishGCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 35,
				Cost =
				{
					FishGRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 62,
				Cost =
				{
					FishGLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 24,
				Cost =
				{
					FishHCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 37,
				Cost =
				{
					FishHRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 68,
				Cost =
				{
					FishHLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 29,
				Cost =
				{
					FishICommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 39,
				Cost =
				{
					FishIRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 78,
				Cost =
				{
					FishILegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 34,
				Cost =
				{
					FishNCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 67,
				Cost =
				{
					FishNRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 93,
				Cost =
				{
					FishNLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 36,
				Cost =
				{
					FishOCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 59,
				Cost =
				{
					FishORare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 87,
				Cost =
				{
					FishOLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 3,
				Cost =
				{
					FishPCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 37,
				Cost =
				{
					FishPRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 51,
				Cost =
				{
					FishPLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 89,
				Cost =
				{
					FishBCommon = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 60,
				Cost =
				{
					FishBRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 100,
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
				BuyName = "MetaCurrency", BuyAmount = 111,
				Cost =
				{
					FishChaosRare = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
			{ 
				BuyName = "MetaCurrency", BuyAmount = 222,
				Cost =
				{
					FishChaosLegendary = 1,
				},
				Priority = true,
				PurchaseSound = "/SFX/KeyPickup",
			},
		}
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
		OffsetX = -300, OffsetY = 0,
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
		FontSize = 17,
		OffsetX = -333, OffsetY = 33,
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
		FontSize = 17,
		OffsetX = -333, OffsetY = 33,
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
	CostTextOffsetX = 330,
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
						ResourceName = "MetaCurrency",
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
			},

			Children = 
			{
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
					AltText = "Menu_Sell",
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