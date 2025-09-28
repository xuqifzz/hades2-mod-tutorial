UnitSetData.Screamer =
{	
	-- chases you, conical scream attack
	Screamer =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "ScreamerIntro",

		HealthBarOffsetY = -210,

		ActivateAnimation = "Enemy_Screamer_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainMedium",
		ActivateFx2 = "EnemyPreSpawnStandingMedium",
		ActivateFxPreSpawn = "EnemySpawnBurstMedium",
		DeathAnimation = "Enemy_Screamer_Death",
		DeathFx = "EnemyDeathFxIris",
		ArmorSparkAnimation = "HitSparkArmor_Medium",

		MaxHealth = 130,

		PreferredSpawnPoint = "EnemyPointMelee",
		Material = "Bone",

		IsAggroedSound = "/SFX/Enemy Sounds/Screamer/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Screamer/EmoteDying",

		AIOptions =
		{
			"AggroAI",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			-- Retreat to spawn points off screen
			RetreatAfterAttack = true,
			RetreatToSpawnPoints = true,
			RetreatBufferDistance = 700,
			RetreatDurationMin = 1.5,
			RetreatDurationMax = 1.75,
			--RetreatAfterAttackEndWait = 0.3,
		
			SurroundRefreshInterval = 0.25,
			--MaintainSurroundDistance = true,
			--SurroundUsingSpawnPoints = true,
			--SurroundDistance = 800,
			--SurroundDistanceBuffer = 200,
			MaxAttackers = 2,

			SurroundRetaliateDistance = 125,

			-- there's also a sound on the Enemy_Screamer_PreFire animation that can be merged with this
			PreAttackSound = "/SFX/Enemy Sounds/Screamer/EmoteCharging",
		},
		PostAggroAI = "SurroundAI",
		OnDamagedFunctionName = "SurroundAIRetaliate",
		EndAIThreadWaitOnFreezeEnd = true,

		BlockAttributes = { "Tracking", },

		WeaponOptions =
		{
			"ScreamerCone",
		},

		GeneratorData =
		{
			DifficultyRating = 13,
			BlockEnemyTypes = {"Screamer_Elite"}
		},

		StunAnimations = 
		{
			Default = "Enemy_Screamer_OnHit",
		},

		OnDealDamageFunctionName = "ScreamerDistortionEffect",

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
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/Melinoe_1649", Text = "Wailers." },
			{ Cue = "/VO/Melinoe_1650", Text = "Wailers!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1651", Text = "More Wailers." },
			{ Cue = "/VO/Melinoe_1652", Text = "Wailers again..." },
		},
	},

	Screamer_Elite =
	{
		InheritFrom = { "Elite", "Screamer" },
		HealthBuffer = 190,

		IsAggroedSound = "/SFX/Enemy Sounds/Screamer/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex" }),

		DefaultAIData =
		{
			DeepInheritance = true,
			MaxAttackers = 3,
		},

		WeaponOptions =
		{
			"ScreamerCone",
		},

		GeneratorData =
		{
			DifficultyRating = 34,
			BlockEnemyTypes = {"Screamer"}
		},
	},

	Screamer2 =
	{
		InheritFrom = { "Elite", "Screamer" },
		MaxHealth = 1100,
		HealthBuffer = 1250,

		HealthBarType = "Medium",
		HealthBarOffsetY = -265,

		ActivateAnimation = "Enemy_Screamer_Spawn_Quick",
		ActivateFx = "EnemyPreSpawnTerrainQuick",
		ActivateFx2 = "EnemyPreSpawnStandingQuick",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 0.25,
		ActivateTint = true,
		ActivateTintDelay = 0.0,
		ActivateTintDuration = 0.5,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.75,

		BlockNextBiomeEnemyShrineUpgrade = true,
		BlockRespawnShrineUpgrade = true,

		DefaultAIData =
		{
			DeepInheritance = true,
			MaxAttackers = 2,
		},

		BlockAttributes = { "Tracking", "Vacuuming" },
		
		WeaponOptions =
		{
			"ScreamerVacuum",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
		},

		GeneratorData =
		{
			DifficultyRating = 405,
		},
	},

	Screamer2_SuperElite =
	{
		InheritFrom = { "SuperElite", "Screamer2" },
		GenusName = "Screamer",

		MaxHealth = 1000,
		HealthBuffer = 5000,

		StartAggroed = true,

		DefaultAIData =
		{
			DeepInheritance = true,
			MaxAttackers = 4,
		},
	},

	Screamer_Shadow =
	{
		InheritFrom = { "Shadow", "Screamer" },
		GenusName = "Screamer",

		MaxHealth = 100,
		HealthBuffer = 100,

		StartAggroed = true,

		DefaultAIData =
		{
			DeepInheritance = true,
			MaxAttackers = 4,
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Screamer )