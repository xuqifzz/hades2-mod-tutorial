UnitSetData.Carrion =
{

	Carrion =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		Groups = { "FlyingEnemies" },
		Material = "Bone",
		--ActivateFx = "TeleportDisappearSmall",

		MaxHealth = 60,
		HealthBarOffsetY = -175,
		HitSparkScale = 1.0,
		HitSparkOffsetZ = 30,

		AggroReactionTime = 0.5,
		--WakeUpDelay = 1.0,
		ChainAggroAllEnemies = false,

		ActivateAnimation = "Enemy_Carrion_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateTint = true,
		ActivateTintDelay = 0.70,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0, 
		ActivateDuration = 1.5,
		ActivateStartOffsetZ = 750,
		ActivateGravity = 650,
		--ActivateFallForce = -2500,

		ActivateSwoopPresentation = true,

		IsAggroedSound = "/SFX/Enemy Sounds/Carrion/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Carrion/EmoteDying",
		DeathFx = "EnemyDeathFxUndeadCarrion",
		Material = "Organic",
		
		PreferredSpawnPoint = "EnemyPoint",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedUndeadCarrion",
			Rapid = "HitSparkEnemyDamagedUndeadRapid",
		},
		
		StunAnimations = 
		{
			Default = "Enemy_Carrion_HitStun",
			Heavy = "Enemy_Carrion_HitStun_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			OrbitTickDegrees = 30,
			OrbitTickDuration = 0.8,
			OrbitDistance = 525,

			OrbitAIDurationMin = 5.5,
			OrbitAIDurationMax = 7.5,

			RandomOrbitDirection = true,

			PostOrbitAI = "AttackerAI",
		},

		MoneyDropOnDeath =
		{
			Chance = 0.25,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},
		HeraclesCombatMoneyValue = 1,

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1200,

		WeaponOptions = { "CarrionSweep" },

		GeneratorData =
		{
			DifficultyRating = 11,
			BlockEnemyTypes = {"Carrion_Elite"}
		},
		ActiveCapWeight = 0.5,

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

			{ Cue = "/VO/MelinoeField_0443", Text = "Bronzebeaks." },
			{ Cue = "/VO/MelinoeField_0444", Text = "Bronzebeaks!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0445", Text = "More Bronzebeaks." },
			{ Cue = "/VO/MelinoeField_0446", Text = "Here, Bronzebeaks...!" },
		},
	},

	Carrion_Passive =
	{
		InheritFrom = { "Carrion" },

		AIOptions = { "IdleAI" },
		OnDamagedFunctionName = "AggroUnit",
		WakeUpDelayMin = 0.0,
		WakeUpDelayMax = 0.5,
		PreferredSpawnPoint = "EnemyPoint",
		IgnoreCurseDamage = true,
		
		DefaultAIData =
		{
			DeepInheritance = true,
			IdleAnimation = "Enemy_Carrion_PeckingGround",
		},
	},

	Carrion_Elite =
	{
		InheritFrom = { "Carrion" },
		HealthBuffer = 60,

		IsAggroedSound = "/SFX/Enemy Sounds/Carrion/EmoteTaunting",

		WeaponOptions = { "CarrionSweep_Elite" },

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		HeraclesCombatMoneyValue = 2,

		GeneratorData =
		{
			DifficultyRating = 22,
			BlockEnemyTypes = {"Carrion"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Carrion )