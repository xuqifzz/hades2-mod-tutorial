UnitSetData.Simple =
{
	Simple =
	{
		InheritFrom = { "BaseQEnemy", "BaseVulnerableEnemy", "LowPolyEnemy" },

		ActivateAnimation = "Enemy_Simple_Spawn",
		ActivateFx = "TyphonLocustSpawnFx",
		ActivateFx2 = "null",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1,
		ActivateDuration = 0.5,
		WakeUpDelay = 0.2,

		MaxHealth = 250,
		HealthBarOffsetY = -140,
		HealthBarType = "Small",
		ArmorSparkAnimation = "HitSparkArmor_Small",
		HitSparkOffsetZ = 100,
		DeathFx = "EnemyDeathFxTyphonSmall",
		DeathAnimation = "Enemy_Simple_Death",
		DeathSound = "/SFX/Enemy Sounds/TyphonSwamerSimple/EmoteDying",

		SkipUnitHitFlash = true,

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},

		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/TyphonSwamerSimple/EmoteAlerted",
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_Simple_OnHit",
			Heavy = "Enemy_Simple_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		LeaderDeadAI = "AttackerAI",
		AIAggroRange = 1150,

		DefaultAIData =
		{
			DeepInheritance = true,

			FollowDistance = 10,
			FollowRefreshDuration = 0.25,
		},

		WeaponOptions =
		{
			"SimpleWander", 
		},

		DumbFireWeapons =
		{
			"SimpleLocust"
		},

		BlockAttributes = { "Orbit", "Vacuum", },

		ActiveCapWeight = 0.5,
		GeneratorData =
		{
			DifficultyRating = 20,
			BlockEnemyTypes = {"Simple_Elite"}
		},

		EnemySightedVoiceLines =
		{
			{ GlobalVoiceLines = "MonstersSightedVoiceLines" },
		},
	},

	Simple_Elite =
	{
		InheritFrom = { "Elite", "Simple" },
		MaxHealth = 300,
		HealthBuffer = 200,
		IsAggroedSound = "/SFX/Enemy Sounds/TyphonSwamerSimple/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SimpleWander", 
		},
		
		DumbFireWeapons =
		{
			"SimpleLocust_Elite"
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"Simple"}
		},
	},

	SimpleSquad =
	{
		IsUnitGroup = true,

		SpawnOffset = 50,

		UnitGroup =
		{
			"Simple",
			"Simple",
			"Simple",
			"Simple",
		},

		GroupAI = "GroupAI",
		--LeaderFx = "SquadLeaderFx",
		DisableLeaderUnitCollision = true,

		GeneratorData =
		{
			DifficultyRating = 120,
			BlockEnemyTypes = {"SimpleSquad_Elite"}
		},
	},

	SimpleSquad_Elite =
	{
		InheritFrom = { "Elite", "SimpleSquad" },

		UnitGroup =
		{
			"Simple_Elite",
			"Simple_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 160,
			BlockEnemyTypes = {"SimpleSquad"}
		},
	},

	Simple2 =
	{
		InheritFrom = { "Simple_Elite" },
		GenusName = "Simple_Elite",
		MaxHealth = 1600,
		HealthBuffer = 1600,

		HealthBarOffsetY = -250,
		HealthBarType = "MediumLarge",

		DumbFireWeapons =
		{
			"Simple2Locust"
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Simple )

WeaponSetData =
{
	SimpleLocust =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SimpleLocust",

			SkipCanAttack = true,
			CancelOnPolymorph = true,
			RestartOnHitStunClear = true,
			ExpireProjectilesOnPolymorph = true,
			ExpireProjectilesOnHitStun = true,

			DumbFireInterval = 10.0,
		},
	},
	SimpleLocust_Elite =
	{
		InheritFrom = { "SimpleLocust" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SimpleLocust_Elite",
		},
	},
	Simple2Locust =
	{
		InheritFrom = { "SimpleLocust" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "Simple2Locust",
		},
	},

	SimpleWander =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			TargetSpawnPoints = true,
			OccupyTargetSpawnPoint = true,
			TargetSpawnPointsRadiusMin = 400,
			TargetSpawnPointsRadius = 1300,

			AttackDistance = 200,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.1,

			AttackStaggerDelay = 0.15,
			MinionCatchUpBuffer = 0.3,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil