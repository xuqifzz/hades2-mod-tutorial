UnitSetData.SiegeVine =
{
	
	SiegeVine =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		--IntroEncounterName = "SiegeVineIntro",

		SpawnAngleMin = 170,
		SpawnAngleMax = 360,
		ActivateAnimation = "Enemy_SiegeVine_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainLarge",
		ActivateFx2 = "EnemyPreSpawnStandingLarge",
		ActivateFxPreSpawn = "EnemySpawnBurstLarge",
		ArmorSparkAnimation = "HitSparkArmor_Large",
		DeathAnimation = "Enemy_SiegeVine_Death",
		DeathFx = "EnemyDeathFx_Large",

		MaxHealth = 290,
		HealthBarOffsetY = -240,
		Groups = { "GroundEnemies", "IgnoreSafeZone", },

		IsAggroedSound = "/SFX/Enemy Sounds/SiegeVine/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/SiegeVine/EmoteDying",

		PreferredSpawnPoint = "EnemyPointRanged",
		Material = "Organic",
		
		StunAnimations = 
		{
			Default = "Enemy_SiegeVine_HitStun",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1300,

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/SiegeVine/EmoteCharging",
		},

		WeaponOptions =
		{
			"SiegeVines"
		},

		ActiveCapWeight = 2.5,

		GeneratorData =
		{
			DifficultyRating = 22,
			BlockSolo = true,
			BlockEnemyTypes = {"SiegeVine_Elite"},
			ActiveEnemyCapBonus = 2,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "MiniBossFogEmitter" }
			},
		},

		EnemySightedVoiceLines =
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			GameStateRequirements =
			{
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 2,
				},
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/Melinoe_1645", Text = "Thorn-Weepers." },
			{ Cue = "/VO/Melinoe_1646", Text = "Thorn-Weepers!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1647", Text = "More Thorn-Weepers." },
			{ Cue = "/VO/Melinoe_1648", Text = "Come, Thorn-Weepers." },
		},
	},

	SiegeVine_Elite =
	{
		InheritFrom = { "Elite", "SiegeVine" },
		HealthBuffer = 390,

		IsAggroedSound = "/SFX/Enemy Sounds/SiegeVine/EmoteAlerted",

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
		--AdditionalAIFunctions = { "DefenseAI" },
		
		WeaponOptions =
		{
			"SiegeVinesElite"
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "MiniBossFogEmitter" }
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 3,
			},
		},

		GeneratorData =
		{
			DifficultyRating = 48,
			BlockSolo = true,
			BlockEnemyTypes = {"SiegeVine"},
			ActiveEnemyCapBonus = 2,
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SiegeVine )