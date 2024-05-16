ToolData =
{
	BaseTool = 
	{
		AnimOffsetZ = 200,
		UseText = "UseTool",

		MouseOverSound = "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage",

		ShopPurchasaeFunctionName = "HighlightPlayerToolPresentation",

		InfoBackingAnimation = "ToolSlotBase",
	},

	ToolFishingRod =
	{
		InheritFrom = { "BaseTool" },

		GrannyModel = "ToolFishRod_Mesh",
		UpgradeTextures =
		{
			ToolFishingRod2 = "Models/Tools/ToolFishRodLvl2_Color",
		},
		PinHintResources =
		{
			"FishFCommon",
			"FishFRare",
			"FishFLegendary",
			"FishGCommon",
			"FishGRare",
			"FishGLegendary",
			"FishHCommon",
			"FishHRare",
			"FishHLegendary",
			"FishICommon",
			"FishIRare",
			"FishILegendary",
			"FishNCommon",
			"FishNRare",
			"FishNLegendary",
			"FishOCommon",
			"FishORare",
			"FishOLegendary",
			"FishPCommon",
			"FishPRare",
			"FishPLegendary",
			"FishBCommon",
			"FishBRare",
			"FishBLegendary",
			"FishChaosCommon",
			"FishChaosRare",
			"FishChaosLegendary",
		},
		EquippedKitAnimation = "FishingRodHoverEquipped",
		UnequippedKitAnimation = "FishingRodHover",
		OnUsedFunctionName = "UseToolKit",
		Icon = "GUI\\Icons\\FishingRod",
		
		EquipVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeMiscToolEquipSpeech", Time = 40 },
				},
				{ Cue = "/VO/Melinoe_0814", Text = "Rod of Fishing." },
				-- { Cue = "/VO/Melinoe_0815", Text = "Could use the Rod." },
			},
			[2] = GlobalVoiceLines.MiscToolEquipVoiceLines,
		},
	},

	ToolPickaxe =
	{
		InheritFrom = { "BaseTool" },

		GrannyModel = "ToolPickAxe_Mesh",
		UpgradeTextures =
		{
			ToolPickaxe2 = "Models/Tools/ToolPickAxeLvl2_Color",
		},
		PinHintResources =
		{
			"OreFSilver",
			"OreGLime",
			"OreHGlassrock",
			"OreIMarble",
			"OreNBronze",
			"OreOIron",
		},
		EquippedKitAnimation = "PickAxeHoverEquipped",
		UnequippedKitAnimation = "PickAxeHover",
		FirstTimeEquipAnimation = "MelinoePickAxeMineSwing",
		OnUsedFunctionName = "UseToolKit",
		Icon = "GUI\\Icons\\Pickaxe",
		EquipVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeMiscToolEquipSpeech", Time = 40 },
				},
				{ Cue = "/VO/Melinoe_0812", Text = "The Pick." },
				{ Cue = "/VO/Melinoe_0813", Text = "How about the Pick." },
			},
			[2] = GlobalVoiceLines.MiscToolEquipVoiceLines,
		},
	},

	ToolShovel =
	{
		InheritFrom = { "BaseTool" },

		GrannyModel = "ToolShovel_Mesh",
		UpgradeTextures =
		{
			ToolShovel2 = "Models/Tools/ToolShovelLvl2_Color",
		},
		PinHintResources =
		{
			"PlantFNightshadeSeed",
			"PlantFNightshade",
			"PlantGCattailSeed",
			"PlantGCattail",
			"PlantHWheatSeed",
			"PlantHWheat",
			"PlantIPoppySeed",
			"PlantIPoppy",
			"PlantNGarlicSeed",
			"PlantNGarlic",
			"PlantOMandrakeSeed",
			"PlantOMandrake",
			"PlantChaosThalamusSeed",
			"PlantChaosThalamus",
		},
		EquippedKitAnimation = "ShovelHoverEquipped",
		UnequippedKitAnimation = "ShovelHover",
		OnUsedFunctionName = "UseToolKit",
		Icon = "GUI\\Icons\\Shovel",
		EquipVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeMiscToolEquipSpeech", Time = 40 },
				},

				{ Cue = "/VO/Melinoe_2474", Text = "The Spade." },
				{ Cue = "/VO/Melinoe_2475", Text = "Maybe the Spade." },
			},
			[2] = GlobalVoiceLines.MiscToolEquipVoiceLines,
		},
	},

	ToolExorcismBook =
	{
		InheritFrom = { "BaseTool" },
		
		GrannyModel = "ToolTablet_Mesh",
		UpgradeTextures =
		{
			ToolExorcismBook2 = "Models/Tools/ToolTabletLvl2_Color",
		},
		PinHintResources =
		{
			"MemPointsCommon",
		},
		EquippedKitAnimation = "ExorcismBookHoverEquipped",
		UnequippedKitAnimation = "ExorcismBookHover",
		FirstTimeEquipAnimation = "MelinoeExorcismFirstTimeEquip",
		OnUsedFunctionName = "UseToolKit",
		Icon = "GUI\\Icons\\ExorcismBook",
		EquipVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeMiscToolEquipSpeech", Time = 40 },
				},
				{ Cue = "/VO/Melinoe_1613", Text = "The Tablet." },
				-- { Cue = "/VO/Melinoe_1614", Text = "Should take the Tablet." },
				-- { Cue = "/VO/Melinoe_0818", Text = "Talisman." },
				-- { Cue = "/VO/Melinoe_0819", Text = "I'll take the talisman." },
			},
			[2] = GlobalVoiceLines.MiscToolEquipVoiceLines,
		},
	},
}

