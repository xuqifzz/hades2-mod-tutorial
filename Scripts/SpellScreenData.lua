TalentTreeUIData = 
{
	DefaultStartX = 400,
	DefaultStartY = 340,
	DefaultTalentXSpacer = 165,
	DefaultTalentYSpacer = 70,
	DefaultTalentScale= 0.3,
	DefaultOverlayScale= 0.5,
}

ScreenData.SpellScreen = 
{
	Components = {}, 
	FreezePlayerArgs = { DisableTray = false,},
	AllowAdvancedTooltip = false, -- Block the normal hotkey, works through TraitTrayButton

	StartX = ScreenCenterX,
	SpacerY = 240,
	StartY = 300,

	ComponentData =
	{
		UseNativeScreenCenter = true,

		DefaultGroup = "Combat_Menu",

		Order =
		{
			"BackgroundTint",
			"Background",
			"ActionBarBackground",
		},

		BackgroundTint = 
		{
			Graphic = "rectangle01",
			Scale = 10,
			X = ScreenCenterX,
			Y = ScreenCenterY,
		},

		Background = 
		{
			AnimationName = "SpellScreenIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Children = 
			{
				TitleText = 
				{
					Text = "SpellScreenMenu_Title",
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
					Text = "SpellScreen_FlavorText01",
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
				"TraitTrayButton",
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
						OnPressedFunctionName = "AcceptAndCloseSpellScreen",
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
					},
					Text = "Spell_Select",
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