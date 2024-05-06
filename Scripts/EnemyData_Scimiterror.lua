UnitSetData.Scimiterror =
{

	Scimiterror =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },
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
		DeathSound = "/SFX/Enemy Sounds/Scimiterror/EmoteDying",

		MaxHealth = 260,
		HealthBarOffsetY = -200,
		HealthBarType = "Small",

		Groups = { "GroundEnemies" },
		Material = "Metal",
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

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"ScimiterrorSlashLeft", "ScimiterrorSlashRight",
		},

		HeraclesCombatMoneyValue = 2,
		ActiveCapWeight = 0.5,
		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"Scimiterror_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_2164", Text = "Seeswords!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = GameData.BannedEnemySightedEncounters,
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_2163", Text = "Seeswords...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2164", Text = "Seeswords...!" },
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

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
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