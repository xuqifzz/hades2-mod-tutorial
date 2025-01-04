UnitSetData.SatyrRatCatcher =
{
	SatyrRatCatcher =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 1000,
		HitSparkScale = 1.5,
		HealthBarOffsetY = -250,
		HealthBarType = "Large",

		ActivateAnimation = "Enemy_SatyrRatCatcher_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronosLarge",
		ActivateFx2 = "EnemyPreSpawnStandingLargeChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstLargeChronos",
		DeathAnimation = "Enemy_SatyrRatCatcher_Death",
		DeathFx = "EnemyDeathFxChronos",

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteDying",
		Material = "Bone",

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,

			MaintainSurroundDistance = true,
			SurroundDistance = 750,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 2,
		},
		AIAggroRange = 9999,
		
		StunAnimations = 
		{
			Default = "Enemy_SatyrRatCatcher_OnHit",
			Heavy = "Enemy_SatyrRatCatcher_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 780,
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"SatyrRatCatcherSummon", "SatyrRatCatcherCast", "SatyrRatCatcherMelee",
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"SatyrRatCatcherCast", "SatyrRatCatcherMelee",
			},
		},

		ActiveCapWeight = 2.5, -- to account for crawlers
		GeneratorData =
		{
			DifficultyRating = 110,
			BlockEnemyTypes = {"SatyrRatCatcher_Elite"}
		},

		EnemySightedVoiceLines =
		{
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
				SuccessiveChanceToPlay = 0.1,

				{ Cue = "/VO/MelinoeField_1639", Text = "Vierophants...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1640", Text = "Vierophants...!" },
				{ Cue = "/VO/MelinoeField_1641", Text = "More Vierophants." },
				{ Cue = "/VO/MelinoeField_1642", Text = "More Vierophants?" },
			},
			[2] = { GlobalVoiceLines = "SatyrsSightedVoiceLines" },
		},

	},

	SatyrRatCatcher_Elite =
	{
		InheritFrom = { "Elite", "SatyrRatCatcher" },
		HealthBuffer = 850,
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteTaunting",
		
		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrRatCatcherSummon_Elite", "SatyrRatCatcherCast_Elite", "SatyrRatCatcherMelee",
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"SatyrRatCatcherCast_Elite", "SatyrRatCatcherMelee",
			},
		},

		GeneratorData =
		{
			DifficultyRating = 280,
			BlockEnemyTypes = {"SatyrRatCatcher"},
		},
	},

	SatyrRatCatcher_Miniboss =
	{
		InheritFrom = { "Elite", "SatyrRatCatcher" },
		MaxHealth = 3200,
		HealthBuffer = 3500,
		HealthBarType = "Large",
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteDying",

		BlockRespawnShrineUpgrade = true,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrRatCatcherSummon_Miniboss", "SatyrRatCatcherCast_Miniboss", "SatyrRatCatcherMelee_Miniboss",
			"SatyrRatCatcherSpell",
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"SatyrRatCatcherCast_Miniboss", "SatyrRatCatcherMelee_Miniboss",
			},
		},

		GeneratorData =
		{
			DifficultyRating = 400,
			--BlockEnemyTypes = {"SatyrRatCatcher"}
		},
	},

	SatyrCultist =
	{
		InheritFrom = { "SatyrRatCatcher" },
		MaxHealth = 630,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -200,
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrCultist/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/SatyrCultist/EmoteDying",

		AIWakeDelay = 1.35,
		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIAggroRange = 1500,
		PostAggroAI = "AttackerAI",

		WeaponOptions =
		{
			"SatyrRatCatcherMeleeCultist",
		},

		GeneratorData =
		{
			DifficultyRating = 75,
			--BlockEnemyTypes = {"SatyrRatCatcher"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SatyrRatCatcher )