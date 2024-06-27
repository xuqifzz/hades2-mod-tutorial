RoomSetData.I =
{
	BaseI =
	{
		DebugOnly = true,
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Tartarus",
		ResultText = "RunHistoryScreenResult_ClockworkTartarus",
		
		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,

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
				IsNone = { "F_PreBoss01", "F_Boss01", "F_Boss02", "F_Boss03", "G_PreBoss01", "G_Boss01", "H_PreBoss01", "H_Boss01", "I_PreBoss01", "I_Boss01", "N_PreBoss01", "N_Boss01", "P_PreBoss01", "P_Boss01" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsNone = { "I", "O", "Q" },
			},
			NamedRequirements = { "ChaosUnlocked", "NoRecentChaosEncounter" },
		},

		TimeChallengeEncounterOptions = { "TimeChallengeI" },

		-- LocationText = "BiomeI",
		SaveProfileLocationText = "Location_BiomeI",

		ZoomFraction = 0.85,

		WellShopSpawnChance = 0.08,

		DoorEntranceAnimation = { DoorType = "CWTartarusEntryDoor", CloseAnimation = "CWTartarusExitDoorClose", OpenedAnimation = "CWTartarusExitDoorOpened", Delay = 0.5 },

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
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.5 }, Args = { StartingCountMin = 6, StartingCountMax = 12, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
			{ FunctionName = "ClockworkManager", Args = { Interval = 10.0 } },
		},

		ThreadedEvents =
		{
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "SessionState", "MapLoads" },
						Comparison = "<=",
						Value = 1,
					},
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
					{
						PathTrue = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "SessionState", "MapLoads" },
						Comparison = "<=",
						Value = 1,
					},
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

		HarvestPointChances =
		{
			0,
		},
		ShovelPointChance = 0,
		PickaxePointChance = 0,
		ExorcismPointChance = 0,

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
								VoiceLines = GlobalVoiceLines.ErisNotSightedVoiceLines,
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
				Args = { Text = "Location_BiomeI", Delay = 2.0, },
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
			},
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
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_I_Intro_02" },
					},
					RequiredUnitsNotAlive = { "NPC_Eris_01" },
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
						--
					},
					RequiredUnitsNotAlive = { "NPC_Eris_01" },
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
			[1] = GlobalVoiceLines.StartPackagedBountyRunVoiceLines,
			[2] = GlobalVoiceLines.BiomeStateChangeStartVoiceLines,
			[3] =
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
			},
		},

	},

	I_PreBoss01 =
	{
		InheritFrom = { "BaseI" },

		LinkedRoom = "I_Boss01",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RemainingClockworkGoals", },
				Comparison = "<=",
				Value = 0,
			}
		},
		MaxCreationsPerRoom = 1,

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

		SkipLastKillPresentation = true,

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

		FlipHorizontalChance = 0.0,

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
		-- EndMusicOnEnterDuration = 5.0,

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

		},

		EnterVoiceLines =
		{
			PreLineWait = 1.2,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
				},
				RequiredMinHealthFraction = 0.2,
			},

			{ Cue = "/VO/MelinoeField_1291", Text = "Down there...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1292", Text = "There it is..." },
			{ Cue = "/VO/MelinoeField_1293", Text = "The House..." },
			{ Cue = "/VO/MelinoeField_1294", Text = "Made it through..." },
			{ Cue = "/VO/MelinoeField_1295", Text = "I'm here..." },
			{ Cue = "/VO/MelinoeField_1296", Text = "This is it..." },
		},

		ExitVoiceLines =
		{
			PreLineWait = 0.5,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.5,
			GameStateRequirements =
			{
				{
				},
			},

			{ Cue = "/VO/MelinoeField_1299", Text = "One way in...!" },
			{ Cue = "/VO/MelinoeField_1300", Text = "{#Emph}<Inhale>", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1301", Text = "River, take me...!" },
			{ Cue = "/VO/MelinoeField_1302", Text = "Styx, take me...!" },
			{ Cue = "/VO/MelinoeField_1303", Text = "Quick dip..." },
			{ Cue = "/VO/MelinoeField_1304", Text = "Swimtime..." },
		},

	},

	I_Boss01 =
	{
		InheritFrom = { "BaseI" },

		RequiresLinked = true,
		ExitPreviewAnim = "ExitDownPreview",
		FlipHorizontal = false,
		
		LoadBackgroundColor = Color.ChronosSand,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossChronos01", },
		ForcedReward = "MixerIBossDrop",

		LinkedRoom = "I_PostBoss01",
		ExitFunctionName = "EndEarlyAccessPresentation",
		SkipLoadNextMap = true,

		EntranceFunctionName = "RoomEntranceChronos",
		EntranceFunctionArgs = { LandingTarget = 704921, AngleTowardsIdOnEnd = 609246 },
		BlockCameraReattach = true,
		ZoomFraction = 0.70,

		ToulaFishingTeleportId = 704921,
		IgnoreFishingCameraClamps = true,

		Ambience = "/Ambience/DemoEndAmbience",
		UnthreadedEvents =
		{
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
						Value = 0.1,
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" },
					},
				},
				Args =
				{
					AutoUnpause = true,
					VoiceLines =
					{
						-- Time Cannot Be Stopped
						Queue = "Interrupt",
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							SuccessiveChanceToPlay = 0.75,
							SuccessiveChanceToPlayAll = 0.33,

							{ Cue = "/VO/Chronos_0563_B", Text = "{#Emph}Hahaha! {#Prev}No. {#Emph}You {#Prev}do not control the flow of Time. Not {#Emph}here.", PlayFirst = true, PlayOnce = true },
							{ Cue = "/VO/Chronos_0564", Text = "{#Emph}Uh-uh-uhh!" },
							{ Cue = "/VO/Chronos_0565", Text = "Time cannot be stopped." },
							{ Cue = "/VO/Chronos_0566", Text = "We have a score to settle, do we not?" },
							{ Cue = "/VO/Chronos_0567", Text = "How very rude of you to even {#Emph}try!" },
							{ Cue = "/VO/Chronos_0568", Text = "Who, exactly, do you think you {#Emph}are?" },
							{ Cue = "/VO/Chronos_0569", Text = "Time does not stop for {#Emph}you." },
							{ Cue = "/VO/Chronos_0570", Text = "Such antics you attempt with me!" },
							{ Cue = "/VO/Chronos_0571", Text = "I said {#Emph}no. {#Prev}We {#Emph}fight!" },
							{ Cue = "/VO/Chronos_0572", Text = "Cease this and {#Emph}fight!" },
							{ Cue = "/VO/Chronos_0573", Text = "Your power is formidable, but no." },
							{ Cue = "/VO/Chronos_0574", Text = "We now resume the battle already in progress." },
							{ Cue = "/VO/Chronos_0575", Text = "You only prolong your demise." },
							{ Cue = "/VO/Chronos_0576", Text = "Are you {#Emph}enjoying {#Prev}this?" },
							{ Cue = "/VO/Chronos_0577",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "LastLinePlayed" },
										IsAny = { "/VO/Chronos_0576" },
									},
								},
							 	Text = "{#Emph}I {#Prev}am enjoying this." },
							{ Cue = "/VO/Chronos_0562", Text = "{#Emph}Hahaha! {#Prev}No.",
								GameStateRequirements =
								{
									{
										PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Chronos_0562_B" },
									},
									{
										PathFalse = { "PrevRun", "SpeechRecord", "/VO/Chronos_0562_B" },
									},
									{
										Path = { "GameState", "SpeechRecord" },
										HasAll = {
											"/VO/Chronos_0572",
											"/VO/Chronos_0573",
											"/VO/Chronos_0573",
											"/VO/Chronos_0574",
											"/VO/Chronos_0575",
										},
									},
								},
							},
							{ Cue = "/VO/Chronos_0563", Text = "{#Emph}You {#Prev}do not control the flow of Time. Not {#Emph}here.",
								GameStateRequirements =
								{
									{
										PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Chronos_0562_B" },
									},
									{
										PathFalse = { "PrevRun", "SpeechRecord", "/VO/Chronos_0562_B" },
									},
									{
										Path = { "GameState", "SpeechRecord" },
										HasAll = {
											"/VO/Chronos_0572",
											"/VO/Chronos_0573",
											"/VO/Chronos_0573",
											"/VO/Chronos_0574",
											"/VO/Chronos_0575",
										},
									},
								},
							},
						},
						{
							BreakIfPlayed = true,
							RandomRemaining = true,

							{ Cue = "/VO/Chronos_0578", Text = "No.", PlayFirst = true },
							{ Cue = "/VO/Chronos_0579", Text = "{#Emph}No!", PlayFirst = true },
							{ Cue = "/VO/Chronos_0580", Text = "No...", PlayFirst = true },
							{ Cue = "/VO/Chronos_0581", Text = "{#Emph}No...!", PlayFirst = true },
							{ Cue = "/VO/Chronos_0582", Text = "{#Emph}Mm... {#Prev}no.", PlayFirst = true },
							{ Cue = "/VO/Chronos_0583", Text = "How about {#Emph}no." },
							{ Cue = "/VO/Chronos_0584", Text = "Absolutely not." },
							{ Cue = "/VO/Chronos_0585", Text = "{#Emph}Hellooo?" },
						},
					},
				},
			},
			{
				FunctionName = "SetupPauseMenuTakeover",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">",
						Value = 0.1,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePauseChronosFight" },
					},
				},
				Args =
				{
					AutoUnpause = false,
					Cooldown = 3.0,
					VoiceLines =
					{
						Queue = "Interrupt",
						{
							RandomRemaining = true,
							SuccessiveChanceToPlay = 0.66,
							GameStateRequirements =
							{
								-- None
							},

							{ Cue = "/VO/Chronos_0594_B", Text = "Again, with this foolishness...? Wait, what? Stuck! {#Emph}How?! {#Prev}Impossible...", PlayFirst = true, PlayOnce = true },
							{ Cue = "/VO/Chronos_0597", Text = "{#Emph}Rnngghh..." },
							{ Cue = "/VO/Chronos_0598", Text = "{#Emph}How...?", PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0594_B" },
									},
								}
							},
							{ Cue = "/VO/Chronos_0599", Text = "Such power...", PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0594_B" },
									},
								}
							},
							{ Cue = "/VO/Chronos_0600", Text = "If it must be...", PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_0594_B" },
									},
								}
							},
							{ Cue = "/VO/Chronos_0586", Text = "Oh, {#Emph}fine. {#Prev}I shall allow it, I suppose..." },
							{ Cue = "/VO/Chronos_0587", Text = "{#Emph}Rngh{#Prev}, oh very well." },
							{ Cue = "/VO/Chronos_0588", Text = "I shall abide what doubtless is a necessary bathroom break." },
							{ Cue = "/VO/Chronos_0589", Text = "You know what? Have it your way! {#Emph}Fine." },
							{ Cue = "/VO/Chronos_0590", Text = "{#Emph}Eugh..." },
							{ Cue = "/VO/Chronos_0591", Text = "Then let us wait..." },
							{ Cue = "/VO/Chronos_0592", Text = "{#Emph}Again...?" },
							{ Cue = "/VO/Chronos_0593", Text = "Fine..." },
						},
					},
				},
			},
		},

		PostCombatReloadEvents =
		{
			{
				FunctionName = "ChronosPostCombatReload"
			}
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
						--
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
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
					NamedRequirements = { "NoRecentInspectPointUsed" },
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

		},

		EnterVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.25,

				{ Cue = "/VO/MelinoeField_1305", Text = "{#Emph}<Gasp> {#Prev}Pff..." },
				{ Cue = "/VO/MelinoeField_1306", Text = "{#Emph}<Gasp> {#Prev}...I'm home..." },
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
				{ Cue = "/VO/MelinoeField_1308", Text = "{#Emph}<Cough> {#Prev}Chronos...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1309", Text = "{#Emph}<Cough>" },
				{ Cue = "/VO/MelinoeField_1310", Text = "{#Emph}<Cough>" },
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
				{ Cue = "/VO/Chronos_0196", Text = "Time again, is it?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Boss01" },
							Comparison = ">=",
							Value = 4,
						}
					}

				},
				{ Cue = "/VO/Chronos_0203", Text = "A visitor, at this hour?",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Boss01" },
							Comparison = ">=",
							Value = 9,
						}
					}
				},
				{ Cue = "/VO/Chronos_0206", Text = "We meet again, my girl.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "I_Boss01" },
							Comparison = ">=",
							Value = 9,
						}
					}
				},
			}
		},

	},

	I_PostBoss01 =
	{
		InheritFrom = { "BaseF" },
		LegalEncounters = { "Empty" },

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

		ExitFunctionName = "EndEarlyAccessPresentation",
		SkipLoadNextMap = true,

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		ExitPreviewAnim = "ExitDownPreview",
		RichPresence = "#RichPresence_PostBoss",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,

		SkipLastKillPresentation = true,
		TimeChallengeSwitchSpawnChance = 0.0,
		WellShopSpawnChance = 0.0,
		SecretSpawnChance = 0.0,
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
			RequiredMinExits = 2,
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
				Path = { "MapState", "OfferedExitDoors" },
				UseLength = true,
				Comparison = ">",
				Value = 1,
			},
		},

		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,
		ExorcismPointChance = 0.4,

		InspectPoints =
		{
			[515864] =
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
					Inspect_I_Shop_01 =
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
		SpawnRewardOnId = 561339,
		DisableRewardMagnetisim = true,
		IntroSequenceDuration = 0.02,

		SpawnRewardOnId = 410000,

		HarvestPointChances =
		{
			0.8,
			0.4,
			0.1,
		},

		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,
		ExorcismPointChance = 0,

		HarvestPointRequirements = { },
		ShovelPointRequirements = { },
		PickaxePointRequirements = { },
		ExorcismPointRequirements = { },

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
			RequiredMinCompletedRuns = 0,
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
				Path = { "MapState", "OfferedExitDoors" },
				UseLength = true,
				Comparison = ">",
				Value = 1,
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
			[1] = GlobalVoiceLines.CombatResolvedVoiceLines,
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
		DebugOnly = true,
		HasFishingPoint = false,

		EntranceDirection = "Right",

		ZoomFraction = 0.85,
		ZoomFractionSwitch = 0.9,
		RushMaxRangeOverride = 525,
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

	-- I_Combat15

	I_Combat16 =
	{
		InheritFrom = { "BaseI", "I_BaseCombat" },
		DebugOnly = true,
		
		HasFishingPoint = false,

		EntranceDirection = "Left",
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
		DebugOnly = true,

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

	I_MiniBoss01 =
	{
		InheritFrom = { "BaseI", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		HasFishingPoint = false,
		
		SecretSpawnChance = 0.0,
		SuppressRewardSpawnSounds = false,
		ReverbValue = 1.0,

		ZoomFraction = 0.775,

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "I_MiniBoss02" },
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
				Path = { "MapState", "OfferedExitDoors" },
				UseLength = true,
				Comparison = ">",
				Value = 1,
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
			[1] = GlobalVoiceLines.MiniBossEncounterEndVoiceLines,
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
			RequiredFalseSeenRoomsThisRun = { "I_MiniBoss01" },
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
				Path = { "MapState", "OfferedExitDoors" },
				UseLength = true,
				Comparison = ">",
				Value = 1,
			},
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
							Text = "{#Emph}Pure, glimmering gold; a metal shunned by the true King of the Underworld not just for its softness, but because it was favored by his Titan father; a stark reminder of a bygone age." },
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
			[1] = GlobalVoiceLines.MiniBossEncounterEndVoiceLines,
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

	-- NPC room layout 1
	I_Story01 =
	{
		InheritFrom = { "BaseI" },
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		RichPresence = "#RichPresence_IStory01",
		HarvestBlockedText = "ExitBlockedByNPC",
		AllowExorcismPreExitsUnlock = true,

		HasFishingPoint = false,

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
				Path = { "MapState", "OfferedExitDoors" },
				UseLength = true,
				Comparison = ">",
				Value = 1,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty", },
			},
		},

		SecretMusic = "/Music/EndThemeAcoustic",
		ZoomFraction = 0.85,
		TimerBlock = "StoryRoom",

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Hades_01" },
		EntranceDirection = "LeftRight",

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 700,

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
				PlayOnce = true,
				PlayOnceContext = "IStoryEnterVoiceLines",
				RandomRemaining = true,
				PreLineWait = 1.5,

				{ Cue = "/VO/Melinoe_1159", Text = "It can't be... Cerberus...!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1160", Text = "Cerberus!" },
				{ Cue = "/VO/Melinoe_0810", Text = "What...?" },
			},
		},

		ExitVoiceLines =
		{
			UsePlayerSource = true,
			PreLineWait = 0.25,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.75,
			GameStateRequirements =
			{
				{
				},
			},

			{ Cue = "/VO/MelinoeField_1525", Text = "Thank you, Father." },
			{ Cue = "/VO/MelinoeField_1526", Text = "It won't be for naught." },
			{ Cue = "/VO/MelinoeField_1527", Text = "Hold on, Father..." },
			{ Cue = "/VO/MelinoeField_1528", Text = "Cerberus, take care of him, OK...?",
				GameStateRequirements =
				{
					AreIdsAlive = { 506405 },
				},
			},
			{ Cue = "/VO/MelinoeField_1529", Text = "You honor me." },
			{ Cue = "/VO/MelinoeField_1530", Text = "I shall return..." },
			{ Cue = "/VO/MelinoeField_1531", Text = "You'll be avenged.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1532", Text = "For our family." },
		},

		StartThreadedEvents =
		{
			-- { FunctionName = "ClockworkManager", Args = { Interval = 5.0 } },
		},
		ThreadedEvents =
		{
		},
	},

}
AddTableKeysCheckDupes( RoomData, RoomSetData.I )