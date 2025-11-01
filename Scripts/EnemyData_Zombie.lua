UnitSetData.Zombie =
{

	Zombie =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },

		MaxHealth = 170,
		HealthBarOffsetY = -200,
		HealthBarType = "Medium",

		ActivateAnimation = "Enemy_Zombie_Spawn",
		ActivateFx = "EphyraZombieHoleIn",
		ActivateFx2 = "EphyraZombieSpawnMask",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1, 
		--ActivateMask = true,
		--ActivateMaskDuration = 0.2,
		--ActivateMaskDelay = 0.6,

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedUndead",
			Rapid = "HitSparkEnemyDamagedUndeadRapid",
		},

		DeathAnimation = "Enemy_Zombie_Death",
		DeathFx = "EnemyDeathFxUndead",
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/Zombie/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Zombie/EmoteDying",

		PreferredSpawnPoint = "EnemyPoint",
		Groups = { "GroundEnemies" },
		OnHitShake = { Distance = 8, Speed = 550, Duration = 0.155 },

		AIOptions =
		{
			"AggroAI",
		},
		
		PlayStunAnimationOnHealthBufferDeplete = true,
		StunAnimations = 
		{
			Default = "Enemy_Zombie_OnHit",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			RetreatBufferDistance = 550,
			RetreatAfterAttackChance = 0.35,
			RetreatTimeoutMin = 1.0,
			RetreatTimeoutMax = 2.0,
		},

		HeraclesCombatMoneyValue = 2,
		MoneyDropOnDeath =
		{
			Chance = 0.25,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.17,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		WeaponOptions =
		{
			"ZombieMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 6,
			BlockEnemyTypes = {"Zombie_Elite"}
		},

		ActiveCapWeight = 0.35,

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "OlympusIntro" },
				},
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0451", Text = "Shamblers." },
			{ Cue = "/VO/MelinoeField_0452", Text = "Shamblers!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0453", Text = "Shamblers..." },
			{ Cue = "/VO/MelinoeField_0454", Text = "Shamblers ahead...",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "O" },
					},
				},
			},
		},
	},

	Zombie_Passive =
	{
		InheritFrom = { "Zombie" },

		AIOptions = { "IdleAI" },
		CanBeAggroed = true,
		CanBeChainAggroed = false,
		OnDamagedFunctionName = "AggroUnit",
		WakeUpDelayMin = 0.0,
		WakeUpDelayMax = 0.5,
		--PreferredSpawnPoint = "EnemyPointMelee",
		IgnoreCurseDamage = true,

		DefaultAIData =
		{
			DeepInheritance = true,
		},
	},

	Zombie_Elite =
	{
		InheritFrom = { "Elite", "Zombie" },
		HealthBuffer = 170,

		IsAggroedSound = "/SFX/Enemy Sounds/Zombie/EmoteTaunting",

		WeaponOptions =
		{
			"ZombieMelee_Elite",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		HeraclesCombatMoneyValue = 5,

		GeneratorData =
		{
			DifficultyRating = 16,
			BlockEnemyTypes = {"Zombie"}
		},
	},

	ZombieCrewman =
	{
		InheritFrom = { "BaseOEnemy", "Zombie" },
		BlockNextBiomeEnemyShrineUpgrade = true,

		MaxHealth = 260,

		IsAggroedSound = "/SFX/Enemy Sounds/Zombie/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,

		},

		WeaponOptions =
		{
			"ZombieMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 15,
			BlockEnemyTypes = {"ZombieCrewman_Elite"}
		},
	},

	ZombieCrewman_Elite =
	{
		InheritFrom = { "ZombieCrewman" },
		HealthBuffer = 260,

		IsAggroedSound = "/SFX/Enemy Sounds/Zombie/EmoteTaunting",

		WeaponOptions =
		{
			"ZombieMelee_Elite",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 3,
			},
		},

		HeraclesCombatMoneyValue = 5,

		GeneratorData =
		{
			DifficultyRating = 35,
			BlockEnemyTypes = {"ZombieCrewman"}
		},
	},

	ZombieOlympus =
	{
		InheritFrom = { "BasePEnemy", "BaseChronosForces", "Zombie" },
		MaxHealth = 590,
		ActivateFx = "EarthElementalHoleIn",
		ActivateFx2 = "EarthElementalSpawnMask",

		GrannyTexture = "GR2/ZombieOlympus_Color",

		PreferredSpawnPoint = "EnemyPointRanged", -- Chronos Forces spawn on these.
		Groups = { "GroundEnemies", "ChronosForces" },

		DefaultAIData =
		{
			DeepInheritance = true,

			AmbientBattleTargetGroups = { "Automatons" },
		},
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysicalOlympus",
			Rapid = "HitSparkEnemyDamagedPhysicalOlympusRapid",
		},
		WeaponOptions =
		{
			"ZombieOlympusMelee",
		},

		HeraclesCombatMoneyValue = 1,
		GeneratorData =
		{
			DifficultyRating = 35,
			BlockEnemyTypes = {"ZombieOlympus_Elite"}
		},
	},

	ZombieOlympus_Elite =
	{
		InheritFrom = { "ZombieOlympus" },
		HealthBuffer = 350,

		WeaponOptions =
		{
			"ZombieOlympusMelee_Elite",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 3,
			},
		},

		HeraclesCombatMoneyValue = 2,
		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"ZombieOlympus"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Zombie )