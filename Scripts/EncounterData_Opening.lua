OverwriteTableKeys( EncounterData,
{
	-- Opening Encounters

	-- NOTE(andrew): OpeningEmpty, OpeningGeneratedF, FIntroFight, FCastTutorialFight
	-- moved to EncounterData.lua for Tech Test

	OpeningGeneratedN =
	{
		InheritFrom = { "GeneratedN" },
		CanEncounterSkip = true,
		RequireCompletedIntro = true,
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
					{
						FunctionName = "RequiredConfigOptions",
						FunctionArgs = { ConfigOptions = { "EditingMode" }, HasOptions = false },
					},
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
		CountsForRoomEncounterDepth = true,
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

		SpeakerNames = { "Intercom", },
		ThreadedEvents =
		{
			{
				FunctionName = "HadesSpeakingPresentation",
				Args = { SubtitleColor = Color.ChronosVoice, BlockColorGrade = true, OverlayAnim = "ChronosOverlay", VoiceLines = { GlobalVoiceLines = "ChronosAlertVoiceLines" }, StartSound = "/SFX/TimeSlowStart", UseSurvivalPresentation = true, StartDelay = 1.0 },
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
			Append = true,
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
			Append = true,
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
			Append = true,
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
			Append = true,
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
			Append = true,
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
			Append = true,
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
			Append = true,
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


	BasePIntroEncounters =
	{
		UnthreadedEvents = EncounterSets.EncounterEventsDefault,

		PreUnthreadedEvents =
		{
			{ FunctionName = "WaitForWithinDistance", Args = { DestinationId = 750675, Distance = 800 } }
		},

		CountsForRoomEncounterDepth = false,

		SpawnIntervalMin = 0.0,
		SpawnIntervalMax = 0.0,
		ActiveEnemyCapBase = 99,
		ActiveEnemyCapMax = 99,

		SpawnOverrides =
		{
			UseActivatePresentation = false,

			AIOptions = { "AmbientBattleAggroAI" },
			AmbientBattleAggroRange = 75,
			WakeUpDelay = 0.3,
			AggroReactionTimeMin = 0.15,
			AggroReactionTimeMax = 0.45,
		},

		SpawnDefaultAIDataOverrides =
		{
			TeleportToBattleFoeChance = 0.0,
		},

		GameStateRequirements =
		{
		},

		DistanceTriggers =
		{
			{
				Name = "OlympusFirstEnemySightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = { GlobalVoiceLines = "OlympusAssaultReactionLines" },
			}
		},	
	},

	PIntroCombat01 =
	{
		InheritFrom = { "BasePIntroEncounters" },

		PreUnthreadedEvents =
		{
			{ FunctionName = "WaitForWithinDistance", Args = { DestinationId = 750481, Distance = 800 } }
		},
		
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SentryBot",
						TotalCount = 3,
						SpawnOnIds = { 750614, 750613, 750612, },
					},
					{
						Name = "ZombieOlympus",
						TotalCount = 1,
						SpawnOnIds = { 750621, },
					},
				},
			},
		},
	},

	PIntroCombat02 =
	{
		InheritFrom = { "BasePIntroEncounters" },
		
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SentryBot",
						TotalCount = 3,
						SpawnOnIds = { 750628, 750626, 750627, },
					},
					{
						Name = "SatyrLancer2",
						TotalCount = 2,
						SpawnOnIds = { 744501, 744499, },
					},
				},
			},
		},
	},

	PIntroCombat03 =
	{
		InheritFrom = { "BasePIntroEncounters" },

		PreUnthreadedEvents =
		{
			{ FunctionName = "WaitForWithinDistance", Args = { DestinationId = 750481, Distance = 800 } }
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonEnforcer",
						TotalCount = 1,
						SpawnOnIds = { 750624, },
					},
					{
						Name = "SatyrCrossbow2",
						TotalCount = 1,
						SpawnOnIds = { 750613, },
					},
				},
			},
		},	
	},

	PIntroCombat04 =
	{
		InheritFrom = { "BasePIntroEncounters" },

		PreUnthreadedEvents =
		{
			{ FunctionName = "WaitForWithinDistance", Args = { DestinationId = 750481, Distance = 800 } }
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonBeamer",
						TotalCount = 1,
						SpawnOnIds = { 744498 },
					},
					{
						Name = "ZombieOlympus",
						TotalCount = 7,
						SpawnOnIds = { 744501, 750625, 750624, 750623, 750614, 750613, 750612, },
					},
				},
			},
		},	
	},

	PIntroCombat05 =
	{
		InheritFrom = { "BasePIntroEncounters" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonEnforcer",
						TotalCount = 2,
						SpawnOnIds = { 744498, 750626, },
					},
					{
						Name = "HarpyDropper",
						TotalCount = 3,
						SpawnOnIds = { 750623, 750624, 750625, },
					},
				},
			},
		},	
	},

	PIntroCombat06 =
	{
		InheritFrom = { "BasePIntroEncounters" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Dragon_Elite",
						TotalCount = 1,
						SpawnOnIds = { 744503, },
					},
					{
						Name = "SentryBot",
						TotalCount = 5,
						SpawnOnIds = { 750626, 750623, 750627, 750628, 750674, },
					},
				},
			},
		},	

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "DragonIntro" },
			},
		},
	},

	PIntroCombat07 =
	{
		InheritFrom = { "BasePIntroEncounters" },

		PreUnthreadedEvents =
		{
			{ FunctionName = "WaitForWithinDistance", Args = { DestinationId = 750481, Distance = 800 } }
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonBeamer_Elite",
						TotalCount = 1,
						SpawnOnIds = { 750613, },
					},
					{
						Name = "SatyrLancer2",
						TotalCount = 3,
						SpawnOnIds = { 750622, 750621, 750620, 750619, },
					},
				},
			},
		},	
	},

	PIntroCombat08 =
	{
		InheritFrom = { "BasePIntroEncounters" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrCrossbow2_Elite",
						TotalCount = 1,
						SpawnOnIds = { 750624, },
					},
					{
						Name = "AutomatonEnforcer_Elite",
						TotalCount = 1,
						SpawnOnIds = { 750628, },
					},
				},
			},
		},	
	},

	PIntroCombat09 =
	{
		InheritFrom = { "BasePIntroEncounters" },

		PreUnthreadedEvents =
		{
			{ FunctionName = "WaitForWithinDistance", Args = { DestinationId = 750481, Distance = 800 } }
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 1,
						SpawnOnIds = { 750613, },
					},
					{
						Name = "SatyrLancer2",
						TotalCount = 2,
						SpawnOnIds = { 750612, 750614, },
					},
					{
						Name = "AutomatonBeamer",
						TotalCount = 1,
						SpawnOnIds = { 750624, },
					},
					{
						Name = "SentryBot",
						TotalCount = 2,
						SpawnOnIds = { 750625, 750623, },
					},
				},
			},
		},	
	},

	PIntroCombat_ZombieFishing =
	{
		InheritFrom = { "BasePIntroEncounters" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieOlympus",
						TotalCount = 1,
						SpawnOnIds = { 750611, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattleTargetId = 744361,
						},	
					},
				},
			},
		},	
	},

	PIntroCombat_ZombieQuad =
	{
		InheritFrom = { "BasePIntroEncounters" },
		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieOlympus",
						TotalCount = 5,
						SpawnOnIds = { 744498, 744503, 744499, 744502, 744501, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattleTargetId = 744618,
						},	
					},
				},
			},
		},	
	},

	PIntroCombat_DragonQuad =
	{
		InheritFrom = { "BasePIntroEncounters" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Dragon",
						TotalCount = 2,
						SpawnOnIds = { 744501, 744502, 744499, 744503, 744498, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 40055, 750625, },
						},	
					},
				},
			},
		},

		StartRoomUnthreadedEvents =
		{
			Append = true,
			{
				FunctionName = "SpawnOlympusCorpses",
				Args =
				{
					CountMin = 10,
					CountMax = 10,
					SpawnOnIds = { 744501, 750627, 750626, 750625, 750674, 744503, 744498, 744502, 750628, 744499, 750623, 750624, },
					ObstacleOptions =
					{
						"OlympusCorpseSentryBotA",
						"OlympusCorpseSentryBotA",
						"OlympusCorpseSentryBotB",
						"OlympusCorpseSentryBotB",
						"OlympusCorpseSentryBotC",
						"OlympusCorpseSentryBotC",
					}
				}
			}
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "DragonIntro" },
			},
		},

		DistanceTriggers =
		{
			{
				Name = "OlympusFirstEnemySightedVoiceLines",
				TriggerGroup = "EnemyTeam", WithinDistance = 600,
				VoiceLines = { GlobalVoiceLines = "OlympusAssaultReactionLines" },
			}
		},		
	},

	PIntroCombat_SapperGate =
	{
		InheritFrom = { "BasePIntroEncounters" },
		ForceIfEncounterNotCompleted = "PIntroCombat_SapperGate",

		PreUnthreadedEvents = {},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 3,
						SpawnOnIds = { 750674, 744499, 750673, },
						SpawnOverrides =
						{
							AmbientBattleAggroRange = 100,
							AggroReactionTimeMin = 10.15,
							AggroReactionTimeMax = 10.45,
							WakeUpDelay = 0.3,
						},
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattleTargetId = 750676,
						},	

					},
				},
			},
		},	
	},

	PIntroCombat_CrossbowStatues =
	{
		InheritFrom = { "BasePIntroEncounters" },
		ForceIfEncounterNotCompleted = "PIntroCombat_SapperGate",

		PreUnthreadedEvents =
		{
			{ FunctionName = "WaitForWithinDistance", Args = { DestinationId = 750481, Distance = 800 } }
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrCrossbow2",
						TotalCount = 3,
						SpawnOnIds = { 750612, 750614, 750621, },
						SpawnOverrides =
						{
							AmbientBattleAggroRange = 100,
							AggroReactionTimeMin = 10.15,
							AggroReactionTimeMax = 10.45,
							WakeUpDelay = 0.3,
						},
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 764540, 764539, },
						},

					},
				},
			},
		},	
	},

	PIntroCombat_SapperOverlook =
	{
		InheritFrom = { "BasePIntroEncounters" },
		ForceIfEncounterNotCompleted = "PIntroCombat_SapperGate",

		PreUnthreadedEvents = {},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 3,
						SpawnOnIds = { 750626, 750674, 744498, },
						SpawnOverrides =
						{
							AmbientBattleAggroRange = 100,
							AggroReactionTimeMin = 10.15,
							AggroReactionTimeMax = 10.45,
							WakeUpDelay = 0.3,
						},
						SpawnOverrides =
						{
							WeaponOptions =
							{
								"SatyrSapperLob_PreCombat"
							},
						},
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 750625, 750624, 750623, 750627, 744499, 750673, 750611, 744503, 744501, },
						},

					},
				},
			},
		},

		StartRoomUnthreadedEvents =
		{
			Append = true,
			{
				FunctionName = "SpawnOlympusCorpses",
				Args =
				{
					CountMin = 3,
					CountMax = 5,
					SpawnOnIds = { 750625, 750624, 750623, 750627, 744499, 750673, 750611, 744503, 744501, },
					ObstacleOptions =
					{
						"OlympusCorpseAutomatonBeamerA",
						"OlympusCorpseAutomatonBeamerB",
						"OlympusCorpseAutomatonBeamerC",

						"OlympusCorpseAutomatonEnforcerA",
						"OlympusCorpseAutomatonEnforcerB",
						"OlympusCorpseAutomatonEnforcerC",
					}
				}
			}
		},
	},

	PIntroCombat_CrossbowSiege =
	{
		InheritFrom = { "BasePIntroEncounters" },
		DebugOnly = true,
		ForceIfEncounterNotCompleted = "PIntroCombat_SapperGate",

		PreUnthreadedEvents = {},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrCrossbow2",
						TotalCount = 3,
						SpawnOnIds = { 750622, 750614, 750619, 750612, },
						SpawnOverrides =
						{
							AmbientBattleAggroRange = 100,
							AggroReactionTimeMin = 10.15,
							AggroReactionTimeMax = 10.45,
							WakeUpDelay = 0.3,
						},
						SpawnOverrides =
						{
							WeaponOptions =
							{
								"SatyrCrossbowFadeBolt_PreCombat"
							},
						},
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 764152, 747524, },
						},

					},
				},
			},
		},	
	},

	P_BaseVignette =
	{
		InheritFrom = { "GeneratedP_PreCombat" },

		SpawnDefaultAIDataOverrides =
		{
			TeleportToBattleFoeChance = 0.0,
		},
	},

	P_Combat01_PreCombat01 = -- Chronos Siege, Zombie gag
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 1,
						SpawnOnIds = { 763003 },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattleTargetId = 763004,
						},
					},
					{
						Name = "ZombieOlympus",
						TotalCount = 4,
						SpawnOnIds = { 762883, 762878, 762931, 762930, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattleTargetId = 723153,
						},
					},
				},
			},
		},
	},

	P_Combat01_PreCombat02 = -- Corpses at Exit
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrLancer2",
						TotalCount = 3,
						SpawnOnIds = { 762916, 762934, 762933, 762915, 762914, 762939, 762929, 762935, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 762917, 763003, 762924, 762923, 762922, 762925, 762918, },
						},
					},
				},
			},
		},

		StartRoomUnthreadedEvents =
		{
			Append = true,
			{
				FunctionName = "SpawnOlympusCorpses",
				Args =
				{
					CountMin = 3,
					CountMax = 5,
					SpawnOnIds = { 762917, 763003, 762924, 762923, 762922, 762925, 762918, },
					ObstacleOptions =
					{
						"OlympusCorpseAutomatonBeamerA",
						"OlympusCorpseAutomatonBeamerB",
						"OlympusCorpseAutomatonBeamerC",

						"OlympusCorpseAutomatonEnforcerA",
						"OlympusCorpseAutomatonEnforcerB",
						"OlympusCorpseAutomatonEnforcerC",
					}
				}
			}
		},
	},

	P_Combat02_PreCombat01 = -- SentryBot Defensive formation
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SentryBot",
						TotalCount = 6,
						SpawnOnIds = { 762870, 762869, 762868, 762867, 762872, 762871, },
					},
					{
						Name = "SatyrLancer2",
						TotalCount = 2,
						SpawnOnIds = { 763017, 763022, },
					},
				},
			},
		},
	},

	P_Combat02_PreCombat02 = -- Attacking Hestia Statues
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 2,
						SpawnOnIds = { 762918, 762877, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 768171, 723194 },
						},
					},
					{
						Name = "SatyrLancer2",
						TotalCount = 2,
						SpawnOnIds = { 768169, 762920, 763009, 762927, 768168, 763016, 763013, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattleTargetId = 723189,
						},
					},
				},
			},
		},
	},

	P_Combat03_PreCombat01 = -- Sappers lobbing the foreground
	{
		InheritFrom = { "P_BaseVignette" },

		AmbientBattleDamagePerGroup =
		{
			ChronosForces = { Min = 0.05, Max = 0.2 },
			Automatons = { Min = 0.8, Max = 0.9 },
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 3,
						SpawnOnIds = { 763033, 763030, 763078 },
					},
					{
						Name = "SentryBot",
						TotalCount = 9,
						SpawnOnIds = { 763024, 763025, 763026, 763028, 763068, 763072, 763070, 763069, 763018, 763021, 763020, 763019, },
					},
				},
			},
		},
	},

	P_Combat04_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 3,
						SpawnOnIds = { 763203, 763202, 763205, 763201, 763204, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattleTargetId = 723596,
						},	

					},
				},
			},
		},
	},

	P_Combat05_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrCrossbow2",
						TotalCount = 3,
						SpawnOnIds = { 723361, 762859, 762835 },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 763010, 763006, 763011 },
						},	
						SpawnOverrides =
						{
							WeaponOptions =
							{
								"SatyrCrossbowShieldedBolt", "SatyrCrossbowFadeBolt"
							},
						},
					},
				},
			},
		},
	},

	P_Combat05_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Dragon",
						TotalCount = 1,
						SpawnOnIds = { 762851 },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 723219 },
						},
					},
				},
			},
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "DragonIntro" },
			},
		},
	},

	P_Combat06_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonBeamer",
						TotalCount = 3,
						SpawnOnIds = { 763186, 763185, 763189, 763190, },
					},
					{
						Name = "SatyrLancer2",
						TotalCount = 6,
						SpawnOnIds = { 763232, 763231, 763224, 763220, 763219, 763213, 763218, },
					},
				},
			},
		},
	},

	P_Combat06_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "HarpyDropper",
						TotalCount = 6,
						SpawnOnIds = { 763253, 763200, 763219, 763180, 763246, 763183, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 723240, 723241, },
						},
					},
				},
			},
		},
	},

	P_Combat07_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 1,
						SpawnOnIds = { 763237, },
					},
					{
						Name = "SatyrLancer2",
						TotalCount = 2,
						SpawnOnIds = { 763239, 763288, },
					},
					{
						Name = "AutomatonEnforcer_Elite",
						TotalCount = 1,
						SpawnOnIds = { 763294, },
					},
				},
			},
		},
	},

	P_Combat08_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieOlympus",
						TotalCount = 10,
						SpawnOnIds = { 768439, 768453, 768454, 768461, 768477, 768476, 768475, 768433, 768478, 768456, 768394, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 768347, 723166, 768348, 768346, 768345, 723167, 768479 },
						},
					},
				},
			},
		},
	},

	P_Combat08_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "HarpyDropper",
						TotalCount = 3,
						SpawnOnIds = { 768404, 768473, 768466, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 723167, },
						},
					},
				},
			},
		},
	},

	P_Combat09_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonEnforcer_Elite",
						TotalCount = 1,
						SpawnOnIds = { 762971, },
					},
					{
						Name = "SatyrLancer2",
						TotalCount = 3,
						SpawnOnIds = { 763030, 763054, 763024, },
					},
				},
			},
		},
	},

	P_Combat09_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper_Elite",
						TotalCount = 2,
						SpawnOnIds = { 762968, 762965, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 768300, 768301, },
						},
					},
				},
			},
		},
	},

	P_Combat10_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "HarpyDropper",
						TotalCount = 2,
						SpawnOnIds = { 768094, 768023, 768052, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 723024, },
						},
					},
					{
						Name = "SatyrSapper",
						TotalCount = 1,
						SpawnOnIds = { 768040 },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 767989, },
						},
					},
				},
			},
		},
	},

	P_Combat11_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Dragon_Elite",
						TotalCount = 1,
						SpawnOnIds = { 723651 },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 723669, },
						},
					},
				},
			},
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "DragonIntro" },
			},
		},
	},

	P_Combat11_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrSapper",
						TotalCount = 1,
						SpawnOnIds = { 723674, 723677, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 723678, 723679, },
						},
					},
				},
			},
		},
	},

	P_Combat12_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SentryBot",
						TotalCount = 6,
						SpawnOnIds = { 768658, 768659, 768654, 768622, 768623, 768618, 768619, 768621, 768655, 768657, },
					},
					{
						Name = "ZombieOlympus",
						TotalCount = 10,
						SpawnOnIds = { 768678, 768677, 768693, 768692, 768697, 768698, 768661, 768660, 768701, 768704, 768691, 768687, 768686, 768679, },
					},
				},
			},
		},
	},

	P_Combat12_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		RandomizeAmbientBattleDamagePerGroup =
		{
			GroupNames = { "ChronosForces" },
			BattleDamageDataOptions =
			{
				{ Min = 0.75, Max = 0.95 },
			},
		},

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "ZombieOlympus",
						TotalCount = 10,
						SpawnOnIds = { 768668, 768673, 768670, 768620, 768622, 768655, 768659, 768654, 768691, 768692, 768693, 768706, 768680, 768676, 768675, 768704, 768700, 768661, },
					},
				},
			},
		},

		StartRoomUnthreadedEvents =
		{
			Append = true,
			{
				FunctionName = "SpawnOlympusCorpses",
				Args =
				{
					CountMin = 4,
					CountMax = 4,
					SpawnOnIds = { 768621, 768669, 768618, 768667, },
					ObstacleOptions =
					{
						"OlympusCorpseAutomatonBeamerA",
						"OlympusCorpseAutomatonBeamerB",
						"OlympusCorpseAutomatonBeamerC",
					}
				}
			}
		},
	},

	P_Combat13_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "AutomatonBeamer",
						TotalCount = 2,
						SpawnOnIds = { 763105, 763102, },
					},
					{
						Name = "AutomatonEnforcer",
						TotalCount = 2,
						SpawnOnIds = { 763147, },
					},
					{
						Name = "SatyrCrossbow2",
						TotalCount = 3,
						SpawnOnIds = { 763121, 763125, 763127, 763129, 763140, 763142, 763124, },
					},
				},
			},
		},
	},

	P_Combat13_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Dragon",
						TotalCount = 2,
						SpawnOnIds = { 763093, 763148, 763160, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 738536, },
						},
					},
				},
			},
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "DragonIntro" },
			},
		},
	},

	P_Combat13_PreCombat03 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrCrossbow2",
						TotalCount = 2,
						SpawnOnIds = { 763098, 763096, 763146, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 763088, 763089, },
						},
					},
				},
			},
		},

		StartRoomUnthreadedEvents =
		{
			Append = true,
			{
				FunctionName = "SpawnOlympusCorpses",
				Args =
				{
					CountMin = 10,
					CountMax = 10,
					SpawnOnIds = { 763105, 763102, 763101, 763103, 763107, 763106, 763155, 763153, 763154, 763148, 763087, },
					ObstacleOptions =
					{
						"OlympusCorpseSentryBotA",
						"OlympusCorpseSentryBotA",
						"OlympusCorpseSentryBotB",
						"OlympusCorpseSentryBotB",
						"OlympusCorpseSentryBotC",
						"OlympusCorpseSentryBotC",
					}
				}
			}
		},
	},

	P_Combat14_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SentryBot",
						TotalCount = 6,
						SpawnOnIds = { 763408, 763409, 763410, 763400, 763406, 763403, },
					},
					{
						Name = "AutomatonEnforcer",
						TotalCount = 1,
						SpawnOnIds = { 763413, },
					},
					{
						Name = "ZombieOlympus_Elite",
						TotalCount = 8,
						SpawnOnIds = { 763415, 763418, 763373, 763372, 763375, 763374, 763376, 763377, 763411, 763414, 763351, 763352, 763416, 763417, },
					},
				},
			},
		},
	},

	P_Combat14_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Dragon_Elite",
						TotalCount = 1,
						SpawnOnIds = { 763350, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 738618, },
						},
					},
				},
			},
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "DragonIntro" },
			},
		},
	},

	P_Combat15_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "Dragon",
						TotalCount = 1,
						SpawnOnIds = { 763433, 763449, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 756136, },
						},
					},
				},
			},
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "DragonIntro" },
			},
		},
	},

	P_Combat15_PreCombat02 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrCrossbow2",
						TotalCount = 1,
						SpawnOnIds = { 763456, 763446, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 763442, 763436, },
						},
					},
				},
			},
		},
	},

	P_Combat16_PreCombat01 =
	{
		InheritFrom = { "P_BaseVignette" },

		SpawnWaves =
		{
			{
				Spawns =
				{
					{
						Name = "SatyrCrossbow2",
						TotalCount = 2,
						SpawnOnIds = { 763487, 763483, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 756234, },
						},
					},
					{
						Name = "SatyrSapper_Elite",
						TotalCount = 2,
						SpawnOnIds = { 763479, 763481, },
						SpawnDefaultAIDataOverrides =
						{
							AmbientBattlePickClosestTargetIds = { 756234, },
						},
					},
				},
			},
		},
	},
})