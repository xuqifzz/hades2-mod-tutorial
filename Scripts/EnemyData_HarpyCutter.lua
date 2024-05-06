UnitSetData.HarpyCutter =
{

	HarpyCutter =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "HarpyCutterIntro",

		Groups = { "FlyingEnemies" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteAlerted",

		ActivateAnimation = "Enemy_HarpyCutter_Swoop",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0, 
		ActivateDuration = 1.3,
		ActivateStartOffsetZ = 2000,
		PostActivateStop = true,
		--ActivateGravity = 9000,
		ActivateFallForce = -2500,
		DeathSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteDying",

		MaxHealth = 725,
		HealthBarOffsetY = -280,
		HealthBarType = "Medium",

		StunAnimations = 
		{
			Default = "Enemy_HarpyCutter_OnHit",
			Heavy = "Enemy_HarpyCutter_OnHit_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,

		WeaponOptions = { "HarpySlice", "HarpyFlap", "HarpyDashRight", "HarpyDashLeft" },

		HeraclesCombatMoneyValue = 4,
		ActiveCapWeight = 0.67,
		GeneratorData =
		{
			DifficultyRating = 75,
			BlockEnemyTypes = {"HarpyCutter_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_2180", Text = "Talons!" },
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

			{ Cue = "/VO/MelinoeField_2179", Text = "Talons.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2180", Text = "Talons!" },
			{ Cue = "/VO/MelinoeField_2181", Text = "Talons, incoming!" },
			{ Cue = "/VO/MelinoeField_2182", Text = "More Talons!" },
		},

	},

	HarpyCutter_Elite =
	{
		InheritFrom = { "Elite", "HarpyCutter" },
		HealthBuffer = 585,
		IsAggroedSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions = { "HarpySlice", "HarpyFlap_Elite", "HarpyDashRight", "HarpyDashLeft" },

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		HeraclesCombatMoneyValue = 8,
		GeneratorData =
		{
			DifficultyRating = 165,
			BlockEnemyTypes = {"HarpyCutter"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.HarpyCutter )