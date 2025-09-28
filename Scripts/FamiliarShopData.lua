FamiliarShopItemData =
{
	-- FrogFamiliar / Frinos

	BaseFrogUpgrade = 
	{
		DebugOnly = true,
		FamiliarName = "FrogFamiliar",
	},

	FrogHealthBonus = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		Icon = "FamiliarShopIcon_FrogHealthBonus",
		ShowLastInGroup = "FrogHealthBonus",
		IncreaseTraitLevel = "HealthFamiliar",
	},

	FrogHealthBonus2 = 
	{
		InheritFrom = { "FrogHealthBonus" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogHealthBonus" },
			},
		},
	},

	FrogHealthBonus3 = 
	{
		InheritFrom = { "FrogHealthBonus" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogHealthBonus2" },
			},
		},
	},

	FrogUses = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		Icon = "FamiliarShopIcon_FrogUses",
		ShowLastInGroup = "FrogUses",
		IncreaseTraitLevel = "FamiliarFrogResourceBonus",
	},

	FrogUses2 = 
	{
		InheritFrom = { "FrogUses" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogUses" },
			},
		},
	},

	FrogUses3 = 
	{
		InheritFrom = { "FrogUses" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogUses2" },
			},
		},
	},

	FrogDamage =
	{
		InheritFrom = { "BaseFrogUpgrade" },
		Icon = "FamiliarShopIcon_FrogDamage",
		ShowLastInGroup = "FrogDamage",
		IncreaseTraitLevel = "FamiliarFrogDamage",
	},

	FrogDamage2 = 
	{
		InheritFrom = { "FrogDamage" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogDamage" },
			},
		},
	},

	FrogDamage3 = 
	{
		InheritFrom = { "FrogDamage" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogDamage2" },
			},
		},
	},

	-- CatFamiliar / Toula

	BaseCatUpgrade = 
	{
		DebugOnly = true,
		FamiliarName = "CatFamiliar",
	},

	CatLastStandHeal = 
	{
		InheritFrom = { "BaseCatUpgrade" },
		Icon = "FamiliarShopIcon_CatLastStandHeal",
		IncreaseTraitLevel = "LastStandFamiliar",
		ShowLastInGroup = "CatLastStandHeal",
	},

	CatLastStandHeal2 =
	{
		InheritFrom = { "CatLastStandHeal" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatLastStandHeal" },
			},
		},
	},

	CatLastStandHeal3 =
	{
		InheritFrom = { "CatLastStandHeal" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatLastStandHeal2" },
			},
		},
	},

	CatUses =
	{
		InheritFrom = { "BaseCatUpgrade" },
		Icon = "FamiliarShopIcon_CatUses",
		ShowLastInGroup = "CatUses",
		IncreaseTraitLevel = "FamiliarCatResourceBonus",
	},

	CatUses2 =
	{
		InheritFrom = { "CatUses" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatUses" },
			},
		},
	},

	CatUses3 =
	{
		InheritFrom = { "CatUses" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatUses2" },
			},
		},
	},

	CatAttack =
	{
		InheritFrom = { "BaseCatUpgrade" },
		Icon = "FamiliarShopIcon_CatAttack",
		ShowLastInGroup = "CatAttack",
		IncreaseTraitLevel = "FamiliarCatAttacks",
	},

	CatAttack2 = 
	{
		InheritFrom = { "CatAttack" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatAttack" },
			},
		},
	},

	CatAttack3 = 
	{
		InheritFrom = { "CatAttack" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatAttack2" },
			},
		},
	},

	-- RavenFamiliar / Raki

	BaseRavenUpgrade = 
	{
		DebugOnly = true,
		FamiliarName = "RavenFamiliar",
	},

	RavenCritChanceBonus =
	{
		InheritFrom = { "BaseRavenUpgrade" },
		Icon = "FamiliarShopIcon_RavenCritChanceBonus",
		ShowLastInGroup = "RavenCritChanceBonus",
		IncreaseTraitLevel = "CritFamiliar",
	},

	RavenCritChanceBonus2 = 
	{
		InheritFrom = { "RavenCritChanceBonus" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "RavenCritChanceBonus" },
			},
		},
	},

	RavenCritChanceBonus3 = 
	{
		InheritFrom = { "RavenCritChanceBonus" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "RavenCritChanceBonus2" },
			},
		},
	},

	RavenUses =
	{
		InheritFrom = { "BaseRavenUpgrade" },
		Icon = "FamiliarShopIcon_RavenUses",
		ShowLastInGroup = "RavenUses",
		IncreaseTraitLevel = "FamiliarRavenResourceBonus",
	},

	RavenUses2 =
	{
		InheritFrom = { "RavenUses" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "RavenUses" },
			},
		},
	},

	RavenUses3 =
	{
		InheritFrom = { "RavenUses" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "RavenUses2" },
			},
		},
	},

	RavenAttack =
	{
		InheritFrom = { "BaseRavenUpgrade" },
		Icon = "FamiliarShopIcon_RavenAttack",
		ShowLastInGroup = "RavenAttack",
		IncreaseTraitLevel = "FamiliarRavenAttackDuration",
	},

	RavenAttack2 = 
	{
		InheritFrom = { "RavenAttack" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "RavenAttack" },
			},
		},
	},

	RavenAttack3 = 
	{
		InheritFrom = { "RavenAttack" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "RavenAttack2" },
			},
		},
	},

	-- HoundFamiliar / Hecuba

	BaseHoundUpgrade = 
	{
		DebugOnly = true,
		FamiliarName = "HoundFamiliar",
	},

	HoundManaBonus = 
	{
		InheritFrom = { "BaseHoundUpgrade" },
		Icon = "FamiliarShopIcon_HoundManaBonus",
		ShowLastInGroup = "HoundManaBonus",
		IncreaseTraitLevel = "DigFamiliar",
	},

	HoundManaBonus2 = 
	{
		InheritFrom = { "HoundManaBonus" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "HoundManaBonus" },
			},
		},
	},

	HoundManaBonus3 = 
	{
		InheritFrom = { "HoundManaBonus" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "HoundManaBonus2" },
			},
		},
	},

	HoundUses =
	{
		InheritFrom = { "BaseHoundUpgrade" },
		Icon = "FamiliarShopIcon_HoundUses",
		ShowLastInGroup = "HoundUses",
		IncreaseTraitLevel = "FamiliarHoundResourceBonus",
	},

	HoundUses2 =
	{
		InheritFrom = { "HoundUses" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "HoundUses" },
			},
		},
	},

	HoundUses3 =
	{
		InheritFrom = { "HoundUses" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "HoundUses2" },
			},
		},
	},

	HoundAttack =
	{
		InheritFrom = { "BaseHoundUpgrade" },
		Icon = "FamiliarShopIcon_HoundAttack",
		ShowLastInGroup = "HoundAttack",
		IncreaseTraitLevel = "FamiliarHoundBarkDuration",
	},

	HoundAttack2 =
	{
		InheritFrom = { "HoundAttack" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "HoundAttack" },
			},
		},
	},

	HoundAttack3 =
	{
		InheritFrom = { "HoundAttack" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "HoundAttack2" },
			},
		},
	},

	-- PolecatFamiliar / Gale

	BasePolecatUpgrade = 
	{
		DebugOnly = true,
		FamiliarName = "PolecatFamiliar",
	},

	PolecatDodgeBonus = 
	{
		InheritFrom = { "BasePolecatUpgrade" },
		Icon = "FamiliarShopIcon_PolecatDodgeBonus",
		ShowLastInGroup = "PolecatDodgeBonus",
		IncreaseTraitLevel = "DodgeFamiliar",
	},

	PolecatDodgeBonus2 = 
	{
		InheritFrom = { "PolecatDodgeBonus" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "PolecatDodgeBonus" },
			},
		},
	},

	PolecatDodgeBonus3 = 
	{
		InheritFrom = { "PolecatDodgeBonus" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "PolecatDodgeBonus2" },
			},
		},
	},

	PolecatUses = 
	{
		InheritFrom = { "BasePolecatUpgrade" },
		Icon = "FamiliarShopIcon_PolecatUses",
		ShowLastInGroup = "PolecatUses",
		IncreaseTraitLevel = "FamiliarPolecatResourceBonus",
	},

	PolecatUses2 = 
	{
		InheritFrom = { "PolecatUses" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "PolecatUses" },
			},
		},
	},

	PolecatUses3 = 
	{
		InheritFrom = { "PolecatUses" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "PolecatUses2" },
			},
		},
	},

	PolecatDamage =
	{
		InheritFrom = { "BasePolecatUpgrade" },
		Icon = "FamiliarShopIcon_PolecatDamage",
		ShowLastInGroup = "PolecatDamage",
		IncreaseTraitLevel = "FamiliarPolecatDamage",
	},

	PolecatDamage2 = 
	{
		InheritFrom = { "PolecatDamage" },
		RarityLevel = 2,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "PolecatDamage" },
			},
		},
	},

	PolecatDamage3 = 
	{
		InheritFrom = { "PolecatDamage" },
		RarityLevel = 3,
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "PolecatDamage2" },
			},
		},
	},

}

