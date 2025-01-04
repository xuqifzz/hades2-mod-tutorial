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
		BonusResourceSpawnChance = 0.03,
		ShowLastInGroup = "FrogUses",
		SimpleExtractValues =
		{
			{
				Property = "BonusResourceSpawnChance",
				Multiply = 100 / 0.12, -- Temp divide by BaseResourceSpawnChance 
				NewProperty = "BonusResourceSpawnChancePercent",
			},
		},
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
		TraitName = "FamiliarFrogDamage",
	},

	FrogDamage2 = 
	{
		InheritFrom = { "FrogDamage" },
		TraitName = nil,
		IncreaseTraitLevel = "FamiliarFrogDamage",
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
		TraitName = nil,
		IncreaseTraitLevel = "FamiliarFrogDamage",
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
		BonusResourceSpawnChance = 0.025,
		ShowLastInGroup = "CatUses",
		SimpleExtractValues =
		{
			{
				Property = "BonusResourceSpawnChance",
				Multiply = 100 / 0.1, -- Temp divide by BaseResourceSpawnChance 
				NewProperty = "BonusResourceSpawnChancePercent",
			},
		},
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
		OverwriteSelf =
		{
			NumAttacks = 2,
		},
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
		OverwriteSelf =
		{
			NumAttacks = 3,
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
		OverwriteSelf =
		{
			NumAttacks = 4,
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
		Icon = "FamiliarIcon_Raven",
		ShowLastInGroup = "RavenCritChanceBonus",
		IncreaseTraitLevel = "CritFamiliar",
		BonusChance = 0.01, -- Temp hardcoding, should match CritFamiliar AbsoluteStackValues
		SimpleExtractValues =
		{
			{
				Property = "BonusChance",
				Multiply = 100, 
				NewProperty = "BonusCritChancePercent",
			},
		},
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
		Icon = "FamiliarIcon_Raven",
		BonusResourceSpawnChance = 0.025,
		ShowLastInGroup = "RavenUses",
		SimpleExtractValues =
		{
			{
				Property = "BonusResourceSpawnChance",
				Multiply = 100 / 0.1, -- Temp divide by BaseResourceSpawnChance 
				NewProperty = "BonusResourceSpawnChancePercent",
			},
		},
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
		Icon = "FamiliarIcon_Raven",
		ShowLastInGroup = "RavenAttack",
		FrequencyIncrease = 10.0 / 8.0, -- Temp divide from original to modified MaxTimeBetweenAttacks
		OverwriteSelf =
		{
			MinTimeBetweenAttacks = 7.0,
			MaxTimeBetweenAttacks = 8.0,
		},
		SimpleExtractValues =
		{
			{
				Property = "FrequencyIncrease",
				Multiply = 100,
				Add = -100,
				NewProperty = "FrequencyIncreasePercent",
			},
		},
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
		OverwriteSelf =
		{
			MinTimeBetweenAttacks = 5.0,
			MaxTimeBetweenAttacks = 6.0,
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
		OverwriteSelf =
		{
			MinTimeBetweenAttacks = 3.0,
			MaxTimeBetweenAttacks = 4.0,
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
		Icon = "FamiliarIcon_Hound",
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
		Icon = "FamiliarIcon_Hound",
		BonusResourceSpawnChance = 0.025,
		ShowLastInGroup = "HoundUses",
		SimpleExtractValues =
		{
			{
				Property = "BonusResourceSpawnChance",
				Multiply = 100 / 0.1, -- Temp divide by BaseResourceSpawnChance 
				NewProperty = "BonusResourceSpawnChancePercent",
			},
		},
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
		Icon = "FamiliarIcon_Hound",
		ShowLastInGroup = "HoundAttack",
		FrequencyIncrease = 0.15, -- This is wrong but close enough... 12% -> 14% -> 16%
		OverwriteSelf =
		{
			MinTimeBetweenBarks = 7.0,
			MaxTimeBetweenBarks = 8.0,
		},
		SimpleExtractValues =
		{
			{
				Property = "FrequencyIncrease",
				Multiply = 100,
				NewProperty = "FrequencyIncreasePercent",
			},
		},
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
		OverwriteSelf =
		{
			MinTimeBetweenBarks = 6.0,
			MaxTimeBetweenBarks = 7.0,
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
		OverwriteSelf =
		{
			MinTimeBetweenBarks = 5.0,
			MaxTimeBetweenBarks = 6.0,
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
			ScaleX = 30.0,
			ScaleY = 30.0,
			X = ScreenCenterX + 300,
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
				InfoBoxFlavor =
				{
					TextArgs = ScreenData.UpgradeChoice.FlavorText,
				},
			}
		},

		SelectButton =
		{
			Graphic = "ContextualActionButton",
			GroupName = "Combat_Menu_Overlay",
			X = UIData.ContextualButtonXRight - UIData.ContextualButtonSpacing - 100,
			BottomOffset = UIData.ContextualButtonBottomOffset,
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