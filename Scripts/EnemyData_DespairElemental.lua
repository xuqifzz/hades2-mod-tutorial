UnitSetData.DespairElemental =
{	
	DespairElemental =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 440,

		HealthBarOffsetY = -260,

		ActiveCapWeight = 0.35,

		IsAggroedSound = "/SFX/Enemy Sounds/DespairElementalRegular/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/DespairElementalRegular/EmoteDying",

		ActivateAnimation = "Enemy_DespairElemental_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainQuick",
		ActivateFx2 = "EnemyPreSpawnStandingQuick",
		ActivateFxPreSpawn = "nil",
		ActivateFxPreSpawnDelay = 0.25,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 0.25,
		ActivateTint = true,
		ActivateTintDelay = 0.75,
		ActivateTintDuration = 0.5,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.75,
		ActiveCapWeight = 0.30,

		DeathAnimation = "Enemy_DespairElemental_Death",
		DeathFx = "EnemyDeathFxIris",

		UseActivatePresentation = true,

		PreferredSpawnPoint = "EnemyPointMelee",
		Material = "Bone",

		IsAggroedSound = "/SFX/Enemy Sounds/Screamer/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Screamer/EmoteDying",

		StunAnimations = 
		{
			Default = "Enemy_DespairElemental_OnHit",
		},

		AIOptions = { "AggroAI" },
		WanderTowardTypes = { "EnemyPointSupport" },
		AIWanderFrequency = 10.0,
		AlliedScaleMultiplier = 1.0,

		AIAggroRange = 2500,
		AIChainAggroRange = 0,
		ChainAggroAllEnemies = false,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		DumbFireWeapons =
		{
			"DespairElementalRam"
		},

		WeaponOptions = { "DespairElementalChase" },

		ActiveCapWeight = 0.25,
		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"DespairElemental_Elite"}
		},
	},
	DespairElemental_Elite =
	{
		InheritFrom = { "DespairElemental" },
		HealthBuffer = 440,

		IsAggroedSound = "/SFX/Enemy Sounds/DespairElementalRegular/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"DespairElemental"}
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 2,
		},
	},

	DespairElementalLarge =
	{
		InheritFrom = { "DespairElemental" },
		MaxHealth = 600,
		HealthBarOffsetY = -350,

		IsAggroedSound = "/SFX/Enemy Sounds/DespairElementalHuge/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/DespairElementalHuge/EmoteDying",

		--WeaponOptions = { "DespairElementalLargeChase" },
		DumbFireWeapons = { "DespairElementalLargeRam" },

		GeneratorData =
		{
			DifficultyRating = 300,
			BlockEnemyTypes = {"DespairElementalLarge_Elite"}
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 4,
		},
	},
	DespairElementalLarge_Elite =
	{
		InheritFrom = { "DespairElementalLarge" },
		HealthBuffer = 500,

		IsAggroedSound = "/SFX/Enemy Sounds/DespairElementalHuge/EmoteTaunting",

		GeneratorData =
		{
			DifficultyRating = 480,
			BlockEnemyTypes = {"DespairElementalLarge"}
		},
	},

	DespairElemental_Passive =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 999999,

		IsAggroedSound = "/SFX/Enemy Sounds/DespairElementalHuge/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/DespairElementalHuge/EmoteDying",

		AIOptions = { "AggroAI" },
		AIAggroRange = 1,
		AIWanderDistance = 2000,
		AggroAIRefreshDuration = 5.0,
		AggroIfLastAlive = false,
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.DespairElemental )