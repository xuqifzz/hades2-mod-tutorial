RoomSetData.F =
{
	BaseF =
	{
		DebugOnly = true,
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Erebus",
		ResultText = "RunHistoryScreenResult_Erebus",

		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,

		LegalEncounters = EncounterSets.FEncountersDefault,
		DevotionEncounters = {"DevotionTestF"},
		TargetMetaRewardsRatio = 0.4,

		SecretSpawnChance = 0.10,
		WellShopSpawnChance = 0.25,
		--[[ @ handled in BaseRoom =
		SecretDoorRequirements =
		{
			NamedRequirements = { "ChaosUnlocked", "NoRecentChaosEncounter" },
		},
		]]--

		TimeChallengeSwitchSpawnChance = 0.20,
		TimeChallengeSwitchRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitches1" },
			},
			RequiredMinBiomeDepth = 5,
			RequiredMinRoomsSinceChallengeSwitch = 5,
		},
		TimeChallengeEncounterOptions = { "TimeChallengeF" },
		
		CapturePointSwitchSpawnChance = 0.0,
		CapturePointSwitchRequirements =
		{
			RequiredMinBiomeDepth = 5,
			RequiredMinRoomsSinceChallengeSwitch = 3,
		},
		CapturePointEncounterOptions = { "CapturePointF" },

		PerfectClearSwitchSpawnChance = 0.0,
		PerfectClearSwitchRequirements =
		{
			RequiredMinBiomeDepth = 5,
			RequiredMinRoomsSinceChallengeSwitch = 3,
		},
		PerfectClearEncounterOptions = { "PerfectClearChallengeF" },

		Ambience = "/Ambience/ErebusAmbientLoop",
		ShopSecretMusic = "/Music/CharonShopTheme",
		StopSecretMusic = true,

		LocationText = "Location_BiomeF",
		SaveProfileLocationText = "Location_BiomeF",
		-- NarrativeContextArt = "DialogueBackgroundBiome_Woods",

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

		StartThreadedEvents =
		{
			{ FunctionName = "ShadeMercManager", GameStateRequirements = { ChanceToPlay = 0.5 }, Args = { StartingCountMin = 0, StartingCountMax = 12, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
			{ FunctionName = "RespawningCoverManager", Args = { RespawnInterval = 10.0, ObjectsPerIntervalMin = 3, ObjectsPerIntervalMax = 5, MaxActive = 50, StartingCountMin = 50, StartingCountMax = 50, CoverObjectNames = { "RespawningCover" } } },
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

		HarvestPointChances =
		{
			0.0,
			0.0,
			0.0,
		},
		HarvestPointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
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

		PickaxePointChance = 0.0,
		PickaxePointForceRequirements =
		{
			{
				Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
				Comparison = "<=",
				Value = 5,
			}, 
		},

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
					-- don't spawn as ForcedReward just after unlocking daggers
					{
						PathFalse = { "PrevRun", "SpeechRecord", "/VO/Melinoe_0729" },
					},
				}
			},
			{
				Name = "Boon",
				LootName = "PoseidonUpgrade",
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "RoomRewardBonusBoon",
						Rarity = "Common",
					},
					{
						Type = "Trait",
						ItemName = "EncounterStartOffenseBuffBoon",
						Rarity = "Common",
					},
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "UseRecord", "PoseidonUpgrade" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PoseidonLegacyBoonIntro01" },
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
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonLegacyBoonIntro01" },
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
		},

		StartUnthreadedEvents =
		{
			{
				FunctionName = "ShowRunIntro",
				GameStateRequirements =
				{
					RequiredTrueConfigOptions = { "ShowUIAnimations", },
					RequiredFalseConfigOptions = { "EditingMode", },
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
				Args = { Text = "Location_BiomeF", Delay = 2.0, UseBiomeStateSubtitle = true, },
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

		StartThreadedEvents =
		{
			{ FunctionName = "CheckBiomeStateStart" },
			{ FunctionName = "ShadeMercManager", Args = { StartingCountMin = 3, StartingCountMax = 12, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
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
			[1] = GlobalVoiceLines.StartPackagedBountyRunVoiceLines,
			-- biome state changes
			[2] = GlobalVoiceLines.BiomeStateChangeStartVoiceLines,
			-- other general cases
			[3] = GlobalVoiceLines.TaskBegunVoiceLines,
		},

		ExitVoiceLines =
		{
			[1] = GlobalVoiceLines.StorytellerRunStartVoiceLines,
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
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						-- PathTrue = { "PrevRun", "RoomCountCache", "F_Boss01" },
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
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
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
						Path = { "GameState", "RoomCountCache", "F_Opening03", },
						Comparison = ">=",
						Value = 1,
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
							{ Cue = "/VO/Melinoe_1683", Text = "I'd not expected this one..." },
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
			RequiredFalseSeenRoomsThisRun = { "F_MiniBoss02" },
		},

		LegalEncounters = { "MiniBossTreant" },
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
			[1] = GlobalVoiceLines.MiniBossEncounterEndVoiceLines,
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
			RequiredFalseSeenRoomsThisRun = { "F_MiniBoss01" },
		},

		LegalEncounters = { "MiniBossFogEmitter" },
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
			[1] = GlobalVoiceLines.MiniBossEncounterEndVoiceLines,
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
						PathFalse = { "CurrentRun", "CurrentRoom", "ChallengeSwitch" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
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
		EntranceDirection = "Right",
		DebugOnly = true,
	},

	F_PreBoss01 =
	{
		InheritFrom = { "BaseF" },

		LinkedRoom = "F_Boss01",

		ForceAtBiomeDepthMin = 10,
		ForceAtBiomeDepthMax = 10,

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

		--[[ handled in the Shop encounter
		ExitVoiceLines =
		{
		},
		]]--

		InspectPoints =
		{
			[566373] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "F_Boss01" },
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

		RequiresLinked = true,
		LinkedRoom = "F_PostBoss01",
		ExitPreviewAnim = "ExitDownPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",
		
		HasFishingPoint = false,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossHecate01", },
		ForcedReward = "MixerFBossDrop",
		IgnoreForRewardStoreCount = true,
		NoReroll = true,

		EntranceFunctionName = "RoomEntranceBoss",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 510167 },
		IntroSequenceDuration = 2.7,
		BlockCameraReattach = true,
		ZoomFraction = 0.8,
		FlipHorizontalChance = 0.0,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 510167 },
					SetupBossIds = { 510167 },
					PreTextLinesWaitTime = 0.5,
					DelayedStart = true,
					SkipAngleTowardTarget = true,
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
			{ FunctionName = "ShadeMercManager", Args = { StartingCountMin = 0, StartingCountMax = 12, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
			{ FunctionName = "RespawningCoverManager", Args = { RespawnInterval = 7.0, ObjectsPerIntervalMin = 5, ObjectsPerIntervalMax = 5, MaxActive = 25, StartingCountMin = 0, StartingCountMax = 15, CoverObjectNames = { "RespawningCover" } } },
		},

		EnterVoiceLines =
		{
			{
				-- RandomRemaining = true,
				PreLineWait = 1.0,
				PlayOnce = true,
				PlayOnceContext = "HecateBossFirstVO",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Hecate" },
						Comparison = "<=",
						Value = 5,
					}, 
				},

				{ Cue = "/VO/Melinoe_0036", Text = "Headmistress..." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlayAll = 0.66,
				ObjectType = "Hecate",

				{ Cue = "/VO/Hecate_0487", Text = "There she is.", PlayFirst = true },
				{ Cue = "/VO/Hecate_0066", Text = "{#Emph}Ah." },
				{ Cue = "/VO/Hecate_0067", Text = "{#Emph}Hm." },
				{ Cue = "/VO/Hecate_0071", Text = "I sensed your presence." },
				{ Cue = "/VO/Hecate_0334", Text = "At last." },
				{ Cue = "/VO/Hecate_0336", Text = "Well, well." },
				{ Cue = "/VO/Hecate_0337", Text = "{#Emph}Hrm..." },
				{ Cue = "/VO/Hecate_0338", Text = "Come forward." },
				{ Cue = "/VO/Hecate_0483", Text = "Shall we?" },
				{ Cue = "/VO/Hecate_0484", Text = "Ready?" },
				{ Cue = "/VO/Hecate_0485", Text = "Breathe." },
				{ Cue = "/VO/Hecate_0486", Text = "There you are." },
				{ Cue = "/VO/Hecate_0488", Text = "Sure enough." },
				{ Cue = "/VO/HecateField_0179", Text = "Welcome." },
				{ Cue = "/VO/HecateField_0180", Text = "Hold." },
				{ Cue = "/VO/HecateField_0183", Text = "That was quick." },

				{ Cue = "/VO/Hecate_0068", Text = "Greetings, Witch.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
						},
					},
				},
				{ Cue = "/VO/Hecate_0070", Text = "There you are.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
						},
					},
				},
				{ Cue = "/VO/Hecate_0333", Text = "Prompt as ever.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
						},
					},
				},
				{ Cue = "/VO/Hecate_0335", Text = "Compose yourself.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
						},
					},
				},
				{ Cue = "/VO/Hecate_0069", Text = "Melinoë.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Hecate_0487" }
						},
					},
				},				
				{ Cue = "/VO/HecateField_0181", Text = "Not even a scratch!",
					PlayFirst = true,
					GameStateRequirements =
					{
						RequiredMinHealthFraction = 1.0,
					},
				},
				--[[
				{ Cue = "/VO/HecateField_0182", Text = "Fresh as rain.",
					PlayFirst = true,
					GameStateRequirements =
					{
						RequiredMinHealthFraction = 0.9,
					},
				},
				]]--
				{ Cue = "/VO/HecateField_0184", Text = "Descura...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
						},
					},
				},
				{ Cue = "/VO/HecateField_0185", Text = "Lim and Oros...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
						},
					},
				},
				{ Cue = "/VO/HecateField_0186", Text = "Ygnium...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
						},
					},
				},
				{ Cue = "/VO/HecateField_0187", Text = "Zorephet...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
						},
					},
				},
				{ Cue = "/VO/HecateField_0188", Text = "Revaal...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
						},
					},
				},

			},
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

	F_PostBoss01 =
	{
		InheritFrom = { "BaseF" },
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
		RichPresence = "#RichPresence_PostBoss",
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
		TimeChallengeSwitchSpawnChance = 0.0,
		WellShopSpawnChance = 1.0,
		 
		SecretSpawnChance = 0.0,
		ForceWellShop = true,
		SellTraitShrineUpgrade = true,
		SpeakerName = "Intercom",

		WellShopRequirements =
		{
			{
				-- PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossWellShops" },
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
			},
		},

		StartUnthreadedEvents =
		{
			{
				FunctionName = "PostBossFirstFloorPresentation",
			},
		},
		ThreadedEvents =
		{
			-- { FunctionName = "HadesSpeakingPresentation", Args = { VoiceLines = GlobalVoiceLines.HadesPostBossVoiceLines, StartDelay = 2 } },
			{ FunctionName = "ProcessInterest", Args = { StartDelay = 1 } },
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
					AreIdsNotAlive = { 561902 },
				},

				{ Cue = "/VO/MelinoeField_0109", Text = "The pathways down...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0110", Text = "At last..." },
				{ Cue = "/VO/MelinoeField_0111", Text = "Out of Erebus..." },
				{ Cue = "/VO/MelinoeField_0112", Text = "{#Emph}Whew." },
				{ Cue = "/VO/MelinoeField_0117", Text = "No one's here..." },
				{ Cue = "/VO/MelinoeField_0118", Text = "All quiet..." },
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
					PathFalse = { "CurrentRun", "UseRecord", "NPC_Chronos_01" },
				},
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

		LeavePostPresentationEvents =
		{
			--[[
			{
				FunctionName = "BiomeMapPresentation",
				Args =
				{
					StartOffsetX = -600,
					StartOffsetY = 500,

					HeroStartOffsetX = 100,
					HeroStartOffsetY = -200,

					MoveOffsetX = 600,
					MoveOffsetY = 300,
					MoveDuration = 2.0,
					MoveEaseIn = 0.5,
					MoveEaseOut = 1.0,
					
				},
				GameStateRequirements =
				{
					-- None
				}
			},
			]]
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
					AreIdsNotAlive = { 561902 },
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

		GameStateRequirements =
		{
			RequiredMinExits = 2,
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
		ExorcismPointChance = 0.4,

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
			{ FunctionName = "ShadeMercManager", Args = { StartingCountMin = 3, StartingCountMax = 12, ObjectNames = { "ShadeMerc" }, MaxActive = 12 } },
			{ FunctionName = "RespawningCoverManager", Args = { RespawnInterval = 8.0, ObjectsPerIntervalMin = 4, ObjectsPerIntervalMax = 8, MaxActive = 50, StartingCountMin = 15, StartingCountMax = 30, CoverObjectNames = { "RespawningCover" } } },
			{
				FunctionName = "ActivateFamiliar",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "O_Intro" },
					},
					{
						PathFalse = { "GameState", "LifetimeResourcesGained", "FamiliarPoints" },
					},
				},
				Args =
				{
					Id = 561081,
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
				Value = 9,
			},
		},

		ObstacleData =
		{
			[699330] =
			{
				Name = "CatFamiliarMIA",
				DistanceTriggers =
				{
					{
						WithinDistance = 350,
						VoiceLines =
						{
							PlayOnce = true,
							UsePlayerSource = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "UseRecord", "CatFamiliar" }
								},
								{
									PathFalse = { "GameState", "FamiliarStatus", "CatFamiliar", "Unlocked" },
								},
								AreIdsNotAlive = { 561081 },
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},
							{ Cue = "/VO/MelinoeField_2055", Text = "That cat must have moved on..." },
						},
					},
				},
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
		RichPresence = "#RichPresence_FStory01",
		HarvestBlockedText = "ExitBlockedByNPC",
		AllowExorcismPreExitsUnlock = true,

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
				Value = 9,
			},
			{
				PathTrue = { "GameState", "RoomsEntered", "F_Boss01" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ArtemisFirstMeeting" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty", },
			},
		},

		HarvestPointChances =
		{
			0.5,
			0.1,
		},
		ShovelPointChance = 0.4,
		PickaxePointChance = 0.4,
		ExorcismPointChance = 0.4,

		HarvestPointRequirements = { },
		ShovelPointRequirements = { },
		--PickaxePointRequirements = { },
		ExorcismPointRequirements = { },

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