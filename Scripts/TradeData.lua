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
		DefaultGroup = "Combat_Menu",
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

		--[[
		Background = 
		{
			Graphic = "SpellScreenBackground",
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},
		]]

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
			X = 480,
			Y = 260,
			TextArgs =
			{
				FontSize = 24,
				OffsetX = 0, OffsetY = 0,
				-- Color = Color.PenaltyRed,
				Font = "P22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				Justification = "Left",
			},
		},

		GiveInfoBoxBacking =
		{
			Graphic = ScreenData.UpgradeChoice.PurchaseButton.Name,
			X = ScreenCenterX,
			Y = 400,
			TextArgs = ScreenData.UpgradeChoice.DescriptionText,
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
					Graphic = "BlankObstacle",
					Scale = ScreenData.UpgradeChoice.Icon.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
				},

				GiveInfoBoxFrame = 
				{
					Graphic = "BlankObstacle",
					Animation = "Frame_Boon_Menu_Common",
					Scale = ScreenData.UpgradeChoice.Frame.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
				},

				GiveInfoBoxName =
				{
					TextArgs = ScreenData.UpgradeChoice.TitleText,
				},
				
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
			},
		},

		GetHintText = 
		{
			Text = "TradeScreen_GetHint",
			X = 480,
			Y = 610,
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
			Graphic = ScreenData.UpgradeChoice.PurchaseButton.Name,
			X = ScreenCenterX,
			Y = 750,
			TextArgs = ScreenData.UpgradeChoice.DescriptionText,
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
					Scale = ScreenData.UpgradeChoice.Icon.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
				},

				GetInfoBoxFrame = 
				{
					Graphic = "BlankObstacle",
					Animation = "Frame_Boon_Menu_Common",
					Scale = ScreenData.UpgradeChoice.Frame.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
				},

				GetInfoBoxName =
				{
					TextArgs = ScreenData.UpgradeChoice.TitleText,
				},
				
				GetInfoBoxStatLineLeft =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineLeft,
				},
				
				GetInfoBoxStatLineRight =
				{ 
					TextArgs = ScreenData.UpgradeChoice.StatLineRight,
				},
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

				AcceptButton =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "TradeScreenAccept",
						Sound = "/SFX/Menu Sounds/GodBoonInteract",
						ControlHotkeys = { "Confirm", },
					},
					Text = "TradeScreen_Accept",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "TradeScreenDecline",
						Sound = "/SFX/Menu Sounds/GodBoonMenuClose",
						ControlHotkeys = { "Cancel", },
					},
					Text = "TradeScreen_Decline",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}