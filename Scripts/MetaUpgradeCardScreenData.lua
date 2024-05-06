ScreenData.MetaUpgradeCardLayout = 
{
	Components = {},
	BlockPause = true,
	
	DefaultStartX = 92,
	DefaultStartY = 114,
	DefaultTalentXSpacer = 148,
	DefaultTalentYSpacer = 190,

	CostStartX = 715,
	CostStartY = -160,
	DefaultArtScale = 0.2775,

	DefaultCardTitleTextArgs =
	{
		FontSize = 18, 
		Color = Color.DefaultText,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "LatoMedium",
		OffsetX = 100,
		OffsetY = 100,
		Color = Color.Transparent,
	},

	DefaultCardCostTitleArgs =
	{
		FontSize = 22, 
		Color = Color.White,
		OffsetX = 40,
		OffsetY = -77,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "P22UndergroundSCMedium",
		OutlineThickness = 4,
		OutlineColor = {0,0,0,1},
		ShadowBlur = 4, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
	},

	LockedCardCostTitleArgs =
	{
		FontSize = 22, 
		Color = Color.CodexLocked,
		OffsetX = 40,
		OffsetY = -77,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "P22UndergroundSCMedium",
		OutlineThickness = 4,
		OutlineColor = {0,0,0,1},
		ShadowBlur = 4, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
	},

	LockedCardTitleTextArgs =
	{
		FontSize = 18, 
		Color = Color.CodexLocked,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "LatoMedium",
		OffsetX = 100,
		OffsetY = 100,
		Color = Color.Transparent,
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
		FontSize = 20, 
		Color = Color.Transparent,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "LatoMedium",
		OffsetX = 100,
		OffsetY = 100,
	},

	CardAutoEquipTextArgs =
	{
		FontSize = 14,
		OffsetY = 200, 
		OffsetX = -30,
		Width = 560,
		LineSpacingBottom = 3,
		FontSize = 20,
		Color = Color.FlavorTextPurple,
		Font = "LatoItalic",
		ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 1},
		Justification = "CENTER",
		VerticalJustification = "CENTER",
		Graft = true,
	},

	CardFlavorTextArgs =
	{
		FontSize = 14,
		OffsetY = 340, 
		OffsetX = -30,
		Width = 560,
		LineSpacingBottom = 3,
		FontSize = 20,
		Color = Color.FlavorTextPurple,
		Font = "LatoItalic",
		ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 1},
		Justification = "CENTER",
		VerticalJustification = "CENTER",
		Graft = true,
	},

	CostDisplay =
	{
		StartX = 1110,
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
ScreenData.MetaUpgradeCardLayout.ComponentData = 
{
	DefaultGroup = "Combat_Menu_Overlay",
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
		X = -200,
		Y = -200,
	},

	CardSwapFrame = 
	{
		AnimationName = "DevCard_SwapHover",
		GroupName = "Combat_Menu_Overlay",
		X = -200,
		Y = -200,
	},

	Background = 
	{
		Graphic = "MetaUpgradeCardBackground",
		GroupName = "Combat_Menu",
		X = ScreenCenterX,
		Y = ScreenCenterY,
		Children = 
		{
			MemCostModule = 
			{
				GroupName = "Combat_Menu_Overlay_Backing",
				Graphic = "MetaUpgradeMemCostBacking",
				OffsetY = ScreenData.MetaUpgradeCardLayout.CostStartY - 105, 
				OffsetX = ScreenData.MetaUpgradeCardLayout.CostStartX,
				Children = 
				{			
					CostTextRingTarget= 
					{
						GroupName = "Combat_Menu_Overlay_Backing",
						OffsetY = -5,
						OffsetX = 2,
					},
					MemNotifyUpgradeAvailableFrame = 
					{
						GroupName = "Combat_Menu_Overlay_Backing",
						AnimationName = "MemNotifyUpgradeAvailableFrame",
						Alpha = 0,						
						Children = 
						{
							MemHighlightFrame = 
							{
								GroupName = "Combat_Menu_Overlay_Backing",
								AnimationName = "MetaUpgradeMemHighlightFrame",
								Alpha = 0,

							}
						}
					}
				},
				Data =
				{
					Name = "MemCostModule",
					OnPressedFunctionName = "IncreaseMetaUpgradeCardLimit",
					OnMouseOverFunctionName = "MouseOverMetaUpgradeCardLimit",
					OnMouseOffFunctionName = "MouseOffMetaUpgradeCardLimit",
					MouseOverSound = "/SFX/Menu Sounds/VictoryScreenBoonToggle",
				},
			},
			CostTextPrefix = 
			{
				GroupName = "Combat_Menu_Overlay",
				Text = "MetaUpgrade_CostPrefix",
				TextArgs = {
					FontSize = 26,
					OffsetY = ScreenData.MetaUpgradeCardLayout.CostStartY, 
					OffsetX = ScreenData.MetaUpgradeCardLayout.CostStartX,
					Width = 1040,
					Color = Color.Transparent,
					Font = "P22UndergroundSCHeavy",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "RIGHT" 
				}
			},
			CurrentCostText = 
			{
				GroupName = "Combat_Menu_Overlay",
				Text = "MEM_COST",
				TextArgs = {
					FontSize = 26,
					OffsetY = ScreenData.MetaUpgradeCardLayout.CostStartY,
					OffsetX = ScreenData.MetaUpgradeCardLayout.CostStartX - 38,
					Width = 1040,
					Color = Color.LightGreen,
					Font = "LatoBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "CENTER" 
				}
			},
			SlashText = 
			{
				GroupName = "Combat_Menu_Overlay",
				Text = "MetaUpgrade_Slash",
				TextArgs = {
					FontSize = 24,
					OffsetY = ScreenData.MetaUpgradeCardLayout.CostStartY,
					OffsetX = ScreenData.MetaUpgradeCardLayout.CostStartX - 14,
					Width = 1040,
					Color = Color.LightGreen,
					Font = "LatoBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "CENTER" 
				}
			},
			MaxCostText = 
			{
				GroupName = "Combat_Menu_Overlay",
				Text = "MEM_COST",
				OffsetY = ScreenData.MetaUpgradeCardLayout.CostStartY, 
				OffsetX = ScreenData.MetaUpgradeCardLayout.CostStartX - 4,
				TextArgs = {
					FontSize = 26,
					Width = 1040,
					Color = Color.LightGreen,
					Font = "LatoBold",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "LEFT",
				}
			},
			InfoPane = 
			{
				Graphic = null,
				GroupName = "Combat_Menu_Overlay_Backing",
				OffsetX = 180,
				OffsetY = 0,
				Scale = 1.0,
				Alpha = 1.0,
				Children = 
				{
					MetaUpgradeCardTitle = 
					{
						GroupName = "Combat_Menu_Overlay",
						Text = "TESTEXT 2",
						TextArgs = {
							FontSize = 32,
							OffsetY = 20, 
							OffsetX = -25,
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
					MetaUpgradeCardType = 
					{
						GroupName = "Combat_Menu_Overlay",
						OffsetY = -370, 
						OffsetX = 0,
					},
					MetaUpgradeCardArt = 
					{
						GroupName = "Combat_Menu_Overlay",
						AnimationName = "Blank",
						OffsetX = 57,
						OffsetY = -107,
						Scale = 1.0,
						Children = 
						{
							MetaUpgradeCardArtHighlight = 
							{
								GroupName = "Combat_Menu_Overlay",
							},
							MetaUpgradeCardArtPatch = 
							{
								GroupName = "Combat_Menu_Overlay",
								OffsetX = -233,
								OffsetY = -361,
							}
						}
					},
					
					MetaUpgradeCardText = 
					{
						GroupName = "Combat_Menu_Overlay",
						Text = "TESTEXT 3",
						TextArgs =
						{
							FontSize = 22,
							TextSymbolScale = 0.75,
							OffsetY = 65, 
							OffsetX = -35,
							Width = 550,
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
						Text = "AutoEquip Text Placeholder!",
						TextArgs =
						{
							FontSize = 22,
							TextSymbolScale = 0.75,
							OffsetY = 180,
							OffsetX = -35,
							Width = 550,
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
					
					MetaUpgradeResourceCostBacking = 
					{
						Graphic = "MetaUpgradeResourceCostBacking",
						Alpha = 1.0,
						OffsetX = -30,
						OffsetY = 340,
					},
					
					MetaUpgradeCardFlavorText = 
					{
						GroupName = "Combat_Menu_Overlay",
						Text = "Flavor Text Placeholder!",
						TextArgs = {},
					},
				}
			},
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
					OnPressedFunctionName = "MetaUpgradeCardScreenPinItem",
					ControlHotkeys = { "ItemPin", },
				},
				Text = "Menu_Pin",
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
					OnPressedFunctionName = "EnterUpgradeMode",
					ControlHotkeys = { "Confirm", },
				},
				Text = "MetaUpgradeMem_UpgradeMode",
				TextArgs = MergeTables( UIData.ContextualButtonFormatRight, { LuaValue = { Amount = 0 }, LuaKey = "TempTextData" }),
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
					OnPressedFunctionName = "CloseMetaUpgradeCardScreen",
					ControlHotkeys = { "Cancel", },
				},
				Text = "Menu_Exit",
				TextArgs = UIData.ContextualButtonFormatRight,
			},
		},
	},

	Letterbox =
	{
		X = ScreenCenterX,
		Y = ScreenCenterY,
		Animation = "GUI\\Graybox\\NativeAspectRatioFrame",
		Alpha = 0.0,
		AlphaTarget = 1.0,
		AlphaTargetDuration = 0.2,
		Requirements =
		{
			{
				PathFalse = { "ScreenState", "NativeAspetRatio" },
			}
		},
	},

	PillarboxLeft =
	{
		PillarboxLeft = true,
		Y = ScreenCenterY,
		GroupName = "Combat_Menu_TraitTray_Overlay",
		Animation = "GUI\\SideBars_01",
		FlipHorizontal = true,
		Alpha = 0.0,
		AlphaTarget = 1.0,
		AlphaTargetDuration = 0.2,
		Requirements =
		{
			{
				PathFalse = { "ScreenState", "NeedsPillarbox" },
			}
		},
	},

	PillarboxRight =
	{
		PillarboxRight = true,
		Y = ScreenCenterY,
		GroupName = "Combat_Menu_TraitTray_Overlay",
		Animation = "GUI\\SideBars_01",
		Alpha = 0.0,
		AlphaTarget = 1.0,
		AlphaTargetDuration = 0.2,
		Requirements =
		{
			{
				PathFalse = { "ScreenState", "NeedsPillarbox" },
			}
		},
	},
}