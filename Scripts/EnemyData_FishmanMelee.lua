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

		StunAnimations = 
		{
			Default = "Enemy_FishmanMelee_HitStun",
			Heavy = "Enemy_FishmanMelee_HitStun_Heavy",
		},

		WeaponOptions =
		{
			"FishmanImpale"
		},

		GeneratorData =
		{
			DifficultyRating = 45,
			BlockEnemyTypes = {"FishmanMelee_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			PreLineWait = 0.65,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0079", Text = "Lurkers!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "ArachneCombatG" },
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0078", Text = "Lurkers.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0079", Text = "Lurkers!" },
			{ Cue = "/VO/MelinoeField_0080", Text = "More Lurkers." },
			{ Cue = "/VO/MelinoeField_0081", Text = "Come, Lurkers." },
		},
	},

	FishmanMelee_Elite =
	{
		InheritFrom = { "Elite", "FishmanMelee" },
		HealthBuffer = 485,

		IsAggroedSound = "/SFX/Enemy Sounds/FishmanMelee/EmoteTaunting",

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

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 95,
			BlockEnemyTypes = {"FishmanMelee"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.FishmanMelee )