OverwriteTableKeys( EncounterData,
{
	-- Boss Encounters
	-- NOTE(andrew): BossEncounter base and Hecate moved to EncounterData.lua
	-- for the Tech Test

	BossInfestedCerberus01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "InfestedCerberus" }, SpawnOverrides = { }, IgnoreAI = true, SkipPresentation = true, } },
		},
		
		WipeEnemiesOnKill = "InfestedCerberus",

		EnterVoiceLines =
		{
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			{
				UsePlayerSource = true,
				PreLineWait = 3.0,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "H_Boss01" },
						Comparison = "<=",
						Value = 1,
					}
				},

				{ Cue = "/VO/MelinoeField_0917", Text = "{#Emph}Erm... {#Prev}hello?" },
				{ Cue = "/VO/MelinoeField_0918", Text = "No! Heel! Stay!", PreLineWait = 1.7 },
				{ Cue = "/VO/MelinoeField_0919", Text = "Three heads... you're...", PreLineWait = 1.7 },

				{ Cue = "/VO/MelinoeField_1109", Text = "Cerberus, is that you?!", PreLineWait = 4 },
				{ Cue = "/VO/MelinoeField_1110", Text = "I'm going to help you, boy! No matter what!", PreLineWait = 3, BreakIfPlayed = true },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 3.0,
				SuccessiveChanceToPlayAll = 0.66,

				{ Cue = "/VO/MelinoeField_1109", Text = "Cerberus, is that you?!", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
						{
							PathFalse = { "GameState", "SpeechRecord", "/VO/MelinoeField_1109" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1111", Text = "You'll soon feel better, Cerberus, I swear!", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_1109" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1219", Text = "It's like he's formed a shell...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1220", Text = "I'll break you from your shell!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0920", Text = "You're not going to step aside, are you?" },
				{ Cue = "/VO/MelinoeField_0921", Text = "What is it you think you're guarding, {#Emph}hrm?" },
				{ Cue = "/VO/MelinoeField_0922", Text = "I'm sorry, but I have to get through." },
				{ Cue = "/VO/MelinoeField_0923", Text = "Heads up..." },
				{ Cue = "/VO/MelinoeField_0924", Text = "I'm not afraid of you..." },
				{ Cue = "/VO/MelinoeField_0925", Text = "Don't take your sorrow out on me!" },
				{ Cue = "/VO/MelinoeField_0926", Text = "You're very vigilant, I'll grant you that." },
				{ Cue = "/VO/MelinoeField_0927", Text = "The guardian at the gates of hell..." },
				{ Cue = "/VO/MelinoeField_1110", Text = "I'm going to help you, boy! No matter what!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0928", Text = "You'll soon feel better again, Cerberus.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_0929", Text = "You're all mired up again.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_0930", Text = "Been rolling around in Miasma, have you?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_0931", Text = "Chronos must have kicked him out again.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_0932", Text = "Not going to hurt you, Cerberus.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_0933", Text = "Cerberus, it's me! Don't you remember?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_1110", Text = "I'm going to help you, boy! No matter what!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_1112", Text = "Due for another cleaning, then?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_1113", Text = "I know you're angry! Believe me, so am I!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_1114", Text = "Don't you yet recognize me, boy?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_1115", Text = "He's running on pure instinct now...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_1116", Text = "I have to calm him down...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
			},
		},
	},

	CerberusSpawns01 =
	{
		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,
		BlockSpawnMultipliers = true,

		UnthreadedEvents = EncounterSets.EncounterEventsBossSpawnedEncounter,

		UseRoomEncounterEnemySet = true,

		SpawnAggroed = true,

		WaveStartPresentationFunction = "StartWavePresentation",
		SkipNextWaveVoicelines = true,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Lamia_Elite",
						TotalCount = 4,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusSpawns02 =
	{
		InheritFrom = { "CerberusSpawns01" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Lycanthrope_Elite",
						TotalCount = 2,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusSpawns03 =
	{
		InheritFrom = { "CerberusSpawns01" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Mourner_Elite",
						TotalCount = 3,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusSpawns04 =
	{
		InheritFrom = { "CerberusSpawns01" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Lovesick_Elite",
						TotalCount = 4,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusSpawns05 =
	{
		InheritFrom = { "CerberusSpawns01" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "CorruptedShadeSmall_Elite",
						TotalCount = 9,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
					{
						Name = "FogEmitter2",
						TotalCount = 2,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	BossChronos01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Chronos", "SatyrCultist" }, IgnoreAI = true, SkipPresentation = true, } },
			{
				FunctionName = "HandleChronosPreSpawns",
			},
		},

		ObstaclesToRestore =
		{
			{
				Name = "ChronosRemains",
				DestinationId = 713403,
			},
		},

		EnemiesToRestore = {},
		
		WipeEnemiesOnKill = "Chronos",
	},

	BossEris01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Eris" }, SpawnOverrides = { }, IgnoreAI = true, SkipPresentation = true, } },
		},
		
		WipeEnemiesOnKill = "Eris",
		CancelSpawnsOnKill = { "Eris" },
	},

	BossScylla01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Scylla", "SirenDrummer", "SirenKeytarist" }, SpawnOverrides = {  }, IgnoreAI = true, SkipPresentation = true, } },
			{ FunctionName = "SetupGroupHealthBar", Args = { } }
		},

		ThreadedEvents =
		{
			{ FunctionName = "ScyllaCoverManager", GameStateRequirements = { },
				Args = { CoverChangeInterval = 7.5, CoverSpawnChance = 1.0, CoverSpawnIds = { 595541, 595540, 595543, },
						SpawnName = "ScyllaCover", SpawnFx = "WaterUnitSurface", DestroyFx = "ScyllaCoverSubmerge" }
			},
		},

		UseGroupHealthBar = true,
		GroupHealthBarTypes = { "Scylla", "SirenDrummer", "SirenKeytarist" },
		HealthBarTextId = "Scylla_Full",

		DeathStinger = "/Music/IrisScyllaDeathStinger",
		DeathExtraSounds = { "/SFX/ScyllaCrowdApplause1", "/SFX/ScyllaCrowdApplause2", "/SFX/ScyllaCrowdCrappyWoo3" },
		SpawnThreadName = "ScyllaSpawnThread",
		WipeEnemiesOnKill = "Scylla",
	},

	BossPolyphemus01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Polyphemus" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		EnemiesToRestore =
		{
			{
				Name = "PolyphemusCorpse",
				Location =
				{
					X = 5754,
					Y = 9228
				},
			},
		},

		WipeEnemiesOnKill = "Polyphemus",
		CancelSpawnsOnKill = { "Polyphemus" },
		SpawnThreadName = "PolyphemusSpawnThread",
	},
})