UnitSetData.Mage =
{
	Mage =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 80,
		HealthBarOffsetY = -200,
		HealthBarType = "Medium",
		Material = "Organic",

		PreferredSpawnPoint = "EnemyPointRanged",

		ActivateAnimation = "Enemy_Mage_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainMedium",
		ActivateStartAlpha = 1.0,
		ArmorSparkAnimation = "HitSparkArmor_Medium",

		IsAggroedSound = "/SFX/Enemy Sounds/Mage/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Mage/EmoteDying",
		DeathAnimation = "Enemy_Mage_Death",
		DeathFx = "EnemyDeathFxIris",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1250,
		PostAggroAI = "HideAndPeekAI",
		PeekAggroMultiplier = 3,

		AggroAnimation = "Enemy_Mage_Alert",
		AggroDuration = 0.7,

		BlockAttributes = { "Tracking" },
		
		StunAnimations = 
		{
			Default = "Enemy_Mage_HitStun",
			Heavy = "Enemy_Mage_HitStun_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			--RetreatDistance = 400,
			--RetreatBufferDistance = 500,
			--RetreatTimeoutMin = 1.00,
			--RetreatTimeoutMax = 1.50,
			--TakeCoverDuration = 2.0,
			TakeCoverDurationMin = 1.5,
			TakeCoverDurationMax = 2.2,
			CoverHugDistance = 250,
			MoveWithinRangeTimeoutMin = 7.0,
			MoveWithinRangeTimeoutMax = 10.0,

			PreAttackSound = "/SFX/Enemy Sounds/Mage/EmoteCharging",
			MaxAttackers = 6,
		},

		WeaponOptions =
		{
			"MageRanged",
		},

		GeneratorData =
		{
			DifficultyRating = 12,
			BlockEnemyTypes = {"Mage_Elite"}
		},

		ActiveCapWeight = 0.8,

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = GameData.BannedEnemySightedEncounters,
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/Melinoe_1443", Text = "Caskets." },
			{ Cue = "/VO/Melinoe_1444", Text = "Caskets!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1445", Text = "More Caskets." },
			{ Cue = "/VO/Melinoe_1446", Text = "Come, Caskets!" },
		},
	},

	Mage_Elite =
	{
		InheritFrom = { "Elite", "Mage" },
		HealthBuffer = 155,
		IsAggroedSound = "/SFX/Enemy Sounds/Mage/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,

			--RetreatTimeoutMin = 0.5,
			--RetreatTimeoutMax = 0.75,
			--TakeCoverDuration = 1.0,
			TakeCoverDurationMin = 0.8,
			TakeCoverDurationMax = 1.2,

			MaxAttackers = 6,
		},

		WeaponOptions =
		{
			"MageRanged_Elite",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 24,
			BlockEnemyTypes = {"Mage"}
		},
	},

	Mage2 =
	{
		InheritFrom = { "Mage" },
		IntroEncounterName = "Mage2Intro",
		MaxHealth = 390,

		ActivateAnimation = "Enemy_Mage_Idle",
		ActivateFx = "WaterUnitSurfaceLargeWithSound",
		ActivateFxPreSpawn = "Blank",
		ActivateFx2 = "Blank",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateDuration = 0.4,
		
		IsAggroedSound = "/SFX/Enemy Sounds/Mage/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,

			TakeCoverDurationMin = 2.5,
			TakeCoverDurationMax = 3.2,

			MaxAttackers = 2,
		},
		AIAggroRange = 1150,

		WeaponOptions =
		{
			"Mage2Ranged",
		},

		HeraclesCombatMoneyValue = 2,
		GeneratorData =
		{
			DifficultyRating = 40,
			BlockEnemyTypes = {"Mage2_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_2184", Text = "Blaskets!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = GameData.BannedEnemySightedEncounters,
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_2183", Text = "Blaskets.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2184", Text = "Blaskets!" },
			{ Cue = "/VO/MelinoeField_2185", Text = "More Blaskets." },
			{ Cue = "/VO/MelinoeField_2194", Text = "More Blaskets!" },
		},

	},

	Mage2_Elite =
	{
		InheritFrom = { "Elite", "Mage2" },
		HealthBuffer = 390,
		IsAggroedSound = "/SFX/Enemy Sounds/Mage/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,

			TakeCoverDurationMin = 1.5,
			TakeCoverDurationMax = 2.2,

			MaxAttackers = 1,
		},

		WeaponOptions =
		{
			"Mage2Ranged_Elite",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		HeraclesCombatMoneyValue = 4,
		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"Mage2"}
		},
	},

	MageSquad =
	{
		IsUnitGroup = true,

		SpawnOffset = 50,

		UnitGroup =
		{
			"Mage",
			"Mage",
			"Mage",
		},

		GroupAI = "GroupAI",
		LeaderFx = "SquadLeaderFx",

		GeneratorData =
		{
			DifficultyRating = 21,
			BlockEnemyTypes = {"Mage", "Mage_Elite"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Mage )