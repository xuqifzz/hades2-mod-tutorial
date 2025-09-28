UnitSetData.BrokenHearted =
{
	BrokenHearted =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },

		MaxHealth = 280,
		HealthBarType = "Medium",
		
		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/BrokenHearted/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/BrokenHearted/EmoteDying",

		ActivateAnimation = "Enemy_BrokenHearted_Spawn",
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

		CollisionReactions = {},

		StunAnimations = 
		{
			Default = "Enemy_BrokenHearted_OnHit",
			Heavy = "Enemy_BrokenHearted_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			"AggroAI",
		},

		WeaponOptions = { "BrokenHeartedSlam" },

		ActiveCapWeight = 0.34,
		GeneratorData =
		{
			DifficultyRating = 38,
			BlockEnemyTypes = {"BrokenHearted_Elite"}
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

			{ Cue = "/VO/MelinoeField_1030", Text = "Smackers!", PlayFirst = true },
		},
	},

	BrokenHearted_Elite =
	{
		InheritFrom = { "Elite", "BrokenHearted" },
		HealthBuffer = 160,

		IsAggroedSound = "/SFX/Enemy Sounds/BrokenHearted/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		
		WeaponOptions = { "BrokenHeartedSlam" },

		ActiveCapWeight = 0.34,
		GeneratorData =
		{
			DifficultyRating = 65,
			BlockEnemyTypes = {"BrokenHearted"}
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
}

OverwriteTableKeys( EnemyData, UnitSetData.BrokenHearted )