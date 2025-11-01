RoomSetData.I =
{
	BaseI =
	{
		DebugOnly = true,
		RichPresence = "#RichPresence_I",
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Tartarus",
		ResultText = "RunHistoryScreenResult_ClockworkTartarus",
		
		HarvestPointBase = "DrownedChambersHarvestPointBase01",
		
		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,

		ShovelPointChance = 0.12,
		PickaxePointChance = 0.18,
		ExorcismPointChance = 0.12,
		FishingPointChance = 0.09,

		LocationAnimName = "InfoBannerTartarusIn",
		LocationAnimOutName = "InfoBannerTartarusOut",

		NemesisTakeExitSuccessDistance = 160,

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
						Path = { "GameState", "LifetimeResourcesGained", "PlantIShaderot" },
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
				Path = { "GameState", "LifetimeResourcesGained", "PlantHWheatSeed" },
				Comparison = ">=",
				Value = 2,
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
						Path = { "GameState", "LifetimeResourcesGained", "PlantIPoppySeed" },
						Comparison = "<",
						Value = 16,
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
				Path = { "GameState", "LifetimeResourcesGained", "OreHGlassrock" },
				Comparison = ">=",
				Value = 6,
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
						Path = { "GameState", "LifetimeResourcesGained", "OreIMarble" },
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
				Path = { "GameState", "ExorcisedNames", "ShadeFieldsGreyIdle" },
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
								Path = { "GameState", "ExorcisedNames", "ShadeClockworkIdle" },
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
						NotHasAll = { "FishICommon", "FishIRare", "FishILegendary" },
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

		LegalEncounters = EncounterSets.IEncountersDefault,
		DevotionEncounters = {"DevotionTestI"},
		ForcedRewardStore = "TartarusRewards",
		BreakableValueOptions = { MaxHighValueBreakables = 6 },
		StopSecretMusic = true,
		Ambience = "/Ambience/ClockworkTartarusAmbience",
		-- ShopSecretMusic = "/Music/CharonShopTheme",
		TargetMetaRewardsRatio = 0.25,

		MaxAppearancesThisBiome = 1,

		SecretDoorRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 2, -- restrict Chaos from being served after the first combat room
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "F_PreBoss01", "F_Boss01", "F_Boss02", "G_PreBoss01", "G_Boss01", "G_Boss02", "H_PreBoss01", "H_Boss01", "H_Boss02", "N_PreBoss01", "N_Boss01", "N_Boss02", "P_PreBoss01", "P_Boss01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "I", "O", "Q" },
			},
			NamedRequirements = { "ChaosUnlocked", "NoRecentChaosEncounter" },
		},

		TimeChallengeEncounterOptions = { "TimeChallengeI" },
		PerfectClearEncounterOptions = { "PerfectClearChallengeI" },
		EliteChallengeEncounterOptions = { "EliteChallengeI" },

		-- LocationText = "BiomeI",
		SaveProfileLocationText = "Location_BiomeI",

		NarrativeContextArt = "DialogueBackground_CWTartarus",
		NarrativeContextArtFlippable = false,

		ZoomFraction = 0.85,

		WellShopSpawnChance = 0.08,

		DoorEntranceAnimation = { DoorType = "CWTartarusEntryDoor", CloseAnimation = "CWTartarusExitDoorClose", OpenedAnimation = "CWTartarusExitDoorOpened", Delay = 0.5 },


		SwapAnimations =
		{
			["SuitExhaustSprintDust"] = "SuitExhaustSprintDust_CWT",
			["OlympusSnowExplosionDecal"] = "ExplosionScorchDecal",
			["FishingPointActive"] = "FishingPointActiveSand",
			["FishingPointDark"] = "FishingPointDarkSand",
			["FishingBobberIdle"] = "FishingBobberIdle_Sand",
			["FishingBobberResurface"] = "FishingBobberResurface_Sand",
			["FishingBobberDunk"] = "FishingBobberDunk_Sand",
			["FishingBobberFakeDunkA"] = "FishingBobberFakeDunkA_Sand",
			["FishingSplashA_Standing"] = "FishingSplashA_Standing_Sand",
			["FishingSplashB_Standing"] = "FishingSplashB_Standing_Sand",
			["FishingSplashA"] = "FishingSplashA_Sand",
			["FishingSplashB"] = "FishingSplashB_Sand",
		},

		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsHardSurface",
			["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsHardSurfaceRun",
			["/Leftovers/Object Ambiences/FishJumpSplash"] = "/SFX/FishSandSplashLoop",
			["/Leftovers/World Sounds/ClickSplash"] = "/SFX/SandEmerge",
		},
		FishingStartSound = "/SFX/SandFishBig",
		FishingDunkSound = "/SFX/SandFishBig",
		FishingFailSound = "/SFX/SandEmerge",

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.1 }, Args = { StartingCountMin = 0, StartingCountMax = 8, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
			{ FunctionName = "ClockworkManager", Args = { Interval = 10.0 } },
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

	I_TwoExits =
	{
		DebugOnly = true,
		GameStateRequirements =
		{
			Append = true,
			{
				Path = { "CurrentRun", "BiomeRewardsSpawned", },
				Comparison = "<",
				ValuePath = { "CurrentRun", "MaxClockworkNonGoalRewards", },
				ValuePathAddition = -1,
			}
		},
	},

	I_Intro =
	{
		InheritFrom = { "BaseI","BiomeStartRoom" },

		LegalEncounters = { "Empty" },

		IntroSequenceDuration = 0.7,
		Starting = true,
		NoReward = true,
		NoReroll = true,
		SkipLastKillPresentation = true,
		HideRewardPreview = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceFunctionName = "RoomEntranceDrop",
		EntranceFunctionArgs = { LandingAnimation = "Melinoe_HeroLanding", Sound = "/SFX/Player Sounds/MelWhooshDropIn", IntroHoldDuration = 2.34, StartZoomFraction = 0.65, ZoomDuration = 4 },
		-- ExitFunctionName = "LeaveRoomPresentation",
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		FlipHorizontalChance = 0.0,

		ForceAtBiomeDepthMin = 0,
		ForceAtBiomeDepthMax = 1,
		MaxAppearancesThisBiome = 1,

		HarvestPointChances = { 0.02, },
		ShovelPointChance = 0.02,
		PickaxePointChance = 0.02,
		--ExorcismPointChance = 0.02,
		FishingPointChance = 0.02,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 700,

		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 150, FunctionName = "BiomeOverlook", Repeat = true, Args = { PanTargetId = 562099, ZoomFraction = 0.90 },
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "BiomeBackToRoom", Repeat = true,
			},
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "EndBiomeRecords", },
			{
				FunctionName = "InitClockworkGoalReward",
				Args =
				{
					GoalRewards = 5,
					MinNonGoalRewards = 3,
					MaxNonGoalRewards = 6,
				},				
			},
			{
				FunctionName = "SpawnErisForCurse",
				Args =
				{
					UnitName = "NPC_Eris_01",
					SpawnOnId = 699326,
					GoalAngle = 320,
					GiveRandomConsumables =
					{
						UpwardForceMin = 1000,
						UpwardForceMax = 1000,
						Range = 0,
						Force = 0,
						--NotRequiredPickup = true,
						LootOptions =
						{
							{
								Name = "MetaCurrencyDrop",
								Overrides =
								{
									CanDuplicate = false,
									MetaConversionEligible = false,
									NPCDrop = true,
									AddResources =
									{
										MetaCurrency = 300,
									},
								},
							},
						}
					},
				},
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "ErisCurseHealthThreshold", },
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 7,
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "ErisCurseTrait" },
					},
				},
				BreakIfPlayed = true,
			},
			{
				FunctionName = "DistanceTrigger",
				Threaded = true,
				Args =
				{
					Id = 699326,
					WithinDistance = 400,
					PostTriggerEvents =
					{
						{
							FunctionName = "GenericPresentation",
							Args = 
							{
								VoiceLines = { GlobalVoiceLines = "ErisNotSightedVoiceLines" },
							},
						},
					},
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 10,
					},
					{
						Path = { "PrevRun", "TraitCache", },
						HasAny = { "ErisCurseTrait" },
					},
				},
			},
		},

		ThreadedEvents =
		{
			Threaded = true,
			{
				FunctionName = "DisplayInfoBanner",
				Args =
				{
					Text = "Location_BiomeI",
					AnimationName = "InfoBannerTartarusIn",
					AnimationOutName = "InfoBannerTartarusOut",
					Delay = 2.0,
				},
				GameStateRequirements =
				{
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

		BlockExitPan = true,
		RewardPreviewOverride = "HadesLockIcon",
		ObstacleData =
		{
			[565632] =
			{
				Template = "CWTartarusExitDoor",
				OnUseEvents =
				{
					{
						FunctionName = "TartarusChamberMoverPresentation",
						GameStateRequirements =
						{
							{
								FunctionName = "CheckRoomExitsReadySource",
							},
						},
					},
					{ FunctionName = "AttemptUseDoor", },
				},
				UseText = "UseChamberMover",
				UnlockedUseText = "UseChamberMover",
				UnlockedUseTextReroll = "UseChamberMover",
				UnlockedUseTextCannotReroll = "UseChamberMover",
				Using = { "NightmareEdgeFxSpawner" }
			},
		},

		InspectPoints =
		{
			[565616] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_Intro_02" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Eris_01", }, Alive = false },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Intro_01 =
					{
						{ Cue = "/VO/Storyteller_0057",
							Text = "{#Emph}Within the deepest reaches of the earth, where once grim Lord Hades reigned, now twist the edifices of the Titan Chronos, who made this former tomb of his his home." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1116", Text = "I can't believe that this is Tartarus..." },
						},
					},
				},
			},

			[692104] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Eris_01", }, Alive = false },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Intro_02 =
					{
						{ Cue = "/VO/Storyteller_0214",
							Text = "{#Emph}The exposed inner-workings of the infamously interlocking chambers of the Underworld are a mass of gold-toothed wheels; a never-ending cycle turning at the Titan's sole behest." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1430", Text = "Can hardly concentrate with all this racket..." },
						},
					},
				},
			},


		},

		-- Room Audio Below This Line
		MusicActiveStems = { "Guitar", "Bass" },
		MusicMutedStems = { "Drums" },
		MusicStartDelay = 1.5,
		PlayBiomeMusic = true,
		MusicSection = 0,

		EnterVoiceLines =
		{
			{ GlobalVoiceLines = "StartPackagedBountyRunVoiceLines" },
			{ GlobalVoiceLines = "BiomeStateChangeStartVoiceLines" },
			{
				PlayOnce = true,
				PlayOnceContext = "ReachedTartarusHecateMissingSpeech",
				PreLineWait = 1.35,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					NamedRequirements = { "HecateMissing" },
				},

				{ Cue = "/VO/Melinoe_5197", Text = "I have to do this... I have to do this... I have to do this...", IgnoreMute = true, }
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ReachedTartarusPostTrueEndingIntroSpeech",
				PreLineWait = 1.35,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_4586", Text = "No renovations here..." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.35,
				SuccessiveChanceToPlayAll = 0.5,

				{ Cue = "/VO/Melinoe_1461", Text = "Almost there..." },
				{ Cue = "/VO/Melinoe_1462", Text = "Not much farther now..." },
				{ Cue = "/VO/MelinoeField_1279", Text = "The lowest reaches..." },
				{ Cue = "/VO/MelinoeField_1280", Text = "Ground floor..." },
				{ Cue = "/VO/MelinoeField_1281", Text = "Chronos awaits..." },
				{ Cue = "/VO/MelinoeField_1282", Text = "Maintenance access..." },
				{ Cue = "/VO/MelinoeField_1283", Text = "Service entrance..." },
				{ Cue = "/VO/MelinoeField_1284", Text = "...I'm in.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_4586", Text = "No renovations here...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							SumPrevRuns = 8,
							Path = { "SpeechRecord", "/VO/MelinoeField_4586" },
							CountPathTrue = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
			},
		},

	},

	I_PreBoss01 =
	{
		InheritFrom = { "BaseI" },
		LinkedRoom = "I_Boss01",

		BackupCauseOfDeath = "Chronos",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RemainingClockworkGoals", },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
		},
		MaxCreationsPerRoom = 1,
		SkipUnusedWeaponBonusReward = true,
		AlwaysForceOncePerRoom = true,
		AlwaysForceRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeRewardsSpawned", },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "MaxClockworkNonGoalRewards", },
			}
		},
		
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

		ZagContractRewardDestinationId = 776340,

		IneligibleRewards = { "Devotion", "RoomMoneyDrop", },
		ForcedFirstReward = "ClockworkGoal",
		ForcedRewards =
		{
			{
				Name = "ClockworkGoal",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BiomeRewardsSpawned", },
						Comparison = ">=",
						ValuePath = { "CurrentRun", "MaxClockworkNonGoalRewards", },
					}
				},
			},
		},

		StoreDataName = "I_WorldShop",
		SkipShopSecretMusic = true,
		TimerBlock = "ShopEncounter",

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		DisableRewardMagnetisim = true,

		ZoomFraction = 0.75,
		--IntroSequenceDuration = 1.8,
		CameraZoomWeights =
		{
			[410008] = 0.92,
			[714706] = 1.23,
		},

		LegalEncounters = { "Empty" },

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,
		EndMusicOnEnter = true,

		StartThreadedEvents =
		{
			-- { FunctionName = "ClockworkManager", Args = { Interval = 5.0 } },
		},
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,

		ExitTowardsFunctionName = "GenericPresentation",
		ExitTowardsFunctionArgs =
		{
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
			EndMusic = true,
		},

		InspectPoints =
		{
			[410182] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						--
					},
					-- NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_PreBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0219",
							Text = "{#Emph}The stately House of Hades now is but a fading memory, for in its place, a new-formed palace rises; twisted into the visage of the world-conquering Titan of Time." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1435", Text = "It's hideous..." },
						},
					},
				},
			},

			[620001] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_PreBoss01_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_PreBoss01_02 =
					{
						{ Cue = "/VO/Storyteller_0220",
							Text = "{#Emph}Here in fathomless Tartarus, the gods' cruel predecessor Chronos commands his renegade forces, maneuvering against Olympus whilst holding the Underworld in his thrall." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1436", Text = "Olympus can't get to him here..." },
						},
					},
				},
			},

			[620002] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_PreBoss01_02" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_PreBoss01_03 =
					{
						{ Cue = "/VO/Storyteller_0221",
							Text = "{#Emph}The tyrannical Titan's stolen fortress beckons, for the moment undefended and exposed; either because his forces have been scattered, or his certainty of victory, complete." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1437", Text = "Or perhaps both." },
						},
					},
				},
			},

			[755629] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_PreBoss01_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_PreBoss01_04 =
					{
						{ Cue = "/VO/Storyteller_0218",
							Text = "{#Emph}Amid the clamor of the Princess' assault on her eternal foe's stronghold, the Boatman Charon brazenly cuts through the hostile river-waters, with a variety of smuggled wares at hand." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1434", Text = "He's stealthier than I..." },
						},
					},
				},
			},

		},

		EnterVoiceLines =
		{
			{ GlobalVoiceLines = "ApproachingHouseLines" },
		},
		ExitVoiceLines =
		{
			{ GlobalVoiceLines = "InfiltratingHouseLines" },
		},
	},

	I_PreBoss02 =
	{
		InheritFrom = { "I_PreBoss01" },
		
		ZagContractRewardDestinationId = 800817,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RemainingClockworkGoals", },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},

		Ambience = "/Leftovers/Ambience/Ambience1",

		-- This room actually has water, so don't play the sand fishing SFX/VFX
		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsHardSurface",
			["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsHardSurfaceRun",
		},
		SwapAnimations =
		{
			["SuitExhaustSprintDust"] = "SuitExhaustSprintDust_CWT",
			["OlympusSnowExplosionDecal"] = "ExplosionScorchDecal",
		},
		FishingStartSound = "nil",
		FishingDunkSound = "nil",
		FishingFailSound = "nil",

		StartUnthreadedEvents =
		{
			Append = true,
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadPackages = { "Chronos", "Selene", },
					LoadVoiceBanks = { "Chronos", "Selene", },
				},
			},
			{
				FunctionName = "CheckPriorityConversations",
				Args =
				{
					Conversations =
					{
						"NeoChronosAboutTartarus01",
						"NeoChronosAboutTartarus01_B",
						"NeoChronosAboutTartarus02",
					},
				},
			},
		},

		InspectPoints =
		{
			[410182] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutTartarus01_B" }
					},
					-- NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_PreBoss02_01 =
					{
						{ Cue = "/VO/Storyteller_0498",
							Text = "{#Emph}The House of Hades once again stands tall and stately, with the proper countenance engraved upon its heavy door. But the Princess of the Dead has a different entryway in mind." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_4266", Text = "Time for a quick dip..." },
						},
					},
				},
			},
			[620001] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_PreBoss02_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_PreBoss02_02 =
					{
						{ Cue = "/VO/Storyteller_0499",
							Text = "{#Emph}The River Styx here once again flows red, as well it had in ages past, pouring still into the Underworld's heart; even whilst all through Tartarus, the Titan's gold yet glimmers." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_4267", Text = "Not forever, it won't." },
						},
					},
				},
			},
		},

		ExitVoiceLines =
		{
			-- played via ChronosLaunchVoiceLines in this context
		},
	},

	I_Boss01 =
	{
		InheritFrom = { "BaseI" },
		RichPresence = "#RichPresence_Boss",

		ExitPreviewAnim = "ExitDownPreview",
		FlipHorizontal = false,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossChronos01", "BossChronos02" },
		ForcedReward = "MixerIBossDrop",
		-- NarrativeContextArt = "nil",

		RequiresLinked = true,
		LinkedRoom = "I_PostBoss01",
		LeavePostPresentationEvents =
		{
			{
				FunctionName = "SetupHeroForEnding",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
		},

		EntranceFunctionName = "RoomEntranceChronos",
		EntranceFunctionArgs = { LandingTarget = 704921, AngleTowardsIdOnEnd = 609246 },
		BlockCameraReattach = true,
		ZoomFraction = 0.70,

		IgnoreFishingCameraClamps = true,

		Ambience = "/Ambience/DemoEndAmbience",
		UnthreadedEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
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
					ProcessTextLinesIds = { 609246 },
					SetupBossIds = { 609246 },
					SkipAngleTowardTarget = true,
					SkipBossMusic = true,
					ResetRoomZoom = true,
					UnlockDelay = 4.4,
					DelayedStart = true,
				},
			},
			{
				FunctionName = "SetupPauseMenuTakeover",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
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
				-- AllowPause lines if not in EM or the disable upgrade has been purchased
				FunctionName = "SetupPauseMenuTakeover",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">",
						Value = 0,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" },
							},
						},
						{
							{
								Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
								Comparison = "<=",
								Value = 3,
							},
						},
					}
				},
				Args = RoomEventData.PauseMenuTakeOverAllowPause,
			},
			{
				FunctionName = "RandomizeChronosClockface",
			},
		},

		PostCombatReloadEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				Args =
				{
					ExitFunctionName = "EndEarlyAccessPresentation",
					SkipLoadNextMap = true,
				},
			},
			{
				FunctionName = "ChronosPostCombatReload"
			},
		},
		SpawnRewardOnId = 626310,

		EntranceDirection = "Left",
		FlipHorizontalChance = 0.0,

		InspectPoints =
		{
			[626383] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Boss01_01 =
					{
						{ Cue = "/VO/Storyteller_0222",
							Text = "{#Emph}The gutted grand hall of the former House of Hades eerily lies still. Knowing the immortal Titan shall return, the dark Princess pursues an object that may be the key to her predicament." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1438", Text = "It should be in the Prince's chambers still..." },
						},
					},
				},
			},
			[626384] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_Boss01_01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Boss01_02 =
					{
						{ Cue = "/VO/Storyteller_0223",
							Text = "{#Emph}Vanquished only for the moment, scheming Chronos cannot be so easily destroyed; yet in her every fleeting victory against him, fierce Melinoë recovers something she thought lost." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1439", Text = "I still remember flashes of this place..." },
						},
					},
				},
			},
			[793948] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Boss01_03 =
					{
						{ Cue = "/VO/Storyteller_0422",
							Text = "{#Emph}Not even deathless gods are able to entirely withstand the sheer relentless force of Time; and yet upon this night, the Princess of the Dead has seemingly achieved exactly that." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_3615", Text = "I think I know something of Time by now..." },
						},
					},
				},
			},
			[794210] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_Boss01_03" },
					},
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 4,
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Boss01_04 =
					{
						{ Cue = "/VO/Storyteller_0457",
							Text = "{#Emph}The Princess of the Dead has fought by now not only to the ends of the Earth, but to the end of Time; quite the accomplishment for one still in the midst of youth." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3655", Text = "Well, you know..." },
						},
					},
				},
			},
			[797657] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirements = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Boss01TrueEnding_01 =
					{
						{ Cue = "/VO/Storyteller_0527",
							Text = "{#Emph}For the moment, Time stands still... stricken by the enchanted spear Gigaros, and temporarily susceptible to one final step the Princess of the Dead has planned." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							-- RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_3881", Text = "...now for Zagreus to do his part." },
						},
					},
				},
			},
			[797653] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutroPostTrueEnding01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Boss01_05 =
					{
						{ Cue = "/VO/Storyteller_0520",
							Text = "{#Emph}A vision of the House of Hades, overtaken by the Titan of Time... one possibility that could have come to pass, had not the Princess just eradicated him." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_5023", Text = "I can get used to this." },
						},
					},
				},
			},


		},

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				PreLineFunctionName = "UnmuteSpeakerPermanent",

				-- Hidden Aspect Quests
				{ Cue = "/VO/MelinoeField_3553", Text = "{#Emph}Great Anubis, grant me and Descura now abyssal strength.",
					PreLineThreadedFunctionName = "LegendaryAspectPresentation",
					PreLineThreadedFunctionArgs = { WaitTime = 4.9, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedAnubis" },
					PreLineWait = 2.0,
					PlayFirst = true,
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffRaiseDeadAspect" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3554", Text = "{#Emph}May the Morrigan now sharpen Lim and Oros for the kill.",
					PreLineThreadedFunctionName = "LegendaryAspectPresentation",
					PreLineThreadedFunctionArgs = { WaitTime = 4.6, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedMorrigan" },
					PreLineWait = 2.0,
					PlayFirst = true,
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerTripleAspect" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3555", Text = "{#Emph}Mighty Supay, now make Ygnium burn brighter still.",
					PreLineThreadedFunctionName = "LegendaryAspectPresentation",
					PreLineThreadedFunctionArgs = { WaitTime = 4.7, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedSupay" },
					PreLineWait = 2.0,
					PlayFirst = true,
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchAutofireAspect" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3556", Text = "{#Emph}May Nergal grant this form of Zorephet still greater might.",
					PreLineThreadedFunctionName = "LegendaryAspectPresentation",
					PreLineThreadedFunctionArgs = { WaitTime = 5.0, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedNergal" },
					PreLineWait = 2.0,
					PlayFirst = true,
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxeRallyAspect" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3557", Text = "{#Emph}May the dark goddess Hel awaken in Revaal power untold.",
					PreLineThreadedFunctionName = "LegendaryAspectPresentation",
					PreLineThreadedFunctionArgs = { WaitTime = 4.9, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedHel" },
					PreLineWait = 2.0,
					PlayFirst = true,
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "LobGunAspect" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3558", Text = "{#Emph}Great Shiva, grant to Xinth your full destructive force.",
					PreLineThreadedFunctionName = "LegendaryAspectPresentation",
					PreLineThreadedFunctionArgs = { WaitTime = 4.9, SoundName = "/Leftovers/Menu Sounds/EmoteAscendedShiva" },
					PreLineWait = 2.0,
					PlayFirst = true,
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SuitComboAspect" },
						},
					},
				},
			},
			{
				PreLineWait = 0.25,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosBossAboutHecateKidnapped01" },
					},
					NamedRequirements = { "HecateMissing" },
				},
				PreLineFunctionName = "UnmuteSpeakerPermanent",
				{ Cue = "/VO/MelinoeField_3876", Text = "{#Emph}Pah! {#Prev}Where is she?!" },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3876" },
					},
				},

				{ Cue = "/VO/MelinoeField_1305", Text = "{#Emph}<Gasp> {#Prev}Pff..." },
				{ Cue = "/VO/MelinoeField_1306", Text = "{#Emph}<Gasp> {#Prev}...I'm home..." },
				{ Cue = "/VO/MelinoeField_1308", Text = "{#Emph}<Cough> {#Prev}Chronos...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1309", Text = "{#Emph}<Cough>" },
				{ Cue = "/VO/MelinoeField_1310", Text = "{#Emph}<Cough>" },
				{ Cue = "/VO/MelinoeField_4195", Text = "{#Emph}<Cough> {#Prev}Wow... it worked...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							Path = { "GameState", "SpeechRecord", "/VO/MelinoeField_4195" },
							Comparison = "<=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4196", Text = "{#Emph}<Cough> Whew... {#Prev}wow...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4195" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4197", Text = "{#Emph}<Cough> {#Prev}Oh, hello...!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4195" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1307", Text = "{#Emph}<Cough> {#Prev}...refreshing...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "Chronos" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				ObjectType = "Chronos",
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "Chronos", "QueuedBossIntroTextLines", "Name" },
						IsAny = { "ChronosBossAboutHecateKidnapped01" },
					},
				},
				{ Cue = "/VO/Chronos_1517", Text = "{#Emph}She {#Prev}is now my guest." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ChronosHecKidnappedIntroVO",
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				ObjectType = "Chronos",
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "Chronos", "QueuedBossIntroTextLines", "Name" },
						IsAny = { "ChronosBossAboutHecateKidnapped01" },
					},
					NamedRequirements = { "HecateMissing" },
				},
				{ Cue = "/VO/Chronos_0984", Text = "Looking for someone?" },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ChronosEarlyIntroVO",
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 2.0,
				ObjectType = "Chronos",
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "UseRecord", "NPC_Chronos_01" },
					},
				},
				{ Cue = "/VO/Chronos_0203", Text = "A visitor, at this hour?" },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ChronosEarlyIntroVOB",
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 2.0,
				ObjectType = "Chronos",
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Chronos_01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChronosReveal01", "ChronosReveal01B" },
					},
				},
				{ Cue = "/VO/Chronos_0206", Text = "We meet again, my girl." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ChronosPostEndingIntroVO",
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				ObjectType = "Chronos",
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Chronos_1048", Text = "You again..." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ChronosPreFightTyphonDeathVO",
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				ObjectType = "Chronos",
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceAboutTyphonDeath01" },
					},
				},
				{ Cue = "/VO/Chronos_0983", Text = "What have you done...?" },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 2.0,
				ObjectType = "Chronos",
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "Chronos", "QueuedBossIntroTextLines", "Name" },
						IsAny = { "ChronosBossAboutFamily01" },
					},
				},
				{ Cue = "/VO/Chronos_0982", Text = "You {#Emph}dare {#Prev}return?" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				--PreLineWait = 1.8,
				PreLineWait = 2.0,
				SuccessiveChanceToPlayAll = 0.75,
				ObjectType = "Chronos",
				PreLineAnim = "Enemy_Chronos_SittingGreeting",

				{ Cue = "/VO/Chronos_0163", Text = "{#Emph}Ahh. {#Prev}Welcome, my girl.", PlayFirst = true },
				{ Cue = "/VO/Chronos_0187", Text = "Hello again, my girl." },
				{ Cue = "/VO/Chronos_0188", Text = "Hello, my girl." },
				{ Cue = "/VO/Chronos_0189", Text = "Welcome." },
				{ Cue = "/VO/Chronos_0190", Text = "Welcome back." },
				{ Cue = "/VO/Chronos_0191", Text = "You yet persist." },
				{ Cue = "/VO/Chronos_0192", Text = "{#Emph}Ah{#Prev}, at last." },
				{ Cue = "/VO/Chronos_0193", Text = "Come closer..." },
				{ Cue = "/VO/Chronos_0194", Text = "We have a visitor." },
				{ Cue = "/VO/Chronos_0195", Text = "Come all this way again..." },
				{ Cue = "/VO/Chronos_0015", Text = "The Hades girl returns!" },
				{ Cue = "/VO/Chronos_0017", Text = "Welcome to my House." },
				{ Cue = "/VO/Chronos_0018", Text = "You waste what precious time remains to you." },
				{ Cue = "/VO/Chronos_0020", Text = "The Fates cannot help you now..." },
				{ Cue = "/VO/Chronos_0030", Text = "Do not presume to test my patience here." },
				{ Cue = "/VO/Chronos_0799", Text = "Returned again, I see." },
				{ Cue = "/VO/Chronos_0800", Text = "And not a moment late." },
				{ Cue = "/VO/Chronos_0801", Text = "You are, at least, precise." },
				{ Cue = "/VO/Chronos_0802", Text = "My granddaughter." },
				{ Cue = "/VO/Chronos_0980", Text = "Oh not {#Emph}again..." },
				{ Cue = "/VO/Chronos_0981", Text = "...Oh, {#Emph}blast..." },
				{ Cue = "/VO/Chronos_0982", Text = "You {#Emph}dare {#Prev}return?",
					GameStateRequirements =
					{
						{
							SumPrevRuns = 8,
							Path = { "SpeechRecord", "/VO/Chronos_0982" },
							CountPathTrue = true,
							Comparison = "==",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/Chronos_0804", Text = "How predictable." },
				{ Cue = "/VO/Chronos_0805", Text = "My, my..." },
				{ Cue = "/VO/Chronos_0979", Text = "{#Emph}Guards?! {#Prev}...Cowards.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = {
								"HadesChronosDebuffBoon",
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_0798", Text = "You look a bit unwell.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0163" },
						},
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.5, },
						},
					}
				},
				{ Cue = "/VO/Chronos_1207", Text = "You are late.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BiomeSpeedShrineUpgrade" },
							Comparison = ">=",
							Value = 1,
						},
						{
							Path = { "CurrentRun", "BiomeTime" },
							Comparison = "<=",
							Value = 30,
						},
					},
				},
				{ Cue = "/VO/Chronos_1208", Text = "Your Time runs very short...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BiomeSpeedShrineUpgrade" },
							Comparison = ">=",
							Value = 1,
						},
						{
							Path = { "CurrentRun", "BiomeTime" },
							Comparison = "<=",
							Value = 20,
						},
					},
				},
				{ Cue = "/VO/Chronos_1209", Text = "You seem a little short of breath...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.5, },
						},
						{
							Path = { "GameState", "ShrineUpgrades", "BiomeSpeedShrineUpgrade" },
							Comparison = ">=",
							Value = 1,
						},
						{
							Path = { "CurrentRun", "BiomeTime" },
							Comparison = "<=",
							Value = 25,
						},
					},
				},
				{ Cue = "/VO/Chronos_1210", Text = "You seem rather in a hurry...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BiomeSpeedShrineUpgrade" },
							Comparison = ">=",
							Value = 1,
						},
						{
							Path = { "CurrentRun", "BiomeTime" },
							Comparison = "<=",
							Value = 25,
						},
					},
				},
				{ Cue = "/VO/Chronos_1211", Text = "No Time for you to spare...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BiomeSpeedShrineUpgrade" },
							Comparison = ">=",
							Value = 1,
						},
						{
							Path = { "CurrentRun", "BiomeTime" },
							Comparison = "<=",
							Value = 25,
						},
					},
				},
				{ Cue = "/VO/Chronos_1212", Text = "What took you so long?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BiomeSpeedShrineUpgrade" },
							Comparison = ">=",
							Value = 1,
						},
						{
							Path = { "CurrentRun", "BiomeTime" },
							Comparison = "<=",
							Value = 30,
						},
					},
				},
				{ Cue = "/VO/Chronos_0803", Text = "Returned from aboveground?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0163" },
						},
						{
							PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" },
						},
					},
				},
				{ Cue = "/VO/Chronos_0946", Text = "My, what a lovely dress.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutro01" },
						},
						{
							PathFalse = { "CurrentRun", "SpawnRecord", "NPC_Chronos_01" }
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0947", Text = "All clad in black just like your father.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutro01" },
						},
						{
							PathFalse = { "CurrentRun", "SpawnRecord", "NPC_Chronos_01" }
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = {
								"HighArmorCostume",
							},
						},
					},
				},
				{ Cue = "/VO/Chronos_0948", Text = "Oh good, you brought a change of clothes!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutro01" },
						},
						{
							PathFalse = { "CurrentRun", "SpawnRecord", "NPC_Chronos_01" }
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0949", Text = "At least you dressed for the occasion.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutro01" },
						},
						{
							PathFalse = { "CurrentRun", "SpawnRecord", "NPC_Chronos_01" }
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0806", Text = "Still in that dress?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpawnRecord", "NPC_Chronos_01" }
						},
						{
							Path = { "GameState", "SpeechRecord" },
							HasAny = { "/VO/Chronos_0794", "/VO/Chronos_0792" }
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0807", Text = "Your silk is still intact?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAny = { "/VO/Chronos_0794", "/VO/Chronos_0792" }
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0808", Text = "That silk lasted this long?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAny = { "/VO/Chronos_0794", "/VO/Chronos_0792" }
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0809", Text = "Your silk has served you well.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAny = { "/VO/Chronos_0794", "/VO/Chronos_0792" }
						},
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = GameData.AllArachneCostumes,
						},
					},
				},
				{ Cue = "/VO/Chronos_0196", Text = "Time again, is it?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Boss01" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Chronos_0203", Text = "A visitor, at this hour?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Boss01" },
							Comparison = ">=",
							Value = 9,
						},
					},
				},
				{ Cue = "/VO/Chronos_0206", Text = "We meet again, my girl.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Boss01" },
							Comparison = ">=",
							Value = 9,
						},
					},
				},
				{ Cue = "/VO/Chronos_0984", Text = "Looking for someone?",
					GameStateRequirements =
					{
						{
							FunctionName = "RequireRunsSinceTextLines",
							FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 9 },
						},
					},
				},
				{ Cue = "/VO/Chronos_1048", Text = "You again...",
					GameStateRequirements =
					{
						{
							FunctionName = "RequireRunsSinceTextLines",
							FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 9 },
						},
					},
				},
			},
		},

		Using = { "ChronosRemainsBroken", "ChronosBattleOutroDeathParticleEmitter", "ChronosGigarosKillFx", "ChronosBattleOutroDeathParticleEmitterGigarosKill", },
	},

	I_Shop01 =
	{	
		InheritFrom = { "BaseI" },
		DebugOnly = true,
		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 3,
		ForceAtBiomeDepthMax = 5,
		LegalEncounters = { "Shop" },
		NoReward = true,
		RewardPreviewOverride = "ShopPreview",
		StoreDataName = "WorldShop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		ShopSecretMusic = "/Music/CharonShopTheme",
		NoReroll = true,

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredMinExits",
				FunctionArgs = { Count = 2 },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomCreations" },
				HasNone = { "I_Shop01", "I_Story01", "I_Reprieve01", "I_MiniBoss01", "I_MiniBoss02" },
			},
			{
				FunctionName = "RequiredOfferedDoorWitRoomSetName",
				FunctionArgs =
				{
					RoomSetName = "I",
				},
			},
		},

		ZoomFraction = 0.75,

		SpawnRewardGlobalVoiceLines = "FoundShopVoiceLines",
	},

	I_Reprieve01 =
	{
		InheritFrom = { "BaseI", "I_TwoExits" },
		IneligibleRewards = { "Devotion", },
		-- SuppressRewardSpawnSounds = true,

		ZoomFraction = 0.7,
		EntranceDirection = "LeftRight",
		
		MaxCreationsThisRun = 1,
		LegalEncounters = { "HealthRestore" },
		SecretMusic = "/Music/BlankMusicCue",
		Ambience = "/Leftovers/Ambience/StillWaterAmbience",
		--ZoomFraction = 0.75,
		FlipHorizontalChance = 0.0,
		DisableRewardMagnetisim = true,
		IntroSequenceDuration = 0.02,
		SpawnRewardOnId = 410000,

		HarvestPointChances = { 0.4, 0.2, },
		ShovelPointChance = 0.16,
		PickaxePointChance = 0.24,
		ExorcismPointChance = 0.16,
		FishingPointChance = 0.12,

		-- This room actually has water, so don't play the sand fishing SFX/VFX
		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/SFX/Player Sounds/FootstepsHardSurface",
			["/Leftovers/SFX/FootstepsWheat"] = "/SFX/Player Sounds/FootstepsHardSurfaceRun",
		},
		SwapAnimations =
		{
			["SuitExhaustSprintDust"] = "SuitExhaustSprintDust_CWT",
			["OlympusSnowExplosionDecal"] = "ExplosionScorchDecal",
		},
		FishingStartSound = "nil",
		FishingDunkSound = "nil",
		FishingFailSound = "nil",

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 1.0 }, Args = { StartingCountMin = 24, StartingCountMax = 36, ObjectNames = { "ShadeMerc" }, MaxActive = 36 } },
		},

		GameStateRequirements =
		{
			Append = true,
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeTartarusReprieve" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomCreations" },
				HasNone = { "I_Shop01", "I_Story01", "I_Reprieve01", "I_MiniBoss01", "I_MiniBoss02" },
			},
			{
				FunctionName = "RequiredOfferedDoorWitRoomSetName",
				FunctionArgs =
				{
					RoomSetName = "I",
				},
			},
		},

		InspectPoints =
		{
			[480765] =
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
					Inspect_I_Reprieve01_01 =
					{
						{ Cue = "/VO/Storyteller_0217",
							Text = "{#Emph}A long-forgotten hidden refuge within Tartarus provides the Princess of the Dead some small reprieve... much as it did for her own brother, in a bygone time." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1433", Text = "These waters still run clear enough, somehow..." },
						},
					},
				},
			},

		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},

		MusicMutedStems = { "Drums" },
		EnterGlobalVoiceLines = "EnteredReprieveRoomVoiceLines",

		-- Ambience = "/Leftovers/Ambience/StillWaterAmbience",
	},

	I_BaseCombat =
	{
		DebugOnly = true,

		IneligibleRewards = { "Boon" },
		ForcedFirstReward = "ClockworkGoal",
		ForcedRewards =
		{
			{
				Name = "ClockworkGoal",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BiomeRewardsSpawned", },
						Comparison = ">=",
						ValuePath = { "CurrentRun", "MaxClockworkNonGoalRewards", },
					}
				},
			},
		},

		CombatResolvedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "CombatResolvedVoiceLines" },
		},

	},

	I_Combat01 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },

		EntranceDirection = "Left",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat02 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		HasFishingPoint = false,

		EntranceDirection = "Left",

		LegalEncounters = EncounterSets.IEncountersSmaller,
	},

	I_Combat03 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		HasFishingPoint = false,

		EntranceDirection = "Right",

		LegalEncounters = EncounterSets.IEncountersSmaller,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat04 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		HasFishingPoint = false,

		EntranceDirection = "Left",

		LegalEncounters = EncounterSets.IEncountersSmaller,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat05 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		HasFishingPoint = false,

		ZoomFraction = 0.8,

		EntranceDirection = "LeftRight",

		LegalEncounters = EncounterSets.IEncountersSmaller,
	},

	I_Combat06 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },

		EntranceDirection = "Left",

		RushMaxRangeOverride = 475,
	},

	I_Combat07 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },

		EntranceDirection = "Left",
	},

	I_Combat08 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		HasFishingPoint = false,

		EntranceDirection = "Left",
	},

	I_Combat09 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		HasFishingPoint = false,

		EntranceDirection = "Right",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat10 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		EntranceDirection = "LeftRight",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat11 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		EntranceDirection = "LeftRight",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat12 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		EntranceDirection = "Right",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat13 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		ZoomFraction = 0.8,
		EntranceDirection = "LeftRight",
	},

	I_Combat14 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		ZoomFraction = 0.85,
		EntranceDirection = "Right",
	},

	I_Combat15 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		
		HasFishingPoint = false,

		EntranceDirection = "Left",
	},

	I_Combat16 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		
		HasFishingPoint = false,

		EntranceDirection = "Left",

		RushMaxRangeOverride = 475,
	},

	I_Combat17 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },

		EntranceDirection = "Right",
	},

	I_Combat18 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		HasFishingPoint = false,

		EntranceDirection = "Left",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat19 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },

		EntranceDirection = "LeftRight",
	},

	I_Combat20 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		HasFishingPoint = false,

		EntranceDirection = "Left",

		LegalEncounters = EncounterSets.IEncountersSmaller,
	},

	I_Combat21 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		HasFishingPoint = false,

		EntranceDirection = "LeftRight",

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat22 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat", "I_TwoExits" },
		HasFishingPoint = false,

		EntranceDirection = "Right",

		LegalEncounters = EncounterSets.IEncountersSmaller,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_Combat23 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },

		EntranceDirection = "LeftRight",
	},

	I_Combat24 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },

		EntranceDirection = "Left",

		GameStateRequirements =
		{
			Append = true,
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeTartarusReprieve" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 6,
			},
		},
	},

	I_MiniBoss01 =
	{
		InheritFrom = { "BaseI", "I_TwoExits" },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		HasFishingPoint = false,
		
		SecretSpawnChance = 0.0,
		SuppressRewardSpawnSounds = false,
		ReverbValue = 1.0,

		ZoomFraction = 0.775,

		GameStateRequirements =
		{
			Append = true,
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "I_MiniBoss02" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomCreations" },
				HasNone = { "I_Shop01", "I_Story01", "I_Reprieve01", "I_MiniBoss01", "I_MiniBoss02" },
			},
			{
				FunctionName = "RequiredOfferedDoorWitRoomSetName",
				FunctionArgs =
				{
					RoomSetName = "I",
				},
			},
		},

		--SpawnRewardOnId = 621502,

		LegalEncounters = { "MiniBossRatCatcher" },
		FlipHorizontalChance = 0.0,

		EligibleRewards = { "Boon" },
		-- BoonRaritiesOverride = { Legendary = 0.1, Epic = 0.25, Rare = 0.90 },
		BoonRaritiesOverride = { Duo = 0.2, Legendary = 0.2, Epic = 0.10, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 3,
		ForceAtBiomeDepthMax = 7,
		MaxAppearancesThisBiome = 1,

		EntranceDirection = "Left",

		InspectPoints =
		{
			[723011] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_MiniBoss_01_01 =
					{
						{ Cue = "/VO/Storyteller_0236",
							Text = "{#Emph}The Satyrs and the vermin at their call once lurked the upper reaches of the Underworld, making profane preparations for the Titan Lord's return." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_1663", Text = "Those Satyrs belong here more than they know." },
						},
					},
				},
			},

		},

		CombatResolvedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},

		MusicActiveStems = { "Guitar", "Bass", "Drums", },
	},

	I_MiniBoss02 =
	{
		InheritFrom = { "I_MiniBoss01", },

		BreakableValueOptions = { MaxHighValueBreakables = 12 },
		BreakableHighValueChanceMultiplier = 100.0,

		HasFishingPoint = true,

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "I_MiniBoss01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomCreations" },
				HasNone = { "I_Shop01", "I_Story01", "I_Reprieve01", "I_MiniBoss01", "I_MiniBoss02" },
			},
			{
				FunctionName = "RequiredOfferedDoorWitRoomSetName",
				FunctionArgs =
				{
					RoomSetName = "I",
				},
			},
			{ -- Manually Add TwoExits requirement since Append would double inherit from I_MiniBoss01 and TwoExit
				Path = { "CurrentRun", "BiomeRewardsSpawned", },
				Comparison = "<",
				ValuePath = { "CurrentRun", "MaxClockworkNonGoalRewards", },
				ValuePathAddition = -1,
			}
		},

		LegalEncounters = { "MiniBossGoldElemental" },

		InspectPoints =
		{
			[723012] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_MiniBoss_02_01 =
					{
						{ Cue = "/VO/Storyteller_0237",
							Text = "{#Emph}Pure, glimmering gold: a metal shunned by the true King of the Underworld not just for its softness, but because it was favored by his Titan father. A stark reminder of a bygone age." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_1664", Text = "It's shiny, but so what?" },
						},
					},
				},
			},

		},

		CombatResolvedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "CWTartarusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	I_MiniBoss03 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		DebugOnly = true,
		
		HasFishingPoint = false,

		EntranceDirection = "Right",
	},

	-- NPC room layout 1
	I_Story01 =
	{
		InheritFrom = { "BaseI" },
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		ForceIfUnseenForRuns = 6,

		HasFishingPoint = false,

		HarvestPointRequirements =
		{
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantIShaderot" },
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
				Path = { "GameState", "LifetimeResourcesGained", "PlantHWheatSeed" },
				Comparison = ">=",
				Value = 2,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantIPoppySeed" },
						Comparison = "<",
						Value = 6,
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
			{
				Path = { "GameState", "LifetimeResourcesGained", "OreHGlassrock" },
				Comparison = ">=",
				Value = 6,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreIMarble" },
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

		ForceAtBiomeDepthMin = 2,
		ForceAtBiomeDepthMax = 4,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomsEntered", "I_Intro" },
				Comparison = ">",
				Value = 1,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomCreations" },
				HasNone = { "I_Shop01", "I_Story01", "I_Reprieve01", "I_MiniBoss01", "I_MiniBoss02" },
			},
			{
				FunctionName = "RequiredOfferedDoorWitRoomSetName",
				FunctionArgs =
				{
					RoomSetName = "I",
				},
			},
			NamedRequirementsFalse = { "StandardPackageBountyActive", "HecateMissing", "AfterTrueEndingBeforeFinalBoss" },
		},

		SecretMusic = "/Music/EndThemeAcoustic",
		TrueEndingSecretMusic = "/Music/EndThemeORCHESTRAL",
		ZoomFraction = 0.85,
		TimerBlock = "StoryRoom",

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Hades_01" },
		EntranceDirection = "LeftRight",

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 700,
		CerberusPetTargetId = 731281,

		InspectPoints =
		{
			[506297] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Story01_01 =
					{
						{ Cue = "/VO/Storyteller_0215",
							Text = "{#Emph}The once-feared Underworld King resembles now the wretched and the damned that here were shackled in his stead, until the scheming Titan Chronos cut them loose." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1431", Text = "Unforgivable..." },
						},
					},
				},
			},

			[690323] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_Story01_01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_Story01_02 =
					{
						{ Cue = "/VO/Storyteller_0216",
							Text = "{#Emph}All bound in chains of hardest adamant, the erstwhile Lord and Master of the Dead now is a prisoner within the realm the Fates themselves decreed was his by right." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1432", Text = "I'm sorry, Father..." },
						},
					},
				},
			},

		},

		EnterVoiceLines =
		{
			{
				PreLineWait = 1.25,
				-- SuccessiveChanceToPlay = 0.75,
				SuccessiveChanceToPlayAll = 0.5,
				RandomRemaining = true,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Persephone_01", }, Alive = true },
					},
				},
				Cooldowns =
				{
					{ Name = "HadesSpokeRecently", Time = 2 },
				},

				{ Cue = "/VO/MelinoeField_4144", Text = "Mother! Father!" },
				{ Cue = "/VO/MelinoeField_4145", Text = "Mother. Father." },
				{ Cue = "/VO/MelinoeField_4146", Text = "Family!" },
				{ Cue = "/VO/MelinoeField_4147", Text = "Family." },
				{ Cue = "/VO/MelinoeField_3318", Text = "Down, girl.",
					PostLineFunctionName = "HoundFamiliarReaction",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EquippedFamiliar" },
							IsAny = { "HoundFamiliar" },
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Cerberus_Field_01", }, Alive = true },
						},
					},
				},
			},
			{
				PlayOnce = true,
				PlayOnceContext = "IStoryEnterVoiceLines",
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 1.5,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Melinoe_1159", Text = "It can't be... Cerberus...!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1160", Text = "Cerberus!" },
				{ Cue = "/VO/Melinoe_0810", Text = "What...?" },
			},
			{
				PreLineWait = 1.25,
				-- SuccessiveChanceToPlay = 0.75,
				RandomRemaining = true,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				Cooldowns =
				{
					{ Name = "HadesSpokeRecently", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_1519", Text = "Father...!" },
				{ Cue = "/VO/MelinoeField_1520", Text = "Father...?" },
				{ Cue = "/VO/MelinoeField_1521", Text = "{#Emph}Erm... {#Prev}greetings, Father...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1522", Text = "Greetings, Father..." },
				{ Cue = "/VO/MelinoeField_1523", Text = "It's me..." },
				{ Cue = "/VO/MelinoeField_1524", Text = "It's... me..." },
				{ Cue = "/VO/MelinoeField_3318", Text = "Down, girl.",
					PlayFirst = true,
					PostLineFunctionName = "HoundFamiliarReaction",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EquippedFamiliar" },
							IsAny = { "HoundFamiliar" },
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids = { 506405 } },
						},
					},
				},
			},
		},

		-- moved to ThankingHadesVoiceLines
		ExitVoiceLines =
		{
		},

		UnthreadedEvents =
		{
		},

		StartThreadedEvents =
		{
			-- { FunctionName = "ClockworkManager", Args = { Interval = 5.0 } },
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding", },
					},
				},
				Args =
				{
					Groups = { "TrueEndingActivated" },
				},
			},
			{
				FunctionName = "GenericPresentation",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding", },
					},
				},
				Args =
				{
					Ids = { 625906, 625913, 625908, 625912, 625910, 625909, 625907, 731175, 731176, 731237, 625375, },
					SetAlpha = 0,
				},
			},
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding", },
					},
				},
				Args =
				{
					Groups = { "TrueEndingDeactivated" },
				},
			},
		},
		ThreadedEvents =
		{
		},
	},

	-- @ ending
	I_PostBoss01 =
	{
		InheritFrom = { "BaseI" },
		RichPresence = "#RichPresence_PostBossUnderworld",
		LegalEncounters = { "Empty" },

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

		BlockCombat = true,

		GameStateRequirements =
		{
			-- None
		},

		EntranceFunctionName = "RoomEntranceIPostBoss",
		RequiresLinked = true,
		LinkedRoom = "I_ChronosFlashback01",
		ExitPreviewAnim = "ExitDownPreview",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.9,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SecretSpawnChance = 0.0,

		ReverbValue = -1,
		GlobalEcho = 0,

		StartUnthreadedEvents =
		{
			{ FunctionName = "HideGameplayTimers" },
			{ FunctionName = "MirrorOffPresentation", },
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Zagreus", "Chronos" },
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					Types = { "NPC_Zagreus_Past_01" },
				},
			},
			{
				FunctionName = "CheckPriorityConversations",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					Conversations =
					{
						"ZagreusPastMeeting06",
						"ZagreusPastMeeting06_B",
						"ZagreusPastFirstMeeting",
						"ZagreusPastMeeting02",
						"ZagreusPastMeeting02_2",
						"ZagreusPastMeeting03",
						"ZagreusPastMeeting04",
						"ZagreusPastMeeting04_2",
						"ZagreusPastMeeting04_3",
						"ZagreusPastMeeting05",
						-- optional
						"ZagreusPastMeeting07",
					},
					IgnorePackages = true,
				},
			},
			{
				FunctionName = "CheckConversations",
			},
		},

		ObstacleData =
		{
			-- Bed
			[310036] =
			{
				Name = "DreamBed01",
				InteractDistance = 250,
				UseText = "UseHouseBed",
				OnUsedFunctionName = "DreamBedPresentation",

				SetupEvents =
				{
					{
						FunctionName = "GenericPresentation",
						Args =
						{
							CreateAnimation = "IPostBossBedSparkles",
						},
					},
				},
			},

			-- Mirror of Night
			[741588] =
			{
				Name = "NightMirror01",
				InteractDistance = 250,
				UseText = "UseHouseMirror",
				OnUsedFunctionName = "TimeMirrorPresentation",
				OnUsedGameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "DreamBed01" },
					},
					OrRequirements =
					{
						{
							{
								PathFalse = { "MapState", "ActiveObstacles", 800279 },
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "UseRecord", "HadesSpear01" }
							},
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
						WithinDistance = 150,
						VoiceLines = { GlobalVoiceLines = "MirrorInitialInspectLines" },
					},
				},
			},

			-- Gigaros
			[800279] =
			{
				Name = "HadesSpear01",
				InteractDistance = 190,
				UseText = "UseHadesSpear",
				OnUsedFunctionName = "UseHadesSpearPresentation",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ZagreusPastMeeting04_3" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting05" },
					},
				},
				DestroyIfNotSetup = true,

				SetupEvents =
				{
					{
						FunctionName = "GenericPresentation",
						Args =
						{
							SetAlpha = 0.0,
							UseableOff = true,
						},
					},
				},

				DistanceTriggers =
				{
					{
						TriggerObjectType = "MetaUpgradeScreen",
						WithinDistance = 150,
						Repeat = true,
						FunctionName = "PingHadesSpear",
					},
				},
			},

			-- Zagreus Mirror
			[772206] =
			{
				Name = "ZagreusPastMirrorLinesTrigger",
				DistanceTriggers =
				{
					{
						WithinDistance = 600,
						VoiceLines = { GlobalVoiceLines = "ZagreusPastMirrorLines" },
					},
				},
			},
			[772208] =
			{
				Name = "ZagreusPastMirror",
				DistanceTriggers =
				{
					{
						Name = "ZagreusInterrupt",
						WithinDistance = 450,
						VoiceLines = { GlobalVoiceLines = "ZagreusPastGreetingLines" },
					},
				},
			},

			-- fake exit to I_DeathAreaRestored
			[420896] =
			{
				Name = "I_PostBossExit",
				DistanceTriggers =
				{
					{
						WithinDistance = 350,
						Repeat = true,
						VoiceLines =
						{
							PlayOnceFromTableThisRun = true,
							RandomRemaining = true,
							PlayOnce = true,
							PlayOnceContext = "ZagBedroomExitAttemptVO",
							UsePlayerSource = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "CurrentRoom", "InDreamState" },
								},
								{
									Path = { "CurrentRun", "TextLinesRecord" },
									HasNone = { "ZagreusPastMeeting06", "ZagreusPastMeeting06_B" },
								},
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},

							{ Cue = "/VO/MelinoeField_1263", Text = "No turning back.", PlayFirst = true },
							{ Cue = "/VO/MelinoeField_1264", Text = "Not going there." },
							{ Cue = "/VO/MelinoeField_1267", Text = "Not this way..." },
						},
					},
				},

				HideRewardPreview = true,

				InteractDistance = 350,
				InteractOffsetX = 45,
				InteractOffsetY = 135,
				AutoActivate = true,
			},

			-- satyr sack
			[742074] =
			{
				Name = "SatyrSack01",
				DistanceTriggers =
				{
					{
						WithinDistance = 150,
						VoiceLines =
						{
							PlayOnce = true,
							PlayOnceContext = "ZagBedroomObservationVO",
							UsePlayerSource = true,
							GameStateRequirements =
							{
								NamedRequirementsFalse = { "HecateMissing" },
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},
							{ Cue = "/VO/MelinoeField_3407", Text = "Such an awful mess..." },
						},
					},
				},
			},

		},

		InspectPoints =
		{
			[772209] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
					},
					-- NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_PostBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0413",
							Text = "{#Emph}The chambers of the missing Underworld Prince lie in a perpetual state of utter disarray; marked by the passage of Time, but otherwise untouched, for who would dare?" },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3859", Text = "Just as we surmised..." },
						},
					},
				},
			},
			[772210] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_PostBoss01_01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
					},
					-- NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_I_PostBoss01_02 =
					{
						{ Cue = "/VO/Storyteller_0414",
							Text = "{#Emph}The ancient Mirror of Night, that conduit of dark primordial power from before Time took hold, lies forgotten amid the myriad possessions of the captive Underworld Prince." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3860", Text = "An ordinary mirror, nothing more..." },
						},
					},

				},
			},

		},

		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "ZagChamberFinalEntranceVO",
				PreLineWait = 1.2,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					NamedRequirements = { "HecateMissing" },
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_5040", Text = "Hold on, Headmistress..." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "ZagChamberEntranceVO",
				PreLineWait = 1.0,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
					},
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_3404", Text = "The Prince's chambers... the Mirror..." },
				{ Cue = "/VO/MelinoeField_3405", Text = "Just as it was..." },
				{ Cue = "/VO/MelinoeField_3406", Text = "All right, Brother..." },
				{ Cue = "/VO/MelinoeField_1259", Text = "So much dust..." },
				{ Cue = "/VO/MelinoeField_3408", Text = "Hold on, Brother..." },
			},
		},

	},

	-- @ ending
	I_ChronosFlashback01 =
	{
		InheritFrom = { "BaseI" },
		RichPresence = "#RichPresence_Dream",
		LegalEncounters = { "Empty" },
		-- Ambience = "/Ambience/MusicExploration4AMBIENCEIris",
		NarrativeContextArt = nil,
		SpeakerName = { "Chronos", "Persephone", "Achilles", "Nyx" },

		HeroOverwrites =
		{
			AttachedAnimationName = "nil",
			LineHistoryName = "NPC_Chronos_01",
			SubtitleColor = Color.ChronosVoice,
		},

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

		BlockCombat = true,
		BlockFamiliars = true,

		GameStateRequirements =
		{
			-- None
		},

		EntranceFunctionName = "RoomEntranceIChronosFlashback",
		RequiresLinked = true,
		LinkedRoom = "I_DeathAreaRestored",
		ExitPreviewAnim = "ExitDownPreview",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.9,
		IgnoreClamps = true, -- these are set via script

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SecretSpawnChance = 0.0,

		ReverbValue = 1.2,
		GlobalEcho = 0,

		StartUnthreadedEvents =
		{
			{ FunctionName = "HideGameplayTimers" },
			{ FunctionName = "MirrorOffPresentation" },
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Zagreus", "Chronos" },
				},
			},
		},

		ObstacleData =
		{
			[812338] =
			{
				Name = "NWExit",
				DistanceTrigger =
				{
					PreTriggerWait = 0.1,
					WithinDistance = 250,
					VoiceLines =
					{
						{
							PlayOnce = true,
							PlayOnceContext = "ChronosFlashbackVO",
							UsePlayerSource = true,
							BreakIfPlayed = true,

							-- { Cue = "/VO/Chronos_1410", Text = "She cannot possibly be there..." },
							-- { Cue = "/VO/Chronos_1411", Text = "Off limits..." },
							{ Cue = "/VO/Chronos_1412", Text = "Already searched there..." },
						},
					},
				},
			},
			[811664] =
			{
				Name = "NEExit",
				DistanceTrigger =
				{
					PreTriggerWait = 0.1,
					WithinDistance = 300,
					VoiceLines =
					{
						{
							PlayOnce = true,
							PlayOnceContext = "ChronosFlashbackVO",
							UsePlayerSource = true,
							BreakIfPlayed = true,
							SkipCooldownCheckIfNonePlayed = true,

							{ Cue = "/VO/Chronos_1410", Text = "She cannot possibly be there..." },
							-- { Cue = "/VO/Chronos_1411", Text = "Off limits..." },
							-- { Cue = "/VO/Chronos_1412", Text = "Already searched there..." },
						},
					},
				},
			},
			[816416] =
			{
				Name = "FlashbackBroker",
				DistanceTrigger =
				{
					PreTriggerWait = 0.1,
					WithinDistance = 500,
					VoiceLines =
					{
						Queue = "Never",
						{
							PlayOnce = true,
							PlayOnceContext = "ChronosFlashbackVO",
							UsePlayerSource = true,
							BreakIfPlayed = true,
							SkipCooldownCheckIfNonePlayed = true,

							{ Cue = "/VO/Chronos_1416", Text = "Broker.",
								PostLineFunctionName = "WretchedBrokerReaction" },
						},
						{
							PreLineWait = 0.5,
							ObjectType = "NPC_Melinoe_Story_01",
							Speaker = "PlayerUnit",
							SkipAnim = true,

							{ Cue = "/VO/MelinoeField_5052", Text = "{#Emph}<Laugh>" },
						},
					},
				},
			},

			-- exit to I_DeathAreaRestored
			[420896] =
			{
				Name = "I_PostBossExit",
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

				InteractDistance = 350,
				InteractOffsetX = 45,
				InteractOffsetY = 135,
				AutoActivate = true,
			},
		},

	},

	I_DeathAreaRestored =
	{
		InheritFrom = { "BaseI" },
		RichPresence = "#RichPresence_Misc",
		LegalEncounters = { "Story_DeathAreaRestored" },

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

		EntranceFunctionName = "DeathAreaRestoredEntrance",

		BlockCombat = true,
		UnloadWeapons = true,
		BlockFamiliars = true,

		RequiresLinked = true,
		SkipLoadNextMap = true,

		--[[
		CameraZoomWeights =
		{
			[40001] = 1.0,
			[210380] = 1.2,
			[50002] = 1.3,
			[555424] = 1.0,
		},
		]]--
		SoftClamp = 0.75,
		-- chronos
		CameraClamps = { 772613, 772364, 772363, 772629, 772204, 772561, 772607, },
		-- restored
		RestoredCameraClamps = { 555717, 422050, 422049, 422048, 422047, 422046, 422045, 422043, 40009, 555718, },

		ReverbValue = 1.5,
		GlobalEcho = 0,

		GameStateRequirements =
		{
			-- None
		},

		IgnoreMusic = true,
		BlockRunProgressUI = true,
		EntranceDirection = "Left",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SecretSpawnChance = 0.0,

		CerberusPetTargetId = 774474,

		StartUnthreadedEvents =
		{
			{ FunctionName = "HideGameplayTimers" },
		},

		ObstacleData =
		{
			[774464] =
			{
				InteractDistance = 250,
				UseText = "UseFamilyRescue",
				OnUsedFunctionName = "FamilyRescuePresentation",
				OnUsedFunctionArgs =
				{
					PanId = 774464,
					VoiceLines =
					{
						{ Cue = "/VO/MelinoeField_3577", Text = "{#Emph}Queen Persephone! Prince Zagreus! Return to us!" },
					},
					TextLineSet =
					{
						TrueEnding02 =
						{
							SkipContextArt = true,
							{ Cue = "/VO/Persephone_0132",
								Emote = "PortraitEmoteSurprise",
								Source = "NPC_Persephone_01",
								Portrait = "Portrait_Persephone_Queen_Joyful_01",
								PortraitExitAnimation = "Portrait_Persephone_Queen_Joyful_01_Exit",
								Text = "Melinoë...! You're... you're all grown up? But then... of course you are. I... {#Emph}oh{#Prev}, my heart..." },

							{ Cue = "/VO/Zagreus_0478",
								PreLineWait = 0.35,
								Source = "NPC_Zagreus_01",
								Portrait = "Portrait_ZagPresent_Pained_01",
								Text = "{#Emph}Hah... hahah{#Prev}, Melinoë, it's really you...! You look just like your nightmare reflection did... so long ago, before the little you was even born. Did we succeed...? {#Emph}Augh{#Prev}, I'm shaking..." },

							{ Cue = "/VO/Chronos_1470",
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								PreLineWait = 0.35,
								SecretMusic = "/Music/MusicHadesReset2_MC",
								SecretMusicSection = 0,
								SecretMusicActiveStems = { "Guitar", },
								SecretMusicMutedStems = { "Drums", "Bass" },

								Text = "They shall recover, give them time... and give me {#Emph}death! {#Prev}Go on and send me to the blasted void, already! {#Emph}You{#Prev}, Son, or that witch, or {#Emph}you{#Prev}, Granddaughter, one of you! For I am {#Emph}weary {#Prev}of it all! You long for a world without me — it is {#Emph}yours!" },

							{ Cue = "/VO/Zagreus_0479",
								Source = "NPC_Zagreus_01",
								Portrait = "Portrait_ZagPresent_Unwell_01",
								PreLineAnim = "Zagreus_KnockedDown_End", PreLineAnimTarget = 774442,
								Text = "Grandfather, no...! How could you say that after all we've been through together? I swore you'd be under my protection, and... oh, gods... what happened to this place?" },

							{ Cue = "/VO/Chronos_1471",
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								ExitPortraitImmediately = true,
								PreLineAnim = "Enemy_Chronos_Knockdown_Frustrated", PreLineAnimTarget = 774365,

								-- SecretMusicActiveStems = { "Drums" },

								Text = "I {#Emph}took {#Prev}this place, is what, Zagreus. And {#Emph}ruined {#Prev}it! You need not advocate for me again. You never knew my real self. Merely a... {#Emph}possibility{#Prev}, and nothing more. And you, Melinoë... to think I... put you through all this. Take your vengeance." },

							{ Cue = "/VO/MelinoeField_5190",
								UsePlayerSource = true,
								PreLineWait = 0.65,
								-- Emote = "PortraitEmoteFiredUp",
								Portrait = "Portrait_Mel_Intense_01",
								PreLineAnim = "Melinoe_Assist_End", PreLineAnimTarget = "Hero",
								SecretMusic = "/Music/MusicPlayer/PersephoneThemeMusicPlayer",

								Text = "...No. Our family's had enough for now. Who else recalls what happened? Memories, as vivid as any you hold dear, but of a separate life we might have lived...! Mother, do you remember?" },

							{ Cue = "/VO/Persephone_0133",
								Source = "NPC_Persephone_01",
								Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
								PortraitExitAnimation = "Portrait_Persephone_Queen_Apprehensive_01_Exit",
								PreLineAnim = "Persephone_Sitting_End", PreLineAnimTarget = 774443,
								Text = "I... I do. You were... insatiably curious as a child, and... sometimes too much even for me to handle, so... Zagreus, and Chronos, they... often helped take care of you." },

							{ Cue = "/VO/Hades_0405",
								Portrait = "Portrait_Hades_Chained_02",
								Source = "NPC_Hades_Story_01",
								PreLineWait = 0.5,
								Text = "...I, too, remember now. That Father was with us, after Zagreus discovered him and took him in. Yet all the while... I have been a prisoner. {#Emph}His {#Prev}prisoner, {#Emph}here {#Prev}in this time of ours..." },

							{ Cue = "/VO/HecateField_0431",
								Source = "NPC_Hecate_01",

								SecretMusic = "/Music/RemembranceScreenAmbience2",

								PreLineAnim = "Hecate_Hub_Affirm",
								PreLineAnimTarget = 774366, -- Hecate

								Text = "Queen Persephone, Lord Hades, do {#Emph}not {#Prev}believe these {#Emph}falsehoods {#Prev}coursing through your minds! Even your son and daughter seem susceptible. You {#Emph}all {#Prev}have been manipulated by the Titan's spell!" },

							{ Cue = "/VO/MelinoeField_5151",
								UsePlayerSource = true,
								PreLineWait = 0.5,
								Portrait = "Portrait_Mel_Intense_01",
								AngleId = 560366,
								AngleTowardTargetId = 774366,
								PreLineAnim = "Melinoe_Defiant", PreLineAnimTarget = "Hero",
								PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 6.2 },

								Text = "Headmistress, that's not true! Don't you understand? The Dissolution of Time... this is how I manifested it. You always said the task was mine, as were the methods I employed. This was the path I chose." },

							{ Cue = "/VO/HecateField_0432",
								Source = "NPC_Hecate_01",
								Emote = "PortraitEmoteAnger",

								SecretMusic = "/Music/MusicHadesReset3_MC",
								SecretMusicSection = 0,
								SecretMusicActiveStems = { "Guitar", "Drums" },
								SecretMusicMutedStems = { "Bass" },

								PreLineAnim = "Hecate_Hub_Stern_Start",
								PreLineAnimTarget = 774366, -- Hecate
								PostLineAnim = "Hecate_Hub_Stern_End",
								PostLineAnimTarget = 774366, -- Hecate

								Text = "Then you failed! {#Emph}Death to Chronos {#Prev}was the task, yet {#Emph}there {#Prev}he is! Melinoë... what could possibly have compelled you to take such a course?" },

							{ Cue = "/VO/MelinoeField_5152",
								UsePlayerSource = true,
								Emote = "PortraitEmoteFiredUp",
								Portrait = "Portrait_Mel_Vulnerable_01",
								ExitPortraitImmediately = true,
								PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

								SecretMusicMutedStems = { "Drums" },

								Text = "Your own teachings! To think for myself, not just... do as I'm told! But if you still believe destroying Chronos will make our problems go away... then what are you waiting for?" },

							{ Cue = "/VO/HecateField_0433",
								Source = "NPC_Hecate_01",
								PreLineWait = 1.0,
								PreLineAnim = "Hecate_Hub_Scoff",
								PreLineAnimTarget = 774366, -- Hecate
								ExitPortraitImmediately = true,

								EndSecretMusic = true,

								Text = "...I shall never forgive this Titan for what he has done... to this world, your family, you, or me." },

							{ Cue = "/VO/Persephone_0134",
								Source = "NPC_Persephone_01",
								PreLineWait = 0.85,
								Portrait = "Portrait_Persephone_Queen_Apprehensive_01",
								ExitPortraitImmediately = true,
								PreLineAnim = "Persephone_DismissQuick_Start",
								PreLineAnimTarget = 774443,
								SecretMusic = "/Music/MusicPlayer/Iris/EndThemeACOUSTICMusicPlayer",

								Text = "Dear Hecate... my handmaiden. Who said anything about forgiveness? I've never heard such pain in you. Last I recall, in this life... just before Chronos struck, your task was to protect our daughter at all costs... and you did...! You did!" },

							{ Cue = "/VO/Hades_0406",
								Portrait = "Portrait_Hades_Chained_02",
								ExitPortraitImmediately = true,
								Source = "NPC_Hades_Story_01",
								PreLineWait = 0.35,

								Text = "...In our moment of peril, you were the only one we could count on, esteemed Witch of the Crossroads. For that and more, you have our gratitude. For all eternity." },
								
							{ Cue = "/VO/HecateField_0434",
								Portrait = "Portrait_Hec_Averted_01",
								Source = "NPC_Hecate_01",
								PreLineAnim = "HecateHubGreet",
								PreLineAnimTarget = 774366, -- Hecate

								ExitPortraitImmediately = true,
								PostLineFunctionName = "HadesOfficialDecree",

								PreLineWait = 0.85,

								Text = "...I did no more than was my charge, O King and Queen. And I remain, as ever, at your service.... Well then, Melinoë... what now...?" },

							{ Cue = "/VO/MelinoeField_5153",
								UsePlayerSource = true,
								AngleId = 560366,
								AngleTowardTargetId = 774443,
								PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

								PreLineWait = 0.85,

								Text = "What now...? There is so much to be done... bringing this House to order, for one thing! Mother... Father... you've seen what was possible. Let us give Chronos one chance to make himself useful, starting with our restoration efforts. Would you grant me that?" },

							{ Cue = "/VO/Persephone_0135",
								Source = "NPC_Persephone_01",
								Portrait = "Portrait_Persephone_Queen_01",
								PreLineAnim = "Persephone_Greet_Full",
								PreLineAnimTarget = 774443,
								PreLineWait = 0.5,
								Text = "...Granted! We're not finished with you, Chronos. They say Time heals all wounds. Prove it." },

							{ Cue = "/VO/Hades_0407",
								Portrait = "Portrait_Hades_Chained_01",
								Source = "NPC_Hades_Story_01",
								PreLineWait = 0.5,
								Text = "...Granted. But only this one chance. By the grace of the Princess of the Underworld." },

							{ Cue = "/VO/Chronos_1472",
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								-- PostLineRemoveContextArt = true,
								ExitPortraitImmediately = true,
								PreLineWait = 0.8,
								Text = "...You would... permit me such a chance? But I cannot change what already occurred... cannot undo the unforgivable decisions I have made." },

							{ Cue = "/VO/MelinoeField_5154",
								UsePlayerSource = true,
								Portrait = "Portrait_Mel_Default_01",
								AngleId = 560366,
								AngleTowardTargetId = 774365,
								PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",

								Text = "You're Time itself. We're not demanding you move backward. We're demanding you move forward." },

							{ Cue = "/VO/Chronos_1527",
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								-- PostLineRemoveContextArt = true,
								ExitPortraitImmediately = true,
								PreLineWait = 0.8,
								Text = "To move forward... that is all I have ever known. Then I shall make time... both for this House... and everything." },

							EndFunctionName = "DeathAreaRestorationPresentation",
							EndFunctionArgs =
							{
								Conversations =
								{
									"ZagreusTrueEnding01",
									"CerberusTrueEnding01",
									"PersephoneTrueEnding01",
									"AchillesTrueEnding01",
									"HadesTrueEnding01",
									"SeleneTrueEnding01",
								},
							},
						},
					},
				},
			},

			-- Procrastination Point 1
			[772631] =
			{
				Name = "ProcrastinationPoint01",
				DistanceTriggers =
				{
					{
						Repeat = true,
						WithinDistance = 300,
						VoiceLines =
						{
							PlayOnce = true,
							PlayOnceContext = "TrueEndingMiscVO",
							ObjectType = "NPC_Hades_Story_01",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "TrueEnding01" },
								},
							},
							{ Cue = "/VO/Hades_0404", Text = "Daughter, please..." },
						},
					},
				},
			},
			-- Procrastination Point 2
			[560377] =
			{
				Name = "ProcrastinationPoint02",
				DistanceTriggers =
				{
					{
						Repeat = true,
						WithinDistance = 750,
						VoiceLines =
						{
							PlayOnce = true,
							PlayOnceContext = "TrueEndingMiscVO",
							ObjectType = "NPC_Hecate_Story_01",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "TrueEnding01" },
								},
							},
							{ Cue = "/VO/HecateField_0429", Text = "What are you waiting for...?" },
						},
					},
				},
			},
			-- Procrastination Point 3
			[772593] =
			{
				Name = "ProcrastinationPoint03",
				DistanceTriggers =
				{
					{
						Repeat = true,
						WithinDistance = 250,
						VoiceLines =
						{
							PlayOnce = true,
							PlayOnceContext = "TrueEndingMiscVO",
							ObjectType = "NPC_Hecate_Story_01",
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "TrueEnding01" },
								},
							},
							{ Cue = "/VO/HecateField_0430", Text = "Melinoë...!" },
						},
					},
				},
			},

		},

		EnterVoiceLines =
		{
			Queue = "Interrupt",
			{
				{
					ObjectTypes = { "NPC_Hecate_Story_01" },

					{ Cue = "/VO/HecateField_0322", Text = "{#Emph}Nrgh?! {#Prev}Titan...!" },
				},
				{
					UsePlayerSource = true,
					PreLineWait = 0.2,

					{ Cue = "/VO/MelinoeField_3569", Text = "...What?!" }
				},
				{
					ObjectTypes = { "NPC_Chronos_01", "NPC_Chronos_Story_01" },
					PreLineWait = 0.7,

					{ Cue = "/VO/Chronos_1463", Text = "{#Emph}<Gasp> {#Prev}Wha... I..." },
				},
			},
		},
	},

	EndCredits01 =
	{
		LegalEncounters = { "Story_EndCredits" },
		Ambience = "/Leftovers/Ambience/WhippingWindLoopEnding",

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

		BlockCombat = true,
		BlockFamiliars = true,

		-- ExitFunctionName = "EndEarlyAccessPresentation",
		RequiresLinked = true,
		SkipLoadNextMap = true,

		RichPresence = "#RichPresence_Misc",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		BlockCameraReattach = true,
		EntranceFunctionName = "RoomEntranceEndCredits",
		EntranceFunctionArgs =
		{
			ChariotId = 780625,
			CameraLockId = 780636,
		},

		EntranceDirection = "Left",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.85,

		BlockHeroLight = true,

		ReverbValue = 0.5,
		GlobalEcho = 0.6,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SecretSpawnChance = 0.0,

		StartUnthreadedEvents =
		{
			{ FunctionName = "HideGameplayTimers" },
			{
				FunctionName = "HandleEndingCreditsWrapping",
				Args =
				{
					-- far background
					{
						Ids = { 723524, 780629, 780661, 780662, },
						ResetOffsetDistance = -1800,
						MoveDistance = 2640,
						MoveSpeed = 2640 / 30.0,
						AltMoveSpeed = 2640 / 15.0,
					},
					-- near background
					{
						Ids = { 723523, 780628, 780664, 780665, },
						ResetOffsetDistance = -1800,
						MoveDistance = 2640,
						MoveSpeed = 2640 / 24.0,
						AltMoveSpeed = 2640 / 12.0,
					},
					-- far foreground
					{
						Ids = { 723522, 780630, 780663, 780668 },
						ResetOffsetDistance = -1800,
						MoveDistance = 2640,
						MoveSpeed = 2640 / 16.0,
						AltMoveSpeed = 2640 / 8.0,
					},
					-- near foreground
					{
						Ids = { 780624, 780631, },
						ResetOffsetDistance = -1800,
						MoveDistance = 2640,
						MoveSpeed = 2640 / 12.0,
						AltMoveSpeed = 2640 / 6.0,
					},
				},
			},
		},

		EnterVoiceLines =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "SkipCreditsPreamble" },
				},
			},

			{
				--PreLineWait = 2.65, -- using the wait in RoomEntranceEndCredits instead
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_3904", Text = "You get to fly like this each night...?" },
			},
			{
				PreLineWait = 0.4,
				-- ObjectType = "NPC_Selene_01",
				Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },

				{ Cue = "/VO/Selene_0234", Text = "{#Emph}Hmm." },
			},
			{
				PreLineWait = 2.65,
				UsePlayerSource = true,

				-- { Cue = "/VO/MelinoeField_3905", Text = "Is that Olympus over there...?" },
			},
		},
	},

}
AddTableKeysCheckDupes( RoomData, RoomSetData.I )