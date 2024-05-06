-- supporting systems
OverwriteTableKeys( WorldUpgradeData, 
{
	WorldUpgradeHarvestUpgrade =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_flora",
		BonusResourcesChance = 0.20,
		BonusResourcesCount = 1,
		SimpleExtractValues =
		{
			{
				Property = "BonusResourcesChance",
				Multiply = 100,
				NewProperty = "BonusResourcesChancePercent",
			}
		},
		Cost =
		{
			PlantNMoss = 7,
			PlantGLotus = 7, 
			PlantFMoly = 7,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WeaponsUnlocked" },
				HasAll = { "ToolPickaxe", "ToolExorcismBook", "ToolShovel", "ToolFishingRod" },
			},
			{
				Path = { "CurrentRun", "WeaponsUnlocked" },
				HasNone = { "ToolPickaxe", "ToolExorcismBook", "ToolShovel", "ToolFishingRod" },
			},
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolUpgradeSystem" },
			},
		},
	},
	WorldUpgradeGardenT2 =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_soil",
		Cost =
		{
			PlantGLotus = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGarden" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshade" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantGCattail" },
				Comparison = ">=",
				Value = 1,
			},
		},

		ActivateRoomObstacleIds = { 583643, 583642 },
		PanDuration = 1.5,
		PanHoldDuration = 1.0,
		PostRevealVoiceLines = 
		{
			{
				ObjectType = "NPC_Odysseus_01",
				PreLineWait = 0.35,

				{ Cue = "/VO/Odysseus_0335", Text = "That's a good trick." },
			},
		},
	},
	WorldUpgradeGardenT3 =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_soil",
		Cost =
		{
			PlantHWheat = 1,
			PlantNGarlic = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGardenT2" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantNGarlic" },
				Comparison = ">=",
				Value = 1,
			},
		},

		ActivateRoomObstacleIds = { 583640, 583641 },
		PanDuration = 1.5,
		PanHoldDuration = 1.0,
	},
	WorldUpgradeGardenTent =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_soil",
		Cost =
		{
			PlantFMoly = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGarden" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "SeedP" },
				Comparison = ">=",
				Value = 1,
			},
		},

		ActivateRoomObstacleIds = { 583644, 583645 },
		PanDuration = 1.5,
		PanHoldDuration = 1.0,
	},
	WorldUpgradeGardenTaverna =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_soil",
		Cost =
		{
			PlantFMoly = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshadeSeed" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "DONTWORK" },
			}
		},

		ActivateRoomObstacleIds = { 583649, 583648 },
		PanDuration = 1.5,
		PanHoldDuration = 1.0,
	},
	-- Learned Sage -- Sage
	WorldUpgradeRunHistory =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },

		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_history",
		Cost =
		{
			OreIMarble = 3,
			MixerIBoss = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeMarket", "WorldUpgradeTaverna" },
			},
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "EnemyKills", "Polyphemus" },
				Comparison = ">=",
				Value = 1,
			},
		},

		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_3564", Text = "Welcome, O Learned Sage!", PostLineFunctionName = "LearnedSageReaction" },
		},

		ActivateRoomObstacleIds = { 589466 },
		ActivateGroups = { "HistorianDecor" },
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPoint = 589466,
	},
	-- Record Keeper -- Keeper
	WorldUpgradeGameStats =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },

		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_stats",
		Cost =
		{
			PlantIPoppy = 2,
			PlantIShaderot = 2,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeMarket", "WorldUpgradeTaverna" },
			},
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 1,
			},
		},

		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_3565", Text = "Record Keeper, pleased to have you here!", PostLineFunctionName = "RecordKeeperReaction" },
		},

		ActivateRoomObstacleIds = { 589467 },
		ActivateGroups = { "StatisticianDecor" },
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPoint = 589548,
	},
	WorldUpgradeGiftsShop =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_gifting",
		Cost =
		{
			MetaCurrency = 60,
			--PlantFMoly = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeMarket", "WorldUpgradeToolsShop" },
			},
			{
				PathTrue = { "GameState", "ScreensViewed", "MarketScreen" },
			},
		},
		ActivateGroups = { "BrokerGiftDecor" },
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "GiftPoints", SoundName = "/SFX/GiftAmbrosiaBottlePickup" },


		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_0553", Text = "Broker, you've expanded your shop!", PostLineFunctionName = "WretchedBrokerReaction" },
		},

		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		CameraFocusId = 558096,
	},
	WorldUpgradeRelationshipBar =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_relationship",
		-- InspectPoint = 422257,
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },
		Cost =
		{
			PlantHMyrtle = 3,
			MetaFabric = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "CodexStatus", "Enabled" },
			},
			-- this counts number of Keepsakes acquired
			{
				Path = { "GameState", "GiftPresentation" },
				UseLength = true,
				Comparison = ">=",
				Value = 7,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantHMyrtle" },
				Comparison = ">=",
				Value = 3,
			},
		},
		OnActivateFinishedFunctionName = "ShowCodexUpdate",
	},
	-- he is fast asleep, for he has seen too much; counted too much
	WorldUpgradeHypnosUnlock =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_hypnos",
		Cost =
		{
			MysteryResource = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Hypnos_01", },
				Comparison = ">=",
				Value = 999,
			},
		},

		-- SetPlayerAnimation = "ZagreusTalkDenial_Full",

		CameraFocusId = 370024, -- Hypnos
		PreActivationHoldDuration = 4,
		PostActivationHoldDuration = 5,
	},
})