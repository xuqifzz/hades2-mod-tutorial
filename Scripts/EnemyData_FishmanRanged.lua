UnitSetData.FishmanRanged =
{

	FishmanRanged =
	{
		InheritFrom = { "OceanusUnitData", "BaseVulnerableEnemy" },
		
		ActivateAnimation = "Enemy_FishmanRanged_Spawn",
		ClearChillOnDeath = true,
		MaxHealth = 390,
		HealthBarOffsetY = -200,
		HealthBarType = "MediumLarge",
		Material = "Organic",

		IsAggroedSound = "/SFX/Enemy Sounds/FishmanRanged/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/FishmanRanged/EmoteDying",

		OnDeathFireWeapons = { "FishmanRangedSelfDestruct" },
		DeathAnimation = "EnemyDeathFx_Medium",
		DeathFx = "EnemyDeathFxFish",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1100,

		StunAnimations = 
		{
			Default = "Enemy_FishmanRanged_HitStun",
			Heavy = "Enemy_FishmanRanged_HitStun_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackSound = "/SFX/Enemy Sounds/FishmanRanged/EmoteCharging",
		},

		WeaponOptions =
		{
			"FishmanRanged",
		},

		GeneratorData =
		{
			DifficultyRating = 36,
			BlockEnemyTypes = {"FishmanRanged_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0083", Text = "Hippos!" },
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

			{ Cue = "/VO/MelinoeField_0082", Text = "Hippos.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0083", Text = "Hippos!" },
			{ Cue = "/VO/MelinoeField_0084", Text = "More Hippos." },
			{ Cue = "/VO/MelinoeField_0085", Text = "More Hippos...!" },
		},
	},

	FishmanRanged_Elite =
	{
		InheritFrom = { "Elite", "FishmanRanged" },
		HealthBuffer = 335,

		IsAggroedSound = "/SFX/Enemy Sounds/FishmanRanged/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
			MaxAttackers = 3,
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		WeaponOptions =
		{
			"FishmanRanged_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 79,
			BlockEnemyTypes = {"FishmanRanged"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.FishmanRanged )