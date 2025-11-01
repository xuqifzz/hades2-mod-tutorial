UnitSetData.GoldElemental =
{
	GoldElemental =
	{
		InheritFrom = { "BaseVulnerableEnemy","LowPolyEnemy" },

		MaxHealth = 510,
		HealthBarOffsetY = -200,
		HealthBarType = "Medium",

		ActivateAnimation = "Enemy_GoldElemental_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronos",
		ActivateFx2 = "EnemyPreSpawnStandingMediumChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		IsAggroedSound = "/SFX/Enemy Sounds/GoldElemental/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/GoldElemental/EmoteDying",
		DeathFx = "EnemyDeathFxChronos",
		HealthDamageSound = "/SFX/Enemy Sounds/GoldElemental/EmoteHurt",
		DeathAnimation = "Enemy_GoldElemental_Death",

		Groups = { "GroundEnemies" },
		Material = "Bone",

		DefaultAIData =
		{
			DeepInheritance = true,

			RetreatDistance = 500,
			RetreatBufferDistance = 900,
			RetreatTimeoutMin = 1.50,
			RetreatTimeoutMax = 2.00,
			TakeCoverDuration = 1.0,
			CoverHugDistance = 250,

			MaxAttackers = 4,
		},
		AIAggroRange = 900,
		
		StunAnimations = 
		{
			Default = "Enemy_GoldElemental_OnHit",
			Heavy = "Enemy_GoldElemental_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "HideAndPeekAI",
		PeekAggroMultiplier = 3,

		WeaponOptions =
		{
			"GoldElementalBeam", 
			--"GoldElementalSky"
		},

		ActiveCapWeight = 0.25,
		GeneratorData =
		{
			DifficultyRating = 44,
			BlockEnemyTypes = {"GoldElemental_Elite"}
		},

		BlockAttributes = { "Tracking", "ExtraDamage" },

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

			{ Cue = "/VO/MelinoeField_1655", Text = "Goldwraiths." },
			{ Cue = "/VO/MelinoeField_1656", Text = "Goldwraiths...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1657", Text = "More Goldwraiths." },
			{ Cue = "/VO/MelinoeField_1658", Text = "More Goldwraiths...!" },
		},
	},

	GoldElemental_Elite =
	{
		InheritFrom = { "Elite", "GoldElemental" },
		HealthBuffer = 510,
		IsAggroedSound = "/SFX/Enemy Sounds/GoldElemental/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/GoldElemental/EmoteDying",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"GoldElementalBeam_Elite",
			--"GoldElementalSky"
		},

		GeneratorData =
		{
			DifficultyRating = 88,
			BlockEnemyTypes = {"GoldElemental"}
		},
	},

	GoldElemental_MiniBoss =
	{
		InheritFrom = { "Elite", "GoldElemental" },
		RunHistoryKilledByName = "GoldElemental_MiniBoss",
		MaxHealth = 3100,
		HealthBuffer = 8250,
		HealthBarAttachToMarkerName = "GoldElemental_Rig:root_00_M_JNT",
		HealthBarOffsetY = -150,
		HealthBarType = "Large",
		
		BlockRespawnShrineUpgrade = true,

		IsAggroedSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteHurt",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		PostAggroAI = "AttackerAI",

		WeaponOptions =
		{
			"GoldElementalBeam_MiniBoss", "GoldElementalJumpCombo", "GoldElementalGround"
		},

		GeneratorData =
		{
			DifficultyRating = 200,
			BlockEnemyTypes = {"GoldElemental"}
		},
	},

	GoldElemental_Shadow =
	{
		InheritFrom = { "Shadow", "GoldElemental" },
		GenusName = "GoldElemental",
		MaxHealth = 1000,
		HealthBuffer = 1000,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"GoldElementalBeam_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 75,
			BlockEnemyTypes = {"GoldElemental"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.GoldElemental )