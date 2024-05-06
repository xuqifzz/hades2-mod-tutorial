UnitSetData.CorruptedShadeLarge =
{
	CorruptedShadeLarge =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		DeathAnimation = "EnemyDeathFxCorruptedShade_Large",
		MaxHealth = 640,
		HealthBarOffsetY = -250,
		HealthBarType = "MediumLarge",

		IsAggroedSound = "/SFX/Enemy Sounds/CorruptedShadeLarge/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/CorruptedShadeLarge/EmoteDying",

		ActivateAnimation = "Enemy_CorruptedShadeL_Spawn",
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

		CollisionReactions = {},

		StunAnimations = 
		{
			Default = "Enemy_CorruptedShadeL_OnHit",
			Heavy = "Enemy_CorruptedShadeL_OnHit_Heavy",
		},

		DefaultAIData = {
			DeepInheritance = true,

			SurroundDistance = 800,
			SurroundRefreshInterval = 0.1,
			MaxAttackers = 1,
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 200,
		AIChainAggroRange = 200,
		AIHostileChainAggroRange = 600,
		AggroIfLastAlive = false,
		PostAggroAI = "SurroundAI",

		WeaponOptions = { "CorruptedShadeLVacuum", "CorruptedShadeLNova" },

		ActiveCapWeight = 0.34,
		GeneratorData =
		{
			DifficultyRating = 70,
			BlockEnemyTypes = {"CorruptedShadeLarge_Elite"}
		},
	},
	CorruptedShadeLarge_Elite =
	{
		InheritFrom = { "CorruptedShadeLarge" },
		HealthBuffer = 410,

		IsAggroedSound = "/SFX/Enemy Sounds/CorruptedShadeLarge/EmoteTaunting",

		DefaultAIData = {
			DeepInheritance = true,
			SurroundRefreshInterval = 0.1,
			MaxAttackers = 2,
		},
		
		WeaponOptions = { "CorruptedShadeLVacuum_Elite", "CorruptedShadeLNova_Elite" },

		GeneratorData =
		{
			DifficultyRating = 130,
			BlockEnemyTypes = {"CorruptedShadeLarge"}
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.CorruptedShadeLarge )