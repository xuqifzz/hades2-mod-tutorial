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
		PostAggroAI = "SurroundAI",

		StunAnimations = 
		{
			Default = "Enemy_FishmanRanged_HitStun",
			Heavy = "Enemy_FishmanRanged_HitStun_Heavy",
		},

		UniqueIconAttachments = 
		{
			Burn = "FishmanRanged_Rig:root_00_M_JNT",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackSound = "/SFX/Enemy Sounds/FishmanRanged/EmoteCharging",

			MaintainSurroundDistance = true,
			SurroundDistance = 600,
			SurroundRefreshInterval = 0.1,
			MaxAttackers = 2,
		},

		WeaponOptions =
		{
			"FishmanRanged",
		},

		GeneratorData =
		{
			DifficultyRating = 39,
			BlockEnemyTypes = {"FishmanRanged_Elite"}
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

			{ Cue = "/VO/MelinoeField_0082", Text = "Hippos." },
			{ Cue = "/VO/MelinoeField_0083", Text = "Hippos!", PlayFirst = true },
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
			MaxAttackers = 2,
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