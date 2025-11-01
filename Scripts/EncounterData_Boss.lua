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
				RecheckRequirementsPostWait = true,
				RecheckRequirementsForSubLines = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "H_Boss01" },
						Comparison = "<=",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/MelinoeField_0917", Text = "{#Emph}Erm... {#Prev}hello?" },
				{ Cue = "/VO/MelinoeField_0918", Text = "No! Heel! Stay!", PreLineWait = 1.7 },
				{ Cue = "/VO/MelinoeField_0919", Text = "Three heads... you're...", PreLineWait = 1.7 },

				{ Cue = "/VO/MelinoeField_1109", Text = "Cerberus, is that you?!", PreLineWait = 4 },
				{ Cue = "/VO/MelinoeField_1110", Text = "I'm going to help you, boy! No matter what!", PreLineWait = 3, BreakIfPlayed = true },
			},
			{
				UsePlayerSource = true,
				BreakIfPlayed = true,
				PreLineWait = 3.0,
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
						Comparison = ">=",
						Value = 3,
					},
				},

				{ Cue = "/VO/MelinoeField_3532", Text = "Covered in magma now... the Vow of Rivals caused all this?" },
			},
			{
				UsePlayerSource = true,
				PreLineWait = 1.0,
				PlayOnce = true,
				PlayOnceContext = "CerberusSecondFightVO",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "H_PostBoss01" },
						Comparison = "==",
						Value = 1,
					},
				},

				{ Cue = "/VO/MelinoeField_2566", Text = "Is he gone...?" },
				{ Cue = "/VO/MelinoeField_2567", Text = "No, he is not. Calm yourself, Cerberus! We're going to fix this...", PreLineWait = 3, BreakIfPlayed = true },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "CerberusBossPostEndingFirstMeetingVO",
				UsePlayerSource = true,
				PreLineWait = 3.0,
				RecheckRequirementsPostWait = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/MelinoeField_4571", Text = "You like getting to roam free here, don't you?" },
				{ Cue = "/VO/MelinoeField_4567", Text = "I know you don't like cleanings, but it's time!", PreLineWait = 3.5, BreakIfPlayed = true },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 3.0,
				SuccessiveChanceToPlayAll = 0.66,
				RecheckRequirementsPostWait = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/MelinoeField_0920", Text = "You're not going to step aside, are you?" },
				{ Cue = "/VO/MelinoeField_0921", Text = "What is it you think you're guarding, {#Emph}hm?" },
				{ Cue = "/VO/MelinoeField_0926", Text = "You're very vigilant, I'll grant you that." },
				{ Cue = "/VO/MelinoeField_0927", Text = "The guardian at the gates of hell..." },
				{ Cue = "/VO/MelinoeField_0923", Text = "Heads up..." },
				{ Cue = "/VO/MelinoeField_4566", Text = "Well, boy! More playtime for you now?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4567", Text = "I know you don't like cleanings, but it's time!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							SumPrevRuns = 8,
							Path = { "SpeechRecord", "/VO/MelinoeField_4567" },
							CountPathTrue = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4568", Text = "Hello again, Cerberus! Shall we?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4569", Text = "Hi boy! Let's do our thing.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4570", Text = "You've got a lot of energy for an old dog!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4571", Text = "You like getting to roam free here, don't you?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							SumPrevRuns = 8,
							Path = { "SpeechRecord", "/VO/MelinoeField_4571" },
							CountPathTrue = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0922", Text = "I'm sorry, but I have to get through.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0924", Text = "I'm not afraid of you...",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0925", Text = "Don't take your sorrow out on me!",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4184", Text = "Is this just playtime for you, boy?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4566", Text = "Well, boy! More playtime for you now?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4184" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4183", Text = "All right, boy! We'll do this {#Emph}just {#Prev}like before!", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4184" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_4185", Text = "Been playing in the mud again, boy?", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_4184" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3536", Text = "I'll cool you off as soon as possible here, boy...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 3,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3537", Text = "At least that magma's gone for now...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = "<",
							Value = 3,
						},
						{
							PathTrue = { "GameState", "LastBossDifficultyRecord", "InfestedCerberus" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1109", Text = "Cerberus, is that you?!", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
						-- intentional in case the above version doesn't play
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
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
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
				{ Cue = "/VO/MelinoeField_3033", Text = "Hecuba, meet Cerberus!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
						{
							Path = { "GameState", "EquippedFamiliar" },
							IsAny = { "HoundFamiliar" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3034", Text = "You're not afraid of dogs are you, Toula?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
						{
							Path = { "GameState", "EquippedFamiliar" },
							IsAny = { "CatFamiliar" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0928", Text = "You'll soon feel better again, Cerberus.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0929", Text = "You're all mired up again.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0930", Text = "Been rolling around in Miasma, have you?",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0931", Text = "Chronos must have kicked him out again.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0932", Text = "Not going to hurt you, Cerberus.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0933", Text = "Cerberus, it's me! Don't you remember?",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1110", Text = "I'm going to help you, boy! No matter what!",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1112", Text = "Due for another cleaning, then?",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "LastBossHealthBarRecord", "InfestedCerberus" },
							Comparison = "<=",
							Value = 0,
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						}
					},
				},
				{ Cue = "/VO/MelinoeField_1113", Text = "I know you're angry! Believe me, so am I!",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1114", Text = "Don't you yet recognize me, boy?",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1115", Text = "He's running on pure instinct now...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1116", Text = "I have to calm him down...",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ReachedTrueEnding" },
						},
						{
							PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
						},
					},
				},
			},
		},
	},
	BossInfestedCerberus02 =
	{
		InheritFrom = { "BossInfestedCerberus01" },
	},

	CerberusSpawns01 =
	{
		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapMax = 6,
		BlockSpawnMultipliers = true,

		SkipCleanupRaiseDead = true,

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
						TotalCount = 1,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusEMSpawns01 =
	{
		InheritFrom = { "CerberusSpawns01" },
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessPitcher_Elite",
						TotalCount = 5,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusEMSpawns02 =
	{
		InheritFrom = { "CerberusSpawns01" },
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessWaveFist_Elite",
						TotalCount = 6,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusEMSpawns03 =
	{
		InheritFrom = { "CerberusSpawns01" },
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessGrenadier_Elite",
						TotalCount = 5,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusEMSpawns04 =
	{
		InheritFrom = { "CerberusSpawns01" },
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessSelfDestruct_Elite",
						TotalCount = 7,
						SpawnPointGroupName = "SpawnPointsPhase1"
					},
				},
			},
		},
	},

	CerberusEMSpawns05 =
	{
		InheritFrom = { "CerberusSpawns01" },
		ActiveEnemyCapBase = 8,
		ActiveEnemyCapMax = 8,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "BloodlessBerserker_Elite",
						TotalCount = 8,
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
		BlockPostBossKeepsakeExpiration = true,

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = "<",
					Value = 4,
				},
			},
		},

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Chronos", "SatyrCultist" }, IgnoreAI = true, SkipPresentation = true, } },
			{
				FunctionName = "HandleChronosPreSpawns",
			},
		},

		EnemiesToRestore = {},
		
		WipeEnemiesOnKill = "Chronos",
	},

	BossChronos02 =
	{
		InheritFrom = { "BossChronos01" },

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Chronos", "SatyrCultist_Elite" }, IgnoreAI = true, SkipPresentation = true, } },
			{
				FunctionName = "HandleChronosPreSpawns",
			},
		},

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = ">=",
					Value = 4,
				},
			},
		},
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
	BossEris02 =
	{
		InheritFrom = { "BossEris01" },
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
		GroupHealthBarRecordName = "Scylla",
		HealthBarTextId = "Scylla_Full",

		DeathStinger = "/Music/IrisScyllaDeathStinger",
		DeathExtraSounds = { "/SFX/ScyllaCrowdApplause1", "/SFX/ScyllaCrowdApplause2", "/SFX/ScyllaCrowdCrappyWoo3" },
		SpawnThreadName = "ScyllaSpawnThread",
		WipeEnemiesOnKill = "Scylla",
	},

	BossScylla02 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Scylla", "SirenDrummer", "SirenKeytarist", "Charybdis_ScyllaFight", "CharybdisTentacle2" }, SpawnOverrides = {  }, IgnoreAI = true, SkipPresentation = true, OccupyNearestSpawnPoint = true } },
			{ FunctionName = "SetupGroupHealthBar", Args = { } }
		},

		ThreadedEvents =
		{
		},

		UseGroupHealthBar = true,
		GroupHealthBarTypes = { "Scylla", "SirenDrummer", "SirenKeytarist", "CharybdisTentacle2" },
		GroupHealthBarRecordName = "Scylla",
		HealthBarTextId = "Scylla_AltFight01",

		DeathStinger = "/Music/IrisScyllaDeathStinger",
		DeathExtraSounds = { "/SFX/TheseusCrowdCheer" },
		SpawnThreadName = "ScyllaSpawnThread",
		WipeEnemiesOnKill = "Scylla",
	},

	ScyllaTentacleSpawns01 =
	{
		SpawnIntervalMin = 0.05,
		SpawnIntervalMax = 0.1,
		ActiveEnemyCapBase = 10,
		ActiveEnemyCapMax = 10,
		BlockSpawnMultipliers = true,

		SkipCleanupRaiseDead = true,

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
						Name = "CharybdisTentacle2",
						TotalCount = 3,
						--SpawnOnIds = { 737390, 737392, 737391, 737389, 737387, 737440, 737442, 737438, },
					},
				},
			},
		},
	},

	ScyllaTentacleSpawns02 =
	{
		InheritFrom = { "ScyllaTentacleSpawns01" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "CharybdisTentacle2",
						TotalCount = 4,
					},
				},
			},
		},
	},

	ScyllaTentacleSpawns03 =
	{
		InheritFrom = { "ScyllaTentacleSpawns01" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "CharybdisTentacle2",
						TotalCount = 6,
					},
				},
			},
		},
	},

	BossPolyphemus01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Polyphemus" }, IgnoreAI = true, SkipPresentation = true, } },
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 0.25, FractionMax = 0.5, LegalTypes = { "Sheep_Intro" }, IgnoreAI = false, SkipPresentation = true, } },
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

	BossPolyphemus02 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Polyphemus", "Medea" }, IgnoreAI = true, SkipPresentation = true, } },
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

	BossPrometheus01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Prometheus", "Eagle" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		WipeEnemiesOnKill = "Prometheus",
		CancelSpawnsOnKill = { "Prometheus" },
		SpawnThreadName = "PrometheusSpawnThread",

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = "<",
					Value = 3,
				},
			},
		}
	},

	BossPrometheus02 =
	{
		InheritFrom = { "BossPrometheus01" },
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Prometheus", "Eagle", "Heracles" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		ThreadedEvents =
		{
			{ FunctionName = "PrometheusHeraclesRoleSwitcher", Args  = { Interval = 17 } }
		},

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = ">=",
					Value = 3,
				},
			},
		}
	},

	BossTyphonHead01 =
	{
		InheritFrom = { "BossEncounter" },
		DelayedStart = true,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "TyphonHead" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		WipeEnemiesOnKill = "TyphonHead",
		CancelSpawnsOnKill = { "TyphonHead" },
		SpawnThreadName = "TyphonSpawnThread",

		SpeakerNames = { "Zeus", "Chronos" },

		PreFightVoiceLines =
		{
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 2.0,
				SuccessiveChanceToPlay = 0.85,
				SuccessiveChanceToPlayAll = 0.5,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/MelinoeField_3004", Text = "{#Emph}Typhon!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3005", Text = "Hail, Typhon!" },
				{ Cue = "/VO/MelinoeField_3180", Text = "I've returned!" },
				{ Cue = "/VO/MelinoeField_3181", Text = "{#Emph}Out{#Prev}, Typhon!" },
				{ Cue = "/VO/MelinoeField_3182", Text = "Show yourself!" },
				{ Cue = "/VO/MelinoeField_3183", Text = "Come on out!" },
				{ Cue = "/VO/MelinoeField_3184", Text = "Remember me?" },
				{ Cue = "/VO/MelinoeField_3185", Text = "Monster!" },
			},
			{
				UsePlayerSource = true,
				PreLineWait = 2.0,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "Q_Boss01" },
						Comparison = "<=",
						Value = 1,
					},
				},
				{ Cue = "/VO/MelinoeField_3000", Text = "{#Emph}<Gasp>" },
			},
		},

		PreRoarVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				ObjectType = "TyphonHead",
				SkipAnim = true,
				PreLineWait = 1.0,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomCountCache", "Q_Boss01" },
					},
				},
				Cooldowns =
				{
					{ Name = "TyphonIntroSpeech", Time = 36 },
				},
				TriggerCooldowns = { "TyphonSpokeRecently" },

				{ Cue = "/VO/Typhon_0072", Text = "{#TyphonFormat}RAAAAAUGH...!" },
				{ Cue = "/VO/Typhon_0073", Text = "{#TyphonFormat}RAAAAAGE...!" },
				{ Cue = "/VO/Typhon_0075", Text = "{#TyphonFormat}WHERRRRRE...?!" },
				{ Cue = "/VO/Typhon_0076", Text = "{#TyphonFormat}NOOOOOW...!" },
				{ Cue = "/VO/Typhon_0077", Text = "{#TyphonFormat}KILLLLLL...!" },
				{ Cue = "/VO/Typhon_0078", Text = "{#TyphonFormat}HAAAAATE...!", PlayFirst = true },
				{ Cue = "/VO/Typhon_0071", Text = "{#TyphonFormat}DIEEEEE...!", PlayFirst = true },
				{ Cue = "/VO/Typhon_0113", Text = "{#TyphonFormat}TIIIME...!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0114", Text = "{#TyphonFormat}CHRONOOOSSS...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0115", Text = "{#TyphonFormat}TIIITANNN...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0117", Text = "{#TyphonFormat}BOWWW...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0116", Text = "{#TyphonFormat}MINE...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0118", Text = "{#TyphonFormat}YOUUUUUU...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0074", Text = "{#TyphonFormat}YOUUUUUU...!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
						},
					},
				},
			},
		},

		FightStartVoiceLines =
		{
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", "TyphonSpokeRecently" },
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 1.0,

				{ Cue = "/VO/MelinoeField_3001", Text = "The Father of All Monsters...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "RoomsEntered", "Q_Boss01" },
							Comparison = "<=",
							Value = 1,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_3336", Text = "Looks like you're all patched up!",
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
						},
						{
							Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
			},
			{
				RandomRemaining = true,
				ObjectType = "TyphonHead",
				SkipAnim = true,
				PreLineWait = 2.0,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "TyphonIntroSpeech", Time = 36 },
				},
				TriggerCooldowns = { "TyphonSpokeRecently" },
				TriggerCooldownsImmediately = true,

				{ Cue = "/VO/Typhon_0003", Text = "{#TyphonFormat}WHERE... IS... ZEUUUUUSSS...", PlayFirst = true, },
				{ Cue = "/VO/Typhon_0018", Text = "{#TyphonFormat}WHERE... IS... ZEUUUUUSSS..." },
				{ Cue = "/VO/Typhon_0002", Text = "{#TyphonFormat}YOUUUUU... DAAAAARE..." },
				{ Cue = "/VO/Typhon_0004", Text = "{#TyphonFormat}RAAAAAUGHHH..." },
				{ Cue = "/VO/Typhon_0005", Text = "{#TyphonFormat}YOUUUUU..." },
				{ Cue = "/VO/Typhon_0006", Text = "{#TyphonFormat}I... SSSEEEEEE... YOUUUUU..." },
				{ Cue = "/VO/Typhon_0007", Text = "{#TyphonFormat}WHERE... IS... HEEEEE..." },
				{ Cue = "/VO/Typhon_0008", Text = "{#TyphonFormat}WHERE... ARE... YOUUUUU..." },
				{ Cue = "/VO/Typhon_0009", Text = "{#TyphonFormat}GODSSS... DIIIIIE..." },
				{ Cue = "/VO/Typhon_0010", Text = "{#TyphonFormat}KILLLLLL..." },
				{ Cue = "/VO/Typhon_0015", Text = "{#TyphonFormat}NOOOOOW..." },
				{ Cue = "/VO/Typhon_0016", Text = "{#TyphonFormat}RAAAAAGE..." },
				{ Cue = "/VO/Typhon_0124", Text = "{#TyphonFormat}PRAAAY... FOR... DEAAATH..." },
				{ Cue = "/VO/Typhon_0122", Text = "{#TyphonFormat}THISSS... ENDSSS... NOW..." },
				{ Cue = "/VO/Typhon_0125", Text = "{#TyphonFormat}I... AM... BAAACK...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0126", Text = "{#TyphonFormat}WHAT... ARE... YOU...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ZeusPalacePostTrueEnding01" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0127", Text = "{#TyphonFormat}I... RETURN...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0128", Text = "{#TyphonFormat}YOU... RETURN...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "ReachedTrueEnding" }
						},
					},
				},
				{ Cue = "/VO/Typhon_0119", Text = "{#TyphonFormat}BOWWW... TO... USSS...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0120", Text = "{#TyphonFormat}WE... SHALL... RUUULE...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0121", Text = "{#TyphonFormat}YOUR... TIME... ENDSSS...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0123", Text = "{#TyphonFormat}IT... ISSS... TIIIIIME...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
							Comparison = ">=",
							Value = 4,
						},
					},
				},
				{ Cue = "/VO/Typhon_0013", Text = "{#TyphonFormat}YOU... HADESSS...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "EnemyKills", "TyphonHead" },
							Comparison = ">=",
							Value = 2,
						},
					},
				},
				{ Cue = "/VO/Typhon_0014", Text = "{#TyphonFormat}HADEEEEESSS...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
						},
					},
				},
				{ Cue = "/VO/Typhon_0011", Text = "{#TyphonFormat}YOU... DAAAAARE...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
						},
					},
				},
				{ Cue = "/VO/Typhon_0012", Text = "{#TyphonFormat}DAAAAAMN... YOUUUUU...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
						},
					},
				},
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MelVsTyphonIntroVO04",
				UsePlayerSource = true,
				BreakIfPlayed = true,
				-- PreLineWait = 1.0,
				RecheckRequirementsPostWait = true,
				RecheckRequirementsForSubLines = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStormStop" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelFacingTyphonSpeech", Time = 45 },
				},
				TriggerCooldowns = { "MelWindReactionSpeech" },
				TriggerCooldownsImmediately = true,

				{ Cue = "/VO/MelinoeField_4173", Text = "This is it... just need to weaken him." },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MelVsTyphonIntroVO04",
				UsePlayerSource = true,
				-- PreLineWait = 1.0,
				RecheckRequirementsPostWait = true,
				RecheckRequirementsForSubLines = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "TyphonHead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelFacingTyphonSpeech", Time = 45 },
				},
				TriggerCooldowns = { "MelWindReactionSpeech" },
				TriggerCooldownsImmediately = true,

				{ Cue = "/VO/MelinoeField_3187", Text = "Can't sense his life force at all...", PreLineWait = 1.7 },
				{ Cue = "/VO/MelinoeField_3189", Text = "Just a foe, it's just another foe...", PreLineWait = 1.7,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3187" }
						},
					},
				},
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MelVsTyphonIntroVO01",
				UsePlayerSource = true,
				-- PreLineWait = 1.0,
				RecheckRequirementsPostWait = true,
				RecheckRequirementsForSubLines = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelFacingTyphonSpeech", Time = 45 },
				},
				TriggerCooldowns = { "MelWindReactionSpeech" },
				TriggerCooldownsImmediately = true,

				{ Cue = "/VO/MelinoeField_3331", Text = "You dare hide your life-force from {#Emph}me?!", PreLineWait = 1.7 },
				{ Cue = "/VO/MelinoeField_3332", Text = "However much you have I'll bleed it {#Emph}dry!", PreLineWait = 1.7, BreakIfPlayed = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3331" }
						},
					},
				},
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MelVsTyphonIntroVO02",
				UsePlayerSource = true,
				-- PreLineWait = 1.0,
				RecheckRequirementsPostWait = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelFacingTyphonSpeech", Time = 45 },
				},
				TriggerCooldowns = { "MelWindReactionSpeech" },
				TriggerCooldownsImmediately = true,

				{ Cue = "/VO/MelinoeField_3333", Text = "Hiding your life-force? {#Emph}Coward!", PreLineWait = 1.7 },
				{ Cue = "/VO/MelinoeField_3334", Text = "I'll know how much you had when you lie {#Emph}dead!", PreLineWait = 1.7, BreakIfPlayed = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3333" }
						},
					},
				},
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MelVsTyphonIntroVO",
				UsePlayerSource = true,
				-- PreLineWait = 1.0,
				RecheckRequirementsPostWait = true,
				RecheckRequirementsForSubLines = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelFacingTyphonSpeech", Time = 45 },
				},
				TriggerCooldowns = { "MelWindReactionSpeech" },
				TriggerCooldownsImmediately = true,

				{ Cue = "/VO/MelinoeField_3002", Text = "I don't fear you!", PreLineWait = 1.7 },
				{ Cue = "/VO/MelinoeField_3003", Text = "You'll fear {#Emph}me!", PreLineWait = 1.7, BreakIfPlayed = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "SpeechRecord", "/VO/MelinoeField_3002" }
						},
					},
				},
			},
			{
				UsePlayerSource = true,
				-- PreLineWait = 1.0,
				RecheckRequirementsPostWait = true,
				SuccessiveChanceToPlay = 0.1,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
				},
				Cooldowns =
				{
					{ Name = "MelFacingTyphonSpeech", Time = 45 },
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns = { "MelWindReactionSpeech" },
				TriggerCooldownsImmediately = true,

				{ Cue = "/VO/MelinoeField_3335", Text = "{#Emph}For Olympus!" },
			},
		},

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = "<",
					Value = 4,
				},
			},
		}

	},
	
	BossTyphonHead02 =
	{
		InheritFrom = { "BossTyphonHead01" },

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "TyphonHead", "Chronos_TyphonFight" }, IgnoreAI = true, SkipPresentation = true, } },
		},

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = ">=",
					Value = 4,
				},
			},
		},

		CapturePointMoveChance = 1,
		CapturePointMoveSearchDistance = 1400,
		CapturePointMoveSuccessWaitDuration = 1.0,
		CapturePointTickDuration = 0.18,
		
	},

	BossZagreus01 =
	{
		InheritFrom = { "BossEncounter" },
		SkipExitReadyCheckpoint = true,
		DelayedStart = true,
		SkipBossTraits = true,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "Zagreus", }, IgnoreAI = true, SkipPresentation = true, } },
		},
		UnthreadedEvents = 
		{
			
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "HandleEnemySpawns" },
			{ FunctionName = "CheckForAllEnemiesDead" },
			{ FunctionName = "PostCombatAudio" },
			{ FunctionName = "AwardContractTrait" },
			{ FunctionName = "SpawnRoomReward" },
		},
		WipeEnemiesOnKill = "Zagreus",
		CancelSpawnsOnKill = { "Zagreus" },
		SpawnThreadName = "ZagreusSpawnThread",

		Using =
		{
			"ElysiumConfettiEmitterBurst",
			"StageSpotlight",
		}
	},
})