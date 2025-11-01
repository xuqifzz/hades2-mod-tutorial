RoomSetData.Q =
{
	BaseQ =
	{
		DebugOnly = true,
		RichPresence = "#RichPresence_Q",
		ResultText = "RunHistoryScreenResult_Q",

		-- LocationText = "BiomeQ",
		SaveProfileLocationText = "BiomeQ_Short",

		NarrativeContextArt = "DialogueBackground_Typhon",
		NarrativeContextArtFlippable = false,

		LegalEncounters = EncounterSets.QEncountersDefault,
		IneligibleRewards = { "Devotion", },

		Ambience = "/Ambience/TyphonIndoorAmbience",

		MaxAppearancesThisBiome = 1,

		ZoomFraction = 0.8,

		ExitFunctionName = "BiomeQLeaveRoomPresentation",

		EnterWipeAnimation = "RoomTransitionOut_Up",

		BreakableValueOptions = { MaxHighValueBreakables = 8 },

		StopSecretMusic = true,

		ValidateSecretData = false,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,

		SecretSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SurfaceShopSpawnChance = 0.10,
		TargetMetaRewardsRatio = 0.15,

		LocationAnimName = "InfoBannerTyphonIn",
		LocationAnimOutName = "InfoBannerTyphonOut",

		TimeChallengeSwitchRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitchesSurface1" },
			},
		},
		TimeChallengeEncounterOptions = { "TimeChallengeQ" },
		PerfectClearEncounterOptions = { "PerfectClearChallengeQ" },
		EliteChallengeEncounterOptions = { "EliteChallengeQ" },

		HarvestPointChances =
		{
			0.10,
		},
		ShovelPointChance = 0.10,
		PickaxePointChance = 0.10,
		ExorcismPointChance = 0.05,
		FishingPointChance = 0.15,

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
						Path = { "GameState", "LifetimeResourcesGained", "PlantQFang" },
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
						Path = { "GameState", "LifetimeResourcesGained", "PlantQSnakereedSeed" },
						Comparison = "<",
						Value = 18,
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
						Path = { "GameState", "LifetimeResourcesGained", "OreQScales" },
						Comparison = "<",
						Value = 12,
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
								Path = { "GameState", "ExorcisedNames", "ShadeTyphonIdle" },
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
						NotHasAll = { "FishQCommon", "FishQRare", "FishQLegendary" },
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

		RandomStemMixerValues =
		{
			{
				SetSoundCueValues =
				{
					{
						Name = "Drums",
						Value = 1.0,
						Duration = 0.25,
					},
					{
						Name = "Bass",
						Value = 0.0,
						Duration = 0.25,
					},
				},
			},
		},
		IgnorePostCombatGuitar = true,

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
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					NamedRequirements = { "ShouldShowBountyInfoBanner" },
				},
			},
		},
	},

	Q_Intro =
	{
		InheritFrom = { "BaseQ", "BiomeStartRoom" },

		Tags = { "Outdoor" },

		LegalEncounters = { "Empty" },
		GlobalEcho = 0.5,

		ZoomFraction = 0.6,
		IntroSequenceDuration = 0.96,

		ExitFunctionName = "FortressMainDoorOpenPresentation",

		BreakableHighValueChanceMultiplier = 0.33,

		HarvestPointChances = { 0.02, },
		ShovelPointChance = 0.02,
		PickaxePointChance = 0.02,
		ExorcismPointChance = 0.02,
		FishingPointChance = 0.02,

		RushMaxRangeOverride = 475,

		Ambience = "/Ambience/TyphonOutdoorAmbience",

		Starting = true,
		NoReward = true,
		NoReroll = true,
		HideRewardPreview = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceFunctionName = "QIntroEntrancePresentation",
		Using = { Animation = { "HeroSkyTouchdown", "SandPortalExit_Down", "RoomTransitionOut_TimeWarp"}, },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		EntranceDirection = "Right",
		FlipHorizontal = false,
		FlipHorizontalChance = 0.0,

		ForceAtBiomeDepth = 1,
		MaxAppearancesThisBiome = 1,

		FootstepAnimationR = "WaterSplashFootstepR-Spawner",
		FootstepAnimationL = "WaterSplashFootstepL-Spawner",
		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/Leftovers/SFX/FootstepsWetSmall",
			["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsWetMedium",
		},
		SwapAnimations =
		{
			["HeroSkyTouchdownOlympus"] = "HeroSkyTouchdownTyphon",
		},

		StartThreadedEvents =
		{
			{ FunctionName = "TyphonCameraRaindropsPresentation", },
			{ FunctionName = "HandleWrapping" },
		},

		WrappingData =
		{
			ObstacleWrapData =
			{
				{
					Ids = { 769460, 792209, 792211 },
					ResetOffsetDistance = -2000,
					MoveSpeed = 40,
					MoveTime = 240,
				},
				{
					Ids = { 769456, 769459, 769464, 769462, 792212, 792210 },
					ResetOffsetDistance = -4500,
					MoveSpeed = 70,
					MoveTime = 160,
				},
				{
					Ids = { 769461, 792213 },
					ResetOffsetDistance = -2000,
					MoveSpeed = 100,
					MoveTime = 60,
				}
			}
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "EndBiomeRecords", },
		},

		DistanceTriggers =
		{
			{
				TriggerGroup = "OverlookOut",
				WithinDistance = 150,
				FunctionName = "BiomeOverlookTyphon",
				Repeat = true,
				Args =
				{
					PanTargetId = 768079,
					ZoomFraction = 0.3,
					FirstAppearanceTime = 7,
					MinAppearanceTime = 6,
					AppearanceChancePerSecond = 0.12,
					TyphonCreatureId = 769563,
					OverlookFadeIds = { 769413, 769135, },
				},
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "BiomeBackToRoomTyphon", Args = { OverlookFadeIds = { 769413, 769135, }, }, Repeat = true,
			},
		},

		ThreadedEvents =
		{
			Threaded = true,
			{
				FunctionName = "DisplayInfoBanner",
				Args =
				{
					Text = "Location_BiomeQ",
					AnimationName = "InfoBannerTyphonIn",
					AnimationOutName = "InfoBannerTyphonOut",
					Delay = 2.0,
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "ShouldShowBountyInfoBanner" },
				},
			},
			{
				FunctionName = "DisplayInfoBanner",
				Args =
				{
					Text = "Location_BiomeQ_Alt",
					AnimationName = "InfoBannerTyphonIn",
					AnimationOutName = "InfoBannerTyphonOut",
					Delay = 2.0,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "ShouldShowBountyInfoBanner" },
				},
			},
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

		-- IgnoreMusic = true,
		GateMusic = "/Music/IrisMusicTyphon1_MC",

		EnterVoiceLines =
		{
			{
				PreLineWait = 1.5,
				PlayOnce = true,
				PlayOnceContext = "SummitIntroVO",

				{ Cue = "/VO/MelinoeField_2927", Text = "This... storm...!" },
			},
			{
				BreakIfPlayed = true,
				PlayOnce = true,
				PlayOnceContext = "SummitPostTrueEndingIntroVO",
				PreLineWait = 3.15,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

				{ Cue = "/VO/MelinoeField_4198", Text = "{#Emph}Whew... {#Prev}I'm back." },
				{ Cue = "/VO/Melinoe_5724", Text = "All right, Grandfather... let's put your theories to the test..." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 3.15,
				SuccessiveChanceToPlay = 0.25,
				SuccessiveChanceToPlayAll = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_2928", Text = "What happened here...", PlayFirst = true, PlayOnce = true, PlayOnceContext = "QIntroFirstVisitSpeech" },
				{ Cue = "/VO/MelinoeField_2929", Text = "The mountain's tallest peak..." },
				{ Cue = "/VO/MelinoeField_4198", Text = "{#Emph}Whew... {#Prev}I'm back.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							SumPrevRuns = 8,
							Path = { "SpeechRecord", "/VO/MelinoeField_4198" },
							CountPathTrue = true,
							Comparison = "==",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4199", Text = "{#Emph}Whew... {#Prev}Typhon's storm...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4198" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4200", Text = "{#Emph}Whew... {#Prev}Another possibility...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4198" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2930", Text = "All right, Typhon...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2931", Text = "Typhon awaits...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
						},
					},
				},
			},
		},

		InspectPoints =
		{
			[792127] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomCountCache", "Q_Intro" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Intro_01 =
					{
						{ Cue = "/VO/Storyteller_0330",
							Text = "{#Emph}At first, the storm which now engulfs the summit of Olympus may appear to have been wrought by gods in their defense; but its monstrosity belies a far more sinister nature." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								BreakIfPlayed = true,
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
									},
								},
								{ Cue = "/VO/MelinoeField_3251", Text = "Let's locate the source." },
							},
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
									},
								},
								{ Cue = "/VO/MelinoeField_3252", Text = "...Typhon." },
							},
						},
					},
				},
			},
			[792128] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_Q_Intro_01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Intro_02 =
					{
						{ Cue = "/VO/Storyteller_0331",
							Text = "{#Emph}The Fortress of the Gods reels against the incomparable rage of Typhon, Father of Monsters, Giant of Storms, who somehow lurks somewhere very nearby..." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3253", Text = "We'll find {#Emph}him {#Prev}or the other way around..." },
							},
						},
					},
				},
			},
			[792129] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_Q_Intro_01" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},					
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Intro_03 =
					{
						{ Cue = "/VO/Storyteller_0332",
							Text = "{#Emph}Apocalyptic Typhon, lord and father of monstrosity, has fallen to the gods before; and for that ancient bitter loss, he now exacts a most terrible price." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3254", Text = "He'll soon be falling to the gods again." },
							},
						},
					},
				},
			},
			[797654] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Intro_04 =
					{
						{ Cue = "/VO/Storyteller_0521",
							Text = "{#Emph}The storm of Typhon, which no longer plagues Olympus, once again engulfs the Princess of the Dead... for there are possibilities in which the Father of All Monsters lives." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_5024", Text = "Well not for long." },
							},
						},
					},
				},
			},

		},

	},

	Q_CombatData =
	{
		InheritFrom = { "BaseQ" },
		DebugOnly = true,

		ZoomFraction = 0.9,
		IntroSequenceDuration = 0.4,
		IntroPanEaseIn = 0.01,
		IntroPanEaseOut = 0.001,

		NoReward = true,

		PostCombatEvents =
		{
			{
				FunctionName = "TyphonTremorPresentation",
				GameStateRequirements =
				{
					ChanceToPlay = 1.0,
					{
						PathFalse = { "GameState", "TyphonTremorPresentation" }
					},
				},
				Args = { DelayMin = 0.0, DelayMax = 1.5 },
			},
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 2,
			},
		},
	},

	Q_Combat01 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0,
		Ambience = "/Ambience/TyphonOutdoorAmbience",

		GameStateRequirements =
		{
			Append = true,
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 7,
			},
		},
	},

	Q_Combat02 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Right",

		GameStateRequirements =
		{
			Append = true,
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 7,
			},
		},
	},

	-- Two exit before first Miniboss
	Q_Combat03 =
	{
		InheritFrom = { "Q_CombatData" },
		HasFishingPoint = false,

		EntranceDirection = "Right",

		LegalEncounters = EncounterSets.QEncountersIslands,

		RushMaxRangeOverride = 550,

		ForceAtBiomeDepth = 2,

		RequireCompletedIntro = true,
	},

	Q_Combat04 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Right",

		GameStateRequirements =
		{
			Append = true,
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 7,
			},
		},
	},

	-- Two exit before first Miniboss
	Q_Combat05 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Right",

		LegalEncounters = EncounterSets.QEncountersIslands,

		RushMaxRangeOverride = 550,

		ForceAtBiomeDepth = 2,
		
		RequireCompletedIntro = true,

		HoundFamiliarMovementRequiresLineOfSight = true,
	},

	Q_Combat06 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Right",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">",
				Value = 3,
			},
		},
	},

	Q_Combat07 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Left",
	},

	Q_Combat08 =
	{
		InheritFrom = { "Q_CombatData" },
		HasFishingPoint = false,

		EntranceDirection = "Right",
		Ambience = "/Ambience/TyphonOutdoorAmbience",

		GameStateRequirements =
		{
			Append = true,
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 7,
			},
		},
	},

	Q_Combat09 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Left",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">",
				Value = 3,
			},
		},
	},


	Q_BaseFoyer =
	{
		InheritFrom = { "BaseQ" },
		DebugOnly = true,

		ZoomFraction = 0.825,
		IntroSequenceDuration = 0.4,
		IntroPanEaseIn = 0.01,
		IntroPanEaseOut = 0.001,

		NoReward = true,
		DeferReward = false,
		UseDefaultRewardPreview = true,
		--ForceCurrentRoomDoorsAllowReroll = true,

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0,

		LegalEncounters = EncounterSets.QEncountersPreBoss,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "==",
				Value = 1,
			},
		},
	},

	Q_Combat10 =
	{
		InheritFrom = { "Q_BaseFoyer" },

		RushMaxRangeOverride = 475,
	},

	Q_Combat11 =
	{
		InheritFrom = { "Q_BaseFoyer" },
		
		RushMaxRangeOverride = 475,

		ZoomFraction = 0.8,

		GameStateRequirements =
		{
			Append = true,
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "TyphonIntro" },
			},
		},
	},

	-- Two exit before second Miniboss
	Q_Combat12 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Right",

		RushMaxRangeOverride = 525,

		ZoomFraction = 0.85,

		ForceAtBiomeDepth = 5,
	},

	Q_Combat13 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Right",

		ForceAtBiomeDepth = 5,
	},

	Q_Combat14 =
	{
		InheritFrom = { "Q_CombatData" },
		Ambience = "/Ambience/TyphonOutdoorAmbience",

		EntranceDirection = "Left",

		RushMaxRangeOverride = 550,
		
		ZoomFraction = 0.85,

		ForceAtBiomeDepth = 5,
	},

	Q_Combat15 =
	{
		InheritFrom = { "Q_CombatData" },
		Ambience = "/Ambience/TyphonOutdoorAmbience",

		EntranceDirection = "Left",

		RushMaxRangeOverride = 550,

		ForceAtBiomeDepth = 2,
	},

	Q_Combat16 =
	{
		InheritFrom = { "Q_CombatData" },

		EntranceDirection = "Left",
	},

	Q_PreBoss01 =
	{
		InheritFrom = { "BaseQ" },
		Ambience = "/Ambience/TyphonOutdoorAmbience",

		ZoomFraction = 0.8,

		ForceAtBiomeDepth = 7,

		LinkedRooms = { "Q_Boss01", "Q_Boss02" },
		EndMusicOnExit = true,
		ExitFunctionName = "FortressMainDoorOpenPresentation",
		IgnoreMusic = true,
		MusicMutedStems = { "Drums", "Bass", "Guitar", },

		GameStateRequirements =
		{
			-- None
		},
		
		ZagContractRewardDestinationId = 793525,
		
		SecretSpawnChance = 0.0,

		ShovelPointForceRequirements =
		{
			NamedRequirements = { "NoFamiliarShovelPointFoundThisBiome" },
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},
		PickaxePointForceRequirements =
		{
			NamedRequirements = { "NoFamiliarPickaxePointFoundThisBiome" },
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},

		SkipLastKillPresentation = true,
		
		LegalEncounters = { "TyphonShop" },
		ForcedFirstReward = "Shop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomMoneyDrop", },
		DisableRewardMagnetisim = true,

		StoreDataName = "Q_WorldShop",
		SkipShopSecretMusic = true,
		SpeakerName = "Hermes",

		ResetBinksOnExit = true,

		CameraZoomWeights =
		{
			[777418] = 0.92,
			[777417] = 1.23,
		},

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0,

		ExitTowardsFunctionName = "GenericPresentation",
		ExitTowardsFunctionArgs =
		{
			--[[
			SetSoundCueValues =
			{
				{
					Name = "Guitar",
					Value = 1.0,
					AudioStateId = "MusicId",
					Duration = 0.2,
				},
				{
					Name = "Drums",
					Value = 1.0,
					AudioStateId = "MusicId",
					Duration = 0.2,
				},
				{
					Name = "Bass",
					Value = 1.0,
					AudioStateId = "MusicId",
					Duration = 0.2,
				},
				{
					Name = "Keys",
					Value = 1.0,
					AudioStateId = "MusicId",
					Duration = 0.2,
				},
			},
			]]--
			EndMusic = true,
		},

		DistanceTriggers =
		{
			{
				Name = "HermesSpawnTrigger",
				TriggerId = 769407,
				WithinDistance = 800,
				FunctionName = "SpawnHermesInPerson",
				Args =
				{
					UnitName = "NPC_Hermes_01",
					SkipMusic = true,
					WaitTime = 0.0,
					PanTime = 1.5,
					SpawnPoints =
					{
						Q_PreBoss01 = 769407, 
					},
				},
				GameStateRequirements = 
				{
					{
						--
					},
				},
			},
		},

		InspectPoints =
		{
			[792126] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_PreBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0335",
							Text = "{#Emph}Some scarce deliveries risked by swift Hermes represent what aid the gods can finally provide unto the Princess of the Dead, now that the summit of Olympus lies before her." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3255", Text = "I'll take whatever I can get..." },
						},
					},
				},
			},
		},

		Using = { UnitName = "NPC_Hermes_01" },
	},

	Q_BaseMiniBoss =
	{
		InheritFrom = { "BaseQ" },
		DebugOnly = true,

		FlipHorizontalChance = 0.0,
		EntranceDirection = "LeftRight",

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,

		EntranceFunctionName = "RoomEntranceBoss",
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,
		
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",
		ForcedRewardStore = "TyphonBossRewards",
		BoonRaritiesOverride = { Duo = 0.2, Legendary = 0.2, Epic = 0.70, Rare = 1.00, },
		ForceDoorAllowReroll = true,

		RandomStemMixerValues =
		{
			{
				SetSoundCueValues =
				{
					{
						Name = "Drums",
						Value = 1.0,
						Duration = 0.25,
					},
					{
						Name = "Bass",
						Value = 1.0,
						Duration = 0.25,
					},
				},
			},
		},
		PostCombatAudioEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					SetSoundCueValues =
					{
						{
							Name = "Bass",
							Value = 0.0,
							AudioStateId = "MusicId",
							Duration = 0.75,
						},
					},
				},
			},
		},
	},

	-- Deferred
	Q_MiniBoss01 =
	{
		InheritFrom = { "Q_BaseMiniBoss" },
		DebugOnly = true,

		ZoomFraction = 0.75,

		LegalEncounters = { "BossTyphonArm01", },

		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 768121 },

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 768121 },
					SetupBossIds = { 768121, },
					DelayedStart = true,
					SkipAngleTowardTarget = true,
					SkipBossMusic = true,
				},
			},
		},
	},

	Q_MiniBoss02 =
	{
		InheritFrom = { "Q_BaseMiniBoss" },

		ForceAtBiomeDepth = 3,
		
		HasHarvestPoint = false,

		ZoomFraction = 0.825,
		EntranceFunctionName = "RoomEntranceBoss",
		EntranceFunctionArgs =
		{
			AngleTowardsIdOnEnd = 768689,
			BossId = 768689,
			BossIntroSound = "/SFX/Enemy Sounds/TyphonBrute/BruteRoar",
			BossIntroAnimation = "Enemy_Brute_Taunt",
			BossIntroDelay = 0.6,
		},
		IntroSequenceDuration = 1.1,
		BlockCameraReattach = true,
		ThreadEnterVoiceLines = true,

		LegalEncounters = { "MiniBossBrute", },
		BackupCauseOfDeath = "Brute_Miniboss",
		
		CauseOfDeathDisplayData = 
		{
			GameStateRequirements = 
			{
				{
					PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
				}
			},
			Name = "Brute_Miniboss_Alt",
		},

		EnterGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CombatResolvedVoiceLines =
		{
			{ GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		RushMaxRangeOverride = 525,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 768689 },
					SetupBossIds = { 768689, },
					DelayedStart = true,
					SkipBossMusic = true,
				},
			},
		},

		InspectPoints =
		{
			[780392] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_MiniBoss02_01 =
					{
						{ Cue = "/VO/Storyteller_0360",
							Text = "{#Emph}Endless horrors spewn from Typhon are of every shape and size, including relatively sinister and larger ones recently fallen to the Princess of the Underworld's wrath." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3262", Text = "I'll slay them all." },
						},
					},
				},
			},
		},

	},

	Q_MiniBoss03 =
	{
		InheritFrom = { "Q_BaseMiniBoss" },

		ForceAtBiomeDepth = 6,

		LegalEncounters = { "BossTyphonTail01", },
		BackupCauseOfDeath = "TyphonTail",
		
		CauseOfDeathDisplayData = 
		{
			GameStateRequirements = 
			{
				{
					PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
				}
			},
			Name = "TyphonTail_Alt",
		},
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 768130 },
		Ambience = "/Ambience/TyphonOutdoorAmbience",
		
		ZoomFraction = 0.765,
		EntranceFunctionName = "RoomEntranceStandard",
		IntroSequenceDuration = 0.4,
		IntroPanEaseIn = 0.01,
		IntroPanEaseOut = 0.001,

		HarvestPointChances = { 0.3, },
		ShovelPointChance = 0.3,
		PickaxePointChance = 0.3,
		ExorcismPointChance = 0.15,
		FishingPointChance = 0.45,

		UnthreadedEvents =
		{
			{
				FunctionName = "TyphonTailAmbushSetup",
				Args =
				{
					
				},
			},
		},

		DistanceTriggers =
		{
			-- jump scare the first time
			{
				Name = "TyphonTailTrigger",
				TriggerId = 768130,
				WithinDistance = 600,
				FunctionName = "TyphonTailIntro",
				Args =
				{
					TailId = 768130,
					--SetCameraClampIds = { 779863, 779862, 50061, 50062, },
					DelayedStart = true,
					SkipBossMusic = true,
				},
				GameStateRequirements = 
				{
					{
						PathFalse = { "GameState", "RoomCountCache", "Q_MiniBoss03" },
					},
				},
			},
			-- adjusted distance on subsequent visits
			{
				Name = "TyphonTailTrigger",
				TriggerId = 768130,
				WithinDistance = 1200,
				FunctionName = "TyphonTailIntro",
				Args =
				{
					TailId = 768130,
					--SetCameraClampIds = { 779863, 779862, 50061, 50062, },
					DelayedStart = true,
					SkipBossMusic = true,
				},
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "RoomCountCache", "Q_MiniBoss03" },
					},
				},
			},

		},

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.65,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.25,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_2956", Text = "More infestation...",
					PlayOnce = true,
					PlayOnceContext = "TyphonTailRoomEnteredVO",
				},
				{ Cue = "/VO/MelinoeField_3231", Text = "...I'm being watched..." },
				{ Cue = "/VO/MelinoeField_3232", Text = "...Something's here..." },
				{ Cue = "/VO/MelinoeField_3233", Text = "...I know this place..." },
				{ Cue = "/VO/MelinoeField_3234", Text = "...Time for the Tail...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EncountersCompletedCache", "BossTyphonTail01" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3235", Text = "...The Tail Chamber...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_3234" },
						},
					},
				},
			},
		},

		CombatResolvedVoiceLines =
		{
			{ GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		InspectPoints =
		{
			[792125] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_MiniBoss03_01 =
					{
						{ Cue = "/VO/Storyteller_0336",
							Text = "{#Emph}One of the serpentine tails of Typhon, lord and father of all monster-kind, slashed through floor after floor of the fortress behind which the Olympians take shelter from his storm." },
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
										Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
										Comparison = ">",
										Value = 0,
									},
								},
								{ Cue = "/VO/MelinoeField_3256", Text = "He'll tear this fortress apart..." },
							},
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								GameStateRequirements =
								{
									{
										Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
										Comparison = "<=",
										Value = 0,
									},
								},
								{ Cue = "/VO/MelinoeField_3257", Text = "I'll be the last thing he sees." },
							},
						},
					},
				},
			},
		},

	},

	Q_MiniBoss04 =
	{
		InheritFrom = { "Q_BaseMiniBoss" },

		ForceAtBiomeDepth = 6,

		LegalEncounters = { "BossTyphonEye01", },
		BackupCauseOfDeath = "TyphonEye",

		RushMaxRangeOverride = 525,
		
		EntranceFunctionName = "RoomEntranceBoss",
		EntranceFunctionArgs =
		{
			AngleTowardsIdOnEnd = 768689,
			BossId = 768121,
			BossIntroSound = "/SFX/Enemy Sounds/Typhon/EmoteJumpScare",
			BossIntroAnimation = "Enemy_TyphonEye_Shut_End_Fast",
			BossIntroDelay = 0.9,
		},
		IntroSequenceDuration = 2.1,
		BlockCameraReattach = true,
		ThreadEnterVoiceLines = true,
		
		ZoomFraction = 0.7,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "BossTyphonTail01" },
			},
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 768121 },
					SetupBossIds = { 768121, },
					DelayedStart = true,
					SkipBossMusic = true,
				},
			},
		},

		StartThreadedEvents =
		{
			{
				FunctionName = "TyphonEyeEggFuser",
				Args =
				{
					EggSpawn = "Simple",
					EggShadowSpawn = "Mudman_Shadow",
					ActiveEnemyCap = 4,
					StartDelay = 4,
					Interval = 1,
				},
			},
		},

		PostCombatReloadEvents =
		{
			{
				FunctionName = "DestroyGroup",
				Args =
				{
					GroupName = "FightEndDestroy"
				}
			}
		},

		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				-- RandomRemaining = true,
				PreLineWait = 1.0,
				-- SuccessiveChanceToPlay = 0.5,
				-- SuccessiveChanceToPlayAll = 0.25,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_3685", Text = "Oh, what is {#Emph}this...", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/MelinoeField_3686", Text = "That's not what eyes are meant to do!" },
				{ Cue = "/VO/MelinoeField_3687", Text = "Take a good look, Typhon." },
				{ Cue = "/VO/MelinoeField_3688", Text = "Watch this, Monster." },
				{ Cue = "/VO/MelinoeField_3690", Text = "Apparently I'm being watched." },
				{ Cue = "/VO/MelinoeField_3689", Text = "You want to lose {#Emph}another {#Prev}eye?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EncountersCompletedCache", "BossTyphonEye01" }
						},
					},
				},
			},
		},

		CombatResolvedVoiceLines =
		{
			{ GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		InspectPoints =
		{
			[792783] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_MiniBoss04_01 =
					{
						{ Cue = "/VO/Storyteller_0337",
							Text = "{#Emph}The enemies of all-seeing Typhon cannot possibly escape his rancor, for his eyes are everywhere upon him, red with rage, and searching endlessly, piercing the very soul." },
						EndVoiceLines =
						{
							PlayOnce = true,
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3257", Text = "I'll be the last thing he sees." },
						},
					},
				},
			},
		},

	},

	Q_MiniBoss05 =
	{
		InheritFrom = { "Q_BaseMiniBoss" },
		AlwaysForce = true,

		ForceAtBiomeDepth = 3,

		LegalEncounters = { "MiniBossStalker", },
		BackupCauseOfDeath = "Stalker_Miniboss",
		
		CauseOfDeathDisplayData = 
		{
			GameStateRequirements = 
			{
				{
					PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
				}
			},
			Name = "MiniBossStalker_Alt",
		},
		ZoomFraction = 0.77,
		EntranceFunctionName = "RoomEntranceBossTwins",
		IntroSequenceDuration = 0.5,
		IntroPanEaseIn = 0.01,
		IntroPanEaseOut = 0.001,
		BlockCameraReattach = false,
		ThreadEnterVoiceLines = true,
		EntranceFunctionArgs =
		{
			BossIds = { 768838, 768837, },
			BossStaggerDelay = 0.2,
			BossIntroSound = "/SFX/Enemy Sounds/TyphonStalker/EmoteTaunting",
			BossIntroAnimation = "Enemy_Stalker_Intro",
			BossIntroDelay = 0.3,
		},
		
		EnterGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 768838, 768837, },
					SetupBossIds = { 768838, 768837, },
					DelayedStart = true,
					SkipCameraPan = true,
					SkipBossMusic = true,
				},
			},
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossBrute" },
			},
		},

		InspectPoints =
		{
			[792124] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_MiniBoss05_01 =
					{
						{ Cue = "/VO/Storyteller_0361",
							Text = "{#Emph}The foul brood of storm-bringing Typhon crawl through the growing cracks in the stonework of the Fortress of the Gods, as though to shake the mountain to its very core." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3263", Text = "Best watch my step." },
						},
					},
				},
			},
		},

	},

	Q_Boss01 =
	{
		InheritFrom = { "BaseQ" },
		RichPresence = "#RichPresence_Boss",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = "<",
					Value = 4,
				},
			},
		},

		BackupCauseOfDeath = "TyphonHead",

		Ambience = "/Ambience/TyphonOutdoorAmbience",
		GlobalEcho = 0.25,
		ReverbValue = 1.0,

		ForcedReward = "MixerQBossDrop",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",
		NoReroll = true,

		FlipHorizontalChance = 0.0,
		EntranceDirection = "LeftRight",

		OnRoomRewardSpawnedFunctionName = "CheckTyphonReward",
		OnRoomRewardSpawnedFunctionArgs =
		{
			LootOptions =
			{
				{
					Name = "MixerMythicDrop",
					Overrides =
					{
						CanDuplicate = false,
					}
				},
			},
		},

		RequiresLinked = true,
		LinkedRoom = "Q_PostBoss01",
		ExitFunctionName = "BiomeQBossExitPresentation",

		LeavePostPresentationEvents =
		{
			{
				FunctionName = "SetupHeroForEnding",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
					},
				},
			},
		},

		LegalEncounters = { "BossTyphonHead01" },

		EntranceFunctionName = "RoomEntranceTyphonHead",
		EntranceFunctionArgs =
		{
			TyphonId = 768121,
			TyphonIntroSound = "/SFX/Enemy Sounds/Typhon/EmoteAlerted",
			TyphonIntroAnimation = "Enemy_TyphonHead_Intro_Entrance_Start",
			TyphonStartAnimation = "Enemy_TyphonHead_Invisible",
			TyphonIntroDelay = 0.1,
		},
		IntroCameraPanDuration = 4,
		IntroSequenceDuration = 1.0,
		BlockCameraReattach = true,

		TyphonSpecialKillTeleportId = 793961,

		-- handled elsewhere
		IgnoreMusic = true,

		ZoomFraction = 0.6,
		ThreadEnterVoiceLines = true,

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,
		ShovelPointChance = 0.0,
		PickaxePointChance = 0.0,
		ExorcismPointChance = 0.0,
		FishingPointChance = 0.0,

		CatFamiliarOnlyRestOnFamiliarPoints = true,

		FootstepAnimationR = "WaterSplashFootstepR-Spawner",
		FootstepAnimationL = "WaterSplashFootstepL-Spawner",
		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/Leftovers/SFX/FootstepsWetSmall",
			["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsWetMedium",
		},
		
		ExitPanId = 793953,

		UnthreadedEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
					},
				},
				Args =
				{
					ExitFunctionName = "EndEarlyAccessPresentation",
					SkipLoadNextMap = true,
				},
			},
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 768121 },
					SetupBossIds = { 768121, },
					SetupUnitIdAIs = { 793226 },
					DelayedStart = true,
					LockCameraWithBoss = true,
				},
			},
			{
				FunctionName = "SetupPauseMenuTakeover",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" },
					},
				},
				Args = RoomEventData.PauseMenuTakeOverAutoUnpause,			
			},
			{
				FunctionName = "SetupPauseMenuTakeover",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" },
					},
				},
				Args = RoomEventData.PauseMenuTakeOverAllowPause,
			},
		},

		ThreadedEvents =
		{
			{
				FunctionName = "AttackTyphonHint",
				Args = { Delay = 16.0 },
			},
		},

		PostCombatReloadEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
					},
				},
				Args =
				{
					ExitFunctionName = "EndEarlyAccessPresentation",
					SkipLoadNextMap = true,
				},
			},
			{
				FunctionName = "TyphonHeadPostCombatReload"
			},
		},

		--[[ see PreFightVoiceLines & FightStartVoiceLines in EncounterData_Boss
		EnterVoiceLines =
		{

		},
		]]--

		ExitVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "TyphonBossFirstExitVO",
				BreakIfPlayed = true,
				-- RandomRemaining = true,
				PreLineWait = 0.35,
				UsePlayerSource = true,

				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_5010", Text = "Thank you, Zagreus... Gigaros..." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "TyphonBossFirstExitVO",
				BreakIfPlayed = true,
				-- RandomRemaining = true,
				PreLineWait = 0.35,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_3453", Text = "Enough of this place..." },
			},
		},

		InspectPoints =
		{
			[793021] =
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
					Inspect_Q_Boss01_01 =
					{
						{ Cue = "/VO/Storyteller_0338",
							Text = "{#Emph}Finally, the terrifying storm tearing apart the Fortress of the Gods starts to relent, perhaps because its monstrous source is nowhere to be found." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3258", Text = "At least for now..." },
							},
						},
					},
				},
			},
			[793022] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_Q_Boss01_01" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Boss01_02 =
					{
						{ Cue = "/VO/Storyteller_0339",
							Text = "{#Emph}The hopeless threat of Typhon, whom the Princess of the Underworld sent howling toward the Earth from which he sprang in all his rage, subsides; but only for the night." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3259", Text = "The family can enjoy a moment's rest." },
							},
						},
					},
				},
			},
			-- copy in Q_Boss02
			[797655] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "Inspect_Q_Boss02_03" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Boss01_03 =
					{
						{ Cue = "/VO/Storyteller_0522",
							Text = "{#Emph}Once more, no trace remains of our world's worst monstrosity. And the mere possibility that he could have wreaked further havoc on this mountaintop grows faint." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_5025", Text = "We'll leave nothing to chance." },
							},
						},
					},
				},
			},
		},
		Using = { SpawnUnit = "NPC_Zeus_01", Animation = "ZeusLightningIris", },
	},

	Q_Boss02 =
	{
		InheritFrom = { "Q_Boss01" },
		RichPresence = "#RichPresence_Boss",
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = ">=",
					Value = 4,
				},
			},
		},

		SpeakerName = { "Selene" },

		BackupCauseOfDeath = "TyphonHead",
		LegalEncounters = { "BossTyphonHead02" },

		EntranceFunctionName = "RoomEntranceTyphonHeadEM",
		EntranceFunctionArgs =
		{
			TyphonId = 768121,
			TyphonIntroSound = "/SFX/Enemy Sounds/Typhon/EmoteAlerted",
			TyphonIntroAnimation = "Enemy_TyphonHead_Intro_Entrance_Start",
			TyphonStartAnimation = "Enemy_TyphonHead_Invisible",
			TyphonIntroDelay = 0.1,
			TyphonIntroPanId = 800463,
			ChronosId = 793226,
		},

		TyphonSpecialKillTeleportId = 800622,

		UnthreadedEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
					},
				},
				Args =
				{
					ExitFunctionName = "EndEarlyAccessPresentation",
					SkipLoadNextMap = true,
				},
			},
			{
				FunctionName = "BossIntro",
				Args =
				{
					-- ProcessTextLinesIds = { 768121 },
					SetupBossIds = { 768121, },
					SetupUnitIdAIs = { 793226 },
					DelayedStart = true,
					LockCameraWithBoss = true,
				},
			},
			{
				FunctionName = "SetupPauseMenuTakeover",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" },
					},
				},
				Args = RoomEventData.PauseMenuTakeOverAutoUnpause,			
			},
			{
				FunctionName = "SetupPauseMenuTakeover",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "TyphonHead" },
						Comparison = ">",
						Value = 0,
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" },
					},
				},
				Args = RoomEventData.PauseMenuTakeOverAllowPause,
			},
		},

		InspectPoints =
		{
			[793952] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Boss02_01 =
					{
						{ Cue = "/VO/Storyteller_0426",
							Text = "{#Emph}Not even Time itself could stop the fierce Princess from vanquishing that ancient monster which so doggedly attacks the mountain of the gods night after endless night." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3619", Text = "I've learned their tricks." },
							},
						},
					},
				},
			},
			[793022] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Boss02_02 =
					{
						{ Cue = "/VO/Storyteller_0461",
							Text = "{#Emph}United in bitter fury, the father of the gods and the Father of All Monsters nonetheless could neither lay claim to this sacred mountain nor raze it to the Earth." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3659", Text = "And we'll keep it that way." },
							},
						},
					},
				},
			},
			[800628] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "Inspect_Q_Boss01_03" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Boss02_03 =
					{
						{ Cue = "/VO/Storyteller_0522",
							Text = "{#Emph}Once more, no trace remains of our world's worst monstrosity. And the mere possibility that he could have wreaked further havoc on this mountaintop grows faint." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_5025", Text = "We'll leave nothing to chance." },
							},
						},
					},
				},
			},
		},
		ExitPanId = 800243,

		ExitVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "TyphonBossFirstExitVO",
				BreakIfPlayed = true,
				-- RandomRemaining = true,
				PreLineWait = 0.35,
				UsePlayerSource = true,
				
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_5010", Text = "Thank you, Zagreus... Gigaros..." },
			},
		},
	},

	-- @ ending
	Q_PostBoss01 =
	{
		InheritFrom = { "BaseQ" },
		RichPresence = "#RichPresence_Misc",
		LegalEncounters = { "Empty" },
		Ambience = "/Ambience/TyphonOutdoorAmbience",
		NarrativeContextArt = "DialogueBackground_Olympus_Silent",
		NarrativeContextArtFlippable = false,

		GameStateRequirements =
		{
			-- None
		},
		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWoodRun"] = "/Leftovers/SFX/FootstepsConcrete",
			["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsConcreteMedium",
		},
		RequiresLinked = true,
		LinkedRoom = "Q_Story01",
		RewardPreviewOverride = "ExitAheadPreview",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		EntranceDirection = "Right",
		EntrancePresentationUsePlayerSpeed = true,
		ExitFunctionName = "nil",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.45,

		SkipLastKillPresentation = true,
		BlockCombat = true,
		BlockFamiliars = true,

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

		WrappingData =
		{
			ObstacleWrapData =
			{
				{
					Ids = { 794637, 793308, 793297, 793299, 793300, 798406, 798407, 798408, },
					ResetOffsetDistance = 0,
					MoveSpeed = 20,
					MoveTime = 1200,
				},
				{
					Ids = { 798415, 798416, 798417, 798418, 798419, 798420, 798421, 798422, },
					ResetOffsetDistance = 0,
					MoveSpeed = 20,
					MoveTime = 1200,
				},
			},
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "HideGameplayTimers" },
			{ FunctionName = "SetupPalaceForcefield" },
		},

		StartThreadedEvents =
		{
			{ FunctionName = "HandleWrapping", Args = { Angle = 180 } },
			{ FunctionName = "RestoreMelRun", Args = { WaitForInputAllowed = true } },
		},

		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "BiomeOverlookQPostBoss", Repeat = true, Args = { PanTargetId = 792648, ZoomFraction = 0.415 },
			},
			{
				TriggerGroup = "OverlookOut", WithinDistance = 150, FunctionName = "BiomeBackToRoomQPostBoss", Repeat = true,
			},
		},

		ObstacleData = 
		{
			-- palace forcefield
			[792642] =
			{
				Name = "PalaceForcefield",
				InteractDistance = 250,
				UseText = "UseSpecialExit",
				OnUsedFunctionName = "DisablePalaceForcefield",
				OnUsedFunctionArgs =
				{
					ForceWalkRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "ZeusPalaceFirstMeeting" },
						},
					},
					ApolloMusicArgs =
					{
						ApolloId = 800842,
						Params =
						{
							LowPass = 1.0,
							Vocals = 0.6,
						},
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
				DistanceTriggers =
				{
					{
						WithinDistance = 800,
						VoiceLines =
						{
							Queue = "Never",
							{
								UsePlayerSource = true,
								PlayOnce = true,
								{ Cue = "/VO/MelinoeField_3456", Text = "An aether gate...?" },
							},
						}
					}
				},

			},

			[776127] =
			{
				Name = "QStoryExit",
				OnUsedGameStateRequirements =
				{
				},
				OnUsedFunctionName = "AttemptUseDoor",

				SetupEvents =
				{
					{
						FunctionName = "SetupDefaultDoor",
					},
					{
						FunctionName = "GenericPresentation",
						Args =
						{
							AddToGroup = "ExitDoors",
						},
					}
				},

				HideRewardPreview = true,
				InteractDistance = 550,
				InteractOffsetX = 0,
				InteractOffsetY = 0,
				AutoActivate = true,
			},
		},

		InspectPoints =
		{
			[798321] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_Q_Story_02" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_PostBoss_01 =
					{
						{ Cue = "/VO/Storyteller_0415",
							Text = "{#Emph}Few ever have laid eyes on the glorious Palace of the King of the Olympians, as only those deemed worthy may enter, or even locate it amongst the mountain peaks." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3608", Text = "Well, here it is..." },
							},
						},
					},
				},
			},
			[798322] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Story01" },
					},
					-- NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_PostBoss_02 =
					{
						{ Cue = "/VO/Storyteller_0418",
							Text = "{#Emph}Ahead lies the well-hidden and protected Palace of the King and Queen of all the gods, that stronghold from which Olympus has fought back against all too many terrible foes." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
									},
								},
								{ Cue = "/VO/MelinoeField_3611", Text = "Keep holding on..." },
							},
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
									},
								},

								{ Cue = "/VO/MelinoeField_4245", Text = "Typhon makes one fewer." },
							},
						},
					},
				},
			},

		},

		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "Q_PostBossPostTyphonDeathIntroVO",
				BreakIfPlayed = true,
				PreLineWait = 3.5,
				UsePlayerSource = true,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/MelinoeField_5011", Text = "This storm shall pass..." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "Q_PostBossIntroVO",
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 3.5,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_3454", Text = "Almost... there...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3455", Text = "The path to the Palace..." },
			},
		},

	},

	Q_Story01 =
	{
		InheritFrom = { "BaseQ" },
		RichPresence = "#RichPresence_Misc",
		Ambience = "/Leftovers/Object Ambiences/CommonwealthAmbience",
		NarrativeContextArt = "DialogueBackground_Olympus_Silent",
		NarrativeContextArtFlippable = false,

		IgnoreMusic = true,
		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWoodRun"] = "/Leftovers/SFX/FootstepsConcrete",
			["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsConcreteMedium",
		},

		RequiresLinked = true,
		LegalEncounters = { "Story_Palace_01" },
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,

		GameStateRequirements =
		{
		},

		EnterWipeAnimation = "RoomTransitionOut_TopRight",
		EntrancePresentationUsePlayerSpeed = true,
		IntroSequenceDuration = 1.0,
		IntroPanEaseIn = 0.01,
		IntroPanEaseOut = 0.001,
		ZoomFraction = 0.65,
		TimerBlock = "StoryRoom",

		BlockCombat = true,
		BlockFamiliars = true,

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

		CameraZoomWeights =
		{
			[798372] = 1.120,
			[798373] = 0.975,
		},

		InspectPoints =
		{
			[798320] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					-- NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Story_01 =
					{
						{ Cue = "/VO/Storyteller_0416",
							Text = "{#Emph}The majestic Palace of Zeus stands resolute and strong, for the combined might of the gods has kept that seat of power safe, even from such monstrous adversaries as they face." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3609", Text = "These must be just the palace grounds..." },
							},
						},
					},
				},
			},
			[798321] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_Q_Story_01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "Inspect_Q_PostBoss_02" },
					},
					-- NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Q_Story_02 =
					{
						{ Cue = "/VO/Storyteller_0417",
							Text = "{#Emph}Tranquil music made by masterful Apollo reverberates throughout the palace grounds, piercing the grimness of the circumstances like an arrow of pure light." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/MelinoeField_3610", Text = "He's good..." },
							},
						},
					},
				},
			},

		},

		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				-- RandomRemaining = true,
				PreLineWait = 4.0,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 16 },
				},

				{ Cue = "/VO/MelinoeField_3468", Text = "Is that...?" },
				{ Cue = "/VO/MelinoeField_3469", Text = "Music...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3470", Text = "The King and Queen..." },
				{ Cue = "/VO/MelinoeField_3471", Text = "They're here..." },
			},
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "HideGameplayTimers" },
			{ FunctionName = "SetupPalaceExitPoint" },
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "HecateField" },
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "PalaceBoonExit01" }
					},
				},
			},
		},

		ObstacleData = 
		{
			[792347] =
			{
				Name = "EndRunBoon",
				UseText = "UsePalaceExit",
				AnimOffsetZ = 110,
				OnUsedGameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "UseRecord" },
						HasAny = { "NPC_Zeus_Story_01", "NPC_Chronos_02" },
					},
					OrRequirements =
					{
						-- demeter isn't present
						{
							{
								FunctionName = "RequiredAlive",
								FunctionArgs = { Units = { "NPC_Demeter_Story_01", }, Alive = false },
							},
						},
						-- demeter is present and you talked to her
						{
							{
								PathTrue = { "CurrentRun", "CurrentRoom", "UseRecord", "NPC_Demeter_Story_01" },
							},
						},
					},
				},
				OnUsedFunctionName = "UseDummyLoot",
				SpeakerName = "Hecate",
				LoadPackages = { "Hecate" },
				InteractDistance = 180,
				InteractTextLineSets =
				{
					PalaceBoonExit01 =
					{
						PlayOnce = true,
						GameStateRequirements =
						{
							--
						},

						{ Cue = "/VO/MelinoeField_3834", UsePlayerSource = true,
							Portrait = "Portrait_Mel_Vulnerable_01",
							PortraitExitAnimation = "Portrait_Mel_Vulnerable_01_Exit",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

							PostLineFunctionName = "BoonInteractPresentation",
							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							TextColor = Color.DialogueText,
							UseRoomContextArt = true,
							PostLineRemoveContextArt = true,
							Text = "I'm unaccustomed to being on this side! I see... Erebus, I think. Wait, Headmistress, is that {#Emph}you? {#Prev}Can you hear me?" },

						{ Cue = "/VO/HecateField_0328",
							Source = "NPC_Hecate_01",
							PreLineWait = 1.25,
							PortraitExitWait = 0.25,
							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							NarrativeContextArt = "DialogueBackground_Erebus",
							PostLineRemoveContextArt = true,
							PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
							Text = "{#Emph}In the name of Hades. Olympus, I accept this message! {#Prev}...Melinoë? If you can even hear me yonder, I bid you to return. We have matters to discuss." },

						{ Cue = "/VO/MelinoeField_3835", UsePlayerSource = true,
							
							Portrait = "Portrait_Mel_Proud_01",
							PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

							PreLineWait = 0.35,
							PostLineThreadedFunctionName = "KillHero",
							PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },

							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							TextColor = Color.DialogueText,
							UseRoomContextArt = true,
							PostLineRemoveContextArt = true,
							Text = "...I have to go now, everyone. Please take care, and let the others know I'm sorry to have missed them. I'll return!" },
						EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
					},
					PalaceBoonExitTyphonDestroyed01 =
					{
						PlayOnce = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceAboutTyphonDeath01" },
							},
						},
						{ Cue = "/VO/MelinoeField_3926", UsePlayerSource = true,
							Portrait = "Portrait_Mel_Proud_01",
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",

							PostLineThreadedFunctionName = "KillHero",
							PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							TextColor = Color.DialogueText,
							UseRoomContextArt = true,
							PostLineRemoveContextArt = true,
							Text = "...Now for Chronos. I'll be counting on your blessings, everyone!" },
						EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
					},
					PalaceBoonExitPostTrueEnding01 =
					{
						PlayOnce = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
						{ Cue = "/VO/MelinoeField_5022", UsePlayerSource = true,
							Portrait = "Portrait_Mel_Proud_01",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

							PostLineThreadedFunctionName = "KillHero",
							PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							TextColor = Color.DialogueText,
							UseRoomContextArt = true,
							PostLineRemoveContextArt = true,
							Text = "...It sounds like I may not be visiting again anytime soon, so... thank you all, and please let the others know I wish them well. Let's keep in touch by Boon!" },
						EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
					},
					PalaceBoonExit02 =
					{
						PlayOnce = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
							},
						},
						{ Cue = "/VO/MelinoeField_3927", UsePlayerSource = true,
							Portrait = "Portrait_Mel_Proud_01",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

							PostLineThreadedFunctionName = "KillHero",
							PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							TextColor = Color.DialogueText,
							UseRoomContextArt = true,
							PostLineRemoveContextArt = true,
							Text = "...It has been wonderful to see you all! Farewell for now!" },
						EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
					},

					-- repeatable
					PalaceBoonExitRepeatable01 =
					{
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceMeeting02" },
							},
						},

						{ Cue = "/VO/MelinoeField_3923", UsePlayerSource = true,
							Portrait = "Portrait_Mel_Proud_01",
							PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

							PostLineThreadedFunctionName = "KillHero",
							PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							TextColor = Color.DialogueText,
							UseRoomContextArt = true,
							PostLineRemoveContextArt = true,
							Text = "...Goodbye for now, everyone! May you be safe and well when next we meet." },
						EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
					},
					PalaceBoonExitRepeatable02 =
					{
						GameStateRequirements =
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAny = { "ZeusPalaceMeeting03", "ZeusPalaceMeeting03_A", "ZeusPalaceMeeting03_B" },
							},
						},

						{ Cue = "/VO/MelinoeField_3925", UsePlayerSource = true,
							Portrait = "Portrait_Mel_Proud_01",
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",

							PostLineThreadedFunctionName = "KillHero",
							PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							TextColor = Color.DialogueText,
							UseRoomContextArt = true,
							PostLineRemoveContextArt = true,
							Text = "...We're getting closer, everyone. Please stay safe!" },
						EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
					},
					PalaceBoonExitRepeatable03 =
					{
						GameStateRequirements =
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								HasAny = { "ZeusPalaceMeeting04", "ZeusPalaceMeeting04_B" },
							},
						},

						{ Cue = "/VO/MelinoeField_3924", UsePlayerSource = true,
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",

							PostLineThreadedFunctionName = "KillHero",
							PostLineFunctionArgs = { WaitTime = 0, MusicEndTime = 60 },
							BoxAnimation = "DialogueSpeechBubble",
							BoxExitAnimation = "DialogueSpeechBubbleOut",
							TextColor = Color.DialogueText,
							UseRoomContextArt = true,
							PostLineRemoveContextArt = true,
							Text = "...Should Typhon rise again, I shall return!" },
						EndGlobalVoiceLines = "ZeusSendOffVoiceLines",
					},
				},
			},
		},

	},


}
AddTableKeysCheckDupes( RoomData, RoomSetData.Q )