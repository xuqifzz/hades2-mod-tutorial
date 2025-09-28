UnitSetData.LycanSwarmer =
{
	LycanSwarmer =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },

		MaxHealth = 270,
		HealthBarOffsetY = -120,
		HealthBarType = "Small",

		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "GroundEnemies" },
		Material = "Bone",
		ArmorSparkAnimation = "HitSparkArmor_Small",

		IntroEncounterName = "LycanthropeIntro",

		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/LycanSwarmer/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/LycanSwarmer/EmoteDying",

		DeathFx = "EnemyDeathFxIris",

		--ActivateAnimation = "Enemy_Lycanthrope_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainQuick",
		ActivateFx2 = "EnemyPreSpawnStandingQuick",
		ActivateFxPreSpawn = "nil",
		ActivateFxPreSpawnDelay = 0.25,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 0.25,
		ActivateTint = true,
		ActivateTintDelay = 0.0,
		ActivateTintDuration = 0.5,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.75,

		StunAnimations = 
		{
			Default = "Enemy_LycanSwarmer_OnHit",
			Heavy = "Enemy_LycanSwarmer_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"LycanSwarmerChomp", "LycanSwarmerBlink"
		},

		GeneratorData =
		{
			DifficultyRating = 40,
			BlockEnemyTypes = {"LycanSwarmer_Elite"}
		},
	},

	LycanSwarmer_Elite =
	{
		InheritFrom = { "Elite", "LycanSwarmer" },
		HealthBuffer = 270,

		BlockNextBiomeEnemyShrineUpgrade = true,

		IsAggroedSound = "/SFX/Enemy Sounds/LycanSwarmer/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"LycanSwarmerChomp_Elite", "LycanSwarmerBlink"
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"LycanSwarmer"},
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

	LycanSwarmer2 =
	{
		InheritFrom = { "LycanSwarmer_Elite" },
		GenusName = "LycanSwarmer_Elite",
		MaxHealth = 2000,
		HealthBuffer = 2000,

		GrannyTexture = "GR2/LycanSwarmerTyphon_Color",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		SpellSummonDataOverrides =
		{
			WeaponOptions =
			{
				"LycanSwarmer2Chomp_Ally"
			},
		},

		WeaponOptions =
		{
			"LycanSwarmer2Chomp", "LycanSwarmerBlink"
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"LycanSwarmer"},
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.LycanSwarmer )