SurfaceShopData = 
{
	DelayMin = 2,
	DelayMax = 8,
	ImpatienceMultiplier = 1.5, -- Total multiplier you pay of the base cost to get it delivered immediately.
	DelayPriceDiscount = 
	{
		[1] = 1.3,
		[2] = 1.2,
		[3] = 1.1,
		[4] = 1.0,
		[5] = 0.9,
		[6] = 0.8,
		[7] = 0.7,
		[8] = 0.6,
	}
}

-- Shrine of Hermes
ScreenData.SurfaceShop = 
{
	Components = {},

	OpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
	CloseSound = "/Leftovers/Menu Sounds/InfoPanelOutURSA",

	FreezePlayerArgs =
	{
		DisableTray = false,
	},
	TraitTrayArgs =
	{
		IgnoreHideMoney = true,
	},
	BlockPause = true,
	AllowAdvancedTooltip = false, -- Block the normal hotkey, works through TraitTrayButton
	CloseAnimationName = "SurfaceShopOut",

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

	IconBackingOffsetX = -5,
	IconBackingOffsetY = 15,

	ComponentData =
	{
		DefaultGroup = "Combat_Menu_Overlay",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundTint",
			"ShopBackground",
			"ActionBarBackground",
		},

		BackgroundTint =
		{
			Graphic = "rectangle01",
			GroupName = "Combat_Menu_Backing",
			Scale = 4.0,
			UseScreenScaleX = true,
			UseScreenScaleY = true,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {0.15, 0.15, 0.15, 0.85}
		},

		ShopBackground = 
		{
			AnimationName = "SurfaceShopIn",
			GroupName = "Combat_Menu_Backing", 
			OffsetX = 0, 
			OffsetY = 190,
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
						Color = { 172, 172, 172, 255 }, 
						Font = "LatoMedium", 
						ShadowBlur = 0, 
						ShadowColor = {0,0,0,1}, 
						ShadowOffset={0, 2}, 
						Justification = "Center" 
					}
				},
			},
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
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
				"TraitTrayButton",
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
	}
}