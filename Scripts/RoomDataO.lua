RoomSetData.O =
{
	BaseO =
	{
		DebugOnly = true,
		RichPresence = "#RichPresence_O",
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

		LocationAnimName = "InfoBannerThessalyIn",
		LocationAnimOutName = "InfoBannerThessalyOut",

		HarvestPointChances =
		{
			0.30,
		},

		HarvestPointRequirements =
		{
			{
				SumPrevRooms = 3,
				Path = { "NumHarvestPoints" },
				Comparison = "<=",
				Value = 0,
			},
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantODriftwood" },
						Comparison = "<",
						Value = 16,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},
		ShovelPointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
			},
			{
				SumPrevRooms = 4,
				Path = { "NumShovelPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumPickaxePoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumExorcismPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumFishingPoints" },
				Comparison = "<=",
				Value = 0,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantOMandrakeSeed" },
						Comparison = "<",
						Value = 12,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
					{
						SumPrevRooms = 2,
						Path = { "NumPickaxePoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
		},
		PickaxePointRequirements =
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
			{
				SumPrevRooms = 1,
				Path = { "NumShovelPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumExorcismPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumFishingPoints" },
				Comparison = "<=",
				Value = 0,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreOIron" },
						Comparison = "<",
						Value = 24,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
					{
						SumPrevRooms = 2,
						Path = { "NumShovelPoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
		},
		ExorcismPointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
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
				SumPrevRooms = 1,
				Path = { "NumShovelPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumPickaxePoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumFishingPoints" },
				Comparison = "<=",
				Value = 0,
			},

			OrRequirements =
			{
				-- collection
				{
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
								Comparison = "<=",
								Value = 1500,
							},
						},
						{
							{
								Path = { "GameState", "ExorcisedNames", "ShadeShipsOneIdle" },
								Comparison = "<",
								Value = 2,
							},
						},
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
					{
						SumPrevRooms = 2,
						Path = { "NumFishingPoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
		},
		FishingPointRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
			},
			{
				SumPrevRooms = 5,
				Path = { "NumFishingPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumShovelPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumPickaxePoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumExorcismPoints" },
				Comparison = "<=",
				Value = 0,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", },
						NotHasAll = { "FishOCommon", "FishORare", "FishOLegendary" },
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
					{
						SumPrevRooms = 2,
						Path = { "NumExorcismPoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
		},

		SecretSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SurfaceShopSpawnChance = 0.125,
		TargetMetaRewardsRatio = 0.30,

		BreakableValueOptions = { MaxHighValueBreakables = 0 },

		ChallengeSpawnRequirements =
		{
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 1,
			},
			{
				FunctionName = "RequiredMinRoomsSinceEvent",
				FunctionArgs = { Event = "ChallengeSwitch", Count = 3 },
			},
		},
		TimeChallengeSwitchRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitchesSurface1" },
			},
		},
		TimeChallengeEncounterOptions = { "TimeChallengeO" },
		PerfectClearEncounterOptions = { "PerfectClearChallengeO" },
		EliteChallengeEncounterOptions = { "EliteChallengeO" },

		EntranceFunctionName = "ShipsRoomEntrancePresentation",
		EntrancePresentationDelay = 3,

		ZoomFraction = 0.80,
		EntranceDirection = "Right",
		FlipHorizontalChance = 0,

		-- LocationText = "BiomeO",
		SaveProfileLocationText = "BiomeO_Short",
		
		NarrativeContextArt = "DialogueBackground_Thessaly",
		NarrativeContextArtFlippable = false,

		Ambience = "/Ambience/ShipAmbienceLoop",
		ShopSecretMusic = "/Music/CharonShopTheme",
		StopSecretMusic = true,
		ReverbValue = 0.4,

		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/Leftovers/SFX/FootstepsWoodSmall",
			["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsWoodRun",
		},
		SwapAnimations =
		{
			["SpellMeteorCrater"] = "Blank",
			["OlympusSnowExplosionDecal"] = "ExplosionScorchDecal",
		},

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.1 }, Args = { StartingCountMin = 0, StartingCountMax = 12, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
			{ FunctionName = "HandleWrapping" },
		},
		ThreadedEvents =
		{
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					NamedRequirements = { "ShouldShowBountyInfoBanner" },
				},
			},
		},
		PostCombatReloadThreadedEvents =
		{
			{ FunctionName = "HandleWrapping" },
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					NamedRequirements = { "ShouldShowBountyInfoBanner" },
				},
			},
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
						IsNone = { "O_MiniBoss01", "O_Story01", "O_Shop01", "O_PreBoss01", "O_PostBoss01" },
					},
				},

				{ Cue = "/VO/MelinoeField_1815", Text = "This must have been the closest ship..." },
				{ Cue = "/VO/MelinoeField_1816", Text = "...I'll take it.", PreLineWait = 1.0 },
			}
		},
		MaxAppearancesThisBiome = 1,
	},

	O_Intro =
	{
		InheritFrom = { "BaseO", "BiomeStartRoom"},
		LegalEncounters = { "Empty" },

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

		HarvestPointChances = { 0.02, },
		ShovelPointChance = 0.02,
		PickaxePointChance = 0.02,
		--ExorcismPointChance = 0.02,
		HasFishingPoint = true,
		FishingPointChance = 0.35,

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
					-- toula appearance requirements
					{
						PathFalse = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
					},
					{
						Path = { "GameState", "RoomsEntered", "H_Bridge01" },
						Comparison = ">",
						Value = 1,
					},
					{
						Path = { "GameState", "FishingSuccesses" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				Args =
				{
					Id = 739846,
					Name = "CatFamiliar",
					SkipAISetup = true,
					OverwriteSelf =
					{
						InteractDistance = 250,
						OnUsedFunctionName = "nil",
						SpecialInteractFunctionName = "CatFamiliarSpecialInteractLockedInRun",
						PreRecruit = true,
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
									VoiceLines = { GlobalVoiceLines = "CatReactionVoiceLines" },
								},
							},
						}
					},
				},
			},
		},

		ThreadedEvents =
		{
			Threaded = true,
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					NamedRequirements = { "ShouldShowBountyInfoBanner" },
				},
			},
			{
				FunctionName = "CheckObjectiveSetSource",
				Args =
				{
					ObjectiveSetName = "BountyAdvancedTooltip",
				},
			},
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
				Args =
				{
					Text = "Location_BiomeO",
					AnimationName = "InfoBannerThessalyIn",
					AnimationOutName = "InfoBannerThessalyOut",
					Delay = 2.0,
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
						PathFalse = { "CurrentRun", "ActiveBounty" },
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
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_O_Intro_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
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
			[1] = { GlobalVoiceLines = "StartPackagedBountyRunVoiceLines" },
			[2] = { GlobalVoiceLines = "BiomeStateChangeStartVoiceLines" },
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
		FishingPointChance = 0.35,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		StoreDataName = "WorldShop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		NoReroll = true,
		ZoomFraction = 0.855,

		IntroPanDuration = 2,
		IntroSequenceDuration = 2,

		ZagContractDestinationId = 776332,

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

		AlwaysForceRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "==",
				Value = 5,
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "O_Shop01", },
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "O_Story01" },
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
						FunctionName = "GenericPresentation",
						Args =
						{
							UseableOff = true,
						},
					},
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
	
		LinkedRooms = { "O_Boss01", "O_Boss02" },

		ForceAtBiomeDepthMin = 7,
		ForceAtBiomeDepthMax = 7,

		IntroPanDuration = 2,
		IntroSequenceDuration = 2.0,

		GameStateRequirements =
		{
			-- None
		},
		
		ZagContractRewardDestinationId = 776340,
		
		SecretSpawnChance = 0.0,

		HarvestPointChances = { 0.35, },

		SurfaceShopSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,

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
		RushMaxRangeOverride = 565,

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
						FunctionName = "GenericPresentation",
						Args =
						{
							UseableOff = true,
						},
					},
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
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "O_Boss01", "O_Boss02" },
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
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = "<",
					Value = 2,
				},
			},
		},

		SpeakerName = { "Selene" },

		RequiresLinked = true,
		LinkedRoom = "O_PostBoss01",
		ExitPreviewAnim = "ExitAheadPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",
		NarrativeContextArt = "DialogueBackground_BossRoom_Eris",

		BackupCauseOfDeath = "Eris",

		HasFishingPoint = true,

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
		EntranceFunctionArgs = { BossId = 558020, BossIntroAnimation = "Enemy_Eris_Intro", },
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
		StartThreadedEvents =
		{
		},

		EnterVoiceLines =
		{
			{ GlobalVoiceLines = "ErisBossGreetingLines" },
		},

		LeavePostPresentationEvents =
		{
			{
				FunctionName = "BiomeMapPresentation",
				Args =
				{
					HeroStartOffsetX = 620 + -580,
					HeroStartOffsetY = -585 + -300,

					FamiliarStartOffsetX = 710 + -580,
					FamiliarStartOffsetY = -535 + -300,

					HeroMoveOffsetX = -15,
					HeroMoveOffsetY = -630,
					HeroMoveDuration = 1.4,

					FamiliarMoveOffsetX = -15,
					FamiliarMoveOffsetY = -630,
					FamiliarMoveDuration = 1.4,

					MoveEaseIn = 0.5,
					MoveEaseOut = 1.0,

					CameraEndOffsetY = 205,

					BiomeStart = "BiomeO",
					BiomeEnd = "BiomeP",
					PreviousBiomes = { "BiomeN" },

					ShrineBounty = "BossPrometheus01",

					CrossroadsStart = false,
					
				},
				GameStateRequirements =
				{
					-- None
				}
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

	O_Boss02 =
	{
		InheritFrom = { "BaseO" },
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = ">=",
					Value = 2,
				},
			},
		},

		SpeakerName = { "Selene" },

		RequiresLinked = true,
		LinkedRoom = "O_PostBoss01",
		ExitPreviewAnim = "ExitAheadPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",
		NarrativeContextArt = "DialogueBackground_BossRoom_Eris",

		BackupCauseOfDeath = "Eris",

		HasFishingPoint = true,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossEris02", },
		ForcedReward = "MixerOBossDrop",
		NoReroll = true,

		Ambience = "/Leftovers/Ambience/GentleWavesBeachAmbience2D",
		SwapSounds =
		{
			["/SFX/Player Sounds/ZagreusGunReloading"] = "/SFX/Player Sounds/ZagreusGunReloadingLucifer",
			["/SFX/Player Sounds/ZagreusGunGrenadeBounce"] = "/SFX/Player Sounds/ZagreusLuciferBombLand",
			["/SFX/Player Sounds/ZagreusGunGrenadeGasReleaseFly"] = "/SFX/Player Sounds/ZagreusLuciferSpecialSmokeTrail",
			["/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire"] = "/SFX/Player Sounds/ZagreusLuciferSpecialFire",
		},

		EntranceFunctionName = "RoomEntranceBossShips",
		EntranceFunctionArgs = { BossId = 744503, BossIntroAnimation = "Enemy_Eris_Intro", },
		IntroSequenceDuration = 2.3,
		BlockCameraReattach = true,
		ZoomFraction = 0.7,
		ZeusManaSpawnPoints = { 744610, 744615, 744609, 744616, 744608, 744617, 744607, 744618, },
		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 744503 },
					SetupBossIds = { 744503 },
					SkipAngleTowardTarget = true,
					DelayedStart = true,
				},
			},
		},
		StartThreadedEvents =
		{
		},

		LeavePostPresentationEvents =
		{
			{
				FunctionName = "BiomeMapPresentation",
				Args =
				{
					HeroStartOffsetX = 620 + -580,
					HeroStartOffsetY = -585 + -300,

					FamiliarStartOffsetX = 710 + -580,
					FamiliarStartOffsetY = -535 + -300,

					HeroMoveOffsetX = -15,
					HeroMoveOffsetY = -630,
					HeroMoveDuration = 1.4,

					FamiliarMoveOffsetX = -15,
					FamiliarMoveOffsetY = -630,
					FamiliarMoveDuration = 1.4,

					MoveEaseIn = 0.5,
					MoveEaseOut = 1.0,

					CameraEndOffsetY = 205,

					BiomeStart = "BiomeO",
					BiomeEnd = "BiomeP",
					PreviousBiomes = { "BiomeN" },

					ShrineBounty = "BossPrometheus01",

					CrossroadsStart = false,
					
				},
				GameStateRequirements =
				{
					-- None
				}
			},
		},

		InspectPoints =
		{
			[793950] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_Boss02_01 =
					{
						{ Cue = "/VO/Storyteller_0424",
							Text = "{#Emph}A hidden secret of the ancient weapon wielded by the erratic embodiment of Strife proved not quite unpredictable enough to take the Underworld Princess off her guard." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_3617", Text = "May the Rail's next bearer be more responsible." },
						},
					},
				},
			},
			[794212] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_O_Boss02_01" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_Boss02_02 =
					{
						{ Cue = "/VO/Storyteller_0459",
							Text = "{#Emph}A foul shoreline that should never have existed mars the border of the Rift, beyond which stately Mount Olympus looms, stricken this night by Strife and Fear in turn." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3657", Text = "The other beach was quite a bit nicer..." },
						},
					},
				},
			},
		},

		EnterVoiceLines =
		{
			{ GlobalVoiceLines = "ErisBossGreetingLines" },
		},
	},
	
	O_PostBoss01 =
	{
		InheritFrom = { "BaseO" },
		RichPresence = "#RichPresence_PostBossSurface",
		LegalEncounters = { "Empty" },

		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,

		EntranceFunctionName = "RoomEntranceStandard",

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		NextRoomSet = { "P", },
		ExitPreviewAnim = "ExitAheadPreview",
		BlockRunProgressUI = true,
		Ambience = "/Leftovers/SFX/WindAmbienceLocal",
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,
		ReverbValue = 1.0,
		GlobalEcho = 0.0,

		Music = "/Music/IrisMusicBiomeStartOlympus_MC",
		DefaultMusicParams = { "Keys", "Drums", },
		BlockRandomStems = true,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.7,

		ExitPath = { 558947 },

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		SurfaceShopSpawnChance = 1.0,
		ForceSurfaceShop = true,

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,
		HarvestPointChances =
		{
			0.0,
		},
		ShovelPointChance = 0.0,
		PickaxePointChance = 0.0,
		ExorcismPointChance = 0,
		FishingPointChance = 0,

		WellShopSpawnChance = 0.0,
		ForceWellShop = false,
		SecretSpawnChance = 0.0,
		SellTraitShrineUpgrade = true,

		StartUnthreadedEvents = {},

		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsSnow",
			["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsSnow",
		},

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
			[723017] =
			{
				Template = "HealthFountainO",
				Activate = true,
				ActivateIds = { 723017, },
				SetupGameStateRequirements =
				{
					-- None
				},
			},
			[723007] =
			{
				Template = "GiftRack",
				Activate = true,
				ActivateIds = { 723007, 723011, 723009, 723008, 723014, },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossGiftRack", },
					},
				},
			},
			[723015] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				ActivateIds = { 723015 },
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
			[557494] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_O_PostBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0294",
							Text = "{#Emph}A passageway through the snow-covered rock leads to the foot of the most-sacred mountain of the gods: Olympus, which now looms impossibly into the sky above." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_2524", Text = "Bit of a climb..." },
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
				{ Name = "LeftBiomeSpeech", Time = 10 },
			},
			{
				PreLineWait = 3.2,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.15,

				{ Cue = "/VO/MelinoeField_2451", Text = "The path to Olympus...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2452", Text = "The base of the mountain..." },
				{ Cue = "/VO/MelinoeField_2453", Text = "Growing colder..." },
				{ Cue = "/VO/MelinoeField_2454", Text = "This is it..." },
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
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "O_MiniBoss02" },
			},
		},	

		LegalEncounters = { "MiniBossCharybdis" },
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.60,

		IntroSequenceDuration = 3.0,
		IntroPanDuration = 1.0,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.10, Rare = 0.90 },
		ForceDoorAllowReroll = true,
		DisableRewardMagnetisim = true,

		StartUnthreadedEvents =
		{
			
		},

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

		CombatResolvedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
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
								BreakIfPlayed = true,
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_1870" },
									},
								},
								{ Cue = "/VO/Melinoe_3066", Text = "Oh great." },
							},
							{
								BreakIfPlayed = true,
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "SpeechRecord", "/VO/MelinoeField_1870" },
									},
								},
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

	O_MiniBoss02 =
	{
		InheritFrom = { "BaseO", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "O_MiniBoss01" },
			},
		},	

		LegalEncounters = { "MiniBossCaptain" },
		FlipHorizontalChance = 0.0,

		IntroSequenceDuration = 2.1,
		IntroPanDuration = 2.0,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.10, Rare = 0.90 },
		ForceDoorAllowReroll = true,

		StartUnthreadedEvents =
		{
			
		},

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		MaxCreationsThisRun = 1,
		MaxAppearancesThisBiome = 1,	

		CombatResolvedVoiceLines =
		{
			{ GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
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
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723376, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723376, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723377, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},

		InspectPoints =
		{
			[793020] =
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
					Inspect_O_MiniBoss02_01 =
					{
						{ Cue = "/VO/Storyteller_0359",
							Text = "{#Emph}One of the sleeker, broader ghostly ships in the armada of the Titan Lord is now bereft of all the plunderers that were its crew; but in their restlessness, they may yet rise again." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3261", Text = "Then I'll sink them again." },
							},
						},
					},
				},
			},

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

		MultipleEncountersData =
		{
			{ LegalEncounters = EncounterSets.OEncountersIntros }, -- Pre-Spawned Enemies
			{ LegalEncounters = EncounterSets.OEncountersDefault }, -- First Encounter
			{ LegalEncounters = EncounterSets.OEncountersDefault, GameStateRequirements = { ChanceToPlay = 0.6,
					{
						Path = { "CurrentRun", "BiomeEncounterDepth" },
						Comparison = "<",
						Value = 6,
					},
					{
						Path = { "CurrentRun", "BiomeEncounterDepth" },
						Comparison = ">",
						Value = 1,
					},
				},
			}, -- Second Encounter
		},
	},

	O_CombatDataSmall =
	{
		InheritFrom = { "O_CombatData" },
		DebugOnly = true,
	},

	O_CombatDataMedium =
	{
		InheritFrom = { "O_CombatData" },
		DebugOnly = true,
	},

	O_CombatDataLarge =
	{
		InheritFrom = { "O_CombatData" },
		DebugOnly = true,
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

		SpawnRewardOnLootPoint = true,

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

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	O_Combat05 =
	{
		InheritFrom = { "O_CombatDataLarge", "BaseO" },

		SpawnRewardOnLootPoint = true,

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

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	O_Combat08 =
	{
		InheritFrom = { "O_CombatDataMedium", "BaseO" },

		SpawnRewardOnLootPoint = true,

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

		SpawnRewardOnLootPoint = true,

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

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 3,
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

	O_Combat14 =
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
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723376, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723376, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723377, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Combat15 =
	{
		InheritFrom = { "O_CombatDataMedium", "BaseO" },

		SpawnRewardOnLootPoint = true,

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 3,
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
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723375, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723376, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },
					{ Id = 723376, GroupName = "WaterAbove_01", ObstacleColorOverrides = { ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } } },

					{ Id = 723377, GroupName = "Foreground_01", ObstacleGroupOverrides = { ShipsWreckGroup01 = "Standing_Debris", ShipsWreckGroup02 = "Standing_Debris" }, ObstacleColorOverrides = { ShipsShipwreck01 = { 35, 51, 62, 255 }, ShipsWreckGroup01 = { 141, 141, 141, 255 }, ShipsWreckGroup02 = { 141, 141, 141, 255 } }, ObstacleHSVOverrides = { ShipsWreckGroup01 = { -0.088, 0, 0 }, ShipsWreckGroup02 = { -0.088, 0, 0 } }, SkipPreSpawn = true,},
				},
			},
		},
	},

	O_Devotion01 =
	{
		InheritFrom = { "BaseO" },

		ForcedRewardStore = "RunProgress",
		ForcedReward = "Devotion",
		HasFishingPoint = true,
		FishingPointChance = 0.80,

		Ambience = "/Leftovers/Object Ambiences/GentleWavesBeachAmbienceQuiet",
		
		MaxCreationsThisRun = 1,
		EntranceFunctionArgs = { SkipGusts = true },
		
		IntroPanDuration = 2.0,
		IntroSequenceDuration = 2.0,
		IntroZoomFactor = 0.6,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "PoseidonDevotionIntro01" }
			},
			{
				Path = { "GameState", "EncountersOccurredCache" },
				HasAny = {
					"DevotionTestF",
					"DevotionTestG",
					"DevotionTestH",
					"DevotionTestI",
					"DevotionTestN",
					"DevotionTestP",
				},
			},
			{
				Path = { "CurrentRun", "LootTypeHistory" },
				CountOf =
				{
					"AphroditeUpgrade",
					"ApolloUpgrade",
					"DemeterUpgrade", 
					"HephaestusUpgrade",
					"HestiaUpgrade",
					"HeraUpgrade",
					"PoseidonUpgrade",
					"ZeusUpgrade",
				},
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 2,
			},
		},

		InspectPoints =
		{
			[761006] =
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
					Inspect_O_Devotion_01 =
					{
						{ Cue = "/VO/Storyteller_0308",
							Text = "{#Emph}Before the land was split, mortals would gather in great competitions for the glory of the gods; but now, the gods themselves appear to fight over the few remaining scraps." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3249", Text = "There's still enough for all of us, I think." },
							},
						},
					},
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
		ForceDoorAllowReroll = true,

		EntranceFunctionArgs = { SkipGusts = true },

		SwapSounds =
		{
		},

		FlipHorizontalChance = 0.0,
		SpawnRewardOnId = 695602,
		DisableRewardMagnetisim = true,
		IntroSequenceDuration = 2.1,
		IntroPanDuration = 2.0,

		SurfaceShopSpawnChance = 1.0,
		ChallengeSpawnChance = 0.0,

		HasFishingPoint = true,

		HarvestPointChances = { 0.6, 0.4, },
		ShovelPointChance = 0.24,
		PickaxePointChance = 0.36,
		ExorcismPointChance = 0.24,
		FishingPointChance = 0.8,

		IgnoreHarvestBiomeSpawnLimit = true,

		StartThreadedEvents =
		{			
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 1.0 }, Args = { StartingCountMin = 24, StartingCountMax = 36, ObjectNames = { "ShadeMerc" }, MaxActive = 36 } },
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeThessalyReprieve" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
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
		InheritFrom = { "BaseO" },
		HasFishingPoint = true,
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		NarrativeContextArt = "nil",

		FishingPointChance = 0.40,

		HarvestPointRequirements =
		{
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantODriftwood" },
						Comparison = "<",
						Value = 8,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},
		ShovelPointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantOMandrakeSeed" },
						Comparison = "<",
						Value = 12,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},
		PickaxePointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreOIron" },
						Comparison = "<",
						Value = 18,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},

		IgnoreHarvestBiomeSpawnLimit = true,

		Ambience = "/Leftovers/Object Ambiences/GentleWavesBeachAmbienceQuiet",

		EntranceFunctionArgs = { SkipGusts = true },
		
		IntroPanDuration = 2.0,
		IntroSequenceDuration = 2.0,

		SwapSounds =
		{
		},

		ZoomFraction = 0.68,
		CameraZoomWeights =
		{
			[772430] = 1.00,
			[772431] = 1.85,
			[772432] = 0.93,
			[772433] = 0.93,
		},

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
				Value = 5,
			},
			NamedRequirementsFalse = { "StandardPackageBountyActive" },
		},

		AlwaysForceRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "==",
				Value = 5,
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "O_Shop01", },
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "O_Story01" },
			},
		},

		SecretMusic = "/Music/IrisMusicCirceTheme_MC",
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
			-- Hut Door
			[744068] =
			{
				Name = "CirceHutInteract",
				InteractDistance = 250,
				-- InteractOffsetX = -10,
				-- InteractOffsetY = 80,
				-- AnimOffsetZ = 180,
				UseText = "CannotUseObject",
				OnUsedFunctionName = "UseLockedSystemObjectPresentation",
				OnUsedFunctionArgs = { VoiceLines = "TriedCirceHutVoiceLines", SoundName = "/Leftovers/SFX/DoorClose", SkipAnim = true, BlockAngleTowardTarget = true },
				Activate = true,
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
				},
				SetupEvents =
				{
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							Animation = "Blank",
						},
					}
				},
			},

			-- Pig Pen
			[744056] =
			{
				Name = "PigPen",
				DistanceTriggers =
				{
					{
						WithinDistance = 350,
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
							{ Cue = "/VO/MelinoeField_1884", Text = "Evening, little pigs.", PlayFirst = true },
							{ Cue = "/VO/MelinoeField_1886", Text = "Behave yourselves.",
								GameStateRequirements =
								{
									{
										PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/Circe_0169" },
									},
								},
							},
							{ Cue = "/VO/MelinoeField_1883", Text = "Hail, piggies.",
								GameStateRequirements =
								{
									OrRequirements =
									{
										{
											{
												PathTrue = { "GameState", "TextLinesRecord", "CirceAboutThessaly01" },
											},
										},
										{
											{
												PathTrue = { "GameState", "SpeechRecord", "/VO/Circe_0085" },
											},
										},
									},
								},
							},
							{ Cue = "/VO/MelinoeField_1885", Text = "At ease, piggies.",
								GameStateRequirements =
								{
									OrRequirements =
									{
										{
											{
												PathTrue = { "GameState", "TextLinesRecord", "CirceAboutThessaly01" },
											},
										},
										{
											{
												PathTrue = { "GameState", "SpeechRecord", "/VO/Circe_0085" },
											},
										},
									},
								},
							},
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
	},

}
AddTableKeysCheckDupes( RoomData, RoomSetData.O )