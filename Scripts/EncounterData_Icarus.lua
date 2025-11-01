OverwriteTableKeys( EncounterData,
{
	-- Icarus Encounter
	BaseIcarusCombat =
	{
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "UseRecord", "NPC_Icarus_01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "GameState", "BiomeVisits", "O" },
				Comparison = ">",
				Value = 1,
			},
			NamedRequirements = { "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive" },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade" },

		BlockAthenaEncounterKeepsake = true,

		BlockCodexBeforeStart = true,
		DelayedStart = true,
		-- SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		TimerBlock = "IcarusEncounter",
		BlockHighlightEliteTypes = true,

		CanEncounterSkip = false,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsIcarusCombat,
		Using = { "NPC_Icarus_01" },
		LoadPackages = { "Icarus", "NPC_Icarus_01" },

		DifficultyMultiplier = 3.0,

		ActiveEnemyCapBase = 7,
		ActiveEnemyCapMax = 7, -- Give Icarus bone budget room.
		ActiveEnemyCapDepthRamp = 0,
		TypeCountDepthRamp = 0,
		MinWaves = 4,
		MaxWaves = 4,
		MoneyDropCapMin = 30,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,

		WaveStartUnthreadedEvents =
		{
			{ FunctionName = "CheckIcarusSpawn", Args = { FirstWaveIcarusChance = 0.0, WaveSpawnDelay = 1.8 } },
		},
	},

	IcarusCombatO =
	{
		InheritFrom = { "BaseIcarusCombat", "GeneratedO" },

		GameStateRequirements =
		{
			Append = true,
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "IcarusCombatIntro" },
			},
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "IcarusCombatIntro" },
			},
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "IcarusCombatO" },
			},
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "IcarusCombatO2" },
			},
		},

		UnthreadedEvents = EncounterSets.EncounterEventsIcarusShipsCombat,

		BlockCodexBeforeStart = false,
		SkipShipsBombardment = true,
	},

	IcarusCombatO2 =
	{
		InheritFrom = { "IcarusCombatO" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Icarus_01" },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
		},
	},

	IcarusCombatIntro =
	{
		InheritFrom = { "IcarusCombatO" },

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "CirceFirstMeeting" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "CirceEnlargeTrait", "CirceShrinkTrait" },
			},
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "IcarusCombatIntro" },
			},
			{
				PathFalse = { "CurrentRun", "EncountersOccurredCache", "IcarusCombatIntro" },
			},
			{
				PathFalse = { "CurrentRun", "UseRecord", "NPC_Icarus_01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
			{
				Path = { "GameState", "BiomeVisits", "O" },
				Comparison = ">",
				Value = 1,
			},
			{
				FunctionName = "RequiredHealthFraction",
				FunctionArgs = { Comparison = ">=", Value = 0.33, },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentFieldNPCEncounter" },
		},
	},

	IcarusCombatP =
	{
		InheritFrom = { "BaseIcarusCombat", "GeneratedP" },

		RequireRoomTag = "Outdoor",

		GameStateRequirements =
		{
			Append = true,
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "IcarusCombatIntro" },
			},
			{
				Path = { "GameState", "UseRecord", "NPC_Icarus_01" },
				Comparison = ">=",
				Value = 4,
			},
			{
				Path = { "CurrentRun", "EncountersOccurredCache" },
				HasNone = { "IcarusCombatIntro", "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
			},
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "AthenaFirstMeeting" }
			},
		},
	},

	IcarusCombatP2 =
	{
		InheritFrom = { "IcarusCombatP" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Icarus_01" },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
		},
	},
})