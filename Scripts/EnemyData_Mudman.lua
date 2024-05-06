UnitSetData.Mudman =
{

	Mudman =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "MudmanIntro",
		MaxHealth = 330,
		HealthBarOffsetY = -250,
		HealthBarType = "MediumLarge",

		ActivateFx = "ZombieAssassinSpawnSmokeA",
		ActivateFx2 = "Blank",
		ActivateFxPreSpawn = "EnemySpawnBurst",
		ActivateFxPreSound = "/SFX/Enemy Sounds/Mudman/MudmanSpawnFlash",
		-- DeathAnimation = "Enemy_ZombieAssassin_Death",
		DeathFx = "EnemyDeathFxUndead",
		ActivateAnimation = "Enemy_Mudman_Spawn",
		DeathAnimation = "Enemy_Mudman_Death",
		AttachedAnimationName = "MudmanDrips",
		
		OnDeathThreadedFunctionName = "AddPlaceholderEnemyCount",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedUndead",
			Rapid = "HitSparkEnemyDamagedUndeadRapid",
		},

		StunAnimations = 
		{
			Default = "Enemy_Mudman_OnHit",
			Heavy = "Enemy_Mudman_OnHit_Heavy",
		},

		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/Mudman/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Mudman/EmoteDying",

		PreferredSpawnPoint = "EnemyPoint",
		Groups = { "FlyingEnemies" },

		--OnDamagedFunctionName = "ScaleToHealthPercentage",
		--DefaultScale = 1.0,

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 900,

		SpawnUnitOnDeath = "MudmanEye",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"MudmanStraightThrow", "MudmanShove"
		},

		HeraclesCombatMoneyValue = 5,

		ActiveCapWeight = 1.25,
		GeneratorData =
		{
			DifficultyRating = 41,
			BlockEnemyTypes = {"Mudman_Elite"},
			ActiveEnemyCapBonus = 1,
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
			},

			TriggerCooldowns =
			{
				"MelinoeAnyQuipSpeech",
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0448", Text = "Eidolon!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HeraclesCombatN" },
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0447", Text = "An Eidolon.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0448", Text = "Eidolon!" },
			{ Cue = "/VO/MelinoeField_0449", Text = "Eidolon huh?" },
			{ Cue = "/VO/MelinoeField_0450", Text = "Eidolon there." },
		},
	},

	Mudman_Elite =
	{
		InheritFrom = { "Mudman" },
		HealthBuffer = 340,

		IsAggroedSound = "/SFX/Enemy Sounds/Mudman/EmoteTaunting",

		SpawnUnitOnDeath = "MudmanEye_Elite",

		WeaponOptions =
		{
			"MudmanStraightThrow_Elite", "MudmanShove_Elite"
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		HeraclesCombatMoneyValue = 10,

		ActiveCapWeight = 1.25,
		GeneratorData =
		{
			DifficultyRating = 94,
			BlockEnemyTypes = {"Mudman"},
			ActiveEnemyCapBonus = 1,
		},
	},



	MudmanEye =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },
		MaxHealth = 20,
		HealthBarOffsetY = -60,

		Material = "Organic",

		PreferredSpawnPoint = "EnemyPoint",
		Groups = { "FlyingEnemies" },

		ActivateFx = "Blank",
		ActivateFx2 = "Blank",
		ActivateFxPreSpawn = "Blank",
		ActivateDuration = 0.3,
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1, 
		ActivateAnimation = "MudmanEye_Spawn",
		DeathFx = "EnemyDeathFxUndead",
		DeathAnimation = "Blank",
		StunAnimations = 
		{
			Default = "Enemy_MudmanEye_OnHit",
			Default = "Enemy_MudmanEye_OnHit_Heavy",
		},
		IsAggroedSound = "/SFX/Enemy Sounds/MudmanEye/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/MudmanEye/EmoteDying",

		AIOptions =
		{
			"AttackAndDie",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"MudmanEyeExplode",
		},

		HeraclesCombatMoneyValue = 1,

		GeneratorData =
		{
			DifficultyRating = 1,
			BlockEnemyTypes = {"MudmanEye_Elite"}
		},
	},
	MudmanEye_Elite =
	{
		InheritFrom = { "MudmanEye" },
		HealthBuffer = 20,

		IsAggroedSound = "/SFX/Enemy Sounds/MudmanEye/EmoteTaunting",

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		HeraclesCombatMoneyValue = 1,

		GeneratorData =
		{
			DifficultyRating = 2,
			BlockEnemyTypes = {"MudmanEye"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Mudman )