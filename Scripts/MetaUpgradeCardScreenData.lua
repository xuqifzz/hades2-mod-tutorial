ScreenData.MetaUpgradeCardLayout = 
{
	Components = {},
	BlockPause = true,
	
	DefaultStartX = 112,
	DefaultStartY = 170,
	ScaledStartY = -25,
	DefaultTalentXSpacer = 120,
	DefaultTalentYSpacer = 175,

	CostStartX = 570,
	CostStartY = 130,
	DefaultArtScale = 0.2775,
	MouseoverMemScale = 1.05,
	MouseoverArtScale = 0.43,
	StartMouseoverCostXOffset = 20.5,
	EndMouseoverCostXOffset = 19,
	MouseoverCostYOffset = -38,

	CardMemCostOffsetX = 0,
	CardMemCostOffsetY = 0,
	
	TooltipX = 1575,
	TooltipY = 550,

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

	DefaultCardCostTitleArgs =
	{
		FontSize = 28,
		Color = Color.White,
		StartOffsetX = 34,
		EndOffsetX = 35,
		OffsetY = -69,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		Font = "NumericP22UndergroundSCMedium",
		OutlineThickness = 4,
		OutlineColor = {0,0,0,1},
		ShadowBlur = 4, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
	},

	LockedCardCostTitleArgs =
	{
		FontSize = 22, 
		Color = Color.CodexLocked,
		OffsetX = 54,
		OffsetY = -88,
		Width = 485,
		Justification = "Center",
		VerticalJustification = "Center",
		LineSpacingBottom = 6,
		Font = "NumericP22UndergroundSCMedium",
		OutlineThickness = 4,
		OutlineColor = {0,0,0,1},
		ShadowBlur = 4, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
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
		FontSize = 20,
		OffsetY = 200, 
		OffsetX = -30,
		Width = 560,
		LineSpacingBottom = 3,
		Color = Color.FlavorTextPurple,
		Font = "LatoItalic",
		ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 1},
		Justification = "CENTER",
		VerticalJustification = "CENTER",
		Graft = true,
	},

	CardFlavorTextArgs =
	{
		FontSize = 20,
		OffsetY = 340, 
		OffsetX = -30,
		Width = 560,
		LineSpacingBottom = 3,
		Color = Color.FlavorTextPurple,
		Font = "LatoItalic",
		ShadowBlur = 0, ShadowColor = {0, 0, 0, 1}, ShadowOffset = {0, 1},
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

	LayoutSetArtOptionsBackgroundOpacity = 1.0,
	LayoutSetArtOptionsStartX = 150,
	LayoutSetArtOptionsStartY = 230,
	LayoutSetArtOptionsSpacingX = 180,
	LayoutSetArtOptionsSpacingY = 200,
	LayoutSetArtOptionsNumColumns = 10,
	LayoutSetArtOptionsScale = 0.75,
	LayoutSetArtOptionsMouseOverScale = 0.9,
	LayoutSetArtOptionsScaleDuration = 0.1,
	LayoutSetArtOptionsNewIconOffsetX = 0,
	LayoutSetArtOptionsNewIconOffsetY = -110,

	LayoutSetArtOptions =
	{
		-- Default
		{
			TextureNum = 1,
			GameStateRequirements =
			{
				-- None
			},
		},
		-- Underworld
		{
			TextureNum = 2,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck01" },
				},
			},
		},
		-- Surface
		{
			TextureNum = 3,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck01" },
				},
			},
		},
		-- Hermes
		{
			TextureNum = 10,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck01" },
				},
			},
		},
		-- Staff
		{
			TextureNum = 4,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck02" },
				},
			},
		},
		{
			TextureNum = 16,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck03" },
				},
			},
		},
		{
			TextureNum = 17,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck04" },
				},
			},
		},
		{
			TextureNum = 31,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck07" },
				},
			},
		},
		-- Daggers
		{
			TextureNum = 5,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck02" },
				},
			},
		},
		{
			TextureNum = 18,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck03" },
				},
			},
		},
		{
			TextureNum = 19,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck04" },
				},
			},
		},
		{
			TextureNum = 32,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck07" },
				},
			},
		},
		-- Torch
		{
			TextureNum = 6,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck02" },
				},
			},
		},
		{
			TextureNum = 20,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck03" },
				},
			},
		},
		{
			TextureNum = 21,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck04" },
				},
			},
		},
		{
			TextureNum = 33,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck07" },
				},
			},
		},
		-- Axe
		{
			TextureNum = 7,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck02" },
				},
			},
		},
		{
			TextureNum = 22,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck03" },
				},
			},
		},
		{
			TextureNum = 23,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck04" },
				},
			},
		},
		{
			TextureNum = 34,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck07" },
				},
			},
		},
		-- Lob
		{
			TextureNum = 8,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck02" },
				},
			},
		},
		{
			TextureNum = 24,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck03" },
				},
			},
		},
		{
			TextureNum = 25,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck04" },
				},
			},
		},
		{
			TextureNum = 35,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck07" },
				},
			},
		},
		-- Suit
		{
			TextureNum = 9,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck02" },
				},
			},
		},
		{
			TextureNum = 26,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck03" },
				},
			},
		},
		{
			TextureNum = 27,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck04" },
				},
			},
		},
		{
			TextureNum = 36,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck07" },
				},
			},
		},
		-- Familiars
		{
			TextureNum = 11,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck05" },
				},
			},
		},
		{
			TextureNum = 14,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck05" },
				},
			},
		},
		{
			TextureNum = 12,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck05" },
				},
			},
		},
		{
			TextureNum = 13,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck05" },
				},
			},
		},

		{
			TextureNum = 15,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck05" },
				},
			},
		},
		-- Fear
		{
			TextureNum = 28,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck06" },
				},
			},
		},
		{
			TextureNum = 29,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck06" },
				},
			},
		},
		{
			TextureNum = 30,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck06" },
				},
			},
		},
		-- Relics
		{
			TextureNum = 37,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck08" },
				},
			},
		},
		{
			TextureNum = 38,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck08" },
				},
			},
		},
		{
			TextureNum = 39,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck08" },
				},
			},
		},
		{
			TextureNum = 40,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "Cosmetic_CardDeck08" },
				},
			},
		},
	},

	LayoutSetSpacingX = 0,
	LayoutSetSpacingY = 126,
	LayoutSetTemplate =
	{
		Requirements = MetaUpgradeSaveLayoutData.GameStateRequirements,
		Graphic = "BlankInteractableObstacle",
		X = 1772,
		Y = 205,
		Scale = 0.5,
		MouseOverScale = 0.55,
		Data =
		{
			OnPressedFunctionName = "MetaUpgradeCardScreenSelectLayout",
			OnMouseOverFunctionName = "MetaUpgradeCardScreenMouseOverLayout",
			OnMouseOffFunctionName = "MetaUpgradeCardScreenMouseOffLayout",
			MouseOverSound = "/Leftovers/World Sounds/Caravan Interior/CardsInteract",
		},
		InteractProperties =
		{
			FreeFormSelectable = false,
		},
	},

	PinnedMetaUpgradeLevelData =
	{
		DisplayName = "MetaUpgradeCardLimit_Upgrade",
		Icon = "GUI\\Icons\\ManaCrystal",
		IconScale = 1.5,
	},
	BonePositions = 
	{
		[1] = { X = -4, Y = 149 },
		[2] = { X = 3, Y = 301 },
		[3] = { X = 63, Y = 148 },
		[4] = { X = -6, Y = 69 },
		[5] = { X = 48, Y = 79 },
		[6] = { X = 78, Y = 72 },
		[7] = { X = 82, Y = 48 },
		[8] = { X = 57, Y = 33 },
		[9] = { X = 19, Y = 42 },
		[10] = { X = -12, Y = 30 },
		[11] = { X = -40, Y = 36 },
		[12] = { X = -75, Y = -35 },
		[13] = { X = -27, Y = -77 },
		[14] = { X = 21, Y = -79 },
		[15] = { X = 69, Y = -65 },
		[16] = { X = 107, Y = -46 },
		[17] = { X = 144, Y = -136 },
		[18] = { X = 88, Y = -181},
		[19] = { X = 25, Y = -225},
		[20] = { X = -43, Y = -215},
		[21] = { X = -114, Y = -116},
		[22] = { X = -137, Y = -180},
		[23] = { X = -51, Y = -297},
		[24] = { X = 33, Y = -350},
		[25] = { X = 116, Y = -313},
		[26] = { X = 177, Y = -207},
		[27] = { X = 180, Y = -256},
		[28] = { X = 122, Y = -371},
		[29] = { X = 40, Y = -418},
		[30] = { X = -58, Y = -386},
	},
}


