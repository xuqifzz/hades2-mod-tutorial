ScreenData.RunHistory =
{
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/FatedListOpen",
	CloseSound = "/SFX/Menu Sounds/FatedListClose",

	AllowInputRepeat = true,

	ItemStartX = 200,
	ItemStartY = 250,
	ItemSpacingY = 48,
	ItemsPerPage = 15,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = 50,

	TraitStartX = 650,
	TraitStartY = 340,
	TraitSpacingX = 90,
	TraitSpacingY = 90,	
	TraitsPerColumn = 8,
	MaxColumns = 4,	

	Components = {},

	CategoryStartX = 740,
	CategoryStartY = 250,
	CategorySpacingX = 110,

	CategoryIconScale = 0.40,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ActiveCategoryIndex = 1,

	ButtonName = "RunButton",

	RunNameClearedFormat =
	{
		Text = "RunHistoryScreen_RunName",
		Color = Color.Purple,
		Font = "P22UndergroundSCMedium",
		VariableAutoFormat = "BoldFormatGraft",
		FontSize = 22,
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

	HeaderY = 320,
	RowStartY = 380,
	RowSpacingTraits = 40,
	IconScaleTraits = 0.5,
	IconScaleMetaUpgrades = 0.13,
	IconScaleShrineUpgrades = 0.5,

	MouseOverScaleTarget = 1.05,
	MouseOverScaleDuration = 0.2,

	TraitNameFormat =
	{
		FontSize = 22,
		OffsetX = 40, OffsetY = 0,
		Color = Color.White,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left",
	},

	ItemCategories =
	{
		{
			Name = "TraitTray_Category_Traits",
			--Icon = "GUI\\Icons\\Boon",
			IconComponent = "TraitCount",
			GameStateRequirements =
			{
				-- None
			},
			DisplayFunctionName = "RunHistoryScreenShowTraits",
		},
		{
			Name = "TraitTray_Category_MetaUpgrades",
			--Icon = "GUI\\Icons\\ManaCrystal",
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
			--Icon = "GUI\\Icons\\ShrinePoint",
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
			--AnimationName = "Box_FullScreen",
			X = ScreenCenterX,
			Y = ScreenCenterY,
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

		SelectionMarker =
		{
			AnimationName = "BountySelect",
			Alpha = 0.0,
			Scale = 0.7,
			ButtonOffsetX = 150,
			ButtonOffsetY = 0,
		},

		--[[
		RunIndexLabel =
		{
			Text = "RunHistoryScreen_Num",
			X = 1380,
			Y = 200,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Right",
			},
		},
		RunIndexValue =
		{
			X = 1420,
			Y = 200,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		RunRouteLabel =
		{
			Text = "RunHistoryScreen_Route",
			X = 1380,
			Y = 250,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Right",
			},
		},
		RunRouteValue =
		{
			X = 1420,
			Y = 250,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},
		]]

		RunResultLabel =
		{
			Text = "RunHistoryScreen_Result",
			X = 1380,
			Y = 300,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Right",
			},
		},
		RunResultValue =
		{
			X = 1420,
			Y = 300,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		EasyModeLabel =
		{
			Text = "RunClearScreen_EasyModeLevel",
			X = 1390,
			Y = 250,
			Alpha = 0.0,
			TextArgs =
			{
				FontSize = 26,
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

		RunClearTimeLabel =
		{
			Text = "RunHistoryScreen_Time",
			X = 1380,
			Y = 350,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Right",
			},
		},
		RunClearTimeValue =
		{
			X = 1420,
			Y = 350,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		WeaponLabel =
		{
			Text = "RunHistoryScreen_Weapon",
			X = 1380,
			Y = 400,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Right",
			},
		},
		WeaponValue =
		{
			X = 1420,
			Y = 400,
			TextArgs =
			{
				FontSize = 26,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		AspectLabel =
		{
			Text = "RunHistoryScreen_Aspect",
			X = 1380,
			Y = 450,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Right",
			},
		},
		AspectValue =
		{
			X = 1420,
			Y = 450,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		KeepsakeLabel =
		{
			Text = "RunHistoryScreen_Keepsake",
			X = 1380,
			Y = 500,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Right",
			},
		},
		KeepsakeValue =
		{
			X = 1420,
			Y = 500,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		FamiliarLabel =
		{
			Text = "RunHistoryScreen_Assist",
			X = 1380,
			Y = 550,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Right",
			},
		},
		FamiliarValue =
		{
			X = 1420,
			Y = 550,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.Yellow,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		CategoryTitleText = 
		{
			X = 680,
			Y = 200,
			Text = "TraitTray_Category_Traits",
			TextArgs =
			{
				FontSize = 26,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		TraitCount =
		{
			X = 740,
			Y = 250,
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\Boon",
			Scale = 0.8,
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Center",
				OffsetX = 0,
				OffsetY = 12,
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
			X = 850,
			Y = 250,
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\ManaCrystal",
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Center",
				OffsetX = 0,
				OffsetY = 12,
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
			X = 960,
			Y = 250,
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\ShrinePoint",
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Center",
				OffsetX = 0,
				OffsetY = 12,
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
			X = 260,
			Y = 190,
			Alpha = 0,
			InteractProperties =
			{
				FreeFormSelectable = true,
			},
			Data =
			{
				OnPressedFunctionName = "QuestLogScrollUp",
				ControlHotkeys = { "MenuUp", },
			}
		},

		ScrollDown = 
		{
			Graphic = "ButtonCodexDown",
			X = 250,
			Y = 980,
			Alpha = 0,
			InteractProperties =
			{
				FreeFormSelectable = true,
			},
			Data =
			{
				OnPressedFunctionName = "QuestLogScrollDown",
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