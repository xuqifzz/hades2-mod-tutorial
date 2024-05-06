UnitSetData.ZombieHeavyRanged =
{

	ZombieHeavyRanged =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "ZombieHeavyRangedIntro",

		MaxHealth = 440,
		HealthBarOffsetY = -200,

		ActivateFx = "EphyraZombieHRHoleIn",
		ActivateFx2 = "EphyraZombieHRSpawnMask",
		ActivateFxPreSpawn = "Blank",
		DeathAnimation = "Enemy_ZombieHR_Death",
		DeathFx = "EnemyDeathFxUndeadLarge",
		ActivateAnimation = "Enemy_ZombieHR_Spawn",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1.0,
		ActivateDuration = 2.5,

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedUndead",
			Rapid = "HitSparkEnemyDamagedUndeadRapid",
		},

		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/ZombieHeavyRanged/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/ZombieHeavyRanged/EmoteDying",

		PreferredSpawnPoint = "EnemyPoint",
		Groups = { "GroundEnemies" },

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1100,
		
		StunAnimations = 
		{
			Default = "Enemy_ZombieHR_HitStun",
			Heavy = "Enemy_ZombieHR_HitStun_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"ZombieHeavyRangedToss", "ZombieHeavyRangedShove"
		},

		HeraclesCombatMoneyValue = 5,

		GeneratorData =
		{
			DifficultyRating = 40,
			BlockEnemyTypes = {"ZombieHeavyRanged_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			PreLineWait = 0.5,
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0456", Text = "Lubbers!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 0.5,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "HeraclesCombatN" },
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0455", Text = "Lubbers.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0456", Text = "Lubbers!" },
			{ Cue = "/VO/MelinoeField_0457", Text = "More Lubbers." },
			{ Cue = "/VO/MelinoeField_0458", Text = "More Lubbers?" },
		},
	},

	ZombieHeavyRanged_Elite =
	{
		InheritFrom = { "ZombieHeavyRanged" },
		HealthBuffer = 380,

		IsAggroedSound = "/SFX/Enemy Sounds/ZombieHeavyRanged/EmoteTaunting",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		WeaponOptions =
		{
			"ZombieHeavyRangedToss_Elite", "ZombieHeavyRangedShove_Elite"
		},

		HeraclesCombatMoneyValue = 10,

		GeneratorData =
		{
			DifficultyRating = 85,
			BlockEnemyTypes = {"ZombieHeavyRanged"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.ZombieHeavyRanged )