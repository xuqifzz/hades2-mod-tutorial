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

			--SurroundDistance = 550,
			--SurroundRefreshInterval = 0.5,
			--MaxAttackers = 2,
		},
		PostAggroAI = "SurroundAI",

		WeaponOptions = { "LamiaSkyCast", "LamiaShockwave", },

		GeneratorData =
		{
			DifficultyRating = 70,
			BlockEnemyTypes = {"Lamia_Elite", "Lamia_Miniboss"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_1038", Text = "Lamiai...!" },
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
		HealthBuffer = 3800,

		HealthBarOffsetY = -340,
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
	}

}

OverwriteTableKeys( EnemyData, UnitSetData.Lamia )