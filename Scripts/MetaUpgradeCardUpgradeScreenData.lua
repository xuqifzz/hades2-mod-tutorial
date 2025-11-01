ScreenData.MetaUpgradeCardUpgradeLayout = 
{
	GameStateRequirements = 
	{
		{
			PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },
		},
	},

	InspectLocationX = ScreenCenterX,
	InspectLocationY = ScreenCenterY,
	InspectBackgroundAlpha = 0.7,
	InspectCardScale = 1.4,

	Components = {},
	BlockPause = true,

	DefaultStartX = ScreenData.MetaUpgradeCardLayout.DefaultStartX,
	DefaultStartY = ScreenData.MetaUpgradeCardLayout.DefaultStartY,
	ScaledStartY = ScreenData.MetaUpgradeCardLayout.ScaledStartY,
	DefaultTalentXSpacer = ScreenData.MetaUpgradeCardLayout.DefaultTalentXSpacer,
	DefaultTalentYSpacer = ScreenData.MetaUpgradeCardLayout.DefaultTalentYSpacer,
	CostStartX = ScreenData.MetaUpgradeCardLayout.CostStartX,
	CostStartY = ScreenData.MetaUpgradeCardLayout.CostStartY,
	DefaultArtScale = ScreenData.MetaUpgradeCardLayout.DefaultArtScale,
	TooltipX = ScreenData.MetaUpgradeCardLayout.TooltipX,
	TooltipY = ScreenData.MetaUpgradeCardLayout.TooltipY,
	
	CardMemCostOffsetX = ScreenData.MetaUpgradeCardLayout.CardMemCostOffsetX,
	CardMemCostOffsetY = ScreenData.MetaUpgradeCardLayout.CardMemCostOffsetY,

	DefaultCardCostTitleArgs = ScreenData.MetaUpgradeCardLayout.DefaultCardCostTitleArgs,
	LockedCardCostTitleArgs = ScreenData.MetaUpgradeCardLayout.LockedCardCostTitleArgs,

	DefaultCardTitleTextArgs =
	{
		FontSize = 18, 
		Color = Color.Transparent,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "LatoMedium",
		OffsetX = 100,
		OffsetY = 100,
	},
	LockedCardTitleTextArgs =
	{
		FontSize = 18, 
		Color = Color.Transparent,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "LatoMedium",
		OffsetX = 100,
		OffsetY = 100,
	},

	LockedCardResourceTextArgs =
	{
		TextSymbolScale = 0.8,
		FontSize = 18,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "LatoMedium",
		BlockTooltip = true,
		OffsetX = 100,
	},

	MetaUpgradeCostIncreaseTextArgs =
	{
		TextSymbolScale = 0.8,
		FontSize = 18,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "LatoMedium",
		BlockTooltip = true,
	},

	HiddenCardTitleTextArgs =
	{
		FontSize = 18, 
		Color = Color.Transparent,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "LatoMedium",
		OffsetX = 100,
		OffsetY = 100,
	},

	CardFlavorTextArgs = 
	{
		FontSize = 20,
		OffsetY = 340, 
		OffsetX = -25,
		Width = 480,
		LineSpacingBottom = 3,
		Color = Color.FlavorText,
		Font = "LatoSemiboldItalic",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 1},
		Justification = "CENTER",
		VerticalJustification = "CENTER",
		Graft = true,
	},

	CostDisplay =
	{
		StartX = 1045,
		StartY = 880,
		SpacerX = 160,
		InventoryAmountOffsetY = 90,
		ResourceIconOffsetY = -5,
		ResourceIconScale = 1.1,
		InventoryIconOffsetX = -25,
		InventoryIconScale = 0.45,
	},
}

