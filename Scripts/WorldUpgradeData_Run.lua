-- run upgrades
OverwriteTableKeys( WorldUpgradeData, 
{
	WorldUpgradePostBossWellShops =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_well",
		Cost =
		{
			PlantFMoly = 3,
			PlantGCattail = 3,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeWellShops", "WorldUpgradeFountainUpgrade1" },
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "F_PostBoss01" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "Money" },
				Comparison = ">=",
				Value = 3000,
			},
		},
	},
	WorldUpgradeSurfaceShops =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_surfaceshop",
		Cost =
		{
			MetaFabric = 3,
			PlantODriftwood = 2,
			MixerNBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeWellShops", "WorldUpgradeSurfacePenaltyCure", "WorldUpgradeEphyraZoomOut" },
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
			},
		},
	},
	WorldUpgradePostBossSurfaceShops =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_surfaceshop",
		Cost =
		{
			MetaFabric = 2,
			PlantNGarlic = 2,
			PlantOMandrake = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeSurfaceShops" },
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "N_PostBoss01" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "Money" },
				Comparison = ">=",
				Value = 6000,
			},
		},
	},
	WorldUpgradeOceanusReprieve =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_oceanus",
		Cost =
		{
			PlantGLotus = 3,
			OreGLime = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeErebusReprieve" },
			},
			{
				PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
			},
		},
	},
	WorldUpgradeTartarusReprieve =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_tartarus",
		Cost =
		{
			PlantIShaderot = 3,
			OreIMarble = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeOceanusReprieve" },
			},
			{
				PathTrue = { "GameState", "RoomCountCache", "I_PreBoss01" },
			},
			{
				PathTrue = { "GameState", "RoomCountCache", "I_Story01" },
			},
		},
	},
	WorldUpgradeThessalyReprieve =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_oceanus",
		Cost =
		{
			PlantODriftwood = 3,
			OreOIron = 3,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeSurfacePenaltyCure", "WorldUpgradeOceanusReprieve" },
			},
			{
				PathTrue = { "GameState", "RoomCountCache", "O_Boss01" },
			},
		},
	},
	WorldUpgradeFountainUpgrade2 =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_fountain",
		Cost =
		{
			PlantFNightshade = 1,
			PlantGCattail = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFountainUpgrade1" },
			},
			{
				Path = { "GameState", "UseRecord" },
				HasAny = { "HealthFountainG", "HealthFountainN" },
			},
		},
	},
	WorldUpgradeBreakableValue1 =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_trove",
		Cost =
		{
			OreGLime = 1,
			MetaFabric = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossGiftRack" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "Money" },
				Comparison = ">=",
				Value = 1500,
			},
		},
	},
	WorldUpgradeEphyraZoomOut =
	{
		InheritFrom = { "DefaultMinorItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_cage",
		Cost =
		{
			PlantNMoss = 3,
			TrashPoints = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
			},
			{
				Path = { "GameState", "SpeechRecord" },
				HasAny = { "/VO/MelinoeField_0619", "/VO/MelinoeField_0414" }
			},
		},
	},
	WorldUpgradeFieldsRewardFinder =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bough",
		Cost =
		{
			-- PlantFMoly = 1,
			PlantHMyrtle = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "H_Intro" },
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_2783", Text = "How to find my way in the Mourning Fields..." },
		},
	},
	WorldUpgradeTimeSlowChronosFight =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_chronos",
		Cost =
		{
			PlantIShaderot = 3,
			PlantFMoly = 3,
			MetaFabric = 7,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
			},
			NamedRequirements = { "UsedTimeSlowAgainstChronos" },
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3070", Text = "Time thinks he can't be stopped. I think otherwise." },
		},
	},	
	WorldUpgradePauseChronosFight =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_chronos",
		Cost =
		{
			MixerIBoss = 3,
			PlantFMoly = 3,
		},
		--[[
		CostAmountTextIds =
		{
			MixerIBoss = "MysteryResource",
		},
		]]--

		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAny = { "/VO/Chronos_0563_B" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3070", Text = "Time thinks he can't be stopped. I think otherwise." },
		},
	},
	WorldUpgradeUnusedWeaponBonus =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bones",
		Cost =
		{
			OreGLime = 2,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeMarket" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_2822", Text = "The Arms of Night seek something more from me..." },
		},
	},
	WorldUpgradePostBossGiftRack =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_keepsakes",
		Cost =
		{
			OreGLime = 4,
			PlantGLotus = 1,
			PlantFMoly = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomCountCache" },
				HasAll = { "F_PostBoss01" },
			},
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeErebusReprieve" },
			},
			-- this counts number of Keepsakes acquired
			{
				Path = { "GameState", "GiftPresentation" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	WorldUpgradeErebusSafeZones =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_erebus",
		Cost =
		{
			PlantFMoly = 1,
			PlantGLotus = 1,
			PlantOMandrake = 1,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "F_PostBoss01" },
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "N_PostBoss01" },
			},
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeUnusedWeaponBonus", "WorldUpgradeShadeMercs", "WorldUpgradeChallengeSwitches1", },
			},
		},
	},
	WorldUpgradeSafeZoneSpellCharge =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_erebus",
		Cost =
		{
			PlantFMoly = 1,
			PlantGLotus = 1,
			PlantOMandrake = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeErebusSafeZones" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "SeleneFirstPickUp" },
			},
		},
	},
	WorldUpgradeShadeMercs =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_shade",
		Cost =
		{
			MemPointsCommon = 5,
			PlantFNightshade = 5,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeErebusReprieve" },
			},
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeUnusedWeaponBonus" },
			},
			{
				Path = { "GameState", "MaxMetaUpgradeCostCache" },
				Comparison = ">=",
				Value = 21,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,

				{ Cue = "/VO/Melinoe_1071", Text = "{#Emph}Come, Spirits of the Dead, I have a task for you!" },
			},
		},
	},
	WorldUpgradeChallengeSwitches1 =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_trove",
		Cost =
		{
			PlantFNightshade = 1,
			OreGLime = 5,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "F_Boss01" },
			},
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeMarket", "WorldUpgradeToolsShop", "WorldUpgradeErebusReprieve", "WorldUpgradePostBossGiftRack", "WorldUpgradePostBossWellShops" },
			},
		},
	},
	WorldUpgradeMetaCardPointsCommonRunProgress =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_altar",
		Cost =
		{
			PlantGCattail = 5,
			MetaCardPointsCommon = 50,
			MixerGBoss = 5,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 300,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 1000,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 2000,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 20,
			},
		},
	},
	WorldUpgradeMemPointsCommonRunProgress =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_altar",
		Cost =
		{
			PlantOMandrake = 5,
			MemPointsCommon = 100,
			MixerFBoss = 5,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 300,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 1000,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 2000,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 20,
			},
		},
	},
	WorldUpgradeMetaCurrencyRunProgress =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bones",
		Cost =
		{
			PlantHWheat = 5,
			MetaFabric = 10,
			MixerHBoss = 5,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 300,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 1000,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 2000,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 20,
			},
		},
	},
	WorldUpgradeGiftDropRunProgress =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_gifting",
		Cost =
		{
			PlantNGarlic = 5,
			GiftPoints = 5,
			MixerNBoss = 5,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 300,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 1000,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 2000,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 20,
			},
		},
	},
})