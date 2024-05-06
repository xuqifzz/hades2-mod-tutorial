OverwriteTableKeys( EncounterData,
{
	BaseNemesisCombat =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisGetFreeItemIntro01" },
			},
			{
				Path = { "CurrentRun", "EncountersOccurredCache" },
				HasNone = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH" },
			},			
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "ManaUpgrade", "TalentDrop" },

		SkipExitReadyCheckpoint = true,

		BlockFishingBeforeStart = true,
		BlockCodexBeforeStart = true,
		DelayedStart = true,
		-- SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		FastClearThreshold = 65,
		TimerBlock = "ArtemisEncounter",
		BlockHighlightEliteTypes = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsNemesisCombat,
		Using = { "NPC_Nemesis_01" },

		StartRoomThreadedEvents =
		{
			{ FunctionName = "HandleNemesisCombatSpawn" },
		},

		ObjectiveSets = "NemesisChallenge",
		RequiredKillFunctionName = "TrackNemesisChallengeProgress",
		PlayerKills = 0,
		NemesisKills = 0,

		DifficultyModifier = 60,
		--DepthDifficultyRamp = 0,
		--BaseDifficulty = 150,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6, -- has to be lower to account for Nemesis herself
		ActiveEnemyCapDepthRamp = 0,
		TypeCountDepthRamp = 0,
		MinWaves = 4,
		MaxWaves = 4,
		MoneyDropCapMin = 30,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,

		ExitsUnlockedThreadedEvents =
		{
			{
				FunctionName = "NemesisTakeRoomExit",
				Args =
				{
					RandomWaitMin = 1.0,
					RandomWaitMax = 3.0,
				},
				GameStateRequirements =
				{
					ChanceToPlay = 1.0,
				},
			},
		},
	},

	NemesisCombatF =
	{
		InheritFrom = { "BaseNemesisCombat", "GeneratedF" },
	},

	NemesisCombatG =
	{
		InheritFrom = { "BaseNemesisCombat", "GeneratedG" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisGetFreeItemIntro01" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "NemesisWithNarcissus01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
		},
	},

	NemesisCombatH =
	{
		InheritFrom = { "BaseNemesisCombat", "GeneratedH" },

		UnthreadedEvents = EncounterSets.EncounterEventsNemesisCombatFields,
		SpawnRadius = 500,
		SpawnRadiusMin = 200,

		ActiveEnemyCapMax = 4, -- has to be lower to account for Nemesis herself

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "NemesisGetFreeItemIntro01" },
			},
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
		},

		--UnthreadedEvents = EncounterSets.EncounterEventsNemesisCombatFields,

		SpawnPresentationFunction = "NemesisSpawnPresentationFields",
		SpawnRadius = 600,
		SpawnRadiusMin = 150,
	},

	-- like default encounter but occurs only once, with a higher chance
	NemesisCombatIntro =
	{
		InheritFrom = { "NemesisCombatF" },
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
			},
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 7,
			},
			{
				PathTrue = { "GameState", "RoomCountCache", "G_Intro" },
			},
			{
				PathFalse = { "PrevRun", "Cleared" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
		},
	},
})