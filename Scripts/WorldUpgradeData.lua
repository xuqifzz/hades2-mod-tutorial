WorldUpgradeData =
{
	DefaultCriticalItem =
	{
		DebugOnly = true,
		Cost =
		{
		},

		IncantationRepeatableVoiceLines =
		{
			{ GlobalVoiceLines = "AlchemyStartVoiceLines" },
		},

		IncantationDuration = 17,
		IncantationAnimation = "MelinoeCauldronIncantationComplete",
		IncantationAnimationSpeed = 1.0,
		IncantationPunctuation = 2.1,
		IncantationBackgroundAnimation = "GhostAdminScreenCauldronConfirmMinor",
		IncantationAspectRatioFramesHideDelay = 0.0,
		IncantationCameraPanDuration = 0.4,
		IncantationCameraPanEaseIn = 0.05,
		IncantationCameraPanEaseOut = 0.2,
	},

	DefaultMajorItem =
	{
		IncantationDuration = 17.5,
		IncantationAnimation = "MelinoeCauldronIncantationComplete",
		IncantationAnimationSpeed = 0.85,
		IncantationPunctuation = 1.9,
		IncantationBackgroundAnimation = "GhostAdminScreenCauldronConfirm",
		IncantationAspectRatioFramesHideDelay = 0.33,
		IncantationCameraPanDuration = 1.0,
		IncantationCameraPanEaseIn = 0.05,
		IncantationCameraPanEaseOut = 0.3,

		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "AddingReagentVoiceLines" },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,

				{ Cue = "/VO/Melinoe_0528", Text = "{#Emph}Shades of the dead, reagents in the pot, \n {#Emph}Heed now my plea, become what I have sought." },
				{ Cue = "/VO/Melinoe_0530", Text = "{#Emph}By moonlight and the dust of ancient bone, \n {#Emph}Awaken in this cauldron the unknown." },
				{ Cue = "/VO/Melinoe_0531", Text = "{#Emph}Fire and Earth, between heaven and hell, \n {#Emph}Make manifest my thoughts; complete my spell." },
				{ Cue = "/VO/Melinoe_1078", Text = "{#Emph}I ask of you, Spirits of Earth and Night, \n {#Emph}To take away this pain, that we may fight!" },
				{ Cue = "/VO/Melinoe_1079", Text = "{#Emph}Upon my birthright, I command the Dark \n {#Emph}to aid my task and with me find my mark." },
				{ Cue = "/VO/Melinoe_1080", Text = "{#Emph}Hear me, O Shades, on my authority: \n {#Emph}Give my demand all due priority." },
				{ Cue = "/VO/Melinoe_1081", Text = "{#Emph}If Time cannot be stopped, then we shall see; \n {#Emph}If spill my blood I must, so mote it be...!" },
			},
		},

		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
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
			-- { GlobalVoiceLines = "AddingReagentVoiceLines" },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,

				{ Cue = "/VO/Melinoe_0532", Text = "{#Emph}Dark of Chaos, light of Moon, heed now my will!" },
				{ Cue = "/VO/Melinoe_0533", Text = "{#Emph}Great Tree of Life, please listen to my thoughts!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_0534", Text = "{#Emph}By light of moon, together let us shape reality!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1070", Text = "{#Emph}Boil, bounties of the Earth; grant what I seek!" },
				{ Cue = "/VO/Melinoe_1071", Text = "{#Emph}Come, Spirits of the Dead, I have a task for you!" },
				{ Cue = "/VO/Melinoe_1072", Text = "{#Emph}As the Three Fates would have it, so shall I...!" },
				{ Cue = "/VO/Melinoe_1073", Text = "{#Emph}Great mother Gaia, listen to my heart's desire!" },
				{ Cue = "/VO/Melinoe_1074", Text = "{#Emph}My choice is hereby made, my path is set!" },
				{ Cue = "/VO/Melinoe_1075", Text = "{#Emph}By blood and darkness, let my will be done!" },
			},
		},

		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
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
				{ Cue = "/VO/Melinoe_1077", Text = "{#Emph}Askion kataski!" },
				{ Cue = "/VO/Melinoe_1077_V2", Text = "{#Emph}Askion kataski!" },
				{ Cue = "/VO/Melinoe_2610", Text = "{#Emph}Damname aision!" },
				{ Cue = "/VO/Melinoe_2611", Text = "{#Emph}Damnaski traxon!" },
			},
		},

		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
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
			{ GlobalVoiceLines = "AlchemyStartVoiceLines" },
		},
	},

	EndGameItem = 
	{
		CauldronCastFxAnimation = "CauldronEndSpellSequence",
		CauldronVignetteAnimation = "CauldronEndSpellVignette",
		ExtraHoldBeforeUnlockText = 4.0,
		CauldronFxGroup = "Combat_UI_World",
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
			},
			--[[
			{
				PathTrue = { "GameState", "ScreensViewed", "QuestLog" },
			},
			]]--
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

		UnthreadPreRevealVoiceLines = true,
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
	-- time cannot be stopped; not now at least, or perhaps ever...
	-- Dissolution of Time (DoT)
	WorldUpgradeTimeStop =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem", "EndGameItem", },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_chronos",
		AlwaysRevealImmediately = true,
		Cost =
		{
			MixerIBoss = 7,
			MixerMythic = 1,
		},

		GameStateRequirements =
		{
			OrRequirements =
			{
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
				{
					-- unlocked from the start for resets
					{
						Path = { "GameState", "StoryResetCount" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
		},

		OnActivateFinishedFunctionName = "UnblockHubExitForNarrative",

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_2823", Text = "{#Emph}Death to Chronos... {#Prev}there has to be a way..." },
		},

		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			ObjectType = "NPC_Hecate_01",
			-- RequiredSourceValueFalse = "InPartnerConversation",

			{ Cue = "/VO/Hecate_0174", Text = "You may proceed.", PreLineAnim = "Hecate_Hub_Affirm" },
			-- { Cue = "/VO/Hecate_0179", Text = "Now say the words." },
			-- { Cue = "/VO/Hecate_0180", Text = "Now, say the words."	},
		},
		IncantationAnimationSpeed = 0.75,
		IncantationVoiceLines =
		{
			{
				PreLineWait = 1.3,
				{ Cue = "/VO/Melinoe_4740", Text = "{#Emph}Time overstepped his bounds, which cannot stand; \n {#Emph}He shall be stopped as the Three Fates had planned!" },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionFollowUpVoiceLines" },
		},
	},
	-- the father of all monsters can never be destroyed; certainly not at this time
	-- Disintegration of Monstrosity (DoM)
	WorldUpgradeStormStop =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem", "EndGameItem", },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_typhon",
		AlwaysRevealImmediately = true,
		Cost =
		{
			MixerIBoss = 1,
			MixerQBoss = 4,
			HadesSpearPoints = 1,
		},

		GameStateRequirements =
		{
			OrRequirements =
			{
				{
					-- three paths to stop the storm
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny =
						{
							-- returned from Typhon, after ZagreusPastMeeting02 & ZeusPalaceMeeting02; clear not required
							"HecateAboutStormStop01",

							-- significant wins against Chronos, some vs. Typhon, returned from Typhon; requires ZagreusPastMeeting05 via HecateAboutChronosBossW04_B
							"HecateAboutStormStop01_B",

							-- after ZagreusPastMeeting05, if you have ZeusPalaceMeeting02
							"HecateAboutChronosBossW04"
						},
					},
				},
				{
					-- unlocked from the start for resets
					{
						Path = { "GameState", "StoryResetCount" },
						Comparison = ">=",
						Value = 1,
					},
				},
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_4069", Text = "Typhon does not belong in this world..." },
		},

		PreRevealVoiceLines =
		{
			PreLineWait = 0.25,
			ObjectType = "NPC_Hecate_01",
			-- RequiredSourceValueFalse = "InPartnerConversation",

			-- { Cue = "/VO/Hecate_0174", Text = "You may proceed." },
			{ Cue = "/VO/Hecate_0179", Text = "Now say the words.", PreLineAnim = "Hecate_Hub_Affirm" },
			-- { Cue = "/VO/Hecate_0180", Text = "Now, say the words."	},
		},
		IncantationVoiceLines =
		{
			{
				PreLineWait = 1.3,
				{ Cue = "/VO/Melinoe_4739", Text = "{#Emph}Your rage, Monster, shall spill from you like blood; \n {#Emph}Your life force all consumed within that flood!" },
			},
		},
		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionFollowUpVoiceLines" },
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
			{ GlobalVoiceLines = "InvalidResourceInteractionVoiceLines" },
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
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem", },
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
				{ Cue = "/VO/Melinoe_2576", Text = "{#Emph}My blood is bound by fate, yet blood runs free. \n {#Emph}Release me from this realm; become my key!" },
			}
		},

		RevealReactionVoiceLines = 
		{
			{ GlobalVoiceLines = "CauldronReactionVoiceLines" },
			{ GlobalVoiceLines = "CauldronReactionFollowUpVoiceLines" },
		},
	},
	WorldUpgradeNarcissusWaters =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_narcissus",
		Cost =
		{
			PlantGCattail = 3,
			PlantOMandrake = 3,
			Mixer5Common = 2,
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

		UnthreadPreRevealVoiceLines = true,
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.45,
				{ Cue = "/VO/Melinoe_3072", Text = "{#Emph}Where once shone beautiful a flower's soul, \n {#Emph}Run clear again, you waters; make him whole." },
			},
		},
	},

	WorldUpgradeMedeaTears =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_tears",
		AlwaysRevealImmediately = true,
		Cost =
		{
			MixerHBoss = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "Flags", "AcquiredMixerForMedeaQuest" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_4824", Text = "Lady Medea needs this for who-only-knows..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_4825", Text = "{#Emph}Boil, Tears of Sorrow, and return to your essential form." },
			},
		},

		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "MedeaPoints", ResourceAmount = 1, WaitTime = 0.4, SoundName = "/SFX/SuperGemPickup" },
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
	WorldUpgradePinningBoons =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_reminder",
		Cost =
		{
			MetaFabric = 2,
			PlantQSnakereed = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradePinning", "WorldUpgradeBoonList" }
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "GameState", "ClearedSurfaceRunsCache" },
				Comparison = ">=",
				Value = 2,
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
			PlantPIris = 2,
		},
		GameStateRequirements =
		{
			-- number of Keepsake unlocks required
			{
				Path = { "GameState", "GiftPresentation" },
				UseLength = true,
				Comparison = ">=",
				Value = 22,
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
				Value = 15,
			},
		},
	},

	WorldUpgradeElementalBoons =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_element",
		Cost =
		{
			MemPointsCommon = 5,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "MetaUpgradeLimitLevel", },
				Comparison = ">=",
				Value = 3,
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "ZeusFirstPickUp" },
			},
			{
				PathTrue = { "GameState", "RoomCountCache", "H_Boss01" },
			},
		},

		PreRevealVoiceLines =
		{
			-- { GlobalVoiceLines = "AddingReagentVoiceLines" },
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
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_codex",
		Cost =
		{
			SuperGiftPoints = 1,
			MetaFabric = 3,
		},
		GameStateRequirements =
		{
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
				},
			},
		},
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5595", Text = "{#Emph}Reveal within my Book of Shadows greater knowledge that I seek..." },
			},
		},
	},

	WorldUpgradeBossDifficultyT2 =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_em",
		Cost =
		{
			MixerGBoss = 2,
			MixerOBoss = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll = { "BossHecate02", "BossPolyphemus02" },
			},
			{
				Path = { "GameState", "EncountersOccurredCache" },
				HasAll = { "MiniBossCharybdis" },
			},
			{
				Path = { "GameState", "EnemyKills", "Scylla" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "GameState", "EnemyKills", "Eris" },
				Comparison = ">=",
				Value = 3,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.85,
				{ Cue = "/VO/Melinoe_5597", Text = "{#Emph}By will of Night shall I confront still-greater rivals now..." },
			},
		},
	},
	WorldUpgradeBossDifficultyT3 =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_em",
		Cost =
		{
			MixerHBoss = 2,
			MixerPBoss = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll = { "BossScylla02", "BossEris02" },
			},
			{
				Path = { "GameState", "EnemyKills", "InfestedCerberus" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "GameState", "EnemyKills", "Prometheus" },
				Comparison = ">=",
				Value = 3,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.85,
				{ Cue = "/VO/Melinoe_5598", Text = "{#Emph}By will of Night shall I confront my fiercest foes..." },
			},
		},
	},
	WorldUpgradeBossDifficultyT4 =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_em",
		Cost =
		{
			Mixer6Common = 1,
			MixerIBoss = 2,
			MixerQBoss = 2,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" }
			},
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll = { "BossInfestedCerberus02", "BossPrometheus02" },
			},
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "GameState", "EnemyKills", "TyphonHead" },
				Comparison = ">=",
				Value = 3,
			},

			-- Player has reached the Chronos fight after the True Ending
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutTartarus01_B" },
			},

			-- Player has reached the Typhon biome after the True Ending
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "NeoChronosAboutOlympus01", "NeoChronosAboutOlympus01_B" },
			},
		},
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5599", Text = "{#Emph}By will of Night shall I confront the worst perils of all." },
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
			MetaFabric = 3,
			PlantNGarlic = 1,
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
				Path = { "GameState", "FishingSuccesses" },
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
				{ Cue = "/VO/Melinoe_3073", Text = "{#Emph}O Altar of Ashes beneath which I stand, \n {#Emph}Fulfill your purpose that I know firsthand." },
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

		UnthreadPreRevealVoiceLines = true,
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
			Mixer6Common = 1,
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

		-- UnthreadPreRevealVoiceLines = true,
		SkipPreRevealVoiceLines = true,
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3506", Text = "{#Emph}To all my beast companions near and far, \n {#Emph}Let us protect each other, soul and scar." },
			},
		},

		OnActivateFinishedFunctionName = "FamiliarPointsGiftedPresentation",
		OnActivateFinishedFunctionArgs =
		{
			ResourceName = "FamiliarPoints",
			ResourceAmount = 3,
			SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY",
			VoiceLines =
			{
				PreLineWait = 0.75,

				{ Cue = "/VO/Melinoe_5722", Text = "Frinos shall enjoy these..." },
			},
		},
	},
	WorldUpgradeFamiliarUpgradeSystem =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
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
				HasAll = { "WorldUpgradeFamiliarSystem" }
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "FamiliarPoints" },
				Comparison = ">=",
				Value = 4,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5600", Text = "{#Emph}As my Familiars are a source of strength, so may we all grow strong!" },
			},
		},

		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "FamiliarPoints", ResourceAmount = 3, SoundName = "/Leftovers/Menu Sounds/TalismanRockUpLEGENDARY" },
	},
	WorldUpgradeFamiliarCostumeSystem =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_costume",
		Cost =
		{
			MetaFabric = 6,
			MixerNBoss = 6,
			OreChaosProtoplasm = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "CirceGrantsFamiliarCostumes01" }
			},
		},
		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_5436", Text = "The metamorphosis technique from Madame Circe..." },
		},
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5437", Text = "{#Emph}May my Familiars take on unfamiliar forms if they so choose!" },
			},
		},
	},

	WorldUpgradeToolUpgradeSystem =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_pool",
		Cost =
		{
			OreHGlassrock = 4,
			OreIMarble = 4,
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

		UnthreadPreRevealVoiceLines = true,
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3507", Text = "{#Emph}Night's Craftwork, you revealed yourselves to me; \n {#Emph}Your true connection to the Earth, I see." },
			},
		},
	},

	WorldUpgradeChangeNextRunRNG =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_oathreroll",
		Cost =
		{
			MetaFabric = 7,
			MixerIBoss = 7,
			MixerQBoss = 7,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeBoonList", "WorldUpgradeKeepsakeSaveFirst", "WorldUpgradeMetaUpgradeSaveLayout" }
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
			},
			{
				Path = { "GameState", "EnemyKills", "Chronos" },
				Comparison = ">=",
				Value = 7,
			},
			{
				Path = { "GameState", "EnemyKills", "TyphonHead" },
				Comparison = ">=",
				Value = 7,
			},
			NamedRequirements = { "ReachedEpilogue" },
		},
		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_5565", Text = "Inspiration from the Fates themselves..." },
		},

		UnthreadPreRevealVoiceLines = true,
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_0529", Text = "{#Emph}O essences of Chaos, heed my voice, \n {#Emph}In your potential I have made my choice." },
			},
		},

	},

	-- run upgrades
	WorldUpgradeWellShops =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_well",
		Cost =
		{
			PlantFMoly = 1,
			PlantFNightshade = 2,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "CharonPoints", },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "Money", },
				Comparison = ">=",
				Value = 1840,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5601", Text = "{#Emph}Long-dormant Wells of Charon, rise again into the night!" },
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
			PlantGCattail = 1,
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
			OreHGlassrock = 1,
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
			{
				SumPrevRuns = 2,
				Path = { "WorldUpgradesAdded", "WorldUpgradeWellShops" },
				CountPathTrue = true,
				IgnoreCurrentRun = true,
				Comparison = "<",
				Value = 1,
			},
		},
	},
	WorldUpgradeSurfaceShops =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
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

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5602", Text = "{#Emph}May all the travel shrines of swift Lord Hermes re-emerge!" },
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
	WorldUpgradeRestoreSellTraitShop =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_selltrait",
		Cost =
		{
			PlantIShaderot = 2,
			OreOIron = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "H_PostBoss01" },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5603", Text = "{#Emph}Flow red again, O Purging Pool of Tartarus!" },
			},
		},
	},
	WorldUpgradePostBossSellTraitShops =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_selltrait",
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

		PreRevealVoiceLines =
		{
			-- { GlobalVoiceLines = "AddingReagentVoiceLines" },
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
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSellShop" },
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
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_olympus",
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
			PlantGCattail = 3,
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
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
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

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5604", Text = "{#Emph}Whatever gleams with Gold shall soon be found!" },
			},
		},
	},
	WorldUpgradeEphyraZoomOut =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
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

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.25,
				{ Cue = "/VO/Melinoe_5605", Text = "{#Emph}Return, All-Seeing Bats, and hear the City of the Dead!" },
			},
		},
	},

	WorldUpgradeFieldsRewardFinder =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bough",
		Cost =
		{
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
			PreLineWait = 0.35,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_2783", Text = "How to find my way in the Mourning Fields..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5606", Text = "{#Emph}May Boughs throughout the Mourning Fields revive!" },
			},
		},
	},

	WorldUpgradeTimeSlowChronosFight =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_hourglass",
		Cost =
		{
			PlantIShaderot = 2,
			PlantFMoly = 2,
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

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5607", Text = "{#Emph}Time cannot be withstood, not even by itself." },
			},
		},
	},

	WorldUpgradePauseChronosFight =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_chronos",
		Cost =
		{
			MixerIBoss = 3,
			PlantFMoly = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" }
			},
			{
				Path = { "GameState", "SpeechRecord" },
				HasAny = { "/VO/Chronos_0563_B" }
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "ChronosBossAboutAltFight01", "TyphonHeadAltFight01" },
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_3070", Text = "Time thinks he can't be stopped. I think otherwise." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5608", Text = "{#Emph}My Time belongs to me and no one else." },
			},
		},
	},

	WorldUpgradeUnusedWeaponBonus =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
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
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_1598" },
				},
			},

			{ Cue = "/VO/Melinoe_2822", Text = "The Arms of Night seek something more from me..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5609", Text = "{#Emph}Come, Darkness, mark the Arms of Night within my care!" },
			},
		},
	},
	WorldUpgradeUnusedWeaponBonusT2 =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bonesgems",
		Cost =
		{
			OreIMarble = 2,
			MetaFabric = 3,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeExchangeShop" },
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent", "CosmeticsPoints" },
				Comparison = ">=",
				Value = 100,
			},
			{
				Path = { "GameState", "ClearedUnderworldRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll = { "BossEris01" },
			},
			{
				SumPrevRuns = 2,
				Path = { "WorldUpgradesAdded", "WorldUpgradeExchangeShop" },
				CountPathTrue = true,
				IgnoreCurrentRun = true,
				Comparison = "<",
				Value = 1,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5610", Text = "{#Emph}Arms of Night, draw out the riches of the Earth!" },
			},
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

	WorldUpgradeDoubleAdvanceKeepsakes =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_keepsakes",
		BonusRate = 100, -- used only for text
		Cost =
		{
			PlantNMoss = 4,
			GiftPointsEpic = 1,
		},
		GameStateRequirements =
		{
			-- this counts number of Keepsakes acquired
			{
				Path = { "GameState", "GiftPresentation" },
				UseLength = true,
				Comparison = ">=",
				Value = 23,
			},
		},

		PreRevealVoiceLines =
		{
			-- { GlobalVoiceLines = "AddingReagentVoiceLines" },
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

		PreRevealVoiceLines =
		{
			-- { GlobalVoiceLines = "AddingReagentVoiceLines" },
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
			{
				SumPrevRuns = 2,
				Path = { "WorldUpgradesAdded", "WorldUpgradeErebusSafeZones" },
				CountPathTrue = true,
				IgnoreCurrentRun = true,
				Comparison = "<",
				Value = 1,
			},
			{
			    Path = { "GameState", "ProjectileRecord", "SafeZoneDefense" },
			    Comparison = ">=",
			    Value = 5,
			},
		},

		PreRevealVoiceLines =
		{
			-- { GlobalVoiceLines = "AddingReagentVoiceLines" },
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

	WorldUpgradeOlympusStatues =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_statue",
		Cost =
		{
			OreQScales = 4,
			MixerFBoss = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgrades" },
				HasAll = { "WorldUpgradeOlympusReprieve" },
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "Q_Intro" },
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.55,
				{ Cue = "/VO/Melinoe_5611", Text = "{#Emph}Gods and Goddesses upon Olympus, fight!" },
			},
		},
	},

	WorldUpgradeChallengeSwitches1 =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
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

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.55,
				{ Cue = "/VO/Melinoe_5612", Text = "{#Emph}The stolen Troves of Hades all shall rise!" },
			},
		},
	},

	WorldUpgradeChallengeSwitchesSurface1 =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_trove",
		Cost =
		{
			OreGLime = 1,
			OreOIron = 2,
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

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5613", Text = "{#Emph}Come, Night, reveal the guarded treasures of this realm!" },
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
		PreRevealVoiceLines =
		{
			-- { GlobalVoiceLines = "AddingReagentVoiceLines" },
		},
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_3508", Text = "{#Emph}Hear me Selene, if you so desire: \n {#Emph}Aid me in finding that which I require!" },
			},
		},
	},

	WorldUpgradeMetaRewardStands =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_metarewardstand",
		Cost =
		{
			OreHGlassrock = 6,
			OreQScales = 6,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered" },
				HasAll = { "I_Boss01", "Q_Boss01" },
			},
			OrRequirements =
			{
				{
					{
						Path = { "GameState", "HighestShrinePointClearUnderworldCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
				{
					{
						Path = { "GameState", "HighestShrinePointClearSurfaceCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.75,
				{ Cue = "/VO/Melinoe_5614", Text = "{#Emph}Only the fearless are deserving of the Gifts of Night!" },
			},
		},
	},

	WorldUpgradeMetaCardPointsCommonRunProgress =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_rewardash",
		Cost =
		{
			PlantGCattail = 4,
			MetaCardPointsCommon = 60,
			Mixer5Common = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 800,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 7500,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 50,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.75,
				{ Cue = "/VO/Melinoe_5615", Text = "{#Emph}May Ashes of the Past awaken newfound strength!" },
			},
		},

	},

	WorldUpgradeMetaCurrencyRunProgress =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_rewardbones",
		Cost =
		{
			PlantHWheat = 2,
			MetaFabric = 10,
			Mixer5Common = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 800,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 7500,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 50,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.75,
				{ Cue = "/VO/Melinoe_5617", Text = "{#Emph}May dust of ancient Bone infuse the soul!" },
			},
		},
	},

	WorldUpgradeGiftDropRunProgress =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_rewardnectar",
		Cost =
		{
			PlantNGarlic = 8,
			GiftPoints = 2,
			Mixer5Common = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCardPointsCommon" },
				Comparison = ">=",
				Value = 800,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "MetaCurrency" },
				Comparison = ">=",
				Value = 7500,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
				Comparison = ">=",
				Value = 50,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.75,
				{ Cue = "/VO/Melinoe_5616", Text = "{#Emph}May Nectar of the Gods bring greater blessings still!" },
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
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5596", Text = "{#Emph}Great Night, reveal now your works within our Silver Pool!" },
			},
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

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5619", Text = "{#Emph}Great Gaia, share your secrets if my worth is true!" },
			},
		},

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
	WorldUpgradeHarvestUpgrade =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_flora",
		SeedChance = 0.35,
		SimpleExtractValues =
		{
			{
				Property = "SeedChance",
				Multiply = 100,
				NewProperty = "SeedChancePercent",
			}
		},
		Cost =
		{
			PlantNMoss = 4,
			PlantHWheat = 4, 
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
			PlantGCattail = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeGarden" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshade" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantGCattail" },
				Comparison = ">=",
				Value = 1,
			},
			OrRequirements =
			{
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantHWheat" },
						Comparison = ">=",
						Value = 1,
					},
				},
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantHWheatSeed" },
						Comparison = ">=",
						Value = 6,
					},
				},
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5618", Text = "{#Emph}Light of Moon, awaken verdant land!" },
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
				Path = { "GameState", "LifetimeResourcesGained", "PlantIPoppy" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantPOlive" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantNGarlic" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantOMandrake" },
				Comparison = ">=",
				Value = 4,
			},
		},

		ActivateRoomObstacleIds = { 583640, 583641 },
		PanDuration = 1.5,
		PanHoldDuration = 1.0,
	},
	WorldUpgradeGardenHarvestAll =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_soil2",
		Cost =
		{
			PlantHWheat = 2,
			PlantQSnakereed = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeGardenT3", "WorldUpgradeHarvestUpgrade" },
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent" },
				SumOf =
				{
					"SeedMystery",
					"PlantFNightshadeSeed",
					"PlantGCattailSeed",
					"PlantHWheatSeed",
					"PlantIPoppySeed",
					"PlantNGarlicSeed",
					"PlantOMandrakeSeed",
					"PlantPOliveSeed",
					"PlantQSnakereedSeed",
					"PlantChaosThalamusSeed",
				},
				Comparison = ">=",
				Value = 90,
			},
		},
	},
	WorldUpgradeGardenMultiPlant =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_soil3",
		Cost =
		{
			PlantPOlive = 2,
			PlantIPoppy = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeGardenT3", "WorldUpgradeHarvestUpgrade" },
			},
			{
				Path = { "GameState", "LifetimeResourcesSpent" },
				SumOf =
				{
					"SeedMystery",
					"PlantFNightshadeSeed",
					"PlantGCattailSeed",
					"PlantHWheatSeed",
					"PlantIPoppySeed",
					"PlantNGarlicSeed",
					"PlantOMandrakeSeed",
					"PlantPOliveSeed",
					"PlantQSnakereedSeed",
					"PlantChaosThalamusSeed",
				},
				Comparison = ">=",
				Value = 90,
			},
		},
	},
	WorldUpgradeAutoHarvestOnExit =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_gather",
		Cost =
		{
			PlantQSnakereed = 3,
			PlantPOlive = 3,
			CardUpgradePoints = 3,
		},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesSpent", "FamiliarPoints" },
				Comparison = ">=",
				Value = 30,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained" },
				CountOf =
				{
					"FishFCommon", "FishFRare", "FishFLegendary",
					"FishGCommon", "FishGRare", "FishGLegendary",
					"FishHCommon", "FishHRare", "FishHLegendary",
					"FishICommon", "FishIRare", "FishILegendary",
					"FishNCommon", "FishNRare", "FishNLegendary",
					"FishOCommon", "FishORare", "FishOLegendary",
					"FishPCommon", "FishPRare", "FishPLegendary",
					"FishQCommon", "FishQRare", "FishQLegendary",
					"FishChaosCommon", "FishChaosRare", "FishChaosLegendary",
				},
				Comparison = ">=",
				Value = 24,
			},
			--[[
			{
				Path = { "GameState", "ExorcisedNames" },
				HasAll =
				{
					"ShadeErebusIdle",
					"ShadeOceanusSIdle",
					"ShadeFieldsGreyIdle",
					"ShadeClockworkIdle",
					"ShadeEphyraIdle",
					"ShadeShipsOneIdle",
					"ShadeTyphonIdle",
				},
			},
			]]
			{
				Path = { "GameState", "LifetimeResourcesGained" },
				HasAll =
				{
					"SeedMystery",
					"PlantFNightshadeSeed",
					"PlantGCattailSeed",
					"PlantHWheatSeed",
					"PlantIPoppySeed",
					"PlantNGarlicSeed",
					"PlantOMandrakeSeed",
					"PlantPOliveSeed",
					"PlantQSnakereedSeed",
					"PlantChaosThalamusSeed",
				},
			},
			{
				Path = { "GameState", "LifetimeResourcesGained" },
				HasAll =
				{
					"OreFSilver",
					"OreGLime",
					"OreHGlassrock",
					"OreIMarble",
					"OreNBronze",
					"OreOIron",
					"OrePAdamant",
					"OreQScales",
					"OreChaosProtoplasm",
				},
			},
			{
				Path = { "GameState", "LifetimeResourcesGained" },
				HasAll =
				{
					"PlantFMoly",
					"PlantGLotus",
					"PlantHMyrtle",
					"PlantIShaderot",
					"PlantNMoss",
					"PlantODriftwood",
					"PlantPIris",
					"PlantQFang",
					"Mixer6Common",
				},
			},
			{
				Path = { "GameState", "ExorcismSuccesses" },
				Comparison = ">=",
				Value = 51,
			},
			{
				Path = { "GameState", "ShovelSuccesses" },
				Comparison = ">=",
				Value = 101,
			},
			{
				Path = { "GameState", "PickaxeSuccesses" },
				Comparison = ">=",
				Value = 101,
			},
			{
				Path = { "GameState", "FishingSuccesses" },
				Comparison = ">=",
				Value = 51,
			},
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5620", Text = "{#Emph}Great mother Gaia, I shall see my debt to you repaid!" },
			},
		},
	},
	-- Learned Sage -- Sage
	WorldUpgradeRunHistory =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },

		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_history",
		Cost =
		{
			OreIMarble = 1,
			MixerHBoss = 1,
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
			MetaFabric = 4,
			PlantIShaderot = 1,
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
				Value = 2,
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
	WorldUpgradeMusicPlayerShuffle =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_bardshuffle",
		Cost =
		{
			PlantIShaderot = 1,
			PlantQFang = 1,
			SeedMystery = 2,
		},

		GameStateRequirements =
		{
			{
				Path = { "GameState", "WorldUpgradesAdded" },
				HasAll = { "WorldUpgradeMusicPlayer" },
			},
			{
				Path = { "GameState", "UnlockedMusicPlayerSongs" },
				UseLength = true,
				Comparison = ">=",
				Value = 5,
			},
		},

		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		CameraFocusId = 738510,
	},
	
	WorldUpgradeRelationshipBar =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_relationship",
		OnPurchasedFunctionName = "CheckQuestStatus",
		OnPurchasedFunctionArgs = { Silent = true, },
		AlwaysRevealImmediately = true,
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
				Value = 9,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantHMyrtle" },
				Comparison = ">=",
				Value = 4,
			},
			{
				FunctionName = "RequireGiftTrackProgress",
				FunctionArgs = { MinGifts = 2, AnyNPC = true },
			},
		},
		OnActivateFinishedFunctionName = "ShowCodexUpdate",

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.65,
				{ Cue = "/VO/Melinoe_5621", Text = "{#Emph}As I would know our enemy, I too would know my heart." },
			},
		},
	},

	WorldUpgradeSkellyHealth =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_skelly",
		AlwaysRevealImmediately = true,
		Cost =
		{
			MixerShadow = 1,
			WeaponPointsRare = 2,
			OreGLime = 10,
			OrePAdamant = 10,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutHealthQuest01" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_4952", Text = "Augmentation of Bone Density, for the Commander..." },
		},

		UnthreadPreRevealVoiceLines = true,
		PreRevealVoiceLines =
		{
			{ GlobalVoiceLines = "AddingReagentVoiceLines" },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_4953", Text = "{#Emph}May bones of old become as adamant, unbreakable!" },
			},
		},
	},

	WorldUpgradeErisTrashPickup =
	{
		InheritFrom = { "DefaultMinorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_trash",
		Cost =
		{
			PlantNMoss = 3,
			PlantNGarlic = 3,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_ErisTrashcan" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "ErisGift07" }
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "TrashPoints" },
				Comparison = ">=",
				Value = 40,
			},
			NamedRequirements = { "ErisUnlocked" },
		},
	},

	WorldUpgradeBadgeSeller =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_badge",
		AlwaysRevealImmediately = true,
		Cost =
		{
			CosmeticsPoints = 250,
			MixerShadow = 1,
		},
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HecateGrantsBadgeSeller01" },
			},
		},

		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		CameraFocusId = 590506, -- Bartender Ghost
	},

	-- he is fast asleep, for he has seen too much; counted too much
	WorldUpgradeWakeHypnos =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
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
	WorldUpgradeWakeHypnosT2 =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_hypnos2",
		AlwaysRevealImmediately = true,

		Cost =
		{
			PlantFMoly = 1,
			PlantOMandrake = 3,
			PlantIPoppy = 2,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaGrantsHypnosSpell01" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_4636", Text = "I could make stronger Dream Vapors..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_4637", Text = "{#Emph}From Sleep to waking dream and then beyond..." },
			},
		},

		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		CameraFocusId = 370024, -- Hypnos

		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "HypnosPoints", SoundName = "/Leftovers/Menu Sounds/TalismanPaperEquipLEGENDARY" },
	},
	
	WorldUpgradeWakeHypnosT3 =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_hypnos2",
		AlwaysRevealImmediately = true,

		Cost =
		{
			PlantIShaderot = 1,
			PlantIPoppy = 2,
			DeathAreaPoints = 1,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MedeaGrantsHypnosSpell02" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_4705", Text = "This {#Emph}has {#Prev}to wake Lord Hypnos up..." },
		},

		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_4706", Text = "{#Emph}The strongest dreams shall shatter if they must!" },
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
		InheritFrom = { "DefaultMajorItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_dora",
		AlwaysRevealImmediately = true,

		Cost =
		{
			PlantGCattail = 4,
			Mixer6Common = 2,
			Mixer5Common = 2,
		},
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraAboutPrometheus04" }
			},
			-- back-compat
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraAboutPrometheus03" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "DoraGrantsCosmeticsShop01" },
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_4690", Text = "Dora's memory isn't gone, it's... buried." },
		},

		UnthreadPreRevealVoiceLines = true,
		PreRevealVoiceLines =
		{
			Queue = "Interrupt",
			{
				PreLineWait = 0.05,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4701", Text = "Dora wishes to remember... she's ready..." },
			},
		},
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.6,
				{ Cue = "/VO/Melinoe_4699", Text = "{#Emph}My true friend Dora, for you this is aimed: \n {#Emph}Regain the memories the Lethe claimed!" },
			},
		},
		PostRevealVoiceLines =
		{
			{
				PreLineWait = 0.85,
				ObjectType = "NPC_Dora_01",

				{ Cue = "/VO/Dora_0576", Text = "{#Emph}Whooaaaaa...",
					PostLineFunctionName = "DoraTeleportExit",
					PostLineFunctionArgs = { HideUntilNextRun = true } },
			},
			{
				PreLineWait = 0.2,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4829", Text = "Dora, wait...!" },
			}
		},

		StartIncantationThreadedFunctionName = "TeleportDoraForIncantation",
		PanDuration = 1.25,
		PanHoldDuration = 5.0,
		CameraFocusId = 566832, -- Dora
	},

	WorldUpgradeStoryReset =
	{
		InheritFrom = { "DefaultMajorItem", "DefaultHubItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_hadesfountain",
		AlwaysRevealImmediately = true,

		Cost =
		{
			MetaFabric = 3,
			Mixer5Common = 1,
		},
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			OrRequirements =
			{
				{
					{
						PathFalse = { "CurrentRun", "PlayedTrueEnding" },
					},
				},
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04_2" },
					},
				},
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_5751", Text = "By now I've learned something of dreams and time..." },
		},

		-- UnthreadPreRevealVoiceLines = true,
		IncantationVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5752", Text = "{#Emph}If Time flows freely forth, then I would see; \n {#Emph}A prior point, a possibility." },

			},
		},

		OnActivateFunctionName = "SetupStoryResetObject",

		PanDuration = 2,
		PanHoldDuration = 2.0,
		CameraFocusId = 567074,
		InspectPointId = 800770,

		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_5753", Text = "Through dreams and time, the past reveals itself..." },
		},
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
			{
				FunctionName = "RequireGiftTrackProgress",
				FunctionArgs =
				{
					MinGifts = 2,
					AnyOf =
					{
						"NPC_Hecate_01",
						"NPC_Odysseus_01",
						"NPC_Nemesis_01",
						"NPC_Eris_01",
						"NPC_Moros_01",
						"NPC_Dora_01",
						"NPC_Icarus_01",
					},
				},
			},
		},
		OnActivateFunctionName = "RevealBathHousePresentation",
		CameraFocusId = 589478,
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPointId = 589546,

		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_5077", Text = "Someone around here probably wouldn't mind a quick dip..." },
		},
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
		CameraFocusId = 558317,
		PanDuration = 1.5,
		PanHoldDuration = 2.0,
		InspectPointId = 589545,

		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_5078", Text = "Should be a nice quiet spot to catch a river denizen or two." },
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
		PostActivationThreadedFunctionName = "PostRevealTavernaPresentation",
		CameraFocusId = 586614,
		PanDuration = 1.0,
		PanHoldDuration = 2.0,
		PostActivationHoldDuration = 1.0,
		InspectPointId = 576167,

		PostRevealVoiceLines =
		{
			PreLineWait = 0.55,
			UsePlayerSource = true,

			{ Cue = "/VO/Melinoe_5076", Text = "Thank you for your patience, everyone! Please enjoy!" },
		},
	},

	-- alchemy / cooking recipes
	WorldUpgradeMixerShadow =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
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
				PlayOnce = true,
				BreakIfPlayed = true,
				-- PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_2612", Text = "{#Emph}Essences of Shadow, to the surface rise." },
			},
			{ GlobalVoiceLines = "AlchemyStartVoiceLines" },
		},

		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeFamiliarPoints =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CraftableIcon_FamiliarPoints",
		Cost =
		{
			GiftPoints = 1,
			Mixer5Common = 1,
		},
		CookTime = 14,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "FamiliarPoints", ResourceAmount = 3, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

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

			{ Cue = "/VO/Melinoe_5569", Text = "Could cook my own Witch's Delight..." },
		},

		IncantationVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				-- PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5622", Text = "{#Emph}Become the strength and nourishment of beasts!" },
			},
			{ GlobalVoiceLines = "AlchemyStartVoiceLines" },
		},

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
		OnActivateFinishedFunctionArgs = { ResourceName = "CardUpgradePoints", ResourceAmount = 5, WaitTime = 0.4, SoundName = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract" },

		IgnoreAffordable = true,

		IncantationVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				-- PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5624", Text = "{#Emph}Come, Moon Dust, from the shine of stars!" },
				{ Cue = "/VO/Melinoe_5623", Text = "{#Emph}Come, Moon Dust, from the dark of night!" },
			},
			{ GlobalVoiceLines = "AlchemyStartVoiceLines" },
		},

		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeNectar =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "CosmeticIcon_Nectar",
		AlwaysRevealImmediately = true,
		Cost =
		{
			Mixer5Common = 1,
			MixerOBoss = 1,
		},
		CookTime = 8,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "GiftPoints", ResourceAmount = 6, SoundName = "/SFX/GiftAmbrosiaBottlePickup" },

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
				PlayOnce = true,
				BreakIfPlayed = true,
				-- PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_1082", Text = "{#Emph}Come savor, unrivaled from heights of Olympus, to depths of the sea!" }
			},
			{ GlobalVoiceLines = "AlchemyStartVoiceLines" },
		},
		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},
	WorldUpgradeAmbrosia =
	{
		InheritFrom = { "DefaultInstantItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_ambrosia",
		AlwaysRevealImmediately = true,
		Cost =
		{
			Mixer5Common = 1,
			PlantHMyrtle = 1,
			MixerOBoss = 1,
			PlantPIris = 1,
		},
		CookTime = 16,
		Repeatable = true,
		SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "SuperGiftPoints", ResourceAmount = 3, SoundName = "/SFX/SuperGiftAmbrosiaBottlePickup" },

		IgnoreAffordable = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "DemeterPalacePostTrueEnding01", },
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_5689", Text = "Grandmother's recipe..." },
		},

		IncantationVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_5690", Text = "{#Emph}Ambrosia from the heavens, shine!" },
			},
			{ GlobalVoiceLines = "AlchemyStartVoiceLines" },
		},
		RevealReactionGlobalVoiceLines = "CookingStartedVoiceLines",
	},

	WorldUpgradeReviveIcarus =
	{
		InheritFrom = { "DefaultHubItem", "DefaultCriticalItem" },
		Icon = "GUI\\Screens\\CriticalItemShop\\Icons\\cauldron_icarus",
		AlwaysRevealImmediately = true,
		Cost =
		{
			PlantIShaderot = 2,
			MixerShadow = 1,
		},
		CookTime = 32,
		-- Repeatable = true,
		-- SkipUnlockText = true,
		UnlockTextId = "RepeatableUnlock",
		IgnoreAffordable = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "IcarusGift09" }
			},
		},

		OfferedVoiceLines =
		{
			PreLineWait = 0.7,
			PlayOnce = true,
			TriggerCooldowns = { "MelCauldronSpellRevealedSpeech" },

			{ Cue = "/VO/Melinoe_4569", Text = "You'll feel whole again. I swear it, Icarus..." },
		},

		UnthreadPreRevealVoiceLines = true,
		PreRevealVoiceLines =
		{
			{
				PreLineWait = 0.05,
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_4702", Text = "I failed Icarus before, but not this time..." },
			},
		},
		IncantationVoiceLines =
		{
			{
				PreLineWait = 0.3,
				{ Cue = "/VO/Melinoe_4700", Text = "{#Emph}The corpus of a Shade is never gone; \n {#Emph}May one regain his form till light of dawn!" },
			},
		},
		IncantationDuration = 30,

		OnActivateFinishedFunctionName = "ResourceGiftedPresentation",
		OnActivateFinishedFunctionArgs = { ResourceName = "IcarusPoints", ResourceAmount = 1, SoundName = "/SFX/GiftAmbrosiaBottlePickup" },
	},
}

