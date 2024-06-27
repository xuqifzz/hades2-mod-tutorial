UnitSetData.WaterUnit =
{
	
	WaterUnit =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "WaterUnitIntro",

		BlockRespawnShrineUpgrade = true,
		BlockNextBiomeEnemyShrineUpgrade = true,

		MaxHealth = 250,
		HealthBarType = "Medium",
		HealthBarOffsetY = -180,

		IsAggroedSound = "/SFX/Enemy Sounds/WaterUnit/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/WaterUnit/EmoteDying",

		ActivateFx = "",
		ActivateFx2 = "",
		ActivateFxPreSpawn = "WaterUnitSurface",
		ActivateFxPreSpawnDelay = 0.80,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.00,
		ActivateFadeInDuration = 0.6,
		ActivateTint = false,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.8,
		AttachedAnimationName = "WaterUnitGlow",

		ActivateAnimation = "OceanusEnemyBubbles",
		ActivateStartAlpha = 1.0,

		DeathAnimation = "Enemy_WaterUnit_Death",
		DeathFx = "EnemyDeathFxFishSmall",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedFish",
			Rapid = "HitSparkEnemyDamagedFishRapid",
		},

		RequiredSpawnPoint = "EnemyPointRanged",
		Material = "Bone",
		ProjectileBlockPresentationFunctionName = "ShadeBlockPresentation",

		StunAnimations = 
		{
			Default = "Enemy_WaterUnit_HitStun",
			Heavy = "Enemy_WaterUnit_HitStun_Heavy",
		},

		AIAggroRange = 2000,
		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "AttackerAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackAlpha = 1,
		},

		WeaponOptions =
		{
			"WaterUnitSpit", "WaterUnitSwipe", "WaterUnitLob", "WaterUnitDive", "WaterUnitDive",
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"WaterUnitSpit", "WaterUnitSwipe", "WaterUnitLob"
			},
		},

		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"WaterUnit_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0091", Text = "Serpents!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "ArachneCombatG" },
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0090", Text = "Serpents.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0091", Text = "Serpents!" },
			{ Cue = "/VO/MelinoeField_0092", Text = "More Serpents." },
			{ Cue = "/VO/MelinoeField_0093", Text = "More Serpents?" },
		},
	},

	WaterUnit_Elite =
	{
		InheritFrom = { "Elite", "WaterUnit" },
		HealthBuffer = 230,

		IsAggroedSound = "/SFX/Enemy Sounds/WaterUnit/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"WaterUnitSwipe", "WaterUnitSpitElite", "WaterUnitLob", "WaterUnitDive", "WaterUnitDive",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 62,
			BlockEnemyTypes = {"WaterUnit"}
		},
	},

	WaterUnitMiniboss =
	{
		InheritFrom = { "Elite", "WaterUnit" },
		BlockRespawnShrineUpgrade = true,
		MaxHealth = 700,
		HealthBuffer = 2650,
		HealthBarType = "Large",
		HealthBarOffsetY = -350,

		IsAggroedSound = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteDying",

		BlockRespawnShrineUpgrade = true,

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackSound = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteCharging",
		},

		WeaponOptions =
		{
			"WaterUnitSpitMiniBoss", "WaterUnitLobMiniboss",
			"WaterUnitSwipeMiniboss",
			"WaterUnitDiveMiniBoss", "WaterUnitDiveMiniBoss",
			-- "WaterUnitRoar", 
		},

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"WaterUnit"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.WaterUnit )