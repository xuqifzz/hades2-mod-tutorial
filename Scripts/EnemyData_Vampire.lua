UnitSetData.Vampire =
{
	
	Vampire =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		Groups = { "FlyingEnemies", "GroundEnemies" },
		Material = "Bone",

		MaxHealth = 4000,
		HealthBarOffsetY = -280,
		HealthBarType = "MediumLarge",
		HitSparkScale = 3.0,

		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,

		IntroEncounterName = "VampireIntro",

		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Vampire/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Vampire/EmoteDying",

		OutgoingLifestealModifiers =
		{
			{
				ValidMultiplier = 10.0,
			}
		},
		
		StunAnimations = 
		{
			Default = "Enemy_Vampire_OnHit",
			Heavy = "Enemy_Vampire_OnHit_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			OrbitTickDegrees = 15,
			OrbitTickDuration = 0.2,
			OrbitDistance = 900,

			OrbitAIDurationMin = 5.0,
			OrbitAIDurationMax = 6.0,

			RandomOrbitDirection = true,

			PreAttackSound = "/SFX/Enemy Sounds/Vampire/EmoteCharging",
		},

		AIOptions =
		{
			"AggroAI",
		},

		WeaponOptions =
		{
			"VampireCast",
			"VampireSwipe",
			"VampireTeleport",
			"VampireUppercut",
			"VampireCombo",
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"Vampire_Elite"}
		},
	},

	Vampire_Elite =
	{
		InheritFrom = { "Elite", "Vampire" },
		MaxHealth = 2000,
		HealthBuffer = 300,

		IsAggroedSound = "/SFX/Enemy Sounds/Vampire/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		StartAggroed = true,
		WakeUpDelayMin = 1.1,
		WakeUpDelayMax = 1.1,

		WeaponOptions =
		{
			"VampireCast",
			"VampireSwipe",
			"VampireTeleport",
		},

		GeneratorData =
		{
			DifficultyRating = 170,
			BlockEnemyTypes = {"Vampire"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Vampire )