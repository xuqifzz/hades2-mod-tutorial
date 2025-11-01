RoomSetData.G =
{
	BaseG =
	{
		DebugOnly = true,
		RichPresence = "#RichPresence_G",
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Oceanus",
		ResultText = "RunHistoryScreenResult_Oceanus",
		
		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,
		HarvestPointBase = "DrownedChambersHarvestPointBase01",

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
						Path = { "GameState", "LifetimeResourcesGained", "PlantGLotus" },
						Comparison = "<",
						Value = 13,
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
				Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshadeSeed" },
				Comparison = ">=",
				Value = 3,
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
						Path = { "GameState", "LifetimeResourcesGained", "PlantGCattailSeed" },
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
				Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
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
						Path = { "GameState", "LifetimeResourcesGained", "OreGLime" },
						Comparison = "<",
						Value = 36,
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
				Path = { "GameState", "ExorcisedNames", "ShadeErebusIdle" },
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
								Path = { "GameState", "ExorcisedNames", "ShadeOceanusSIdle" },
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
						NotHasAll = { "FishGCommon", "FishGRare", "FishGLegendary" },
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

		BreakableValueOptions = { MaxHighValueBreakables = 3 },
		TimeChallengeEncounterOptions = { "TimeChallengeG" },
		PerfectClearEncounterOptions = { "PerfectClearChallengeG" },
		EliteChallengeEncounterOptions = { "EliteChallengeG" },

		SaveWhitelist =
		{
			-- for fates quest
			UsedBlockDeath = true,
		},

		LeavePrevRoomWipeAnimation = "RoomTransitionIn_Down",
		EnterWipeAnimation = "RoomTransitionOut_Down",

		LegalEncounters = EncounterSets.GEncountersDefault,
		DevotionEncounters = {"DevotionTestG"},
		TargetMetaRewardsRatio = 0.35,

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

		NarrativeContextArt = "DialogueBackground_Oceanus",
		NarrativeContextArtFlippable = false,

		EntranceFunctionName = "EnterBiomeGRoomPresentation",
		NextRoomEntranceFunctionName = "EnterBiomeGRoomPresentation",
		EntranceAnimation = "MelinoeIdle",
		LocationAnimName = "InfoBannerOceanusIn",
		LocationAnimOutName = "InfoBannerOceanusOut",

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
			["SuitExhaustBase_Sprint_R"] = "SuitExhaustBase_Sprint_R_Water",
			["SuitExhaustBase_Sprint_L"] = "SuitExhaustBase_Sprint_L_Water",
			["DeathSplats"] = "DeathSplatsBlackSoft",
			["OlympusSnowExplosionDecal"] = "ExplosionScorchDecal",
			["FrogFamiliarLandDust"] = "FrogFamiliarLandSplashOceanus",
		},

		SwapSounds =
		{
			["/Leftovers/SFX/FootstepsWheat2Small"] = "/Leftovers/SFX/FootstepsWetSmall",
			["/Leftovers/SFX/FootstepsWheat"] = "/Leftovers/SFX/FootstepsWetMedium",
		},

		StartThreadedEvents =
		{
			--{ FunctionName = "FloodManager", GameStateRequirements = { ChanceToPlay = 0.5, }, Args = { Types = { "FloodTrap" }, IntervalMin = 12.0, IntervalMax = 25.0, FirstIntervalMin = 6.0, FirstIntervalMax = 12.0 } },
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.15 }, Args = { StartingCountMin = 0, StartingCountMax = 8, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
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
		LinkedRooms = { "G_Boss01", "G_Boss02" },

		RushMaxRangeOverride = 475,

		GameStateRequirements =
		{
			-- None
		},
		
		SecretSpawnChance = 0.0,

		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,
		ExorcismPointChance = 0.3,
		FishingPointChance = 0.3,

		WellShopSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,

		SkipLastKillPresentation = true,
		
		ZagContractRewardDestinationId = 776334,

		LegalEncounters = { "Shop" },
		ForcedFirstReward = "Shop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomMoneyDrop", },

		SpawnRewardOnId = 561335,

		DisableRewardMagnetisim = true,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,
		HoundFamiliarMovementRequiresLineOfSight = true,
		PolecatFamiliarShouldNotFollow = true,

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
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech" },
							},

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
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "RoomsEntered", "G_Boss01" },
									},
								},

								{ Cue = "/VO/MelinoeField_3820", Text = "Right onto Scylla's stage..." },
							},
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "RoomsEntered", "G_Boss01" },
									},
								},

								{ Cue = "/VO/Melinoe_0855", Text = "It's very pretty..." },
							},
						},
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

		BackupCauseOfDeath = "Scylla",

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
		EntranceFunctionArgs = { ScyllaId = 557843 },
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,
		ZoomFraction = 0.68,
		FlipHorizontalChance = 0.0,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

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
		},	

		StartThreadedEvents =
		{
			--{ FunctionName = "FloodManager", GameStateRequirements = { ChanceToPlay = 0.0, }, Args = { Types = { "FloodTrap" }, IntervalMin = 7.0, IntervalMax = 15.0, FirstIntervalMin = 2.0, FirstIntervalMax = 3.0 } },
		},

		EnterVoiceLines =
		{
			{ GlobalVoiceLines = "ScyllaGreetingLines" },
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
								{
									FunctionName = "RequiredHealthFraction",
									FunctionArgs = { Comparison = ">", Value = 0.2, },
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
			[736957] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_G_Boss01_02 =
					{
						{ Cue = "/VO/Storyteller_0474",
							Text = "{#Emph}The alluring Siren song fades finally to nothingness, leaving the Princess of the Dead to contemplate the pathways plunging deeper toward forbidden regions of the realm." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3821", Text = "We're almost to the Fields." },
						},
					},
				},
			},

			[595118] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_G_Boss01_02", },
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

	G_Boss02 =
	{
		InheritFrom = { "BaseG" },
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

		BackupCauseOfDeath = "Scylla",

		SpeakerName = { "Selene" },

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
		LegalEncounters = { "BossScylla02", },
		ForcedReward = "MixerGBossDrop",
		NoReroll = true,

		EntranceFunctionName = "RoomEntranceBoss02BiomeG",
		EntranceFunctionArgs =
		{
			ScyllaId = 609649,
			TentacleIdsOrdered = { 737568, 737569, 737572, 737573, 737571, 737570 },
		},
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,
		ZoomFraction = 0.63,
		FlipHorizontalChance = 0.0,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasFishingPoint = false,
		HasExorcismPoint = false,

		UnthreadedEvents =
		{
			{
				FunctionName = "SetupStageLights"
			},
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 609649 },
					SetupBossIds = { 609649, 609648, 609650, },
					SetupUnitIdAIs = { 737569, 737572, 737573, 737571, 737568, 737570, 737136 },
					--SkipAngleTowardTarget = true,
					-- Vocals handled in Scylla's EndTextLinesThreadedFunctionName
					SkipBossMusic = true,
					DelayedStart = true,
				},
			},
		},
		PostCombatReloadEvents =
		{
			{
				FunctionName = "SetupStageLights"
			},
		},

		StartThreadedEvents =
		{
			--{ FunctionName = "FloodManager", GameStateRequirements = { ChanceToPlay = 0.0, }, Args = { Types = { "FloodTrap" }, IntervalMin = 7.0, IntervalMax = 15.0, FirstIntervalMin = 2.0, FirstIntervalMax = 3.0 } },
		},

		InspectPoints =
		{
			[793947] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_G_Boss02_01 =
					{
						{ Cue = "/VO/Storyteller_0420",
							Text = "{#Emph}Though bolstered by colossal Charybdis, Scylla and those monstrous songstresses from the abyssal sea yet prove unable to complete their deadly act." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_3613", Text = "In the end, a normal night for them." },
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
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_G_Boss02_01" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_G_Boss02_02 =
					{
						{ Cue = "/VO/Storyteller_0455",
							Text = "{#Emph}With such a rousing show abruptly ended all too soon, the Shades there in attendance are left to wonder whether to await an encore, or a refund." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3653", Text = "Passes are nonrefundable I think..." },
						},
					},
				},
			},
		},

	},

	G_PostBoss01 =
	{
		InheritFrom = { "BaseG" },
		RichPresence = "#RichPresence_PostBossUnderworld",
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
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 1.0,
		 
		ForceWellShop = true,
		WellShopChallengeBaseId = 487438,
		SecretSpawnChance = 0.0,
		SellTraitShrineUpgrade = true,

		WellShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossWellShops" },
			},
		},
		SellShopSpawnChance = 1.0,
		SellShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossSellTraitShops" },
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
					-- None
				},
			},
			[486504] =
			{
				Template = "GiftRack",
				Activate = true,
				ActivateIds = { 616853, 616854, 616855, 616856, 768630 },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossGiftRack" },
					},
				},
			},
			[637448] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				ActivateIds = { 768632 },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossSellTraitShops" },
					},
				},
			},
			[487438] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				ActivateIds = { 768631 },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossWellShops" },
					},
				},
			},
		},

		LeavePostPresentationEvents =
		{
			{
				FunctionName = "BiomeMapPresentation",
				Args =
				{
					HeroStartOffsetX = 40,
					HeroStartOffsetY = 880,

					FamiliarStartOffsetX = -75,
					FamiliarStartOffsetY = 880,

					HeroMoveOffsetX = 670,
					HeroMoveOffsetY = 210,
					HeroMoveDuration = 1.4,

					FamiliarMoveOffsetX = 670,
					FamiliarMoveOffsetY = 210,
					FamiliarMoveDuration = 1.4,

					CameraEndOffsetX = -60,

					MoveEaseIn = 0.5,
					MoveEaseOut = 1.0,

					BiomeStart = "BiomeG",
					BiomeEnd = "BiomeH",
					PreviousBiomes = { "BiomeF" },

					CrossroadsStart = false,

					ShrineBounty = "BossInfestedCerberus01",
				},
				GameStateRequirements =
				{
					-- None
				}
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutSongs01" }
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

				{ Cue = "/VO/MelinoeField_0983", Text = "First tunnel to my right...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0984", Text = "The Sirens' ready-room..." },
				{ Cue = "/VO/MelinoeField_0985", Text = "No Sirens, thank the gods..." },
				{ Cue = "/VO/MelinoeField_0986", Text = "Best get out before Scylla comes back." },
				{ Cue = "/VO/MelinoeField_0987", Text = "The edge of Oceanus..." },
				{ Cue = "/VO/MelinoeField_0988", Text = "The very bottom of the sea..." },
				{ Cue = "/VO/MelinoeField_0989", Text = "Reeks in here..." },
				{ Cue = "/VO/MelinoeField_0990", Text = "No more crowds..." },
			},
		},
		ExitVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "LeftBiomeSpeech", Time = 6 },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.5,
				TriggerCooldowns = { "MelinoeFieldsStartSpeech" },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/MelinoeField_4585", Text = "Back to the Fields then..." },
			},
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

		HarvestPointChances = { 0.02, },
		ShovelPointChance = 0.02,
		PickaxePointChance = 0.02,
		--ExorcismPointChance = 0.02,
		FishingPointChance = 0.02,

		ZoomFraction = 0.75,
		CameraZoomWeights =
		{
			[569393] = 1.00,
			[569394] = 1.25,
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "EndBiomeRecords", },
			{ FunctionName = "EndAllBiomeStates" }, -- back-compat for saves with rain in F_PostBoss
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
									CanDuplicate = false,
									NPCDrop = true,
									MetaConversionEligible = false,
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
				Args =
				{
					Text = "Location_BiomeG",
					AnimationName = "InfoBannerOceanusIn",
					AnimationOutName = "InfoBannerOceanusOut",
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
			{ GlobalVoiceLines = "StartPackagedBountyRunVoiceLines" },
			{ GlobalVoiceLines = "BiomeStateChangeStartVoiceLines" },
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.65,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					NamedRequirements = { "TrueFatesQuestCanBeCompleted" },
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},

				{ Cue = "/VO/MelinoeField_5026", Text = "All right, Fates, where are you...?", PlayFirst = true },
				{ Cue = "/VO/Melinoe_5692", Text = "Fear not, you three... we'll find you..." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.65,
				PreLineFunctionName = "GenericPresentation",
				PreLineFunctionArgs = { PreWait = 1.0 },
				SuccessiveChanceToPlayAll = 0.5,

				{ Cue = "/VO/MelinoeField_4601", Text = "Is this a different song...?",
					PlayFirst = true,
					PlayOnce = true,
					PreLineWait = 3.5,
					GameStateRequirements =
					{
						{
							Path = { "AudioState", "MusicName" },
							IsAny = { "/Music/IrisMusicScylla2_MC" },
						},
						{
							Path = { "GameState", "MusicRecord", "/Music/IrisMusicScylla2_MC" },
							Comparison = "<=",
							Value = 1,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4602", Text = "An unfamiliar tune...",
					PlayFirst = true,
					PlayOnce = true,
					PreLineWait = 2.65,
					GameStateRequirements =
					{
						{
							Path = { "AudioState", "MusicName" },
							IsAny = { "/Music/IrisMusicScylla3_MC" },
						},
						{
							Path = { "GameState", "MusicRecord", "/Music/IrisMusicScylla3_MC" },
							Comparison = "<=",
							Value = 1,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4600", Text = "Not heard this one before...",
					PlayFirst = true,
					PlayOnce = true,
					PreLineWait = 2.65,
					GameStateRequirements =
					{
						{
							Path = { "AudioState", "MusicName" },
							IsAny = { "/Music/IrisMusicScylla4_MC" },
						},
						{
							Path = { "GameState", "MusicRecord", "/Music/IrisMusicScylla4_MC" },
							Comparison = "<=",
							Value = 1,
						},
					},
				},
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
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Eris_01" }, Alive = false },
						},
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
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Eris_01" }, Alive = false },
						},
						OrRequirements =
						{
							{
								{
									Path = { "AudioState", "MusicName" },
									IsAny = { "/Music/IrisMusicScylla1_MC" },
								},
								{
									Path = { "GameState", "MusicRecord", "/Music/IrisMusicScylla1_MC" },
									Comparison = ">",
									Value = 1,
								},
							},
							{
								{
									Path = { "AudioState", "MusicName" },
									IsAny = { "/Music/IrisMusicScylla2_MC" },
								},
								{
									Path = { "GameState", "MusicRecord", "/Music/IrisMusicScylla2_MC" },
									Comparison = ">",
									Value = 1,
								},
							},
							{
								{
									Path = { "AudioState", "MusicName" },
									IsAny = { "/Music/IrisMusicScylla3_MC" },
								},
								{
									Path = { "GameState", "MusicRecord", "/Music/IrisMusicScylla3_MC" },
									Comparison = ">",
									Value = 1,
								},
							},
							{
								{
									Path = { "AudioState", "MusicName" },
									IsAny = { "/Music/IrisMusicScylla4_MC" },
								},
								{
									Path = { "GameState", "MusicRecord", "/Music/IrisMusicScylla4_MC" },
									Comparison = ">",
									Value = 1,
								},
							},
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0131", Text = "Keep practicing, Scylla...",
					PreLineWait = 2.65,
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
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Eris_01" }, Alive = false },
						},
						NamedRequirementsFalse = { "HecateMissing" },
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

		Using = { AdditionalAnimations = { "TrueEndingBannerFx", "EpilogueOutro", }, },
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
			{
				FunctionName = "RequiredMinExits",
				FunctionArgs = { Count = 2 },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 5,
			},
		},

		ZagContractDestinationId = 776330,	

		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,
		ExorcismPointChance = 0.3,
		FishingPointChance = 0.3,

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
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "G_MiniBoss02" },
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "G_MiniBoss03" },
			},
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
			[1] = { GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
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
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "G_MiniBoss01" },
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "G_MiniBoss03" },
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossWaterUnit" },
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossJellyfish" },
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
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 7,
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

	G_MiniBoss03 =
	{
		InheritFrom = { "BaseG", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		SecretMusic = "/Music/IrisMinibossMusic",
		SecretMusicSection = 2,

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "G_MiniBoss01" },
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "G_MiniBoss02" },
			},
		},

		LegalEncounters = { "MiniBossJellyfish" },
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.85,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.10, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 7,
		MaxAppearancesThisBiome = 1,

		CombatResolvedVoiceLines =
		{
			{ GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		InspectPoints =
		{
			[745536] =
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
					Inspect_G_MiniBoss03_01 =
					{
						{ Cue = "/VO/Storyteller_0358",
							Text = "{#Emph}There are such creatures born of nightmare and the sea, which float eternally toward death and decay, and so invariably find themselves exactly here." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3260", Text = "Think I just stepped in one..." },
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

		IneligibleRewards = { "Devotion" },

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

		IneligibleRewards = { "Devotion" },

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 3,
			},
		},
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

		RushMaxRangeOverride = 525,
		
		IneligibleRewards = { "Devotion" },

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
		
		IneligibleRewards = { "Devotion" },

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

	G_Combat16 =
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

	G_Combat17 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.8,
		
		RushMaxRangeOverride = 525,
		
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	G_Combat18 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.8,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	G_Combat19 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.8,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 3,
			},
		},
	},

	G_Combat20 =
	{
		InheritFrom = { "BaseG_Combat" },
		ZoomFraction = 0.8,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
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
		HoundFamiliarMovementRequiresLineOfSight = true,
		PolecatFamiliarShouldNotFollow = true,

		HarvestPointChances = { 0.6, 0.4, },
		ShovelPointChance = 0.24,
		PickaxePointChance = 0.36,
		ExorcismPointChance = 0.24,
		FishingPointChance = 0.18,

		IgnoreHarvestBiomeSpawnLimit = true,

		StartThreadedEvents =
		{			
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 1.0 }, Args = { StartingCountMin = 24, StartingCountMax = 36, ObjectNames = { "ShadeMerc" }, MaxActive = 36 } },
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeOceanusReprieve" },
			},
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
			NamedRequirementsFalse = { "StandardPackageBountyActive" },
		},

		--[[
		CameraZoomWeights =
		{
			[569397] = 1.00, -- far from narcisuss
			[569395] = 1.25, -- near to narcisuss
			[569396] = 1.25, -- near to narcissus
			[569398] = 1.00, -- far from narcisuss
		},
		]]--

		HarvestPointChances = { 0.5, 0.1, },
		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,
		ExorcismPointChance = 0.4,
		FishingPointChance = 0.1,

		HarvestPointRequirements =
		{
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantGLotus" },
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
				Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshadeSeed" },
				Comparison = ">=",
				Value = 3,
			},
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantGCattailSeed" },
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
				Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
				Comparison = ">=",
				Value = 6,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreGLime" },
						Comparison = "<",
						Value = 36,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},

		IgnoreHarvestBiomeSpawnLimit = true,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		SecretMusic = "/Music/NarcissusTheme",
		SecretMusicSectionRandomizer =
		{
			Sections = { 1, 2, 3 },
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomCountCache", "G_Story01" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},

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
			-- dirty fountain
			[772219] =
			{
				SetupEvents =
				{
					{
						GameStateRequirements =
						{
							NamedRequirements = { "NarcissusDirtyWater" },
						},
						FunctionName = "OverwriteSelf",
						Args =
						{
							Animation = "Tilesets/DrownedChambers/DrownedChambers_Narcissus_Bowl_01b"
						},
					},
				},
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
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					Id = 800426,
					Color = { 96, 88, 38, 255 },
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
					Ids = { 800410, 800425, 800443, 800411, 800444, 800412, 800414, 800415, },
					Color = { 136, 104, 45, 255 },
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
					Ids = { 800429, 800421, 800428, 800427, 800423, 800420, 800418, 800424, 800419, },
					Color = { 106, 88, 29, 255 },
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
					Id = 800445,
					Color = { 207, 223, 67, 255 },
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