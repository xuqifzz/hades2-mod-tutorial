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
		ActivateFx2 = "nil",
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
		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.100,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

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

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
				},
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0459", Text = "Cutthroats." },
			{ Cue = "/VO/MelinoeField_0460", Text = "Cutthroats!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0461", Text = "More Cutthroats." },
			{ Cue = "/VO/MelinoeField_0462", Text = "More Cutthroats...!" },
		},
	},

	ZombieAssassin_Elite =
	{
		InheritFrom = { "ZombieAssassin" },
		HealthBuffer = 230,

		IsAggroedSound = "/SFX/Enemy Sounds/Assassin/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Rifts" }),

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

	ZombieAssassin_Shadow =
	{
		InheritFrom = { "Shadow", "ZombieAssassin" },
		GenusName = "ZombieAssassin",
		
		MaxHealth = 230,
		HealthBuffer = 230,
	},

	ZombieAssassin_Miniboss =
	{
		InheritFrom = { "ZombieAssassin" },
		MaxHealth = 1615,
		HealthBarType = "ExtraLarge",
		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -60,

		DeathSound = "/SFX/Enemy Sounds/AssassinMiniboss/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/AssassinMiniboss/EmoteHurt",

		GrannyTexture = "GR2/AssassinMiniboss_Color",

		ActivateFx = "nil",
		ActivateFx2 = "Blank",
		ActivateFxPreSpawn = "nil",
		ActivateAnimation = "Enemy_ZombieAssassin_StalkIdle_Miniboss",
		SpawnAnimation = "Enemy_ZombieAssassin_StalkExit",
		SpawnFx = "ZombieAssassinCloakFront_Miniboss",
		ActivateTint = false,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 0.7,
		ActivateDuration = 0.7,
		WakeUpDelay = 0.5,
		
		BlockRespawnShrineUpgrade = true,

		IsAggroedSound = "/SFX/Enemy Sounds/Assassin/EmoteTaunting",

		WeaponOptions =
		{
			"ZombieAssassinCombo", "ZombieAssassinStalk_Miniboss",
		},

		AIOptions = { "AttackerAI" },

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"ZombieAssassin"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Zombie )