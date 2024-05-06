UnitSetData.Lycanthrope =
{
	Lycanthrope =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 890,
		HealthBarOffsetY = -240,

		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "GroundEnemies" },
		Material = "Bone",

		IntroEncounterName = "LycanthropeIntro",

		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Werewolf/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Werewolf/EmoteDying",

		DeathAnimation = "Enemy_Lycanthrope_Death",
		DeathFx = "EnemyDeathFxIris",

		ActivateAnimation = "Enemy_Lycanthrope_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainQuick",
		ActivateFx2 = "EnemyPreSpawnStandingQuick",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 0.25,
		ActivateTint = true,
		ActivateTintDelay = 0.0,
		ActivateTintDuration = 0.5,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.75,

		StunAnimations = 
		{
			Default = "Enemy_Lycanthrope_OnHit",
			Heavy = "Enemy_Lycanthrope_OnHit_Heavy",
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
			"LycanthropePounce", "LycanthropeHowlSummons"
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"LycanthropePounce"
			},
		},

		ActiveCapWeight = 1.5,
		GeneratorData =
		{
		DifficultyRating = 115,
			BlockEnemyTypes = {"Lycanthrope_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_1034", Text = "Lycaons...!" },
		},
	},

	Lycanthrope_Elite =
	{
		InheritFrom = { "Elite", "Lycanthrope" },
		HealthBuffer = 790,
		HealthBarOffsetY = -240,

		BlockNextBiomeEnemyShrineUpgrade = true,

		IsAggroedSound = "/SFX/Enemy Sounds/Werewolf/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"LycanthropePounce_Elite", "LycanthropeHowlSummons_Elite"
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,

			WeaponOptions =
			{
				"LycanthropePounce_Elite"
			},
		},

		GeneratorData =
		{
			DifficultyRating = 310,
			BlockEnemyTypes = {"Lycanthrope"},
			MaxCount = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 3,
			},
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Lycanthrope )