ScreenData.WeaponUpgradeScreen =
{
	Components = {},

	OpenSound = "/SFX/Menu Sounds/MirrorMenuOpen",
	CloseSound = "/SFX/Menu Sounds/AspectMenuClose",

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
		Animation = "ActiveAspectLoop",
		Group = "Combat_Menu_Additive",
		Alpha = 0.0,
		Scale = 1.2,
		OffsetX = -504,
		OffsetY = -54,
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
			"StaffRaiseDeadAspect",
		},
		WeaponDagger =
		{
			"DaggerBackstabAspect",
			"DaggerBlockAspect",
			"DaggerHomingThrowAspect",
			"DaggerTripleAspect",
		},
		WeaponTorch = 
		{
			"TorchSpecialDurationAspect",
			"TorchDetonateAspect",
			"TorchSprintRecallAspect",
			"TorchAutofireAspect",
		},
		WeaponAxe = 
		{
			"AxeRecoveryAspect",
			"AxeArmCastAspect",
			"AxePerfectCriticalAspect",
			"AxeRallyAspect",
		},
		WeaponLob = 
		{
			"LobAmmoBoostAspect",
			"LobCloseAttackAspect",
			"LobImpulseAspect",
			"LobGunAspect"
		},
		WeaponSuit = 
		{
			"BaseSuitAspect",
			"SuitHexAspect",
			"SuitMarkCritAspect",
			"SuitComboAspect",
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
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.4,

			},

			InfoBoxFrame = 
			{
				Graphic = "BlankObstacle",
				Animation = "Frame_Boon_Menu_Common",
				Scale = ScreenData.UpgradeChoice.Frame.Scale,
				OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
				OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.4,
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
			AnimationName = "WeaponUpgradeIn",
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
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.4,
			Group = "Combat_Menu_Overlay",
		},

		StatsBox =
		{
			AnimationName = "GUI\\Screens\\WeaponUpgrade\\StatsBacking",
			X = 215,
			Y = 808,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.4,
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

-- Aspects Screen
GlobalVoiceLines.OpenedWeaponUpgradeMenuVoiceLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.45,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.75,
		Cooldowns =
		{
			{ Name = "MelinoeAnyQuipSpeech" },
		},

		{ Cue = "/VO/Melinoe_2541", Text = "The Aspects of the Nocturnal Arms..." },
		{ Cue = "/VO/Melinoe_0728", Text = "Descura.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponStaffSwing" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3428", Text = "Descura.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponStaffSwing" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3429", Text = "Descura.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponStaffSwing" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"StaffClearCastAspect",
						"StaffSelfHitAspect",
						"StaffRaiseDeadAspect"
					},
				},
			},
		},		
		{ Cue = "/VO/Melinoe_0730", Text = "Lim and Oros.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3430", Text = "Lim and Oros.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3431", Text = "Lim. Oros.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"DaggerBlockAspect",
						"DaggerHomingThrowAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_0736", Text = "Ygnium.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3432", Text = "Ygnium.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3433", Text = "Ygnium.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponTorch" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"TorchDetonateAspect",
						"TorchSprintRecallAspect",
						"TorchAutofireAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3032", Text = "Zorephet.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponAxe" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3434", Text = "Zorephet.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponAxe" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3435", Text = "Zorephet.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponAxe" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"AxeArmCastAspect",
						"AxePerfectCriticalAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_0734", Text = "Revaal.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponLob" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3436", Text = "Revaal.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponLob" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3437", Text = "Revaal.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponLob" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						"LobCloseAttackAspect",
						"LobImpulseAspect",
						"LobGunAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3617", Text = "Xinth.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponSuit" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3618", Text = "Xinth.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponSuit" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						-- "LobCloseAttackAspect",
						-- "LobImpulseAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3619", Text = "Xinth.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponSuit" },
				},
				{
					Path = { "GameState", "WeaponsUnlocked" },
					HasAll =
					{ 
						-- "LobCloseAttackAspect",
						-- "LobImpulseAspect",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_3416", Text = "I have returned." },
		{ Cue = "/VO/Melinoe_3417", Text = "Such intricate work..." },
		{ Cue = "/VO/Melinoe_3418", Text = "Still not even a scratch..." },
		-- single-weapon lines
		{ Cue = "/VO/Melinoe_3415", Text = "Show me what you can do.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3420", Text = "I'm honored as your bearer.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3422", Text = "Show me your past.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3423", Text = "Show me our future.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3425", Text = "In service to the realm.",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3426", Text = "Can hear me, can't you...?",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsNone = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		-- dual-weapon lines
		{ Cue = "/VO/Melinoe_3421", Text = "Who else shall wield you?",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3419", Text = "What secrets do you keep...?",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3424", Text = "Forged by the Fates...",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3427", Text = "What form suits you tonight?",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "WeaponName" },
					IsAny = { "WeaponDagger", "WeaponTorch" },
				},
			},
		},
	},
}

GlobalVoiceLines.AspectMaxedVoiceLines =
{
	RandomRemaining = true,
	PreLineWait = 0.35,
	UsePlayerSource = true,
	TriggerCooldowns = { "MelinoeMiscWeaponEquipSpeech" },

	{ Cue = "/VO/Melinoe_2619", Text = "My bond with this Aspect is complete." },
	{ Cue = "/VO/Melinoe_2620", Text = "Our bond is now complete." },
	{ Cue = "/VO/Melinoe_2621", Text = "We are inseparable now." },
}