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
				HasNone = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" },
			},			
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive", "HecateMissing", },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "TalentDrop" },

		SkipExitReadyCheckpoint = true,

		BlockAthenaEncounterKeepsake = true,

		BlockCodexBeforeStart = true,
		DelayedStart = true,
		-- SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		TimerBlock = "ArtemisEncounter",
		BlockHighlightEliteTypes = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsNemesisCombat,
		Using = { "NPC_Nemesis_01" },
		LoadPackages = { "Nemesis", },

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
					RandomWaitMin = 0.1,
					RandomWaitMax = 0.5,
				},
				GameStateRequirements =
				{
					ChanceToPlay = 1.0,
					{
						PathEmpty = { "GameState", "NemesisTakeExitRecord" },
					},
				},
			},
			{
				FunctionName = "NemesisTakeRoomExit",
				Args =
				{
					RandomWaitMin = 0.5,
					RandomWaitMax = 2.0,
				},
				GameStateRequirements =
				{
					ChanceToPlay = 1.0,
					{
						PathNotEmpty = { "GameState", "NemesisTakeExitRecord" },
					},
				},
			},
		},
	},

	SetupEvents =
	{
		{
			FunctionName = "EraseRoomKeys",
			Args =
			{
				EraseKeys =
				{
					"FishingPointSuccess",
					"ExorcismPointSuccess",
				},
			},
		},
	},

	NemesisCombatF =
	{
		InheritFrom = { "BaseNemesisCombat", "GeneratedF" },
		CanEncounterSkip = false,
	},

	NemesisCombatG =
	{
		InheritFrom = { "BaseNemesisCombat", "GeneratedG" },
		CanEncounterSkip = false,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersOccurredCache" },
				HasNone = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" },
			},	
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
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive", "HecateMissing", },
		},
	},

	NemesisCombatH =
	{
		InheritFrom = { "BaseNemesisCombat", "GeneratedH" },
		CanEncounterSkip = false,
		ForceEncounterStart = false,

		UnthreadedEvents = EncounterSets.EncounterEventsNemesisCombatFields,

		ActiveEnemyCapMax = 4, -- has to be lower to account for Nemesis herself

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersOccurredCache" },
				HasNone = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" },
			},	
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
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive", "HecateMissing", },
		},

		--UnthreadedEvents = EncounterSets.EncounterEventsNemesisCombatFields,

		SpawnPresentationFunction = "NemesisSpawnPresentationFields",
		NemesisSpawnRadius = 600,
		NemesisSpawnRadiusMin = 150,
	},

	NemesisCombatI =
	{
		InheritFrom = { "BaseNemesisCombat", "GeneratedI" },
		CanEncounterSkip = false,
		ForceEncounterStart = false,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "EncountersOccurredCache" },
				HasNone = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" },
			},	
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "NemesisGetFreeItemIntro01", "NemesisPostCombatAboutTartarus02" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive", "HecateMissing", },
		},
		NemesisSpawnRadius = 1500,
		NemesisSpawnRadiusMin = 800,
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
			NamedRequirementsFalse = { "StandardPackageBountyActive", "HecateMissing", },
		},
	},
})