ScreenData.FamiliarShop =
{
	BlockPause = true,

	CategoryStartX = 104,
	CategoryStartY = 126,
	CategorySpacingX = 94,

	CategoryIconScale = 0.40,
	CategoryIconOffsetX = 0,
	CategoryIconOffsetY = 1,

	ItemStartX = 495,
	ItemStartY = 300,
	ItemSpacingY = 110,
	IconOffsetX = -390,
	IconOffsetY = 0,
	IconScale = 0.5,
	ItemsPerPage = 5,
	ScrollOffset = 0,
	FreeFormSelectOffsetX = -450,

	FadeOutTime = 0.3,
	OnPurchasedFadeOutTime = 0.4,

	OpenSound = "/SFX/CrappyRewardPickup",

	ItemAvailableNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = Color.CostAffordableShop,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	},

	ItemPurchasedNameFormat =
	{
		OffsetX = -320,
		OffsetY = 0,
		FontSize = 22,
		Width = 720,
		Color = {0.5, 0.5, 0.5, 1.0},
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	},

	GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 4,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},

	ItemOrder =
	{
		"FrogHealthBonus",
		"FrogHealthBonus2",
		"FrogHealthBonus3",
		"FrogUses",
		"FrogUses2",
		"FrogUses3",
		"FrogDamage",
		"FrogDamage2",
		"FrogDamage3",
		--"FrogDeflect",

		"CatLastStandHeal",
		"CatLastStandHeal2",
		"CatLastStandHeal3",
		"CatUses",
		"CatUses2",
		"CatUses3",
		"CatAttack",
		"CatAttack2",
		"CatAttack3",
		--"CatCrit",

		"RavenCritChanceBonus",
		"RavenCritChanceBonus2",
		"RavenCritChanceBonus3",
		"RavenUses",
		"RavenUses2",
		"RavenUses3",
		"RavenAttack",
		"RavenAttack2",
		"RavenAttack3",

		"HoundManaBonus",
		"HoundManaBonus2",
		"HoundManaBonus3",
		"HoundUses",
		"HoundUses2",
		"HoundUses3",
		"HoundAttack",
		"HoundAttack2",
		"HoundAttack3",

		"PolecatDodgeBonus",
		"PolecatDodgeBonus2",
		"PolecatDodgeBonus3",
		"PolecatUses",
		"PolecatUses2",
		"PolecatUses3",
		"PolecatDamage",
		"PolecatDamage2",
		"PolecatDamage3",
	},

	Components = {},

	TooltipX = 1680,
	TooltipY = 1280,

	ItemAvailableAnimation = "GUI\\Screens\\CriticalItemShop\\Button",
	ItemAvailableHighlightAnimation = "GUI\\Screens\\CriticalItemShop\\Button_Highlight",
	ItemPurchasedAnimation = "GUI\\Screens\\CriticalItemShop\\Button",
	ItemPurchasedHighlightAnimation = "GUI\\Screens\\CriticalItemShop\\Button_Highlight",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,

		Order =
		{
			"BackgroundDim",
			"FamiliarShopBacking",
			"FamiliarShopAnimalBacking",
			"ActionBarBackground",
			"ResourceCostBacking",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			AnimationName = "WeaponShopVignette",
			ScaleX = 30.0,
			ScaleY = 30.0,
			X = ScreenCenterX + 300,
			Y = ScreenCenterY,
			UseNativeScreenCenter = true,
			Color = { 1.0, 1.0, 1.0, 0.8 },
		},

		FamiliarShopBacking =
		{
			AnimationName = "FamiliarShopBackdrop",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
		},

		FamiliarShopAnimalBacking =
		{
			X = ScreenCenterX + 540,
			Y = ScreenCenterY,
			Alpha = 0.0,
			AlphaTarget = 1.0,
			AlphaTargetDuration = 0.2,
		},

		TitleText = 
		{
			Text = "FamiliarShopScreen_Title",
			TextArgs =
			{
				FontSize = 36,
				OffsetX = 0, OffsetY = -465,
				Color = Color.White,

				Font = "P22UndergroundSCLightTitling",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 3},
				OutlineThickness = 3,
				Justification = "Center",
			},
		},

		HintText = 
		{
			Text = "FamiliarShopScreen_Hint",
			TextArgs =
			{
				FontSize = 19,
				OffsetX = 0, OffsetY = -410,
				Width = 840,
				Color = {120, 120, 120, 255},
				Font = "LatoSemiboldItalic",
				ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
				Justification = "Center",
			},
		},

		InfoBoxBacking =
		{
			Graphic = ScreenData.UpgradeChoice.PurchaseButton.Name,
			X = 970,
			Y = 862,
			UseNativeScreenX = true,
			Alpha = 0.0,
			UseableOff = true,
			InteractProperties =
			{
				FreeFormSelectable = false,
			},

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
				},

				InfoBoxFrame = 
				{
					Graphic = "BlankObstacle",
					Animation = "Frame_Boon_Menu_Common",
					Scale = ScreenData.UpgradeChoice.Frame.Scale,
					OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
					OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
					Alpha = 0.0,
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
				InfoBoxFlavor =
				{
					TextArgs = ScreenData.UpgradeChoice.FlavorText,
				},
			}
		},

		ActionBarBackground =
		{
			AnimationName = "GUI\\ActionBar",
			X = ScreenCenterX,
			Y = UIData.ActionBarY,
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
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						-- Dummy button
					},
					Text = "FamiliarShop_Select",
					TextArgs = UIData.ContextualButtonFormatLeft,
				},

				CloseButton =
				{
					Graphic = "ContextualActionButton",
					GroupName = "Combat_Menu_Overlay",
					Alpha = 0.0,
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = "CloseFamiliarShopScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
	},
}