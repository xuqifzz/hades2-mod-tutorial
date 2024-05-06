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
		IncreaseTraitLevel = "HealthFamiliar",
		ShowLastInGroup = "FrogHealthBonus",
	},

	FrogHealthBonus2 = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		IncreaseTraitLevel = "HealthFamiliar",
		RarityLevel = 2,
		ShowLastInGroup = "FrogHealthBonus",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogHealthBonus" },
			},
		},
	},

	FrogHealthBonus3 = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		IncreaseTraitLevel = "HealthFamiliar",
		RarityLevel = 3,
		ShowLastInGroup = "FrogHealthBonus",
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
		BonusUses = 1,
		ShowLastInGroup = "FrogUses",
	},

	FrogUses2 = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		RarityLevel = 2,
		ShowLastInGroup = "FrogUses",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogUses" },
			},
		},
		BonusUses = 1,
	},

	FrogUses3 = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		RarityLevel = 3,
		ShowLastInGroup = "FrogUses",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogUses2" },
			},
		},
		BonusUses = 1,
	},

	FrogDamage =
	{
		InheritFrom = { "BaseFrogUpgrade" },
		TraitName = "FamiliarFrogDamage",
		ShowLastInGroup = "FrogDamage",
	},

	FrogDamage2 = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		IncreaseTraitLevel = "FamiliarFrogDamage",
		RarityLevel = 2,
		ShowLastInGroup = "FrogDamage",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogDamage" },
			},
		},
	},

	FrogDamage3 = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		IncreaseTraitLevel = "FamiliarFrogDamage",
		RarityLevel = 3,
		ShowLastInGroup = "FrogDamage",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogDamage2" },
			},
		},
	},

	--[[
	FrogDeflect = 
	{
		InheritFrom = { "BaseFrogUpgrade" },
		TraitName = "FamiliarFrogDeflect",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogHealthBonus3" },
			},
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogUses3" },
			},
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "FrogDamage3" },
			},
		},
	},
	]]

	-- CatFamiliar / Toula

	BaseCatUpgrade = 
	{
		DebugOnly = true,
		FamiliarName = "CatFamiliar",
	},

	CatLastStandHeal = 
	{
		InheritFrom = { "BaseCatUpgrade" },
		IncreaseTraitLevel = "LastStandFamiliar",
		ShowLastInGroup = "CatLastStandHeal",
	},

	CatLastStandHeal2 =
	{
		InheritFrom = { "BaseCatUpgrade" },
		IncreaseTraitLevel = "LastStandFamiliar",
		RarityLevel = 2,
		ShowLastInGroup = "CatLastStandHeal",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatLastStandHeal" },
			},
		},
	},

	CatLastStandHeal3 =
	{
		InheritFrom = { "BaseCatUpgrade" },
		IncreaseTraitLevel = "LastStandFamiliar",
		RarityLevel = 3,
		ShowLastInGroup = "CatLastStandHeal",
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
		BonusUses = 1,
		ShowLastInGroup = "CatUses",
	},

	CatUses2 =
	{
		InheritFrom = { "BaseCatUpgrade" },
		RarityLevel = 2,
		ShowLastInGroup = "CatUses",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatUses" },
			},
		},
		BonusUses = 1,
	},

	CatUses3 =
	{
		InheritFrom = { "BaseCatUpgrade" },
		RarityLevel = 3,
		ShowLastInGroup = "CatUses",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatUses2" },
			},
		},
		BonusUses = 1,
	},

	CatAttack =
	{
		InheritFrom = { "BaseCatUpgrade" },
		--TraitName = "FamiliarFrogDamage",
		ShowLastInGroup = "CatAttack",
		OverwriteSelf =
		{
			NumAttacks = 2,
		},
	},

	CatAttack2 = 
	{
		InheritFrom = { "BaseCatUpgrade" },
		--IncreaseTraitLevel = "FamiliarFrogDamage",
		RarityLevel = 2,
		ShowLastInGroup = "CatAttack",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatAttack" },
			},
		},
		OverwriteSelf =
		{
			NumAttacks = 3,
		},
	},

	CatAttack3 = 
	{
		InheritFrom = { "BaseCatUpgrade" },
		--IncreaseTraitLevel = "FamiliarFrogDamage",
		RarityLevel = 3,
		ShowLastInGroup = "CatAttack",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatAttack2" },
			},
		},
		OverwriteSelf =
		{
			NumAttacks = 4,
		},
	},

	--[[
	CatCrit = 
	{
		InheritFrom = { "BaseCatUpgrade" },
		TraitName = "FamiliarCatCrit",
		GameStateRequirements = 
		{
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatLastStandHeal3" },
			},
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatUses3" },
			},
			{
				PathTrue = { "GameState", "FamiliarUpgrades", "CatAttack3" },
			},
		},
	},
	]]
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
		FreeFormSelectSuccessDistanceStep = 8,
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
	},

	Components = {},

	SaleData = {},
	NumSales = 0,
	NumItemsOffered = 0,

	TooltipX = 1680,
	TooltipY = 1280,

	ItemAvailableAnimation = "GUI\\Screens\\CriticalItemShop\\Button",
	ItemAvailableHighlightAnimation = "GUI\\Screens\\CriticalItemShop\\Button_Highlight",
	ItemPurchasedAnimation = "GUI\\Screens\\CriticalItemShop\\Button",
	ItemPurchasedHighlightAnimation = "GUI\\Screens\\CriticalItemShop\\Button_Highlight",

	ComponentData =
	{
		DefaultGroup = "Combat_Menu",

		Order =
		{
			"BackgroundDim",
			"ListBackground",
			"ResourceCostBacking",
		},

		BackgroundDim = 
		{
			Graphic = "rectangle01",
			AnimationName = "WeaponShopVignette",
			GroupName = "Combat_Menu_Backing",
			ScaleX = 10.0,
			ScaleY = 20.0,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			UseNativeScreenCenter = true,
			Color = { 1.0, 1.0, 1.0, 0.8 },
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
					TextArgs = ScreenData.UpgradeChoice.FlavorText,
				},
			}
		},

		--[[
		ScrollUp =
		{
			Graphic = "ButtonCodexUp",
			X = 30,
			Y = 210,
			Alpha = 0.0,
			Scale = 0.85,
			Data =
			{
				OnPressedFunctionName = "WeaponShopScrollUp",
				ControlHotkey = "MenuUp",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},

		ScrollDown =
		{
			Graphic = "ButtonCodexDown",
			X = 30,
			Y = 692,
			Alpha = 0.0,
			Scale = 0.85,
			Data =
			{
				OnPressedFunctionName = "WeaponShopScrollDown",
				ControlHotkey = "MenuDown",
				Sound = "/SFX/Menu Sounds/GeneralWhooshMENU",
			},
		},
		]]

		SelectButton =
		{
			Graphic = "ContextualActionButton",
			GroupName = "Combat_Menu_Overlay",
			X = UIData.ContextualButtonXRight - UIData.ContextualButtonSpacing - 100,
			Y = UIData.ContextualButtonY,
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
			X = UIData.ContextualButtonXRight,
			BottomOffset = UIData.ContextualButtonBottomOffset,
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
}