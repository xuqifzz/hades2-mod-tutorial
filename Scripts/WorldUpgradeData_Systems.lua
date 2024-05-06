-- key systems
OverwriteTableKeys( WorldUpgradeData, 
{
	-- Aspects System
	WorldUpgradeWeaponUpgradeSystem =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_aspect",
		Cost =
		{
			OreNBronze = 5,
			PlantFNightshade = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBossGrantsWeaponUpgradeSystem01" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "MelCauldronSpellRevealedSpeech", Time = 20 },
			},
			{ Cue = "/VO/Melinoe_2539", Text = "The Nocturnal Arms still are holding something back..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_2574", Text = "{#Emph}As bearer of the Fated Arms of Night, \n {#Emph}I seek their Aspects hidden from my sight." },
			}
		},
	},
	WorldUpgradeCardUpgradeSystem =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_altar",
		Cost =
		{
			MetaFabric = 6,
			MixerFBoss = 1,
			MetaCardPointsCommon = 6,
			--Mixer5Common = 1,

		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBossGrantsCardUpgradeSystem01" }
			},
		},
		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "MelCauldronSpellRevealedSpeech", Time = 20 },
			},
			{ Cue = "/VO/Melinoe_3488", Text = "Our Altar can be purified..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				{ Cue = "/VO/Melinoe_3073", Text = "{#Emph}O Altar of Ashes beneath which I stand, \n {#Emph}Fulfill your true purpose that I know firsthand." },
			},
		},

		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "CardUpgradePoints", ResourceAmount = 3, SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },
	},
	WorldUpgradeBountyBoard =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bounty",
		-- InspectPoint = 422257,
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },
		Cost =
		{
			PlantFMoly = 2,
			MetaFabric = 2,
			MixerGBoss = 2,
			PlantFNightshade = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChaosGrantsBountyBoard01" },
			},
		},
		CameraFocusId = 424956,
		PanDuration = 1.5,
		PanHoldDuration = 1.0,

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "MelCauldronSpellRevealedSpeech", Time = 20 },
			},
			{ Cue = "/VO/Melinoe_3444", Text = "Through the knowledge of Almighty Chaos, I can see into the void..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				{ Cue = "/VO/Melinoe_3074", Text = "{#Emph}As ancient Chaos beckoned me to say, \n {#Emph}Awake, O monument of Night; I shall obey!" },
			},
		},
	},
	WorldUpgradeFamiliarSystem =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_FamiliarPoints",
		Cost =
		{
			PlantGLotus = 1,
			GiftPoints = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateBossGrantsFamiliarSystem01" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.5,
			PlayOnce = true,
			Cooldowns =
			{
				{ Name = "MelCauldronSpellRevealedSpeech", Time = 20 },
			},
			{ Cue = "/VO/Melinoe_3410", Text = "The incantation that Headmistress taught to me..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,

				{ Cue = "/VO/Melinoe_3506", Text = "{#Emph}To all my beast companions near and far, \n {#Emph}Let us protect each other, soul and scar." },
			},
		},

		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "FamiliarPoints", ResourceAmount = 1, SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },
	},
	WorldUpgradeFamiliarRest =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_pool",
		Cost =
		{
			PlantHWheat = 4,
			MixerHBoss = 1,
			MixerNBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasNone = { "/VO/Melinoe_2766", "/VO/MelinoeField_1916" }
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "FamiliarPoints" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
	WorldUpgradeToolUpgradeSystem =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_pool",
		Cost =
		{
			OreNBronze = 4,
			OreIMarble = 2,
			OreOIron = 4,
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
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3507", Text = "{#Emph}Night's Craftwork, you revealed yourselves to me; \n {#Emph}Your true connection to the Earth, I see." },
			},
		},
	},
})