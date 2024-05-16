RoomSetData.G =
{
	BaseG =
	{
		DebugOnly = true,
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Oceanus",
		ResultText = "RunHistoryScreenResult_Oceanus",
		
		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,
		HarvestPointBase = "DrownedChambersHarvestPointBase01",

		BreakableValueOptions = { MaxHighValueBreakables = 3 },
		TimeChallengeEncounterOptions = { "TimeChallengeG" },

		LegalEncounters = EncounterSets.GEncountersDefault,
		DevotionEncounters = {"DevotionTestG"},
		TargetMetaRewardsRatio = 0.40,

		SecretSpawnChance = 0.12,
		WellShopSpawnChance = 0.30,

		Ambience = "/Leftovers/Ambience/MatchSiteIPoolAmbience",
		ReverbValue = 1.8,
		StopSecretMusic = true,
		RandomStemMixerBass = 0,
		DefaultMusicParams = { "Vocals", "Guitar", "Drums", },
		-- ShopSecretMusic = "/Music/CharonShopTheme",

		LocationText = "Location_BiomeG",
		SaveProfileLocationText = "Location_BiomeG",

		EntranceFunctionName = "EnterBiomeGRoomPresentation",
		NextRoomEntranceFunctionName = "EnterBiomeGRoomPresentation",
		EntranceAnimation = "MelinoeIdle",

		HeroCreateAnimation = "WaterIdleFootRippleR-Spawner",
		FootstepAnimationR = "WaterSplashFootstepR-Spawner",
		FootstepAnimationL = "WaterSplashFootstepL-Spawner",

		SwapAnimations =
		{
			["DashDustPuff"] = "DashWake",
			["DashCrack"] = "FloodTrapFxTrailWake",
			["AxeGroundCrack"] = "AxeGroundCrackWithSplash",
			["LobProjectileBounceFx"] = "LobBounceFxOceanus",
			["LobProjectileBounceFx_Apollo"] = "LobBounceFxOceanus",
			["LobProjectileBounceFx_Demeter"] = "LobBounceFxOceanus",
			["LobProjectileBounceFx_Hestia"] = "LobBounceFxOceanus",
			["LobProjectileBounceFx_Hera"] = "LobBounceFxOceanus",
			["SpellMeteorCrater"] = "SpellMeteorCraterOceanus",
		},

		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/Leftovers/SFX/FootstepsWetSmall",
			["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsWetMedium",
		},

		StartThreadedEvents =
		{
			--{ FunctionName = "FloodManager", GameStateRequirements = { ChanceToPlay = 0.5, }, Args = { Types = { "FloodTrap" }, IntervalMin = 12.0, IntervalMax = 25.0, FirstIntervalMin = 6.0, FirstIntervalMax = 12.0 } },
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.5 }, Args = { StartingCountMin = 0, StartingCountMax = 12, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
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

		HazardData =
		{
			SpawnPointGroupName = "Hazards",
			ObstacleName = "LavaSplash",
			SpawnRate = 10,
			SpawnStagger = 0.1,
			SpawnsPerBurstMin = 4,
			SpawnsPerBurstMax = 5,
		},

		ZoomFraction = 0.8,
		MaxAppearancesThisBiome = 1,
	},

	G_PreBoss01 =
	{
		InheritFrom = { "BaseG" },

		ForceAtBiomeDepthMin = 8,
		ForceAtBiomeDepthMax = 8,
		LinkedRoom = "G_Boss01",

		RushMaxRangeOverride = 475,

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

		SpawnRewardOnId = 561335,

		DisableRewardMagnetisim = true,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		FlipHorizontalChance = 1.0,

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.5 }, Args = { StartingCountMin = 16, StartingCountMax = 22, ObjectNames = { "ShadeMerc" }, MaxActive = 22 } },
		},

		ObstacleData =
		{
			-- Concert Queue
			[617546] =
			{
				Name = "ConcertBouncer",
				EmoteOffsetZ = 10,
				DistanceTriggers =
				{
					{
						WithinDistance = 450,
						Emote = "StatusIconDisgruntled",
						TriggerOnceThisRun = true,
					},
					{
						WithinDistance = 400,
						TriggerOnceThisRun = true,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							SuccessiveChanceToPlayAll = 0.25,

							{ Cue = "/VO/MelinoeField_0257", Text = "What's everybody queuing for...?", PlayFirst = true },
							{ Cue = "/VO/MelinoeField_0258", Text = "Here for the show?" },
							{ Cue = "/VO/MelinoeField_0259", Text = "Show's about to start..." },
							{ Cue = "/VO/MelinoeField_0260", Text = "I have a season pass." },
							{ Cue = "/VO/MelinoeField_0261", Text = "I have a backstage pass." },
						}
					},
				}
			}
		},

		InspectPoints =
		{
			[560583] =
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
					Inspect_G_PreBoss_01 =
					{
						{ Cue = "/VO/Storyteller_0020",
							Text = "{#Emph}An ever-present song compels the nightmare-bringing Princess ever forward, towards the beauty, deeper into the abyss." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_0855", Text = "It's very pretty..." },
						},
					},
				},
			},
		},

		ExitVoiceLines =
		{
			PreLineWait = 0.5,
			RandomRemaining = true,
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
				},
			},

			{ Cue = "/VO/MelinoeField_0977", Text = "Almost out of here...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0978", Text = "Showtime..." },
			{ Cue = "/VO/MelinoeField_0979", Text = "To the stage..." },
			{ Cue = "/VO/MelinoeField_0980", Text = "On with the show..." },
			{ Cue = "/VO/MelinoeField_0981", Text = "All right, Scylla..." },
			{ Cue = "/VO/MelinoeField_0982", Text = "The old song-and-dance...",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "G_Boss01" },
						Comparison = ">=",
						Value = 5,
					},
				},
			},
		},

		-- so that guitars don't cut out & create silence at start of G_Boss01
		IgnoreStemMixer = true,
		MusicActiveStems = { "Guitar" },
	},

	G_Boss01 =
	{
		InheritFrom = { "BaseG" },

		ValidateSecretData = false,
		RequiresLinked = true,
		LinkedRoom = "G_PostBoss01",
		ExitPreviewAnim = "ExitDownPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",
		-- IgnoreMusic = true,
		MusicActiveStems = { "Drums" },
		-- Vocals handled in Scylla's EndTextLinesThreadedFunctionName
		DefaultMusicParams = { "Guitar", "Drums", },
		Ambience = "/Ambience/ScyllaFightAmbience",

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossScylla01", },
		ForcedReward = "MixerGBossDrop",
		NoReroll = true,

		EntranceFunctionName = "RoomEntranceBossBiomeG",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 557843 },
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,
		ZoomFraction = 0.68,
		FlipHorizontalChance = 0.0,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 557843 },
					SetupBossIds = { 569244, 557843, 558409, },
					SkipAngleTowardTarget = true,
					-- Vocals handled in Scylla's EndTextLinesThreadedFunctionName
					SkipBossMusic = true,
					DelayedStart = true,
				},
			},
			--[[
			{
				FunctionName = "SingingPresentationScylla"
			}
			]]
		},	

		StartThreadedEvents =
		{
			--{ FunctionName = "FloodManager", GameStateRequirements = { ChanceToPlay = 0.0, }, Args = { Types = { "FloodTrap" }, IntervalMin = 7.0, IntervalMax = 15.0, FirstIntervalMin = 2.0, FirstIntervalMax = 3.0 } },
		},

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.75,
				ObjectType = "Scylla",

				{ Cue = "/VO/Scylla_0058", Text = "{#Emph}Oohh....", PlayFirst = true },
				{ Cue = "/VO/Scylla_0059", Text = "{#Emph}Hello..." },
				{ Cue = "/VO/Scylla_0060", Text = "{#Emph}Hello...!" },
				{ Cue = "/VO/Scylla_0061", Text = "She came...!" },
				{ Cue = "/VO/Scylla_0062", Text = "Hey {#Emph}gals!" },
				{ Cue = "/VO/Scylla_0063", Text = "She's {#Emph}back." },
				{ Cue = "/VO/Scylla_0064", Text = "{#Emph}Aw{#Prev}, look who!" },
				{ Cue = "/VO/Scylla_0065", Text = "{#Emph}Showtime..." },
				{ Cue = "/VO/Scylla_0066", Text = "{#Emph}Lookit {#Prev}here..." },
				{ Cue = "/VO/Scylla_0067", Text = "You again..." },
				{ Cue = "/VO/Scylla_0068", Text = "{#Emph}Hmm..." },
				{ Cue = "/VO/Scylla_0069", Text = "{#Emph}Hoh!" },
				{ Cue = "/VO/Scylla_0070", Text = "{#Emph}Mmm, hmhmhmhm!" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.35,
				SuccessiveChanceToPlayAll = 0.33,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaFirstMeeting" },
					},
					NamedRequirementsFalse = { "NoGreetingToScylla" },
				},

				{ Cue = "/VO/Melinoe_1447", Text = "Still practicing, are we?" },
				{ Cue = "/VO/Melinoe_1448", Text = "I beat the crowds, did I?" },
				{ Cue = "/VO/Melinoe_1449", Text = "On with the show?", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1450", Text = "From the top, then?" },
			},

		},

		ObstacleData =
		{
			-- Siren Fan
			[595279] =
			{
				Name = "SirenFanShade",
				EmoteOffsetZ = 10,
				DistanceTriggers =
				{
					{
						WithinDistance = 550,
						Emote = "StatusIconDisgruntled",
						TriggerOnceThisRun = true,
					},
					{
						Repeat = true,
						WithinDistance = 400,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							PreLineThreadedFunctionName = "SpecialInteractSirenFan",
							GameStateRequirements =
							{
								{
									PathEmpty = { "RequiredKillEnemies" },
								},
							},

							{ Cue = "/VO/MelinoeField_1717", Text = "Show's over, everyone.", PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
										HasNone = { "/VO/Melinoe_1100" },
									},
								},
							},
							{ Cue = "/VO/MelinoeField_1718", Text = "That's all for tonight's show." },
							{ Cue = "/VO/MelinoeField_1719", Text = "We'll have another show tomorrow night." },
							{ Cue = "/VO/MelinoeField_1720", Text = "And that's our show for tonight!" },
							{ Cue = "/VO/MelinoeField_1721", Text = "Show's over. Technical difficulties.",
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
										HasNone = { "/VO/Melinoe_1100" },
									},
								},
							},
							{ Cue = "/VO/MelinoeField_1722", Text = "Technical difficulties once again, apologies." },
						}
					}
				}
			}

		},

		InspectPoints =
		{
			[595118] =
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
					Inspect_G_Boss01_01 =
					{
						{ Cue = "/VO/Storyteller_0143",
							Text = "{#Emph}Where once reverberated the enthralling music of the Sirens, sheer silence now remains; yet for how long shall those immortal songstresses be stilled?" },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0222", Text = "Doubtless only till my next attempt..." },
						},
					},
				},
			},

		},

	},

	G_PostBoss01 =
	{
		InheritFrom = { "BaseG" },
		LegalEncounters = { "Empty" },

		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,

		GameStateRequirements =
		{
			-- None
		},

		-- NextRoomEntranceFunctionName = "RoomEntranceStandard",

		RequiresLinked = true,
		NextRoomSet = { "H", },
		ExitPreviewAnim = "ExitDownPreview",
		RichPresence = "#RichPresence_PostBoss",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		SkipLastKillPresentation = true,
		TimeChallengeSwitchSpawnChance = 0.0,
		WellShopSpawnChance = 1.0,
		 
		ForceWellShop = true,
		SecretSpawnChance = 0.0,
		SellTraitShrineUpgrade = true,

		WellShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossWellShops" },
			},
		},

		ObstacleData =
		{
			[613250] =
			{
				Template = "HealthFountainG",
				Activate = true,
				ActivateIds = { 613250 },
				SetupGameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossFountains", },
					},
				},
			},
			[486504] =
			{
				Template = "GiftRack",
				Activate = true,
				ActivateIds = { 616853, 616854, 616855, 616856, },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossGiftRack" },
					},
				},
			},
			[487438] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossWellShops" },
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
					{
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_G_PostBoss_01 =
					{
						{ Cue = "/VO/Storyteller_0169",
							Text = "{#Emph}Within a green-tinged chamber that the shrilly-singing Sirens made their own, a pathway plunges deep into the unknown outskirts of the Underworld." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0815", Text = "So this is Scylla's little lair, huh?" },
						},
					},
				},
			},
			[637438] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_G_PostBoss_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_G_PostBoss_02 =
					{
						{ Cue = "/VO/Storyteller_0211",
							Text = "{#Emph}Collected works of sailor-slaying Scylla and her Sirens lie conspicuously scattered here, a parting vengeance on the sensibility of those who dare to take a closer look." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_1326", Text = "{#Emph}You're such a mess, that little dress... {#Prev}oh, gods..." },
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
				SuccessiveChanceToPlay = 0.5,
				GameStateRequirements =
				{
					-- AreIdsNotAlive = { 561902 },
				},

				{ Cue = "/VO/MelinoeField_0983", Text = "First tunnel to my right..." },
				{ Cue = "/VO/MelinoeField_0984", Text = "The Sirens' ready-room..." },
				{ Cue = "/VO/MelinoeField_0985", Text = "No Sirens, thank the gods..." },
				{ Cue = "/VO/MelinoeField_0986", Text = "Best get out before Scylla comes back." },
				{ Cue = "/VO/MelinoeField_0987", Text = "The edge of Oceanus...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0988", Text = "The very bottom of the sea..." },
				{ Cue = "/VO/MelinoeField_0989", Text = "Reeks in here..." },
				{ Cue = "/VO/MelinoeField_0990", Text = "No more crowds..." },
			},
		},
		ExitVoiceLines =
		{
			PreLineWait = 0.5,
			RandomRemaining = true,
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
				},
			},

			{ Cue = "/VO/MelinoeField_0991", Text = "Big drop...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0992", Text = "Closer now..." },
			{ Cue = "/VO/MelinoeField_0993", Text = "To the Fields..." },
			{ Cue = "/VO/MelinoeField_0994", Text = "{#Emph}<Inhale>" },
			{ Cue = "/VO/MelinoeField_0995", Text = "Out of here." },
			{ Cue = "/VO/MelinoeField_0996", Text = "Long way down..." },
			{ Cue = "/VO/MelinoeField_0997", Text = "Time to dry off." },
			{ Cue = "/VO/MelinoeField_0998", Text = "To firmer ground." },
		},

	},

	G_Intro =
	{
		InheritFrom = { "BaseG", "BiomeStartRoom"},

		LegalEncounters = { "Empty" },
		Starting = true,
		IntroSequenceDuration = 0.9,
		NoReward = true,
		NoReroll = true,
		SkipLastKillPresentation = true,
		HideRewardPreview = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceFunctionName = "RoomEntranceStandard",
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		FlipHorizontalChance = 0.0,

		ForceAtBiomeDepthMin = 0,
		ForceAtBiomeDepthMax = 1,
		MaxAppearancesThisBiome = 1,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		HarvestPointChances =
		{
			0,
			0,
			0,
		},

		ZoomFraction = 0.75,
		CameraZoomWeights =
		{
			[569393] = 1.00,
			[569394] = 1.25,
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "EndBiomeRecords", },
			{ FunctionName = "EndAllBiomeStates" },
			{
				FunctionName = "SpawnErisForCurse",
				Args =
				{
					UnitName = "NPC_Eris_01",
					SpawnOnId = 410264,
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
								Name = "MetaCardPointsCommonDrop",
								Overrides =
								{
									AddResources =
									{
										MetaCardPointsCommon = 20,
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
						Value = 1,
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
					Id = 410264,
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
						Value = 3,
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
				Args = { Text = "Location_BiomeG", Delay = 2.0, },
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

		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 150, FunctionName = "BiomeOverlook", Repeat = true, Args = { PanTargetId = 558051, ZoomFraction = 0.65 },
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "BiomeBackToRoom", Repeat = true,
			},
		},

		ObstacleData =
		{
			
		},

		InspectPoints =
		{
			[560583] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					RequiredUnitsNotAlive = { "NPC_Eris_01" },
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_G_Intro_01 =
					{
						{ Cue = "/VO/Storyteller_0019",
							Text = "{#Emph}Within the sopping, blackest pits of Oceanus reside horrors that the greatest mortal or immortal poets could not possibly describe." },
						EndVoiceLines =
						{
							{
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
									},
								},
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_0854", Text = "Don't sell yourself short, Homer." },
							},
							{
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
									},
								},
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_0151", Text = "I'll find a way." },
							},
						},
					},
				},
			},

			[595117] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					RequiredUnitsNotAlive = { "NPC_Eris_01" },
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_G_Intro_02 =
					{
						{ Cue = "/VO/Storyteller_0142",
							Text = "{#Emph}The Underworld plunges deeper than the deepest sea; yet there are such places where the edge of one and the other meet." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0221", Text = "One dark abyss next to another..." },
						},
					},
				},
			},

		},

		-- Room Audio Below This Line
		MusicStartDelay = 0.25,
		MusicActiveStems = { "Guitar", },
		MusicMutedStems = { "Drums", },
		PlayBiomeMusic = true,
		MusicSection = 0,

		EnterVoiceLines =
		{
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			[1] = GlobalVoiceLines.StartPackagedBountyRunVoiceLines,
			[2] = GlobalVoiceLines.BiomeStateChangeStartVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 1.65,
				PreLineFunctionName = "GenericPresentation",
				PreLineFunctionArgs = { PreWait = 1.0 },
				SuccessiveChanceToPlayAll = 0.5,

				{ Cue = "/VO/Melinoe_0802", Text = "That singing...",
					PlayFirst = true, PreLineWait = 6.65,
					RecheckRequirementsPostWait = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "SessionMapState", "Humming", },
						},
						{
							Path = { "LastLinePlayed" },
							IsNone = { "/VO/MelinoeField_1959", "/VO/MelinoeField_1960" },
						},
						IsObjectTypeNotAlive = "NPC_Eris_01",
					},
				},
				{ Cue = "/VO/Melinoe_0803", Text = "That song again...",
					PlayFirst = true, PreLineWait = 6.65,
					RecheckRequirementsPostWait = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_0802" },
						},
						{
							PathTrue = { "SessionMapState", "Humming", },
						},
						{
							Path = { "LastLinePlayed" },
							IsNone = { "/VO/MelinoeField_1959", "/VO/MelinoeField_1960" },
						},
						IsObjectTypeNotAlive = "NPC_Eris_01",
					},
				},
				{ Cue = "/VO/MelinoeField_0131", Text = "Keep practicing, Scylla...",
					PreLineWait = 6.65,
					RecheckRequirementsPostWait = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "H_Intro" },
							Comparison = ">=",
							Value = 2,
						},
						{
							PathTrue = { "SessionMapState", "Humming", },
						},
						{
							Path = { "LastLinePlayed" },
							IsNone = { "/VO/MelinoeField_1959", "/VO/MelinoeField_1960" },
						},
						IsObjectTypeNotAlive = "NPC_Eris_01",
					},
				},
				{ Cue = "/VO/MelinoeField_0127", Text = "The rim of Oceanus..." },
				{ Cue = "/VO/MelinoeField_0128", Text = "That briny smell..." },
				{ Cue = "/VO/MelinoeField_0129", Text = "The air's thick..." },
				{ Cue = "/VO/MelinoeField_0130", Text = "There's that rancid scent...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "SpeechRecord" },
							HasAny = { "/VO/MelinoeField_0128" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0132", Text = "At least my feet are clean...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "G_Intro" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0133", Text = "{#Emph}Brr{#Prev}, that's cold..." },
				--[[
				{ Cue = "/VO/MelinoeField_0134", Text = "No Siren song this time...", PreLineWait = 7.65,
					GameStateRequirements =
					{
						{
							PathFalse = { "AudioState", "SecretMusicId" },
						}
					},
				},
				]]--
			},
		},

	},

	G_Shop01 =
	{	
		InheritFrom = { "BaseG" },
		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 3,
		ForceAtBiomeDepthMax = 6,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		StoreDataName = "WorldShop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		NoReroll = true,

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			RequiredMinExits = 2,
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
			},
		},

		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,
		ExorcismPointChance = 0.4,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		ZoomFraction = 0.85,

		-- Ambience = "/Leftovers/Object Ambiences/ShipwreckAmbience",
		SpawnRewardGlobalVoiceLines = "FoundShopVoiceLines",

		InspectPoints =
		{
			[595121] =
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
					Inspect_G_Shop01_01 =
					{
						{ Cue = "/VO/Storyteller_0146",
							Text = "{#Emph}Even the faintest river-current in the Underworld bears willingly the Boatman of the Dead... wheresoever he may please." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0225", Text = "I'm grateful he made the trip." },
						},
					},
				},
			},

		},

	},

	G_MiniBoss01 =
	{
		InheritFrom = { "BaseG", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		SecretMusic = "/Music/IrisMinibossMusic",
		SecretMusicSection = 2,

		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "G_MiniBoss02" },
		},

		LegalEncounters = { "MiniBossWaterUnit" },
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.82,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.10, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 7,
		MaxAppearancesThisBiome = 1,

		CombatResolvedVoiceLines =
		{
			[1] = GlobalVoiceLines.MiniBossEncounterEndVoiceLines,
		},

		InspectPoints =
		{
			[595119] =
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
					Inspect_G_MiniBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0144",
							Text = "{#Emph}That which slithers, seeps, and crawls, all of it thrives within the foul air and crushing climate near the bottom of the sea." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0223", Text = "The air is definitely stuffier down here..." },
						},
					},
				},
			},

		},

	},

	G_MiniBoss02 =
	{
		InheritFrom = { "BaseG", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		-- handled in RoomEntranceCrawlerMiniBoss
		-- SecretMusic = "/Music/IrisMinibossMusic",
		-- SecretMusicSection = 2,

		EntranceFunctionName = "RoomEntranceCrawlerMiniBoss",
		
		GameStateRequirements =
		{
			RequiredFalseSeenRoomsThisRun = { "G_MiniBoss01" },
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossWaterUnit" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 8,
			},
		},

		LegalEncounters = { "MiniBossCrawler" },
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.82,

		RushMaxRangeOverride = 475,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.10, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		--ForceAtBiomeDepthMin = 5,
		--ForceAtBiomeDepthMax = 8,
		MaxAppearancesThisBiome = 1,

		InspectPoints =
		{
			[595120] =
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
					Inspect_G_MiniBoss_02_01 =
					{
						{ Cue = "/VO/Storyteller_0145",
							Text = "{#Emph}As surface-vermin flee from sinking vessels, so have Underworld vermin sought darker reaches of their realm, in the tumult of the times." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0224", Text = "It's hard to be a rodent..." },
						},
					},
				},
			},

		},

	},

	BaseG_Combat =
	{
		InheritFrom = { "BaseG" },
		DebugOnly = true,

		LockExtraExitsWithEncounter = "GeneratedG_ExtraDoor",
		LockExtraExitsChance = 0.10,
		AllowAnomalyReplacement = true,

		MaxAppearancesThisBiome = 1,
	},

	G_Combat01 =
	{
		InheritFrom = { "BaseG_Combat" },

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	G_Combat02 =
	{
		InheritFrom = { "BaseG_Combat" },
		LockExtraExitsChance = 0.35,
	},

	G_Combat03 =
	{
		InheritFrom = { "BaseG_Combat" },
		LockExtraExitsChance = 0.35,
		
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Combat04 =
	{
		InheritFrom = { "BaseG_Combat" },

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	G_Combat05 =
	{
		InheritFrom = { "BaseG_Combat" },
		LockExtraExitsChance = 0.80,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	G_Combat05Backup =
	{
		InheritFrom = { "BaseG_Combat" },
		DebugOnly = true,

	},

	G_Combat06 =
	{
		InheritFrom = { "BaseG_Combat" },

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	G_Combat07 =
	{
		InheritFrom = { "BaseG_Combat" },

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	G_Combat08 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.75,

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 3,
			},
		},

	},

	G_Combat09 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.85,
		LockExtraExitsChance = 0.35,

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Combat10 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.85,

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Combat11 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.85,

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Combat12 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.75,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Combat13 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.8,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Combat14 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.8,
		
		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Combat15 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.735,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Reprieve01 =
	{
		InheritFrom = { "BaseG" },
		IneligibleRewards = { "Devotion", },
		-- SuppressRewardSpawnSounds = true,

		RushMaxRangeOverride = 475,
		
		MaxCreationsThisRun = 1,
		LegalEncounters = { "HealthRestore" },
		SecretMusic = "/Music/BlankMusicCue",
		--ZoomFraction = 0.75,
		FlipHorizontalChance = 0.0,
		SpawnRewardOnId = 561339,
		DisableRewardMagnetisim = true,
		IntroSequenceDuration = 0.02,
		EntranceFunctionName = "EnterBiomeGRoomPresentation",

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
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeOceanusReprieve" },
			},
			RequiredMinCompletedRuns = 0,
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 6,
			},
		},

		MusicMutedStems = { "Drums" },
		EnterGlobalVoiceLines = "EnteredReprieveRoomVoiceLines",

		-- Ambience = "/Leftovers/Ambience/StillWaterAmbience",

		InspectPoints =
		{
			[560583] =
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
					Inspect_G_Reprieve01_01 =
					{
						{ Cue = "/VO/Storyteller_0147",
							Text = "{#Emph}In black and murky Oceanus past the border of the Underworld, the putrid waters are purified, as if to show that there, Poseidon holds no sway." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0226", Text = "As long as his Boons still work..." },
						},
					},
				},
			},

		},

	},

	G_Story01 =
	{
		InheritFrom = { "BaseG" },
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		ForceIfUnseenForRuns = 6,
		RichPresence = "#RichPresence_GStory01",
		HarvestBlockedText = "ExitBlockedByNPC",
		AllowExorcismPreExitsUnlock = true,

		SkipLastKillPresentation = true, 

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
				Value = 6,
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "G_Boss01" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty", },
			},
		},

		ZoomFraction = 0.8,
		--[[
		CameraZoomWeights =
		{
			[569397] = 1.00, -- far from narcisuss
			[569395] = 1.25, -- near to narcisuss
			[569396] = 1.25, -- near to narcissus
			[569398] = 1.00, -- far from narcisuss
		},
		]]--

		HarvestPointChances =
		{
			0.9,
			0.5,
			0.1,
		},
		ShovelPointChance = 0.5,
		PickaxePointChance = 0.5,
		ExorcismPointChance = 0.5,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		HarvestPointRequirements = { },
		ShovelPointRequirements = { },
		--PickaxePointRequirements = { },
		ExorcismPointRequirements = { },

		-- SecretMusic = "/Music/MusicPlayer/OrpheusSong2MusicPlayer",
		-- ZoomFraction = 0.85,
		ZoomFraction = 0.85,
		TimerBlock = "StoryRoom",

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Narcissus_01" },

		MusicMutedStems = { "Vocals", },

		ObstacleData =
		{
			-- dirty water
			[623585] =
			{
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				DestroyIfNotSetup = true,
			},
			-- narcissus reflection
			[563373] =
			{
				SetupGameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				DestroyIfNotSetup = true,
			},
		},

		StartUnthreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					Id = 591757,
					Color = { 87, 72, 16, 255 },
					SetBase = true,
				},
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					Ids = { 591222, 591216, 591213, 591212, 591209, 590990, 591242, 591217, 591218, 591244, 591211, 590993, 591241, 591239, 590987, 590994, 591219, },
					Color = { 50, 52, 8, 255 },
					SetBase = true,
				},
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					Ids = { 595106, 595105, },
					Color = { 35, 30, 0, 255 },
					SetBase = true,
				},
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					Id = 623530,
					Color = { 124, 109, 25, 255 },
					SetBase = true,
				},
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
			},
		},

		InspectPoints =
		{
			[595073] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Narcissus_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_G_Story01_01 =
					{
						{ Cue = "/VO/Storyteller_0148",
							Text = "{#Emph}The mirror sheen of the standing waters all about reveal to denizens of Oceanus their full selves; to their horror, or to their delight." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0227", Text = "This is not a good view..." },
						},
					},
				},
			},
		},

	},

}

AddTableKeysCheckDupes( RoomData, RoomSetData.G )