UnitSetData.Swarmer =
{
	Swarmer =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "Swarmer",
		PreferredSpawnPoint = "EnemyPointMelee",
		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Swarmer/EmoteAlerted",
		Material = "Bone",

		ActivateAnimation = "Enemy_Swarmer_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronos_Small",
		ActivateFx2 = "EnemyPreSpawnStandingSmallChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		DeathFx = "EnemyDeathFxChronosSmall",
		DeathSound = "/SFX/Enemy Sounds/Swarmer/EmoteDying",
		DeathAnimation = "Enemy_Swarmer_Death",

		BlockAttributes = { "DeathSpreadHitShields" },

		MaxHealth = 30,
		HealthBarOffsetY = -100,

		AggroAnimation = "Enemy_Swarmer_Alert",
		AggroDuration = 0.5,
	
		ActiveCapWeight = 0.35,

		StunAnimations = 
		{
			Default = "Enemy_Swarmer_HitStun",
			Heavy = "Enemy_Swarmer_HitStun_Heavy",
		},

		WeaponOptions =
		{
			"SwarmerMelee",
		},
		AIOptions =
		{
			"AggroAI",
		},

		GeneratorData =
		{
			DifficultyRating = 8,
			BlockEnemyTypes = { "Swarmer_Elite" },
			ActiveEnemyCapBonus = 2, -- to increase the 'swarm'
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

			{ Cue = "/VO/MelinoeField_1647", Text = "Numbskulls." },
			{ Cue = "/VO/MelinoeField_1648", Text = "Numbskulls...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1649", Text = "More Numbskulls." },
			{ Cue = "/VO/MelinoeField_1650", Text = "More Numbskulls...?" },
		},
	},

	Swarmer_Elite =
	{
		InheritFrom = { "Elite", "Swarmer" },
		HealthBuffer = 60,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
		--	RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 20,
			BlockEnemyTypes = { "Swarmer" },
			ActiveEnemyCapBonus = 2 -- to increase the swarm
		},
	},
	
	SwarmerClockwork =
	{
		InheritFrom = { "Swarmer" },
		MaxHealth = 225,
		HealthBarType = "Medium",
		HealthBarOffsetY = -150,

		AttachedAnimationName = "SwarmerClockworkGlow",

		OnDamagedWeaponInterrupt = "SwarmerClockworkRepositionTeleport",
		OnDamagedWeaponCooldown = 4.0,

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIAggroRange = 910,

		WeaponOptions =
		{
			"SwarmerClockworkMelee"
		},

		GeneratorData =
		{
			DifficultyRating = 25,
			BlockEnemyTypes = { "SwarmerClockwork_Elite" }
		},
	},

	SwarmerClockwork_Elite =
	{
		InheritFrom = { "Elite", "SwarmerClockwork" },
		HealthBuffer = 225,
		OnDamagedWeaponCooldown = 3.0,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SwarmerClockworkMelee_Elite",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"SwarmerClockwork",}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Swarmer )