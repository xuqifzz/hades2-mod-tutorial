ScreenData.TradeScreen = 
{
	Components = {},
	BlockPause = true,
	AllowAdvancedTooltip = false, -- Block the normal hotkey, works through TraitTrayButton
	FreezePlayerArgs =
	{
		DisableTray = false,
	},			

	OpenSound = "/SFX/Menu Sounds/GenericPanelIn",
	-- CloseSound = "/SFX/Menu Sounds/GodBoonMenuClose",

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 16,
		FreeFormSelectSuccessDistanceStep = 1,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval= 0.1,
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundTint",
			"Background",
		},
		
		BackgroundTint = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = Color.Black,
			Alpha = 0.0,
			AlphaTarget = 0.65,
			AlphaTargetDuration = 0.3,
		},

		Background = 
		{
			Animation = "TradeScreenBackground",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		TitleText = 
		{
			Text = "TradeScreen_Title",
			X = ScreenCenterX,
			Y = 100,
			TextArgs =
			{
				FontSize = 32,
				OffsetX = 0, OffsetY = 0,
				Color = Color.White,
				Font = "P22UndergroundSCLightTitling",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				OutlineThickness = 3,
				Justification = "Center",
			}
		},

		SubtitleText = 
		{
			Text = "TradeScreen_Subtitle",
			X = ScreenCenterX,
			Y = 150,
			TextArgs =
			{
				FontSize = 19,
				OffsetX = 0, OffsetY = 0,
				Color = { 0.8, 0.8, 0.8, 1.0 },
				Font = "LatoItalic",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "Center",
			},
		},

		GiveHintText = 
		{
			Text = "TradeScreen_GiveHint",
			X = 540,
			Y = 365,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.PenaltyRed,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		GiveInfoBoxBacking =
		{
			X = ScreenCenterX,
			Y = ScreenCenterY,
			-- Description
			TextArgs =
			{
				OffsetX = -520,
				OffsetY = 120,
				Width = 420,
				Justification = "Left",
				VerticalJustification = "Top",
				LineSpacingBottom = 5,
				LuaKey = "TooltipData",
				LuaValue = {},
				Format = "BaseFormat",
				UseDescription = true,
				VariableAutoFormat = "BoldFormatGraft",
				TextSymbolScale = 0.8,
			},
			InteractProperties =
			{
				TooltipOffsetX = ScreenData.UpgradeChoice.TooltipOffsetX,
			},
			Data =
			{
				OnPressedFunctionName = "TradeOptionPressedPresentation",
			},

			ChildrenOrder =
			{
				"GiveInfoBoxIcon",
				"GiveInfoBoxFrame",
			},

			Children =
			{
				GiveInfoBoxIcon = 
				{
					Scale = 0.9,
					OffsetX = -332,
					OffsetY = -40,
					Alpha = 0.0,
				},

				GiveInfoBoxFrame = 
				{
					Animation = "Frame_Boon_Menu_Common",
					Scale = 0.6,
					OffsetX = -332,
					OffsetY = -40,
					Alpha = 0.0,
				},

				GiveInfoBoxName =
				{
					TextArgs =
					{
						OffsetX = -520,
						OffsetY = 80,
						FontSize = 27,						
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						LuaKey = "TooltipData",
						LuaValue = {},
					},
				},

				GiveInfoBoxSubText =
				{
					TextArgs =
					{
						OffsetX = -320,
						OffsetY = 265,
						Font = "P22UndergroundSCMedium",
						FontSize = 22,
						ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
						OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
						ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
						Justification = "Center",
						LuaKey = "TooltipData",
						LuaValue = {},
						TextSymbolScale = 0.8,
						DataProperties =
						{
							TextSymbolOffsetY = 3,
						},
					},
				},
				
				--[[
				GiveInfoBoxStatLineLeft =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineLeft,
				},
				
				GiveInfoBoxStatLineRight =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineRight,
				},

				GiveInfoBoxRarity =
				{
					TextArgs = ScreenData.UpgradeChoice.RarityText,
				},
				]]
			},
		},

		GetHintText = 
		{
			Text = "TradeScreen_GetHint",
			X = 1050,
			Y = 365,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				Color = Color.UpgradeGreen,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		GetInfoBoxBacking =
		{
			X = ScreenCenterX,
			Y = ScreenCenterY,
			-- Description
			TextArgs =
			{
				OffsetX = 90,
				OffsetY = 120,
				Width = 420,
				Justification = "Left",
				VerticalJustification = "Top",
				LineSpacingBottom = 5,
				LuaKey = "TooltipData",
				LuaValue = {},
				Format = "BaseFormat",
				UseDescription = true,
				VariableAutoFormat = "BoldFormatGraft",
				TextSymbolScale = 0.8,
			},
			InteractProperties =
			{
				TooltipOffsetX = ScreenData.UpgradeChoice.TooltipOffsetX,
			},
			Data =
			{
				OnPressedFunctionName = "TradeOptionPressedPresentation",
			},

			ChildrenOrder =
			{
				"GetInfoBoxIcon",
				"GetInfoBoxFrame",
			},

			Children =
			{
				GetInfoBoxIcon = 
				{
					Graphic = "BlankObstacle",
					Scale = 0.9,
					OffsetX = 333,
					OffsetY = -40,
					Alpha = 0.0,
				},

				GetInfoBoxFrame = 
				{
					Graphic = "BlankObstacle",
					Animation = "Frame_Boon_Menu_Common",
					Scale = 0.6,
					OffsetX = 0,
					OffsetY = 0,
					Alpha = 0.0,
				},

				GetInfoBoxName =
				{
					TextArgs =
					{
						OffsetX = 90,
						OffsetY = 80,
						FontSize = 27,						
						Font = "P22UndergroundSCMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
						Justification = "Left",
						LuaKey = "TooltipData",
						LuaValue = {},
					},
				},

				GetInfoBoxSubText =
				{
					TextArgs =
					{
						OffsetX = 280,
						OffsetY = 265,
						Font = "P22UndergroundSCMedium",
						FontSize = 22,
						ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
						OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
						ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
						Justification = "Center",
						LuaKey = "TooltipData",
						LuaValue = {},
						TextSymbolScale = 0.8,
						DataProperties =
						{
							TextSymbolOffsetY = 3,
						},
					},
				},
				
				--[[
				GetInfoBoxStatLineLeft =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineLeft,
				},
				
				GetInfoBoxStatLineRight =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineRight,
				},
				]]
			},
		},

		ActionBar =
		{
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"TraitTrayButton",
				"CloseButton",
				"AcceptButton",
			},

			Children =
			{
				TraitTrayButton = 
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "UpgradeChoiceScreenOpenTraitTray",
						ControlHotkeys = { "AdvancedTooltip", },
					},
					Text = "Menu_OpenTraitTray",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},

		AcceptButton =
		{
			Graphic = "ContextualActionButton",
			Animation = "TradeScreenAccept",
			X = 1190,
			Y = 950,
			Data =
			{
				OnMouseOverFunctionName = "MouseOverContextualAction",
				OnMouseOffFunctionName = "MouseOffContextualAction",
				OnPressedFunctionName = "TradeScreenAccept",
				Sound = "/SFX/Menu Sounds/GodBoonInteract",
				ControlHotkeys = { "Confirm", },
			},
			Text = "TradeScreen_Accept",
			TextArgs =
			{
				OffsetY = -3,
				OffsetX = -5,
				FontSize = 20,
				Width = 415,
				LineSpacingBottom = 0,
				Color = { 1.0, 1.0, 1.0, 1.0 },
				Font = "LatoBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "CENTER",
				VerticalJustification = "CENTER",
				TextSymbolScale = 0.8,
			},
		},

		CloseButton =
		{
			Graphic = "ContextualActionButton",
			Animation = "TradeScreenDecline",
			X = 735,
			Y = 950,
			Data =
			{
				OnMouseOverFunctionName = "MouseOverContextualAction",
				OnMouseOffFunctionName = "MouseOffContextualAction",
				OnPressedFunctionName = "TradeScreenDecline",
				Sound = "/SFX/Menu Sounds/IrisMenuBack",
				ControlHotkeys = { "Cancel", },
			},
			Text = "TradeScreen_Decline",
			TextArgs =
			{
				OffsetY = -3,
				OffsetX = -5,
				FontSize = 20,
				Width = 415,
				LineSpacingBottom = 0,
				Color = { 1.0, 1.0, 1.0, 1.0 },
				Font = "LatoBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "CENTER",
				VerticalJustification = "CENTER",
				TextSymbolScale = 0.8,
			},
		},
	},
}