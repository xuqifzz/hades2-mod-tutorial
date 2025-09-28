UnitSetData.Scimiterror =
{

	Scimiterror =
	{
		InheritFrom = { "BaseOEnemy", "BaseVulnerableEnemy", "LowPolyEnemy" },
		IntroEncounterName = "ScimiterrorIntro",

		ActivateAnimation = "Enemy_Scimiterror_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateScaleIn = true,
		ActivateScaleInDuration = 0.5,
		ActivateDuration = 1.0,
		ActivateTintDuration = 0.5,
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateTintDelay = 0,
		DeathAnimation = "ScimiterrorDeath",
		DeathFx = "ScimiterrorDeathFx",
		DeathSound = "/SFX/Enemy Sounds/Scimiterror/EmoteDying",
		DestroyDelay = 0.43333,

		MaxHealth = 260,
		HealthBarOffsetY = -200,
		HealthBarType = "Small",

		Groups = { "GroundEnemies" },
		Material = "Stone",
		IsAggroedSound = "/SFX/Enemy Sounds/Scimiterror/EmoteAlerted",

		StunAnimations = 
		{
			Default = "Enemy_Scimiterror_OnHit",
			Heavy = "Enemy_Scimiterror_OnHit_Heavy"
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,
		PostAggroAI = "SurroundAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			MaxAttackers = 2,
			SurroundRetaliateDistance = 300,
		},

		WeaponOptions =
		{
			"ScimiterrorSlashLeft", "ScimiterrorSlashRight",
		},

		HeraclesCombatMoneyValue = 2,
		MoneyDropOnDeath =
		{
			Chance = 0.4,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.05,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		ActiveCapWeight = 0.5,
		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"Scimiterror_Elite"}
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

			{ Cue = "/VO/MelinoeField_2163", Text = "Seeswords..." },
			{ Cue = "/VO/MelinoeField_2164", Text = "Seeswords...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2165", Text = "More Seeswords." },
			{ Cue = "/VO/MelinoeField_2166", Text = "More Seeswords?" },
		},

	},

	Scimiterror_Elite =
	{
		InheritFrom = { "Elite", "Scimiterror" },
		HealthBuffer = 260,
		IsAggroedSound = "/SFX/Enemy Sounds/Scimiterror/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"ScimiterrorSlashLeft", "ScimiterrorSlashRight",
		},

		HeraclesCombatMoneyValue = 4,
		GeneratorData =
		{
			DifficultyRating = 65,
			BlockEnemyTypes = {"Scimiterror"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Scimiterror )