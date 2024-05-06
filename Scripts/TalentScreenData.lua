ScreenData.TalentScreen = 
{
	TooltipOffsetXStart = ScreenWidth - 240,
	TooltipOffsetYStart = ScreenCenterY + 350,
	UnusableArrowAlpha = 0.2,
	Components = {},
	

	GamepadNavigation =
	{
		ExclusiveInteractGroup = "Combat_Menu_Overlay",
		--FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 32,
		FreeFormSelectSuccessDistanceStep = 32,
	},
	ComponentData =
	{
		UseNativeScreenCenter = true,
		
		DefaultGroup = "Combat_Menu_Overlay",
		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_UI_World_Backing",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "SpellScreenIn",
			GroupName = "Combat_Menu",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				TitleText = 
				{
					Text = "TalentScreenMenu_Title",
					TextArgs = {
						FontSize = 32,
						OffsetX = 0, OffsetY = -455,
						Color = Color.White,
						Font = "P22UndergroundSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
						OutlineThickness = 3,
						Justification = "Center",
					}
				},
				FlavorText = 
				{
					Text = "TalentDrop_FlavorText01",
					TextArgs = {
						FontSize = 20,
						OffsetY = -415, Width = 1040,
						Color = {0.698, 0.698, 0.698, 1.0},
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
						Justification = "Center" 
					}
				},
				AvailablePointsTitle = 
				{
					OffsetX = -670,
					OffsetY = 0,
					Alpha = 0,
					AnimationName = "Frame_Boon_Menu_Common",
					Children = 
					{
						TalentPointText = 
						{
							Alpha = 0,
							Text = "1",
							TextArgs = {
								FontSize = 64,
								Color = {0.698, 0.698, 0.698, 1.0},
								Font = "LatoBold",
								ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
								Justification = "Center" 
							}
						},
					}
				},
				SpellBacking = 
				{
					AnimationName = "BoonSlotBase",
					GroupName = "Combat_Menu_Overlay_Backing",
					OffsetX = 0,
					OffsetY = -290,
					Children = 
					{
						SpellIcon = 
						{
							Graphic = "BlankObstacle",
							Scale = ScreenData.UpgradeChoice.Icon.Scale,
							OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
							OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
						},
						SpellText = 
						{
							TextArgs = ScreenData.UpgradeChoice.TitleText,
						},
						SpellDescription = 
						{
							TextArgs = ScreenData.UpgradeChoice.DescriptionText,
						},
					}
				},
				TalentContainer = 
				{
					AnimationName = "BoonSlotBase",
					GroupName = "Combat_Menu_Overlay_Backing",
					OffsetX = 0,
					OffsetY = 350,
					Children = 
					{
						TitleBox = 
						{
							GroupName = "Combat_Menu_TraitTray",
							TextArgs = ScreenData.UpgradeChoice.TitleText,
						},
						DetailsBacking = 
						{
							TextArgs = ScreenData.UpgradeChoice.DescriptionText,
						},
						RarityBox = 
						{
							GroupName = "Combat_Menu_TraitTray_Backing",
							TextArgs = ScreenData.UpgradeChoice.RarityText,
						},
						TalentIcon = 
						{
							Graphic = "BlankObstacle",
							Scale = ScreenData.UpgradeChoice.Icon.Scale,
							OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
							OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
						},
					}
				},
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			BottomOffset = UIData.ActionBarBottomOffset,
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
			},

			Children =
			{
				SelectButton =
				{
					Graphic = "ContextualActionButton",
					X = UIData.ContextualButtonXRight - UIData.ContextualButtonSpacing - UIData.ContextualButtonSpacing,
					Y = UIData.ContextualButtonY,
					Alpha = 0.0,
					Data =
					{
						--Dummy Button
					},
					Text = " ",
					TextArgs = UIData.ContextualButtonFormatLeft,
				},

				CloseButton = 
				{
					Graphic = "ContextualActionButton",
					X = UIData.ContextualButtonXRight,
					Y = UIData.ContextualButtonY,
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "LeaveTalentTree",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},

		TalentHover = 
		{
			AnimationName = "TalentHighlight",
			GroupName = "Combat_Menu_TraitTray_Backing",
			X = 200,
			Y = 450,
			Scale = TalentTreeUIData.DefaultOverlayScale,
			Alpha = 0.0,
		},

		TalentPin = 
		{
			AnimationName = "TraitPinIn_NoHighlight",
			GroupName = "Combat_Menu_TraitTray_Backing",
			X = 200,
			Y = 450,
			Scale = 0.6,
			Alpha = 0
		},
	}
}