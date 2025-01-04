WorldUpgradeData =
{
	DefaultCriticalItem =
	{
		DebugOnly = true,
		Icon = "Shop_BedroomDecor",
		Cost =
		{
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
			[1] = { GlobalVoiceLines = "AddingReagentVoiceLines" },
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
			[1] = { GlobalVoiceLines = "CauldronReactionVoiceLines" },
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
			-- [1] = { GlobalVoiceLines = "AddingReagentVoiceLines" },
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
			[1] = { GlobalVoiceLines = "CauldronReactionVoiceLines" },
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
			[1] = { GlobalVoiceLines = "CauldronReactionVoiceLines" },
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
				PreLineWait = 0.3,
				RandomRemaining = true,
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 }, Alive = false },
					},
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
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_moros",
		AlwaysRevealImmediately = true,

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
	WorldUpgradeTimeStop =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_chronos",
		Cost =
		{
			MixerIBoss = 9999,
			MixerMythic = 9999,
		},
		CostAmountTextIds =
		{
			MixerIBoss = "MysteryResource",
			MixerMythic = "MysteryResource",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChronosBossWonAgainstHim01" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MixerIBoss" },
				Comparison = ">=",
				Value = 1,
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_2823", Text = "{#Emph}Death to Chronos... {#Prev}there has to be a way..." },
		},
	},
	WorldUpgradeAltRunDoor =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_ward",
		AlwaysRevealImmediately = true,

		Cost =
		{
			PlantFMoly = 3,
			MixerFBoss = 1,
			MixerShadow = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "HecateAboutHermes01", "HecateBossAboutHermes02" },
			},
		},

		CannotAffordVoiceLines =
		{
			{
				PlayOnce = true,
				PreLineWait = 0.45,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "MixerShadow" },
						Comparison = "<",
						Value = 1,
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				{ Cue = "/VO/Melinoe_2622", Text = "Must be a way I can extract pure Shadow..." },
			},
			[2] = { GlobalVoiceLines = "InvalidResourceInteractionVoiceLines" },
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_1346", Text = "I need to make my own way to the surface..." },
		},

		SkipPreRevealVoiceLines = true,
		PreRevealVoiceLines =
		{
			{
				PreLineWait = 0.05,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_1770", Text = "There..." },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_2575", Text = "{#Emph}The wards for my protection I dispel, \n {#Emph}For I am ready now for heaven as for hell!" },
			}
		},
	},
	WorldUpgradeSurfacePenaltyCure =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_melcurse",
		Cost =
		{
			PlantGLotus = 2,
			PlantFNightshade = 2,
			PlantNMoss = 2,
			PlantChaosThalamus = 2,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsSurfacePenaltyCure01" },
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_1347", Text = "Can I suppress my illness on the surface...?" },
		},

		PreRevealVoiceLines =
		{
			{
				PreLineWait = 0.05,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_0178", Text = "Now..." },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_2576", Text = "{#Emph}My blood is bound by fate, yet blood runs free; \n {#Emph}As it would spill upon the surface, I must be." },
			}
		},
	},
	WorldUpgradeNarcissusWaters =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "KeyItem_SealedDoc",
		Cost =
		{
			PlantGCattail = 3,
			PlantOMandrake = 3,
			MixerHBoss = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters04_2" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3071", Text = "I owe Narcissus crystal clarity..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3072", Text = "{#Emph}Where once shone beautiful a flower's soul, \n {#Emph}Run clear again, you waters; make him whole." },
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
	WorldUpgradeKeepsakeSaveFirst =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_favorite",
		Cost =
		{
			PlantIShaderot = 2,
			SuperGiftPoints = 1,
			PlantPIris = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBoonList" },
			},
			-- number of Keepsake unlocks required
			{
				Path = { "GameState", "GiftPresentation" },
				UseLength = true,
				Comparison = ">=",
				Value = 24,
			},
		},
	},
	WorldUpgradeResourceFinder =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
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
	},
	WorldUpgradeMetaUpgradeSaveLayout =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_altar",
		Cost =
		{
			MetaCardPointsCommon = 30,
			PlantPOlive = 2,
		},
		GameStateRequirements =
		{
			-- Force = true,
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeCardUpgradeSystem" },
			},
			{
				Path = { "GameState", "MaxMetaUpgradeCostCache" },
				Comparison = ">=",
				Value = 28,
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "CardUpgradePoints" },
				Comparison = ">=",
				Value = 10,
			},
		},
	},
	WorldUpgradeElementalBoons =
	{
		InheritFrom = { "DefaultHubItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_element",
		Cost =
		{
			MemPointsCommon = 5,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZeusFirstPickUp" },
			},
			{
				PathTrue = { "GameState", "RoomCountCache", "G_Boss01" },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3505", Text = "{#Emph}Within the Boons of Mount Olympus I would see \n {#Emph}Their elemental essences, my victory." },
			},
		},
	},
	WorldUpgradeBoonList =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_codex",
		Cost =
		{
			SuperGiftPoints = 1,
			MixerOBoss = 1,
			PlantIPoppy = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "Codex" },
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll =
				{
					"ZeusGift01",
					"HeraGift01",
					"PoseidonGift01",
					"ApolloGift01",
					"DemeterGift01",
					"AphroditeGift01",
					"HephaestusGift01",
					"HestiaGift01",
					"HermesGift01",
					"ChaosGift01",
					"ArtemisGift01",
				},
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
		InspectPointId = 576166,

		PreRevealVoiceLines =
		{
			[1] = { GlobalVoiceLines = "AddingReagentVoiceLines" },
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
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_brokersell",
		Cost =
		{
			MetaCardPointsCommon = 1,
			--PlantFMoly = 1,
			--PlantFNightshade = 1,
			PlantMoney = 1,
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
				Path = { "GameState", "LifetimeResourcesGained", "PlantMoney" },
				Comparison = ">=",
				Value = 1,
			},
		},

		PostActivationThreadedFunctionName = "WretchedBrokerReaction",
		PostActivationThreadedFunctionArgs = { Delay = 1.0 },

		PanDuration = 1.25,
		PanHoldDuration = 1.0,
		CameraFocusId = 558096,
	},

	WorldUpgradeGiftsShop =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_brokerexotic",
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

		PanDuration = 1.25,
		PanHoldDuration = 2.0,
		CameraFocusId = 558096,
	},

	WorldUpgradeExchangeShop =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_sell",
		AlwaysRevealImmediately = true,

		Cost =
		{
			MetaCurrency = 100,
		},
		GameStateRequirements =
		{
			NamedRequirements = { "CosmeticsShopUnlocked", },
		},

		PostActivationThreadedFunctionName = "WretchedBrokerReaction",
		PostActivationThreadedFunctionArgs = { Delay = 1.0 },

		PanDuration = 1.25,
		PanHoldDuration = 1.0,
		CameraFocusId = 558096,
	},

	-- Aspects System
	WorldUpgradeWeaponUpgradeSystem =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_aspect",
		AlwaysRevealImmediately = true,

		Cost =
		{
			OreNBronze = 5,
			PlantFNightshade = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "HecateBossGrantsWeaponUpgradeSystem01", "HecateGrantsWeaponUpgradeSystem01" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

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
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3488", Text = "Our Altar can be purified..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
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
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },
		Cost =
		{
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
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3444", Text = "Through the knowledge of Almighty Chaos, I can see into the void..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3074", Text = "{#Emph}As ancient Chaos beckoned me to say, \n {#Emph}Awake, O monument of Night; I shall obey!" },
			},
		},
	},
	WorldUpgradeBountyBoardRepeat =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bounty2",
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },
		Cost =
		{
			PlantFMoly = 6,
			MetaFabric = 2,
			OreChaosProtoplasm = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
			},
			{
				Path = { "GameState", "PackagedBountyClears" },
				UseLength = true,
				Comparison = ">=",
				Value = 6,
			},
		},
		CameraFocusId = 424956,
		PanDuration = 1.5,
		PanHoldDuration = 1.0,
	},
	WorldUpgradeFamiliarSystem =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_familiar",
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
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

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
		OnActivateFinishedFunctionArgs = { ResourceName = "FamiliarPoints", ResourceAmount = 3, SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },
	},
	WorldUpgradeFamiliarRest =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_familiargroup",
		Cost =
		{
			PlantPOlive = 3,
			MixerHBoss = 1,
		},
		GameStateRequirements =
		{
			{
				PathEmpty = { "CurrentRun", "FamiliarsUnlocked" },
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "FamiliarPoints" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},
	WorldUpgradeFamiliarUpgradeSystem =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_familiar2",
		Cost =
		{
			PlantHWheat = 3,
			MixerNBoss = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeFamiliarRest", "WorldUpgradeFamiliarSystem" }
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "FamiliarPoints" },
				Comparison = ">=",
				Value = 3,
			},
		},

		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "FamiliarPoints", ResourceAmount = 1, SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },
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
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeWeaponUpgradeSystem", "WorldUpgradeElementalBoons" },
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
	WorldUpgradePostBossSellTraitShops =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_well",
		Cost =
		{
			PlantIShaderot = 2,
			OreOIron = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "SellTraits" }
			},
			{
				Path = { "GameState", "TraitsSold", },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 1,
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
				PathTrue = { "GameState", "RoomsEntered", "G_Intro" },
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
				Path = { "GameState", "RoomsEntered" },
				HasAll = { "I_Story01", "I_PreBoss01" },
			},
		},
	},
	WorldUpgradeThessalyReprieve =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_ships",
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
				PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
			},
		},
	},
	WorldUpgradeOlympusReprieve =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_ships",
		Cost =
		{
			PlantPIris = 3,
			OrePAdamant = 3,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeThessalyReprieve" },
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
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
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_urn",
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
				Value = 2000,
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

	--[[
	-- Remember that Time cannot be stopped; merely put on hold. -C.
	WorldUpgradePauseChronosFight =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_chronos",
		Cost =
		{
			MixerIBoss = 3,
			PlantFMoly = 3,
		},

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
	]]

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
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeResourceFinder" },
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
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_wardingcircle2",
		Cost =
		{
			OreFSilver = 2,
			PlantPIris = 2,
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
				HasAll = { "WorldUpgradeUnusedWeaponBonus", "WorldUpgradeShadeMercs", "WorldUpgradeChallengeSwitches1", "WorldUpgradeSurfaceShops", "WorldUpgradePostBossSurfaceShops" },
			},
		},
	},

	WorldUpgradeSafeZoneSpellCharge =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_wardingcircle",
		Cost =
		{
			PlantFNightshade = 4,
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

	WorldUpgradeChallengeSwitchesSurface1 =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_trove",
		Cost =
		{
			PlantOMandrake = 1,
			OreOIron = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "O_Boss01" },
			},
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeSurfacePenaltyCure", "WorldUpgradeChallengeSwitches1" },
			},
		},
	},

	WorldUpgradeChallengeSwitchesExtra1 =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_challengeswitch",
		Cost =
		{
			OreHGlassrock = 2,
			OrePAdamant = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
			},
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeChallengeSwitches1", "WorldUpgradeChallengeSwitchesSurface1" },
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

	WorldUpgradeMetaCardPointsCommonRunProgress =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_rewardash",
		Cost =
		{
			PlantGCattail = 3,
			MetaCardPointsCommon = 50,
			MixerGBoss = 3,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 530,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 2500,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 5300,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 35,
			},
		},
	},

	WorldUpgradeMemPointsCommonRunProgress =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_rewardpsyche",
		Cost =
		{
			PlantOMandrake = 3,
			MemPointsCommon = 100,
			MixerFBoss = 3,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 530,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 2500,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 5300,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 35,
			},
		},
	},

	WorldUpgradeMetaCurrencyRunProgress =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_rewardbones",
		Cost =
		{
			PlantHWheat = 3,
			MetaFabric = 3,
			MixerHBoss = 3,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 530,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 2500,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 5300,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 35,
			},
		},
	},

	WorldUpgradeGiftDropRunProgress =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_rewardnectar",
		Cost =
		{
			PlantNGarlic = 3,
			GiftPoints = 3,
			MixerNBoss = 3,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 530,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
				Comparison = ">=",
				Value = 2500,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 5300,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 35,
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
		NumPlots = 2, -- Used only for text
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
			PlantNMoss = 5,
			PlantHWheat = 5, 
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
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGardenT3" },
			},
		},
	},
	WorldUpgradeGardenT2 =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_soil",
		NumPlots = 2, -- Used only for text
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
		NumPlots = 2, -- Used only for text
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
		NumPlots = 2, -- Used only for text
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
		NumPlots = 2, -- Used only for text
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
		InspectPointId = 589547,
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
		InspectPointId = 589548,
	},
	-- Music Player
	WorldUpgradeMusicPlayer =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },

		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bard",
		Cost =
		{
			MixerHBoss = 1,
			PlantGLotus = 2,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeTaverna" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraGrantsCosmeticsShop01" }
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "CosmeticsPoints" },
				Comparison = ">=",
				Value = 500,
			},
		},

		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_3673", Text = "Everyone please welcome our new Music Maker here!", PostLineFunctionName = "MusicMakerReaction" },
		},

		ActivateRoomObstacleIds = { 738510 },
		ActivateGroups = { "MusicianDecor" },
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPointId = 738760,
	},
	
	WorldUpgradeRelationshipBar =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_relationship",
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
	WorldUpgradeWakeHypnos =
	{
		InheritFrom = { "DefaultHubItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_hypnos",
		AlwaysRevealImmediately = true,

		Cost =
		{
			PlantFMoly = 1,
			PlantOMandrake = 2,
			PlantIPoppy = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HypnosAboutPoppies01" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3679", Text = "A means to wake Lord Hypnos, possibly..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3680", Text = "{#Emph}Sleep is not Death, for the sleeping awake..." },
			},
		},

		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		CameraFocusId = 370024, -- Hypnos

		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "HypnosPoints", SoundName = "/Leftovers/Menu Sounds/TalismanPaperEquipLEGENDARY" },
	},

	WorldUpgradeDoraMemory =
	{
		InheritFrom = { "DefaultHubItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_dora",
		AlwaysRevealImmediately = true,

		Cost =
		{
			MixerShadow = 9999,
			MixerPBoss = 9999,
			MixerMythic = 9999,
		},
		CostAmountTextIds =
		{
			MixerShadow = "MysteryResource",
			MixerPBoss = "MysteryResource",
			MixerMythic = "MysteryResource",
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraAboutPrometheus04" }
			},
		},

		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		CameraFocusId = 370024, -- Hypnos

		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "HypnosPoints", SoundName = "/Leftovers/Menu Sounds/TalismanPaperEquipLEGENDARY" },
	},

	-- hub expansions
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

	-- alchemy / cooking recipes
	WorldUpgradeMixerShadow =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_MixerShadow",
		Cost =
		{
			--MetaCurrency = 50,
			MetaFabric = 3,
			MetaCardPointsCommon = 30,
			MemPointsCommon = 30,
		},
		CookTime = 12,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "MixerShadow", ResourceAmount = 1, WaitTime = 0.4, SoundName = "/Leftovers/Menu Sounds/TitanToggleLong" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			NamedRequirements = { "AlchemyUnlocked" },
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_2609", Text = "I need pure Shadow to permeate the surface wards... so what if...?" },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_2612", Text = "{#Emph}Essences of Shadow, to the surface rise." },
			},
		},

		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeFamiliarPoints =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_FamiliarPoints",
		Cost =
		{
			PlantGLotus = 2,
			Mixer5Common = 1,
		},
		CookTime = 14,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "FamiliarPoints", ResourceAmount = 2, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarSystem" }
			},
			{
				Path = { "GameState", "FamiliarsUnlocked" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3144", Text = "With this Star Dust I could form an immutable bond with a beast that has affinity for me..." }
		},

		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeCardUpgradePoints =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_CardUpgradePoints",
		Cost =
		{
			MixerFBoss = 1,
			MixerShadow = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
			},
		},
		CookTime = 8,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "CardUpgradePoints", ResourceAmount = 5, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

		IgnoreAffordable = true,

		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeCardUpgradePoints2 =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_CardUpgradePoints",
		Cost =
		{
			Mixer5Common = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "FamiliarPoints" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "Mixer5Common" },
				Comparison = ">=",
				Value = 3,
			},
			{
				PathTrue = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
			},
		},
		CookTime = 4,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "CardUpgradePoints", ResourceAmount = 3, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

		IgnoreAffordable = true,
		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeNectar =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "CosmeticIcon_Nectar",
		Cost =
		{
			MixerOBoss = 1,
		},
		CookTime = 8,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "GiftPoints", ResourceAmount = 3, SoundName = "/SFX/GiftAmbrosiaBottlePickup" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutNectar01", },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_1082", Text = "{#Emph}Come savor, unrivaled from heights of Olympus, to depths of the sea!" }
			},
		},
		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
}