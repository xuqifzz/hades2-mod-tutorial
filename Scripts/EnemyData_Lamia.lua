UnitSetData.Lamia =
{
	Lamia =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 480,
		HealthBarOffsetY = -230,
		HealthBarType = "Small",

		IntroEncounterName = "LamiaIntro",

		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Lamia/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Lamia/EmoteDying",

		DeathAnimation = "Enemy_Lamia_Death",
		DeathFx = "EnemyDeathFxIris",

		ActivateAnimation = "Enemy_Lamia_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainQuick",
		ActivateFx2 = "EnemyPreSpawnStandingQuick",
		ActivateFxPreSpawn = "nil",
		ActivateFxPreSpawnDelay = 0.25,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 0.25,
		ActivateTint = true,
		ActivateTintDelay = 0.75,
		ActivateTintDuration = 0.5,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.75,

		Groups = { "GroundEnemies" },
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_Lamia_OnHit",
		},

		AIOptions =
		{
			"AggroAI",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundRetaliateDistance = 400,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 4,
		},
		PostAggroAI = "SurroundAI",
		EndAIThreadWaitOnFreezeEnd = true,

		WeaponOptions = { "LamiaSkyCast", "LamiaShockwave", },

		GeneratorData =
		{
			DifficultyRating = 70,
			BlockEnemyTypes = {"Lamia_Elite", "Lamia_Miniboss"}
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

			{ Cue = "/VO/MelinoeField_1038", Text = "Lamiai...!", PlayFirst = true },
		},
	},

	Lamia_Elite =
	{
		InheritFrom = { "Elite", "Lamia" },
		HealthBuffer = 380,

		IsAggroedSound = "/SFX/Enemy Sounds/Lamia/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		
		WeaponOptions = { "LamiaSkyCast_Elite", "LamiaShockwave", },

		GeneratorData =
		{
			DifficultyRating = 165,
			BlockEnemyTypes = {"Lamia", "Lamia_Miniboss"}
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

	Lamia_Support =
	{
		InheritFrom = { "Elite", "Lamia" },
		GenusName = "Lamia_Elite",
		HealthBuffer = 270,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WakeUpDelayMin = 0.3,
		WakeUpDelayMax = 5.0,
		PostAggroAI = "AttackerAI",
		
		WeaponOptions = { "LamiaSkyCast_Support", "LamiaShockwave", },

		GeneratorData =
		{
			DifficultyRating = 110,
		},

		GameStateRequirements =
		{
			--RequiredMinBiomeDepth = 3,
		},
	},

	Lamia_Miniboss =
	{
		InheritFrom = { "Elite", "Lamia" },
		RunHistoryKilledByName = "Lamia_Miniboss",
		HealthBuffer = 3950,

		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -160,
		HealthBarType = "Large",

		WakeUpDelayMin = 0.5,
		WakeUpDelayMax = 0.5,
		
		BlockRespawnShrineUpgrade = true,

		IsAggroedSound = "/SFX/Enemy Sounds/Lamia/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions = { "LamiaSkyCast_Miniboss", "LamiaShockwave_Miniboss", "LamiaMiasma" },

		AIOptions = {
			"AttackerAI",
		},
		PostAggroAI = nil,

		GeneratorData =
		{
			DifficultyRating = 200,
			--BlockEnemyTypes = {"Lamia", "Lamia_Elite"}
		},

		GameStateRequirements =
		{
		--	RequiredMinBiomeDepth = 4,
		},
	},

	Lamia_SuperElite =
	{
		InheritFrom = { "SuperElite", "Lamia_Miniboss" },
		MaxHealth = 1000,
		HealthBuffer = 5000,
		BlockRaiseDead = false,
	}

}

OverwriteTableKeys( EnemyData, UnitSetData.Lamia )