-- Several components below reference variables defined above
ScreenData.MetaUpgradeCardLayout.ComponentData = 
{
	DefaultGroup = "Combat_Menu_Overlay",
	DefaultHighlightGroup = "Combat_Menu_Overlay_Additive",
	DefaultCornerGroup = "HUD_Backing",

	MouseOverGroup = "HUD_Main",
	MouseOverHighlightGroup = "Combat_UI_Additive",
	MouseOverCornerGroup = "Combat_Menu_TraitTray_Backing",

	UseNativeScreenCenter = true,

	Order =
	{
		"MemCostModule",
		"LayoutSet1",
		"LayoutSet2",
		"LayoutSet3",
		"LayoutSet4",
		"LayoutSet5",
		"LayoutSet6",
		"LayoutSetSelectionHighlight",
	},

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
		X = -1000,
		Y = -1000,
	},

	LayoutSet1 = MergeTables( ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate,
	{
		MetaUpgradeLayoutNum = 1,
		X = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.X + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingX * 0),
		Y = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.Y + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingY * 0),
	}),
	LayoutSet2 = MergeTables( ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate,
	{
		MetaUpgradeLayoutNum = 2,
		X = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.X + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingX * 1),
		Y = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.Y + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingY * 1),
	}),
	LayoutSet3 = MergeTables( ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate,
	{
		MetaUpgradeLayoutNum = 3,
		X = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.X + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingX * 2),
		Y = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.Y + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingY * 2),
	}),
	LayoutSet4 = MergeTables( ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate,
	{
		MetaUpgradeLayoutNum = 4,
		X = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.X + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingX * 3),
		Y = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.Y + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingY * 3),
	}),
	LayoutSet5 = MergeTables( ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate,
	{
		MetaUpgradeLayoutNum = 5,
		X = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.X + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingX * 4),
		Y = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.Y + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingY * 4),
	}),
	LayoutSet6 = MergeTables( ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate,
	{
		MetaUpgradeLayoutNum = 6,
		X = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.X + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingX * 5),
		Y = ScreenData.MetaUpgradeCardLayout.LayoutSetTemplate.Y + (ScreenData.MetaUpgradeCardLayout.LayoutSetSpacingY * 5),
	}),

	LayoutSetSelectionHighlight = 
	{
		Requirements = MetaUpgradeSaveLayoutData.GameStateRequirements,
		AnimationName = "DeckArt_Selected",
		GroupName = "Combat_Menu_Overlay_Additive",
	},

	LayoutArtSwapBackground =
	{
		Animation = "MetaUpgradeLayoutArtSwapBackground",
		GroupName = "HUD_Main",
		Scale = 1,
		X = ScreenCenterX,
		Y = ScreenCenterY,
		Alpha = 0.0,
	},

	LayoutArtSwapSelectionHighlight = 
	{
		AnimationName = "DeckArt_Selected",
		GroupName = "Combat_UI_Additive",
		Alpha = 0.0,
	},

	Background = 
	{
		Graphic = "MetaUpgradeCardBackground",
		GroupName = "Combat_Menu",
		X = ScreenCenterX,
		Y = ScreenCenterY,
		Children = 
		{
			MemCostModuleBacking = 
			{
				RedirectClick = "MemCostModule",
				GroupName = "Combat_Menu",
				Graphic = "MetaUpgradeMemCostBackground",
				FlavorText = "Max_MetaUpgrade_FlavorText01",
				OffsetY = ScreenData.MetaUpgradeCardLayout.CostStartY, 
				OffsetX = ScreenData.MetaUpgradeCardLayout.CostStartX,
				Data = 
				{	
					OnPressedFunctionName = "IncreaseMetaUpgradeCardLimit",
					OnMouseOverFunctionName = "MouseOverMetaUpgradeCardLimit",
					OnMouseOffFunctionName = "MouseOffMetaUpgradeCardLimit",
				},
				Children = 
				{
					CostTextRingTarget =
					{
						GroupName = "Combat_Menu_Overlay_Backing",
					},
					MemCostModuleBackingFx = 
					{
						GroupName = "Combat_Menu_Overlay_Additive",
						AnimationName = "MetaUpgradeGhostHandFxIn",
					},
					Darkener = 
					{
						AnimationName = "MetaUpgradeMemCostBackgroundDiffuser",				
						OffsetY = 380, 
					}
				}
			},

			InfoPane = 
			{
				Graphic = null,
				GroupName = "Combat_Menu_Overlay_Backing",
				OffsetX = 110,
				OffsetY = 65,
				Scale = 1.0,
				Alpha = 1.0,
				Children = 
				{
					MetaUpgradeCardTitle = 
					{
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
					
					MetaUpgradeCardArt = 
					{
						AnimationName = "Blank",
						OffsetX = -30,
						OffsetY = -337,
						Scale = 0.84,
						Alpha = 0,
						Children = 
						{
							MetaUpgradeCardArtPatch = 
							{
								GroupName = "Combat_Menu_Overlay",
								Scale = 0.84,
							}
						}
					},
					
					MetaUpgradeCardText = 
					{
						GroupName = "Combat_Menu_Overlay_Backing",
						Text = " ",
						TextArgs =
						{
							FontSize = 22,
							TextSymbolScale = 0.75,
							OffsetY = 0, 
							OffsetX = -35,
							Width = 550,
							LangWidth = {
								{ Code = "pl", Value = 612 },
							},
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
						GroupName = "Combat_Menu_Overlay_Backing",
						Text = " ",
						TextArgs =
						{
							FontSize = 22,
							TextSymbolScale = 0.75,
							OffsetY = 100,
							LangOffsetY = {
								{ Code = "ja", Value = 110 },
							},
							OffsetX = -35,
							Width = 570,
							LangWidth = {
								{ Code = "uk", Value = 585 },
								{ Code = "pl", Value = 612 },
							},
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
						Alpha = 0,
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

	MemCostModuleHoverTarget = 
	{
		Graphic = "InvisibleTarget",
		X = ScreenCenterX + ScreenData.MetaUpgradeCardLayout.CostStartX + 110 + 3,
		Y = ScreenCenterY + ScreenData.MetaUpgradeCardLayout.CostStartY - 550 - 23, 
	},
	MemCostModuleBaseTarget = 
	{
		Graphic = "InvisibleTarget",
		X = ScreenCenterX + ScreenData.MetaUpgradeCardLayout.CostStartX + 110,
		Y = ScreenCenterY + ScreenData.MetaUpgradeCardLayout.CostStartY - 550, 
	},
	MemCostModule =
	{
		GroupName = "Combat_Menu_Overlay_Backing",
		Graphic = "MetaUpgradeMemCostBacking",
		TooltipOffsetY = 425,
		PinOffsetX = 10,
		PinOffsetY = 140,
		Children = 
		{
			PipRingTarget = 
			{
				GroupName = "Combat_Menu_Overlay_Backing",
				OffsetX = 3
			},
			MemNotifyUpgradeAvailableFrame = 
			{
				GroupName = "Combat_Menu_Overlay_Backing",
				AnimationName = "MemNotifyUpgradeAvailableFrame",
				Alpha = 0,
				OffsetX = 4,
				OffsetY = 1,
				Children = 
				{
					MemHighlightFrame = 
					{
						GroupName = "Combat_Menu_Additive",
						AnimationName = "MetaUpgradeMemHighlightFrame",
						Alpha = 0,
					}
				}
			},

			CurrentCostText = 
			{
				Text = "MEM_COST",
				TextArgs =
				{
					FontSize = 26,
					OffsetX = -5,
					OffsetY = -1,
					Width = 1040,
					Color = Color.LightGreen,
					Font = "NumericP22UndergroundSCMedium",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "RIGHT",
					VerticalJustification = "CENTER",
				}
			},

			SlashText = 
			{
				Text = "MetaUpgrade_Slash",
				TextArgs =
				{
					FontSize = 24,
					OffsetX = -3,
					OffsetY = 0,
					Width = 1040,
					Color = Color.LightGreen,
					Font = "NumericP22UndergroundSCMedium",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "CENTER",
					VerticalJustification = "CENTER",
				}
			},

			MaxCostText = 
			{
				Text = "MEM_COST",
				OffsetX = 11,
				OffsetY = -1,
				TextArgs =
				{
					FontSize = 26,
					Width = 1040,
					Color = Color.LightGreen,
					Font = "NumericP22UndergroundSCMedium",
					ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					Justification = "LEFT",
				}
			},
		},
	},

	ActionBarLeft =
	{
		X = UIData.ContextualButtonXLeft,
		Y = UIData.ContextualButtonY,
		AutoAlignContextualButtons = true,
		AutoAlignJustification = "Left",

		ChildrenOrder =
		{
			"PrevMetaUpgradeSetButton",
			"NextMetaUpgradeSetButton",				
		},

		Children = 
		{
			PrevMetaUpgradeSetButton = 
			{
				Graphic = "ContextualActionButton",
				GroupName = "HUD_Backing",
				Requirements = MetaUpgradeSaveLayoutData.GameStateRequirements,
				Data =
				{
					OnMouseOverFunctionName = "MouseOverContextualAction",
					OnMouseOffFunctionName = "MouseOffContextualAction",
					OnPressedFunctionName = "MetaUpgradeCardScreenPrevLayout",
					ControlHotkeys = { "PrevLayout", },
				},
				Text = "MetaUpgrade_PrevLayout",
				TextArgs = UIData.ContextualButtonFormatLeft,
			},

			NextMetaUpgradeSetButton = 
			{
				Graphic = "ContextualActionButton",
				GroupName = "HUD_Backing",
				Requirements = MetaUpgradeSaveLayoutData.GameStateRequirements,
				Data =
				{
					OnMouseOverFunctionName = "MouseOverContextualAction",
					OnMouseOffFunctionName = "MouseOffContextualAction",
					OnPressedFunctionName = "MetaUpgradeCardScreenNextLayout",
					ControlHotkeys = { "NextLayout", },
				},
				Text = "MetaUpgrade_NextLayout",
				TextArgs = UIData.ContextualButtonFormatLeft,
			},
	},
	},
	
	ActionBarBackground =
	{
		AnimationName = "GUI\\ActionBar",
		X = ScreenCenterX,
		Y = UIData.ActionBarY + 44,
		GroupName = "HUD_Backing",
		UseScreenScaleX = true,
		ScaleY = 0.4,
		Alpha = 0.0,
		AlphaTarget = 0.5,
		AlphaTargetDuration = 0.1,
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
				GroupName = "HUD_Backing",
				Alpha = 0.0,
				Data =
				{
					-- Hotkey only
					OnPressedFunctionName = "MetaUpgradeCardScreenPinItem",
					ControlHotkeys = { "ItemPin", },
				},
				Text = "MetaUpgrade_Pin",
				AltTexts = { "MetaUpgrade_SwapLayoutArt", },
				TextArgs = UIData.ContextualButtonFormatRight,
			},

			UpgradeModeButton = 
			{
				Graphic = "ContextualActionButton",
				GroupName = "HUD_Backing",
				Requirements = 
				{
					{ PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },}
				},
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
				GroupName = "HUD_Backing",
				Alpha = 0.0,
				Data =
				{
					-- Dummy button
				},
				Text = "MetaUpgrade_Unlock",
				AltTexts = { "MetaUpgrade_Unequip", "MetaUpgrade_Equip" },
				TextArgs = UIData.ContextualButtonFormatRight,
			},

			CloseButton = 
			{
				Graphic = "ContextualActionButton",
				GroupName = "HUD_Backing",
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

	LayoutArtSwapActionBarBackground =
	{
		AnimationName = "GUI\\ActionBar",
		GroupName = "HUD_Main",
		X = ScreenCenterX,
		Y = UIData.ActionBarY,
		UseScreenScaleX = true,
		Alpha = 0.0,
	},

	LayoutArtSwapActionBar =
	{
		X = UIData.ContextualButtonXRight,
		Y = UIData.ContextualButtonY,
		AutoAlignContextualButtons = true,
		AutoAlignJustification = "Right",

		ChildrenOrder =
		{
			"LayoutArtSwapCloseButton",
			"LayoutArtSwapSelectButton",
		},

		Children =
		{
			LayoutArtSwapSelectButton =
			{
				Graphic = "ContextualActionButton",
				GroupName = "HUD_Main",
				Alpha = 0.0,
				Data =
				{
					-- Dummy button
				},
				Text = "MetaUpgrade_SwapLayoutArtSelect",
				AltTexts = { "MetaUpgrade_Unequip", "MetaUpgrade_Equip" },
				TextArgs = UIData.ContextualButtonFormatRight,
			},

			LayoutArtSwapCloseButton = 
			{
				Graphic = "ContextualActionButton",
				GroupName = "HUD_Main",
				UseableOff = true,
				Alpha = 0.0,
				Data =
				{
					OnMouseOverFunctionName = "MouseOverContextualAction",
					OnMouseOffFunctionName = "MouseOffContextualAction",
					OnPressedFunctionName = "MetaUpgradeCardScreenLayoutSetSwapClose",
				},
				Text = "Menu_Exit",
				TextArgs = UIData.ContextualButtonFormatRight,
			},
		},
	},
}

-- Altar
GlobalVoiceLines.OpenedCardScreenVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelCardScreenOpenedSpeech", Time = 180 },
	},
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		-- RandomRemaining = true,
		PreLineWait = 0.45,
		-- SuccessiveChanceToPlay = 0.5,
		-- SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				PathTrue = { "ActiveScreens", "MetaUpgradeCardLayout" },
			},
		},

		{ Cue = "/VO/Melinoe_1609", Text = "Headmistress lent me the Arcana..." },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "CardUpgradeIntroVO",
		BreakIfPlayed = true,
		-- RandomRemaining = true,
		PreLineWait = 0.45,
		-- SuccessiveChanceToPlay = 0.5,
		-- SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				PathTrue = { "ActiveScreens", "MetaUpgradeCardLayout" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" }
			},
		},

		-- also copy lines below to OpenedCardScreenHighPsycheLines
		{ Cue = "/VO/Melinoe_3912", Text = "The Arcana... I finally understand..." },
	},
	{
		PlayOnce = true,
		PlayOnceContext = "CardUpgradeIntroVO",
		BreakIfPlayed = true,
		-- RandomRemaining = true,
		PreLineWait = 0.45,
		-- SuccessiveChanceToPlay = 0.5,
		-- SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				PathTrue = { "ActiveScreens", "MetaUpgradeCardLayout" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMetaUpgradeSaveLayout" },
			},
		},

		{ Cue = "/VO/Melinoe_3828", Text = "I can store different arrangements of Arcana now..." },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.5,
		GameStateRequirements =
		{
			{
				PathTrue = { "ActiveScreens", "MetaUpgradeCardLayout" },
			},
		},

		{ Cue = "/VO/Melinoe_2404", Text = "The Ashes remember." },
		{ Cue = "/VO/Melinoe_2405", Text = "Ashes of the past..." },
		{ Cue = "/VO/Melinoe_2406", Text = "What say the Ashes...?" },
		{ Cue = "/VO/Melinoe_0539", Text = "The Arcana..." },
		{ Cue = "/VO/Melinoe_0540", Text = "Strength and wisdom of my predecessors." },
		{ Cue = "/VO/Melinoe_0541", Text = "Focus..." },
		{ Cue = "/VO/Melinoe_1135", Text = "What say the Cards this eve?" },
		{ Cue = "/VO/Melinoe_1136", Text = "Which Cards reflect my path...?" },
		{ Cue = "/VO/Melinoe_1137", Text = "Know the past, know the future..." },
		{ Cue = "/VO/Melinoe_1138", Text = "What say the Arcana...?" },
		{ Cue = "/VO/Melinoe_1139", Text = "I have this..." },
		{ Cue = "/VO/Melinoe_1867", Text = "Wisdom of the ages..." },
		{ Cue = "/VO/Melinoe_1868", Text = "{#Emph}<Sigh>" },
		{ Cue = "/VO/Melinoe_1869", Text = "What is my path...?" },
		{ Cue = "/VO/Melinoe_1870", Text = "Just breathe..." },
		{ Cue = "/VO/Melinoe_2403", Text = "The Altar of Ashes.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1609" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0538", Text = "My Altar...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 12,
				},
			}
		},
	},
}
GlobalVoiceLines.OpenedCardScreenHighPsycheLines =
{
	Cooldowns =
	{
		{ Name = "MelCardScreenOpenedSpeech", Time = 120 },
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.55,
		SuccessiveChanceToPlayAll = 0.05,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_3773", Text = "I should be able to increase my Grasp..." },
		{ Cue = "/VO/Melinoe_3774", Text = "Think I can raise my Grasp..." },
		{ Cue = "/VO/Melinoe_3912", Text = "The Arcana... I finally understand...",
			PlayFirst = true,
			PlayOnceContext = "CardUpgradeIntroVO",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" }
				},
			}
		},
		{ Cue = "/VO/Melinoe_3828", Text = "I can store different arrangements of Arcana now...",
			PlayFirst = true,
			PlayOnce = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMetaUpgradeSaveLayout" }
				},
			},
		},
	},
}

