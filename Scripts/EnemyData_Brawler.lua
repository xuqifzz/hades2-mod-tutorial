UnitSetData.Brawler =
{
		-- tough Terminator-like foe that bursts like an explosive grape
	Brawler =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		UseActivatePresentation = true,
		ActivateAnimation = "Enemy_Brawler_Spawn",
		ActivateStartAlpha = 1.0,
		ActivateFx = "EnemyPreSpawnTerrainMedium",
		ActivateFx2 = "EnemyPreSpawnStandingMedium",
		ActivateFxPreSpawn = "EnemySpawnBurstMedium",

		DeathAnimation = "Enemy_Brawler_Death",
		DeathFx = "EnemyDeathFxIris",

		MaxHealth = 210,
		HealthBarOffsetY = -200,
		Material = "Organic",

		IsAggroedSound = "/SFX/Enemy Sounds/Brawler/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Brawler/EmoteDying",

		PreferredSpawnPoint = "EnemyPointMelee",

		AIOptions =
		{
			"AggroAI",
		},

		StunAnimations = 
		{
			Default = "Enemy_Brawler_HitStun",
			Heavy = "Enemy_Brawler_HitStunLong",
			Light = "Enemy_Brawler_HitStun2",
			BlockStun = "Enemy_Brawler_HitStunBlock",
			Lightning = "Enemy_Brawler_HitStunLightning",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Brawler/EmoteCharging",
		},

		WeaponOptions =
		{
			"BrawlerMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 18,
			BlockEnemyTypes = {"Brawler_Elite"}
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

			{ Cue = "/VO/Melinoe_1435", Text = "Wastrels." },
			{ Cue = "/VO/Melinoe_1436", Text = "Wastrels!", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1437", Text = "More Wastrels." },
			{ Cue = "/VO/Melinoe_1438", Text = "Come, Wastrels." },
		},
	},

	Brawler_Elite =
	{
		InheritFrom = { "Elite", "Brawler" },
		HealthBuffer = 330,
		IsAggroedSound = "/SFX/Enemy Sounds/Brawler/EmoteTaunting",

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
			"BrawlerMelee",
		},

		GeneratorData =
		{
			DifficultyRating = 39,
			BlockEnemyTypes = {"Brawler"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Brawler )