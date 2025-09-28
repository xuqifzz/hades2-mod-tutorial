UnitSetData.Lovesick =
{
	Lovesick =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 400,
		HealthBarOffsetY = -230,
		HealthBarType = "Medium",

		DeathAnimation = "Enemy_Lovesick_Death",
		DeathFx = "EnemyDeathFxIris",

		IntroEncounterName = "LovesickIntro",

		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Heartless/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Heartless/EmoteDying",

		ActivateAnimation = "Enemy_Lovesick_Spawn",
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

		Groups = { "FlyingEnemies" },
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_Lovesick_OnHit",
			Heavy = "Enemy_Lovesick_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "SurroundAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundRetaliateDistance = 300,
			SurroundRefreshInterval = 0.4,
			MaxAttackers = 3,
		},

		WeaponOptions =
		{
			"LovesickGround",
			"LovesickOverhand",
		},
		
		ActiveCapWeight = 1.0,
		GeneratorData =
		{
			DifficultyRating = 55,
			BlockEnemyTypes = {"Lovesick_Elite"}
		},

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

			{ Cue = "/VO/MelinoeField_1032", Text = "Holehearts...!", PlayFirst = true },
		},
	},

	Lovesick_Elite =
	{
		InheritFrom = { "Elite", "Lovesick" },
		HealthBuffer = 315,

		IsAggroedSound = "/SFX/Enemy Sounds/Heartless/EmoteTaunting",

		DefaultAIData = {
			DeepInheritance = true,
		},
		
		WeaponOptions =
		{
			"LovesickGround_Elite",
			"LovesickLauncher_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 120,
			BlockEnemyTypes = {"Lovesick"}
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

	Lovesick_Shadow =
	{
		InheritFrom = { "Shadow", "Lovesick" },
		GenusName = "Lovesick",
		MaxHealth = 800,
		HealthBuffer = 1200,
		
		WeaponOptions =
		{
			"LovesickGround",
			"LovesickLauncher",
		},
	},

	LovesickHeart =
	{
		InheritFrom = { "BaseTrap" },
		GenusName = "Lovesick",

		ActivateFuseIfNoSpawner = true,
		FuseWarningAnimation = "LovesickHeartMineDecalIn",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		TriggerGroups = { "HeroTeam" },
		StartCharmedDataOverrides =
		{
			TriggerGroups = { "EnemyTeam" },
		},

		OnDamagedFunctionNames = { "ActivateFuse" },
		OnDeathFireWeapons = { "LovesickHeartMineBlast" },

		DissipateAnimation = "LovesickHeartMineDissipate",
		FuseAnimation = "LovesickHeartMineActivated",
		FuseWarningProjectileName = "LovesickHeartMineBlast",
		FlashOnFuse = true,
		FuseDuration = 0.6,
		TriggerDistance = 310,
		TriggerDistanceScaleY = 0.5,
		WakeUpDelay = 0.15,
		ExpirationDuration = 12.0,

		AIOptions =
		{
			"MineAI",
		},
		AttackDistance = 100,

		OutgoingDamageModifiers =
		{
			{
				Name = "FriendImmunity",
				FriendMultiplier = 0,
			},
		},
	},

	LovesickHeart_Elite =
	{
		InheritFrom = { "LovesickHeart", },
		GenusName = "Lovesick_Elite",

		OnDeathFireWeapons = { "LovesickHeartMineBlast_Elite" },
		FuseWarningProjectileName = "LovesickHeartMineBlast_Elite",

		TriggerDistance = 420,
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Lovesick )