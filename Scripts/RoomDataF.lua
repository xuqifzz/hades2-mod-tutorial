RoomSetData.F =
{
	BaseF =
	{
		DebugOnly = true,
		RichPresence = "#RichPresence_F",
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Erebus",
		ResultText = "RunHistoryScreenResult_Erebus",

		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,

		LocationAnimName = "InfoBannerErebusIn",
		LocationAnimOutName = "InfoBannerErebusOut",

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
						Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
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
						Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshadeSeed" },
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
						Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
						Comparison = "<",
						Value = 62,
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
								Path = { "GameState", "ExorcisedNames", "ShadeErebusIdle" },
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
						NotHasAll = { "FishFCommon", "FishFRare", "FishFLegendary" },
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

		LegalEncounters = EncounterSets.FEncountersDefault,
		DevotionEncounters = {"DevotionTestF"},
		TargetMetaRewardsRatio = 0.315,

		SecretSpawnChance = 0.10,
		WellShopSpawnChance = 0.25,

		ChallengeSpawnChance = 0.25,
		TimeChallengeEncounterOptions = { "TimeChallengeF" },
		PerfectClearEncounterOptions = { "PerfectClearChallengeF" },
		EliteChallengeEncounterOptions = { "EliteChallengeF" },

		Ambience = "/Ambience/ErebusAmbientLoop",
		ShopSecretMusic = "/Music/CharonShopTheme",
		StopSecretMusic = true,

		LocationText = "Location_BiomeF",
		SaveProfileLocationText = "Location_BiomeF",

		BreakableValueOptions = { MaxHighValueBreakables = 3 },
		
		NarrativeContextArt = "DialogueBackground_Erebus",
		NarrativeContextArtFlippable = false,

		--[[
		SwapSounds =
		{
			["/SFX/Player Sounds/FootstepsHardSurface"] = "/Leftovers/SFX/FootstepsWheat2Small",
			["/SFX/Player Sounds/FootstepsHardSurfaceRun"] = "/Leftovers/SFX/FootstepsWheat",
		},
		]]--


		SwapAnimations =
		{
			["SuitExhaustSprintDust"] = "SuitExhaustSprintDust_Erebus",
			["OlympusSnowExplosionDecal"] = "ExplosionScorchDecal",
		},

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.2 }, Args = { StartingCountMin = 0, StartingCountMax = 8, ObjectNames = { "ShadeMerc" }, MaxActive = 8 } },
			{ FunctionName = "RespawningCoverManager", Args = { RespawnInterval = 10.0, ObjectsPerIntervalMin = 3, ObjectsPerIntervalMax = 5, MaxActive = 50, StartingCountMin = 50, StartingCountMax = 50, CoverObjectNames = { "RespawningCover" } } },
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

		ZoomFraction = 0.8,
		MaxAppearancesThisBiome = 1,
	},

	F_Opening01 =
	{
		InheritFrom = { "BaseF", "BiomeStartRoom" },
		Starting = true,
		GameStart = true,

		LegalEncounters = { "OpeningEmpty", "OpeningGeneratedF", "FCastTutorialFight" },
		NextRoomSet = { "F", },

		ForcedRewardStore = "RunProgress",
		IneligibleRewards = RewardSets.OpeningRoomBans,
		MaxAppearancesThisBiome = 1,

		BlockRunProgressUI = true,
		HasFishingPoint = true,
		TeleportCatFamiliarOnEncounterStart = true,

		SpawnRewardOnId = 40055,
		ForceIfUnseenForRuns = 6,

		EntranceFunctionName = "RoomEntranceMaterialize",
		EntranceFunctionArgs = { HeroGoalAngle = 315 },

		EndSecretMusicOnCombatOver = true, -- for Hermes

		--IntroSequenceDuration = 1.5,
		ZoomFraction = .84,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersOccurredCache", },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		DistanceTriggersPostCombatReload = true,

		HarvestPointChances = {	0.02, },
		HarvestPointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
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
						Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
						Comparison = "<",
						Value = 8,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.6,
				},
			},
		},
		HarvestPointForceRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
				Comparison = "<=",
				Value = 1,
			},
		},
		ShovelPointChance = 0.02,
		PickaxePointChance = 0.02,
		PickaxePointForceRequirements =
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
				Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
				Comparison = "<=",
				Value = 5,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},
		--ExorcismPointChance = 0.02,
		FishingPointChance = 0.02,

		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ZeusUpgrade",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "NextBiomeStateName" },
						IsAny = { "Rain" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "ZeusUpgrade" },
					},
				},
			},
			{
				Name = "Boon",
				LootName = "DemeterUpgrade",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "DemeterUpgrade" },
					},
				},
			},
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "PoseidonUpgrade" },
					},
				}
			},
			{
				Name = "Boon",
				LootName = "HestiaUpgrade",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord" },
						HasAll = { "PoseidonUpgrade", "DemeterUpgrade" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "HestiaUpgrade" },
					},
				},
			},
			{
				Name = "Boon",
				LootName = "AphroditeUpgrade",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord" },
						HasAll = { "DemeterUpgrade", "PoseidonUpgrade", "HestiaUpgrade" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "AphroditeUpgrade" },
					},
				}
			},
			{
				Name = "Boon",
				LootName = "HephaestusUpgrade",
				GameStateRequirements =
				{
					NamedRequirements = { "HephaestusUnlocked" },
				},
			},
			{
				Name = "SpellDrop",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "ArtemisCombatIntro" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "SpellDrop" },
					},
				}
			},
			{
				Name = "WeaponUpgrade",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "AphroditeUpgrade" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "WeaponUpgrade" },
					},
					{
						Path = { "CurrentRun", "WeaponsUnlocked" },
						HasNone = { "WeaponStaffSwing", "WeaponDagger" },
					},
				}
			},
			{
				Name = "Boon",
				LootName = "HermesUpgrade",
				FunctionName = "SpawnHermesInPerson",
				FunctionArgs =
				{
					UnitName = "NPC_Hermes_01",
					SpawnPoints =
					{
						F_Opening01 = 699329, 
						F_Opening02 = 699330,
						F_Opening03 = 699331, 
					},
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "G_Intro" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "GameState", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "HermesUpgrade" },
					},
				},
			},
			{
				Name = "Boon",
				LootName = "HeraUpgrade",
				GameStateRequirements =
				{
					NamedRequirements = { "HeraUnlocked" },
				},
			},
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "PoseidonDevotionIntro01" },
					},
					NamedRequirements = { "DevotionTestUnlocked" },
				}
			},
			{
				Name = "Boon",
				LootName = "AresUpgrade",
				GameStateRequirements =
				{
					NamedRequirements = { "AresUnlocked" },
				},
			},
			-- special case if you reach Q but not the final confrontation; also in RoomDataN
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Intro" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasNone = { "Q_MiniBoss03" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PoseidonAboutSurfaceThreat01" }
					},
				},
			},
			{
				Name = "Boon",
				LootName = "HermesUpgrade",
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_MiniBoss03" },
					},
					{
						Path = { "GameState", "RoomsEntered" },
						HasNone = { "Q_Boss01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesAboutTyphonReveal01" }
					},
				},
			},
			{
				Name = "Boon",
				LootName = "ZeusUpgrade",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusPostTrueEnding01", "ZeusPalacePostTrueEnding01" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
			},
			{
				Name = "Boon",
				LootName = "HermesUpgrade",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesPostEpilogue01" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
			},
			-- special case for Hermes & Apollo Keepsake; also in RoomDataN
			{
				Name = "Boon",
				LootName = "HermesUpgrade",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceApolloBoonKeepsake" },
					},
					{
						Path = { "GameState", "TraitUses", "ForceApolloKeepsake" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HermesAboutApolloKeepsake01" }
					},
				},
			},
		},

		StartUnthreadedEvents =
		{
			{
				FunctionName = "ShowRunIntro",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredConfigOptions",
						FunctionArgs = { ConfigOptions = { "ShowUIAnimations", }, },
					},
					{
						FunctionName = "RequiredConfigOptions",
						FunctionArgs = { ConfigOptions = { "EditingMode", }, HasOptions = false },
					},
				},
			},
			{
				FunctionName = "MusicPlayerEvent",
				Args = { TrackName = "/Music/MusicRunstart_MC", },
				-- Args = { TrackName = "/Music/IrisMusicExploration2_MC", },
			},
		},

		ThreadedEvents =
		{
			Threaded = true,
			{
				FunctionName = "DisplayInfoBanner",
				Args =
				{
					Text = "Location_BiomeF",
					AnimationName = "InfoBannerErebusIn",
					AnimationOutName = "InfoBannerErebusOut",
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

		StartThreadedEvents =
		{
			{ FunctionName = "CheckBiomeStateStart" },
			{ FunctionName = "ShadeMercManager", Args = { StartingCountMin = 3, StartingCountMax = 8, ObjectNames = { "ShadeMerc" }, MaxActive = 8 } },
			{ FunctionName = "RespawningCoverManager", Args = { RespawnInterval = 8.0, ObjectsPerIntervalMin = 4, ObjectsPerIntervalMax = 8, MaxActive = 50, StartingCountMin = 15, StartingCountMax = 30, CoverObjectNames = { "RespawningCover" } } },
		},

		EnterVoiceLines =
		{
			-- first run
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 60 },
				},
				PreLineWait = 2.0,

				{ Cue = "/VO/Melinoe_0004_V3", Text = "Death to Chronos.", PostLineWait = 3.3 },
				{ Cue = "/VO/Melinoe_1607", Text = "Vengeance for my family." },
			},			
		},

		RewardSpawnVoiceLines =
		{
			-- packaged bounties
			{ GlobalVoiceLines = "StartPackagedBountyRunVoiceLines" },
			-- biome state changes
			{ GlobalVoiceLines = "BiomeStateChangeStartVoiceLines" },
			-- other general cases
			{ GlobalVoiceLines = "TaskBegunVoiceLines" },
		},

		ExitVoiceLines =
		{
			{ GlobalVoiceLines = "StorytellerRunStartVoiceLines" },
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 520,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},

		InspectPoints =
		{
			[510255] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "InspectPreRun01" },
					},
				},
				InteractTextLineSets =
				{
					F_OpeningInspect01 =
					{
						{ Cue = "/VO/Storyteller_0009",
							Text = "{#Emph}Within mist-shrouded, labyrinthine Erebus lie countless souls of the dead, awaiting judgment that shall never come." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_0034", Text = "They'll be judged soon enough." },
						},
					},
				},
			},
		},

		Using = { UnitName = "NPC_Hermes_01" }
	},

	F_Opening02 =
	{
		InheritFrom = { "F_Opening01", "BaseF" },
		Starting = true,

		LegalEncounters = { "OpeningGeneratedF", "FCastTutorialFight" },

		SpawnRewardOnId = 40055,
		ForceIfUnseenForRuns = 6,

		EntranceFunctionName = "RoomEntranceMaterialize",
		EntranceFunctionArgs = { HeroGoalAngle = 225, ZoomStartFraction = 0.55 },

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersOccurredCache", },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
			{
				Path = { "GameState", "RoomCountCache", "F_Opening01", },
				Comparison = ">=",
				Value = 2,
			},
			{
				PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
			},
		},

		InspectPoints =
		{
			[510255] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "InspectPreRun01" },
					},
				},				
				InteractTextLineSets =
				{
					F_Opening02_Inspect01 =
					{
						{ Cue = "/VO/Storyteller_0119",
							Text = "{#Emph}Near all of the near-endless pathways in suffocating Erebus lead to dead ends, and very scarce are those who can navigate them." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
							{ Cue = "/VO/Melinoe_1433", Text = "Took only my entire life to figure out." },
						},
					},
				},
			},
		},

	},

	F_Opening03 =
	{
		InheritFrom = { "F_Opening01", "BaseF" },
		Starting = true,

		LegalEncounters = { "OpeningGeneratedF", "FCastTutorialFight" },

		SpawnRewardOnId = 567223,
		ForceIfUnseenForRuns = 6,

		EntranceFunctionName = "RoomEntranceMaterialize",
		EntranceFunctionArgs = { HeroGoalAngle = 325, ZoomStartFraction = 0.60 },

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersOccurredCache", },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
			{
				Path = { "GameState", "RoomCountCache", "F_Opening01", },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "GameState", "RoomCountCache", "F_Opening02", },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
			},
		},

		InspectPoints =
		{
			[567224] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						Path = { "GameState", "RoomCountCache", "F_Opening03", },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "InspectPreRun01" },
					},
				},				
				InteractTextLineSets =
				{
					F_Opening03_Inspect01 =
					{
						{ Cue = "/VO/Storyteller_0120",
							Text = "{#Emph}Not even those with the power to enter the Crossroads at will can entirely anticipate which of its three hidden paths shall be their exit." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_4599", Text = "I still know the way..." },
						},
					},
				},
			},
		},

	},

	F_MiniBoss01 =
	{
		InheritFrom = { "BaseF", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",
		
		HasFishingPoint = false,
		SecretSpawnChance = 0.0,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomsEntered" },
				HasNone = { "F_MiniBoss02", "F_MiniBoss03" },
			},
		},

		LegalEncounters = { "MiniBossTreant", "MiniBossTreant_Shrine" },
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.86,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		-- BoonRaritiesOverride = { Legendary = 0.1, Epic = 0.25, Rare = 0.90 },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.07, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 6,
		MaxAppearancesThisBiome = 1,

		EntranceDirection = "Right",

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		CombatResolvedVoiceLines =
		{
			{ GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		InspectPoints =
		{
			[584869] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_MiniBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0137",
							Text = "{#Emph}The ever-restless Shades of Erebus find little peace there, save for the prickly embrace of the gnarled branches of those writhing woods." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1690", Text = "Am I fighting the Spirits, or the woods?" },
						},
					},
				},
			},
		},

	},

	F_MiniBoss02 =
	{
		InheritFrom = { "BaseF", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",
		
		HasFishingPoint = false,
		SecretSpawnChance = 0.0,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "MiniBossTreant" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "RoomsEntered" },
				HasNone = { "F_MiniBoss01", "F_MiniBoss03" },
			},
		},

		LegalEncounters = { "MiniBossFogEmitter", "MiniBossFogEmitter_Shrine" },
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.82,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.07, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 6,
		MaxAppearancesThisBiome = 1,

		EntranceDirection = "Right",

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		CombatResolvedVoiceLines =
		{
			{ GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		InspectPoints =
		{
			[587135] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_MiniBoss02_01 =
					{
						{ Cue = "/VO/Storyteller_0138",
							Text = "{#Emph}Such deep impenetrable gloom surrounds the Underworld Princess that not even her infernal eye can easily discern what horrors lie therein." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1691", Text = "If I can't see into the shadows, I'll cut through." },
						},
					},
				},
			},
		},

	},

	F_MiniBoss03 =
	{
		InheritFrom = { "BaseF", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",
		
		--HasFishingPoint = false,
		SecretSpawnChance = 0.0,

		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "MiniBossTreant" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "RoomsEntered" },
				HasNone = { "F_MiniBoss01", "F_MiniBoss02" },
			},
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAll = { "BossChronos01", "BossPolyphemus01", "ZombieAssassinIntro" },
			},
		},

		LegalEncounters = { "MiniBossAssassin" },
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.9,
		IntroSequenceDuration = 0.3,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.07, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 6,
		MaxAppearancesThisBiome = 1,

		EntranceDirection = "Right",

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		CombatResolvedVoiceLines =
		{
			{ GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		InspectPoints =
		{
			[800455] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = { "/VO/MelinoeField_3696", "/VO/MelinoeField_3698" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_MiniBoss03_01 =
					{
						{ Cue = "/VO/Storyteller_0473",
							Text = "{#Emph}The shadow of a skulking killer now is gone, presumably after it drifted from the crumbling Ephyra streets in search here of a target too important to pass up." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3661", Text = "That Cutthroat came for me." },
						},
					},
				},
			},
		},		
	},

	BaseF_Combat =
	{
		InheritFrom = { "BaseF" },
		DebugOnly = true,
		AllowAnomalyReplacement = true,
	},

	F_Combat01 =
	{
		InheritFrom = { "BaseF_Combat" },

		EntranceDirection = "Right",

		ForceIfEncounterNotCompleted = "FIntroFight",
		LegalEncounters = { "FIntroFight", "GeneratedF", },

		IneligibleRewards = { "Devotion" },
		ForcedRewardStore = "RunProgress",
		ForcedRewards =
		{
			{
				Name = "Boon",
				LootName = "ApolloUpgrade",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
				},
			},
		},
		ForceCommonLootFirstRun = true,
		--ForceLootTableFirstRun = { "AthenaWeaponTrait", "AthenaRushTrait", "AthenaRangedTrait" },
		ForceLootTableFirstRun = { "ApolloWeaponBoon", "ApolloSprintBoon", "ApolloManaBoon" },
		
		FlipHorizontalChance = 0.0,
		ZoomFraction = 0.8,

		DistanceTriggers =
		{
			-- Intro
			{
				TriggerGroup = "GroundEnemies", WithinDistance = 600,
				TriggerOnceThisRun = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 0,
					},
				},
				VoiceLines =
				{
					PreLineWait = 0.01,
					UsePlayerSource = true,
					{ Cue = "/VO/Melinoe_1612", Text = "Lost Souls. I'll make the Titan pay." },
				},
			},
		},
		
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},
	},

	F_Combat02 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Left",
		ZoomFraction = 0.9,
		
		HasFishingPoint = false,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat03 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",
		ZoomFraction = 0.8,
		
		HasFishingPoint = false,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat04 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Right",
		ZoomFraction = 0.9,
		
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},

		InspectPoints =
		{
			[560954] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 3,
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_Cocytus_01 =
					{
						{ Cue = "/VO/Storyteller_0166",
							Text = "{#Emph}The River Cocytus winds through endless misty passageways, the wailing souls within its languid waters all denied their eternal rest." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_0856", Text = "Reminds me of home!" },
						},
					},
				},
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat05 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",
		ZoomFraction = 0.85,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat06 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Left",
		ZoomFraction = 0.85,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat07 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Left",
		ZoomFraction = 0.85,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat08 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",
		ZoomFraction = 0.85,
		
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat09 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",
		ZoomFraction = 0.9,

		HasFishingPoint = false,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 4,
			},
		},
	},

	F_Test =
	{
		InheritFrom = { "BaseF" },
		DebugOnly = true,
	},

	F_Combat10 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Left",
		ZoomFraction = 0.9,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},

		RushMaxRangeOverride = 525,
	},

	F_Combat11 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",
		ZoomFraction = 0.85,

		RushMaxRangeOverride = 525,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},

		InspectPoints =
		{
			[587136] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "InspectPoint" },
					},
				},
				InteractTextLineSets =
				{
					Inspect_VastRiches_01 =
					{
						{ Cue = "/VO/Storyteller_0131", Text = "{#Emph}The Underworld of Hades holds more than the souls of the dead: riches beyond imagination; even the remains of the deathless Titans." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1681", Text = "They'll end up back where they belong." },
						},
					},
				},
			},
		},

	},

	F_Combat12 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Right",
		ZoomFraction = 0.83,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},		
	},

	F_Combat13 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",
		ZoomFraction = 0.85,

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},

		InspectPoints =
		{
			[587137] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "ArtemisCombatIntro", "ArtemisCombatF" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					InspectArtemis01 =
					{
						{ Cue = "/VO/Storyteller_0079",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}Whilst the pale Moon's slender fingertips scarcely reach mournful Erebus, the goddess of the hunt can effortlessly navigate those woods." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_1429", Text = "She's good, I'll give her that." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Artemis_Field_01",
								{ Cue = "/VO/Artemis_0062", Text = "Hm." },
							},
						},
					},
				},
			},
		},

	},
	F_Combat14 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Left",
		ZoomFraction = 0.80,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},
	F_Combat15 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Left",
		ZoomFraction = 0.85,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},
	F_Combat16 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Right",
		ZoomFraction = 0.85,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat17 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",
		ZoomFraction = 0.79,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat18 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Right",
		ZoomFraction = 0.85,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "ErebusExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	F_Combat19 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},
	},

	F_Combat20 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "LeftRight",
		FishingPointRadii =
		{
			[571028] = 300,
		},
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 5,
			},
		},
	},

	F_Combat21 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Right",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},
	},

	F_Combat22 =
	{
		InheritFrom = { "BaseF_Combat" },
		EntranceDirection = "Right",

		HasFishingPoint = false,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = "<=",
				Value = 5,
			},
		},
	},

	F_PreBoss01 =
	{
		InheritFrom = { "BaseF" },

		LinkedRooms = { "F_Boss01", "F_Boss02" },

		ForceAtBiomeDepthMin = 10,
		ForceAtBiomeDepthMax = 10,

		GameStateRequirements =
		{
			-- None
		},
		
		SecretSpawnChance = 0.0,

		--ShovelPointChance = 0.4, -- moved to F_Boss
		--PickaxePointChance = 0.4, -- moved to F_Boss
		ExorcismPointChance = 0.3,
		FishingPointChance = 0.3,

		WellShopSpawnChance = 0.0,
		ChallengeSpawnChance = 0.0,

		SkipLastKillPresentation = true,

		ZagContractRewardDestinationId = 776332,

		LegalEncounters = { "Shop" },
		ForcedFirstReward = "Shop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomMoneyDrop", },
		SpawnRewardOnId = 561331,

		DisableRewardMagnetisim = true,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,

		ObstacleData =
		{
			
		},

		IgnoreStemMixer = true,
		MusicMutedStems = { "Drums", "Bass", "Guitar", },

		InspectPoints =
		{
			[566373] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache" },
						SumOf = { "F_Boss01", "F_Boss02" },
						Comparison = ">=",
						Value = 2,
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_PreBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0114", IsNarration = true,
							Text = "{#Emph}Ahead, the Underworld Princess shall again confront the one who raised her, and taught to her the means by which she may prevail..." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1431", Text = "There's always more to learn." },
						},
					},
				},
			},

		},

	},

	F_Boss01 =
	{
		InheritFrom = { "BaseF" },
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = "<",
					Value = 1,
				},
			},
		},

		RequiresLinked = true,
		LinkedRoom = "F_PostBoss01",
		ExitPreviewAnim = "ExitDownPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",

		BackupCauseOfDeath = "Hecate",
		
		HasFishingPoint = false,
		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters =
		{
			"BossHecate01",
			-- @ ending
			"BossHecateKidnapping",
			"BossHecateMissing",
		},
		ForcedReward = "MixerFBossDrop",
		IgnoreForRewardStoreCount = true,
		NoReroll = true,

		EntranceFunctionName = "RoomEntranceBoss",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 510167 },
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,
		ZoomFraction = 0.8,
		FlipHorizontalChance = 0.0,

		StartUnthreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Selene" },
				},
			},
			-- @ ending
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Chronos" },
				},
				GameStateRequirements =
				{
					NamedRequirements = { "NearTrueEnding" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
			},
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 510167 },
					SetupBossIds = { 510167 },
					DelayedStart = true,
					SkipAngleTowardTarget = true,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecate01" },
					},
				},
			},
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					ExitFunctionName = "EndEarlyAccessPresentation",
					SkipLoadNextMap = true,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "ConfigOptionCache", "DemoMode" },
					},
				},
			},
			-- @ ending
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 510167 },
					DelayedStart = true,
					SkipAngleTowardTarget = true,
					SkipBossMusic = true,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecateKidnapping" },
					},
				},
			},
			{
				FunctionName = "HecateKidnappingExitPresentation",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecateKidnapping" },
					},
				},
			},
			{
				FunctionName = "HecateMissingPresentation",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecateMissing" },
					},
				},
			},
		},

		PostCombatReloadEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					ExitFunctionName = "EndEarlyAccessPresentation",
					SkipLoadNextMap = true,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "ConfigOptionCache", "DemoMode" },
					},
				},
			},
		},

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", Args = { StartingCountMin = 0, StartingCountMax = 8, ObjectNames = { "ShadeMerc" }, MaxActive = 8 } },
			{ FunctionName = "RespawningCoverManager", Args = { RespawnInterval = 7.0, ObjectsPerIntervalMin = 5, ObjectsPerIntervalMax = 5, MaxActive = 25, StartingCountMin = 0, StartingCountMax = 15, CoverObjectNames = { "RespawningCover" } } },
			{ FunctionName = "HecateLightTorches", Args = {},
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NearTrueEnding", "HecateMissing" },
				},
			},
		},

		EnterVoiceLines =
		{
			{ GlobalVoiceLines = "HecateBossGreetingLines" },
		},

		InspectPoints =
		{
			[560570] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Chronos_01", },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_F_Boss01_01 =
					{
						{ Cue = "/VO/Storyteller_0045",
							Text = "{#Emph}Beneath the outer edge of Erebus extends a hidden region of the Underworld, known only to few, and navigable only by fewer still." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_0859", Text = "Let's hope so." },
						},
					},
				},
			},
		},

	},

	F_Boss02 =
	{
		InheritFrom = { "BaseF" },
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = ">=",
					Value = 1,
				},
			},
		},

		HecateStageTransitionPoint = 585238,

		SpeakerName = { "Selene" },

		RequiresLinked = true,
		LinkedRoom = "F_PostBoss01",
		ExitPreviewAnim = "ExitDownPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",

		BackupCauseOfDeath = "Hecate",
		
		--HasFishingPoint = false,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters =
		{
			"BossHecate02",
			-- @ ending
			"BossHecateKidnapping",
			"BossHecateMissing"
		},
		ForcedReward = "MixerFBossDrop",
		IgnoreForRewardStoreCount = true,
		NoReroll = true,

		EntranceFunctionName = "RoomEntranceBoss",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 571032 },
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,
		ZoomFraction = 0.8,
		FlipHorizontalChance = 0.0,

		StartUnthreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Selene" },
				},
			},
			-- @ ending
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Chronos" },
				},
				GameStateRequirements =
				{
					NamedRequirements = { "NearTrueEnding" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
			},
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 571032 },
					SetupBossIds = { 571032 },
					SetupUnitTypeAIs = { "HecateCopyEM" },
					DelayedStart = true,
					SkipAngleTowardTarget = true,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecate02" },
					},
				},
			},
			-- @ ending
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 571032 },
					DelayedStart = true,
					SkipAngleTowardTarget = true,
					SkipBossMusic = true,
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecateKidnapping" },
					},
				},
			},
			{
				FunctionName = "HecateKidnappingExitPresentation",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecateKidnapping" },
					},
				},
			},
			{
				FunctionName = "HecateMissingPresentation",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecateMissing" },
					},
				},
			},
		},

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", Args = { StartingCountMin = 0, StartingCountMax = 8, ObjectNames = { "ShadeMerc" }, MaxActive = 8 } },
			{ FunctionName = "RespawningCoverManager", Args = { RespawnInterval = 7.0, ObjectsPerIntervalMin = 5, ObjectsPerIntervalMax = 5, MaxActive = 25, StartingCountMin = 0, StartingCountMax = 15, CoverObjectNames = { "RespawningCover" } } },
			{ FunctionName = "SpawnHecateClones", Args = { Delay = 1.5 },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsAny = { "BossHecate02" },
					},
				},
			},
		},

		InspectPoints =
		{
			[793319] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_F_Boss02_01 =
					{
						{ Cue = "/VO/Storyteller_0419",
							Text = "{#Emph}Having revealed more of her vast experience, the Witch of the Crossroads leaves the Princess of the Dead to contemplate the limits of the knowledge she has gained." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3612", Text = "She must know so much..." },
						},
					},
				},
			},
			[793320] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_F_Boss02_01" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					Inspect_F_Boss02_02 =
					{
						{ Cue = "/VO/Storyteller_0454",
							Text = "{#Emph}Perhaps only the Moon herself can see this exceptionally hidden grove bordering Erebus, wherein practitioners of ancient sorcery may hone their craft to the fullest." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3652", Text = "I'm seeing it just fine." },
						},
					},
				},
			},
		},

		EnterVoiceLines =
		{
			{ GlobalVoiceLines = "HecateBossGreetingLines" },
		},

	},

	F_PostBoss01 =
	{
		InheritFrom = { "BaseF" },
		RichPresence = "#RichPresence_PostBossUnderworld",
		LegalEncounters = { "Story_Chronos_01" },

		-- HasHarvestPoint = false,
		-- HasShovelPoint = false,
		-- HasPickaxePoint = false,
		HasFishingPoint = false,
		-- HasExorcismPoint = false,

		-- UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,

		GameStateRequirements =
		{
			-- None
		},

		RequiresLinked = true,
		NextRoomSet = { "G", },
		ExitPreviewAnim = "ExitDownPreview",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		Ambience = "/Leftovers/Ambience/CreepyHauntedWindLoop",
		EntranceDirection = "Right",
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
		 
		SecretSpawnChance = 0.0,
		ForceWellShop = true,
		WellShopChallengeBaseId = 480768,
		SellTraitShrineUpgrade = true,
		SpeakerName = "Intercom",

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

		DistanceTriggers =
		{
			-- Tent Dim
			{
				TriggerGroup = "FloorExit", WithinDistance = 200, FunctionName = "PostBossSecondFloorPresentation", Repeat = true,
			},
			{
				TriggerGroup = "FloorEntrance", WithinDistance = 250, FunctionName = "PostBossFirstFloorPresentation", Repeat = true,
			},
		},

		ObstacleData =
		{
			[557482] =
			{
				Template = "HealthFountainF",
				Activate = true,
				SetupGameStateRequirements =
				{
					-- None
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
			[480768] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossWellShops" },
					},
				},
				InteractDistance = 200,
			},
			[755023] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossSellTraitShops" },
					},
				},
			},
		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "EndAllBiomeStates" },
			{ FunctionName = "PostBossFirstFloorPresentation" },
		},
		ThreadedEvents =
		{
			-- { FunctionName = "HadesSpeakingPresentation", Args = { VoiceLines = { GlobalVoiceLines = "HadesPostBossVoiceLines" }, StartDelay = 2 } },
		},

		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				PlayOnceContext = "LeavingErebusHecateMissingVO",
				PreLineWait = 2.6,
				BreakIfPlayed = true,
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					NamedRequirements = { "HecateMissing" },
				},

				{ Cue = "/VO/MelinoeField_4269", Text = "Hold on, Headmistress...", IgnoreMute = true },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "LeavingErebusPostEndingIntroVO",
				PreLineWait = 2.6,
				BreakIfPlayed = true,
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 561902, 772130 }, Alive = false },
					},
				},

				{ Cue = "/VO/MelinoeField_4584", Text = "Retracing my past steps..." },
			},
			{
				PreLineWait = 2.8,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.25,
				SuccessiveChanceToPlayAll = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 561902, 772130 }, Alive = false },
					},
				},

				{ Cue = "/VO/MelinoeField_0109", Text = "The pathways down...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0110", Text = "At last..." },
				{ Cue = "/VO/MelinoeField_0111", Text = "Out of Erebus..." },
				{ Cue = "/VO/MelinoeField_0117", Text = "No one's here..." },
				{ Cue = "/VO/MelinoeField_0118", Text = "All quiet..." },
				{ Cue = "/VO/MelinoeField_4584", Text = "Retracing my past steps...",
					GameStateRequirements =
					{
						{
							SumPrevRuns = 8,
							Path = { "SpeechRecord", "/VO/MelinoeField_4584" },
							CountPathTrue = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0112", Text = "{#Emph}Whew.",
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = "<=", Value = 0.7, },
						},
					},
				},
			},
		},
		ExitVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				BreakIfPlayed = true,
				ObjectType = "NPC_Chronos_01",
				SuccessiveChanceToPlayAll = 0.5,
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 4 },
				},

				{ Cue = "/VO/Chronos_0940", Text = "Rude..." },
				{ Cue = "/VO/Chronos_0941", Text = "...Fine." },
				{ Cue = "/VO/Chronos_0942", Text = "I shall not be ignored!" },
				{ Cue = "/VO/Chronos_0943", Text = "Ignore me if you wish." },
				{ Cue = "/VO/Chronos_0944", Text = "Come back here...!" },
				{ Cue = "/VO/Chronos_0945", Text = "Go on then, girl!", PlayFirst = true },
			},
			{
				PreLineWait = 0.5,
				RandomRemaining = true,
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "NPC_Chronos_01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "HecateBossKidnapped01" },
					},
				},
				Cooldowns =
				{
					{ Name = "LeftBiomeSpeech", Time = 6 },
				},

				{ Cue = "/VO/MelinoeField_0119", Text = "Farewell, Erebus." },
				{ Cue = "/VO/MelinoeField_0120", Text = "Down I go." },
				{ Cue = "/VO/MelinoeField_0121", Text = "Going down." },
				{ Cue = "/VO/MelinoeField_0122", Text = "Heading in." },
				{ Cue = "/VO/MelinoeField_0123", Text = "Beginning descent.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0124", Text = "Into the depths." },
				{ Cue = "/VO/MelinoeField_0125", Text = "Onward." },
				{ Cue = "/VO/MelinoeField_0126", Text = "Closer to Tartarus..." },
			},
		},

		LeavePostPresentationEvents =
		{
			{
				FunctionName = "BiomeMapPresentation",
				Args =
				{
					HeroStartOffsetX = -680,
					HeroStartOffsetY = 580,

					FamiliarStartOffsetX = -800,
					FamiliarStartOffsetY = 580,

					HeroMoveOffsetX = 745,
					HeroMoveOffsetY = 285,
					HeroMoveDuration = 1.4,

					FamiliarMoveOffsetX = 745,
					FamiliarMoveOffsetY = 285,
					FamiliarMoveDuration = 1.4,

					MoveEaseIn = 0.5,
					MoveEaseOut = 1.0,

					BiomeStart = "BiomeF",
					BiomeEnd = "BiomeG",
					PreviousBiomes = { },

					AdditionalFirstTimeWait = 1.15,

					ShrineBounty = "BossScylla01",

					--CrossroadsStart = true,
					
				},
				GameStateRequirements =
				{
					-- None
				}
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
					{
						PathTrue = { "GameState", "RoomCountCache", "G_Intro", },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 561902, 772130 }, Alive = false },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_PostBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0014",
							Text = "{#Emph}Far below, down in the deepest reaches of the Underworld, awaits the ancient foe of saffron-veiled goddess Melinoë." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							-- You'll help me find him.
							{ Cue = "/VO/Melinoe_0405", Text = "You'll help me find him." },
						},
					},
				},
			},
		},
	},

	F_Shop01 =
	{	
		InheritFrom = { "BaseF" },
		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 4,
		ForceAtBiomeDepthMax = 6,
		LegalEncounters = { "Shop" },
		ForcedReward = "Shop",
		StoreDataName = "WorldShop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		NoReroll = true,

		ZagContractDestinationId = 776331,
		FlipZagContract = true,

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredMinExits",
				FunctionArgs = { Count = 2 },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<=",
				Value = 6,
			},
		},

		SpawnRewardOnId = 486418,
		DisableRewardMagnetisim = true,

		ZoomFraction = 0.83,
		FlipHorizontalChance = 0.0,

		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,
		ExorcismPointChance = 0.3,
		FishingPointChance = 0.3,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		EntranceDirection = "LeftRight",

		-- Ambience = "/Leftovers/Object Ambiences/ShipwreckAmbience",
		SpawnRewardGlobalVoiceLines = "FoundShopVoiceLines",

		InspectPoints =
		{
			[561089] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Charon_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_Shop01_01 =
					{
						{ Cue = "/VO/Storyteller_0113", Text = "{#Emph}The Boatman Charon, one-time steward of the dead, now sculls the rivers of the Underworld in aid of those who yet resist the Titan Lord." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1430", Text = "What would we do without him?" },
						},
					},
				},
			},
		},
	},

	F_Reprieve01 =
	{
		InheritFrom = { "BaseF" },
		IneligibleRewards = { "Devotion", },
		-- SuppressRewardSpawnSounds = true,
		
		MaxCreationsThisRun = 1,
		LegalEncounters = { "HealthRestore" },
		EntranceDirection = "LeftRight",
		SecretMusic = "/Music/BlankMusicCue",
		--ZoomFraction = 0.75,
		FlipHorizontalChance = 0.0,
		SpawnRewardOnId = 40055,
		DisableRewardMagnetisim = true,
		IntroSequenceDuration = 0.02,

		HarvestPointChances = { 0.6, 0.4, },
		ShovelPointChance = 0.24,
		PickaxePointChance = 0.36,
		ExorcismPointChance = 0.24,
		FishingPointChance = 0.18,

		IgnoreHarvestBiomeSpawnLimit = true,

		ConditionalSubIcon = "RoomRewardSubIcon_FatedList",
		ConditionalSubIconRequirements =
		{
			{
				PathFalse = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
			},
			{
				Path = { "GameState", "RoomsEntered", "F_Reprieve01" },
				Comparison = ">",
				Value = 1,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", Args = { StartingCountMin = 3, StartingCountMax = 8, ObjectNames = { "ShadeMerc" }, MaxActive = 8 } },
			{ FunctionName = "RespawningCoverManager", Args = { RespawnInterval = 8.0, ObjectsPerIntervalMin = 4, ObjectsPerIntervalMax = 8, MaxActive = 50, StartingCountMin = 15, StartingCountMax = 30, CoverObjectNames = { "RespawningCover" } } },
			{ FunctionName = "ActivateFamiliar",
				GameStateRequirements =
				{
					-- raki appearance requirements
					{
						PathFalse = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
					},
					{
						Path = { "GameState", "RoomsEntered", "F_Reprieve01" },
						Comparison = ">",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				Args =
				{
					Id = 699334,
					Name = "RavenFamiliar",
					SkipAISetup = true,
					OverwriteSelf =
					{
						OnUsedFunctionName = "nil",
						SpecialInteractFunctionName = "RavenFamiliarSpecialInteractLockedInRun",
						PreRecruit = true,
						DistanceTriggers =
						{
							{
								WithinDistance = 550,
								PreTriggerFunctionName = "GenericPresentation",
								PreTriggerFunctionArgs =
								{
									SetAnimation = "Familiar_Raven_Perched",
									AngleTowardTarget = 586381,
								},
								FunctionName = "GenericPresentation",
								Args =
								{
									PreWait = 0.0,
									AngleTowardHero = true,
									SetAnimation = "Familiar_Raven_Victory_Perch",
									Sound = "/SFX/Familiars/RavenSquawk3",
									VoiceLines = { GlobalVoiceLines = "RavenReactionVoiceLines" },
								},
							},
						}
					},
				},
			},

		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeErebusReprieve" },
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

		MusicMutedStems = { "Drums" },
		EnterGlobalVoiceLines = "EnteredReprieveRoomVoiceLines",
		-- Ambience = "/Leftovers/Ambience/StillWaterAmbience",

		InspectPoints =
		{
			[560582] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					-- RequiredMinBiomeDepth = 4,
					-- RequiredMinCompletedRuns = 9999,
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_Reprieve01_01 =
					{
						{ Cue = "/VO/Storyteller_0046", IsNarration = true,
							Text = "{#Emph}Deep in the endless woods of Erebus lie secret clearings undiscoverable but through supernatural means." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_0860", Text = "I knew we'd find this place." },
						},
					},
				},
			},
			[566419] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_F_Reprieve01_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_Reprieve01_02 =
					{
						{ Cue = "/VO/Storyteller_0123", IsNarration = true,
							Text = "{#Emph}Most of the ancient edifices that once housed the dead awaiting judgment within Erebus have since been taken by the woods, or by decay." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1686", Text = "It must have been magnificent..." },
						},
					},
				},
			},
		},
	},

	-- NPC room layout 1
	F_Story01 =
	{
		InheritFrom = { "BaseF" },
		ForcedReward = "Story",
		NoReroll = true,
		MaxCreationsThisRun = 1,
		ForceIfUnseenForRuns = 3,
    AlwaysForce = true,
		IntroSequenceDuration = 0.9,

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
				Value = 8,
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "F_Boss01" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ArtemisFirstMeeting" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "ArtemisFirstMeeting" },
			},
			NamedRequirementsFalse = { "StandardPackageBountyActive" },
		},

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
						Path = { "GameState", "LifetimeResourcesGained", "PlantFMoly" },
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
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantFNightshadeSeed" },
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

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
						Comparison = "<",
						Value = 62,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},

		IgnoreHarvestBiomeSpawnLimit = true,

		SecretMusic = "/Music/IrisArachneTheme_MC",
		ZoomFraction = 0.9,
		TimerBlock = "StoryRoom",

		FlipHorizontalChance = 0.0,
		LegalEncounters = { "Story_Arachne_01" },
		EntranceDirection = "LeftRight",

		InspectPoints =
		{
			[557845] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_F_Story01_01 =
					{
						{ Cue = "/VO/Storyteller_0022",
							Text = "{#Emph}The intricately woven spider-silk ensconcing the environs of one gloom-filled recess within Erebus rivals in quality even the weavings of the gods themselves." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_0857", Text = "Arachne knows her stuff." },
							},
							{
								RandomRemaining = true,
								PreLineWait = 0.4,
								ObjectType = "NPC_Arachne_01",
								RequiredMinElapsedTime = 3,

								{ Cue = "/VO/Arachne_0336", Text = "{#Emph}Mm!" },
							}
						},
					},
				},
			},
		},

		ThreadedEvents =
		{
			{ FunctionName = "SetupArachneTheme" },
		},
	},

}

AddTableKeysCheckDupes( RoomData, RoomSetData.F )