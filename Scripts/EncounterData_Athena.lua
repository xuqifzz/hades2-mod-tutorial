OverwriteTableKeys( EncounterData,
{
	-- Athena P Encounters
	BaseAthenaCombat =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "AthenaCombatIntro" },
			},
			{
				PathFalse = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				PathFalse ={ "CurrentRun", "ExpiredKeepsakes", "AthenaEncounterKeepsake" },
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentFieldNPCEncounter" },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "TalentDrop" },

		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,

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

		UnthreadedEvents = EncounterSets.EncounterEventsAthenaCombat,
		Using = { "NPC_Athena_01" },
		SpeakerNames = { "Athena", },
		LoadPackages = { "NPC_Athena_01", },

		BaseDifficulty = 680,
		DepthDifficultyRamp = 180,

		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,
		ActiveEnemyCapDepthRamp = 0,
		TypeCountDepthRamp = 0,
		MinWaves = 3,
		MaxWaves = 3,
		MoneyDropCapMin = 30,
		MoneyDropCapMax = 30,
		MoneyDropCapDepthRamp = 0,

		WaveStartUnthreadedEvents = {}, -- Excluding OlympusEagleSpawn from Athena encounters

		ThreadedEvents =
		{
			{
				FunctionName = "HandleAthenaSpawn",
			},
		},

	},

	AthenaCombatP =
	{
		InheritFrom = { "BaseAthenaCombat", "GeneratedP" },
		CanEncounterSkip = false,

		PauseDurationAfterPriorityGroup = 0.0, -- Causes enemies to spawn in after she begins her presentation
	},

	AthenaCombatP02 =
	{
		InheritFrom = { "AthenaCombatP" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Heracles_01" },
				Comparison = "<=",
				Value = 2,
			},
		},
	},	

	-- like default encounter but occurs only once, with a higher chance
	AthenaCombatIntro =
	{
		InheritFrom = { "AthenaCombatP" },

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "AthenaCombatIntro" },
			},
			{
				PathFalse = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentFieldNPCEncounter" },
		},
	},
})