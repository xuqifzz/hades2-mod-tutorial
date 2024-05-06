UnitSetData.CorruptedShadeMedium =
{
	CorruptedShadeMedium =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },
		DeathAnimation = "EnemyDeathFxCorruptedShade_Medium",
		MaxHealth = 350,
		HealthBarOffsetY = -180,
		HealthBarType = "Medium",

		ActiveCapWeight = 0.336,

		IsAggroedSound = "/SFX/Enemy Sounds/CorruptedShadeMedium/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/CorruptedShadeMedium/EmoteDying",

		CollisionReactions = {},

		ActivateAnimation = "Enemy_CorruptedShadeM_Spawn",
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


		StunAnimations = 
		{
			Default = "Enemy_CorruptedShadeM_OnHit",
			Heavy = "Enemy_CorruptedShadeM_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 200,
		AIChainAggroRange = 200,
		AIHostileChainAggroRange = 600,
		AggroIfLastAlive = false,
		
		SetupFunctions =
		{
			{
				Name = "ChooseWanderSpawnPoints",
				Args =
				{
					Radius = 400,
				},
			},
		},

		WeaponOptions = { "CorruptedShadeMRam" },

		ActiveCapWeight = 0.25,
		GeneratorData =
		{
			DifficultyRating = 15,
			BlockEnemyTypes = {"CorruptedShadeMedium_Elite"}
		},
	},

	CorruptedShadeMedium_Elite =
	{
		InheritFrom = { "Elite", "CorruptedShadeMedium" },
		HealthBuffer = 250,

		IsAggroedSound = "/SFX/Enemy Sounds/CorruptedShadeMedium/EmoteTaunting",

		DefaultAIData = {
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"CorruptedShadeMedium"}
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},
	}

}

OverwriteTableKeys( EnemyData, UnitSetData.CorruptedShadeMedium )