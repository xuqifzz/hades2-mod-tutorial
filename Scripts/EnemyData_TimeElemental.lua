UnitSetData.TimeElemental =
{
	TimeElemental =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 325,
		HealthBarOffsetY = -170,
		HealthBarType = "Small",

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalAggro",
		Material = "Stone",

		ActivateAnimation = "Enemy_TimeElemental_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronos_Small",
		ActivateFx2 = "EnemyPreSpawnStandingSmallChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		DeathFx = "EnemyDeathFxChronos",
		DeathAnimation = "Enemy_TimeElemental_Death",

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,

			SurroundRetaliateDistance = 550,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 3,
		},
		
		StunAnimations = 
		{
			Default = "Enemy_TimeElemental_OnHit",
			Heavy = "Enemy_TimeElemental_OnHit_Heavy",
		},
		
		OnDeathFireWeapons = { "TimeElementalDeath" },

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "SurroundAI",
		WanderTowardPlayer = true,
		AIAggroRange = 850,
		
		WeaponOptions =
		{
			"TimeElementalOrbit"
		},

		BlockAttributes = { "StasisDeath", },

		ActiveCapWeight = 0.5,
		GeneratorData =
		{
			DifficultyRating = 55,
			BlockEnemyTypes = {"TimeElemental_Elite"},
			BlockSolo = true,
		},

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "I_Boss01" },
				},
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_1651", Text = "Tempii." },
			{ Cue = "/VO/MelinoeField_1652", Text = "Tempii!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1653", Text = "More Tempii." },
			{ Cue = "/VO/MelinoeField_1654", Text = "More of those Tempii." },
		},
	},

	TimeElemental_Elite =
	{
		InheritFrom = { "Elite", "TimeElemental" },
		HealthBuffer = 335,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"TimeElementalOrbit_Elite"
		},

		GeneratorData =
		{
			DifficultyRating = 105,
			BlockEnemyTypes = {"TimeElemental"}
		},
	},

	TimeElemental2 =
	{
		InheritFrom = { "TimeElemental" },
		GenusName = "TimeElemental",

		MaxHealth = 445,		
		GrannyTexture = "GR2/TimeElementalChronos_Color",

		AggroReactionTime = 0,
		DefaultAIData =
		{
			DeepInheritance = true,
			MoveSuccessDistance = 75,
			MaxAttackers = 999,
			TargetMaxDistance = 9999,
		},
		PostAggroAI = "AttackerAI",

		WeaponOptions =
		{
			"TimeElementalHealBeam",
		},

		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"TimeElemental2_EM"}
		},
		ProjectilesCollideWithGroupsCharmed =
		{
			"HeroTeam",
		},
	},

	TimeElemental2_EM =
	{
		InheritFrom = { "TimeElemental2" },
		GenusName = "TimeElemental2",
		MaxHealth = 650,

		HealthBarOffsetY = -190,
		HealthBarType = "Medium",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"TimeElementalHealBeam_EM"
		},

		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"TimeElemental2"}
		},
	},

	TimeElemental2_Typhon =
	{
		InheritFrom = { "TimeElemental2" },
		GenusName = "TimeElemental2",
		MaxHealth = 1200,

		HealthBarOffsetY = -210,
		HealthBarType = "MediumLarge",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"TimeElementalHealBeam_Typhon"
		},

		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"TimeElemental2"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.TimeElemental )