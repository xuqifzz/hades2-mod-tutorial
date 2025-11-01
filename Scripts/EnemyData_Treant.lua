UnitSetData.Treant =
{
	
	Treant =
	{
		InheritFrom = { "Elite", "BaseVulnerableEnemy" },
		RunHistoryKilledByName = "Treant",

		ActivateFx = "EnemyPreSpawnTerrainLarge",
		ActivateFx2 = "EnemyPreSpawnStandingLarge",
		ActivateFxPreSpawn = "EnemySpawnBurstLarge",
		ActivateAnimation = "Enemy_Treant_Spawn",
		DeathFx = "EnemyDeathFx_Medium",
		DeathAnimation = "Enemy_Treant_Death",

		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,

		MaxHealth = 450,
		HealthBuffer = 1220,
		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -180,
		HealthBarType = "Large",

		IsAggroedSound = "/SFX/Enemy Sounds/Treant/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/Treant/EmoteDying",

		PreferredSpawnPoint = "EnemyPointRanged",
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_Treant_HitStun",
			Heavy = "Enemy_Treant_HitStun_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Treant/EmoteCharging"			
		},
		PostAggroAI = "AttackerAI",

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		WeaponOptions =
		{
			"TreantRangedSpray", "TreantRangedRoots", "TreantTailSpawn", "TreantMelee", "TreantRangedRootsTriple",
		},

		BlockAttributes = { "Frenzy", },

		GeneratorData =
		{
			DifficultyRating = 65,
		},
	},

	Treant_Shadow =
	{
		InheritFrom = { "Treant" },
		GenusName = "Treant",

		WeaponOptions =
		{
			"TreantRangedSpray", "TreantRangedRoots", "TreantTailSpawn_Shadow", "TreantMelee", "TreantRangedRootsTriple",
		},
	},

	TreantTail =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "Treant",

		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateAnimation = "Enemy_TreantTail_Unburrow",
		ActivateFxPreSpawnDelay = 0.0,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0, 
		ActivateTint = false,
		ActivateDuration = 1.0,

		MaxHealth = 345,
		HealthBuffer = 485,
		HealthBarOffsetY = -200,
		HealthBarType = "Medium",

		DeathFx = "EnemyDeathFxIris",
		DeathAnimation = "Enemy_TreantTail_Death",
		DeathSound = "/SFX/Enemy Sounds/Treant/EmoteHurt",

		StunAnimations = 
		{
			Default = "Enemy_TreantTail_HitStun",
			Heavy = "Enemy_TreantTail_HitStun_Heavy",
		},

		AIOptions =
		{
			"AttackerAI",
		},
		WakeUpDelay = 1.0,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		WeaponOptions =
		{
			"TreantTailBurrow", "TreantTailSwipe"
		},

		GeneratorData =
		{
			DifficultyRating = 25,
		},
	},

	TreantTail_Shadow =
	{
		InheritFrom = { "Shadow", "TreantTail" },
		GenusName = "Treant",
	},

	Treant2 =
	{
		InheritFrom = { "Treant", "Elite", "BaseVulnerableEnemy", },
		MaxHealth = 850,
		HealthBuffer = 1850,
		ActivateAnimation = "Enemy_Treant_Spawn_Quick",
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

		HealthBarAttachToMarkerName = "nil",
		HealthBarOffsetY = -300,
		
		KillEnemyEvents =
		{
			{
				FunctionName = "WipeSpawnsOnKill",
			},
		},

		DefaultAIData =
		{
			DeepInheritance = true,	
		},

		WeaponOptions =
		{
			"Treant2RangedSpray", --"Treant2RangedRoots", 
			"Treant2TailSpawn", 
			"TreantMelee",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 4,
			},
		},

		ActiveCapWeight = 3.0,
		GeneratorData =
		{
			DifficultyRating = 480,
		},
	},

	TreantTail2 =
	{
		InheritFrom = { "TreantTail" },
		GenusName = "Treant2",

		MaxHealth = 460,
		HealthBuffer = 520,

		WeaponOptions =
		{
			"TreantTail2Burrow", "TreantTail2Swipe"
		},

		GeneratorData =
		{
			DifficultyRating = 50,
		},
	},

	Treant2_SuperElite =
	{
		InheritFrom = { "SuperElite", "Treant2", },
		GenusName = "Treant2",

		MaxHealth = 1000,
		HealthBuffer = 5000,
		BlockRaiseDead = false,

		WeaponOptions =
		{
			"Treant2RangedSpray", "Treant2RangedRoots", "Treant2SuperEliteTailSpawn", "TreantMelee",
		},
	},

	TreantTail2_SuperElite =
	{
		InheritFrom = { "TreantTail2" },
		GenusName = "Treant2",

		MaxHealth = 200,
		HealthBuffer = 1000,
		BlockRaiseDead = false,
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Treant )