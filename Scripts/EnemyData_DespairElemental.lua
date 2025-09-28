UnitSetData.DespairElemental =
{	
	DespairElemental =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 440,

		HealthBarOffsetY = -260,

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

		DeathAnimation = "Enemy_DespairElemental_Death",
		DeathFx = "EnemyDeathFxIris",

		UseActivatePresentation = true,

		PreferredSpawnPoint = "EnemyPointMelee",
		Material = "Bone",

		SkipUnitHitFlash = true,

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
		SpellSummonDataOverrides =
		{
			WeaponOptions = { "DespairElementalChase_Ally" },
		},

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
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 2,
			},
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.DespairElemental )