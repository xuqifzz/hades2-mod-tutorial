-- hub expansions
OverwriteTableKeys( WorldUpgradeData,
{
	WorldUpgradeTaverna =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bar",
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },

		Cost =
		{
			GiftPoints = 2,
			PlantNGarlic = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "GiftPoints" },
				Comparison = ">=",
				Value = 12,
			},
		},
		OnActivateFunctionName = "RevealTavernaPresentation",
		CameraFocusId = 586614,
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPointId = 576167,
	},
	WorldUpgradeBathHouse =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_spring",
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },
		Cost =
		{
			PlantFMoly = 2,
			PlantGLotus = 2,
			PlantFNightshade = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "GiftPoints" },
				Comparison = ">=",
				Value = 6,
			},
		},
		OnActivateFunctionName = "RevealBathHousePresentation",
		CameraFocusId = 589478,
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPointId = 589546,
	},
	WorldUpgradeFishingPoint =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_dock",
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },
		Cost =
		{
			PlantGCattail = 2,
			PlantODriftwood = 4,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" },
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "GiftPoints" },
				Comparison = ">=",
				Value = 12,
			},
		},
		OnActivateFunctionName = "RevealFishingPointPresentation",
		CameraFocusId = 586672,
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPointId = 589545,
	},
})