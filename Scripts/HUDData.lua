TraitUI =
{
	RecentTraitSize = 5,
	StartX = 40,
	StartY = ScreenCenterY - 7,
	SpacerX = 0,
	OddSpacerX = 35,
	IconStartY = ScreenCenterY - 240,
	IconStartX = 27 + 64 - 40,
	SpacerY = 93.5,
	SpacerX = 128,
 	PipOffsetX = 12,
	PipOffsetY = 12,
	NEW_TRAIT_TOKEN = "NEW",
}

ConsumableUI =
{
	StartY = ScreenHeight - 20,
	SpacerY = 36,
	StartX = ScreenWidth - 30,
	SpacerX = 0,
	FloatingCountSpacerX = -120
}

AmmoUI =
{
	StartX = -20,
	StartY = 60,
	HideDelay = 3,
}

StaffUI =
{
	StartX = 658,
	--StartY = 980,
	BottomOffset = 85,
	HideDelay = 3,
}

DaggerUI =
{
	StartX = 658,
	--StartY = 980,
	BottomOffset = 85,
	HideDelay = 3,
}

AxeUI =
{
	StartX = 658,
	--StartY = 980,
	BottomOffset = 85,
	HideDelay = 3,
}

TorchUI =
{
	StartX = 750,
	BottomOffset = 100,
	
	HideDelay = 3,
}

MoneyUI =
{
	HideDelay = 2.2,
	FadeDuration = 0.4,
	DigitSpacer = -25,
	StartSpacer = -60
}

