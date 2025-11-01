ScreenData.RunHistory =
{
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/RunHistoryOpen",
	CloseSound = "/SFX/Menu Sounds/RunHistoryClose",

	InAnimations =
	{
		"RunHistoryInUnderworld",
		"RunHistoryInUnderworldFail",
		"RunHistoryInSurface",
		"RunHistoryInSurfaceFail",
		"RunHistoryInChaos",
		"RunHistoryInChaosFail",
	},

	OutAnimations =
	{
		"RunHistoryOutUnderworld",
		"RunHistoryOutUnderworldFail",
		"RunHistoryOutSurface",
		"RunHistoryOutSurfaceFail",
		"RunHistoryOutChaos",
		"RunHistoryOutChaosFail",
	},

	TransitionFromBlankAnimations =
	{
		"RunHistoryTransitionBlankToUnderworld",
		"RunHistoryTransitionBlankToUnderworldFail",
		"RunHistoryTransitionBlankToSurface",
		"RunHistoryTransitionBlankToSurfaceFail",
		"RunHistoryTransitionBlankToChaos",
		"RunHistoryTransitionBlankToChaosFail",
	},

	TransitionToBlankAnimations =
	{
		"RunHistoryTransitionUnderworldToBlank",
		"RunHistoryTransitionUnderworldFailToBlank",
		"RunHistoryTransitionSurfaceToBlank",
		"RunHistoryTransitionSurfaceFailToBlank",
		"RunHistoryTransitionChaosToBlank",
		"RunHistoryTransitionChaosFailToBlank",
	},

	ItemStartX = 95,
	ItemStartY = 297,
	ItemSpacingY = 48,
	ItemsPerPage = 14,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = 100,

	TraitStartX = 1275,
	TraitStartY = 345,
	TraitSpacingX = 95,
	TraitSpacingY = 90,
	TraitsPerColumn = 7,
	TraitIconScale = 0.5,
	TraitMaxColumns = 5,

	MetaUpgradeStartY = 366,
	MetaUpgradeSpacingX = 88,
	MetaUpgradeSpacingY = 128,
	MetaUpgradesPerColumn = 5,
	MetaUpgradeIconScale = 0.21,

	ShrineUpgradeStartX = 1285,
	ShrineUpgradeSpacingX = 120,
	ShrineUpgradeSpacingY = 80,
	ShrineUpgradesPerRow = 4,
	ShrineUpgradesMaxRows = 5,
	ShrineUpgradeIconScale = 0.4,
	ShrineUpgradeBackingScale = 0.67,

	Components = {},

	CategoryStartX = 1350,
	CategoryStartY = 220,
	CategorySpacingX = 110,

	CategoryIconScale = 0.4,
	CategoryIconOffsetX = -18,
	CategoryIconOffsetY = -2,

	RunDataTitleX = 640,
	RunDataValueX = 740,
	RunDataStartY = 670,
	RunDataSpacingY = 57,
	RunDataIconX = 710,
	MaxVisibleRunDataEntries = 6, -- weapon + familiar + 4 keepsakes

	WeaponIconScale = 0.35,
	WeaponIconOffsetY = 0,

	FamiliarIconScale = 0.35,
	FamiliarIconOffsetY = 0,

	KeepsakeIconScale = 0.32,
	KeepsakeIconOffsetY = 0,

	ActiveCategoryIndex = 1,

	FadeOutTime = 0.35,
	CloseDestroyWait = 0.35,

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
		Color = {90, 220, 160, 255},
		Font = "P22UndergroundSCMedium",
		VariableAutoFormat = "BoldFormatGraft",
		FontSize = 22,
		FadeOpacity = 1.0,
		OffsetX = 0, OffsetY = -2,
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
		Color = {160, 0, 0, 225},
		Font = "P22UndergroundSCMedium",
		VariableAutoFormat = "BoldFormatGraft",
		FontSize = 22,
		FadeOpacity = 1.0,
		OffsetX = 0, OffsetY = -2,
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
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		Color = {255, 225, 225, 125},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Right",
		FadeOpacity = 0.0,
		FadeTarget = 0.49,
		FadeTargetDuration = 0.2,
	},

	RunDataValueFormat =
	{
		FontSize = 22,
		OffsetX = 0, OffsetY = 0,
		Color = Color.White,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
		Justification = "Left",
		LineSpacingBottom = -20,
		Width = 400,
		FadeOpacity = 0.0,
		FadeTarget = 0.49,
		FadeTargetDuration = 0.2,
	},

	MouseOverScaleTarget = 1.05,
	MouseOverScaleDuration = 0.2,

	ItemCategories =
	{
		{
			Name = "TraitTray_Category_Traits",
			DisplayFunctionName = "RunHistoryScreenShowTraits",
			TextComponentName = "TraitCount",
		},
		{
			Name = "TraitTray_Category_OverflowTraits",
			DisplayFunctionName = "RunHistoryScreenShowTraits",
			DisplayFunctionArgs = { Overflow = true },
			TextComponentName = "OverflowTraitLabel",
		},
		{
			Name = "TraitTray_Category_MetaUpgrades",
			DisplayFunctionName = "RunHistoryScreenShowMetaUpgrades",
			TextComponentName = "MetaUpgradeCount",
			TraitStartX = 70,
			TraitStartBottomOffset = 870,
			TraitSpacingX = 110,
			TraitSpacingY = 135,
			TraitsPerColumn = 5,
		},
		{
			Name = "TraitTray_Category_ShrineUpgrades",
			DisplayFunctionName = "RunHistoryScreenShowShrineUpgrades",
			TextComponentName = "ShrinePointCount",
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
			"ForegroundTheme",
			"SelectionMarker",
			"HoverMarker",
			"BiomeCard",
			"KilledByCard",
			"ResultSplash",
			"ResultRibbonFailure",
			"ResultRibbonSuccess",
			"TabSetup",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 9.0,
			Color = { 0.090, 0.055, 0.157, 0.8 },
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		ForegroundTheme =
		{
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		BiomeCard =
		{
			X = 875,
			Y = 310,
			Alpha = 0.0,
			Angle = -15,
			Scale = 0.8,
		},

		KilledByCard =
		{
			X = 640,
			Y = 310,
			Alpha = 0.0,
			Angle = 15,
			Scale = 0.8,
		},

		ResultRibbonSuccess =
		{
			AnimationName = "RunHistoryRibbon_Success_In",
			X = 700,
			Y = 283,
		},
		ResultRibbonFailure =
		{
			AnimationName = "RunHistoryRibbon_Failure_In",
			X = 700,
			Y = 283,
		},

		TabSetup =
		{
			FunctionName = "RunHistoryScreenSetupTabs",
		},

		ResultText =
		{
			X = 752,
			Y = 500,
			TextArgs =
			{
				FontSize = 28,
				Width = 528,
				LangFontSize = {
					{ Code = "el", Value = 25 },
					{ Code = "ja", Value = 25 }
				},
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
			},
		},

		SupertitleResultText =
		{
			X = 752,
			Y = 486,
			TextArgs =
			{
				FontSize = 32,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
			},
		},

		SubtitleResultText =
		{
			X = 752,
			Y = 521,
			TextArgs =
			{
				FontSize = 21,
				OffsetX = 0, OffsetY = 0,
				Color = { 150, 225, 200, 180 },
				TextSymbolScale = 0.0, -- hack to hide the inline victory message dots
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
			},
		},

		TimeText =
		{
			X = 758,
			Y = 576,
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

		RunErasedText =
		{
			X = 758,
			Y = 676,
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
			AnimationName = "RunHistorySelect",
			Alpha = 0.0,
		},

		HoverMarker =
		{
			AnimationName = "RunHistoryHover",
			Alpha = 0.0,
		},

		HoverFrame =
		{
			AnimationName = "TraitTray_Highlight",
			GroupName = "Combat_Menu_TraitTray_Additive",
			Alpha = 0.0,
		},

		TraitName =
		{
			X = 1465,
			Y = 275,
			TextArgs =
			{
				FontSize = 22,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
			},
		},

		EasyModeLabel =
		{
			Text = "RunClearScreen_EasyModeLevel",
			X = 1676,
			Y = 220,
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
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\Boon",
			Alpha = 0.0,
			Scale = 0.51,
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 20,
				OffsetY = -2,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				DataProperties =
				{
					OpacityWithOwner = true,
				}
			},
		},

		OverflowTraitLabel =
		{
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\Boon",
			Alpha = 0.0,
			Scale = 0.51,
			TextArgs =
			{
				Text = "TraitTray_Label_OverflowTraits",
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 20,
				OffsetY = -10,
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
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\ManaCrystal",
			Alpha = 0.0,
			Scale = 0.58,
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 20,
				OffsetY = -2,
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
			GroupName = "Combat_Menu_Overlay",
			Animation = "GUI\\Icons\\ShrinePoint",
			Alpha = 0.0,
			Scale = 0.52,
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 20,
				OffsetY = -2,
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
			Y = 237,
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

RunResultData =
{
	UnderworldSuccess = 1,
	UnderworldFail = 2,
	SurfaceSuccess = 3,
	SurfaceFail = 4,
	BountySuccess = 5,
	BountyFail = 6,
}

-- RunHistory Screen
GlobalVoiceLines.OpenedRunHistoryScreenVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		SuccessiveChanceToPlayAll = 0.1,
		PreLineWait = 0.5,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "MelRunHistoryIntroSpeech", Time = 30 },
		},

		{ Cue = "/VO/Melinoe_2981", Text = "What does my history reveal?", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2982", Text = "Let's see how fares my task." },
		{ Cue = "/VO/Melinoe_3854", Text = "How've I been doing?" },
		{ Cue = "/VO/Melinoe_3855", Text = "My recent history detailed..." },
	},
}
GlobalVoiceLines.PositiveRunHistoryScreenVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.1,
		SuccessiveChanceToPlayAll = 0.1,
		PreLineWait = 0.44,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
			{ Name = "RunHistorySpeech", Time = 18 },
		},

		{ Cue = "/VO/Melinoe_3860", Text = "Went all right." },
		{ Cue = "/VO/Melinoe_3861", Text = "Good one that time." },
		{ Cue = "/VO/Melinoe_3862", Text = "Proper." },
		{ Cue = "/VO/Melinoe_3863", Text = "Adequate..." },
	},
}
GlobalVoiceLines.NegativeRunHistoryScreenVoiceLines =
{
	{
		SkipAnim = true,
		BreakIfPlayed = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.1,
		SuccessiveChanceToPlayAll = 0.1,
		PreLineWait = 0.44,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_3856", Text = "{#Emph}Mm." },
		{ Cue = "/VO/Melinoe_3857", Text = "Not quite..." },
		{ Cue = "/VO/Melinoe_3858", Text = "{#Emph}Eugh..." },
		{ Cue = "/VO/Melinoe_3859", Text = "Oh, right..." },
			{ Name = "RunHistorySpeech", Time = 18 },
	},
}