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
				PathFalse = { "CurrentRun", "ExpiredKeepsakes", "AthenaEncounterKeepsake" },
			},
			NamedRequirements = { "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive", "SurfaceRouteLockedByTyphonKill" },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", },

		BlockAthenaEncounterKeepsake = true,
		BlockDionysusEncounterKeepsake = true,
		ExpireTrait = "AthenaEncounterKeepsake",

		BlockCodexBeforeStart = true,
		BlockLocationText = true,
		DelayedStart = true,
		-- SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		BlockHighlightEliteTypes = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsAthenaCombat,
		Using = { "NPC_Athena_01" },
		SpeakerNames = { "Athena", },
		LoadPackages = { "NPC_Athena_01", "Athena" },

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
				Args = { Force = true },
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
				Path = { "SpawnRecord", "NPC_Athena_01" },
				Comparison = "<=",
				Value = 2,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
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