ScreenData.HUD =
{
	Components = {},

	ObjectiveStartX = 130,
	ObjectiveStartY = 150,
	ObjectiveSpacingY = 40,

	AmmoX = 630,
	--AmmoY = 980,
	AmmoBottomOffset = 100,

	FadeInDuration = 0.5,
	FadeOutDuration = 0.2,
	
	LastStandX = 610,
	LastStandBottomOffset = 36,
	LastStandSpacingX = 48,
	LastStandScale = 0.8,
	LastStandTextFormat = 
	{
		Font = "NumericP22UndergroundSCMedium", 
		FontSize = 22,
		Color = Color.White,
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
		OffsetX = 5, OffsetY = 9,
		Justification = "Center",
		DataProperties =
		{
			OpacityWithOwner = true,
		}
	},
	SlottedTraitComponents = {},
	--SlottedTraitStartX = 80,
	--SlottedTraitStartY = 200,

	ActiveTraitComponents = {},
	--ActiveTraitStartX = 80,
	ActiveTraitStartY = 900,
	ActiveTraitBottomOffset = 160,
	--ActiveTraitSpacingX = 100,

	ActiveTraitGroup = "Combat_Menu_TraitTray",

	GroupOrder =
	{
		{ Name = "Combat_UI_World_Backing" },
		{ Name = "Combat_UI_World" },
		{ Name = "Combat_UI_World_Add", BlendMode = "Additive" },
		{ Name = "Combat_UI_Backing" },
		{ Name = "Combat_UI" },
		{ Name = "Combat_Menu_Backing" },
		{ Name = "Portrait_FX_Behind" },
		{ Name = "Portrait_FX_Behind_Add", BlendMode = "Additive" },
		{ Name = "Combat_Menu" },
		{ Name = "Combat_Menu_Additive", BlendMode = "Additive" },
		{ Name = "Combat_Menu_Overlay_Backing" },
		{ Name = "Combat_Menu_Overlay" },
		{ Name = "Combat_Menu_Overlay_Additive", BlendMode = "Additive" },
		{ Name = "HUD_Backing" },
		{ Name = "HUD_Main" },
		{ Name = "HUD_Overlay" },
		{ Name = "Combat_UI_Additive", BlendMode = "Additive" },
		{ Name = "Combat_Menu_TraitTray_Backing" },
		{ Name = "Combat_Menu_TraitTray" },
		{ Name = "TraitTrayHover1" },
		{ Name = "TraitTrayHover2" },
		{ Name = "TraitTrayHover3" },
		{ Name = "TraitTrayHover4" },
		{ Name = "TraitTrayHover5" },
		{ Name = "TraitTrayHover6" },
		{ Name = "TraitTrayHover7" },
		{ Name = "TraitTrayHover8" },
		{ Name = "Combat_Menu_TraitTray_Additive", BlendMode = "Additive" },
		{ Name = "Combat_Menu_TraitTray_Labels" },
		{ Name = "Combat_Menu_TraitTray_Overlay" },
		{ Name = "Combat_Menu_TraitTray_Overlay_Text" },
		{ Name = "Combat_Menu_TraitTray_Overlay_Additive", BlendMode = "Additive" },
	},

	SlottedTraitOrder =
	{
		"Aspect",
		"Familiar",
		"Melee",
		"Secondary",
		"Ranged",
		"Rush",
		"Mana",
	},

	ActiveTraitOrder =
	{
		"Keepsake",
		"Spell",
		"Assist",
	},

	ComponentData =
	{
		DefaultGroup = "HUD_Main",

		Order =
		{
			"HealthBack",
			"HealthFalloff",
			"HealthFill",
			"HealthBuffer",
			"HealthHighIndicator",
			"HealthLowIndicator",
			"HealthFlash",

			"ManaMeterBack",
			"ManaMeterFill",
			"ManaMeterReserve",
			"ManaLowIndicator",

			"ResourceBackingShadow",
		},

		ResourceBackingShadow =
		{
			RightOffset = 113,
			BottomOffset = 229,
			Animation = "GUI\\HUD\\ResourceBackingShadow",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Data =
			{
				ShowAlpha = 0.5,
			},
		},

		TraitCount =
		{
			X = 40,
			Y = 40,
			Animation = "GUI\\Icons\\Boon",
			GroupName = "HUD_Overlay",
			Scale = 0.7,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			TextArgs =
			{
				Text = "HUD_TraitCount",
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 20,
				OffsetY = 0,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
			},
		},

		MetaUpgradeCount =
		{
			X = 120,
			Y = 40,
			Animation = "GUI\\Icons\\ManaCrystal",
			Scale = 0.7,
			GroupName = "HUD_Overlay",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			TextArgs =
			{
				Text = "HUD_MetaUpgradeCount",
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 20,
				OffsetY = 0,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
			},
		},
		
		ShrinePointCount =
		{
			X = 200,
			Y = 40,
			Animation = "GUI\\Icons\\ShrinePoint",
			Scale = 0.7,
			GroupName = "HUD_Overlay",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			TextArgs =
			{
				Text = "InGameUI_ActiveShrinePoints",
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 20,
				OffsetY = 0,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
			},
		},

		BountyActive =
		{
			X = 280,
			Y = 40,
			Animation = "GUI\\Icons\\BountyBoardEye",
			Scale = 0.7,
			GroupName = "HUD_Overlay",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			TextArgs =
			{
				Font = "P22UndergroundSCMedium",
				FontSize = 24,
				Justification = "Left",
				OffsetX = 20,
				OffsetY = 0,
				FadeOpacity = 0.0,
				FadeTarget = 0.0,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				DataProperties =
				{
					OpacityWithOwner = false,
				}
			},
		},

		BountyReadyConfirm =
		{
			X = 260,
			Y = 40,
			GroupName = "HUD_Overlay",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			TextArgs =
			{
				Text = "HUD_BountyReady",
				Font = "P22UndergroundSCMedium",
				FontSize = 28,
				Justification = "Left",
				OffsetX = 0,
				OffsetY = 0,
				Color = Color.Yellow,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = Color.Black, OutlineThickness = 4,
				ShadowAlpha = 1.0, ShadowBlur = 2, ShadowOffset = {0, 4},
			},
		},

		-- Slotted Trait Backings

		WeaponSlotIcon =
		{
			X = ScreenData.TraitTrayScreen.TraitStartX,
			BottomOffset = ScreenData.TraitTrayScreen.TraitStartBottomOffset - (ScreenData.TraitTrayScreen.TraitSpacingY * 0),
			GroupName = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup,
			Animation = "GUI\\HUD\\PrimaryBoons\\SlotIcon_Attack",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5, 
		},

		FamiliarSlotIcon =
		{
			X = ScreenData.TraitTrayScreen.TraitStartX,
			BottomOffset = ScreenData.TraitTrayScreen.TraitStartBottomOffset - (ScreenData.TraitTrayScreen.TraitSpacingY * 1),
			GroupName = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup,
			Animation = "GUI\\HUD\\PrimaryBoons\\SlotIcon_Wrath",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5, 
		},

		AttackSlotIcon =
		{
			X = ScreenData.TraitTrayScreen.TraitStartX,
			BottomOffset = ScreenData.TraitTrayScreen.TraitStartBottomOffset - (ScreenData.TraitTrayScreen.TraitSpacingY * 2),
			GroupName = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup,
			Animation = "GUI\\HUD\\PrimaryBoons\\SlotIcon_Attack",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5, 
		},

		SpecialSlotIcon =
		{
			X = ScreenData.TraitTrayScreen.TraitStartX,
			BottomOffset = ScreenData.TraitTrayScreen.TraitStartBottomOffset - (ScreenData.TraitTrayScreen.TraitSpacingY * 3),
			GroupName = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup,
			Animation = "GUI\\HUD\\PrimaryBoons\\SlotIcon_Secondary",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5, 
		},

		CastSlotIcon =
		{
			X = ScreenData.TraitTrayScreen.TraitStartX,
			BottomOffset = ScreenData.TraitTrayScreen.TraitStartBottomOffset - (ScreenData.TraitTrayScreen.TraitSpacingY * 4),
			GroupName = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup,
			Animation = "GUI\\HUD\\PrimaryBoons\\SlotIcon_Ranged",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5, 
		},

		DashSlotIcon =
		{
			X = ScreenData.TraitTrayScreen.TraitStartX,
			BottomOffset = ScreenData.TraitTrayScreen.TraitStartBottomOffset - (ScreenData.TraitTrayScreen.TraitSpacingY * 5),
			GroupName = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup,
			Animation = "GUI\\HUD\\PrimaryBoons\\SlotIcon_Dash",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5, 
		},

		ManaSlotIcon =
		{
			X = ScreenData.TraitTrayScreen.TraitStartX,
			BottomOffset = ScreenData.TraitTrayScreen.TraitStartBottomOffset - (ScreenData.TraitTrayScreen.TraitSpacingY * 6),
			GroupName = ScreenData.TraitTrayScreen.ComponentData.DefaultGroup,
			Animation = "GUI\\HUD\\PrimaryBoons\\SlotIcon_Wrath",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5, 
		},

		-- Health Meter

		HealthBack =
		{
			Animation = "HPManaBacking",
			X = 315,
			BottomOffset = 60,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5,
			TextArgs =
			{
				--Text = "UI_PlayerHealth",
				OffsetX = 0,
				OffsetY = 18,
				Font = "NumericP22UndergroundSCHeavy",
				FontSize = 28,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				Justification = "Center",
				DataProperties = 
				{
					OpacityWithOwner = true,
				},
			},
		},

		HealthFalloff = 
		{
			Animation = "HPBarFalloff",
			X = 325,
			BottomOffset = 39,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5,
			UpdateDelay = 0.4,
			UpdateDuration = 0.4,
			UpdateEaseIn = 0.66,
			UpdateEaseOut = 0.88,
		},

		HealthFill = 
		{
			Animation = "HPBarFill",
			X = 325,
			BottomOffset = 39,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5,
			UpdateDuration = 0.0,
			UpdateEaseIn = 0.0,
			UpdateEaseOut = 0.0,
		},

		HealthBuffer = 
		{
			Animation = "HPBarArmorFill",
			X = 325,
			BottomOffset = 39,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5,
			TextArgs =
			{
				--Text = "UI_HealthBuffer",
				OffsetX = 225,
				OffsetY = -4,
				Font = "NumericP22UndergroundSCHeavy",
				FontSize = 28,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				Justification = "Right",
				DataProperties = 
				{
					OpacityWithOwner = true,
				},
			},
		},

		HealthFlash = 
		{
			Graphic = "BlankObstacle",
			Animation = "HealthBarBlank",
			X = 36,
			BottomOffset = 45,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			--ScaleX = 2.0,
			--ScaleY = 1.5,
			Color = Color.Purple,
		},

		HealthHighIndicator = 
		{
			Graphic = "BlankObstacle",
			Animation = "HPBarIndicatorHigh",
			-- 80% hp
			X = 483,
			BottomOffset = 45,
			Alpha = 0.0,
			AlphaTarget = 0.0,
		},

		HealthLowIndicator = 
		{
			Graphic = "BlankObstacle",
			Animation = "HPBarIndicatorLow",
			-- 30% hp
			X = 217,
			BottomOffset = 45,
			Alpha = 0.0,
			AlphaTarget = 0.0,
		},

		-- Mana Meter

		ManaMeterBack =
		{
			Graphic = "BlankObstacle",
			Animation = null,
			X = 325,
			BottomOffset = 95,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			TextArgs =
			{
				--Text = "UI_PlayerHealth",
				OffsetX = -10,
				OffsetY = 9,
				Font = "NumericP22UndergroundSCHeavy",
				FontSize = 28,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				Justification = "Center",
				DataProperties = 
				{
					OpacityWithOwner = true,
				},
			},
		},

		ManaMeterFill = 
		{
			Graphic = "BlankObstacle",
			Animation = "ManaBarFill",
			X = 325,
			BottomOffset = 82,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5
		},

		ManaMeterReserve = 
		{
			Graphic = "BlankObstacle",
			Animation = "ManaBarReserveFill",
			X = 325,
			BottomOffset = 82,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			Scale = 0.5,
			TextArgs =
			{
				--Text = "UI_HealthBuffer",
				OffsetX = 200,
				OffsetY = -2,
				Font = "NumericP22UndergroundSCHeavy",
				FontSize = 28,
				Color = { 180, 168, 255, 255 },
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 2,
				ShadowAlpha = 1.0, ShadowBlur = 1, ShadowOffset = {0, 4},
				Justification = "Right",
				DataProperties = 
				{
					OpacityWithOwner = true,
				},
			},
		},
		
		ManaLowIndicator = 
		{
			Graphic = "BlankObstacle",
			Animation = "ManaBarIndicatorLow",
			LowManaThreshold = 10, -- absolute, not relative mana
			BarOffset = 2,
			Alpha = 0.0,
			AlphaTarget = 0.0,
		},
		MoneyIcon =
		{
			RightOffset = 40,
			BottomOffset = 24,
			Animation = "CurrencyIcon",
			Scale = 0.8,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			TextArgs =
			{
				OffsetX = -30,
				OffsetY = 0,
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 28,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
				ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
				Justification = "Right",
				DataProperties =
				{
					OpacityWithOwner = true,
				}
			},
		},

		RerollIcon =
		{
			RightOffset = 40,
			BottomOffset = 70,
			Animation = "RerollIcon",
			Scale = 0.9,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			TextArgs =
			{
				OffsetX = -30,
				OffsetY = 0,
				Font = "NumericP22UndergroundSCMedium",
				FontSize = 28,
				ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
				OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 3,
				ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
				Justification = "Right",
				DataProperties =
				{
					OpacityWithOwner = true,
				}
			},
		},

		InventoryIcon =
		{
			RightOffset = 60,
			BottomOffset = 120,
			Animation = "GUI\\Screens\\Inventory\\Icon-Inventory",
			Alpha = 0.0,
			AlphaTarget = 0.0,
		},

		ToolIcon =
		{
			RightOffset = 60,
			BottomOffset = 200,
		},

		FamiliarIcon =
		{
			RightOffset = 60,
			BottomOffset = 280,
			TextArgs =
			{
				Font = "NumericP22UndergroundSCMedium", 
				FontSize = 22,
				Color = Color.White,
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={1, 2},
				OffsetX = 5, OffsetY = 40,
				Justification = "Center",
				DataProperties =
				{
					OpacityWithOwner = true,
				}
			},
		},

		Letterbox =
		{
			UseNativeScreenCenter = true,
			GroupName = "HUD_Backing",
			Animation = "GUI\\Graybox\\NativeAspectRatioFrame",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AlphaTargetDuration = 0.2,
			Requirements =
			{
				{
					PathTrue = { "ScreenState", "NeedsLetterbox" },
				}
			},
		},

		PillarboxLeft =
		{
			PillarboxLeft = true,
			Y = ScreenCenterY,
			GroupName = "HUD_Backing",
			Animation = "GUI\\SideBars_01",
			FlipHorizontal = true,
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AlphaTargetDuration = 0.2,
			Requirements =
			{
				{
					PathTrue = { "ScreenState", "NeedsPillarbox" },
				}
			},
		},

		PillarboxRight =
		{
			PillarboxRight = true,
			Y = ScreenCenterY,
			GroupName = "HUD_Backing",
			Animation = "GUI\\SideBars_01",
			Alpha = 0.0,
			AlphaTarget = 0.0,
			AlphaTargetDuration = 0.2,
			Requirements =
			{
				{
					PathTrue = { "ScreenState", "NeedsPillarbox" },
				}
			},
		},
	},
}