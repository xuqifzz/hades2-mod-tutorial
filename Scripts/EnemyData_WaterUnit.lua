UnitSetData.WaterUnit =
{
	
	WaterUnit =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		--IntroEncounterName = "WaterUnitIntro", -- Miniboss is the intro

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossWaterUnit" },
			},
		},

		BlockRespawnShrineUpgrade = true,
		BlockNextBiomeEnemyShrineUpgrade = true,
		BlockForcedTeleport = true,

		MaxHealth = 250,
		HealthBarType = "Medium",
		HealthBarOffsetY = -180,

		IsAggroedSound = "/SFX/Enemy Sounds/WaterUnit/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/WaterUnit/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/WaterUnit/EmoteHurt",

		ActivateFx = "",
		ActivateFx2 = "",
		ActivateFxPreSpawn = "WaterUnitSurface",
		ActivateFxPreSpawnDelay = 0.80,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.00,
		ActivateFadeInDuration = 0.6,
		ActivateTint = false,
		ActivateDuration = 0.8,
		ActivateStartAlpha = 1.0,
		AttachedAnimationName = "WaterUnitGlow",

		ActivateAnimation = "OceanusEnemyBubbles",

		DeathAnimation = "Enemy_WaterUnit_Death",
		DeathFx = "EnemyDeathFxFishSmall",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedFish",
			Rapid = "HitSparkEnemyDamagedFishRapid",
		},

		RequiredSpawnPoint = "EnemyPointRanged",
		Material = "Bone",

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
		PostAggroAI = "SurroundAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackAlpha = 1,

			SurroundRetaliateDistance = 400,
			SurroundRefreshInterval = 0.4,
			MaxAttackers = 99, -- Only restrict WaterUnitSpit & WaterUnitLob
		},

		WeaponOptions =
		{
			"WaterUnitSpit", "WaterUnitSwipe", "WaterUnitDive", "WaterUnitDive", "WaterUnitFidget"
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"WaterUnitSpit", "WaterUnitSwipe",
			},
		},

		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"WaterUnit_Elite"}
		},

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
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

			{ Cue = "/VO/MelinoeField_0090", Text = "Serpents." },
			{ Cue = "/VO/MelinoeField_0091", Text = "Serpents!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0092", Text = "More Serpents." },
			{ Cue = "/VO/MelinoeField_0093", Text = "More Serpents?" },
		},
	},

	WaterUnit_Elite =
	{
		InheritFrom = { "Elite", "WaterUnit" },
		HealthBuffer = 230,

		IsAggroedSound = "/SFX/Enemy Sounds/WaterUnit/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Homing" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"WaterUnitSwipe", "WaterUnitSpitElite", "WaterUnitDive", "WaterUnitDive", "WaterUnitFidget"
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
		MaxHealth = 700,
		HealthBuffer = 2650,
		HealthBarType = "Large",
		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -130,

		ArmorSparkAnimation = "HitSparkArmor_Transparent",

		IsAggroedSound = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteHurt",

		BlockRespawnShrineUpgrade = true,
		BlockCharm = true,

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
		},

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"WaterUnit"}
		},
	},

	WaterUnitMiniboss_Shadow =
	{
		InheritFrom = { "Shadow", "WaterUnitMiniboss" },
		GenusName = "WaterUnitMiniboss",
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.WaterUnit )