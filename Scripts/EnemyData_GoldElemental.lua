UnitSetData.GoldElemental =
{
	GoldElemental =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },

		MaxHealth = 510,
		HealthBarOffsetY = -200,
		HealthBarType = "Medium",

		ActivateAnimation = "Enemy_GoldElemental_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronos",
		ActivateFx2 = "EnemyPreSpawnStandingMediumChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		IsAggroedSound = "/SFX/Enemy Sounds/GoldElemental/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/GoldElemental/EmoteDying",
		DeathFx = "EnemyDeathFxChronos",
		DeathAnimation = "Enemy_GoldElemental_Death",

		Groups = { "GroundEnemies" },
		Material = "Bone",

		DefaultAIData =
		{
			DeepInheritance = true,

			RetreatDistance = 500,
			RetreatBufferDistance = 900,
			RetreatTimeoutMin = 1.50,
			RetreatTimeoutMax = 2.00,
			TakeCoverDuration = 1.0,
			CoverHugDistance = 250,

			--DashIfOverDistance = 100,
			--DashWeapon = "GoldElementalSky"
		},
		AIAggroRange = 900,
		
		StunAnimations = 
		{
			Default = "Enemy_GoldElemental_OnHit",
			Heavy = "Enemy_GoldElemental_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "HideAndPeekAI",
		PeekAggroMultiplier = 3,

		WeaponOptions =
		{
			"GoldElementalBeam", 
			--"GoldElementalSky"
		},

		ActiveCapWeight = 0.25,
		GeneratorData =
		{
			DifficultyRating = 38,
			BlockEnemyTypes = {"GoldElemental_Elite"}
		},

		BlockAttributes = { "Tracking" },

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_1655", Text = "Goldwraiths." },
			{ Cue = "/VO/MelinoeField_1656", Text = "Goldwraiths...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1657", Text = "More Goldwraiths." },
			{ Cue = "/VO/MelinoeField_1658", Text = "More Goldwraiths...!" },
		},
	},

	GoldElemental_Elite =
	{
		InheritFrom = { "Elite", "GoldElemental" },
		HealthBuffer = 510,
		IsAggroedSound = "/SFX/Enemy Sounds/GoldElemental/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/GoldElemental/EmoteDying",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		WeaponOptions =
		{
			"GoldElementalBeam_Elite",
			--"GoldElementalSky"
		},

		GeneratorData =
		{
			DifficultyRating = 75,
			BlockEnemyTypes = {"GoldElemental"}
		},
	},

	GoldElemental_MiniBoss =
	{
		InheritFrom = { "Elite", "GoldElemental" },
		MaxHealth = 3100,
		HealthBuffer = 8250,
		HealthBarOffsetY = -270,
		HealthBarType = "Large",
		
		BlockRespawnShrineUpgrade = true,

		IsAggroedSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteDying",

		DefaultAIData =
		{
			DeepInheritance = true,

			DashIfOverDistance = 100,
			DashWeapon = "GoldElementalSky"
		},
		PostAggroAI = "AttackerAI",

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		WeaponOptions =
		{
			"GoldElementalBeam_MiniBoss", "GoldElementalSky", "GoldElementalGround"
		},

		GeneratorData =
		{
			DifficultyRating = 200,
			BlockEnemyTypes = {"GoldElemental"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.GoldElemental )