ToolOrderData =
{
	"ToolPickaxe",
	"ToolExorcismBook",
	"ToolShovel",
	"ToolFishingRod",
}

HarvestData =
{
	DefaultSpawnChances =
	{
		0.25,
		--0.10,
		--0.05,
	},
	DefaultGameStateRequirements =
	{
		{
			SumPrevRooms = 3,
			Path = { "NumHarvestPoints" },
			Comparison = "<=",
			Value = 0,
		},
	},

	WeightedOptions =
	{
		{
			Weight = 20,
			Animation = "HarvestPointMushroom",
			EmptyAnimation = "ShovelPointUsed",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "WetState" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", "N", },
				},
			},
			AddResources =
			{
				PlantMoney = 1,
			},
		},

		-- Erebus
		{
			Weight = 15,
			Animation = "HarvestPointMoly",
			EmptyAnimation = "HarvestPointMolyUsed",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", },
				},
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny= { "VanillaState" },
				},
			},
			AddResources =
			{
				PlantFMoly = 1,
			},
		},

		-- Oceanus
		{
			Weight = 15,
			Animation = "HarvestPointPlantGLotus",
			EmptyAnimation = "HarvestPointPlantGLotusUsed",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G", },
				},
				--[[
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny= { "VanillaState" },
				},
				]]
			},
			AddResources =
			{
				PlantGLotus = 1,
			},
		},

		-- Fields
		{
			Weight = 15,
			Animation = "HarvestPointPlantHMyrtle",
			EmptyAnimation = "HarvestPointPlantHMyrtleUsed",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "H", },
				},
				--[[
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny= { "VanillaState" },
				},
				]]
			},
			AddResources =
			{
				PlantHMyrtle = 1,
			},
		},

		-- Tartarus
		{
			Weight = 15,
			Animation = "HarvestPointPlantIShaderot",
			EmptyAnimation = "HarvestPointPlantIShaderotUsed",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I", },
				},
				--[[
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny= { "VanillaState" },
				},
				]]
			},
			AddResources =
			{
				PlantIShaderot = 1,
			},
		},

		-- Ephyra
		{
			Weight = 15,
			Animation = "HarvestPointPlantNMoss",
			EmptyAnimation = "HarvestPointPlantNMossUsed",
			HarvestedDrawGroup = "Terrain_Gameplay",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N", "N_SubRooms", },
				},
				--[[
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny= { "VanillaState" },
				},
				]]
			},
			AddResources =
			{
				PlantNMoss = 1,
			},
		},

		-- Ships
		{
			Weight = 15,
			Animation = "HarvestPointPlantODriftwood",
			EmptyAnimation = "HarvestPointPlantODriftwoodUsed",
			UseText = "UseHarvestPointDriftwood",
			DrawGroup = "Terrain_Gameplay",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O", },
				},
				--[[
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny= { "VanillaState" },
				},
				]]
			},
			AddResources =
			{
				PlantODriftwood = 1,
			},
		},

		-- Chaos		
		{
			Weight = 15,
			ConsumableName = "Mixer6CommonDrop",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChaosGrantsDarkness01" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "Chaos", },
				},
			},
		},
	},
}