GameData.WorldUpgradeAutomaticUnlocks =
{
	"Cosmetic_TentBlanket01",
	"Cosmetic_TentCandle01",
	"Cosmetic_TentShelf01",
	"Cosmetic_TentTable01",
	"Cosmetic_FrinosRock01",
	"Cosmetic_OdysseusTable01",
	"Cosmetic_MainHangingTassles01",
	"Cosmetic_MainHangingRope01",
	"Cosmetic_MainLanterns01",
	"Cosmetic_Cauldron01",
	"Cosmetic_CauldronRing01",
	"Cosmetic_CauldronPillars01",
	"Cosmetic_HypnosLanterns01",
	"Cosmetic_HypnosPillars01",
	"Cosmetic_HypnosPedestal01",
	"Cosmetic_TavernaTables01",
	"Cosmetic_TavernaChairs01",
	"Cosmetic_TavernaCauldron01",
	"Cosmetic_SkellyFloor01",
	"Cosmetic_TrainingDummy01",
	"FamiliarCostume_FrogDefault",
	"FamiliarCostume_CatDefault",
	"FamiliarCostume_RavenDefault",
	"FamiliarCostume_HoundDefault",
	"FamiliarCostume_PolecatDefault",
	"Song_MainTheme",
	"Costume_Default",
	"WeaponStaffSwing",
}