UnitSetData.SatyrCultist =
{
	SatyrCultist =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 630,
		HealthBarType = "Medium",
		HealthBarOffsetY = -180,

		--ActivateAnimation = "Enemy_SatyrRatCatcher_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronosLarge",
		ActivateFx2 = "EnemyPreSpawnStandingLargeChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstLargeChronos",
		DeathAnimation = "Enemy_SatyrCultist_Death",
		DeathFx = "EnemyDeathFxChronos",

		Groups = { "GroundEnemies" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrCultist/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/SatyrCultist/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/SatyrCultist/EmoteHurt",
		
		StunAnimations = 
		{
			Default = "Enemy_SatyrCultist_OnHit",
			Heavy = "Enemy_SatyrCultist_OnHit_Heavy",
		},

		WakeUpDelay = 1.35,
		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,

			MaintainSurroundDistance = false,
			SurroundDistance = 750,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 3,
		},
		AIAggroRange = 1500,
		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"SatyrCultistMelee", "SatyrCultistThrow", "SatyrCultistThrow",
		},

		GeneratorData =
		{
			DifficultyRating = 75,
		},
	},

	SatyrCultist_Elite =
	{
		InheritFrom = { "Elite", "SatyrCultist" },

		HealthBuffer = 600,

		WakeUpDelayMin = 0.0,
		WakeUpDelayMax = 1.0,

		OnDeathFireWeapons = { "SatyrCultistRitual" },

		WeaponOptions =
		{
			"SatyrCultistMelee_Elite", "SatyrCultistThrow_Elite", "SatyrCultistThrow_Elite",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SatyrCultist )