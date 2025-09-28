ScreenData.SpellScreen = 
{
	Components = {}, 
	FreezePlayerArgs = { DisableTray = false,},
	AllowAdvancedTooltip = false, -- Block the normal hotkey, works through TraitTrayButton
	BlockPause = true,
	BlockExitsReady = true,

	StartX = ScreenCenterX,
	SpacerY = 240,
	StartY = 300,

	ComponentData =
	{
		UseNativeScreenCenter = true,

		DefaultGroup = "Combat_Menu",

		Order =
		{
			"BackgroundDim",
			"MoonBackground",
			"Background",
			"ActionBarBackground",
		},
		BackgroundDim = 
		{
			Graphic = "rectangle01",
			Scale = 10.0,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = Color.Black,
			Alpha = 0.0,
			AlphaTarget = 0.34,
			AlphaTargetDuration = 0.3,
		},

		Background = 
		{
			AnimationName = "SpellScreenIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				SpellTopGradient = 
				{
					AnimationName = "SpellScreenTopGradient",
					X = ScreenCenterX,
					Y = ScreenCenterY,
				},
				TitleText = 
				{
					Text = "SpellScreenMenu_Title",
					TextArgs =
					{
						FontSize = 32,
						OffsetX = 0, OffsetY = -455,
						Color = Color.White,
						Font = "P22UndergroundSCLightTitling",
						ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
						OutlineThickness = 3,
						Justification = "Center",
					},
				},
				FlavorText = 
				{
					TextArgs =
					{
						FontSize = 19,
						OffsetX = 0, OffsetY = -415,
						Width = 840,
						Color = {120, 120, 120, 255},
						Font = "LatoItalic",
						ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 2},
						Justification = "Center",
					},
				},
			}
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
		},

		ActionBarLeft =
		{
			X = UIData.ContextualButtonXLeft,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Left",

			ChildrenOrder =
			{
				"TraitTrayButton",
				"BoonListButton",
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
					TextArgs = UIData.ContextualButtonFormatLeft,
				},

				BoonListButton =
				{
					Requirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeBoonList" },
						}
					},
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "AttemptOpenUpgradeChoiceBoonInfo",
						ControlHotkeys = { "MenuInfo", },
					},
					Text = "Menu_TraitList",
					TextArgs = UIData.ContextualButtonFormatLeft,
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
				"SelectButton",
			},

			Children =
			{
				SelectButton =
				{
					Graphic = "ContextualActionButton",
					Alpha = 1.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
					},
					Text = "Spell_Select",
					TextArgs = UIData.ContextualButtonFormatRight,
				},

			},
		},
	}	
}