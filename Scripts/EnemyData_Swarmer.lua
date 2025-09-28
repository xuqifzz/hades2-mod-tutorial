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

		BlockAttributes = { "SpreadHitShields", },

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
				-- None
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_2749", Text = "Sandskulls." },
			{ Cue = "/VO/MelinoeField_2750", Text = "Sandskulls...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2751", Text = "More Sandskulls." },
			{ Cue = "/VO/MelinoeField_2752", Text = "More Sandskulls...?" },
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
			DifficultyRating = 35,
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

		GeneratorData =
		{
			DifficultyRating = 65,
			BlockEnemyTypes = {"SwarmerClockwork",}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Swarmer )