ShovelPointData =
{
	DefaultSpawnCap = 1,
	DefaultSpawnChance = 0.01,
	HasToolSpawnChance = 0.35,
	ToolName = "ToolShovel",
	DefaultGameStateRequirements =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		{
			SumPrevRooms = 3,
			Path = { "NumShovelPoints" },
			Comparison = "<=",
			Value = 0,
		},
	},
	ShovelPointBonusDrops =
	{
		{
			PresentationFunctionName = "ShovelPointBombPresentation",
			ProjectileName = "ShovelPointBomb",
			Chance = 0.02,
		},
		{
			HealthDropName = "HealDropMinor",
			Chance = 0.15,
		},
	},
	WeightedOptions =
	{
		-- Erebus
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", },
				},
			},
			AddResources =
			{
				PlantFNightshadeSeed = 2,
			},
		},

		-- Oceanus
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G", },
				},
			},
			AddResources =
			{
				PlantGCattailSeed = 2,
			},
		},

		-- Fields
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "H", },
				},
			},
			AddResources =
			{
				PlantHWheatSeed = 2,
			},
		},

		-- Tartarus
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I", },
				},
			},
			AddResources =
			{
				PlantIPoppySeed = 2,
			},
		},

		-- Ephyra
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N", "N_SubRooms", },
				},
			},
			AddResources =
			{
				PlantNGarlicSeed = 2,
			},
		},

		-- Ships
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O", },
				},
			},
			AddResources =
			{
				PlantOMandrakeSeed = 2,
			},
		},

		-- Chaos
		{
			Weight = 4,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "Chaos", },
				},
			},
			AddResources =
			{
				PlantChaosThalamusSeed = 1,
			},
		},
	},
}

PickaxePointData =
{
	DefaultSpawnCap = 1,
	DefaultSpawnChance = 0.01,
	HasToolSpawnChance = 0.40,
	ToolName = "ToolPickaxe",
	DefaultGameStateRequirements =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 1,
		},
		{
			SumPrevRooms = 4,
			Path = { "NumPickaxePoints" },
			Comparison = "<=",
			Value = 0,
		},
	},
	WeightedOptions =
	{
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreFSilver",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointSilverUnavailable",
			Animation = "PickaxePointSilver",
			EmptyAnimation = "PickaxePointSilverEmpty",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreGLime",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreGLimeUnavailable",
			Animation = "PickaxePointOreGLime",
			EmptyAnimation = "PickaxePointOreGLimeEmpty",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G", },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreHGlassrock",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreHGlassrockUnavailable",
			Animation = "PickaxePointOreHGlassrock",
			EmptyAnimation = "PickaxePointOreHGlassrockEmpty",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "H", },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreIMarble",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreIMarbleUnavailable",
			Animation = "PickaxePointOreIMarble",
			EmptyAnimation = "PickaxePointOreIMarbleEmpty",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I", },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreNBronze",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointBronzeUnavailable",
			Animation = "PickaxePointBronze",
			EmptyAnimation = "PickaxePointBronzeEmpty",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N", "N_SubRooms" },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 3,
			ResourceName = "OreOIron",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreOIronUnavailable",
			Animation = "PickaxePointOreOIron",
			EmptyAnimation = "PickaxePointOreOIronEmpty",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
			},
		},
		{
			Weight = 1,
			MaxHealth = 1,
			ResourceName = "OreChaosProtoplasm",
			SwingDamage = 1,
			UnavailableAnimation = "PickaxePointOreChaosProtoplasmUnavailable",
			Animation = "PickaxePointOreChaosProtoplasm",
			EmptyAnimation = "PickaxePointOreChaosProtoplasmEmpty",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "Chaos" },
				},
			},
		},
	},
}

