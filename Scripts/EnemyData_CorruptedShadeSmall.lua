UnitSetData.CorruptedShadeSmall =
{
	CorruptedShadeSmall =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },
		DeathAnimation = "EnemyDeathFxCorruptedShade",
		MaxHealth = 125,
		HealthBarType = "Small",

		IsAggroedSound = "/SFX/Enemy Sounds/CorruptedShadeSmall/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/CorruptedShadeSmall/EmoteDying",

		CollisionReactions = {},

		ActivateAnimation = "Enemy_CorruptedShadeS_Spawn",
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
			Default = "Enemy_CorruptedShadeS_OnHit",
			Heavy = "Enemy_CorruptedShadeS_OnHit_Heavy",
		},

		DefaultAIData = {
			DeepInheritance = true,

			SurroundDistance = 550,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 5,
		},
		PostAggroAI = "SurroundAI",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 200,
		AIChainAggroRange = 200,
		AIHostileChainAggroRange = 600,
		AggroIfLastAlive = false,

		WeaponOptions = { "CorruptedShadeSCast" },

		ActiveCapWeight = 0.34,
		GeneratorData =
		{
			DifficultyRating = 10,
			BlockEnemyTypes = {"CorruptedShadeSmall_Elite"}
		},
	},

	CorruptedShadeSmall_Elite =
	{
		InheritFrom = { "Elite", "CorruptedShadeSmall" },
		HealthBuffer = 125,

		IsAggroedSound = "/SFX/Enemy Sounds/CorruptedShadeSmall/EmoteTaunting",

		DefaultAIData = {
			DeepInheritance = true,
		},
		
		WeaponOptions = { "CorruptedShadeSCast_Elite" },

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 25,
			BlockEnemyTypes = {"CorruptedShadeSmall"}
		},
	}
}

OverwriteTableKeys( EnemyData, UnitSetData.CorruptedShadeSmall )