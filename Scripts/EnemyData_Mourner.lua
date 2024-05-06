UnitSetData.Mourner =
{
	Mourner =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 825,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -280,

		IntroEncounterName = "MournerIntro",

		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Mourner/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Mourner/EmoteDying",

		AttachedAnimationName = "MournerDrips",

		DeathAnimation = "Enemy_Mourner_Death",
		DeathFx = "EnemyDeathFxIris",

		ActivateAnimation = "Enemy_Mourner_Spawn",
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

		OnDamagedFunctionNames = { "CheckWeaponInterrupt" },
		
		StunAnimations = 
		{
			Default = "Enemy_Mourner_OnHit",
			Heavy = "Enemy_Mourner_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			"AggroAI",
		},
		
		WeaponOptions =
		{
			"MournerRampage",
			"MournerRampage",
			"MournerRampage",
			"MournerRampage",
			"MournerScream",
		},

		ActiveCapWeight = 1.0,
		GeneratorData =
		{
			DifficultyRating = 85,
			BlockEnemyTypes = {"Mourner_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_1036", Text = "Mourners...!" },
		},
	},

	Mourner_Elite =
	{
		InheritFrom = { "Elite", "Mourner" },
		HealthBuffer = 550,
		HealthBarOffsetY = -310,

		IsAggroedSound = "/SFX/Enemy Sounds/Mourner/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"MournerRampage_Elite",
			"MournerRampage_Elite",
			"MournerRampage_Elite",
			"MournerRampage_Elite",
			"MournerScream",
		},

		GeneratorData =
		{
			DifficultyRating = 160,
			BlockEnemyTypes = {"Mourner"},
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">",
				Value = 1
			},
		},
	},

	Mourner_Support =
	{
		InheritFrom = { "Elite", "Mourner" },
		HealthBarOffsetY = -370,
		HealthBuffer = 2350,
		HealthBarType = "Large",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIOptions = { "IdleAI" },
		OnDamagedFunctionName = "AggroUnit",
		SpawnAngleTowardId = 621200,

		WeaponOptions =
		{
			"MournerCast_Elite",
			"MournerCast_Elite",
			"MournerRampage_Elite",
			"MournerScream",
		},

		GeneratorData =
		{
			DifficultyRating = 130,
			BlockEnemyTypes = {"Mourner"},
		},

	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Mourner )