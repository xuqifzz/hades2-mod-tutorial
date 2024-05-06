ScreenData.MetaUpgradeCardPromptLayout = 
{
	Components = {},

	OpenSound = "/SFX/Menu Sounds/HadesLocationTextAppear",
	-- CloseSound = "/SFX/Menu Sounds/GodBoonMenuClose",

	ComponentData = 
	{
		DefaultGroup = "Combat_Menu_TraitTray_Backing",
		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_TraitTray_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "MythmakerBoxDefault",
			GroupName = "Combat_Menu_TraitTray",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Scale = 1.15,
			Text = "MetaUpgrade_EquipAvailable",
			TextArgs =
			{
				FontSize = 32,
				Width = 750,
				Color = Color.White,
				Font = "P22UndergroundSCHeavy",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
			},

			Children = 
			{

				ConfirmButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.0,
					OffsetX = 200,
					OffsetY = 300,
					Text = "MetaUpgradeEquip_Proceed",
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "ConfirmExitMetaUpgradeCardPrompt",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},

				CenteredButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					OffsetX = 0,
					OffsetY = 300,
					Scale = 1.0,
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "CancelExitMetaUpgradeCardPrompt",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},

				CloseButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.0,
					OffsetX = -200,
					OffsetY = 300,
					Text = "MetaUpgradeEquip_Back",
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "CancelExitMetaUpgradeCardPrompt",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},
			}
		},
	}
}
ScreenData.GraspLimitLayout = 
{
	Components = {},

	OpenSound = "/SFX/Menu Sounds/HadesLocationTextAppear",
	CloseSound = "/SFX/Menu Sounds/GodBoonMenuClose",

	ComponentData = 
	{
		DefaultGroup = "Combat_Menu_TraitTray_Backing",
		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_TraitTray_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "MythmakerBoxDefault",
			GroupName = "Combat_Menu_TraitTray",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Scale = 1.15,
			Children = 
			{
				TitleText = 
				{

					Text = "MetaUpgradeTable_UnableToEquip",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -300,
					TextArgs =
					{
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "P22UndergroundSCMedium",
						FontSize = 40,
						Color = { 221, 211, 211, 255 },
						OutlineColor = { 27, 26, 23, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				DescriptionText = 
				{
					Text = "MetaUpgradeTable_UnableToEquip",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -100,
					TextArgs =
					{
						UseDescription = true,
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "LatoMedium",
						FontSize = 26,
						Width = 750,
						TextSymbolScale = 0.8,
						Color = { 207, 225, 217, 255 },
						OutlineColor = { 52, 51, 49, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				CloseButton = 
				{
					Graphic = "ShellButtonBack",
					GroupName = "Combat_Menu_TraitTray",
					OffsetX = 0,
					OffsetY = 300,
					Scale = 1.0,
					--Text = "MetaUpgrade_UpgradesAvailable_Close",
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "CloseGraspLimitScreen",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},
			}
		},
	}
}
ScreenData.BelowLimitLayout = 
{
	Components = {},

	OpenSound = "/SFX/Menu Sounds/HadesLocationTextAppear",
	CloseSound = "/SFX/Menu Sounds/GodBoonMenuClose",

	ComponentData = 
	{
		DefaultGroup = "Combat_Menu_TraitTray_Backing",
		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_TraitTray_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "MythmakerBoxDefault",
			GroupName = "Combat_Menu_TraitTray",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Scale = 1.15,
			Children = 
			{
				TitleText = 
				{

					Text = "MetaUpgrade_EquipAvailable",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -300,
					TextArgs =
					{
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "P22UndergroundSCMedium",
						FontSize = 40,
						Color = { 221, 211, 211, 255 },
						OutlineColor = { 27, 26, 23, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				DescriptionText = 
				{
					Text = "MetaUpgrade_EquipAvailable",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -100,
					TextArgs =
					{
						UseDescription = true,
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "LatoMedium",
						FontSize = 26,
						Width = 750,
						TextSymbolScale = 0.8,
						Color = { 207, 225, 217, 255 },
						OutlineColor = { 52, 51, 49, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				
				ConfirmButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.0,
					OffsetX = 200,
					OffsetY = 200,
					Text = "MetaUpgradeEquip_Proceed",
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "ConfirmExitBelowLimitScreen",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},
				CloseButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.0,
					OffsetX = -200,
					OffsetY = 200,
					Text = "MetaUpgradeEquip_Back",
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "CancelExitBelowLimitScreen",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},
			}
		},
	}
}
ScreenData.NoUpgradeInfoLayout = 
{
	Components = {},

	OpenSound = "/SFX/Menu Sounds/HadesLocationTextAppear",
	CloseSound = "/SFX/Menu Sounds/GodBoonMenuClose",

	ComponentData = 
	{
		DefaultGroup = "Combat_Menu_TraitTray_Backing",
		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_TraitTray_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "MythmakerBoxDefault",
			GroupName = "Combat_Menu_TraitTray",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Scale = 1.15,
			Children = 
			{
				TitleText = 
				{

					Text = "MetaUpgrade_CardUnlocksAvailable",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -300,
					TextArgs =
					{
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "P22UndergroundSCMedium",
						FontSize = 40,
						Color = { 221, 211, 211, 255 },
						OutlineColor = { 27, 26, 23, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				DescriptionText = 
				{
					Text = "MetaUpgrade_CardUnlocksAvailable",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -100,
					TextArgs =
					{
						UseDescription = true,
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "LatoMedium",
						FontSize = 26,
						Width = 750,
						TextSymbolScale = 0.8,
						Color = { 207, 225, 217, 255 },
						OutlineColor = { 52, 51, 49, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				
				ConfirmButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.0,
					OffsetX = 200,
					OffsetY = 300,
					Text = "MetaUpgradeEquip_Proceed",
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "ConfirmExitNoUpgradeInfoScreen",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},
				CloseButton = 
				{
					Graphic = "ButtonDefault",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.0,
					OffsetX = -200,
					OffsetY = 300,
					Text = "MetaUpgradeEquip_CardUnlockBack",
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "CancelExitNoUpgradeInfoScreen",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},
			}
		},
	}
}
ScreenData.CardUpgradeInfoLayout = 
{
	Components = {},

	OpenSound = "/SFX/Menu Sounds/HadesLocationTextAppear",
	CloseSound = "/SFX/Menu Sounds/GodBoonMenuClose",

	ComponentData = 
	{
		DefaultGroup = "Combat_Menu_TraitTray_Backing",
		UseNativeScreenCenter = true,

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_TraitTray_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "MythmakerBoxDefault",
			GroupName = "Combat_Menu_TraitTray",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Scale = 1.15,
			Children = 
			{
				TitleText = 
				{

					Text = "MetaUpgrade_UpgradesAvailable",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -300,
					TextArgs =
					{
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "P22UndergroundSCMedium",
						FontSize = 40,
						Color = { 221, 211, 211, 255 },
						OutlineColor = { 27, 26, 23, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				DescriptionText = 
				{
					Text = "MetaUpgrade_UpgradesAvailable",
					GroupName = "Combat_Menu_TraitTray",
					OffsetY = -100,
					TextArgs =
					{
						UseDescription = true,
						Justification = "Center",
						VerticalJustification = "Center",
						Font = "LatoMedium",
						FontSize = 26,
						Width = 750,
						TextSymbolScale = 0.8,
						Color = { 207, 225, 217, 255 },
						OutlineColor = { 52, 51, 49, 255 },
						ShadowColor = { 12, 11, 10, 255 },
						ShadowBlur = 0,
						ShadowOffset = { 0, 4 },
						OutlineThickness = 4,
					},
				},
				
				CloseButton = 
				{
					Graphic = "ShellButtonBack",
					GroupName = "Combat_Menu_TraitTray",
					Scale = 1.0,
					OffsetX = 0,
					OffsetY = 300,
					--Text = "MetaUpgrade_UpgradesAvailable_Close",
					TextArgs =
					{
						FontSize = 22,
						Width = 600,
						Color = Color.White,
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
					},
					Data =
					{
						OnPressedFunctionName = "CancelExitCardUpgradeInfoScreen",
						PressSound = "/SFX/Menu Sounds/GodBoonMenuClose",
					}
				},
			}
		},
	}
}