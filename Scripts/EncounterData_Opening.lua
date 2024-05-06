OverwriteTableKeys( EncounterData,
{
	-- Opening Encounters

	-- NOTE(andrew): OpeningEmpty, OpeningGeneratedF, FIntroFight, FCastTutorialFight
	-- moved to EncounterData.lua for Tech Test

	OpeningGeneratedN =
	{
		InheritFrom = { "GeneratedN" },
		RequireCompletedIntro = true,
		GameStateRequirements =
		{
			RequiredMinCompletedRuns = 1,
		},
		GroupReinforcements = false,
		MaxWaves = 1,
		BaseDifficulty = 60,
		MinTypes = 1,
		MaxTypes = 2,
		MaxTypesCap = 2,
		DelayedStart = true, 

		OnSpawnFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",

		PreSpawnEnemies = false,
		UnthreadedEvents =
		{
			{ FunctionName = "SpawnRoomReward", Args = { WaitUntilPickup = true } },
			{ FunctionName = "BeginOpeningEncounter" },
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "HandleEnemySpawns" },
			{ FunctionName = "CheckForAllEnemiesDead" },
			{ FunctionName = "PostCombatAudio" },
			{ FunctionName = "AddTraitToHeroSource",
				GameStateRequirements =
				{
					RequiredFalseConfigOptions = { "EditingMode" },
					{
						PathFalse = { "GameState", "WorldUpgrades", "WorldUpgradeSurfacePenaltyCure", },
					},
				},
				Args =
				{
					TraitName = "SurfacePenalty",
					PreAddFunctionName = "StartSurfacePenaltyPresentation",
					AddTraitSound = "/SFX/StabSplatterSmall",
					WaitTime = 1.5,
				}
			},
		}
	},

	PreHubGeneratedN =
	{
		InheritFrom = { "GeneratedN" },
		RequireCompletedIntro = true,
		GroupReinforcements = false,
		MaxWaves = 1,
		BaseDifficulty = 100,
		DepthDifficultyRamp = 0,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapDepthRamp = 0,
		MinTypes = 1,
		MaxTypes = 2,
		MaxTypesCap = 2,

		OnSpawnFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",

		PreSpawnEnemies = true,
		CountsForRoomEncounterDepth = false,
	},

	GeneratedHubReturn =
	{
		InheritFrom = { "GeneratedN" },
		AlwaysForce = true,
		RequireCompletedIntro = true,
		GroupReinforcements = false,
		MaxWaves = 1,
		BaseDifficulty = 50,
		DepthDifficultyRamp = 0,
		ActiveEnemyCapBase = 6,
		ActiveEnemyCapDepthRamp = 0,
		MinTypes = 2,
		MaxTypes = 2,
		MaxTypesCap = 2,

		CountsForRoomEncounterDepth = false,

		EnemySet = { "Zombie_Passive", "Carrion_Passive" },

		ExitsDontRequireCompleted = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = "==",
				Value = 1,
			}
		},
	},
	
	ClockworkIntro =
	{
		AlwaysForce = true,
		DifficultyModifier = 100,
		
		ActiveEnemyCapBase = 1.0,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "ClockworkIntro" },
			},
		},

		ThreadedEvents =
		{
			{
				FunctionName = "HadesSpeakingPresentation",
				Args = { SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = GlobalVoiceLines.ChronosAlertVoiceLines, StartSound = "/SFX/TimeSlowStart", UseSurvivalPresentation = true, StartDelay = 1.0 },
			},
		},

		UnthreadedEvents = ConcatTableValues(
		{
			{
				FunctionName = "GenericPresentation",
				Args = { PreWait = 3.0 },
			},
		},
		EncounterSets.EncounterEventsDefault),
		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrLancer",
						CountMin = 2,
						CountMax = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "TimeElemental",
						CountMin = 5,
						CountMax = 5,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "SatyrLancer",
						CountMin = 3,
						CountMax = 3,
					},
					{
						Name = "TimeElemental",
						CountMin = 6,
						CountMax = 6,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
	},

	DeadSeaIntro =
	{
		InheritFrom = { "GeneratedO" },
		Generated = false,
		AlwaysForce = true,
		DifficultyModifier = 100,
		
		ActiveEnemyCapBase = 1.0,
		ActiveEnemyCapMax = 8.0,
		ActiveEnemyCapDepthRamp = 1.0,

		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "EncountersCompletedCache", "DeadSeaIntro" },
			},
		},

		SpawnIntervalMin = 0.175,
		SpawnIntervalMax = 0.225,

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Stickler",
						TotalCount = 2,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Stickler",
						TotalCount = 2,
					},
					{
						Name = "Swab",
						TotalCount = 1,
					},
				},
				StartDelay = 0
			},
			{
				Spawns =
				{
					{
						Name = "Stickler",
						TotalCount = 3,
					},
					{
						Name = "Swab",
						TotalCount = 2,
					},
				},
				StartDelay = 0
			},
		},

		ManualWaveTemplates = {},
	},

	BaseHubReturn =
	{
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
		OnDamageEnemyFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",
		BlockNextBiomeEnemyShrineUpgrade = true,

		ExitsDontRequireCompleted = true,
		RequireCompletedIntro = false,

		CountsForRoomEncounterDepth = false,

		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,
		ActiveEnemyCapBase = 99,
		ActiveEnemyCapMax = 99,

		SpawnOverrides =
		{
			UseActivatePresentation = false,
		},		

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "EnemyKills", "SoulPylon" },
				Comparison = ">=",
				Value = 2,
			},
			{
				PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0619" },
			},
		},

		DistanceTriggers =
		{
			{
				Name = "ReloadEncounterVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 500,
				VoiceLines = 
				{
					UsePlayerSource = true,
					BreakIfPlayed = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
						{ Name = "MelinoeReloadEncounterVoiceLines", Time = 300 },
					},
					-- barrier events
					{
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnZombieBarrier01" },
							},
						},
						{ Cue = "/VO/MelinoeField_0627", Text = "They trying to escape...?" },
						{ Cue = "/VO/MelinoeField_0630", Text = "They're trapped in here..." },
						{ Cue = "/VO/MelinoeField_0631", Text = "Nowhere for them to go..." },
					},
					-- statue events
					{
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnZombieStatue01" },
							},
						},
						{ Cue = "/VO/MelinoeField_0639", Text = "This is my... Father...", PlayFirst = true },
						{ Cue = "/VO/MelinoeField_0640", Text = "All gathered by my father's statue..." },
					},
					-- gathering events
					{
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnZombieFountain01", "HubReturnZombieStatue01", "HubReturnZombieIsolated01" },
							},
						},
						{ Cue = "/VO/MelinoeField_0626", Text = "Some sort of gathering..." },
						{ Cue = "/VO/MelinoeField_0523", Text = "Minding their own business..." },
						{ Cue = "/VO/MelinoeField_0637", Text = "Should stay out of their way." },
					},
					-- moon events
					{
						-- RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnZombieIsolated03" },
							},
						},
						{ Cue = "/VO/MelinoeField_0638", Text = "They're drawn to the moonlight..." },
					},
					-- dormant events
					{
						-- RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnZombieCorpses01" },
							},
						},
						{ Cue = "/VO/MelinoeField_0632", Text = "It's been a busy night..." },
					},
					-- carrion events
					{
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnCarrionEating01" },
							},
						},
						{ Cue = "/VO/MelinoeField_0633", Text = "Disgusting..." },
						{ Cue = "/VO/MelinoeField_0634", Text = "{#Emph}Augh..." },
					},
					-- eidolon events
					{
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnMudman01", "HubReturnMudman02" },
							},
						},
						{ Cue = "/VO/MelinoeField_0636", Text = "Eidolons everywhere..." },
					},
					-- zombieassassin events
					{
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnAssassin01" },
							},
						},
						{ Cue = "/VO/MelinoeField_0635", Text = "What's that one doing here...?" },
					},
					-- other foes
					{
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsAny = { "HubReturnSpawners01", "HubReturnSpawners02", "HubReturnZombieHeavyRanged01" },
							},
						},
						{ Cue = "/VO/MelinoeField_0524", Text = "Don't mind me...!" },
					},
					-- miscellaneous
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.1,
						GameStateRequirements =
						{
							{
								PathFromArgs = true,
								Path = { "OriginalSource", "Name" },
								IsAny = { "Zombie_Passive" },
							},
							{
								PathFromArgs = true,
								Path = { "TriggerSource", "Name" },
								IsNone = { "HubReturnZombieIsolated02" },
							},
						},
						{ Cue = "/VO/MelinoeField_0521", Text = "What are they..." },
						{ Cue = "/VO/MelinoeField_0522", Text = "Poor wretches..." },
						{ Cue = "/VO/MelinoeField_0628", Text = "Those Shamblers..." },
						{ Cue = "/VO/MelinoeField_0629", Text = "What's with those Shamblers..." },
					},
				},
			}
		},
	},

	HubReturnZombieFountain01 =
	{
		InheritFrom = { "BaseHubReturn" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Zombie_Passive",
						TotalCount = 6,
						SpawnOnIds = { 664404, 664403, 664402, 664401, 664400, 664399 },
						SpawnOverrides =
						{
							SpawnAngleTowardId = 664734,
						},
						SpawnDefaultAIDataOverrides =
						{
							IdleAnimation = "Enemy_Zombie_IdleLookingDown",
						},
					},
				},
			},
		},
	},

	HubReturnZombieStatue01 =
	{
		InheritFrom = { "BaseHubReturn" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Zombie_Passive",
						TotalCount = 6,
						SpawnOnIds = { 662644, 662639, 662641, 662643, 662642, 662640 },
						SpawnOverrides =
						{
							SpawnAngleTowardId = 662489,
						},
						SpawnDefaultAIDataOverrides =
						{
							IdleAnimation = "Enemy_Zombie_IdleLookingUp",
						},
					},
				},
			},
		},
	},

	HubReturnZombieBarrier01 =
	{
		InheritFrom = { "BaseHubReturn" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = "<",
				Value = 6,
			},
		},		
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Zombie_Passive",
						TotalCount = 10,
						SpawnOnIds = { 664414, 664413, 664412, 664411, 664410, 664409, 664408, 664407, 664406, 664405 },
						SpawnOverrides =
						{
							SpawnAngleTowardId = 561136,
						},
						SpawnDefaultAIDataOverrides =
						{
							IdleAnimation = "Enemy_Zombie_IdleLookingUp",
						},
					},
				},
			},
		},
	},

	HubReturnZombieIsolated01 =
	{
		InheritFrom = { "BaseHubReturn" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Zombie_Passive",
						TotalCount = 5,
						SpawnOnIds = { 664415, 664416, 664417, 664419, 664420 },
						SpawnOverrides =
						{
							SpawnAngleTowardId = 691494,
						},
					},
				},
			},
		},
	},

	HubReturnZombieIsolated02 =
	{
		InheritFrom = { "BaseHubReturn" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Zombie_Passive",
						TotalCount = 1,
						SpawnOnIds = { 664421, },
						SpawnOverrides =
						{
							SpawnAngleTowardId = 662240,
						},
						SpawnDefaultAIDataOverrides =
						{
							IdleAnimation = "Enemy_Zombie_IdleLookingDown",
						},
					},
				},
			},
		},
	},

	HubReturnZombieIsolated03 =
	{
		InheritFrom = { "BaseHubReturn" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Zombie_Passive",
						TotalCount = 4,
						SpawnOnIds = { 664425, 664424, 664426, 664423 },
						SpawnOverrides =
						{
							SpawnAngleTowardId = 664446,
						},
						SpawnDefaultAIDataOverrides =
						{
							IdleAnimation = "Enemy_Zombie_IdleLookingUp",
						},
					},
				},
			},
		},
	},

	HubReturnZombieCorpses01 =
	{
		InheritFrom = { "BaseHubReturn" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Zombie_Passive",
						TotalCount = 5,
						SpawnOnIds = { 664432, 664428, 664429, 664430, 664431 },
						SpawnOverrides =
						{
							SpawnAngleMin = 0,
							SpawnAngleMax = 360,
						},
						SpawnDefaultAIDataOverrides =
						{
							IdleAnimation = "Enemy_Zombie_Prone_IdleLoop",
						},
					},
				},
			},
		},
	},

	HubReturnCarrionEating01 =
	{
		InheritFrom = { "BaseHubReturn" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Zombie_Passive",
						TotalCount = 2,
						SpawnOnIds = { 664433, 664436 },
						SpawnOverrides =
						{
							SpawnAnimation = "Enemy_Zombie_Prone_IdleLoop",
							SpawnAngleMin = -20,
							SpawnAngleMax = 40,
						},
					},
					{
						Name = "Carrion_Passive",
						TotalCount = 2,
						SpawnOnIds = { 664434, 664435 },
						SpawnOverrides =
						{
							SpawnAnimation = "Enemy_Carrion_PeckingGround",
							SpawnAngleTowardId = 664433,
						},							
					},
				},
			},
		},
	},

	HubReturnAssassin01 =
	{
		InheritFrom = { "BaseHubReturn" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ZombieAssassinIntro" }
			}
		},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieAssassin",
						TotalCount = 2,
						SpawnOnIds = { 660477, 660470, },
						SpawnOverrides =
						{
							PreferredSpawnPoint = "nil",
							AIAggroRange = 400,
						},
					},			
				},
			},
		},
	},

	HubReturnMudman01 =
	{
		InheritFrom = { "BaseHubReturn" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MudmanIntro" }
			}
		},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Mudman",
						TotalCount = 1,
						SpawnOnIds = { 664438, },
						SpawnOverrides =
						{
							PreferredSpawnPoint = "nil",
							AIOptions = { "IdleAI" },
							OnDamagedFunctionName = "AggroUnit",
							SpawnAngleMin = 250,
							SpawnAngleMax = 290,
						},
					},
					{
						Name = "MudmanEye",
						TotalCount = 3,
						SpawnOnIds = { 664440, 664441, 664442 },
						SpawnOverrides =
						{
							PreferredSpawnPoint = "nil",
							AIOptions = { "AggroAI" },
							PostAggroAI = "AttackAndDie",
							AIAggroRange = 200,
						},
					},
				},
			},
		},
	},

	HubReturnMudman02 =
	{
		InheritFrom = { "BaseHubReturn" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MudmanIntro" }
			}
		},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Mudman",
						TotalCount = 1,
						SpawnOnIds = { 664446, },
						SpawnOverrides =
						{
							PreferredSpawnPoint = "nil",
							AIOptions = { "IdleAI" },
							OnDamagedFunctionName = "AggroUnit",
							SpawnAngleMin = 250,
							SpawnAngleMax = 290,
						},
					},
					{
						Name = "MudmanEye",
						TotalCount = 3,
						SpawnOnIds = { 664443, 664444, 664445 },
						SpawnOverrides =
						{
							PreferredSpawnPoint = "nil",
							AIOptions = { "AggroAI" },
							PostAggroAI = "AttackAndDie",
							AIAggroRange = 200,
						},
					},
				},
			},
		},
	},

	HubReturnSpawners01 =
	{
		InheritFrom = { "BaseHubReturn" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ZombieSpawnerIntro" }
			}
		},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieSpawner",
						TotalCount = 2,
						SpawnOnIds = { 664448, 664447 },
						SpawnOverrides =
						{
							PreferredSpawnPoint = "nil",
							AIOptions = { "IdleAI" },
							OnDamagedFunctionName = "AggroUnit",
						},
					},
				},
			},
		},
	},

	HubReturnSpawners02 =
	{
		InheritFrom = { "BaseHubReturn" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ZombieSpawnerIntro" }
			}
		},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieSpawner",
						TotalCount = 1,
						SpawnOnIds = { 664449, },
						SpawnOverrides =
						{
							PreferredSpawnPoint = "nil",
							AIOptions = { "IdleAI" },
							OnDamagedFunctionName = "AggroUnit",
						},
					},
					{
						Name = "Zombie_Passive",
						TotalCount = 4,
						SpawnOnIds = { 664451, 664450, 664452, 664453, },
						SpawnOverrides =
						{
							SpawnAngleTowardId = 664449,
						},
						SpawnDefaultAIDataOverrides =
						{
							IdleAnimation = "Enemy_Zombie_IdleLookingUp",
						},
					},				
				},
			},
		},
	},

	HubReturnZombieHeavyRanged01 =
	{
		InheritFrom = { "BaseHubReturn" },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "ZombieHeavyRangedIntro" }
			}
		},
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieHeavyRanged",
						TotalCount = 1,
						SpawnOnIds = { 664454, },
						SpawnOverrides =
						{
							PreferredSpawnPoint = "nil",
							AIAggroRange = 9999,
							WeaponOptions = { "ZombieHeavyRangedToss_Hub" },
						},
					},			
				},
			},
		},
	},
})