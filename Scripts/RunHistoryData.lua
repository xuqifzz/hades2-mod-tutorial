ScreenData.RunHistory =
{
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/FatedListOpen",
	CloseSound = "/SFX/Menu Sounds/FatedListClose",

	AllowInputRepeat = true,

	ItemStartX = 150,
	ItemStartY = 250,
	ItemSpacingY = 48,
	ItemsPerPage = 15,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = 50,

	TraitStartX = 675,
	TraitStartY = 355,
	TraitSpacingX = 95,
	TraitSpacingY = 90,
	TraitsPerColumn = 7,
	TraitIconScale = 0.5,
	TraitMaxColumns = 5,

	MetaUpgradeStartY = 370,
	MetaUpgradeSpacingX = 88,
	MetaUpgradeSpacingY = 125,
	MetaUpgradesPerColumn = 5,
	MetaUpgradeIconScale = 0.15,

	ShrineUpgradeStartX = 685,
	ShrineUpgradeSpacingX = 120,
	ShrineUpgradeSpacingY = 80,
	ShrineUpgradesPerRow = 4,
	ShrineUpgradesMaxRows = 5,
	ShrineUpgradeIconScale = 0.4,
	ShrineUpgradeBackingScale = 0.67,

	Components = {},

	CategoryStartX = 750,
	CategoryStartY = 220,
	CategorySpacingX = 110,

	CategoryIconScale = 0.4,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	RunDataTitleX = 1420,
	RunDataValueX = 1460,
	RunDataStartY = 300,
	RunDataSpacingY = 50,
	MaxVisibleRunDataEntries = 10,

	ActiveCategoryIndex = 1,

	ButtonName = "RunButton",

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 4,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	RunNameClearedFormat =
	{
		Text = "RunHistoryScreen_RunName",
		Color = Color.Purple,
		Font = "P22UndergroundSCMedium",
		VariableAutoFormat = "BoldFormatGraft",
		FontSize = 22,
		FadeOpacity = 1.0,
		OffsetX = 0, OffsetY = 0,
		OutlineThickness = 0,
		OutlineColor = {255, 205, 52, 255},
		ShadowBlur = 0, ShadowColor = {0,0,0,0.7}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	RunNameUnclearedFormat =
	{
		Text = "RunHistoryScreen_RunName",
		Color = Color.Brown,
		Font = "P22UndergroundSCMedium",
		VariableAutoFormat = "BoldFormatGraft",
		FontSize = 22,
		FadeOpacity = 1.0,
		OffsetX = 0, OffsetY = 0,
		OutlineThickness = 0,
		OutlineColor = {255, 205, 52, 255},
		ShadowBlur = 0, ShadowColor = {0,0,0,0.7}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	RunDataTitleFormat =
	{
		FontSize = 24,
		OffsetX = 0, OffsetY = 0,
		Color = Color.White,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right",
	},

	RunDataValueFormat =
	{
		FontSize = 24,
		OffsetX = 0, OffsetY = 0,
		Color = Color.Yellow,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left",
	},
	
	TraitFilters =
	{
		{
			Name = "GameStats_Weapons",
			Icon = "GUI\\Screens\\Inventory\\Icon-Resources",
		},
		{
			Name = "GameStats_Boons",
			Icon = "GUI\\Screens\\Inventory\\Icon-Gifts",
		},
		{
			Name = "GameStats_WeaponUpgrades",
			Icon = "GUI\\Screens\\Inventory\\Icon-Reagents",
		},
		{
			Name = "GameStats_Aspects",
			Icon = "GUI\\Screens\\Inventory\\Icon-Fish",
		},
		{
			Name = "GameStats_Keepsakes",
			Icon = "GUI\\Screens\\Inventory\\Icon-Resources",
		},
	},

	MouseOverScaleTarget = 1.05,
	MouseOverScaleDuration = 0.2,

	ItemCategories =
	{
		{
			Name = "TraitTray_Category_Traits",
			IconComponent = "TraitCount",
			GameStateRequirements =
			{
				-- None
			},
			DisplayFunctionName = "RunHistoryScreenShowTraits",
		},
		{
			Name = "TraitTray_Category_MetaUpgrades",
			IconComponent = "MetaUpgradeCount",
			GameStateRequirements =
			{
				-- None
			},
			DisplayFunctionName = "RunHistoryScreenShowMetaUpgrades",
			TraitStartX = 70,
			TraitStartBottomOffset = 870,
			TraitSpacingX = 110,
			TraitSpacingY = 135,
			TraitsPerColumn = 5,
		},
		{
			Name = "TraitTray_Category_ShrineUpgrades",
			IconComponent = "ShrinePointCount",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpentShrinePointsCache", },
					Comparison = ">=",
					Value = 1,
				},
			},
			DisplayFunctionName = "RunHistoryScreenShowShrineUpgrades",
		},
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"Background",
			"TabSetup",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 9.0,
			Color = { 0.090, 0.055, 0.157, 0.95 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		TabSetup =
		{
			FunctionName = "RunHistoryScreenSetupTabs",
		},

		TitleText = 
		{
			Text = "RunHistoryScreen_Title",
			X = ScreenCenterX,
			Y = ScreenCenterY - 400,
			TextArgs =
			{
				FontSize = 32,
				Font = "SpectralSCLightTitling",
				Color = Color.White,
				Font = "P22UndergroundSCLightTitling",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				OutlineThickness = 3,
				Justification = "Center",
			},
		},

		RunErasedText =
		{
			X = 865,
			Y = 550,
			Alpha = 0.0,
			TextArgs =
			{
				Text = "RunHistoryScreen_RunErased",
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
			},
		},

		SelectionMarker =
		{
			AnimationName = "BountySelect",
			Alpha = 0.0,
			Scale = 0.7,
			ButtonOffsetX = 150,
			ButtonOffsetY = 0,
		},

		HoverFrame =
		{
			AnimationName = "TraitTray_Highlight",
			GroupName = "Combat_Menu_TraitTray_Additive",
			Alpha = 0.0,
		},

		TraitName =
		{
			X = 865,
			Y = 275,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
			},
		},

		TraitListBacking =
		{
			AnimationName = "GUI\\HUD\\TraitTrayBacking",
			X = 865,
			Y = 610,
			Scale = 0.5,
		},

		EasyModeLabel =
		{
			Text = "RunClearScreen_EasyModeLevel",
			X = 1390,
			Y = 250,
			Alpha = 0.0,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		TraitCount =
		{
			X = 730,
			Y = 216,
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\Boon",
			Scale = 0.6,
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 18,
				OffsetY = 0,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				DataProperties =
				{
					OpacityWithOwner = true,
				}
			},
		},

		MetaUpgradeCount =
		{
			X = 840,
			Y = 216,
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\ManaCrystal",
			Scale = 0.6,
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 18,
				OffsetY = 0,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				DataProperties =
				{
					OpacityWithOwner = true,
				}
			},
		},
		
		ShrinePointCount =
		{
			X = 950,
			Y = 216,
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\ShrinePoint",
			Scale = 0.6,
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 18,
				OffsetY = 0,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				DataProperties =
				{
					OpacityWithOwner = true,
				}
			},
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			X = 200,
			Y = 190,
			Alpha = 0,
			InteractProperties =
			{
				FreeFormSelectable = true,
			},
			Data =
			{
				OnPressedFunctionName = "RunHistoryScrollUp",
				ControlHotkeys = { "MenuUp", },
			}
		},

		ScrollDown = 
		{
			Graphic = "ButtonCodexDown",
			X = 200,
			Y = 980,
			Alpha = 0,
			InteractProperties =
			{
				FreeFormSelectable = true,
			},
			Data =
			{
				OnPressedFunctionName = "RunHistoryScrollDown",
				ControlHotkeys = { "MenuDown", },
			}
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
						OnPressedFunctionName = "RunHistoryScreenPrevCategory",
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
						OnPressedFunctionName = "RunHistoryScreenNextCategory",
						ControlHotkeys = { "MenuRight",},
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
						OnPressedFunctionName = "CloseRunHistoryScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}