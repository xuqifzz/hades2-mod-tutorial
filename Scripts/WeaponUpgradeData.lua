ScreenData.WeaponUpgradeScreen =
{
	Components = {},

	OpenSound = "/SFX/Menu Sounds/MirrorMenuOpen",
	CloseSound = "/SFX/Menu Sounds/MirrorCloseNoUpgrade",

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ItemStartX = 970,
	ItemStartY = 185,
	ItemSpacingY = 230,
	IconOffsetX = -320,
	IconOffsetY = 0,

	EquippedIcon =
	{
		Name = "BlankObstacle",
		Animation = "GUI\\Screens\\WeaponUpgrade\\Select",
		Group = "Combat_Menu",
		Alpha = 0.0,
		Scale = 1.0,
		OffsetX = -500,
		OffsetY = -55,
	},
	
	TooltipOffsetX = 710,

	ItemNameText =
	{
		TextArgs = ScreenData.UpgradeChoice.TitleText,
	},
	FreeUnlocks =
	{
		WeaponStaffSwing = "BaseStaffAspect",
		WeaponDagger = "DaggerBackstabAspect",
		WeaponTorch = "TorchSpecialDurationAspect",
		WeaponAxe = "AxeRecoveryAspect",
		WeaponLob = "LobAmmoBoostAspect",
		WeaponSuit = "BaseSuitAspect",
	},

	DisplayOrder =
	{
		WeaponStaffSwing =
		{
			"BaseStaffAspect",
			"StaffClearCastAspect",
			"StaffSelfHitAspect",
		},
		WeaponDagger =
		{
			"DaggerBackstabAspect",
			"DaggerBlockAspect",
			"DaggerHomingThrowAspect",
		},
		WeaponTorch = 
		{
			"TorchSpecialDurationAspect",
			"TorchDetonateAspect",
			"TorchSprintRecallAspect",
		},
		WeaponAxe = 
		{
			"AxeRecoveryAspect",
			"AxeArmCastAspect",
			"AxePerfectCriticalAspect"
		},
		WeaponLob = 
		{
			"LobAmmoBoostAspect",
			"LobCloseAttackAspect",
			"LobImpulseAspect",
		},
		WeaponSuit = 
		{
			"BaseSuitAspect",
			"SuitHexAspect",
			"SuitMarkCritAspect",
		}
	},

	DefaultGroup = "Combat_Menu",

	Highlight =
	{
		Name = "BlankObstacle",
		Group = "Combat_Menu",
	},

	ButtonSlotData = 
	{
		Graphic = ScreenData.UpgradeChoice.PurchaseButton.Name,
		GroupName = "Combat_Menu",

		ChildrenOrder =
		{
			"InfoBoxIcon",
			"InfoBoxFrame",
		},

		Children =
		{
			InfoBoxIcon = 
			{
				Graphic = "BlankObstacle",
				Scale = ScreenData.UpgradeChoice.Icon.Scale,
				OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
				OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
			},

			InfoBoxFrame = 
			{
				Graphic = "BlankObstacle",
				Animation = "Frame_Boon_Menu_Common",
				Scale = ScreenData.UpgradeChoice.Frame.Scale,
				OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
				OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
			},

			InfoBoxName =
			{
				TextArgs = ScreenData.UpgradeChoice.TitleText,
			},
			InfoBoxRarity =
			{
				TextArgs = ScreenData.UpgradeChoice.RarityText,
			},

			InfoBoxDescription =
			{ 
				TextArgs = ScreenData.UpgradeChoice.DescriptionText,
			},
			InfoBoxStatLineLeft =
			{ 
				TextArgs = ScreenData.UpgradeChoice.StatLineLeft,
			},
			InfoBoxStatLineRight =
			{ 
				TextArgs = ScreenData.UpgradeChoice.StatLineRight,
			},
			InfoBoxFlavor =
			{
				TextArgs = ScreenData.UpgradeChoice.FlavorText
			},
		}
	},

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"Background",
			"ActionBarBackground",
			"WeaponImage",
			"StatsBox",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			ScaleX = 10.0,
			ScaleY = 20.0,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {0.090, 0.055, 0.157, 0.6},
		},

		Background = 
		{
			AnimationName = "GUI\\Screens\\WeaponUpgrade\\Background",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Alpha = 1,
			Children = 
			{
				TitleText = 
				{
					TextArgs =
					{
						Font = "P22UndergroundSCMedium",
						FontSize = 25,
						OffsetX = -747,
						OffsetY = 120,
						Justification = "Center",
						Color = Color.White,
						ShadowBlur = 0,
						ShadowColor = {0,0,0,1},
						ShadowOffset={0, 2},
					},
				},

				TitleFlavorText =
				{
					TextArgs =
					{
						UseDescription = true,
						Font = "LatoItalic",
						FontSize = 17,
						Width = 620,
						OffsetX = -747,
						OffsetY = 152,
						Justification = "Center",
						Color = {1, 1, 1, 0.6},						
						ShadowBlur = 0,
						ShadowColor = {0,0,0,0},
						ShadowOffset={0, 2},
					},
				},
			},
		},

		WeaponImage =
		{
			Graphic = "BlankObstacle3D",
			X = 200,
			Y = 500,
			Scale = 2.5,
		},

		StatsBox =
		{
			AnimationName = "GUI\\Screens\\WeaponUpgrade\\StatsBacking",
			ScaleX = 0.9,
			ScaleY = 0.96,
			X = 215,
			Y = 808,
		},

		KillsLabel =		
		{
			X = 44,
			Y = 775,
			Text = "WeaponUpgradeScreen_Kills",
			TextArgs =
			{
				Font = "LatoMedium",
				FontSize = 17,
				Color = {241,241,241,255},
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Left",
			},
		},
		KillsValue =
		{
			X = 380,
			Y = 775,
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 21,
				Font = "NumericP22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},

		ClearsLabel =
		{
			X = 44,
			Y = 805,
			Text = "WeaponUpgradeScreen_Clears",
			TextArgs =
			{
				Font = "LatoMedium",
				FontSize = 17,
				Color = {241,241,241,255},
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Left",
			},
		},
		ClearsValue =
		{
			X = 380,
			Y = 805,
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 21,
				Font = "NumericP22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},

		UnderworldClearTimeRecordLabel =
		{
			X = 44,
			Y = 845,
			Text = "WeaponUpgradeScreen_ClearTimeRecord_Underworld",
			TextArgs =
			{
				Font = "LatoMedium",
				FontSize = 17,
				Color = {241,241,241,255},
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Left",
				TextSymbolScale = 0.8,
			},
		},
		UnderworldClearTimeRecordValue =
		{
			X = 380,
			Y = 845,
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 21,
				Font = "NumericP22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},

		UnderworldShrinePointRecordLabel =
		{
			X = 44,
			Y = 875,
			Text = "WeaponUpgradeScreen_ShrinePointRecord_Underworld",
			TextArgs =
			{
				Font = "LatoMedium",
				FontSize = 17,
				Color = {241,241,241,255},
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Left",
				TextSymbolScale = 0.8,
			},
		},
		UnderworldShrinePointRecordValue =
		{
			X = 380,
			Y = 875,
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 21,
				Font = "NumericP22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},

		SurfaceClearTimeRecordLabel =
		{
			X = 44,
			Y = 915,
			Text = "WeaponUpgradeScreen_ClearTimeRecord_Surface",
			TextArgs =
			{
				Font = "LatoMedium",
				FontSize = 17,
				Color = {241,241,241,255},
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Left",
				TextSymbolScale = 0.8,
			},
		},
		SurfaceClearTimeRecordValue =
		{
			X = 380,
			Y = 915,
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 21,
				Font = "NumericP22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
			},
		},

		SurfaceShrinePointRecordLabel =
		{
			X = 44,
			Y = 945,
			Text = "WeaponUpgradeScreen_ShrinePointRecord_Surface",
			TextArgs =
			{
				Font = "LatoMedium",
				FontSize = 17,
				Color = {241,241,241,255},
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Left",
				TextSymbolScale = 0.8,
			},
		},
		SurfaceShrinePointRecordValue =
		{
			X = 380,
			Y = 945,
			TextArgs =
			{
				Color = {1.000, 0.910, 0.510, 1.0},
				FontSize = 21,
				Font = "NumericP22UndergroundSCMedium",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				OutlineThickness = 2, OutlineColor = {0,0,0,1},
				Justification = "Right",
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
					
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "Menu_ChangeAspect",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
				
				CloseButton =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseWeaponUpgradeScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}