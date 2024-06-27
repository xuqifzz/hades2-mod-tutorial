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
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentFieldNPCEncounter" },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "TalentDrop" },

		BlockFishingBeforeStart = true,
		BlockCodexBeforeStart = true,
		DelayedStart = true,
		-- SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		FastClearThreshold = 65,
		TimerBlock = "IcarusEncounter",
		BlockHighlightEliteTypes = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsIcarusCombat,
		Using = { "NPC_Icarus_01" },

		DifficultyModifier = 300,
		--DepthDifficultyRamp = 0,
		--BaseDifficulty = 150,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 0,
		TypeCountDepthRamp = 0,
		MinWaves = 3,
		MaxWaves = 3,
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
			RequiredMinHealthFraction = 0.33,
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			RequiredMinHealthFraction = 0.33,
			NamedRequirements = { "NoRecentFieldNPCEncounter" },
		},
	},
})