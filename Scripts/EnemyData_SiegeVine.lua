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

		IsAggroedSound = "/SFX/Enemy Sounds/SiegeVine/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/SiegeVine/EmoteDying",

		PreferredSpawnPoint = "EnemyPointRanged",
		Material = "Organic",

		--OnDamagedFunctionNames = { "ActivateFuse" },
		--OnDeathFireWeapons = { "MineBlast" },
		
		StunAnimations = 
		{
			Default = "Enemy_SiegeVine_HitStun",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1300,
		--AdditionalAIFunctions = { "DefenseAI" },

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/SiegeVine/EmoteCharging",

			--DefenseWeapon = "RootsAoESiegeVine",
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

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			Cooldowns =
			{
				-- { Name = "MelinoeAnyQuipSpeech" },
			},
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},

			{ Cue = "/VO/Melinoe_1646", Text = "Thorn-Weepers!" },
		},
		EnemySightedVoiceLines =
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "ArachneCombatF", "NemesisCombatIntro", "NemesisCombatF" },
				},
			},
			GameStateRequirements =
			{
				{
					Path = { "RequiredKillEnemies" },
					UseLength = true,
					Comparison = ">=",
					Value = 2,
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/Melinoe_1645", Text = "Thorn-Weepers.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1646", Text = "Thorn-Weepers!" },
			{ Cue = "/VO/Melinoe_1647", Text = "More Thorn-Weepers." },
			{ Cue = "/VO/Melinoe_1648", Text = "Come, Thorn-Weepers." },
		},
	},

	SiegeVine_Elite =
	{
		InheritFrom = { "Elite", "SiegeVine" },
		HealthBuffer = 390,

		IsAggroedSound = "/SFX/Enemy Sounds/SiegeVine/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,
			--DefenseWeapon = "RootsAoESiegeVine",
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
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 48,
			BlockSolo = true,
			BlockEnemyTypes = {"SiegeVine"},
			ActiveEnemyCapBonus = 2,
		},
	},

	SiegeVine2 =
	{
		InheritFrom = { "Elite", "SiegeVine" },
		HealthBuffer = 800,

		IsAggroedSound = "/SFX/Enemy Sounds/SiegeVine/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		
		WeaponOptions =
		{
			"SiegeVine2FastVines", "SiegeVine2RootVines",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 4,
		},

		GeneratorData =
		{
			DifficultyRating = 300,
			BlockSolo = true,
			BlockEnemyTypes = {"SiegeVine"},
			ActiveEnemyCapBonus = 2,
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.SiegeVine )