UnitSetData.FishmanMelee =
{
	
	FishmanMelee =
	{
		InheritFrom = { "OceanusUnitData", "BaseVulnerableEnemy" },

		ActivateAnimation = "Enemy_FishmanMelee_Spawn",
		ActivateFx = "WaterUnitSurfaceLarge",
		ActivateFxPreSpawn = "WaterUnitSurface",
		ActivateFadeInDuration = 0.1,
		ActivateFxPreSpawnDelay = 0.5,
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 200 },

		DeathAnimation = "Enemy_FishmanMelee_Death",
		MaxHealth = 615,
		HealthBarOffsetY = -200,
		Material = "Organic",

		IsAggroedSound = "/SFX/Enemy Sounds/FishmanMelee/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/FishmanMelee/EmoteDying",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 910,

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		CancelChainedWeaponOnHitStun = true,

		StunAnimations = 
		{
			Default = "Enemy_FishmanMelee_HitStun",
			Heavy = "Enemy_FishmanMelee_HitStun_Heavy",
		},

		WeaponOptions =
		{
			"FishmanImpale",
		},

		GeneratorData =
		{
			DifficultyRating = 45,
			BlockEnemyTypes = {"FishmanMelee_Elite"}
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

			{ Cue = "/VO/MelinoeField_0078", Text = "Lurkers." },
			{ Cue = "/VO/MelinoeField_0079", Text = "Lurkers!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0080", Text = "More Lurkers." },
			{ Cue = "/VO/MelinoeField_0081", Text = "Come, Lurkers." },
		},
	},

	FishmanMelee_Elite =
	{
		InheritFrom = { "Elite", "FishmanMelee" },
		HealthBuffer = 485,

		IsAggroedSound = "/SFX/Enemy Sounds/FishmanMelee/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex", "Metallic" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		--[[
		WeaponOptions =
		{
			"FishmanImpale_Elite",
		},
		]]

		GeneratorData =
		{
			DifficultyRating = 105,
			BlockEnemyTypes = {"FishmanMelee"}
		},
	},

	FishmanMelee2 =
	{
		InheritFrom = { "Elite", "FishmanMelee" },
		GenusName = "FishmanMelee_Elite",
		MaxHealth = 2600,
		HealthBuffer = 2600,

		GrannyTexture = "GR2/FishmanMeleeTyphon_Color",

		IsAggroedSound = "/SFX/Enemy Sounds/FishmanMelee/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex", "Metallic" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"Fishman2Impale",
		},

		SpellSummonDataOverrides =
		{
			WeaponOptions =
			{
				"Fishman2Impale_Ally"
			},
		},

		GeneratorData =
		{
			DifficultyRating = 95,
			BlockEnemyTypes = {"FishmanMelee"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.FishmanMelee )