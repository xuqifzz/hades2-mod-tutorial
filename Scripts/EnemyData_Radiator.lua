UnitSetData.Radiator =
{	
	Radiator =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },
		IntroEncounterName = "RadiatorIntro",

		MaxHealth = 45,

		AIAggroRange = 1250,

		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "FlyingEnemies" },
		HealthBarOffsetY = -100,
		Material = "Organic",

		ActivateFx = "EnemyPreSpawnTerrainSmall",
		ActivateFx2 = "EnemyPreSpawnStandingSmall",
		ActivateFxPreSpawn = "EnemySpawnBurstSmall",
		ActivateAnimation = "Enemy_Radiator_Spawn",
		ActivateStartAlpha = 1.0,
		ArmorSparkAnimation = "HitSparkArmor_Small",

		IsAggroedSound = "/SFX/Enemy Sounds/Radiator/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Radiator/EmoteDying",
		DeathAnimation = "Enemy_Radiator_Death",
		DeathFx = "EnemyDeathFxIris",

		AIOptions =
		{
			"AggroAI",
		},
		
		StunAnimations = 
		{
			Default = "Enemy_Radiator_HitStun",
		},
		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackSound = "/SFX/Enemy Sounds/Radiator/EmoteCharging",

			ExpireProjectilesOnHitStun = true,
		},
		EndAIThreadWaitOnFreezeEnd = true,

		WeaponOptions =
		{
			"RadiatorMelee360",
		},

		GeneratorData =
		{
			DifficultyRating = 7,
			BlockEnemyTypes = {"Radiator_Elite"}
		},

		ActiveCapWeight = 0.5,

		EnemySightedVoiceLines =
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			GameStateRequirements = 
			{
				-- None
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/Melinoe_1439", Text = "Spindles." },
			{ Cue = "/VO/Melinoe_1440", Text = "Spindles!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1441", Text = "More Spindles." },
			{ Cue = "/VO/Melinoe_1442", Text = "Come, Spindles." },
		},
	},

	Radiator_Elite =
	{
		InheritFrom = { "Elite", "Radiator" },
		HealthBuffer = 85,
		IsAggroedSound = "/SFX/Enemy Sounds/Radiator/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"RadiatorMelee360_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 17,
			BlockEnemyTypes = {"Radiator"}
		},
	},


	Radiator2 =
	{
		InheritFrom = { "OceanusUnitData", "Radiator" },
		DeathFx = "EnemyDeathFxIris",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamaged",
			Rapid = "HitSparkEnemyDamagedRapid",
		},
		IntroEncounterName = "FishmanIntro",
		HealthBarOffsetY = -136,
		MaxHealth = 120,
		IsAggroedSound = "/SFX/Enemy Sounds/Radiator/EmoteTaunting",

		ActivateAnimation = "Enemy_Radiator_Idle",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIAggroRange = 1100,

		WeaponOptions =
		{
			"RadiatorMelee360_AutoFire",
			"RadiatorMelee360_AutoFire", 
			"RadiatorMelee360_AutoFire", 
			"RadiatorMelee360_AutoFire", 
			
			"RadiatorMelee360_AutoFire_Seek",
		},

		GeneratorData =
		{
			BlockSolo = true,
			DifficultyRating = 14,
			BlockEnemyTypes = {"Radiator2_Elite"}
		},
	},

	Radiator2_Elite =
	{
		InheritFrom = { "Elite", "Radiator2" },
		HealthBuffer = 135,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			BlockSolo = true,
			DifficultyRating = 27,
			BlockEnemyTypes = {"Radiator2"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Radiator )