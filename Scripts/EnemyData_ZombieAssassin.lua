UnitSetData.Zombie =
{

	ZombieAssassin =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "ZombieAssassinIntro",

		MaxHealth = 230,
		HealthBarType = "Medium",
		HealthBarOffsetY = -200,

		ActivateFx = "ZombieAssassinSpawnSmokeA",
		ActivateFx2 = "Blank",
		ActivateFxPreSpawn = "EnemySpawnBurst",
		DeathAnimation = "Enemy_ZombieAssassin_Death",
		DeathFx = "EnemyDeathFxUndead",
		ActivateAnimation = "Enemy_ZombieAssassin_Spawn",
		ActivateTint = false,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 1.0,
		ActivateDuration = 1.50,
		
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedUndead",
			Rapid = "HitSparkEnemyDamagedUndeadRapid",
		},

		IsAggroedSound = "/SFX/Enemy Sounds/Assassin/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Assassin/EmoteDying",

		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "GroundEnemies" },
		Material = "Bone",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1500,
		
		StunAnimations = 
		{
			Default = "Enemy_ZombieAssassin_OnHit",
			Heavy = "Enemy_ZombieAssassin_OnHit_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,
		},
		
		HeraclesCombatMoneyValue = 2,

		WeaponOptions =
		{
			"ZombieAssassinStab", "ZombieAssassinLateralDash", "ZombieAssassinLateralDash", "ZombieAssassinStalk"
		},
		--OnHitFunctionName = "AssassinSlide",
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"ZombieAssassinStab", "ZombieAssassinLateralDash", "ZombieAssassinLateralDash"
			},
		},

		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"ZombieAssassin_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
			},
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0460", Text = "Cutthroats!", PlayFirst = true },
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
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0459", Text = "Cutthroats.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0460", Text = "Cutthroats!" },
			{ Cue = "/VO/MelinoeField_0461", Text = "More Cutthroats." },
			{ Cue = "/VO/MelinoeField_0462", Text = "More Cutthroats...!" },
		},
	},

	ZombieAssassin_Elite =
	{
		InheritFrom = { "ZombieAssassin" },
		HealthBuffer = 230,

		IsAggroedSound = "/SFX/Enemy Sounds/Assassin/EmoteTaunting",

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		HeraclesCombatMoneyValue = 4,

		WeaponOptions =
		{
			"ZombieAssassinStab_Elite", "ZombieAssassinLateralDash", "ZombieAssassinLateralDash", "ZombieAssassinStalk"
		},
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"ZombieAssassinStab_Elite", "ZombieAssassinLateralDash", "ZombieAssassinLateralDash"
			},
		},

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"ZombieAssassin"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Zombie )