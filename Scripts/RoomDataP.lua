RoomSetData.P =
{
	BaseP =
	{
		DebugOnly = true,
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Olympus",
		ResultText = "RunHistoryScreenResult_Olympus",

		Tags = { "Indoor", "Outdoor" },
		BlockHeroLight = true,

		-- LocationText = "BiomeP",
		SaveProfileLocationText = "BiomeP_Short",

		LegalEncounters = EncounterSets.PEncountersDefault,
		--DevotionEncounters = {"DevotionTestP"},
		IneligibleRewards = { "Devotion", },

		TimeChallengeSwitchRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitchesSurface1" },
			},
		},
		TimeChallengeEncounterOptions = { "TimeChallengeP" },
		PerfectClearEncounterOptions = { "PerfectClearChallengeP" },
		EliteChallengeEncounterOptions = { "EliteChallengeP" },

		ZoomFraction = 0.85,
		MaxAppearancesThisBiome = 1,

		ShopSecretMusic = "/Music/BlankMusicCue",
		StopSecretMusic = true,
		
		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,
		HarvestPointBase = "OlympusTerrainHarvestPointBase01",

		SecretSpawnChance = 0.05,
		SecretDoorRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "P_PreBoss01", "P_Boss01" },
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
			},
			{
				PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
			},
			NamedRequirements = { "ChaosUnlocked", "NoRecentChaosEncounter" },
		},
		WellShopSpawnChance = 0.0,
		SurfaceShopSpawnChance = 0.13,
		TargetMetaRewardsRatio = 0.20,

		FlipHorizontalChance = 0.0,

		BreakableValueOptions = { MaxHighValueBreakables = 6 },
		NarrativeContextArt = "DialogueBackground_Olympus_Silent",

		Ambience = "/Ambience/OlympusOutdoorAmbience",

		HeroCreateAnimation = "OlympusColdBreathEmitter",

		SwapAnimations =
		{
			["SuitExhaustSprintDust"] = "SuitExhaustSprintDust_Olympus",
			["ExplosionScorchDecal"] = "OlympusSnowExplosionDecal",
			["EphyraUndeadGib"] = "EphyraUndeadGibOlympus",
		},

		ExitsUnlockedThreadedEvents =
		{
			{ FunctionName = "OlympusTremorPresentation",
				GameStateRequirements =
				{
					ChanceToPlay = 0.2,
					{
						SumPrevRooms = 7,
						CountPathTrue = true,
						Path = { "OlympusTremorPresentation" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						Comparison = "~=",
						Value = "P_Intro",
					},
				},
				Args = { DelayMin = 3.5, DelayMax = 5.0 },
			},
		},
	},

	P_Intro =
	{
		InheritFrom = { "P_BaseOutdoor", "BaseP", "BiomeStartRoom" },

		LegalEncounters =
		{
			"PIntroCombat01",
			"PIntroCombat02",
			"PIntroCombat03",
			"PIntroCombat04",
			"PIntroCombat05",
			"PIntroCombat06",
			"PIntroCombat07",
			"PIntroCombat08",
			"PIntroCombat09",
			"PIntroCombat_DragonQuad",
			"PIntroCombat_ZombieFishing",
			"PIntroCombat_ZombieQuad",
			"PIntroCombat_SapperGate",
			"PIntroCombat_CrossbowStatues", "Empty",
			"PIntroCombat_SapperOverlook", "Empty",
			--"PIntroCombat_CrossbowSiege", "Empty",
		},
		Starting = true,
		NoReward = true,
		NoReroll = true,
		HideRewardPreview = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceFunctionName = "RoomEntranceStandard",
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		EntranceDirection = "Right",
		FlipHorizontal = false,
		FlipHorizontalChance = 0.0,

		RushMaxRangeOverride = 525,

		ForceAtBiomeDepthMin = 0,
		ForceAtBiomeDepthMax = 1,
		MaxAppearancesThisBiome = 1,

		ZoomFraction = 0.75,
		IntroSequenceDuration = 0.96,
		CameraZoomWeights =
		{
			[560720] = 1.16,
			[744497] = 0.62,
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "EndBiomeRecords", },
			{ FunctionName = "EndAllBiomeStates" },
		},

		ThreadedEvents =
		{
			Threaded = true,
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
			},
			{
				FunctionName = "CheckObjectiveSetSource",
				Args =
				{
					ObjectiveSetName = "BountyAdvancedTooltip",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
			},
		},
		
		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut",
				WithinDistance = 150,
				FunctionName = "BiomeOverlookOlympus",
				Repeat = true,
				Args =
				{
					CameraSpeed = 1260,
					ZoomFraction = 0.9,
					ZoomDuration = 3,
					InitialDuration = 0.9,
					OverlookTargetStartId = 560721,
					BlackoutDuration = 1.4,
					BlackDuration = 1.2,
				},
			},
			-- Location Banners
			{
				TriggerGroup = "BannerTarget",
				WithinDistance = 600,
				FunctionName = "DisplayInfoBanner",
				Args = { Text = "Location_BiomeP", },
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
			},

		},
		DistanceTriggersPostCombatReload = true,

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		InspectPoints =
		{
			[744379] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_Intro_01 =
					{
						{ Cue = "/VO/Storyteller_0054",
							Text = "{#Emph}The majesty of Mount Olympus lies half-buried underneath a heavy coat of snow, which masks the scars and blemishes of a protracted siege." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1113", Text = "Beautiful..." },
						},
					},
				},
			},
			[561086] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_P_Intro_01", },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_Intro_02 =
					{
						{ Cue = "/VO/Storyteller_0055",
							Text = "{#Emph}The very mountain groans and rumbles underneath the feet of the Princess, its stonework shifting not unlike her father's realm." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1114", Text = "Reminds me of home now that you mention it." },
						},
					},
				},
			},
		},

		-- Room Audio
		BlockRandomStems = true,

		EnterVoiceLines =
		{
			[1] = { GlobalVoiceLines = "StartPackagedBountyRunVoiceLines" },
			[2] = { GlobalVoiceLines = "BiomeStateChangeStartVoiceLines" },
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 2.65,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.2,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_2455", Text = "Mount Olympus..." },
				{ Cue = "/VO/MelinoeField_2456", Text = "I'm here..." },
				{ Cue = "/VO/MelinoeField_2457", Text = "Made it this far..." },
				{ Cue = "/VO/MelinoeField_2458", Text = "Now for the climb...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_2524" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1463", Text = "Cold up here..." },
				{ Cue = "/VO/Melinoe_1464", Text = "At last...", PlayFirst = true },			
			},
		},

	},

	P_Shop01 =
	{
		InheritFrom = { "P_BaseOutdoor", "BaseP" },
		MaxCreationsThisRun = 1,
		FishingPointChance = 0.9,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		StoreDataName = "WorldShop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		NoReroll = true,
		
		ZoomFraction = 0.855,
		FlipHorizontalChance = 0.0,

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">",
				Value = 4,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 7,
			},
		},

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,

		-- Ambience = "/Leftovers/Object Ambiences/ShipwreckAmbience",
		SpawnRewardGlobalVoiceLines = "FoundShopVoiceLines",

		ObstacleData =
		{
		},

		InspectPoints =
		{
			[744379] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_Shop01_01 =
					{
						{ Cue = "/VO/Storyteller_0306",
							Text = "{#Emph}Heights such as these are no place for the Boatman of the Underworld; and yet his wares are curiously to be found, borne here perhaps by allies that remain unseen." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_2828", Text = "...Allies whom I certainly appreciate." },
							},
						},
					},
				},
			},

		},

	},

	P_PreBoss01 =
	{
		InheritFrom = { "P_BaseOutdoor", "BaseP" },
		Tags = { "Indoor", "Outdoor" },

		ForceAtBiomeDepthMin = 10,
		ForceAtBiomeDepthMax = 10,
		LinkedRoom = "P_Boss01",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		GameStateRequirements =
		{
			-- None
		},
		
		SecretSpawnChance = 0.0,

		SkipLastKillPresentation = true,
		
		LegalEncounters = { "Shop" },
		ForcedFirstReward = "Shop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomMoneyDrop", },
		SpawnRewardOnId = 744901,

		DisableRewardMagnetisim = true,

		ResetBinksOnExit = true,

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.6,
				SuccessiveChanceToPlay = 0.25,
				SuccessiveChanceToPlayAll = 0.05,

				{ Cue = "/VO/MelinoeField_2512", Text = "The summit's just ahead..." },
				{ Cue = "/VO/MelinoeField_2513", Text = "Quiet here at least...", PlayFirst = true },
			},
		},

		ObstacleData =
		{
			-- Charon Scarecrow
			[744832] =
			{
				Template = "OlympusCharoncrow01",
				SetupGameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "StoreDataName" },
						IsAny = { "WorldShop" },
					}
				},
			},
		},

		InspectPoints =
		{
			[744379] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						--
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_PreBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0296",
							Text = "{#Emph}The majestic summit of Mount Olympus would be very much in sight from here, were it not for the very dark and ominous storm wall that now envelops it." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_2526", Text = "A storm is brewing..." },
						},
					},
				},
			},

		},

	},

	P_Boss01 =
	{
		InheritFrom = { "BaseP", },

		-- the following may be removed once Indoor/Outdoor is chosen for this map
		Ambience = "/Leftovers/Ambience/LavaEruptRumbleLoop_2D",
		ReverbValue = 1,
		GlobalEcho = 0.5,

		NarrativeContextArt = "nil",
		HeroCreateAnimation = "nil",

		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsHardSurface",
			["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsHardSurfaceRun",
		},

		ValidateSecretData = false,

		FlipHorizontal = false,
		FlipHorizontalChance = 0,

		RequiresLinked = true,
		LinkedRoom = "P_PostBoss01",
		ExitPreviewAnim = "ExitAheadPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",
		NoReroll = true,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossPrometheus01", },
		ForcedReward = "MixerPBossDrop",

		EntranceFunctionName = "RoomEntranceBoss",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 560670 },
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,
		ZoomFraction = 0.785,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 560670 },
					SetupBossIds = { 560670, 560671, },
					PreTextLinesWaitTime = 0.5,
					DelayedStart = true,
				},
			},
		},
		
		ExitFunctionName = "EndEarlyAccessPresentation",
		SkipLoadNextMap = true,

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.3,
				SuccessiveChanceToPlay = 0.1,
				UsePlayerSource = true,			
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				-- { Cue = "/VO/MelinoeField_0529", Text = "Polyphemus!", PlayFirst = true },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.8,
				SuccessiveChanceToPlayAll = 0.33,
				PostLineWait = 0.0,
				ObjectType = "Prometheus",

				{ Cue = "/VO/Prometheus_0053", Text = "Stop right there.", PlayFirst = true },
				{ Cue = "/VO/Prometheus_0054", Text = "Don't move." },
				{ Cue = "/VO/Prometheus_0055", Text = "It's you." },
				{ Cue = "/VO/Prometheus_0056", Text = "I knew it.", PostLineFunctionName = "EagleReaction", },
				{ Cue = "/VO/Prometheus_0057", Text = "I knew it!", PostLineFunctionName = "EagleReaction", },
				{ Cue = "/VO/Prometheus_0058", Text = "Here's our prey.", PostLineFunctionName = "EagleReaction", },
				{ Cue = "/VO/Prometheus_0059", Text = "A brief word?" },
				{ Cue = "/VO/Prometheus_0060", Text = "Gods..." },
				{ Cue = "/VO/Prometheus_0063", Text = "My premonition." },
				{ Cue = "/VO/Prometheus_0061", Text = "Agent of Change...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "PrometheusLostAgainstHim01", "PrometheusBossOutro01" },
						},
					},
				},
				{ Cue = "/VO/Prometheus_0064", Text = "What do you know.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "P_Boss01" },
							Comparison = ">=",
							Value = 4,
						},
					}
				},
				{ Cue = "/VO/Prometheus_0062", Text = "Our nightly routine.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "P_Boss01" },
							Comparison = ">=",
							Value = 6,
						},
						{
							PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_2514", Text = "Prometheus.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2515", Text = "Titan." },
				{ Cue = "/VO/MelinoeField_2516", Text = "Surprised?" },
				{ Cue = "/VO/MelinoeField_2517", Text = "Guess who." },
			},
		},

		InspectPoints =
		{
			[751932] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_PostBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0304",
							Text = "{#Emph}No trace remains now of the Titan of Foresight or his Eagle companion, save for a single feather left behind; as if to goad the Princess on toward greater heights." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_2826", Text = "Just no more Eagles, please..." },
							},
						},
					},
				},
			},
			[751931] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_P_PostBoss01_01" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_PostBoss01_02 =
					{
						{ Cue = "/VO/Storyteller_0303",
							Text = "{#Emph}Not even the intense heat rising from the mountain's central hearth can entirely dispel the chill here in the air; a gathering storm, not wrought by gods, but something else." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.42,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_2825", Text = "...Something {#Emph}friendly?" },
							},
						},
					},
				},
			},
		},

	},
	
	P_PostBoss01 =
	{
		InheritFrom = { "BaseP" },

		LegalEncounters = { "Empty" },

		ValidateSecretData = false,

		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,

		EntranceFunctionName = "RoomEntranceStandard",

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		NextRoomSet = { "Q", },
		ExitPreviewAnim = "ExitUpPreview",
		RichPresence = "#RichPresence_PostBoss",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		Ambience = "/Leftovers/SFX/WindAmbienceLocal",
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,
		ReverbValue = 1.0,
		GlobalEcho = 0.0,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.7,

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		SurfaceShopSpawnChance = 1.0,
		ForceSurfaceShop = true,
		HasFishingPoint = true,

		WellShopSpawnChance = 0.0,
		ForceWellShop = false,
		SecretSpawnChance = 0.0,
		SellTraitShrineUpgrade = true,
		AllowExorcismPreExitsUnlock = true,
		AllowFishingPreExitsUnlock = true,

		StartUnthreadedEvents = {},

		SurfaceShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossSurfaceShops" },
			},
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeSurfaceShops" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				SumPrevRooms = 3,
				Path = { "SurfaceShop" },
				CountPathTrue = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		ObstacleData =
		{
			[765183] =
			{
				Template = "HealthFountainP",
				Activate = true,
				ActivateIds = { 751873 },
				SetupGameStateRequirements =
				{
					-- None
				},
			},
			[751868] =
			{
				Template = "GiftRack",
				Activate = true,
				ActivateIds = { 751869, 751870, 751871, 751872, },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossGiftRack", },
					},
				},
			},
			[487438] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				ActivateIds = { 487438 },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossSurfaceShops" },
					},
				},
			},
		},

		InspectPoints =
		{
			[557493] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_PostBoss01_01 =
					{
						{ Cue = "",
							Text = "{#Emph}TKTK" },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								-- { Cue = "/VO/MelinoeField_2524", Text = "Bit of a climb..." },
							},
						},
					},
				},
			},

		},

		EnterVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			{
				PreLineWait = 3.2,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.15,

				-- { Cue = "/VO/MelinoeField_2451", Text = "The path to Olympus...", PlayFirst = true },
			},
		},

	},

	P_CombatData =
	{
		InheritFrom = { "BaseP" },
		DebugOnly = true,
		FlipHorizontalChance = 0.0,

		MultipleEncountersData =
		{
			{ LegalEncounters = EncounterSets.PEncountersIntros, GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
			{ LegalEncounters = EncounterSets.PEncountersDefault }, -- First Encounter
		},
	},

	P_BaseIndoor =
	{
		DebugOnly = true,
		Ambience = "/Ambience/OlympusIndoorAmbience",
		Tags = { "Indoor" },
		ReverbValue = 0.25,
		GlobalEcho = 0.0,
		ZoomFraction = 0.8,

		ExitsUnlockedThreadedEvents = {},

		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsHardSurface",
			["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsHardSurfaceRun",
		},
	},

	P_BaseOutdoor =
	{
		DebugOnly = true,
		Ambience = "/Ambience/OlympusOutdoorAmbience",
		ReverbValue = 1,
		GlobalEcho = 0.5,
		Tags = { "Outdoor" },
		ZoomFraction = 0.7,

		FootstepAnimationR = "SnowFootstepR-Spawner",
		FootstepAnimationL = "SnowFootstepL-Spawner",

		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsSnow",
			["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsSnow",
		},
	},

	P_Combat01 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		EntranceDirection = "Right",
		FlipHorizontalChance = 0.0,

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat01_PreCombat01", "P_Combat01_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat02 =
	{
		InheritFrom = { "P_BaseIndoor", "P_CombatData" },
		HasFishingPoint = false,

		EntranceDirection = "LeftRight",
		RushMaxRangeOverride = 525,
		ZoomFraction = 0.75,

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat02_PreCombat01", "P_Combat02_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat03 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		ForceIfEncounterNotCompleted = "OlympusIntro",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "OlympusIntro", "P_Combat03_PreCombat01" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true },
			{ LegalEncounters = EncounterSets.PEncountersDefault,
				GameStateRequirements = { { PathTrue = { "GameState", "EncountersCompletedCache", "OlympusIntro" } }, }, },
		},

		EntranceDirection = "Right",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 4,
			},
		},

		CombatResolvedVoiceLines =
		{
			PlayOnce = true,
			PlayOnceContext = "AutomatonIntroResolvedVO",
			PreLineWait = 1.0,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "OlympusIntro" },
				},
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_2683", Text = "Automatons apparently are not my friends..." },
		},

		InspectPoints =
		{
			[775708] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EncountersCompletedCache", "OlympusIntro" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Kills" },
						HasAny = { "SentryBot", "AutomatonBeamer", "AtuomatonEnforcer" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Kills" },
						HasAny = { "ZombieOlympus", "SatyrSapper", "HarpyDropper" },
					},
				},
				InteractTextLineSets =
				{
					Inspect_P_Combat03_01 =
					{
						{ Cue = "/VO/Storyteller_0302",
							Text = "{#Emph}The battle of Olympus hangs in the balance, as the mountain's mechanical protectors and the Titan's forces continue to collide, shaking the heavens themselves." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_2824", Text = "All the world shivers..." },
							},
						},
					},
				},
			},

		},

	},

	P_Combat04 =
	{
		InheritFrom = { "P_BaseIndoor", "P_CombatData" },
		HasFishingPoint = false,

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat04_PreCombat01" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},

		EntranceDirection = "LeftRight",
	},

	P_Combat05 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		EntranceDirection = "Left",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat05_PreCombat01", "P_Combat05_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat06 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		EntranceDirection = "Left",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat06_PreCombat01", "P_Combat06_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat07 =
	{
		InheritFrom = { "P_BaseIndoor", "P_CombatData" },

		EntranceDirection = "Right",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat07_PreCombat01" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},

	},

	P_Combat08 =
	{
		InheritFrom = { "P_BaseIndoor", "P_CombatData" },

		ZoomFraction = 0.75,

		HasFishingPoint = false,

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		EntranceDirection = "Right",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat08_PreCombat01", "P_Combat08_PreCombat02", }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat09 =
	{
		InheritFrom = { "P_BaseIndoor", "P_CombatData" },
		
		HasFishingPoint = false,

		EntranceDirection = "Right",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat09_PreCombat01", "P_Combat09_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat10 =
	{
		InheritFrom = { "P_BaseIndoor", "P_CombatData" },

		EntranceDirection = "Left",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat10_PreCombat01" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat11 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		EntranceDirection = "Right",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat11_PreCombat01", "P_Combat11_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat12 =
	{
		InheritFrom = { "P_BaseIndoor", "P_CombatData" },

		HasFishingPoint = false,

		EntranceDirection = "LeftRight",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat12_PreCombat01", "P_Combat12_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat13 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		EntranceDirection = "Left",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat13_PreCombat01", "P_Combat13_PreCombat02", "P_Combat13_PreCombat03" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Combat14 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		EntranceDirection = "Right",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat14_PreCombat01", "P_Combat14_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},
	P_Combat15 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		EntranceDirection = "Right",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat15_PreCombat01", "P_Combat15_PreCombat02" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},
	P_Combat16 =
	{
		InheritFrom = { "P_BaseOutdoor", "P_CombatData" },

		EntranceDirection = "LeftRight",

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		MultipleEncountersData =
		{
			{ LegalEncounters = CombineTables(EncounterSets.PEncountersIntros, { "P_Combat16_PreCombat01" }), GameStateRequirements = { ChanceToPlay = 1.0 }, ContinueIfInelligible = true, },
				
			{ LegalEncounters = EncounterSets.PEncountersDefault },
		},
	},

	P_Reprieve01 =
	{
		InheritFrom = { "P_BaseIndoor", "BaseP", },
		IneligibleRewards = { "Devotion", },
		
		MaxCreationsThisRun = 1,
		LegalEncounters = { "HealthRestore" },
		SecretMusic = "/Music/BlankMusicCue",
		-- Ambience = "/Leftovers/Ambience/GentleWavesBeachAmbience2D",
		SwapSounds =
		{
		},

		FlipHorizontalChance = 0.0,
		SpawnRewardOnId = 744587,
		DisableRewardMagnetisim = true,
		IntroSequenceDuration = 0.02,

		ForceSurfaceShop = true,
		ChallengeSpawnChance = 0.0,

		HasFishingPoint = true,
		FishingPointChance = 0.9,

		HarvestPointChances =
		{
			0.8,
			0.4,
			0.1,
		},

		ShovelPointChance = 0.35,
		PickaxePointChance = 0.35,
		ExorcismPointChance = 0,

		HarvestPointRequirements = { },
		ShovelPointRequirements = { },
		--PickaxePointRequirements = { },
		ExorcismPointRequirements = { },

		StartThreadedEvents =
		{			
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 1.0 }, Args = { StartingCountMin = 24, StartingCountMax = 36, ObjectNames = { "ShadeMerc" }, MaxActive = 36 } },
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeOlympusReprieve" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
		},

		EnterGlobalVoiceLines = "EnteredReprieveRoomVoiceLines",
		-- Ambience = "/Leftovers/Ambience/StillWaterAmbience",

		InspectPoints =
		{
			[744379] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01", },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_Reprieve01_01 =
					{
						{ Cue = "/VO/Storyteller_0300",
							Text = "{#Emph}An alcove unafflicted by the toil on the otherwise-besieged Olympus heights invites the Princess of the Underworld to catch what little breath remains to her for now." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_2529", Text = "Can't rest here, not for long..." },
						},
					},
				},
			},

		},

	},

	P_Story01 =
	{
		InheritFrom = { "P_BaseIndoor", "BaseP" },
		HasFishingPoint = true,
		FishingPointChance = 0.9,
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		RichPresence = "#RichPresence_PStory01",
		AllowExorcismPreExitsUnlock = true,
		AllowFishingPreExitsUnlock = true,

		SwapSounds =
		{
		},

		ZoomFraction = 0.8,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "AthenaFirstMeeting" },
			},
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 8,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},

		Ambience = "/Leftovers/Object Ambiences/ScummyTownAmbience",
		EndAmbienceOnExit = true,
		
		SecretMusic = "/Music/DionysusMusic",
		TimerBlock = "StoryRoom",

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Dionysus_01" },
		StartUnthreadedEvents =
		{
			{
				FunctionName = "DionysusRandomizeLeopards",
				Args =
				{
					LeopardAnimations =
					{
						"LeopardGuest_Idle",
						"LeopardGuest_Sleep_Loop_Alt2"
					},
				},
			},
		},

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.9,
				SuccessiveChanceToPlay = 0.25,
				SuccessiveChanceToPlayAll = 0.05,

				{ Cue = "/VO/MelinoeField_2510", Text = "What is going on in here...?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "PStoryFirstIntroVO", },
				{ Cue = "/VO/MelinoeField_2511", Text = "Still feasting..." },
			},
		},

		ObstacleData =
		{
			--
		},

		InspectPoints =
		{
			[750617] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Dionysus_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_Story01_01 =
					{
						{ Cue = "/VO/Storyteller_0295",
							Text = "{#Emph}What mirth remains upon the war-torn mountain of the gods apparently is concentrated here, where Dionysus, god of wine, plays host to his most-favored retinue of revelers." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_2525", Text = "At least those Satyrs aren't trying to slaughter me..." },
							},
						},
					},
				},
			},

		},

		ThreadedEvents =
		{
			{ FunctionName = "DionysusMusicManager" },
		},
	},

	P_MiniBoss01 =
	{
		InheritFrom = { "P_BaseIndoor", "BaseP" },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		BlockCameraReattach = true,

		HasFishingPoint = false,
		
		SecretSpawnChance = 0.0,
		SuppressRewardSpawnSounds = false,
		ReverbValue = 1.0,

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		ZoomFraction = 0.775,

		EntranceFunctionName = "RoomEntranceBoss",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 774525 },
		ThreadEnterVoiceLines = true,
		IntroSequenceDuration = 3.0,
		FirstTimeBonusWait = 4.0, -- extra wait for VO, 1st time only

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomsEntered", },
				HasNone = { "P_MiniBoss02", },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "MapState", "OfferedExitDoors" },
				UseLength = true,
				Comparison = ">",
				Value = 1,
			},
		},

		LegalEncounters = { "MiniBossTalos" },
		FlipHorizontalChance = 0.0,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 774525 },
					SetupBossIds = { 774525 },
					SetupUnitIdAIs = { 776130, 776131, },
					SkipAngleTowardTarget = true,
					DelayedStart = true,
					BossIntroSound = "/SFX/Enemy Sounds/Talos/EmoteAlerted",
				},
			},
		},

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Duo = 0.2, Legendary = 0.2, Epic = 0.10, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 8,
		MaxAppearancesThisBiome = 1,

		EntranceDirection = "LeftRight",

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		EnterGlobalVoiceLines = "TalosEncounterStartVoiceLines",
		CombatResolvedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		InspectPoints =
		{
			[744643] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01", },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_MiniBoss_01 =
					{
						{ Cue = "/VO/Storyteller_0298",
							Text = "{#Emph}The numerous defensive capabilities of terrifying Talos, the most powerful of the Olympian Automatons wrought by the hands of great Hephaestus himself, includes the power to quite slowly self-repair..." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_2528", Text = "Surely Talos will recall this misunderstanding next time..." },
						},
					},
				},
			},

		},

	},

	P_MiniBoss02 =
	{
		InheritFrom = { "P_BaseIndoor", "BaseP" },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		HasFishingPoint = false,
		
		SecretSpawnChance = 0.0,
		SuppressRewardSpawnSounds = false,
		ReverbValue = 1.0,

		EnterSound = "/SFX/StyxWingDoorCloseSFX",

		ZoomFraction = 0.705,
		RushMaxRangeOverride = 545,

		IntroSequenceDuration = 1.95,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomsEntered", },
				HasNone = { "P_MiniBoss01", },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "MapState", "OfferedExitDoors" },
				UseLength = true,
				Comparison = ">",
				Value = 1,
			},
		},

		LegalEncounters = { "MiniBossDragon" },
		FlipHorizontalChance = 0.0,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Duo = 0.2, Legendary = 0.2, Epic = 0.10, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 8,
		MaxAppearancesThisBiome = 1,

		EntranceDirection = "Right",

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		CombatResolvedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		InspectPoints =
		{
			[775707] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_P_MiniBoss02_01 =
					{
						{ Cue = "/VO/Storyteller_0305",
							Text = "{#Emph}A lofty mountain is not easily besieged; so the crafty Titan of Time sought winged beasts susceptible to his persuasions, and capable of wreaking havoc from the skies." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_2827", Text = "Looks like they've made themselves at home..." },
							},
						},
					},
				},
			},

		},

	},

}
AddTableKeysCheckDupes( RoomData, RoomSetData.P )