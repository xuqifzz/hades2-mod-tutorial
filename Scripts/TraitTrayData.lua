ScreenData.TraitTrayScreen =
{
	Components = {},
	Icons = {},
	Frames = {},
	PrimaryFrames = {},
	Columns = {},
	Pins = {},
	PossibleAutoPins = {},
	TraitComponentDictionary = {},

	OpenSound = "/SFX/Menu Sounds/GeneralWhooshMENULoud",
	CloseSound = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow",

	OnWASDHotSwapFunctionName = "ScreenResetCursorToStartLocation",

	TooltipX = 1686,
	TooltipY = 260,

	TotalPinSpace = 600,
	DefaultPins = 3,
	DefaultPinSpacing = 230,
	MaxPins = 8,
	MaxAutoPins = 5,
	PinCollapseSpeed = 1000,
	PinOffsetX = 970,
	PinOffsetY = 50,	

	AllowAdvancedTooltip = true,
	IgnoreOtherScreenInput = true,
	FreezePlayerArgs = {},

	DisabledShrineIconColor = { 128, 128, 128, 128 },

	TraitStartX = 50,
	TraitStartBottomOffset = 840,
	TraitSpacingX = 95,
	TraitSpacingY = 90,
	TraitsPerColumn = 7,

	ShrineStartX = 52,
	ShrineSpacingX = 95,
	ShrineSpacingY = 95,
	ShrineStartBottomOffset = 600,
	ShrinesPerColumn = 4,
	ShrinesPerRow = 5,
	ShrineBackingScale = 0.8,
	ShrineIconScale = 0.4,

	CategoryCenterX = 240,
	CategoryStartBottomOffset = 972,
	CategorySpacingX = 110,

	CategoryIconScale = 0.8,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	BountyIconShiftX = 370,

	PinPriorities =
	{
		{ Rank = 5 },
		{ Rank = 4 },
		{ Rank = 3 },
		{ Rank = 2 },
		{ Rank = 1 },
		{ IsWeaponEnchantment = true },
		{ Slot = "Keepsake" },
		{ Rarity = "Heroic" },
		{ Rarity = "Legendary" },
		{ Rarity = "Epic" },
		{ Rarity = "Rare" },
	},

	GamepadNavigation =
	{
		--ExclusiveInteractGroup = "HUD_Main",
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 16,
		FreeFormSelectSuccessDistanceStep = 4,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ItemCategories =
	{
		{
			Name = "TraitTray_Category_Traits",
			--Icon = "GUI\\Icons\\Boon",
			IconComponent = "TraitCount",
			BackgroundAnimation = "GUI\\HUD\\TraitTrayBacking",
			GameStateRequirements =
			{
				-- None
			},
			DisplayFunctionName = "TraitTrayShowTraits",
		},
		{
			Name = "TraitTray_Category_MetaUpgrades",
			--Icon = "GUI\\Icons\\ManaCrystal",
			IconComponent = "MetaUpgradeCount",
			BackgroundAnimation = "GUI\\HUD\\TraitTrayBacking_NoHeader",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
					Comparison = ">=",
					Value = 1,
				}
			},
			DisplayFunctionName = "TraitTrayShowMetaUpgrades",
			TraitStartX = 70,
			TraitStartBottomOffset = 870,
			TraitSpacingX = 110,
			TraitSpacingY = 135,
			TraitsPerColumn = 5,
			TraitsNeededForExtendedSpacing = 21,
			ExtendedTraitSpacingX = 88,
		},
		{
			Name = "TraitTray_Category_ShrineUpgrades",
			--Icon = "GUI\\Icons\\ShrinePoint",
			IconComponent = "ShrinePointCount",
			BackgroundAnimation = "GUI\\HUD\\TraitTrayBacking_NoHeader",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "SpentShrinePointsCache", },
					Comparison = ">=",
					Value = 1,
				},
			},
			DisplayFunctionName = "TraitTrayShowShrineUpgrades",
		},
	},

	ComponentData =
	{
		DefaultGroup = "HUD_Main",

		Order =
		{
			"BackgroundTint",
			"TabSetup",
			"Background",
			"ActiveShrineBountyBacking",
			"ActiveShrineBountyTarget",
			"ActiveShrineBountyFrame",
			"ActiveShrineBountyPoints",
			"ActiveShrineBountyWeapon",
		},

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "HUD_Backing",
			Scale = 10.0,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {0, 0, 0, 255},
			Alpha = 0.0,
			AlphaTarget = 0.66,
			AlphaTargetDuration = 0.25,
		},

		TabSetup =
		{
			FunctionName = "TraitTrayScreenSetupTabs",
		},

		Background =
		{
			AnimationName = "GUI\\HUD\\TraitTrayBacking",
			GroupName = "HUD_Backing",
			X = 245,
			BottomOffset = 583,
			Scale = 0.5,
		},

		CategoryTitleText = 
		{
			X = 46,
			BottomOffset = 1040,
			Graphic = "TraitTrayHeader",
			TextArgs =
			{
				FontSize = 26,
				Color = {214,214,214,255},
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Left",
			},
		},

		HoverFrame =
		{
			Graphic = "TraitTray_Highlight",
			GroupName = "Combat_Menu_TraitTray_Additive",
			AlphaTarget = 0.0,
		},

		ElementPanel =
		{
			Name = "BlankObstacle",
			X = 4,
			BottomOffset = 922,
			Scale = 0.5,
			ScaleX = 0.4,
			AlphaTarget = 0.0,
			Animation = null,
			TextArgs =
			{
				Text = "ElementalTooltipHeader",
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 22,
				OffsetX = 60,
				OffsetY = 2,
				Color = Color.White,				
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			}
		},

		NoMetaUpgradesHint =
		{
			X = 4,
			BottomOffset = 800,
			AlphaTarget = 0.0,
			TextArgs =
			{
				Text = "NoMetaUpgradesShrineUpgrade_TrayHint",
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 22,
				OffsetX = 60,
				OffsetY = 2,
				Color = Color.White,				
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Left",
			}
		},

		ActiveShrineBountyBacking =
		{
			X = 244,
			BottomOffset = 790,
			Scale = 1.0,
			Alpha = 0.0,
			AnimationName = "GUI\\Screens\\Shrine\\TestamentBacking",
		},
		ActiveShrineBountyTarget =
		{
			X = 244,
			BottomOffset = 790,
			Scale = 1.0,
			Alpha = 0.0,
		},
		ActiveShrineBountyFrame =
		{
			X = 244,
			BottomOffset = 790,
			Alpha = 0.0,
			AnimationName = "GUI\\Screens\\Shrine\\TestamentActive",
		},
		ActiveShrineBountyPoints =
		{
			X = 250,
			BottomOffset = 839,
			Alpha = 0.0,
			TextArgs =
			{
				Text = "ShrineScreen_BountyShrinePoints",
				FontSize = 17,
				Width = 851,
				Color = Color.White,
				Font = "LatoBold",
				ShadowBlur = 0,
				ShadowColor = {0,0,0,255},
				ShadowOffset = {0, 1},
				Justification = "Center",
				TextSymbolScale = 0.85,
				LuaKey = "TempTextData",
				LuaValue = { RequiredShrinePoints = 0 },
			}
		},
		ActiveShrineBountyWeapon =
		{
			X = 244,
			BottomOffset = 742,
			Alpha = 0.0,
			Scale = 0.55,
		},

		RoomCount = 
		{
			Requirements =
			{
				{
					PathFalse = { "CurrentHubRoom" },
				},
			},
			RightOffset = 20,
			Y = 60,
			TextArgs =
			{
				Text = "UI_RoomCount",
				Font = "P22UndergroundSCMedium",
				FontSize = 21,
				Color = Color.White,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				Justification = "Right",
				DataProperties = 
				{
					OpacityWithOwner = true,
				},
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			GroupName = "Combat_UI_World_Backing",
			X = ScreenCenterX,
			BottomOffset = UIData.ActionBarBottomOffset,
			UseScreenScaleX = true,
		},

		ActionBar =
		{
			X = 1750,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"ScrollRight",
				"ScrollLeft",
				"SelectButton",
				"InfoButton",
			},

			Children =
			{
				SelectButton =
				{
					Graphic = "ContextualActionButton",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_TraitPin",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				InfoButton =
				{
					Graphic = "ContextualActionButton",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Alpha = 0.0,
					Data =
					{
						OnPressedFunctionName = "TraitTrayScreenInfo",
						ControlHotkeys = { "MenuInfo", },
					},
					Text = "Menu_Info",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollLeft = 
				{
					Graphic = "ContextualActionButton",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "TraitTrayScreenPrevCategory",
						ControlHotkeys = { "MenuLeft", },
					},
					Text = "Menu_PrevCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				ScrollRight = 
				{
					Graphic = "ContextualActionButton",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "TraitTrayScreenNextCategory",
						ControlHotkeys = { "MenuRight", },
					},
					Text = "Menu_NextCategory",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
				
				CloseButton =
				{
					Graphic = "ContextualActionButton",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "TraitTrayScreenClose",
						ControlHotkeys = { "Cancel", },
						MouseControlHotkeys = { "Cancel", "AdvancedTooltip", }
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}