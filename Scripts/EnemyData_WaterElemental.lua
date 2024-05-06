UnitSetData.WaterElemental =
{

	WaterElemental =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },
		IntroEncounterName = "WaterElementalIntro",

		MaxHealth = 110,
		HealthBarOffsetY = -120,
		HealthBarType = "Small",

		ActivateFx = "WaterUnitSurface",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateFadeInDelay = 0.00,
		ActivateFadeInDuration = 0.6,
		ActivateDuration = 0.3,
		ActivateTint = false,
		ActivateStartAlpha = 0,

		ActiveCapWeight = 0.20,
		ArmorSparkAnimation = "HitSparkArmor_Small",
		DeathSound = "/SFX/Enemy Sounds/WaterElemental/EmoteDying",

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/WaterElemental/EmoteAlerted",
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_WaterElemental_OnHit",
			Heavy = "Enemy_WaterElemental_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,

		DefaultAIData =
		{
			DeepInheritance = true,

			--MaintainSurroundDistance = true,
			--SurroundDistance = 500,
			--SurroundRefreshInterval = 0.5,
			--MaxAttackers = 20,
		},
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			--"WaterElementalBite", "WaterElementalBurst", "WaterElementalDuplicate"
			"WaterElementalBite", 
			--"WaterElementalDuplicate",
		},

		HeraclesCombatMoneyValue = 1,
		ActiveCapWeight = 0.5,
		GeneratorData =
		{
			DifficultyRating = 13,
			BlockEnemyTypes = {"WaterElemental_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_2160", Text = "Droplets...!" },
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

			{ Cue = "/VO/MelinoeField_2159", Text = "Droplets...", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2160", Text = "Droplets...!" },
			{ Cue = "/VO/MelinoeField_2161", Text = "More Droplets." },
			{ Cue = "/VO/MelinoeField_2162", Text = "More Droplets?" },
		},

	},

	WaterElemental_Elite =
	{
		InheritFrom = { "Elite", "WaterElemental" },
		HealthBuffer = 110,
		IsAggroedSound = "/SFX/Enemy Sounds/WaterElemental/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		WeaponOptions =
		{
			"WaterElementalBite_Elite", 
			--"WaterElementalBurst_Elite", 
			--"WaterElementalDuplicate_Elite"
		},

		HeraclesCombatMoneyValue = 2,
		GeneratorData =
		{
			DifficultyRating = 24,
			BlockEnemyTypes = {"WaterElemental"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.WaterElemental )