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
		ActivateFxPreSpawn = "nil",
		DeathAnimation = "Enemy_ZombieHR_Death",
		DeathFx = "EnemyDeathFxUndeadLarge",
		ActivateAnimation = "Enemy_ZombieHR_Spawn",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1.0,
		ActivateWaitForAnimation = true,

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
		PostAggroAI = "SurroundAI",
		
		StunAnimations = 
		{
			Default = "Enemy_ZombieHR_HitStun",
			Heavy = "Enemy_ZombieHR_HitStun_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			MaintainSurroundDistance = false,
			SurroundDistance = 1000,
			SurroundRefreshInterval = 1.5,
			MaxAttackers = 3,
		},

		WeaponOptions =
		{
			"ZombieHeavyRangedToss", "ZombieHeavyRangedShove"
		},
		
		BlockAttributes = { "Orbit", "Vacuum", },

		HeraclesCombatMoneyValue = 5,
		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.125,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		GeneratorData =
		{
			DifficultyRating = 40,
			BlockEnemyTypes = {"ZombieHeavyRanged_Elite"}
		},

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			PreLineWait = 0.5,
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

			{ Cue = "/VO/MelinoeField_0455", Text = "Lubbers." },
			{ Cue = "/VO/MelinoeField_0456", Text = "Lubbers!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0457", Text = "More Lubbers." },
			{ Cue = "/VO/MelinoeField_0458", Text = "More Lubbers?" },
		},
	},

	ZombieHeavyRanged_Elite =
	{
		InheritFrom = { "Elite", "ZombieHeavyRanged" },
		HealthBuffer = 380,

		IsAggroedSound = "/SFX/Enemy Sounds/ZombieHeavyRanged/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Metallic" }),

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

	ZombieHeavyRanged_EM =
	{
		InheritFrom = { "ZombieHeavyRanged" },
		GenusName = "ZombieHeavyRanged",

		CreateAnimations = { "ZombieHRPoisonFx", },

		WeaponOptions =
		{
			"ZombieHeavyRangedTossPoison", "ZombieHeavyRangedShove"
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.ZombieHeavyRanged )