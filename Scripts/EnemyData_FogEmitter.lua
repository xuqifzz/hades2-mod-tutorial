UnitSetData.FogEmitter =
{
	FogEmitter =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		ActivateFx = "EnemyPreSpawnTerrainLarge",
		ActivateFx2 = "EnemyPreSpawnStandingLarge",
		ActivateFxPreSpawn = "EnemySpawnBurstLarge",
		ActivateAnimation = "Enemy_FogEmitter_Spawn",
		DeathFx = "EnemyDeathFxIris",
		DeathAnimation = "Enemy_FogEmitter_Death",
		InvulnerableFx = "nil",

		BlockRaiseDead = true,

		MaxHealth = 290,
		HealthBarOffsetY = -300,
		HitInvulnerableText = "Blank",

		IsAggroedSound = "/SFX/Enemy Sounds/FogEmitter/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/FogEmitter/EmoteDying",

		PreferredSpawnPoint = "EnemyPointRanged",
		Material = "Organic",

		AIOptions =
		{
			"GuardAI",
		},
		AdditionalAIFunctions = { "FogAI" },

		StunAnimations = 
		{
			Default = "Enemy_FogEmitter_HitStun",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			FogRadius = 725,
			FogRadiusScaleY = 0.85,
			EnterFogRadiusBuffer = 0,
			ExitFogRadiusBuffer = 0,
			OutsideFogFx = "FogEmitterOutside",
			InsideFogFx = "FogEmitterInside",

			TargetGroups = { "HeroTeam" },

			PreAttackSound = "/SFX/Enemy Sounds/FogEmitter/EmoteCharging"
		},
		StopAnimationsOnDeath = { "FogEmitterInside", "FogEmitterOutside" },

		WeaponOptions =
		{
			"FogEmitterSweep", "FogEmitterSlam"
		},

		MoneyDropOnDeath =
		{
			Chance = 1.0,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 50,
			MaxValue = 70,
			--ValuePerDifficulty = 0.2,
			--ValuePerDifficultyMaxValueVariance = 1.3,
		},

		GeneratorData =
		{
			DifficultyRating = 22,
			MaxCount = 1,
			BlockSolo = true,
			BlockEnemyTypes = {"FogEmitter_Elite"}
		},
	},

	FogEmitter_Elite =
	{
		InheritFrom = { "Elite", "FogEmitter" },
		MaxHealth = 510,
		HealthBuffer = 1450,
		
		BlockRespawnShrineUpgrade = true,

		IsAggroedSound = "/SFX/Enemy Sounds/FogEmitter/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"FogEmitterSweep", "FogEmitterSlam",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 5,
		},

		GeneratorData =
		{
			DifficultyRating = 50,
			MaxCount = 1,
			BlockSolo = true,
			BlockEnemyTypes = {"FogEmitter"}
		},
	},

	FogEmitter2 =
	{
		InheritFrom = { "FogEmitter", },
		MaxHealth = 730,

		ActivateAnimation = "Enemy_FogEmitter_Spawn_Quick",
		ActivateFx = "EnemyPreSpawnTerrainQuick",
		ActivateFx2 = "EnemyPreSpawnStandingQuick",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 0.25,
		ActivateTint = true,
		ActivateTintDelay = 0.0,
		ActivateTintDuration = 0.5,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.75,

		BlockNextBiomeEnemyShrineUpgrade = true,
		AIOptions =
		{
			"AggroAI",
		},

		AIAggroRange = 1500,
		SkipAlertedText = true,

		DefaultAIData =
		{
			DeepInheritance = true,
			--FogRadius = 500,
			--ExitFogRadiusBuffer = 50,
		},

		WeaponOptions =
		{
			"FogEmitter2Sweep",
		},

		ActiveCapWeight = 2,
		GeneratorData =
		{
			DifficultyRating = 80,
			MaxCount = 1,
			BlockSolo = true,
			BlockEnemyTypes = {"FogEmitter"}
		},
	}
}

OverwriteTableKeys( EnemyData, UnitSetData.FogEmitter )