GlobalVoiceLines.UnlockedCardVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlayAll = 0.33,
	SkipAnim = true,
	Cooldowns =
	{
		{ Name = "MelCardUnlockSpeech", Time = 10 },
	},

	{ Cue = "/VO/Melinoe_0544", Text = "New Arcana..." },
	{ Cue = "/VO/Melinoe_0545", Text = "Another Card..." },
}

GlobalVoiceLines.UpgradedMemLimitVoiceLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "AllMEMUnlockedVO",
		PreLineWait = 0.35,
		BreakIfPlayed = true,
		UsePlayerSource = true,
		SkipAnim = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "MaxMetaUpgradeCostCache" },
				Comparison = ">=",
				Value = 29,
			}
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_4403", Text = "I know my limit now, and this is it." },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		PlayOnceFromTableThisRun = true,
		SuccessiveChanceToPlayAll = 0.1,
		UsePlayerSource = true,
		SkipAnim = true,
		Cooldowns =
		{
			{ Name = "MelMemUpgradeSpeech", Time = 4 },
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Melinoe_0547", Text = "I can do this...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_0548", Text = "Concentrate..." },
		{ Cue = "/VO/Melinoe_2602", Text = "All in the mind..." },
		{ Cue = "/VO/Melinoe_2603", Text = "Remnants of the past..." },
		{ Cue = "/VO/Melinoe_2604", Text = "So that's it..." },
		{ Cue = "/VO/Melinoe_2605", Text = "I see it now..." },
		{ Cue = "/VO/Melinoe_2606", Text = "I never realized..." },
		{ Cue = "/VO/Melinoe_2607", Text = "Just as I thought..." },
	},
}
GlobalVoiceLines.CannotAffordMemUpgradeVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlayAll = 0.1,
	UsePlayerSource = true,
	SkipAnim = true,
	GameStateRequirements =
	{
		{
			Path = { "GameState", "MaxMetaUpgradeCostCache" },
			Comparison = "<",
			Value = 30,
		}
	},

	{ Cue = "/VO/Melinoe_0779", Text = "I need more Psyche..." },
	{ Cue = "/VO/Melinoe_0780", Text = "Don't have enough Psyche..." },
}

