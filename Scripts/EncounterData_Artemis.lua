OverwriteTableKeys( EncounterData,
{
	-- Artemis F Encounters	
	BaseArtemisCombat =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ArtemisCombatIntro" },
			},
			{
				PathFalse = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			NamedRequirements = { "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive", "SurfaceRouteLockedByTyphonKill" },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade" },

		BlockCodexBeforeStart = true,
		BlockLocationText = true,
		DelayedStart = true,
		-- SkipCombatBeginsVoiceLines = true,
		RequireCompletedIntro = true,
		PreSpawnEnemies = false,
		TimerBlock = "ArtemisEncounter",
		BlockHighlightEliteTypes = true,
		
		BlockAthenaEncounterKeepsake = true,

		MuteSecretMusicDrumsOnCombatOver = true,
		NextRoomResumeMusic = true,

		UnthreadedEvents = EncounterSets.EncounterEventsArtemisCombat,
		Using =
		{
			"NPC_Artemis_Field_01",
			Sounds =
			{
				"/SFX/Menu Sounds/Lounge_GlassWithIce",
				"/SFX/Menu Sounds/Lounge_BottleCork",
				"/SFX/Menu Sounds/Lounge_BottlePour",
				"/Leftovers/World Sounds/Caravan Interior/SwallowDrink",
				"/SFX/Menu Sounds/Lounge_GlassesClinking",
			},
		},
		SpeakerNames = { "Artemis", },
		LoadPackages = { "Artemis", "NPC_Artemis_Field_01" },

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
		CanEncounterSkip = false,
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
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
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
			{
				Path = { "GameState", "TextLinesRecord" },
				CountOf =
				{
					"PoseidonFirstPickUp",
					"DemeterFirstPickUp",
					"HestiaFirstPickUp", 
					"AphroditeFirstPickUp",
					"ZeusFirstPickUp",
					"HephaestusFirstPickUp",
				},
				Comparison = ">=",
				Value = 4,
			},
		},

		WaveStartUnthreadedEvents =
		{
			{ FunctionName = "CheckArtemisSpawn", Args = { FirstWaveArtemisChance = 0.0 } },
		},
	},

	-- Artemis Encounter
	ArtemisCombatG =
	{
		InheritFrom = { "BaseArtemisCombat", "GeneratedG" },
		CanEncounterSkip = false,
		DifficultyModifier = 145,
		MaxEliteTypes = 3,	
	},

	ArtemisCombatG2 =
	{
		InheritFrom = { "ArtemisCombatG" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Artemis_Field_01" },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
		},
	},

	ArtemisCombatN =
	{
		InheritFrom = { "BaseArtemisCombat", "GeneratedN" },
		CanEncounterSkip = false,
		ActiveEnemyCapBase = 5.0,
		ActiveEnemyCapMax = 10,
		ActiveEnemyCapDepthRamp = 1,

		BaseDifficulty = 200,
		DepthDifficultyRamp = 20,
	},

	ArtemisCombatN2 =
	{
		InheritFrom = { "ArtemisCombatN" },

		GameStateRequirements =
		{
			Append = true,
			{
				SumPrevRuns = 4,
				Path = { "SpawnRecord", "NPC_Artemis_Field_01" },
				Comparison = "<=",
				Value = 0,
			},
			{
				PathFalse = { "PrevRun", "SpecialInteractRecord", "Shrine" },
			}
		},
	},
})