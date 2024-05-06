UnitSetData.ZombieSpawner =
{
	ZombieSpawner =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "ZombieSpawnerIntro",
		PreferredSpawnPoint = "EnemyPointSupport",
		Material = "Stone",

		MaxHealth = 400,
		HealthBarOffsetY = -250,
		HitSparkScale = 2.4,
		ActivateAnimation = "Enemy_ZombieSpawner_Spawn",
		ActivateFx = "EphyraZombieSpawnerHoleIn",
		ActivateFx2 = "EphyraZombieSpawnerSpawnMask",
		ActivateFxPreSpawn = "Blank",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1, 
		ImpactSound = "/SFX/RockStoneImpact",
		AttachedAnimationName = "ZombieSpawnerShadow",
		DeathAnimation = "Enemy_ZombieSpawner_Death",

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

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0464", Text = "Tombstone...!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
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

			{ Cue = "/VO/MelinoeField_0463", Text = "A Tombstone.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0464", Text = "Tombstone...!" },
			{ Cue = "/VO/MelinoeField_0465", Text = "Tombstone there." },
			{ Cue = "/VO/MelinoeField_0466", Text = "Tombstone." },
		},
	},

	ZombieSpawner_Elite =
	{
		InheritFrom = { "ZombieSpawner" },
		HealthBuffer = 400,

		IsAggroedSound = "/SFX/Enemy Sounds/ZombieSpawner/EmoteTaunting",

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