UnitSetData.Vampire =
{
	
	Vampire =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		Groups = { "FlyingEnemies", "GroundEnemies" },
		Material = "Bone",

		MaxHealth = 5100,
		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -50,
		HealthBarType = "MediumLarge",

		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,

		IntroEncounterName = "VampireIntro",

		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Vampire/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Vampire/EmoteDying",

		OutgoingLifestealModifiers =
		{
			{
				ValidMultiplier = 40.0,
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

	Vampire_SuperElite =
	{
		InheritFrom = { "SuperElite", "Vampire" },
		MaxHealth = 7000,
		BlockRaiseDead = false,
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Vampire )