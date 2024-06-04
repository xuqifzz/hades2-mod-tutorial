RoomSetData.O =
{
	BaseO =
	{
		DebugOnly = true,
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Ships",
		ResultText = "RunHistoryScreenResult_Thessaly",

		LegalEncounters = EncounterSets.OEncountersDefault,
		DevotionEncounters = {"DevotionTestO"},

		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = false,
		HasExorcismPoint = true,
		SecretSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SurfaceShopSpawnChance = 0.25,
		TargetMetaRewardsRatio = 0.30,

		HarvestPointChances =
		{
			0.30,
		},

		BreakableValueOptions = { MaxHighValueBreakables = 0 },

		TimeChallengeEncounterOptions = { "TimeChallengeO" },

		EntranceFunctionName = "ShipsRoomEntrancePresentation",

		ZoomFraction = 0.80,
		EntranceDirection = "Right",
		FlipHorizontalChance = 0,

		-- LocationText = "BiomeO",
		SaveProfileLocationText = "BiomeO_Short",

		Ambience = "/Ambience/ShipAmbienceLoop",
		ShopSecretMusic = "/Music/CharonShopTheme",
		StopSecretMusic = true,
		ReverbValue = 0.1,

		SpeakerName = "Ships",
		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/Leftovers/SFX/FootstepsWoodSmall",
			["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsWoodRun",
		},

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.1 }, Args = { StartingCountMin = 0, StartingCountMax = 12, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
			{ FunctionName = "HandleWrapping" },
		},
		PostCombatReloadThreadedEvents =
		{
			{ FunctionName = "HandleWrapping" },
		},
		WrappingData =
		{
		},

		ExitsUnlockedThreadedEvents =
		{
			{
				FunctionName = "ShipsEndOilFires",
			},
		},

		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "ShipsFirstCombatVO",
				PreLineWait = 1.6,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "O_MiniBoss01", "O_Story01", "O_Shop01", "O_PreBoss01" },
					},
				},

				{ Cue = "/VO/MelinoeField_1815", Text = "This must have been the closest ship..." },
				{ Cue = "/VO/MelinoeField_1816", Text = "...I'll take it.", PreLineWait = 1.0 },
			}
		},

	},

	O_Intro =
	{
		InheritFrom = { "BaseO", "BiomeStartRoom"},
		LegalEncounters = { "O_Empty" },
		ZoomFraction = 0.75,
		IntroSequenceDuration = 0.7,
		Starting = true,
		NoReward = true,
		NoReroll = true,
		SkipLastKillPresentation = true,
		HideRewardPreview = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceFunctionName = "RoomEntranceStandard",
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		FlipHorizontalChance = 0.0,

		Ambience = "/Leftovers/Ambience/CalmBoatWaterAmbience",

		HarvestPointChances =
		{
			0,
			0,
			0,
		},

		HasFishingPoint = true,
		FishingPointChance = 0.9,

		ForceAtBiomeDepthMin = 0,
		ForceAtBiomeDepthMax = 1,
		MaxAppearancesThisBiome = 1,

		SwapSounds =
		{
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "EndBiomeRecords", },
			{ FunctionName = "EndAllBiomeStates" },
		},

		StartThreadedEvents =
		{
			{
				FunctionName = "ActivateFamiliar",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked" },
					},
					{
						Path = { "GameState", "FishingSuccesses" },
						Comparison = ">=",
						Value = 1,
					},
				},
				Args =
				{
					Id = 739846,
					Name = "CatFamiliar",
					SkipAISetup = true,
					OverwriteSelf =
					{
						OnUsedFunctionName = "nil",
						SpecialInteractFunctionName = "CatFamiliarSpecialInteractLockedInRun",
						DistanceTriggers =
						{
							{
								WithinDistance = 550,
								FunctionName = "GenericPresentation",
								Args =
								{
									PreWait = 0.0,
									AngleTowardHero = true,
									SetAnimation = "Familiar_Cat_Sleep_Awaken",
									Sound = "/SFX/Familiars/CatMeow1",
									VoiceLines = GlobalVoiceLines.CatReactionVoiceLines,
								},
							},
						}
					},
				},
			},
		},

		ThreadedEvents =
		{
		},

		ObstacleData =
		{
			-- Ship Hull
			[691287] =
			{
				Name = "Shipwreck",
				DistanceTriggers =
				{
					{
						WithinDistance = 800,
						VoiceLines =
						{
							PlayOnce = true,
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							SuccessiveChanceToPlayAll = 0.25,
							TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

							{ Cue = "/VO/MelinoeField_1735", Text = "A scuttled ship... ", PlayFirst = true },
							{ Cue = "/VO/MelinoeField_1736", Text = "This ship's no closer to repair..." },
							{ Cue = "/VO/MelinoeField_1737", Text = "It's still connected to the main fleet..." },
							{ Cue = "/VO/MelinoeField_1738", Text = "The Spectral Gate is still intact." },
						}
					},
				}
			},
			-- Exit Door
			[691310] = 
			{
				Name = "ShipFirstExit",
				Template = "ShipsExitDoor",
				DistanceTriggers =
				{
					{
						WithinDistance = 420,
						VoiceLines =
						{
							PlayOnce = true,
							PlayOnceContext = "ShipsFirstExitSpottedVO",
							UsePlayerSource = true,
							TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

							{ Cue = "/VO/MelinoeField_1808", Text = "It's got a Spectral Gate...",
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "SpeechRecord", "/VO/MelinoeField_1738" },
									},
								},
							},
						}
					},
				}
			},

		},

		
		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 150, FunctionName = "BiomeOverlookShips", Repeat = true, Args = { PanTargetId = 690794, ZoomFraction = 0.75, Duration = 6, BlackoutDuration = 1.26, BlackDuration = 0.40 },
			},
			-- Location Banners
			{
				TriggerGroup = "BannerTarget",
				WithinDistance = 1000,
				FunctionName = "DisplayInfoBanner",
				Args = { Text = "Location_BiomeO", Delay = 2.0, },
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
			},
			{
				TriggerGroup = "BannerTarget",
				WithinDistance = 1000,
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
				},
			},
		},

		InspectPoints =
		{
			[691446] =
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
					Inspect_O_Intro_01 =
					{
						{ Cue = "/VO/Storyteller_0052",
							Text = "{#Emph}On the outskirts of the city lies a makeshift dock, from which a vessel may cut through the channel 'cross the land, toward the mountain of the gods." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1836", Text = "Looks like I'll need a ride." },
							},
						},
					},
				},
			},

			[561084] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_O_Intro_01" },
					},
				},
				InteractTextLineSets =
				{
					Inspect_O_Intro_02 =
					{
						{ Cue = "/VO/Storyteller_0053",
							Text = "{#Emph}When the armies of Chronos marched on Olympus, mighty Poseidon split the very land asunder. And so the gods contend with naval forces now..." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_1837", Text = "Not a mistake; an opportunity." },
						},
					},
				},
			},

		},

		-- Room Audio Below This Line
		MusicActiveStems = { "Guitar", "Bass", "Drums" },
		MusicStartDelay = 1.75,
		MusicMutedStems = { "Drums" },
		PlayBiomeMusic = true,
		MusicSection = 0,

		EnterVoiceLines =
		{
			[1] = GlobalVoiceLines.StartPackagedBountyRunVoiceLines,
			[2] = GlobalVoiceLines.BiomeStateChangeStartVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 2.65,
				SuccessiveChanceToPlayAll = 0.1,

				{ Cue = "/VO/Melinoe_0804", Text = "A harbor...", PlayFirst = true, PlayOnce = true, PlayOnceContext = "ShipsFirstEntranceVO" },
				{ Cue = "/VO/Melinoe_0805", Text = "The docks..." },
				-- { Cue = "/VO/Melinoe_1461", Text = "Almost there...", PlayFirst = true },
			},
		},

	},

	O_Shop01 =
	{
		InheritFrom = { "BaseO" },
		MaxCreationsThisRun = 1,
		FishingPointChance = 0.9,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		StoreDataName = "SurfaceShop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		NoReroll = true,
		ZoomFraction = 0.855,
		Ambience = "/Ambience/ShipAmbienceLoopQuieter",

		IntroPanDuration = 2,
		IntroSequenceDuration = 2,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
			},
		},

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,

		-- Ambience = "/Leftovers/Object Ambiences/ShipwreckAmbience",
		EnterGlobalVoiceLines = "BoardedFlagshipVoiceLines",

		ObstacleData =
		{
			-- Steering Wheel
			[690973] =
			{
				SetupEvents =
				{
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							OnUsedFunctionName = "nil",
						},
					}
				},
			},
		},

		InspectPoints =
		{
			[743811] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_Shop01_01 =
					{
						{ Cue = "/VO/Storyteller_0262",
							Text = "{#Emph}A black ship, darkest of them all, disrupts the endless fleet that hounds Olympus; yet none dare engage with it for long, or with the fearsome captain of its spectral crew." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1841", Text = "Lord Charon's kept our enemies at bay..." },
							},
						},
					},
				},
			},

		},

	},

	O_PreBoss01 =
	{
		InheritFrom = { "BaseO" },
	
		LinkedRoom = "O_Boss01",

		ForceAtBiomeDepthMin = 7,
		ForceAtBiomeDepthMax = 7,

		IntroPanDuration = 2,
		IntroSequenceDuration = 2.0,
		Ambience = "/Ambience/ShipAmbienceLoopQuieter",

		GameStateRequirements =
		{
			-- None
		},
		
		SecretSpawnChance = 0.0,

		HarvestPointChances =
		{
			0.35,
		},

		SkipLastKillPresentation = true,
		LegalEncounters = { "Shop" },
		ForcedFirstReward = "Shop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		--ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomMoneyDrop", },
		SpawnRewardOnId = 720909,

		DisableRewardMagnetisim = true,

		ResetBinksOnExit = true,

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,

		EnterGlobalVoiceLines = "BoardedFlagshipVoiceLines",
		MusicMutedStems = { "Drums" },

		ObstacleData =
		{
			-- Charon's Copilot
			[721140] =
			{
				Name = "FlagshipCopilot",
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "Empty" },
					},
				},
			},
			-- Steering Wheel
			[690973] =
			{
				SetupEvents =
				{
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							OnUsedFunctionName = "nil",
						},
					}
				},
			},
		},
		InspectPoints =
		{
			[743812] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_PreBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0263",
							Text = "{#Emph}Now, distant shores upon which proudly rests the mountain of the gods have suddenly grown near. And the Black Flagship is prepared to send the Princess there." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1842", Text = "The coast is dead ahead..." },
							},
						},
					},
				},
			},
			[743813] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "N_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_PreBoss01_02 =
					{
						{ Cue = "/VO/Storyteller_0264",
							Text = "{#Emph}As the Black Flagship sails closer to the shore, the Princess of the Dead knows well that whatsoever Strife she has experienced thus far this night... is about to get worse." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.38,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1843", Text = "Oh I await it {#Emph}eagerly." },
							},
						},
					},
				},
			},

		},


	},

	O_Boss01 =
	{
		InheritFrom = { "BaseO" },

		RequiresLinked = true,
		LinkedRoom = "O_PostBoss01",
		ExitPreviewAnim = "ExitUpPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",

		HasFishingPoint = true,

		Milestone = true,
		MilestoneIcon = "BossIcon",
		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossEris01", },
		ForcedReward = "MixerOBossDrop",
		NoReroll = true,

		Ambience = "/Leftovers/Ambience/GentleWavesBeachAmbience2D",
		SwapSounds =
		{
		},

		EntranceFunctionName = "RoomEntranceBossShips",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 558020 },
		IntroSequenceDuration = 2.3,
		BlockCameraReattach = true,
		ZoomFraction = 0.8,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 558020 },
					SetupBossIds = { 558020 },
					SkipAngleTowardTarget = true,
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
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.75,
				ObjectType = "Eris",
				PreLineAnim = "Enemy_Eris_Hub_Greet",

				{ Cue = "/VO/Eris_0072", Text = "Lookee who!" },
				{ Cue = "/VO/Eris_0074", Text = "{#Emph}Ahh, heh!" },
				{ Cue = "/VO/Eris_0077", Text = "Hey babe!" },
				{ Cue = "/VO/ErisField_0050", Text = "Hiya babe!" },
				{ Cue = "/VO/ErisField_0051", Text = "Hey hey!" },
				{ Cue = "/VO/ErisField_0052", Text = "Thought that was you." },
				{ Cue = "/VO/ErisField_0053", Text = "Look who!" },
				{ Cue = "/VO/ErisField_0054", Text = "Got here {#Emph}first!" },
				{ Cue = "/VO/ErisField_0055", Text = "You made it!", PlayFirst = true },
				{ Cue = "/VO/ErisField_0056", Text = "Trouble!" },
				{ Cue = "/VO/ErisField_0057", Text = "Trouble." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.5,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1903", Text = "Eris...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1905", Text = "You.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1904", Text = "You're in my way." },
				{ Cue = "/VO/MelinoeField_1906", Text = "Every time..." },
			},

		},

		InspectPoints =
		{
			[744274] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_Boss01_01 =
					{
						{ Cue = "/VO/Storyteller_0265",
							Text = "{#Emph}To feel again the stable Earth beneath her feet replenishes within the Princess of the Underworld her nearly-limitless resolve, as her objective finally draws near." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1844", Text = "Mount Olympus... there it is ahead..." },
							},
						},
					},
				},
			},
			[744273] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_Boss01_02 =
					{
						{ Cue = "/VO/Storyteller_0266",
							Text = "{#Emph}The embodiment of Strife has vanished, yet her influence remains, as Earth and Sea alike remain embroiled in a cataclysmic conflict she is keen to endlessly perpetuate." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1845", Text = "Eris must be having the time of her life..." },
							},
						},
					},
				},
			},


		},

	},
	
	O_PostBoss01 =
	{
		InheritFrom = { "BaseO" },
		LegalEncounters = { "Empty" },

		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		NextRoomSet = { "P", },
		ExitPreviewAnim = "ExitUpPreview",
		RichPresence = "#RichPresence_PostBoss",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		Ambience = "/Leftovers/Ambience/CreepyHauntedWindLoop",
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 2.1,
		IntroPanDuration = 2.0,

		ExitPath = { 558947 },

		SkipLastKillPresentation = true,
		TimeChallengeSwitchSpawnChance = 0.0,
		SurfaceShopSpawnChance = 1.0,
		ForceSurfaceShop = true,
		 
		WellShopSpawnChance = 0.0,
		ForceWellShop = false,
		SecretSpawnChance = 0.0,
		SellTraitShrineUpgrade = true,

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
			[557482] =
			{
				Template = "HealthFountain",
				Activate = true,
				ActivateIds = { 557482, },
				SetupGameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossFountains", },
					},
				},
			},
			[487438] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				ActivateIds = { 486371 },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossSurfaceShops" },
					},
				},
			},
		},

	},

	O_MiniBoss01 =
	{
		InheritFrom = { "BaseO", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		EntranceFunctionName = "RoomEntranceCharybdis",
		Ambience = "/Leftovers/Ambience/StormSwathAmbience",

		GameStateRequirements =
		{
			--RequiredFalseSeenRoomsThisRun = { "O_MiniBoss02" },
		},

		LegalEncounters = { "MiniBossCharybdis" },
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.75,

		IntroSequenceDuration = 3.0,
		IntroPanDuration = 1.0,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.10, Rare = 0.90 },

		TentacleBurrowPoints =
		{
			{ 737316, 737312, 737313, 737315, 737314, },
			{ 737321, 737320, 737319, 737318, 737317, },
			{ 737326, 737325, 737324, 737322, 737323, },
			{ 737331, 737329, 737328, 737327, 737330, },
		},

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		MaxCreationsThisRun = 1,
		MaxAppearancesThisBiome = 1,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
			},
		},		

		CombatResolvedVoiceLines =
		{
			[1] = GlobalVoiceLines.MiniBossEncounterEndVoiceLines,
		},

		InspectPoints =
		{
			[743810] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_MiniBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0260",
							Text = "{#Emph}The monster called Charybdis marked the doom of many unsuspecting ships, and in its ancient terror, now despoils the sea-filled rift that has been slashed across the land." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1839", Text = "How many ships have fallen to that thing?" },
							},
						},
					},
				},
			},

			[743811] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_MiniBoss01_02 =
					{
						{ Cue = "/VO/Storyteller_0261",
							Text = "{#Emph}The abomination called Charybdis forms within the waters of the sea a vortex from which not even the sleekest ship can possibly escape." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.42,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1840", Text = "...I should probably go." },
							},
						},
					},
				},
			}

		},
	},

	O_CombatData =
	{
		DebugOnly = true,

		NoReward = true,
		ZoomFraction = 0.835,

		IntroSequenceDuration = 2.1,
		IntroPanDuration = 2.0,

		GameStateRequirements =
		{
			{
				SumPrevRooms = 3,
				Path = { "EncountersOccurredCache", },
				TableValuesToCount = { "GeneratedO_Intro01", "GeneratedO_Intro01_First", "HeraclesCombatO" },
				Comparison = "<",
				Value = 3,
			},
		},

		ExitsUnlockedThreadedEvents =
		{
			{
				FunctionName = "ShipsExitsUnlockedPresentation",
				GameStateRequirements =
				{
					{
						--
					},
				},
			},
			{
				FunctionName = "ShipsEndOilFires",
			},
		},
	},

	O_CombatDataSmall =
	{
		InheritFrom = { "O_CombatData" },
		DebugOnly = true,

		MultipleEncountersData =
		{
			{ LegalEncounters = EncounterSets.OEncountersIntros }, -- Pre-Spawned Enemies
			{ LegalEncounters = EncounterSets.OEncountersDefault }, -- First Encounter
			{ LegalEncounters = EncounterSets.OEncountersDefault, GameStateRequirements = { ChanceToPlay = 0.60,
					{
						Path = { "CurrentRun", "BiomeEncounterDepth" },
						Comparison = "<=",
						Value = 6,
					},
				},
			}, -- Second Encounter
			{ LegalEncounters = EncounterSets.OEncountersDefault, GameStateRequirements = { ChanceToPlay = 0.30,
					{
						Path = { "CurrentRun", "BiomeEncounterDepth" },
						Comparison = "<=",
						Value = 6,
					},
				},
			}, -- Third Encounter
		},
	},

	O_CombatDataMedium =
	{
		InheritFrom = { "O_CombatData" },
		DebugOnly = true,

		MultipleEncountersData =
		{
			{ LegalEncounters = EncounterSets.OEncountersIntros }, -- Pre-Spawned Enemies
			{ LegalEncounters = EncounterSets.OEncountersDefault }, -- First Encounter
			{ LegalEncounters = EncounterSets.OEncountersDefault, GameStateRequirements = { ChanceToPlay = 0.60,
					{
						Path = { "CurrentRun", "BiomeEncounterDepth" },
						Comparison = "<=",
						Value = 6,
					},
				},
			}, -- Second Encounter
			{ LegalEncounters = EncounterSets.OEncountersDefault, GameStateRequirements = { ChanceToPlay = 0.30,
					{
						Path = { "CurrentRun", "BiomeEncounterDepth" },
						Comparison = "<=",
						Value = 6,
					},
				},
			}, -- Third Encounter
		},
	},

	O_CombatDataLarge =
	{
		InheritFrom = { "O_CombatData" },
		DebugOnly = true,

		MultipleEncountersData =
		{
			{ LegalEncounters = EncounterSets.OEncountersIntros }, -- Pre-Spawned Enemies
			{ LegalEncounters = EncounterSets.OEncountersDefault }, -- First Encounter
			{ LegalEncounters = EncounterSets.OEncountersDefault, GameStateRequirements = { ChanceToPlay = 0.60,
					{
						Path = { "CurrentRun", "BiomeEncounterDepth" },
						Comparison = "<=",
						Value = 6,
					},
				},
			}, -- Second Encounter
			{ LegalEncounters = EncounterSets.OEncountersDefault, GameStateRequirements = { ChanceToPlay = 0.30,
					{
						Path = { "CurrentRun", "BiomeEncounterDepth" },
						Comparison = "<=",
						Value = 6,
					},
				},
			}, -- Third Encounter
		},
	},

	O_Combat01 =
	{
		InheritFrom = { "O_CombatDataLarge", "BaseO" },
		
		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723321, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723321, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723321, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723319, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723319, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723320, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat02 =
	{
		InheritFrom = { "O_CombatDataLarge", "BaseO" },

		RushMaxRangeOverride = 475,

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723039, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723039, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723039, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723040, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723040, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723041, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat03 =
	{
		InheritFrom = { "O_CombatDataMedium", "BaseO" },

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723323, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723323, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723323, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723322, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723322, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723324, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat04 =
	{
		InheritFrom = { "O_CombatDataSmall", "BaseO" },

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723363, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723363, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723363, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723362, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723362, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723364, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat05 =
	{
		InheritFrom = { "O_CombatDataLarge", "BaseO" },

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723363, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723363, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723363, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723362, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723362, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723364, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat06 =
	{
		InheritFrom = { "O_CombatDataLarge", "BaseO" },

		RushMaxRangeOverride = 475,

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723373, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723373, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723373, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723374, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723374, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723372, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat07 =
	{
		InheritFrom = { "O_CombatDataSmall", "BaseO" },
		ZoomFraction = 0.86,

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723388, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723388, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723388, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723389, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723389, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723387, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat08 =
	{
		InheritFrom = { "O_CombatDataMedium", "BaseO" },

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723343, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723343, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723343, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723342, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723342, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723344, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat09 =
	{
		InheritFrom = { "O_CombatDataMedium", "BaseO" },

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723346, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723346, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723346, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723347, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723347, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723345, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat10 =
	{
		InheritFrom = { "O_CombatDataSmall", "BaseO" },

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723372, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723372, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723372, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723373, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723373, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723371, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat11 =
	{
		InheritFrom = { "O_CombatDataSmall", "BaseO" },

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723369, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723369, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723369, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723368, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723368, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723370, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat12 =
	{
		InheritFrom = { "O_CombatDataMedium", "BaseO" },

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723326, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723326, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723326, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723325, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723325, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723327, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat13 =
	{
		InheritFrom = { "O_CombatDataMedium", "BaseO" },

		-- Backup if there is nothing eligible before PreBoss
		GameStateRequirements =
		{
			{
				SumPrevRooms = 3,
				Path = { "EncountersOccurredCache", },
				TableValuesToCount = { "GeneratedO_Intro01", "GeneratedO_Intro01_First", "HeraclesCombatO" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 6,
			},
		},

		WrappingData =
		{
			SpawnData =
			{
				PreSpawnObstacles = true,
				MoveSpeed = 600,
				SpawnIntervalMin = 3,
				SpawnIntervalMax = 5,
				MoveTime = 18,
				ObstacleNames =
				{
					"ShipsShipwreck01",
					"ShipsWreckGroup01", "ShipsWreckGroup01", "ShipsWreckGroup01", 
					"ShipsWreckGroup02", "ShipsWreckGroup02", "ShipsWreckGroup02", 
				},
				SpawnPoints =
				{
					{ Id = 723343, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723343, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723343, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723342, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723342, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723344, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Reprieve01 =
	{
		InheritFrom = { "BaseO" },
		IneligibleRewards = { "Devotion", },
		
		MaxCreationsThisRun = 1,
		LegalEncounters = { "HealthRestore" },
		SecretMusic = "/Music/BlankMusicCue",
		Ambience = "/Leftovers/Ambience/GentleWavesBeachAmbience2D",
		SwapSounds =
		{
		},

		FlipHorizontalChance = 0.0,
		SpawnRewardOnId = 695602,
		DisableRewardMagnetisim = true,
		IntroSequenceDuration = 2.1,
		IntroPanDuration = 2.0,

		ForceSurfaceShop = true,
		TimeChallengeSwitchSpawnChance = 0.0,

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
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeThessalyReprieve" },
			},
			RequiredMinCompletedRuns = 0,
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
			[695597] =
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
					Inspect_O_Reprieve01_01 =
					{
						{ Cue = "/VO/Storyteller_0259",
							Text = "{#Emph}A shrouded glade shorn from the heart of the land somehow remains suggestive of a time of peace and beauty that has long since fallen deep into the distant past." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_1838", Text = "Times change." },
						},
					},
				},
			},

		},

	},

	O_Story01 =
	{
		InheritFrom = { "BaseN" },
		HasFishingPoint = true,
		FishingPointChance = 0.9,
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		RichPresence = "#RichPresence_OStory01",
		AllowExorcismPreExitsUnlock = true,

		SwapSounds =
		{
		},

		ZoomFraction = 0.68,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
			},
			{
				Path = { "GameState", "BiomeVisits", "O" },
				Comparison = ">",
				Value = 1,
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "IcarusFirstMeeting" },
			},
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 6,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty", },
			},
		},

		Ambience = "/Leftovers/Ambience/GentleWavesBeachAmbience2D",
		SecretMusic = "/Music/IrisMusicCirceTheme_MC",
		ZoomFraction = 0.85,
		TimerBlock = "StoryRoom",

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Circe_01" },
		StartUnthreadedEvents =
		{
		},

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.6,
				SuccessiveChanceToPlay = 0.25,

				{ Cue = "/VO/MelinoeField_1878", Text = "An island... who...?", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/MelinoeField_1879", Text = "Circe's island..." },
				{ Cue = "/VO/MelinoeField_1881", Text = "I know this place..." },
				{ Cue = "/VO/MelinoeField_1882", Text = "A bit of solid ground..." },
				{ Cue = "/VO/MelinoeField_1880", Text = "The Isle of Aiaia...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "CirceAboutHut01" },
						},
					},
				},
			},
		},

		ObstacleData =
		{
			-- Pig Pen
			[744056] =
			{
				Name = "PigPen",
				DistanceTriggers =
				{
					{
						WithinDistance = 250,
						VoiceLines =
						{
							UsePlayerSource = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" }
								},
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},
							{ Cue = "/VO/MelinoeField_1883", Text = "Hail, piggies." },
							{ Cue = "/VO/MelinoeField_1884", Text = "Evening, little pigs." },
							{ Cue = "/VO/MelinoeField_1885", Text = "At ease, piggies." },
							{ Cue = "/VO/MelinoeField_1886", Text = "Behave yourselves." },
						},
					},
				},
			},
		},


		InspectPoints =
		{
			[744051] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_Story01_01 =
					{
						{ Cue = "/VO/Storyteller_0267",
							Text = "{#Emph}Behold that ancient isle on which a great enchantress plies her trade, amid such flora and fauna as have come to welcome her as one of their own." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1846", Text = "It feels so safe and peaceful here..." },
							},
						},
					},
				},
			},
			[744052] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_O_Story01_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_Story01_02 =
					{
						{ Cue = "/VO/Storyteller_0268",
							Text = "{#Emph}The sweet and pungent aromas emanating from the cauldron of the witch-enchantress Circe suggest the depth of her ability, whether as a practitioner of ancient arts, or as a cook." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_1847", Text = "I can breathe freely here..." },
							},
						},
					},
				},
			},

		},

		ThreadedEvents =
		{
			{ FunctionName = "MedeaMusicManager" },
		},

		ExorcismPointRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsNone = { "FrogFamiliar" },
			},
		},
		FishingPointRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsNone = { "CatFamiliar" },
			},
		},
		PickaxePointRequirements =
		{
			{
				Path = { "GameState", "EquippedFamiliar" },
				IsNone = { "RavenFamiliar" },
			},
		},
	},

}
AddTableKeysCheckDupes( RoomData, RoomSetData.O )