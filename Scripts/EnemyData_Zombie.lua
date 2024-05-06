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
		ActivateFxPreSpawn = "Blank",
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

		MoneyDropOnDeath =
		{
			Chance = 0.5,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
		HeraclesCombatMoneyValue = 2,

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

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
			},
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0452", Text = "Shamblers!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HeraclesCombatN" },
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0451", Text = "Shamblers.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0452", Text = "Shamblers!" },
			{ Cue = "/VO/MelinoeField_0453", Text = "Shamblers..." },
			{ Cue = "/VO/MelinoeField_0454", Text = "Shamblers ahead..." },
		},
	},

	Zombie_Passive =
	{
		InheritFrom = { "Zombie" },

		AIOptions = { "IdleAI" },
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
		InheritFrom = { "Zombie" },
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
		InheritFrom = { "Zombie" },
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
			RequiredMinBiomeDepth = 3,
		},

		HeraclesCombatMoneyValue = 5,

		GeneratorData =
		{
			DifficultyRating = 35,
			BlockEnemyTypes = {"ZombieCrewman"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Zombie )