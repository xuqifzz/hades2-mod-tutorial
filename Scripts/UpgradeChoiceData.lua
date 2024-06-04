ScreenData.UpgradeChoice =
{
	BlockPause = true,

	GamepadNavigation =
	{
		FreeFormSelectWrapY = true,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	AllowAdvancedTooltip = false, -- Block the normal hotkey, works through TraitTrayButton
	Components = {},
	FreezePlayerArgs =   
	{
		DisableTray = false,
	},

	MaxChoices = 3,

	RarityBackingAnimations =
	{
		Rare = "BoonSlotRare",
		Epic = "BoonSlotEpic",
		Heroic = "BoonSlotHeroic",
		Legendary = "BoonSlotLegendary",
		Duo = "BoonSlotDuo",
	},

	-- UpgradeChoiceButton Formats

	ButtonSpacingY = 256,
	ButtonOffsetX = 350,
	IconOffsetX = -504,
	IconOffsetY = -54,
	LineHeight = 35,
	BlessingOffsetY = 0,

	TooltipOffsetX = 735,

	QuestIconOffsetX = -100,
	QuestIconOffsetY = 65,
	PoseidonDuoIconOffsetX = 0,
	PoseidonDuoIconOffsetY = 65,
	RerollIconOffsetX = 450,
	BonusIconOffsetX = 470,
	BonusIconOffsetY = -95,
	PurchaseButton =
	{
		Name = "BoonSlotBase",
		Group = "Combat_Menu",
	},

	Highlight =
	{
		Name = "BlankObstacle",
		Group = "Combat_Menu",
	},

	Icon =
	{
		Name = "BlankObstacle",
		Group = "Combat_Menu",
		Scale = 0.6,
	},

	Frame =
	{
		Name = "BlankObstacle",
		Group = "Combat_Menu", 
		Scale = 0.6,
	},

	RarityText =
	{
		FontSize = 27,
		OffsetX = 410, OffsetY = -60,
		Width = 720,
		Color = color,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Right",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	TitleText =
	{
		FontSize = 27,
		OffsetX = -420, OffsetY = -60,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		LuaKey = "TooltipData",
		LuaValue = {},
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	DescriptionText =
	{
		OffsetX = -420,
		OffsetY = -35,
		Width = 920,
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 5,
		LuaKey = "TooltipData",
		LuaValue = {},
		Format = "BaseFormat",
		UseDescription = true,
		VariableAutoFormat = "BoldFormatGraft",
		TextSymbolScale = 0.8,
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	StatLineLeft =
	{
		OffsetX = -420,
		Width = 420,
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 5,
		LuaKey = "TooltipData",
		LuaValue = {},
		Format = "BaseFormat",
		VariableAutoFormat = "BoldFormatGraft",
		TextSymbolScale = 0.8,
	},

	StatLineRight =
	{
		OffsetX = 0,
		Width = 485,
		Justification = "Left",
		VerticalJustification = "Top",
		LineSpacingBottom = 5,
		UseDescription = true,
		LuaKey = "TooltipData",
		LuaValue = {},
		Format = "BaseFormat",
		VariableAutoFormat = "BoldFormatGraft",
		TextSymbolScale = 0.8,
	},

	FlavorText = 
	{	
		OffsetX = -420,
		OffsetY = 80,
		Width = 900,
		Color = Color.FlavorTextPurple,
		Font = "LatoItalic",
		FontSize = 18,
		ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 2},
		Justification = "Left",
	},

	ExchangeIconScale = 1.0,
	ExchangeIconOffsetX = -506,
	ExchangeIconOffsetY = 70,

	ExchangeFlashSpeed = 1.0,
	ExchangeFlashMinFraction = 0.2,
	ExchangeFlashMaxFraction = 0.7,
	ExchangeFlashColor = Color.Red,

	ExchangeSymbol =
	{
		Name = "BlankObstacle",
		Animation = "TraitExchangeSymbol",
		Group = "Combat_Menu_Overlay",
		OffsetX = -506,
		OffsetY = 9,
		Scale = 0.8
	},

	ElementIcon =
	{
		Group = "Combat_Menu", 
		Scale = 1.0,
		XShift = -110,
		YShift = -100,
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"OlympusBackground",
			"ShopBackgroundDim",
			"ShopBackgroundGradient",
			"ShopBackground",
			"ShopLighting",
			"SourceIcon",
			"ActionBarBackground",
			"TitleText",
			"FlavorText",
		},

		OlympusBackground =
		{
			Graphic = "rectangle01",
			AnimationName = "DialogueBackground_Olympus_BoonScreen",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},
		
		ShopBackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 10.0,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = Color.White,
			Alpha = 0.0,
			AlphaTarget = 0.34,
			AlphaTargetDuration = 0.3,
		},

		ShopBackgroundGradient = 
		{
			Graphic = "BoonSelectTopGradient",
			X = ScreenCenterX,
			Y = ScreenCenterY - 111,
		},

		Shopheader =
		{
			Graphic = "BoonSelectHeader",
			X = ScreenCenterX,
			Y = 175,
		},

		ShopLighting = 
		{
			Graphic = "BoonSelectLighting",
			ThingProperties =
			{
				Ambient = 0.0,
			},
		},

		ShopBackground = 
		{
			Graphic = "BoonSelectMel",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		SourceIcon =
		{
			X = 390,
			Y = 170,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.6,
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
		},

		TitleText = 
		{
			--Text = "",
			TextArgs =
			{
				FontSize = 32,
				OffsetX = 0, OffsetY = -455,
				Color = Color.White,
				Font = "P22UndergroundSCLightTitling",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				OutlineThickness = 3,
				Justification = "Center",
			},
		},

		FlavorText = 
		{
			--Text = "",
			TextArgs =
			{
				FontSize = 19,
				OffsetY = -415, Width = 1040,
				Color = { 0.8, 0.8, 0.8, 1.0 },
				Font = "LatoItalic",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
			},
		},

		ActionBarLeft =
		{
			X = UIData.ContextualButtonXLeft,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Left",

			ChildrenOrder =
			{
				"TraitTrayButton",
				"BoonListButton",
			},

			Children = 
			{
				TraitTrayButton = 
				{
					Graphic = "ContextualActionButton",
					X = UIData.ContextualButtonXRight,
					Y = UIData.ContextualButtonY,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "UpgradeChoiceScreenOpenTraitTray",
						ControlHotkeys = { "AdvancedTooltip", },
					},
					Text = "Menu_OpenTraitTray",
					TextArgs = UIData.ContextualButtonFormatLeft,
				},

				BoonListButton =
				{
					Requirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeBoonList" },
						}
					},
					Graphic = "ContextualActionButton",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "AttemptOpenUpgradeChoiceBoonInfo",
						ControlHotkeys = { "MenuInfo", },
					},
					Text = "Menu_TraitList",
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
				"SelectButton",
				"RerollButton",
				"RarifyButton",
			},

			Children = 
			{
				SelectButton =
				{
					Graphic = "ContextualActionButton",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Boon_Select",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				RerollButton =
				{
					Graphic = "ContextualActionButton",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "AttemptPanelReroll",
						ControlHotkeys = { "Reroll", },
					},
					Text = " ",
					AltText = "Boon_Reroll",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				RarifyButton =
				{
					Graphic = "ContextualActionButton",
					Alpha = 0.0,
					Data =
					{
						OnPressedFunctionName = "UpgradeMouseOverUpgradeChoice",
						ControlHotkeys = { "Rarify", },
					},
					Text = "Boon_Upgrade",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

			},
		},
	}
}