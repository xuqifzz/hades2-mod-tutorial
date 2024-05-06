UnitSetData.Guard =
{

	-- Short-Aggro crawler, lashes out violently if approached
	Guard =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		ActivateFx = "EnemyPreSpawnTerrainMedium",
		ActivateFx2 = "EnemyPreSpawnStandingMedium",
		ActivateFxPreSpawn = "EnemySpawnBurstMedium",
		ActivateAnimation = "Enemy_Guard_Spawn",
		ActivateStartAlpha = 1.0,

		DeathAnimation = "Enemy_Guard_Death",
		DeathFx = "EnemyDeathFxIris",

		MaxHealth = 60,
		--ActivateFx = "TeleportDisappearSmall",

		IsAggroedSound = "/SFX/Enemy Sounds/Guard/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Guard/EmoteDying",
		Material = "Bone",

		PreferredSpawnPoint = "EnemyPointMelee",

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "AttackerAI",
		AIAggroRange = 800,
		
		StunAnimations = 
		{
			Default = "Enemy_Guard_HitStun",
			Heavy = "Enemy_Guard_HitStun_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackSound = "/SFX/Enemy Sounds/Guard/EmoteCharging",
		},

		MoneyDropOnDeath =
		{
			Chance = 0.25,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		WeaponOptions =
		{
			"GuardMelee",
		},

		ActiveCapWeight = 0.6,

		GeneratorData =
		{
			DifficultyRating = 5,
			BlockEnemyTypes = {"Guard_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/Melinoe_1654", Text = "Whispers!" },
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

			{ Cue = "/VO/Melinoe_1653", Text = "Whispers.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1654", Text = "Whispers!" },
			{ Cue = "/VO/Melinoe_1655", Text = "More Whispers." },
			{ Cue = "/VO/Melinoe_1656", Text = "Let's hear it, Whispers." },
		},
	},

	Guard_Elite =
	{
		InheritFrom = { "Elite", "Guard" },
		HealthBuffer = 80,
		IsAggroedSound = "/SFX/Enemy Sounds/Guard/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"GuardMelee_Elite",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 12,
			BlockEnemyTypes = {"Guard"}
		},
	},

	Guard2 =
	{
		InheritFrom = { "OceanusUnitData", "Guard" },
		DeathFx = "EnemyDeathFxIris",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamaged",
			Rapid = "HitSparkEnemyDamagedRapid",
		},
		
		IntroEncounterName = "FishmanIntro",
		IsAggroedSound = "/SFX/Enemy Sounds/Guard/EmoteTaunting",
		MaxHealth = 190,

		AIAggroRange = 800,

		ActivateAnimation = "Enemy_Guard_Idle",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"GuardSaw",
		},

		GeneratorData =
		{
			DifficultyRating = 12,
			BlockEnemyTypes = {"Guard2_Elite"}
		},
	},

	Guard2_Elite =
	{
		InheritFrom = { "Elite", "Guard2" },
		HealthBuffer = 190,
		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 29,
			BlockEnemyTypes = {"Guard2"}
		},
	},

	Guard3 =
	{
		InheritFrom = { "Guard" },
		IsAggroedSound = "/SFX/Enemy Sounds/Guard/EmoteTaunting",
		MaxHealth = 460,
		
		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"GuardHyperSpin",
		},

		GeneratorData =
		{
			DifficultyRating = 40,
		},
	},

	Guard4 =
	{
		InheritFrom = { "Guard" },
		IsAggroedSound = "/SFX/Enemy Sounds/Guard/EmoteTaunting",
		MaxHealth = 560,
		
		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"GuardRanged",
		},

		GeneratorData =
		{
			DifficultyRating = 50,
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Guard )