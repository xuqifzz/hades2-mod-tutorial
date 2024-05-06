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
		Material = "Metal",

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
		WanderTowardPlayer = true,
		AIAggroRange = 850,
		
		WeaponOptions =
		{
			"TimeElementalOrbit"
		},

		ActiveCapWeight = 0.5,
		GeneratorData =
		{
			DifficultyRating = 45,
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
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
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

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		WeaponOptions =
		{
			"TimeElementalOrbit_Elite"
		},

		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"TimeElemental"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.TimeElemental )