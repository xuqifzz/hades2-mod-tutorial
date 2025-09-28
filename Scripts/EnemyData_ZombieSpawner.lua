UnitSetData.ZombieSpawner =
{
	ZombieSpawner =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "ZombieSpawnerIntro",
		PreferredSpawnPoint = "EnemyPointSupport",

		MaxHealth = 400,
		HealthBarOffsetY = -250,
		ArmorSparkAnimation = "HitSparkArmor_Large",
		ActivateAnimation = "Enemy_ZombieSpawner_Spawn",
		ActivateFx = "EphyraZombieSpawnerHoleIn",
		ActivateFx2 = "EphyraZombieSpawnerSpawnMask",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1, 
		ImpactSound = "/SFX/RockStoneImpact",
		AttachedAnimationName = "ZombieSpawnerShadow",
		DeathAnimation = "Enemy_ZombieSpawner_Death",
		
		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,
		BlockCharm = true,

		StunAnimations = 
		{
			Default = "Enemy_ZombieSpawner_OnHit",
			Heavy = "Enemy_ZombieSpawner_OnHit_Heavy",
		},

		DamagedFxStyles =
		{
			Default = "HitSparkZombieSpawner",
			Rapid = "HitSparkZombieSpawner",
		},

		Material = "Stone",
		IsAggroedSound = "/SFX/Enemy Sounds/ZombieSpawner/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/ZombieSpawner/EmoteDying",

		SpawnAwayFromTypes = { "ZombieSpawner", "ZombieSpawner_Elite" },

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIOptions =
		{
			"AttackerAI",
		},
		OnDamagedFunctionName = "AggroSpawns",

		HeraclesCombatMoneyValue = 3,
		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.100,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		WeaponOptions =
		{
			"ZombieSpawnerSummon", "ZombieSpawnerWait"
		},

		GeneratorData =
		{
			DifficultyRating = 40,
			MaxCount = 4,
			BlockSolo = true,
			BlockEnemyTypes = {"ZombieSpawner_Elite"}
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

			{ Cue = "/VO/MelinoeField_0463", Text = "A Tombstone." },
			{ Cue = "/VO/MelinoeField_0464", Text = "Tombstone...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0465", Text = "Tombstone there." },
			{ Cue = "/VO/MelinoeField_0466", Text = "Tombstone." },
		},
	},

	ZombieSpawner_Elite =
	{
		InheritFrom = { "Elite", "ZombieSpawner" },
		HealthBuffer = 400,

		IsAggroedSound = "/SFX/Enemy Sounds/ZombieSpawner/EmoteTaunting",

		EliteAttributeOptions =
		{
			"Fog",
			"HeavyArmor",
			"Orbit",
			"Radial",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		HeraclesCombatMoneyValue = 8,

		WeaponOptions =
		{
			"ZombieSpawnerSummon_Elite", "ZombieSpawnerWait"
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"ZombieSpawner"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.ZombieSpawner )