ConstantsData.MinimumDifficulty = 10

WaveDifficultyPatterns =
{
	{ 1 },
	{ 0.5, 0.5 },
	{ 0.3, 0.15, 0.55 },
	{ 0.3, 0.1, 0.2, 0.4 },
	{ 0.25, 0.1, 0.15, 0.15, 0.35 },
}

TimerBlockCombatExcludes = 
{
	"ThanatosEncounter", "SurvivalEncounter", "ArtemisEncounter",
}

BaseWaveOverrideValues =
{
	RequireNearPlayerDistance = 1500,
	SpawnAggroed = true,
	IgnoreSpawnPreferences = true,
}

IntroWaveOverrideValues =
{
	ActiveEnemyCapBase = 2.3,
	ActiveEnemyCapMax = 8,
	ActiveEnemyCapDepthRamp = 0.35,
	SpawnIntervalMin = 0.175,
	SpawnIntervalMax = 0.225,
	RequireNearPlayerDistance = 750,
	SpawnAggroed = true,
	IgnoreSpawnPreferences = true,
}

EncounterData =
{
	NonCombat =
	{
		EncounterType = "NonCombat",
		SkipExitReadyCheckpoint = true,
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,
	},

	Empty =
	{
		InheritFrom = { "NonCombat" },
		SkipCombatBeginsVoiceLines = true,
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,
		ThreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SetSoundCueValues =
					{
						{
							Name = "Drums",
							Value = 0.0,
							AudioStateId = "MusicId",
							Duration = 1.0,
						}
					},
				},
			},
		},
	},

	O_Empty =
	{
		InheritFrom = { "Empty" },
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "RakiGift01", },
					},
				},
				Args =
				{
					{ FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Familiar_Raven_01" }, }
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "Familiar_Raven_01", WithinDistance = 700,
				FunctionName = "PlayEmoteSimple",
				Args =
				{
					AnimationName = "StatusIconFear",
				},
			},
			{
				TriggerObjectType = "Familiar_Raven_01", WithinDistance = 650,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					{
						BreakIfPlayed = true,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "Resources", "FamiliarPoints" },
								Comparison = ">=",
								Value = 1,
							},
							{
								Path = { "GameState", "UseRecord", "Familiar_Raven_01", },
								Comparison = ">=",
								Value = 1,
							},
						},

						{ Cue = "/VO/Melinoe_0248", Text = "Got something for you.", },
					},
					{
						BreakIfPlayed = true,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							--
						},
						{ Cue = "/VO/Melinoe_0827", Text = "Something there." },
						-- { Cue = "/VO/Melinoe_0825", Text = "Over there." },
						-- { Cue = "/VO/Melinoe_0577", Text = "Mm!" },
					},
				}
			}
		},
	},

	-- Generated Encounters
	Generated =
	{
		EncounterType = "Default",
		Generated = true,
		CountsForRoomEncounterDepth = true,
		PreSpawnEnemies = true,
		PreSpawnMinEndPointDistance = 750,
		GroupReinforcements = false,
		RemoveDistanceReqsForReinforcements = true,
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "HandleEncounterPreSpawns"
			}
		},

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,
		ActiveEnemyCapBase = 2.3,
		ActiveEnemyCapMax = 8,
		ActiveEnemyCapDepthRamp = 0.35,
		MinTypes = 1,
		MaxTypes = 2,
		MinWaves = 1,
		MaxWaves = 3,
		MaxTypesCap = 4,
		TypeCountDepthRamp = 0.20,
		BaseDifficulty = 30,
		DepthDifficultyRamp = 10,
		MetaPointStoreRamp = 0.5,
		MoneyDropCapMin = 10,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0.5,
		EnemySet = EnemySets.BiomeF,
		WaveStartPresentationFunction = "StartWavePresentation",
		BlockTypesAcrossWaves = true,

		Spawns = {},
		SpawnWaves = {},
		WaveTemplate =
		{
			Spawns =
			{

			},
			OverrideValues = BaseWaveOverrideValues,
			StartDelay = 1.0
		},
		NoFirstWaveStartDelay = true,

		ReinforcementsDataOverride =
		{
			RequireNearPlayerDistance = 750,
			SpawnAggroed = true,
		},

		PreSpawnSpawnOverrides =
		{
			WakeUpDelay = 0.3,
			--AggroReactionTimeMin = 1.15,
			--AggroReactionTimeMax = 1.35,
			AggroReactionTimeMin = 0.15,
			AggroReactionTimeMax = 0.45,
		},
	},

	GeneratedF =
	{
		InheritFrom = { "Generated" },
		EnemySet = EnemySets.BiomeF,
		SpawnIntervalMin = 0.200,
		SpawnIntervalMax = 0.400,
		ActiveEnemyCapBase = 3.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 0.35,
		MinTypes = 2,
		MaxTypes = 2,
		MinWaves = 1,
		--TypeCountDepthRamp = 0.10,
		TypeCountDepthRamp = 0.20,
		MaxTypesCap = 4,
		BaseDifficulty = 55,
		DepthDifficultyRamp = 15,
		MaxEliteTypes = 1,

		HardEncounterOverrideValues =
		{
			DepthDifficultyRamp = 30,
			MaxTypesCap = 4,
			ActiveEnemyCapDepthRamp = 0.60
			--EnemySet = EnemySets.BiomeF,
			--MaxEliteTypes = 5,
		},
	},

	-- Intro Encounters
	BaseIntroEncounter =
	{
		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,

		Generated = true,
		PreSpawnEnemies = true,
		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 2,

		EnemyCountDepthRamp = 0.0,
		ActiveEnemyCapBase = 3,
		ActiveEnemyCapDepthRamp = 0.35,
		DifficultyModifier = 0,
		DifficultyMultiplier = 2.0, -- this is to bulk up the second wave, since the first wave always has only 2 units
	},

	GuardIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedF" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Guard",
						CountMin = 3,
						CountMax = 3,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Guard",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		DistanceTriggers =
		{
			{
				Name = "GuardSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Guard.EnemyFirstEncounterVoiceLines,
			}
		},
	},

	RadiatorIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedF" },
		DifficultyModifier = 30,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Radiator",
						CountMin = 3,
						CountMax = 3,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Radiator",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		DistanceTriggers =
		{
			{
				Name = "RadiatorSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Radiator.EnemyFirstEncounterVoiceLines,
			}
		},
	},

	ScreamerIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedF" },
		DifficultyModifier = 20,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Screamer",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "Screamer",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		DistanceTriggers =
		{
			{
				Name = "ScreamerSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.Screamer.EnemyFirstEncounterVoiceLines,
			}
		},
	},

	SiegeVineIntro =
	{
		InheritFrom = { "BaseIntroEncounter", "GeneratedF" },
		DifficultyModifier = 45,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SiegeVine_Elite",
						CountMin = 1,
						CountMax = 1,
					},
				},
				StartDelay = 0
			},
		},

		WaveTemplate =
		{
			Spawns =
			{
				{
					Name = "SiegeVine_Elite",
					Generated = true
				}
			},
			StartDelay = 1,
			OverrideValues = IntroWaveOverrideValues,
			RequireCompletedIntro = true,
		},

		DistanceTriggers =
		{
			{
				Name = "SiegeVineSightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = EnemyData.SiegeVine.EnemyFirstEncounterVoiceLines,
			}
		},
	},

	-- Opening Encounters
	OpeningEmpty =
	{
		InheritFrom = { "NonCombat" },
		AlwaysForce = true,

		OnSpawnFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "UseRecord", "ApolloUpgrade" },
			},
		},

		StartRoomUnthreadedEvents =
		{
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
						"NemesisFieldFirstMeeting",
					},
				},
			},
		},

		UnthreadedEvents =
		{
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "PostCombatAudio" },
		}
	},

	OpeningGeneratedF =
	{
		InheritFrom = { "GeneratedF" },
		RequireCompletedIntro = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache", "OpeningEmpty" },
				Comparison = ">=",
				Value = 1,
			},
		},
		GroupReinforcements = false,
		MaxWaves = 1,
		DifficultyModifier = -20,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,
		DelayedStart = true,

		PreSpawnEnemies = false,
		
		UnthreadedEvents =
		{
			{
				FunctionName = "SpawnRoomReward",
				Args =
				{
					WaitUntilPickup = true,
				}
			},
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "BeginOpeningEncounter" },
			{ FunctionName = "HandleEnemySpawns" },
			{ FunctionName = "CheckForAllEnemiesDead" },
			{ FunctionName = "PostCombatAudio" },
		}
	},

	FIntroFight =
	{
		AlwaysForce = true,
		GameStateRequirements =
		{
			RequiredFalseTextLines = { "ApolloFirstPickUp" },
		},
		PreSpawnEnemies = true,

		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		SpawnWaves =
        {
            {
                Spawns =
                {
					{
						Name = "Brawler",
						CountMin = 1,
						CountMax = 1,
						SpawnOnId = 557598,
					},
                },
				StartDelay = 0,
				OverrideValues =
				{
					SpawnIntervalMin = 0.175,
					SpawnIntervalMax = 0.225,
				},
            },

			-- wave 2
			{
                Spawns =
                {
					{
						Name = "Guard",
						CountMin = 4,
						CountMax = 4,
						SpawnOnIds = { 557599, 557600, 557601, 557602, },
					},
                },
                StartDelay = 1,
				OverrideValues =
				{
					SpawnIntervalMin = 0.175,
					SpawnIntervalMax = 0.225,
				},
            },

			-- wave 3
			{
                Spawns =
                {
					{
						Name = "Mage",
						CountMin = 3,
						CountMax = 3,
						SpawnOnIds = { 557603, 557604, 557605, },
					},
                },
                StartDelay = 0.8,
				OverrideValues =
				{
					SpawnIntervalMin = 0.5,
					SpawnIntervalMax = 0.5,
				},
            },

			-- wave 4
			{
                Spawns =
                {
					{
						Name = "Brawler",
						CountMin = 1,
						CountMax = 1,
						SpawnOnId = 557604,
					},

					{
						Name = "Guard",
						CountMin = 3,
						CountMax = 3,
						SpawnOnIds = { 557606, 557608, 557607, },
					},

					{
						Name = "Mage",
						CountMin = 1,
						CountMax = 1,
						SpawnOnId = 557597,
					},
                },
                StartDelay = 0.9,
				OverrideValues =
				{
					SpawnIntervalMin = 0.225,
					SpawnIntervalMax = 0.275,
				},
            },
        },
	},

	FCastTutorialFight =
	{
		AlwaysForce = true,

		GameStateRequirements =
		{
            {
                Path = { "GameState", "EncountersCompletedCache", "OpeningEmpty" },
                Comparison = ">=",
                Value = 1,
            },
            {
                PathFalse = { "GameState", "EncountersCompletedCache", "FCastTutorialFight" },
            },
		},
        PreSpawnEnemies = false,

        ObjectiveSets = "FCastTutorialInCombat",

        UnthreadedEvents =
        {
            {
                FunctionName = "SpawnRoomReward",
                Args =
                {
                    WaitUntilPickup = true,
                }
            },
            { FunctionName = "EncounterAudio" },
            { FunctionName = "BeginOpeningEncounter" },
            { FunctionName = "HandleEnemySpawns" },
            { FunctionName = "CheckForAllEnemiesDead" },
            { FunctionName = "PostCombatAudio" },
        },

        SpawnIntervalMin = 0.175,
        SpawnIntervalMax = 0.225,
		SpawnWaves =
        {
            {
                Spawns =
                {
					{
						Name = "Guard",
						TotalCount = 10,
					},
                },
            },
        },

		StartVoiceLines =
		{
			PreLineWait = 2.6,
			PlayOnce = true,
			PlayOnceContext = "FCastTutorialVO",

			{ Cue = "/VO/MelinoeField_2061", Text = "All of you, gather 'round..." },
		},
	},

	-- Artemis F Encounters	
	BaseArtemisCombat =
	{
        AlwaysForce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ArtemisCombatIntro" },
			},
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "TalentDrop" },

		BlockFishingBeforeStart = true,
		BlockCodexBeforeStart = true,
		BlockLocationText = true,
		DelayedStart = true,
		-- SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		FastClearThreshold = 65,
		TimerBlock = "ArtemisEncounter",
		BlockHighlightEliteTypes = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsArtemisCombat,
		Using = { "NPC_Artemis_Field_01" },

		DifficultyModifier = 60,
		--DepthDifficultyRamp = 0,
		--BaseDifficulty = 150,
		ActiveEnemyCapBase = 7,
		ActiveEnemyCapMax = 7,
		ActiveEnemyCapDepthRamp = 0,
		TypeCountDepthRamp = 0,
		MinWaves = 4,
		MaxWaves = 4,
		MoneyDropCapMin = 30,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,

		WaveStartUnthreadedEvents =
		{
			{ FunctionName = "CheckArtemisSpawn", Args = { FirstWaveArtemisChance = 0.5, WaveSpawnDelay = 1.8 } },
		},
	},

	ArtemisCombatF =
	{
		InheritFrom = { "BaseArtemisCombat", "GeneratedF" },
	},

	ArtemisCombatF2 =
	{
		InheritFrom = { "ArtemisCombatF" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Artemis_Field_01" },
				Comparison = "<=",
				Value = 0,
			},
		},
	},

	-- like default encounter but occurs only once, with a higher chance
	ArtemisCombatIntro =
	{
		InheritFrom = { "ArtemisCombatF" },

		-- easier introduction moment
		DifficultyModifier = 40,

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "ArtemisCombatIntro" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneFirstMeeting" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "CurrentRun", "Hero", "Health" },
				Comparison = ">=",
				Value = 10,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			RequiredMinAnyTextLines = { TextLines = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "HestiaFirstPickUp", "AphroditeFirstPickUp", "HephaestusUpgrade" }, Count = 4 },
		},

		WaveStartUnthreadedEvents =
		{
			{ FunctionName = "CheckArtemisSpawn", Args = { FirstWaveArtemisChance = 0.0 } },
		},
	},
	
	-- Arache F Encounters
	BaseArachneCombat =
	{
		EncounterType = "ArachneCombat",
		SkipExitReadyCheckpoint = true,
		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "ManaUpgrade", "TalentDrop" },

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ArachneCombatF" },
			},
			{
				Path = { "CurrentRun", "EncountersOccurredBiomeCache" },
				HasNone = { "ArachneCombatF", "ArachneCombatG", "ArachneCombatN" },
			},
		},

		UnthreadedEvents = EncounterSets.EncounterEventsArachneCombat,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "SetupArachneCombatEncounter", Args = { CocoonCountMin = 8, CocoonCountMax = 14,
					CocoonOptions = { "ArachneCocoon", "ArachneCocoon", "ArachneCocoon",
						  "ArachneCocoonMedium", "ArachneCocoonMedium",
						  "ArachneCocoonLarge", }, } }
		},

		RequireCompletedIntro = true,
		PreSpawnEnemies = false,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		BlockRandomStems = true,
		MusicActiveStems = { "Guitar", "Bass", },

		OnSpawnFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",
		SpeakerName = "Arachne",
		Using = { "CocoonOptions" },

		EnterVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 1.0,
				PlayOnce = true,
				PlayOnceContext = "CocoonsInLaterBiomesIntro",

				{ Cue = "/VO/MelinoeField_0186", Text = "Those spiders get around...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "G", "H" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.33,

				{ Cue = "/VO/Melinoe_1717", Text = "Silk cocoons...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1718", Text = "Arachne was here...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "F", },
						},
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1719", Text = "Let's see what we can find..." },
				{ Cue = "/VO/Melinoe_1720", Text = "More cocoons..." },
				{ Cue = "/VO/MelinoeField_0185", Text = "The spiders got here first..." },
				{ Cue = "/VO/MelinoeField_0186", Text = "Those spiders get around...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "G", "H" },
						},
						{
							PathFalse = { "PrevRun", "SpeechRecord", "/VO/MelinoeField_0186" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0187", Text = "Arachne's handiwork...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "F", },
						},
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0188", Text = "Thank you, hidden spiderlings...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
			},
			{
				PreLineWait = 1.23,
				RandomRemaining = true,
				Queue = "Always",
				SuccessiveChanceToPlayAll = 0.5,
				Source = { LineHistoryName = "NPC_Arachne_01", SubtitleColor = Color.ArachneVoice },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F", },
					},
				},

				{ Cue = "/VO/Arachne_0362", Text = "{#Emph}<Laughter>", PlayFirst = true },
				{ Cue = "/VO/Arachne_0363", Text = "{#Emph}<Laughter>" },
				{ Cue = "/VO/Arachne_0364", Text = "{#Emph}<Laughter>" },
				{ Cue = "/VO/Arachne_0365", Text = "{#Emph}<Laughter>" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.4,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements =
				{
					{
						Path = { "LastLinePlayed" },
						IsAny = { "/VO/Arachne_0362", "/VO/Arachne_0363", "/VO/Arachne_0364", "/VO/Arachne_0365" },
					},
				},

				{ Cue = "/VO/Melinoe_1936", Text = "Who's there...?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1937", Text = "What was that...?" },
				{ Cue = "/VO/Melinoe_1938", Text = "Arachne...?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1939", Text = "That you, Arachne?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
				},
			}
		},
	},

	ArachneCombatF =
	{
		InheritFrom = { "BaseArachneCombat" },
		
		GameStateRequirements =
		{
			{
				Path = { "GameState", "EncountersCompletedCache" },
				HasAny = { "MiniBossTreant", "MiniBossFogEmitter", "BossHecate01" },
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
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			}, 
			{
				Path = { "CurrentRun", "EncountersOccurredBiomeCache" },
				HasNone = { "ArachneCombatF", "ArachneCombatG", "ArachneCombatN" },
			},
		},
	},


	-- MiniBoss Encounters
	MinibossEncounter =
	{
		EncounterType = "Miniboss",
		BlockSpawnMultipliers = true,
		BlockEliteAttributes = true,
		BlockNextBiomeEnemyShrineUpgrade = true,
	},

	MiniBossTreant =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedF" },
		PreSpawnEnemies = false,
		SpawnAggroed = true,

		MinWaves = 1,
		MaxWaves = 1,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 3,
		ActiveEnemyCapMax = 3,

		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.05,

		EndMusicOnCombatOver = 20,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "Treant",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
					},
				},
				StartDelay = 0.7,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "Treant" },
		WipeEnemiesOnKill = "Treant",
	},

	MiniBossFogEmitter =
	{
		InheritFrom = { "MinibossEncounter", "GeneratedF", },
		PreSpawnEnemies = true,
		SpawnAggroed = true,

		MinWaves = 2,
		MaxWaves = 2,
		MinTypes = 1,
		MaxTypes = 1,
		TypeCountDepthRamp = 0,
		EnemyCountDepthRamp = 0,
		MaxEliteTypes = 2,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMin = 10,
		ActiveEnemyCapMax = 10,

		SpawnIntervalMin = 0.02,
		SpawnIntervalMax = 0.02,

		EndMusicOnCombatOver = 20,

		MoneyDropCapMin = 15,
		MoneyDropCapMax = 15,
		MoneyDropCapDepthRamp = 0,

		BlockHighlightEncounter = true,
		SkipIntroEncounterCheck = true,
		NoFirstWaveStartDelay = false,

		ManualWaveTemplates =
		{
			-- Wave 1
			[1] =
			{
				Spawns =
				{
					{
						Name = "FogEmitter_Elite",
						TotalCount = 1,
						SpawnOnIds = { 40191 },
						ForceFirst = true,
					},
				},
				SkipWaitForAllDead = true
			},
			[2] =
			{
				Spawns =
				{
					{
						Name = "SiegeVine",
						TotalCount = 2,
						SpawnOnIds = { 558168, 558195, 558169, 558165, 558194, 558166, }
					},
				},
				StartDelay = 3.0,
			},
		},

		StartGlobalVoiceLines = "MiniBossEncounterStartVoiceLines",
		CancelSpawnsOnKill = { "FogEmitter_Elite" },
		--WipeEnemiesOnKill = "FogEmitter_Elite",
	},

	-- Boss Encounters
	BossEncounter =
	{
		EncounterType = "Boss",
		BlockSpawnMultipliers = true,
		BlockRespawnShrineUpgrade = true,
		ActiveEnemyCapMax = 7,
		
		UnthreadedEvents = EncounterSets.EncounterEventsDefault
	},

	BossHecate01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		WipeEnemiesOnKill = "Hecate",
		SkipLastKillPresentation = true,
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Hecate" }, IgnoreAI = true, SkipPresentation = true, } },
		},
	},

	HecateSpawns01 =
	{
		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 5,
		BlockSpawnMultipliers = true,

		UnthreadedEvents = EncounterSets.EncounterEventsBossSpawnedEncounter,

		UseRoomEncounterEnemySet = true,

		WaveStartPresentationFunction = "StartWavePresentation",
		SkipNextWaveVoicelines = true,
		AllAddsDeadGlobalVoiceLines = "HecateAddsDeadVoiceLines",

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightRanged",
						TotalCount = 4,
						SpawnOnIds = { 566514, 566516, 566519, 566512, 566511, 566513, 566518, 566517, 566515, 566520, },
					},
				},
				StartDelay = 4.0, -- Need to give time for HecateCopys to clear (bones budget)
				StartGlobalVoiceLines = "HecateBossSpawnWaveVoiceLines",
			},
		},
	},

	HecateSpawns02 =
	{
		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 10,
		BlockSpawnMultipliers = true,

		UnthreadedEvents = EncounterSets.EncounterEventsBossSpawnedEncounter,

		UseRoomEncounterEnemySet = true,

		WaveStartPresentationFunction = "StartWavePresentation",
		SkipNextWaveVoicelines = true,
		AllAddsDeadGlobalVoiceLines = "HecateAddsDeadVoiceLines",

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "LightRanged",
						TotalCount = 8,
						SpawnOnIds = { 566514, 566516, 566519, 566512, 566511, 566513, 566518, 566517, 566515, 566520, },
					},
				},
				StartDelay = 4.0, -- Need to give time for HecateCopys to clear (bones budget)
				StartGlobalVoiceLines = "HecateBossSpawnWaveVoiceLines",
			},
		},
	},

	HecatePassiveSpawns01 =
	{
		SpawnIntervalMin = 5,
		SpawnIntervalMax = 7,
		EnemyCountDepthRamp = 0,
		ActiveEnemyCapBase = 1.5, -- Hecate + 1 guard (guard is worth 0.5)
		ActiveEnemyCapMax = 1.5,
		EndMusicOnCombatOver = 20,
		SpawnAggroed = true,
		SkipLastKillPresentation = true,
		SkipIntroEncounterCheck = true,
		MoneyDropCapMin = 20,
		MoneyDropCapMax = 20,
		MoneyDropCapDepthRamp = 0,
		FastClearThreshold = 55,
		MinTypes = 1,
		MaxTypes = 1,

		UnthreadedEvents = EncounterSets.EncounterEventsBossSpawnedEncounter,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Guard",
						InfiniteSpawns = true,
					},
				},
				StartDelay = 4.0,
			},
		},
	},

	HecatePassiveSpawns02 =
	{
		InheritFrom = { "HecatePassiveSpawns01" },
		SpawnIntervalMin = 1.5,
		SpawnIntervalMax = 2.0,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Guard",
						InfiniteSpawns = true,
					},
				},
				StartDelay = 4.0,
			},
		},
	},

	-- Story_Encounters
	Story_Arachne_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},

		OnSpawnFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Arachne_01" }, } },
			{ FunctionName = "CheckConversations" },
			{ FunctionName = "SpawnArachneCocoons", Args = { CocoonCountMin = 0, CocoonCountMax = 3, CocoonOptions = { "ArachneCocoonMedium", "ArachneCocoon" } } }
		},

		StartVoiceLines =
		{
			-- The strum of music brought him to an unexpected sight...
			-- { Cue = "", Text = "TODO(BuildText) Storyteller_0079", PreLineWait = 1.5, PlayOnce = true },
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.33,
				SuccessiveChanceToPlay = 0.8,
				ObjectType = "NPC_Arachne_01",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.ArachneUpsetEvents,
					},
				},

				{ Cue = "/VO/Arachne_0299", Text = "Farewell, my friend!" },
				{ Cue = "/VO/Arachne_0300", Text = "Farewell..." },
				{ Cue = "/VO/Arachne_0301", Text = "Goodbye for now!" },
				{ Cue = "/VO/Arachne_0302", Text = "Come back soon...!" },
				{ Cue = "/VO/Arachne_0303", Text = "Do be careful out there!" },
				{ Cue = "/VO/Arachne_0304", Text = "Do come again, won't you?" },
				{ Cue = "/VO/Arachne_0305", Text = "I'll be right here, all right?" },
				{ Cue = "/VO/Arachne_0306", Text = "You truly do look great!" },
				{ Cue = "/VO/Arachne_0307", Text = "To your success!", PlayFirst = true },
				{ Cue = "/VO/Arachne_0308", Text = "Away she goes..." },
				{ Cue = "/VO/Arachne_0309", Text = "Alone again... {#Emph}ha ha ha..." },
				{ Cue = "/VO/Arachne_0310", Text = "{#Emph}<Sigh>" },
			},
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.66,
				PreLineWait = 0.33,

				{ Cue = "/VO/Melinoe_1764", Text = "Weave on." },
				{ Cue = "/VO/Melinoe_1765", Text = "Until we meet again." },
				{ Cue = "/VO/Melinoe_1766", Text = "Keep on spinning." },
				{ Cue = "/VO/Melinoe_1767", Text = "Be well, all right?" },
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Arachne_01", WithinDistance = 800,
				LeaveDistanceBuffer = 60,

				VoiceLines =
				{
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.66,
					UsePlayerSource = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 60 },
					},

					{ Cue = "/VO/Melinoe_0830", Text = "Oh.", PlayFirst = true },
					{ Cue = "/VO/Melinoe_1092", Text = "Arachne!" },
					{ Cue = "/VO/Melinoe_1093", Text = "Hi, Arachne." },
					{ Cue = "/VO/Melinoe_1406", Text = "Arachne's fineries..." },
				},

			},
		},
	},
}