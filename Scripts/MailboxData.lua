ScreenData.MailboxScreen =
{
	Components = {},
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/GeneralWhooshMENULoud",
	CloseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

	MaxNonPriorityOffers = 1,

	MoneySpentPerCharonPoint = 1000,
	CharonPointsRequirements =
	{
		{
			PathTrue = { "GameState", "UseRecord", "CharonPointsDrop" },
		},
		NamedRequirements = { "MailboxUnlocked" },
	},

	NumSales = 0,
	NumItems = 0,

	CategoryStartX = 735,
	CategoryStartY = 165,
	CategorySpacingX = 226,

	ItemStartX = 759,
	ItemStartY = 335,
	ItemSpacingY = 120,
	ItemTextBoxOffsetX = 480,
	IconOffsetX = -387,
	IconOffsetY = -3,
	ItemsPerPage = 5,
	ScrollOffset = 0,

	PinOffsetX = 388,

	ItemAnimation = "GUI\\Screens\\ResourceShop\\Button",
	ItemHighlightAnimation = "GUI\\Screens\\ResourceShop\\Button_Highlight",

	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_Overlay",
		FreeFormSelectWrapY = true,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 2,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
	},

	ItemCategories =
	{
		{
			Name = "MailboxScreen_Default",
			GameStateRequirements =
			{
				-- None
			},
			{ 
				BuyName = "MetaCardPointsCommon", BuyAmount = 20,
				DeliveryTimeMin = 20,
				DeliveryTimeMax = 20,
				Cost =
				{
					CharonPoints = 1,
				},
				Priority = true, 
				PurchaseSound = "/SFX/KeyPickup",
			},

			{ 
				BuyName = "MemPointsCommon", BuyAmount = 80,
				DeliveryTimeMin = 40,
				DeliveryTimeMax = 40,
				Cost =
				{
					CharonPoints = 2,
				},
				Priority = true, 
				PurchaseSound = "/SFX/GiftAmbrosiaBottlePickup",
			},
			{ 
				BuyName = "MetaFabric", BuyAmount = 10,
				DeliveryTimeMin = 60,
				DeliveryTimeMax = 60,
				Cost =
				{
					CharonPoints = 3,
				},
				Priority = true, 
				PurchaseSound = "/SFX/TitanBloodPickupSFX",
			},
			{ 
				BuyName = "CardUpgradePoints", BuyAmount = 8,
				DeliveryTimeMin = 80,
				DeliveryTimeMax = 80,
				Cost =
				{
					CharonPoints = 4,
				},
				Priority = true, 
				PurchaseSound = "/SFX/TitanBloodPickupSFX",

				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "CardUpgradePoints" },
						Comparison = ">=",
						Value = 8,
					},
				},
			},
			{ 
				BuyName = "WeaponPointsRare", BuyAmount = 2,
				DeliveryTimeMin = 100,
				DeliveryTimeMax = 100,
				Cost =
				{
					CharonPoints = 5,
				},
				Priority = true, 
				PurchaseSound = "/SFX/TitanBloodPickupSFX",

				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "WeaponPointsRare" },
						Comparison = ">=",
						Value = 5,
					},
				},
			},
		},
	},

	CostTextArgs =
	{
		TextSymbolScale = 0.8,
		FontSize = 22,
		Justification = "Center",
		VerticalJustification = "Center",
		Font = "LatoBold",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		OffsetY = 0,
		OffsetX= 310,
	},

	ItemNameFormat =
	{
		FontSize = 24,
		OffsetX = -298, OffsetY = -13,
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
		FontSize = 17,
		OffsetX = -333, OffsetY = 33,
		Width = 720,
		Font = "LatoBold",
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

	ItemDeliveryTimeFormat =
	{
		FontSize = 18,
		OffsetX = -298, OffsetY = 18,
		Width = 720,
		Font = "LatoItalic",
		Color = {200, 200, 200, 125},
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		VerticalJustification = "Center",
		LuaKey = "TempTextData",
		TextSymbolScale = 0.8,
		VariableAutoFormat = "WhiteFormat",
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


	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
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
			AlphaTarget = 0.9,
			AlphaTargetDuration = 0.3,
		},

		Background = 
		{
			Graphic = "BlankObstacle",
			Animation = "MailboxScreenBackground",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				TitleText = 
				{
					Text = "MailboxScreen_Title",
					TextArgs =
					{
						FontSize = 32,
						OffsetX = -182, OffsetY = -478,
						Color = Color.White,
						Font = "P22UndergroundSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
						OutlineThickness = 3,
						Justification = "Center",
					}
				},

				--[[HintText = 
				{
					Text = "MailboxScreen_Hint",
					TextArgs =
					{
						FontSize = 18,
						OffsetX = 0, OffsetY = -443,
						Width = 840,
						Color = {200, 200, 200, 255},
						TextSymbolScale = 0.8,
						Font = "LatoItalic",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
						Justification = "Center",
					},
				},]]

				BasicResourceButton =
				{
					Graphic = "BlankInteractableObstacle",
					GroupName = "Combat_Menu_Overlay",
					Scale = 0.7,
					OffsetX = 622,
					OffsetY = -334,
					Data =
					{
						ResourceName = "CharonPoints",
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
						OffsetX = -36, OffsetY = 4,
						Justification = "Right",
						FadeTarget = 1.0, FadeOpacity = 1.0,
					},
				},
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
					Text = "Menu_Order",
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
						OnPressedFunctionName = "CloseMailboxScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},

	},
}