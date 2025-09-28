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

			{ Cue = "/VO/MelinoeField_1034", Text = "Lycaons...!" , PlayFirst = true },
		},
	},

	Lycanthrope_Elite =
	{
		InheritFrom = { "Elite", "Lycanthrope" },
		HealthBuffer = 790,
		HealthBarOffsetY = -240,

		BlockNextBiomeEnemyShrineUpgrade = true,

		IsAggroedSound = "/SFX/Enemy Sounds/Werewolf/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Rifts", "Hex" }),

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

		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.225,
			ValuePerDifficultyMaxValueVariance = 1.3,
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