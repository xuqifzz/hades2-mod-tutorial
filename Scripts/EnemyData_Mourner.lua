UnitSetData.Mourner =
{
	Mourner =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 855,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -280,

		IntroEncounterName = "MournerIntro",

		SkipAlertedText = true,
		IsAggroedSound = "/SFX/Enemy Sounds/Mourner/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Mourner/EmoteDying",

		AttachedAnimationName = "MournerDrips",

		DeathAnimation = "Enemy_Mourner_Death",
		DeathFx = "EnemyDeathFxIris",

		ActivateAnimation = "Enemy_Mourner_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainQuick",
		ActivateFx2 = "EnemyPreSpawnStandingQuick",
		ActivateFxPreSpawn = "nil",
		ActivateFxPreSpawnDelay = 0.25,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.0,
		ActivateFadeInDuration = 0.25,
		ActivateTint = true,
		ActivateTintDelay = 0.0,
		ActivateTintDuration = 0.5,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.75,

		OnDamagedFunctionNames = { "CheckWeaponInterrupt" },
		
		StunAnimations = 
		{
			Default = "Enemy_Mourner_OnHit",
			Heavy = "Enemy_Mourner_OnHit_Heavy",
		},

		UniqueIconAttachments = 
		{
			Burn = "Mourner_Rig:root_00_M_JNT",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundRetaliateDistance = 400,
			SurroundRefreshInterval = 0.4,
			MaxAttackers = 99, -- Only restrict MournerRampage
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "SurroundAI",
		
		WeaponOptions =
		{
			"MournerRampage",
			"MournerRampage",
			"MournerRampage",
			"MournerRampage",
			"MournerScream",
		},

		SpellSummonDataOverrides =
		{
			OutgoingDamageModifiers =
			{
				{
					NonPlayerMultiplier = 0.2,
				},
			},
		},

		ActiveCapWeight = 1.0,
		GeneratorData =
		{
			DifficultyRating = 85,
			BlockEnemyTypes = {"Mourner_Elite"}
		},

		EnemySightedVoiceLines =
		{
			UsePlayerSource = true,
			RandomRemaining = true,
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
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

			{ Cue = "/VO/MelinoeField_1036", Text = "Mourners...!", PlayFirst = true },
		},
	},

	Mourner_Elite =
	{
		InheritFrom = { "Elite", "Mourner" },
		HealthBuffer = 590,
		HealthBarOffsetY = -310,

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Metallic" }),

		IsAggroedSound = "/SFX/Enemy Sounds/Mourner/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"MournerRampage_Elite",
			"MournerRampage_Elite",
			"MournerRampage_Elite",
			"MournerRampage_Elite",
			--"MournerScream",
		},

		GeneratorData =
		{
			DifficultyRating = 160,
			BlockEnemyTypes = {"Mourner"},
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">",
				Value = 1
			},
		},
	},

	Mourner_Shadow =
	{
		InheritFrom = { "Shadow", "Mourner" },
		GenusName = "Mourner",
		HealthBarOffsetY = -370,
		HealthBuffer = 2350,
		HealthBarType = "Large",

		AIAggroRange = 400,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"MournerCast_Elite",
			"MournerRampage_Elite",
			"MournerRampage_Elite",
			"MournerRampage_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 130,
			BlockEnemyTypes = {"Mourner"},
		},

	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Mourner )