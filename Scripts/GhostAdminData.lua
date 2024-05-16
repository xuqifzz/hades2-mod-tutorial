ScreenData.GhostAdmin = ScreenData.GhostAdmin or {}
OverwriteTableKeys( ScreenData.GhostAdmin, 
{
	BlockPause = true,

	OpenSound = "/SFX/Menu Sounds/CauldronMenuOpenClose",
	OpenVoiceLines =
	{
		-- Alchemy revealed
		{
			SkipAnim = true,
			PlayOnce = true,
			PreLineWait = 1.0,
			Cooldowns =
			{
				{ Name = "MelCauldronOpenedSpeech", Time = 200 },
			},
			GameStateRequirements =
			{
				NamedRequirements = { "AlchemyUnlocked" },
			},
			{ Cue = "/VO/Melinoe_2608", Text = "There's more I can do with this Cauldron..." },
		},
	},
	OpenEndVoiceLines =
	{
		{
			SkipAnim = true,
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.6,
			SuccessiveChanceToPlay = 0.75,
			Cooldowns =
			{
				{ Name = "MelCauldronOpenedSpeech", Time = 200 },
				{ Name = "MelCauldronSpellRevealedSpeech", Time = 20 }
			},

			{ Cue = "/VO/Melinoe_0508", Text = "Our cauldron..." },
			{ Cue = "/VO/Melinoe_0509", Text = "Must be an incantation that can help...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0510", Text = "What now..." },
			{ Cue = "/VO/Melinoe_0511", Text = "What to cast..." },
		},
	},

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

	CameraOffetX = -200,
	CameraOffetY = 180,

	CategoryStartX = 150,
	CategoryStartY = 155,
	CategorySpacingX = 110,

	CategoryIconScale = 0.60,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = -6,
	CategoryIconMouseOverShiftDistance = 5,
	CategoryIconMouseOverShiftSpeed = 300,

	ItemStartX = 515,
	ItemStartY = 230,
	ItemSpacingY = 110,
	IconOffsetX = -388,
	IconOffsetY = -1,
	IconScale = 0.7,
	ItemsPerPage = 5,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = -470,
	ScrollbarSliderTopY = 210,
	ScrollbarSliderBottomY = 690,

	ItemAvailableAffordableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {85,202,152,255},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemAvailableUnaffordableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = Color.CostUnffordableShop,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	ItemPurchasedNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {48,48,48,255},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
		DataProperties =
		{
			OpacityWithOwner = true,
		},
	},

	PinOffsetX = 315,

	Components = {},

	SaleData = {},
	NumSales = 0,
	NumItemsOffered = 0,

	TooltipX = 1680,
	TooltipY = 1280,

	ResourceSpendTextInitialOffsetY = 10,
	ResourceSpendTextSpacingY = -102,
	ResourceSpendTextOffsetY = 11,

	CostDisplay =
	{
		StartX = 450,
		StartY = 848,
		SpacerX = 160,
		InventoryAmountOffsetY = 90,
		ResourceIconOffsetY = -5,
		ResourceIconScale = 1.1,
		InventoryIconOffsetX = -25,
		InventoryIconScale = 0.45,

		ResourceNameAffordableFormat =
		{
			Font = "LatoMedium",
			FontSize = 17,
			OffsetX = 0,
			OffsetY = -55,
			Color = Color.Black,
			Height = 70,
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},

		ResourceNameUnaffordableFormat =
		{
			Font = "LatoMedium",
			FontSize = 17,
			OffsetX = 0,
			OffsetY = -55,
			Color = Color.CostUnffordableShop,
			Height = 70,
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},

		ResourceAmountAffordableFormat =
		{
			Font = "LatoBold",
			FontSize = 19,
			OffsetX = 0,
			OffsetY = 62,
			Color = Color.CostAffordable,
			Justification = "Center",
			ShadowColor = {0,0,0,1},
			OutlineColor = {0,0,0,1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 3},
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},

		ResourceAmountUnaffordableFormat =
		{
			Font = "LatoBold",
			FontSize = 19,
			OffsetX = 0,
			OffsetY = 60,
			Color = Color.CostUnffordableShop,
			Justification = "Center",
			ShadowColor = {0,0,0,1},
			OutlineColor = {0,0,0,1}, OutlineThickness = 2,
			ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 3},
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},

		InventoryAmountFormat =
		{
			Text = "ResourceCostInventoryAmount",
			Font = "LatoBold",
			FontSize = 16,
			TextSymbolScale = 0.8,
			OffsetX = 0,
			OffsetY = 115,
			Color = { 232, 232, 232, 125 },
			Justification = "Center",
			DataProperties =
			{
				OpacityWithOwner = true,
			},
		},
	},

	ItemAvailableAnimation = "GUI\\Screens\\CriticalItemShop\\Button",
	ItemAvailableHighlightAnimation = "GUI\\Screens\\CriticalItemShop\\Button_Highlight",
	ItemPurchasedAnimation = "GUI\\Screens\\CriticalItemShop\\Button",
	ItemPurchasedHighlightAnimation = "GUI\\Screens\\CriticalItemShop\\Button_Highlight",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundIllustration01",
			"ShopBackgroundDim",
			"ListBackground",
			"InfoBoxBacking",
			"Scrollbar",
			"ScrollbarSlider",
			"ScrollUp",
			"ScrollDown",
		},

		ShopBackgroundDim = 
		{
			Graphic = "rectangle01",
			AnimationName = "WeaponShopVignette",
			GroupName = "Combat_Menu_Backing",
			ScaleX = 30.0,
			ScaleY = 30.0,
			X = ScreenCenterX + 200,
			Y = ScreenCenterY,
			Color = { 1.0, 1.0, 1.0, 0.8 },
		},

		CategoryBacking = 
		{
			AnimationName = "GUI\\Screens\\CriticalItemShop\\Backing_Header",
			X = 820,
			Y = 100,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
		},

		CategoryTitleText = 
		{
			X = 90,
			Y = 70,
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

		ResourceCostBacking =
		{
			AnimationName = "GUI\\Screens\\CriticalItemShop\\Backing_Left",
			X = 450,
			Y = 865,
			Scale = 0.538,
			Alpha = 0.0,
		},

		BackgroundIllustration01 =
		{
			AnimationName = "GUI\\Screens\\CriticalItemShop\\BackgroundArt_01",
			X = 960,
			Y = 540,
			Scale = 1.0,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
		},

		InfoBoxBacking = 
		{
			AnimationName = "GUI\\Screens\\CriticalItemShop\\Backing_Scroll",
			X = 1165,
			Y = 790,
			Scale = 1.0,
			Alpha = 0.0,
			Children = 
			{
				InfoBoxDescription =
				{ 
					OffsetX = -282,
					OffsetY = -100,
					TextArgs =
					{
						FontSize = 20,
						Color = Color.Black,
						Font = "LatoMedium",
						VariableAutoFormat = "BoldFormatGraftDark",
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 568,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
						LineSpacingBottom = 5,
						TextSymbolScale = 0.8,
					}
				},
				InfoBoxFlavor =
				{
					OffsetX = -282,
					OffsetY = 20,
					TextArgs =
					{
						FontSize = 18,
						Color = Color.FlavorTextPurple,
						Font = "LatoItalic",
						Justification = "Left",
						VerticalJustification = "Top",
						Width = 568,
						FadeOpacity = 0.0,
						FadeTarget = 0.0,
					}
				},
			},
		},

		Scrollbar =
		{
			AnimationName = "PageScrollbar",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 450,
		},

		ScrollbarSlider =
		{
			AnimationName = "PageScrollbarSlider",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 450,
		},
		
		ScrollUp =
		{
			Graphic = "BlankInteractableObstacle",
			AnimationName = "CodexButton_Up",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 210,
			Alpha = 0.0,
			Scale = 0.85,
			HighlightedScale = 1.5, -- relative to Scale
			Data =
			{
				OnMouseOverFunctionName = "GhostAdminMouseOverScrollArrow",
				OnMouseOffFunctionName = "GhostAdminMouseOffScrollArrow",
				OnPressedFunctionName = "GhostAdminScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
			InteractProperties =
			{
				AutoActivateWithGamepad = true,
			},
		},

		ScrollDown =
		{
			Graphic = "BlankInteractableObstacle",
			AnimationName = "CodexButton_Down",
			GroupName = "Combat_Menu_Overlay",
			X = 30,
			Y = 695,
			Alpha = 0.0,
			Scale = 0.85,
			HighlightedScale = 1.5, -- relative to Scale
			Data =
			{
				OnMouseOverFunctionName = "GhostAdminMouseOverScrollArrow",
				OnMouseOffFunctionName = "GhostAdminMouseOffScrollArrow",
				OnPressedFunctionName = "GhostAdminScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
			InteractProperties =
			{
				AutoActivateWithGamepad = true,
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
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
				"PinButton",
			},

			Children =
			{
				PinButton = 
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Hotkey only
						OnPressedFunctionName = "GhostAdminPinItem",
						ControlHotkeys = { "ItemPin", },
					},
					Text = "Menu_Pin",
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
						OnPressedFunctionName = "GhostAdminPrevCategory",
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
						OnPressedFunctionName = "GhostAdminNextCategory",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
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
					Text = "Menu_CauldronUnlock",
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
						OnPressedFunctionName = "CloseGhostAdminScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			}
		}

	},
})
