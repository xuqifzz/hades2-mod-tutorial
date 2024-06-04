WorldUpgradeData =
{
	DefaultCriticalItem =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
		Cost =
		{
			Gems = 5,
			MetaPoints = 10,
		},

		IncantationRepeatableVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,

				{ Cue = "/VO/Melinoe_1350", Text = "The power to create..." },
				{ Cue = "/VO/Melinoe_1351", Text = "The power to change..." },

				-- { Cue = "/VO/Melinoe_1352", Text = "Transmutation complete." },
				-- { Cue = "/VO/Melinoe_1353", Text = "Transmutation succeeded." },
				-- { Cue = "/VO/Melinoe_1354", Text = "My will is manifest." },
				-- { Cue = "/VO/Melinoe_1355", Text = "Re-shaped by Chaos..." },
			},
		},

		IncantationDuration = 17,
		IncantationAnimation = "MelinoeCauldronIncantationComplete",
		IncantationAnimationSpeed = 1.0,
		IncantationPunctuation = 2.1,

		ExorcismData =
		{
			CriticalItem = true,
			MoveSequence =
			{
				{
					Left = true,
					Right = true,
					Duration = 1.8,
				},
			},
		},
	},

	DefaultMajorItem =
	{
		IncantationDuration = 17.5,
		IncantationAnimation = "MelinoeCauldronIncantationComplete",
		IncantationAnimationSpeed = 0.85,
		IncantationPunctuation = 1.9,

		PreRevealVoiceLines =
		{
			[1] = GlobalVoiceLines.AddingReagentVoiceLines,
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,

				{ Cue = "/VO/Melinoe_0528", Text = "{#Emph}Shades of the Dead, reagents in the pot, \n {#Emph}Heed now my plea, become what I have sought." },
				{ Cue = "/VO/Melinoe_0529", Text = "{#Emph}O essences of Chaos, heed my voice, \n {#Emph}In your potential I have made my choice." },
				{ Cue = "/VO/Melinoe_0530", Text = "{#Emph}By moonlight and the dust of ancient bone, \n {#Emph}Awaken in this cauldron the unknown." },
				{ Cue = "/VO/Melinoe_0531", Text = "{#Emph}Fire and earth, between heaven and hell, \n {#Emph}Make manifest my thoughts; complete my spell." },
				{ Cue = "/VO/Melinoe_1078", Text = "{#Emph}I ask of you, Spirits of Earth and Night, \n {#Emph}To take away this pain, that we may fight!" },
				{ Cue = "/VO/Melinoe_1079", Text = "{#Emph}Upon my birthright, I command the Dark \n {#Emph}to aid my task and with me find my mark." },
				{ Cue = "/VO/Melinoe_1080", Text = "{#Emph}Hear me, O Shades, on my authority: \n {#Emph}Give my demand all due priority." },
				{ Cue = "/VO/Melinoe_1081", Text = "{#Emph}If Time cannot be stopped, then we shall see; \n {#Emph}If spill my blood I must, so mote it be...!" },
			},
		},

		RevealReactionVoiceLines = 
		{
			[1] = GlobalVoiceLines.CauldronReactionVoiceLines,
		},
	},

	DefaultHubItem =
	{
		IncantationDuration = 15,
		IncantationAnimation = "MelinoeCauldronIncantationComplete",
		IncantationAnimationSpeed = 1.2,
		IncantationPunctuation = 2.1,

		PreRevealVoiceLines =
		{
			-- [1] = GlobalVoiceLines.AddingReagentVoiceLines,
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,

				{ Cue = "/VO/Melinoe_0532", Text = "{#Emph}Dark of Chaos, light of Moon, heed now my will!" },
				{ Cue = "/VO/Melinoe_0533", Text = "{#Emph}Great Tree of Life, please listen to my thoughts!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0534", Text = "{#Emph}By light of moon, together let us shape reality!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1070", Text = "{#Emph}Boil, bounties of the earth; grant what I seek!" },
				{ Cue = "/VO/Melinoe_1071", Text = "{#Emph}Come, Spirits of the Dead, I have a task for you!" },
				{ Cue = "/VO/Melinoe_1072", Text = "{#Emph}As the Three Fates would have it, so shall I...!" },
				{ Cue = "/VO/Melinoe_1073", Text = "{#Emph}Great mother Gaia, listen to my heart's desire!" },
				{ Cue = "/VO/Melinoe_1074", Text = "{#Emph}My choice is hereby made, my path is set!" },
				{ Cue = "/VO/Melinoe_1075", Text = "{#Emph}By blood and darkness, let my will be done!" },
			},
		},

		RevealReactionVoiceLines = 
		{
			[1] = GlobalVoiceLines.CauldronReactionVoiceLines,
		},
	},

	DefaultMinorItem =
	{
		IncantationDuration = 10,
		IncantationAnimation = "MelinoeCauldronIncantationCompleteFaster",
		IncantationAnimationSpeed = 1.0,
		IncantationPunctuation = 2.1,

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,

				{ Cue = "/VO/Melinoe_1076", Text = "{#Emph}Kataskion aski!" },
				{ Cue = "/VO/Melinoe_1076_V2", Text = "{#Emph}Kataskion aski!" },
				{ Cue = "/VO/Melinoe_1076_V3", Text = "{#Emph}Kataskion aski!" },
				-- { Cue = "/VO/Melinoe_1077", Text = "{#Emph}Askion kataski!" },
				{ Cue = "/VO/Melinoe_1077_V2", Text = "{#Emph}Askion kataski!" },
				{ Cue = "/VO/Melinoe_1077_V3", Text = "{#Emph}Askion kataski!" },
				{ Cue = "/VO/Melinoe_2610", Text = "{#Emph}Damname aision!" },
				{ Cue = "/VO/Melinoe_2611", Text = "{#Emph}Damnaski traxon!" },
			},
		},

		RevealReactionVoiceLines = 
		{
			[1] = GlobalVoiceLines.CauldronReactionVoiceLines,
		},
	},

	DefaultInstantItem =
	{
		IncantationDuration = 6.5,
		IncantationOffsetY = -10,
		IncantationAnimation = "Melinoe_Incantation_Instant_Start",
		IncantationAnimationSpeed = 1.00,
		IncantationPunctuation = 0.03,

		IncantationVoiceLines =
		{
			{
				{ Cue = "/VO/Melinoe_1350", Text = "The power to create..." },
				{ Cue = "/VO/Melinoe_1351", Text = "The power to change..." },

				-- { Cue = "/VO/Melinoe_0195", Text = "In the name of Hades." },
				-- { Cue = "/VO/Melinoe_0196", Text = "In the name of Hades!" },
				-- { Cue = "/VO/Melinoe_0199", Text = "Hear me, on my authority!" }, 
			},
		},
	},

	-- story & major progression
	WorldUpgradeQuestLog =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_fatescroll",
		-- InspectPoint = 422257,
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },
		Cost =
		{
			PlantFMoly = 2,
			MetaCardPointsCommon = 2,
			OreFSilver = 1,
		},
		GameStateRequirements =
		{
			-- none
		},

		SkipUnlockText = true,

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,

				{ Cue = "/VO/Melinoe_1594", Text = "{#Emph}O daughters of Night, who can see all tomorrows, \n {#Emph}Please help me avenge both our families' sorrows." },
			},
		},

		RevealReactionVoiceLines = 
		{
			-- if hecate is absent
			{
				PlayOnce = true,
				PlayOnceContext = "QuestLogUnlockVO", 
				BreakIfPlayed = true,
				PreLineWait = 2.15,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeQuestLog" },
					},
					AreIdsNotAlive = { 556921 },
				},

				{ Cue = "/VO/Melinoe_1596", Text = "...Nothing. They didn't listen." },
			},
			-- if hecate is present
			{
				PreLineWait = 1.85,
				ObjectType = "NPC_Hecate_01",

				{ Cue = "/VO/Hecate_0476", Text = "No effect...?" },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "QuestLogUnlockVO", 
				BreakIfPlayed = true,
				PreLineWait = 0.65,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeQuestLog" },
					},
				},

				{ Cue = "/VO/Melinoe_1596", Text = "...Nothing. They didn't listen." },
			},
		},
	},
	WorldUpgradeMorosUnlock =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		AlwaysRevealImmediately = true,
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_moros",
		Cost =
		{
			PlantFNightshade = 1,
			MetaFabric = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "QuestsViewed", "QuestUnlockMoros" },
			}
		},

		-- SetPlayerAnimation = "ZagreusTalkDenial_Full",
		-- ActivateUnits = { 560612, },
		-- TeleportToId = 560665,
		-- PanDuration = 1.5,
		-- PanHoldDuration = 2.0,

		SkipUnlockText = true,

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },
			-- { Cue = "/VO/Melinoe_1339", Text = "The Fates sent me a message, if I could just..." },
			{ Cue = "/VO/Melinoe_1598", Text = "I think I know how I can do the bidding of the Fates..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,

				{ Cue = "/VO/Melinoe_1595", Text = "{#Emph}Hear me, O Doom, hear my voice from afar, \n {#Emph}I need beseech you, wherever you are." },
			},
		},
		IncantationDuration = 23,

		RevealReactionVoiceLines = 
		{
			{
				PlayOnce = true,
				PlayOnceContext = "MorosUnlockVO", 
				PreLineWait = 3.0,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1597", Text = "...Where are you, Lord Moros...?" },
			},
			{
				PreLineWait = 0.95,
				ObjectType = "NPC_Hecate_01",
				-- RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Hecate_0479", Text = "So it goes at times." },
			},
		},
	},

	-- key upgrades
	WorldUpgradePinning =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_reminder",
		Cost =
		{
			--MetaCardPointsCommon = 2,
			PlantFMoly = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeGarden" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeQuestLog" },
			},
		},
	},
	WorldUpgradeResourceFinder =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_reagent",
		Cost =
		{
			PlantFMoly = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
			},
			{
				PathTrue = { "GameState", "WeaponsUnlocked", "ToolPickaxe" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
				Comparison = ">=",
				Value = 5,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3508", Text = "{#Emph}Hear me Selene, if you so desire: \n {#Emph}Aid me in finding that which I require!" },
			},
		},
	},
	-- Broker
	WorldUpgradeMarket =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },

		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_broker",
		Cost =
		{
			MetaCurrency = 10,
			--PlantFMoly = 1,
		},

		GameStateRequirements =
		{
			-- None
		},

		ActivateRoomObstacleIds = { 558096, },
		ActivateGroups = { "BrokerDecor" },
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPoint = 576166,

		PreRevealVoiceLines =
		{
			[1] = GlobalVoiceLines.AddingReagentVoiceLines,
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,

				{ Cue = "/VO/Melinoe_1075", Text = "{#Emph}By blood and darkness, let my will be done!" },
			},
		},

		RevealReactionVoiceLines = 
		{
			{
				PreLineWait = 0.65,
				ObjectType = "NPC_Hecate_01",
				-- RequiredSourceValueFalse = "InPartnerConversation",

				{ Cue = "/VO/Hecate_0191", Text = "There." },
			},
		},

		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_0551", Text = "Broker! Welcome to the Crossroads.", PostLineFunctionName = "WretchedBrokerReaction" },
		},
	},
	WorldUpgradeSellShop =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_sell",
		Cost =
		{
			MetaCardPointsCommon = 1,
			--PlantFMoly = 1,
			PlantFNightshade = 1,
			--PlantMoney = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeMarket", "WorldUpgradeToolsShop", "WorldUpgradeGarden" },
			},
			{
				PathTrue = { "GameState", "ScreensViewed", "MarketScreen" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshade" },
				Comparison = ">=",
				Value = 1,
			},
		},

		CameraFocusId = 558096,
	},

	-- run upgrades
	WorldUpgradeWellShops =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_well",
		Cost =
		{
			PlantFMoly = 1,
			PlantFNightshade = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "CharonPoints", },
				Comparison = ">=",
				Value = 1,
			},
		},
	},
	WorldUpgradeErebusReprieve =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_erebus",
		Cost =
		{
			PlantFMoly = 1,
			OreFSilver = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeToolsShop" },
			},
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeQuestLog" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeResourceFinder" },
			},
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePinning" },
			},

			-- don't reveal the reprieve on the run you unlock the questlog
			{
				PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeResourceFinder" },
			},
			{
				PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeQuestLog" },
			},
		},
	},
	WorldUpgradeFountainUpgrade1 =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_fountain",
		Cost =
		{
			PlantGLotus = 1,
			PlantFMoly = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "HealthFountain" },
			},
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeErebusReprieve" },
			},
		},
	},

	-- supporting systems
	WorldUpgradeToolsShop =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_pick",
		Cost =
		{
			PlantFMoly = 1,
		},
		GameStateRequirements =
		{
			{
				--
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,

				{ Cue = "/VO/Melinoe_0532", Text = "{#Emph}Dark of Chaos, light of Moon, heed now my will!" },
			}
		},
	},
	WorldUpgradeGarden =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_soil",
		Cost =
		{
			PlantFMoly = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
				Comparison = ">=",
				Value = 6,
			},
		},
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "PlantFNightshadeSeed", CheckSeedStatus = true },

		ActivateRoomObstacleIds = { 558335, 558337 },
		PanDuration = 1.5,
		PanHoldDuration = 1.0,

		PostRevealVoiceLines = 
		{
			{
				ObjectType = "NPC_Odysseus_01",
				PreLineWait = 0.35,
				Cooldowns =
				{
					{ Name = "CauldronRevealQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/Odysseus_0333", Text = "Such sorcery!" },
			},
		},
	},
}