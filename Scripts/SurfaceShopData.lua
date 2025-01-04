SurfaceShopData = 
{
	DelayMin = 1,
	DelayMax = 5,
	ImpatienceMultiplier = 1.5, -- Total multiplier you pay of the base cost to get it delivered immediately.
	DelayPriceDiscount = 
	{
		[1] = 1.2,
		[2] = 1.1,
		[3] = 1.0,
		[4] = 0.9,
		[5] = 0.8,
		[6] = 0.7,
	}
}

-- Shrine of Hermes
ScreenData.SurfaceShop = 
{
	Components = {},

	OpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
	CloseSound = "/Leftovers/Menu Sounds/InfoPanelOutURSA",

	BlockPause = true,

	GamepadNavigation =
	{
		FreeFormSelectWrapY = true,
		FreeFormSelecSearchFromId = 0,
		FreeFormSelectStepDistance = 10,
	},

	ShopItemStartX = ScreenCenterX,
	ShopItemSpacerX = 820,
	ShopItemStartY = 300,
	ShopItemSpacerY = 240,

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			GroupName = "Combat_UI",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {0.15, 0.15, 0.15, 0.85}
		},

		ShopBackground = 
		{
			Children = 
			{
				ShopSubtitle = 
				{
					GroupName = "Combat_Menu_Overlay",
					Text = "Store_Hint",
					TextArgs =  
					{
						FontSize = 18, 
						OffsetX = 0, 
						OffsetY = 380, 
						Width = 840, 
						Color = Color.Gray, 
						Font = "LatoMedium", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset={0, 2}, 
						Justification = "Center" 
					}
				},

				ShopFlavor = 
				{
					GroupName = "Combat_Menu_Overlay",
					Text = "Store_Hint",
					TextArgs =  
					{
						FontSize = 22,
						OffsetY = -385, Width = 840,
						Color = {0.698, 0.702, 0.514, 1.0},
						Font = "LatoMedium",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
						Justification = "Center",
						Scale = 0,
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
			X = UIData.ContextualButtonXRight - 200,
			Y = UIData.ContextualButtonY,
			BottomOffset = UIData.ContextualButtonBottomOffset,
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
					GroupName = "Combat_Menu_Overlay",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_Buy",
					AltText = "Menu_Rush",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

				CloseButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					BottomOffset = UIData.ContextualButtonBottomOffset,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseSurfaceShopScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	}
}