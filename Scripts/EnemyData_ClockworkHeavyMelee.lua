UnitSetData.ClockworkHeavyMelee =
{
	ClockworkHeavyMelee =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 1650,
		HealthBarOffsetY = -250,
		ArmorSparkAnimation = "HitSparkArmor_Large",

		ActivateAnimation = "Enemy_CWHeavyMelee_Spawn",
		ActivateStartAlpha = 1.0,
		ActivateFx = "EnemyPreSpawnTerrainChronosLarge",
		ActivateFx2 = "EnemyPreSpawnStandingLargeChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		DeathFx = "EnemyDeathFxChronos",
		DeathAnimation = "Enemy_CWHeavyMelee_Death",
		DeathSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteDying",

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteAlerted",
		Material = "Bone",

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,
		},

		StunAnimations = 
		{
			Default = "Enemy_CWHeavyMelee_OnHit",
			Heavy = "Enemy_CWHeavyMelee_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 780,
		WeaponOptions =
		{
			"ThugShove", "ThugSwipe"
		},
		
		BlockAttributes = { "Orbit", "Vacuum", },

		ActiveCapWeight = 1,
		GeneratorData =
		{
			DifficultyRating = 125,
			BlockEnemyTypes = {"ClockworkHeavyMelee_Elite"}
		},

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
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_1643", Text = "Wretches..." },
			{ Cue = "/VO/MelinoeField_1644", Text = "Wretches...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1645", Text = "Come, Wretches!" },
			{ Cue = "/VO/MelinoeField_1646", Text = "More Wretches?" },
		},
	},

	ClockworkHeavyMelee_Elite =
	{
		InheritFrom = { "Elite", "ClockworkHeavyMelee" },
		HealthBuffer = 1050,
		IsAggroedSound = "/SFX/Enemy Sounds/Brawler/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Rifts", "Metallic" }),

		DefaultAIData =
		{
			DeepInheritance = true,
			
			--MoveWithinRangeTimeoutMin = 4.0, -- good with ThugSlam attack
			--MoveWithinRangeTimeoutMax = 5.0,
		},

		WeaponOptions =
		{
			  "ThugSwipe_Elite", "ThugShove_Elite", 
			  --"ThugSlam_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 305,
			BlockEnemyTypes = {"ClockworkHeavyMelee"}
		},
	},

	ClockworkHeavyMelee_SuperElite =
	{
		InheritFrom = { "SuperElite", "ClockworkHeavyMelee_Elite" },
		MaxHealth = 1000,
		HealthBuffer = 5000,
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.ClockworkHeavyMelee )