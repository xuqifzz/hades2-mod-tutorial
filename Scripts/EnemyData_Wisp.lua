UnitSetData.Wisp =
{
	Wisp =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 90,

		WakeUpDelayMin = 1.0,
		WakeUpDelayMax = 1.2,
		ActivateFx = "EnemyPreSpawnTerrainSmall",
		PreferredSpawnPoint = "EnemyPointRanged",
		Material = "Organic",
		HealthBarOffsetY = -160,
		HealthBarType = "Small",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 300,
		
		StunAnimations = 
		{
			Default = "Enemy_Wisp_HitStun",
			Heavy = "Enemy_Wisp_HitStun_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			AttackDistanceMin = 230,
			RetreatBufferDistance = 250,
			RetreatTimeout = 20.0,
		},

		StopAnimationsOnDeath = { "WispFuseBurn" },

		WeaponOptions =
		{
			"WispFuse",
		},
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "I_PostBoss01" },
			},
		},

		GeneratorData =
		{
			DifficultyRating = 9,
		},
	},


	Wisp_Elite =
	{
		InheritFrom = { "Elite", "Wisp" },
		HealthBuffer = 100,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "I_PostBoss01" },
			},
			RequiredMinBiomeDepth = 3,
		},

		WeaponOptions =
		{
			"WispFuse",
		},

		GeneratorData =
		{
			DifficultyRating = 20,
			BlockEnemyTypes = {"Wisp"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Wisp )