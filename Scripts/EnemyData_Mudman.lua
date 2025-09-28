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
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "EnemySpawnBurst",
		ActivateFxPreSound = "/SFX/Enemy Sounds/Mudman/MudmanSpawnFlash",
		-- DeathAnimation = "Enemy_ZombieAssassin_Death",
		DeathFx = "EnemyDeathFxUndead",
		ActivateAnimation = "Enemy_Mudman_Spawn",
		DeathAnimation = "Enemy_Mudman_Death",
		AttachedAnimationName = "MudmanDrips",
		
		--OnDeathThreadedFunctionName = "AddPlaceholderEnemyCount",
		--SpawnUnitOnDeath = "MudmanEye",

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

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 900,
		PostAggroAI = "SurroundAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			MaintainSurroundDistance = true,
			SurroundDistance = 650,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 2,
		},

		WeaponOptions =
		{
			"MudmanStraightThrow", "MudmanShove"
		},

		HeraclesCombatMoneyValue = 5,
		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.125,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		ActiveCapWeight = 1.25,
		GeneratorData =
		{
			DifficultyRating = 41,
			BlockEnemyTypes = {"Mudman_Elite"},
			ActiveEnemyCapBonus = 1,
		},

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0447", Text = "An Eidolon." },
			{ Cue = "/VO/MelinoeField_0448", Text = "Eidolon!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0449", Text = "Eidolon huh?" },
			{ Cue = "/VO/MelinoeField_0450", Text = "Eidolon there." },
		},
	},

	Mudman_Shadow =
	{
		InheritFrom = { "Shadow", "Mudman" },
		GenusName = "Mudman",

		ActivateFx = "nil",
		ActivateFx2 = "Blank",
		ActivateFxPreSpawn = "Blank",
		ActivateFxPreSpawnDelay = 0,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0,
		ActivateTint = false,
		ActivateDuration = 0,
		ActivateAnimation = "Enemy_Mudman_Idle",
		WakeUpDelay = 0,

		HealthBuffer = 1200,
		StartAggroed = true,

		WeaponOptions =
		{
			"MudmanStraightThrow_Shadow", "MudmanShove_Elite"
		},
	},

	Mudman_Elite =
	{
		InheritFrom = { "Elite", "Mudman" },
		HealthBuffer = 340,

		IsAggroedSound = "/SFX/Enemy Sounds/Mudman/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex" }),

		SpawnUnitOnDeath = "MudmanEye_Elite",
		SkipSpawnUnitOnDeathIfLastAlive = true,

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

	Mudman2 =
	{
		InheritFrom = { "Mudman_Elite" },
		GenusName = "Mudman_Elite",
		Health = 2650,
		HealthBuffer = 2650,

		GrannyTexture = "GR2/MudmanTyphon_Color",

		IsAggroedSound = "/SFX/Enemy Sounds/Mudman/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex" }),

		SpellSummonDataOverrides =
		{
			WeaponOptions =
			{
				"Mudman2Throw_NoSpawn"
			},
			SpawnUnitOnDeath = "nil",
		},

		SpawnUnitOnDeath = "MudmanEye_Elite",

		WeaponOptions =
		{
			"Mudman2Throw", "Mudman2Shove"
		},

		ActiveCapWeight = 1.25,
		GeneratorData =
		{
			DifficultyRating = 150,
			ActiveEnemyCapBonus = 1,
		},
	},

	MudmanEye =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },
		RunHistoryKilledByName = "Mudman",
		MaxHealth = 20,
		HealthBarOffsetY = -60,

		Material = "Organic",

		PreferredSpawnPoint = "EnemyPoint",
		Groups = { "FlyingEnemies" },

		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
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
			Heavy = "Enemy_MudmanEye_OnHit_Heavy",
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
		InheritFrom = { "Elite", "MudmanEye" },
		HealthBuffer = 20,

		BlockRaiseDead = true,

		IsAggroedSound = "/SFX/Enemy Sounds/MudmanEye/EmoteTaunting",

		HeraclesCombatMoneyValue = 1,

		GeneratorData =
		{
			DifficultyRating = 2,
			BlockEnemyTypes = {"MudmanEye"}
		},
	},

	MudmanEye2 =
	{
		InheritFrom = { "MudmanEye_Elite" },
		GenusName = "MudmanEye_Elite",
		Health = 500,
		HealthBuffer = 500,

		GeneratorData =
		{
			DifficultyRating = 5,
			BlockEnemyTypes = {"MudmanEye"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Mudman )