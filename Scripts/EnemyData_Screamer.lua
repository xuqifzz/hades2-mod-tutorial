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
			RetreatAfterAttack = true,
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

		BlockAttributes = { "Tracking" },

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

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/Melinoe_1650", Text = "Wailers!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "ArachneCombatF", "NemesisCombatIntro", "NemesisCombatF" },
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/Melinoe_1649", Text = "Wailers.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1650", Text = "Wailers!" },
			{ Cue = "/VO/Melinoe_1651", Text = "More Wailers." },
			{ Cue = "/VO/Melinoe_1652", Text = "Wailers again..." },
		},
	},

	Screamer_Elite =
	{
		InheritFrom = { "Elite", "Screamer" },
		HealthBuffer = 190,

		IsAggroedSound = "/SFX/Enemy Sounds/Screamer/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
			MaxAttackers = 3,
		},

		WeaponOptions =
		{
			"ScreamerCone",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 34,
			BlockEnemyTypes = {"Screamer"}
		},
	},

	Screamer2 =
	{
		InheritFrom = { "Screamer" },
		MaxHealth = 1100,
		HealthBuffer = 1250,

		HealthBarType = "Medium",
		HealthBarOffsetY = -235,

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

}

OverwriteTableKeys( EnemyData, UnitSetData.Screamer )