ExorcismData =
{
	DefaultSpawnCap = 1,
	DefaultSpawnChance = 0.01,
	HasToolSpawnChance = 0.30,
	ToolName = "ToolExorcismBook",
	DefaultGameStateRequirements =
	{
		{
			Path = { "GameState", "CompletedRunsCache" },
			Comparison = ">=",
			Value = 2,
		},
		{
			SumPrevRooms = 6,
			Path = { "NumExorcismPoints" },
			Comparison = "<=",
			Value = 0,
		},
		{
			Path = { "CurrentRun", "BiomeDepthCache" },
			Comparison = ">=",
			Value = 2,
		},
	},

	WeightedOptions =
	{
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
			},
			UnavailableAnimation = "ExorcismPointGhostUnavailable",
			Animation = "ExorcismPointGhost",
			AttemptsRemaining = 2,
			NumMovesMin = 4,
			NumMovesMax = 5,
			MoveDurationMin = 1.5,
			MoveDurationMax = 2.0,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 13,
			AddResources =
			{
				MemPointsCommon = 30,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "G" },
				},
			},
			UnavailableAnimation = "ExorcismPointGhostUnavailable",
			Animation = "ExorcismPointGhost",
			AttemptsRemaining = 2,
			NumMovesMin = 6,
			NumMovesMax = 7,
			MoveDurationMin = 1.0,
			MoveDurationMax = 1.4,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 10,
			AddResources =
			{
				MemPointsCommon = 35,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "H" },
				},
			},
			UnavailableAnimation = "ExorcismPointGhostUnavailable",
			Animation = "ExorcismPointGhost",
			AttemptsRemaining = 2,
			NumMovesMin = 8,
			NumMovesMax = 10,
			MoveDurationMin = 0.6,
			MoveDurationMax = 0.8,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 8,
			AddResources =
			{
				MemPointsCommon = 40,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "I" },
				},
			},
			UnavailableAnimation = "ExorcismPointGhostUnavailable",
			Animation = "ExorcismPointGhost",
			AttemptsRemaining = 2,
			NumMovesMin = 13,
			NumMovesMax = 15,
			MoveDurationMin = 0.2,
			MoveDurationMax = 0.4,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 6,
			AddResources =
			{
				MemPointsCommon = 50,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "N", "N_SubRooms" },
				},
			},
			UnavailableAnimation = "ExorcismPointGhostUnavailable",
			Animation = "ExorcismPointGhost",
			AttemptsRemaining = 2,
			NumMovesMin = 4,
			NumMovesMax = 5,
			MoveDurationMin = 1.2,
			MoveDurationMax = 1.4,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 10,
			AddResources =
			{
				MemPointsCommon = 30,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "O" },
				},
			},
			UnavailableAnimation = "ExorcismPointGhostUnavailable",
			Animation = "ExorcismPointGhost",
			AttemptsRemaining = 2,
			NumMovesMin = 7,
			NumMovesMax = 9,
			MoveDurationMin = 0.35,
			MoveDurationMax = 0.65,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 9,
			AddResources =
			{
				MemPointsCommon = 35,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "P" },
				},
			},
			UnavailableAnimation = "ExorcismPointGhostUnavailable",
			Animation = "ExorcismPointGhost",
			AttemptsRemaining = 2,
			NumMovesMin = 12,
			NumMovesMax = 16,
			MoveDurationMin = 0.65,
			MoveDurationMax = 0.85,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 9,
			AddResources =
			{
				MemPointsCommon = 40,
			}
		},
		{
			Weight = 1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "Q" },
				},
			},
			UnavailableAnimation = "ExorcismPointGhostUnavailable",
			Animation = "ExorcismPointGhost",
			AttemptsRemaining = 2,
			NumMovesMin = 17,
			NumMovesMax = 22,
			MoveDurationMin = 0.3,
			MoveDurationMax = 0.5,
			InputCheckInterval = 0.1,
			TotalCheckFails = 999,
			ConsecutiveCheckFails = 7,
			AddResources =
			{
				MemPointsCommon = 50,
			}
		},
	},
}