-- Several components below reference variables defined above
ScreenData.MetaUpgradeCardUpgradeLayout.ComponentData = 
{
	DefaultGroup = "Combat_Menu_Overlay",
	DefaultHighlightGroup = "Combat_Menu_Overlay_Additive",
	DefaultCornerGroup = "HUD_Backing",

	MouseOverGroup = "HUD_Main",
	MouseOverHighlightGroup = "Combat_UI_Additive",
	MouseOverCornerGroup = "Combat_Menu_TraitTray_Backing",

	UseNativeScreenCenter = true,

	BackgroundTint = 
	{
		Graphic = "rectangle01",
		GroupName = "Combat_UI_World_Backing",
		Scale = 10,
		X = ScreenCenterX,
		Y = ScreenCenterY,
	},
	
	CardHoverFrame = 
	{
		AnimationName = "DevCard_Hover",
		GroupName = "Combat_Menu_Overlay",
		X = -2000,
		Y = -2000,
	},

	UpgradeVignette =
	{
		AnimationName = "CardUpgradeModeVignetteEdge_Left",
		GroupName = "Combat_Menu_Overlay_Additive",
	},

	InspectBackground =
	{
		Graphic = "rectangle01",
		GroupName = "HUD_Main",
		Scale = 10,
		X = ScreenCenterX,
		Y = ScreenCenterY,
		Alpha = 0.0,
		AlphaTarget = 0.0,
		Color = Color.Black,
	},

	MetaUpgradeCardArt = 
	{
		GroupName = "HUD_Overlay",
		AnimationName = "Blank",
		X = 1040,
		Y = 268,
		Scale = 0.84,
		Alpha = 0.0,
		Children = 
		{
			MetaUpgradeCardArtPatch = 
			{
				GroupName = "HUD_Overlay",
				Scale = 0.84,
			}
		}
	},

	InspectName =
	{
		GroupName = "HUD_Main",
		X = ScreenCenterX,
		Y = 90,
		Alpha = 0.0,
		AlphaTarget = 0.0,
		TextArgs =
		{
			FontSize = 32,
			Width = 545,
			Height = 150,
			LineSpacingBottom = -10,
			Color = {1,1,1,1},
			Font = "P22UndergroundSCLight",
			ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			Justification = "CENTER",
			VerticalJustification = "CENTER",
		},
	},
	InspectFlavorText =
	{
		GroupName = "HUD_Main",
		X = ScreenCenterX,
		Y = 1010,
		Alpha = 0.0,
		AlphaTarget = 0.0,
		TextArgs =
		{
			FontSize = 20,
			Width = 560,
			LineSpacingBottom = 3,
			Color = Color.FlavorTextPurple,
			Font = "LatoItalic",
			ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 1},
			Justification = "CENTER",
			VerticalJustification = "CENTER",
			Graft = true,
		},
	},

	Background = 
	{
		Graphic = "MetaUpgradeCardBackground",
		GroupName = "Combat_Menu_Backing",
		X = ScreenCenterX,
		Y = ScreenCenterY,
		Children = 
		{
			InsightModeAdditiveBackgroundLayer = 
			{
				Graphic = "MetaUpgradeCardUpgradeBackground",
				GroupName = "Combat_Menu_Backing_Add",	
			},
			InsightModeMoonBackgroundLayer = 
			{
				Graphic = "MetaUpgradeUpgradeScreenBackgroundMoons",
				GroupName = "Portrait_FX_Behind",	
			},
			MemCostModuleBacking = 
			{
				GroupName = "Combat_Menu",
				AnimationName = "MetaUpgradeUpgradeHand",
				OffsetY = ScreenData.MetaUpgradeCardLayout.CostStartY - 130, 
			},

			InfoPane = 
			{
				GroupName = "Combat_Menu_Overlay_Backing",
				OffsetX = 110,
				OffsetY = 65,
				Scale = 1.0,
				Alpha = 1.0,
				Children = 
				{
					MetaUpgradeCardTitle = 
					{
						GroupName = "Combat_Menu_Overlay",
						Text = " ",
						TextArgs =
						{
							FontSize = 32,
							OffsetY = -45, 
							OffsetX = -30,
							Width = 545,
							Height = 150,
							LineSpacingBottom = -10,
							Color = {1,1,1,1},
							Font = "P22UndergroundSCLight",
							ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
							Justification = "CENTER",
							VerticalJustification = "CENTER",
						}
					},

					MetaUpgradeCardText = 
					{
						GroupName = "Combat_Menu_Overlay",
						Text = " ",
						TextArgs =
						{
							FontSize = 22,
							TextSymbolScale = 0.75,
							OffsetY = 0, 
							OffsetX = -35,
							Width = 570,
							LineSpacingBottom = 6,
							Color = {0.8, 0.8, 0.8, 1.0},
							Font = "LatoMedium",
							ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
							Justification = "CENTER",
							VerticalJustification = "TOP",
							VariableAutoFormat = "BoldFormatGraft",
						}
					},

					MetaUpgradeCardAutoEquipText =
					{
						GroupName = "Combat_Menu_Overlay",
						Text = " ",
						TextArgs =
						{
							FontSize = 22,
							TextSymbolScale = 0.75,
							OffsetY = 100,
							LangOffsetY = {
								{ Code = "ja", Value = 110 },
							},
							Width = 570,
							LineSpacingBottom = 6,
							Color = {0.8, 0.8, 0.8, 1.0},
							Font = "LatoMedium",
							ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
							Justification = "CENTER",
							VerticalJustification = "TOP",
							VariableAutoFormat = "BoldFormatGraft",
							FadeSpeed = 8.0,
							DataProperties =
							{
								OpacityWithOwner = true,
							},
						}
					},

					MetaUpgradeMaxRank = 
					{
						AnimationName = "MetaUpgradeUpgradeScreenMaxRank",
						Alpha = 0.0,
						OffsetX = -30,
						OffsetY = 280,
					},

					MetaUpgradeResourceCostBacking = 
					{
						Graphic = "MetaUpgradeResourceCostBacking",
						Alpha = 0.0,
						OffsetX = -30,
						OffsetY = 340,
					},
					
					MetaUpgradeCardMaxLevel = 
					{
						GroupName = "Combat_Menu_Overlay",
						Text = " ",
						TextArgs = {
							FontSize = 20,
							Width = 500,
							LineSpacingBottom = 6,
							Color = {0.8, 0.8, 0.8, 1.0},
							Font = "LatoMedium",
							ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
							Justification = "CENTER",
							VerticalJustification = "TOP",
							VariableAutoFormat = "BoldFormatGraft",
						},
						OffsetX = -30,
						OffsetY = 330,
					},
				},
			},			
		},		
	},
	
	ActionBarBackground =
	{
		AnimationName = "GUI\\ActionBar",
		GroupName = "Combat_Menu_Overlay",
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
			"UpgradeModeButton",
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
					OnPressedFunctionName = "MetaUpgradeCardUpgradeScreenPinItem",
					ControlHotkeys = { "ItemPin", },
				},
				Text = "MetaUpgrade_Pin",
				AltTexts = { "MetaUpgradeCard_Inspect" },
				TextArgs = UIData.ContextualButtonFormatRight,
			},

			UpgradeModeButton = 
			{
				Graphic = "ContextualActionButton",
				GroupName = "Combat_Menu_Overlay",
				Data =
				{
					OnMouseOverFunctionName = "MouseOverContextualAction",
					OnMouseOffFunctionName = "MouseOffContextualAction",
					OnPressedFunctionName = "ExitUpgradeMode",
					ControlHotkeys = { "Confirm", },
				},
				Text = "MetaUpgradeMem_ExitUpgradeMode",
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
				Text = "MetaUpgrade_Unlock",
				AltTexts = { "MetaUpgradeMem_Upgrade" },
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
					OnPressedFunctionName = "CloseUpgradeMetaUpgradeCardScreen",
					ControlHotkeys = { "Cancel", },
				},
				Text = "Menu_Exit",
				TextArgs = UIData.ContextualButtonFormatRight,
			},
		},
	},
}