GlobalVoiceLines.ReachedMemLimitVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	UsePlayerSource = true,
	SkipAnim = true,
	Cooldowns =
	{
		{ Name = "MelMemLimitSpeech", Time = 30 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

	{ Cue = "/VO/Melinoe_2325", Text = "I lack the Grasp for this.", PlayFirst = true, },
	{ Cue = "/VO/Melinoe_2326", Text = "I can't quite grasp this one..." },
	{ Cue = "/VO/Melinoe_2327", Text = "This is beyond my Grasp." },
	{ Cue = "/VO/Melinoe_2328", Text = "Don't think I can do this..." },
	{ Cue = "/VO/Melinoe_0777", Text = "I'm at my limit." },
	{ Cue = "/VO/Melinoe_0778", Text = "I've reached my limit." },
}
GlobalVoiceLines.ReachedMaxMemLimitVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	UsePlayerSource = true,
	SkipAnim = true,
	Cooldowns =
	{
		{ Name = "MelMemLimitSpeech", Time = 30 },
	},

	{ Cue = "/VO/Melinoe_0777", Text = "I'm at my limit." },
	{ Cue = "/VO/Melinoe_0778", Text = "I've reached my limit." },
}
GlobalVoiceLines.ClosedCardScreenVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.75,
	PlayOnceFromTableThisRun = true,
	SuccessiveChanceToPlay = 0.5,
	SuccessiveChanceToPlayAll = 0.33,
	UsePlayerSource = true,
	GameStateRequirements =
	{
		{
			PathTrue = { "SessionState", "MetaUpgradeChanges", "HasChanged" },
		},
	},
	SkipCooldownCheckIfNonePlayed = true,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1140", Text = "Ready for more." },
	{ Cue = "/VO/Melinoe_1141", Text = "The Cards know." },
	{ Cue = "/VO/Melinoe_1142", Text = "Better prepared." },
	{ Cue = "/VO/Melinoe_1143", Text = "That'll do.", PlayFirst = true },
	{ Cue = "/VO/Melinoe_0549", Text = "Very well." },
	{ Cue = "/VO/Melinoe_0550", Text = "Ready." },
}
GlobalVoiceLines.SwitchToUpgradeCardModeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.3,
	SuccessiveChanceToPlayAll = 0.3,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "MelCardScreenModeSpeech", Time = 20 },
	},

	{ Cue = "/VO/Melinoe_0992", Text = "What's this...?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "FirstTimeSwitchedToUpgradeModeVO" },
	{ Cue = "/VO/Melinoe_0242", Text = "Let me see..." },
	{ Cue = "/VO/Melinoe_5561", Text = "Insights..." },
	{ Cue = "/VO/Melinoe_5562", Text = "The other side..." },
}
GlobalVoiceLines.SwitchFromUpgradeCardModeVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.3,
	SuccessiveChanceToPlayAll = 0.3,
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
		{ Name = "MelCardScreenModeSpeech", Time = 20 },
	},

	{ Cue = "/VO/Melinoe_0282", Text = "{#Emph}Whew." },
	{ Cue = "/VO/Melinoe_0575", Text = "{#Emph}Hm." },
	{ Cue = "/VO/Melinoe_5563", Text = "Back..." },
	{ Cue = "/VO/Melinoe_5564", Text = "Moving on..." },
}
GlobalVoiceLines.UpgradeCardVoiceLines =
{
	Cooldowns =
	{
		{ Name = "MelCardUpgradeSpeech", Time = 2 },
	},
	TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		SuccessiveChanceToPlayAll = 0.75,

		{ Cue = "/VO/Melinoe_2973", Text = "I see it now...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2976", Text = "I never realized...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2978", Text = "This potential...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2974", Text = "Now I see..." },
		{ Cue = "/VO/Melinoe_2975", Text = "I understand..." },
		{ Cue = "/VO/Melinoe_2977", Text = "So that's it..." },
		{ Cue = "/VO/Melinoe_0993", Text = "I see it now." },
		{ Cue = "/VO/Melinoe_0994", Text = "I see..." },
		{ Cue = "/VO/Melinoe_0995", Text = "So that's it..." },
		{ Cue = "/VO/Melinoe_0546", Text = "This strength is mine." },
		{ Cue = "/VO/Melinoe_5576", Text = "There we are." },
		{ Cue = "/VO/Melinoe_5577", Text = "Improved..." },
		{ Cue = "/VO/Melinoe_5578", Text = "Deeper connection..." },
		{ Cue = "/VO/Melinoe_5579", Text = "A new detail..." },
		{ Cue = "/VO/Melinoe_5580", Text = "Closer to me..." },
		{ Cue = "/VO/Melinoe_5581", Text = "Wisdom of the past..." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,

		{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
		{ Cue = "/VO/Melinoe_0179", Text = "All right." },
		{ Cue = "/VO/Melinoe_0185", Text = "There." },
		{ Cue = "/VO/Melinoe_0205", Text = "Better." },
		{ Cue = "/VO/Melinoe_0203", Text = "Yes." },
		{ Cue = "/VO/Melinoe_0209", Text = "There." },
		{ Cue = "/VO/Melinoe_0206", Text = "Good." },
	},
}