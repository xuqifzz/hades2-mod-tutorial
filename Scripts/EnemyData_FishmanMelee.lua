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

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex" }),

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
			DifficultyRating = 95,
			BlockEnemyTypes = {"FishmanMelee"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.FishmanMelee )