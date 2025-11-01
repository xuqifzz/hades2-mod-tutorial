ScreenData.GameStats =
{
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/FatedListOpen",
	CloseSound = "/SFX/Menu Sounds/FatedListClose",

	Components = {},

	CategoryStartX = 300,
	CategoryStartY = 230,
	CategorySpacingX = 74,
	CategoryScale = 0.8,
	CategoryIconScale = 0.5,

	ScrollOffset = 0,
	ItemsPerPage = 15,
	ActiveCategoryIndex = 1,
	
	TraitFilters =
	{
		{
			Name = "GameStats_Weapons",
			Icon = "GUI\\Screens\\GameStats\\Icon-Weapons",
		},
		{
			Name = "GameStats_Boons",
			Icon = "GUI\\Screens\\GameStats\\Icon-Boons",
		},
		{
			Name = "GameStats_WeaponUpgrades",
			Icon = "GUI\\Screens\\GameStats\\Icon-Hammers",
		},
		{
			Name = "GameStats_Keepsakes",
			Icon = "GUI\\Screens\\GameStats\\Icon-Keepsakes",
		},
	},

	WeaponBaseAspectMapping =
	{
		BaseStaffAspect = "DummyWeaponStaff",
		DaggerBackstabAspect = "DummyWeaponDagger",
		TorchSpecialDurationAspect = "DummyWeaponTorch",
		AxeRecoveryAspect = "DummyWeaponAxe",
		LobAmmoBoostAspect = "DummyWeaponLob",
		BaseSuitAspect = "DummyWeaponSuit",
	},

	HeaderY = 226,
	RowStartY = 278,
	RowSpacingTraits = 40,
	IconScaleTraits = 0.24,

	WeaponColumnHeaders =
	{
		{ ColumnName = "Name", X = 150, Justification = "Left", },
		{ ColumnName = "Icon", X = 107 },
		{ ColumnName = "UseCount", X = 690, HeaderX = 860, Text = "GameStatsScreen_Usage", Justification = "Right", HeaderJustification = "Center", },
		{ ColumnName = "BarGraph", X = 705, Justification = "Right", },
		{ ColumnName = "ClearCount", X = 1154, Text = "RunClearScreen_Header_Clears", Justification = "Center", },
		{ ColumnName = "FastestTimeUnderworld", X = 1310, Text = "RunClearScreen_Header_RecordClearTime_Underworld", Justification = "Center", },
		{ ColumnName = "HighestShrinePointsUnderworld", X = 1430, Text = "RunClearScreen_Header_RecordShrinePoints_Underworld", Justification = "Center", },
		{ ColumnName = "FastestTimeSurface", X = 1550, Text = "RunClearScreen_Header_RecordClearTime_Surface", Justification = "Center", },
		{ ColumnName = "HighestShrinePointsSurface", X = 1670, Text = "RunClearScreen_Header_RecordShrinePoints_Surface", Justification = "Center", },
	},

	Tabs =
	{
		{ X = -190, Y = -86, Animation = "GUI\\Screens\\GameStats\\CategoryTab1", Highlight = "GUI\\Screens\\GameStats\\CategoryTabHighlight1", Active = "GUI\\Screens\\GameStats\\CategoryTabActiveHighlightOverlay1" },
		{ X = -170, Y = -86, Animation = "GUI\\Screens\\GameStats\\CategoryTab2", Highlight = "GUI\\Screens\\GameStats\\CategoryTabHighlight2", Active = "GUI\\Screens\\GameStats\\CategoryTabActiveHighlightOverlay2" },
		{ X = -150, Y = -86, Animation = "GUI\\Screens\\GameStats\\CategoryTab3", Highlight = "GUI\\Screens\\GameStats\\CategoryTabHighlight3", Active = "GUI\\Screens\\GameStats\\CategoryTabActiveHighlightOverlay3" },
		{ X = -130, Y = -89, Animation = "GUI\\Screens\\GameStats\\CategoryTab1", Highlight = "GUI\\Screens\\GameStats\\CategoryTabHighlight1", Active = "GUI\\Screens\\GameStats\\CategoryTabActiveHighlightOverlay1" },
		{ X = -110, Y = -89, Animation = "GUI\\Screens\\GameStats\\CategoryTab2", Highlight = "GUI\\Screens\\GameStats\\CategoryTabHighlight2", Active = "GUI\\Screens\\GameStats\\CategoryTabActiveHighlightOverlay2" },
	},
	TabIconMouseOverShiftDistance = 5,
	TabIconMouseOverShiftSpeed = 300,
	
	ActiveColumnColor = {0.606, 0.9, 0.378, 1.0},

	SortKeys =
	{
		"UseCount",
		"ClearCount",
		"FastestTimeUnderworld",
		"HighestShrinePointsUnderworld",
		"FastestTimeSurface",
		"HighestShrinePointsSurface",
	},
	SortInReverse =
	{
		FastestTimeUnderworld = true,
		FastestTimeSurface = true,
	},

	HeaderFormat =
	{
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		Color = {0.95, 1, 0.95, 0.8},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
	},

	StatFormat =
	{
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		Color = {0.1, 0.08, 0.11, 0.75},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
	},

	RecordStatFormat =
	{
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		Color = {0.606, 0.9, 0.378, 1.0},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"BackgroundBack",
			"CategoryButtons",
			"BackgroundFront",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 9.0,
			Color = { 0.090, 0.055, 0.157, 0.8 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		BackgroundBack = 
		{
			AnimationName = "GameStatsBack",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		CategoryButtons =
		{
			FunctionName = "GameStatsScreenCreateCategories",
		},

		BackgroundFront = 
		{
			AnimationName = "GameStatsFront",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		CategoryTitleText = 
		{
			X = 80,
			Y = 77,
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

		SortModeIndicator =
		{
			AnimationName = "GameStatsFilterArrow",
			OffsetX = 5,
			OffsetY = -65,
			Scale = 1,
			Alpha = 0,
		},

		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			X = 180,
			Y = 225,
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
			X = 180,
			Y = 920,
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
						OnPressedFunctionName = "CloseGameStatsScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}

-- GameStats Screen
GlobalVoiceLines.OpenedGameStatsScreenVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		SuccessiveChanceToPlayAll = 0.1,
		PreLineWait = 0.6,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelRunHistoryIntroSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_2979", Text = "Let's have the latest numbers." },
		{ Cue = "/VO/Melinoe_2980", Text = "Best to keep track of each detail...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3852", Text = "Trivia of all I've done so far..." },
		{ Cue = "/VO/Melinoe_3853", Text = "How does the Record Keeper know all this..." },
	},
}