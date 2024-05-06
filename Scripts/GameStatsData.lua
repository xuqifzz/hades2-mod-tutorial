ScreenData.GameStats =
{
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/FatedListOpen",
	CloseSound = "/SFX/Menu Sounds/FatedListClose",

	Components = {},

	CategoryStartX = 340,
	CategoryStartY = 250,
	CategorySpacingX = 94,

	CategoryIconScale = 0.40,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ScrollOffset = 0,
	ItemsPerPage = 15,
	ActiveCategoryIndex = 1,
	
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
	RowSpacingWeapons = 60,
	RowSpacingTraits = 40,
	IconScaleWeapons = 0.12,
	IconScaleTraits = 0.2,

	WeaponColumnHeaders =
	{
		{ ColumnName = "Name", X = 600, Justification = "Right", },
		{ ColumnName = "Icon", X = 640 },
		{ ColumnName = "UseCount", X = 730, HeaderX = 920, Text = "GameStatsScreen_Usage", Justification = "Center", },
		{ ColumnName = "BarGraph", X = 770, Justification = "Right", },
		{ ColumnName = "ClearCount", X = 1200, Text = "RunClearScreen_Header_Clears", Justification = "Center", },
		{ ColumnName = "ClearRecordTime", X = 1400, Text = "RunClearScreen_Header_RecordClearTime", Justification = "Center", },
		{ ColumnName = "ClearRecordShrinePoints", X = 1600, Text = "RunClearScreen_Header_RecordShrinePoints", Justification = "Center", },
	},

	ActiveColumnColor = {0.569, 1.000, 0.533, 1.0},

	SortKeys =
	{
		"UseCount",
		"ClearCount",
		"ClearRecordTime",
		"ClearRecordShrinePoints",
	},

	HeaderFormat =
	{
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		Color = Color.White,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
	},

	StatFormat =
	{
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		Color = {0.569, 0.557, 0.533, 1.0},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
	},

	RecordStatFormat =
	{
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		Color = {0.569, 1.000, 0.533, 1.0},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
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
			Text = "GameStatsScreen_Title",
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

		CategoryTitleText = 
		{
			X = 300,
			Y = 200,
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

		GodModeIndicator =
		{
			AnimationName = "GodMode",
			X = 1500,
			Y = 200,
			Scale = 0.75,
			Requirements =
			{
				{
					PathTrue = { "ConfigOptionCache", "EasyMode" },
				}
			}
		},

		SortModeIndicator =
		{
			AnimationName = "QuestLogEntryArrow",
			Angle = 90,
			OffsetX = 25,
			OffsetY = -35,
			Alpha = 0,
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			X = 500,
			Y = 320,
			Alpha = 0,
			InteractProperties =
			{
				FreeFormSelectable = true,
			},
			Data =
			{
				OnPressedFunctionName = "GameStatsScrollUp",
				ControlHotkeys = { "MenuUp", },
			}
		},

		ScrollDown = 
		{
			Graphic = "ButtonCodexDown",
			X = 500,
			Y = 1000,
			Alpha = 0,
			InteractProperties =
			{
				FreeFormSelectable = true,
			},
			Data =
			{
				OnPressedFunctionName = "GameStatsScrollDown",
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
				"ChangeSortMode",
			},

			Children =
			{
				ChangeSortMode =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "GameStatsChangeSortMode",
						ControlHotkeys = { "MenuInfo", },
					},
					Text = "Menu_Sort",
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
						OnPressedFunctionName = "GameStatsPrevCategory",
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
						OnPressedFunctionName = "GameStatsNextCategory",
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
						OnPressedFunctionName = "CloseQuestLogScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}