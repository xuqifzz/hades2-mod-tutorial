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
						OffsetY = 131,
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
						OffsetY = 167,
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
			Y = 797,
		},

		KillsLabel =		
		{
			X = 44,
			Y = 800,
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
			Y = 800,
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
			Y = 840,
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
			Y = 840,
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

		ClearTimeRecordLabel =
		{
			X = 44,
			Y = 880,
			Text = "WeaponUpgradeScreen_ClearTimeRecord",
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
		ClearTimeRecordValue =
		{
			X = 380,
			Y = 880,
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

		ShrinePointRecordLabel =
		{
			X = 44,
			Y = 920,
			Text = "WeaponUpgradeScreen_ShrinePointRecord",
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
		ShrinePointRecordValue =
		{
			X = 380,
			Y = 920,
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
			Y = 984,
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