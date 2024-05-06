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

		DefaultAIData =
		{
			DeepInheritance = true,
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

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_1032", Text = "Holehearts...!" },
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
			"LovesickGround",
			"LovesickLauncher",
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
	}

}

OverwriteTableKeys( EnemyData, UnitSetData.Lovesick )