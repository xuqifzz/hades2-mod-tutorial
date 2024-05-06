ScreenData.BoonInfo = 
{
	StartingIndex = 1,
	Components = {},
	TraitContainers = {},
	TraitRequirements = {},

	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_TraitTray",
		FreeFormSelectGridLock = true,
		FreeFormSelectWrapY = false,
		FreeFormSelectStepDistance = 32,
		FreeFormSelectSuccessDistanceStep = 18,
	},

	NumPerPage = 3,
	Ordering = 
	{
		"ZeusUpgrade",
		"HeraUpgrade",
		"PoseidonUpgrade",
		"ApolloUpgrade",
		"DemeterUpgrade",
		"HestiaUpgrade",
		"AphroditeUpgrade",
		"HephaestusUpgrade",
		"HermesUpgrade",
		"ArtemisUpgrade",
		"TrialUpgrade",
	},

	TextBoxOffsetY = -25,
	DecriptionBoxOffsetY = -30,
	ButtonStartX = 225,
	ButtonStartY = 50,
	ButtonYSpacer = 120,
	ListRequirementSpacingY = 30,
	ListRequirementHeaderSpacingY = 40,

	--TooltipX = 1538,
	--TooltipY = 320,
	TooltipOffsetX = 850,
	TooltipOffsetY = -35,

	HiddenTraitData = 
	{
		
	},

	TraitDictionary = {}, -- Populated in RunData
	TraitRequirementsDictionary = {}, -- Populated in RunData

	RequirementsStartX = 0,
	RequirementsStartY = -100,
	GodIconScale = 0.37,

	NoRequirementsFormat =
	{
		Text = "BoonInfo_NoRequirements",
		FontSize = 24,
		OffsetX = 250,
		Color = { 42, 38, 48, 255 },
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 0},
		Justification = "Center",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ListRequirementHeaderFormat =
	{
		FontSize = 24,
		OffsetX = 30,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ListRequirementUnacquiredFormat =
	{
		Text = "BoonInfo_BulletPoint",
		FontSize = 22,
		OffsetX = 30,
		Color = { 52, 48, 58, 185 },
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 0},
		Justification = "Left",
		LuaKey = "TempTextData",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ListRequirementAcquiredFormat =
	{
		Text = "BoonInfo_BulletPoint",
		FontSize = 22,
		OffsetX = 30,
		Color = { 255, 255, 255, 225 },
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1},
		Justification = "Left",
		LuaKey = "TempTextData",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	CountRequirementFormat =
	{
		Text = "BoonInfo_CountRequirement",
		FontSize = 22,
		OffsetX = 30,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		LuaKey = "TempTextData",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	IconMap =
	{
		Earth = "CurseEarth",
		Fire = "CurseFire",
		Water = "CurseWater",
		Air = "CurseAir",
		Aether = "CurseAether",
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_TraitTray",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"Background",
			"ActionBarBackground",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			Color = { 0.090, 0.055, 0.157, 0.9 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "GUI\\Screens\\Codex\\Codex_BoonInfoBack",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		TitleText = 
		{
			Text = "Codex_BoonInfo_Title",
			X = 220,
			Y = 180,
			TextArgs =
			{
				FontSize = 38,
				OffsetX = -100, OffsetY = -90,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
				OutlineThickness = 3,
				Justification = "Left",
				DataProperties =
				{
					OpacityWithOwner = true,
				},

			},
		},

		RequirementsTitle =
		{
			Text = "BoonInfo_Requirements",
			X = 1250,
			Y = 90,
			Alpha = 0.0,
			TextArgs =
			{
				FontSize = 28,
				OffsetX = 290,
				OffsetY = 0,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		RequirementsText =
		{
			X = 1280,
			Y = 260,
			Alpha = 0.0,
		},
		
		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			BottomOffset = UIData.ActionBarBottomOffset,
			UseScreenScaleX = true,
		},

		ActionBarRight =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"ToggleTooltipsButton",
			},

			Children =
			{
				ToggleTooltipsButton =
				{
					Graphic = "ContextualActionButton",
					--GroupName = "Combat_Menu_TraitTray",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "BoonInfoScreenToggleTooltips",
						ControlHotkeys = { "MenuInfo", },
					},
					Text = "BoonInfo_ShowTooltips",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton =
				{
					Graphic = "ContextualActionButton",
					--GroupName = "Combat_Menu_TraitTray",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseBoonInfoScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_CloseSubmenu",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},

		PageNumber =
		{
			Text = "BoonInfo_PageNumber",
			X = 600,
			Y = UIData.ContextualButtonY,
			TextArgs =
			{
				FontSize = 28,
				OffsetX = 0,
				OffsetY = 0,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				LuaKey = "TempTextData",
				LuaValue = { CurrentPageNum = 0, NumPages = 0 },
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				},
			},
		},

		PageUp =
		{
			Graphic = "ButtonCodexUp",
			X = 520,
			Y = UIData.ContextualButtonY + 3,
			Alpha = 0.0,
			Data =
			{
				OnPressedFunctionName = "BoonInfoScreenPrevious",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
			InteractProperties =
			{
				FreeFormSelectOffsetX = 20,
				FreeFormSelectOffsetY = -900,
			}
		},

		PageDown =
		{
			Graphic = "ButtonCodexDown",
			X = 680,
			Y = UIData.ContextualButtonY - 3,
			Alpha = 0.0,
			Data =
			{
				OnPressedFunctionName = "BoonInfoScreenNext",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
			InteractProperties =
			{
				FreeFormSelectOffsetX = -20,
				FreeFormSelectOffsetY = 0,
			}
		},
	},
}