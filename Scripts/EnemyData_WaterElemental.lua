UnitSetData.WaterElemental =
{

	WaterElemental =
	{
		InheritFrom = { "BaseOEnemy", "BaseVulnerableEnemy", "LowPolyEnemy" },
		IntroEncounterName = "WaterElementalIntro",

		MaxHealth = 105,
		HealthBarOffsetY = -120,
		HealthBarType = "Small",

		ActivateFx = "WaterElementalSpawnFx",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateFadeInDelay = 0.00,
		ActivateFadeInDuration = 0.6,
		ActivateDuration = 0.3,
		ActivateTint = false,
		ActivateStartAlpha = 0,

		ArmorSparkAnimation = "HitSparkArmor_Small",
		DeathSound = "/SFX/Enemy Sounds/WaterElemental/EmoteDying",
		DeathAnimation = "Enemy_WaterElemental_Death",
		DeathFx = "WaterElementalDeathFx",

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/WaterElemental/EmoteAlerted",
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_WaterElemental_OnHit",
			Heavy = "Enemy_WaterElemental_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundRetaliateDistance = 300,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 99,
		},
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"WaterElementalBite", "WaterElementalFidget"
		},

		BlockAttributes = { "Metallic", "Orbit", "Vacuum", },

		HeraclesCombatMoneyValue = 1,
		MoneyDropOnDeath =
		{
			Chance = 0.2,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.075,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		ActiveCapWeight = 0.5,
		GeneratorData =
		{
			DifficultyRating = 13,
			BlockEnemyTypes = {"WaterElemental_Elite"}
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

			{ Cue = "/VO/MelinoeField_2159", Text = "Droplets..." },
			{ Cue = "/VO/MelinoeField_2160", Text = "Droplets...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2161", Text = "More Droplets." },
			{ Cue = "/VO/MelinoeField_2162", Text = "More Droplets?" },
		},

	},

	WaterElemental_Elite =
	{
		InheritFrom = { "Elite", "WaterElemental" },
		HealthBuffer = 105,
		IsAggroedSound = "/SFX/Enemy Sounds/WaterElemental/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"WaterElementalBite_Elite", "WaterElementalFidget",
		},

		HeraclesCombatMoneyValue = 2,
		GeneratorData =
		{
			DifficultyRating = 24,
			BlockEnemyTypes = {"WaterElemental"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.WaterElemental )