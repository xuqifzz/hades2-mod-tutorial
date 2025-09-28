UnitSetData.LightRanged =
{

	LightRanged =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 70,
		HealthBarOffsetY = -200,
		
		BlockNextBiomeEnemyShrineUpgrade = true,

		PreferredSpawnPoint = "EnemyPointRanged",
		Material = "Bone",

		ActivateAnimation = "Enemy_LightRanged_Spawn",
		ActivateStartAlpha = 1.0,

		IsAggroedSound = "/SFX/Enemy Sounds/Caster/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Caster/EmoteDying",
		DeathFx = "EnemyDeathFxIris",
		DeathAnimation = "Enemy_LightRanged_Death",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1250,
		PostAggroAI = "HideAndPeekAI",
		PeekAggroMultiplier = 3,
		
		StunAnimations = 
		{
			Default = "Enemy_LightRanged_HitStun",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			RetreatDistance = 500,
			RetreatBufferDistance = 900,
			RetreatTimeoutMin = 1.00,
			RetreatTimeoutMax = 1.50,
			TakeCoverDuration = 1.0,
			CoverHugDistance = 250,
			MoveWithinRangeTimeoutMin = 1.5,
			MoveWithinRangeTimeoutMax = 1.9,

			-- FollowAI
			FollowDistance = 100,

			PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",
		},

		WeaponOptions =
		{
			"LightRangedBolt",
		},

		GeneratorData =
		{
			DifficultyRating = 10,
			BlockEnemyTypes = {"LightRanged_Elite"}
		},

		OnDeathFunctionName = "CheckAchievement",
		OnDeathFunctionArgs = { Name = "AchKillWitchAsSheep", },

		OnKillVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.65,
				ObjectType = "Hecate",
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.25,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "PolymorphType" },
						IsAny = { "Sheep", "Pig", "Rat" }
					},
				},
				Cooldowns =
				{
					{ Name = "HecateSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/HecateField_0413", Text = "Still dangerous, I see!" },
				{ Cue = "/VO/HecateField_0414", Text = "More deadly than you look!" },
				{ Cue = "/VO/HecateField_0415", Text = "Clever..." },
				{ Cue = "/VO/HecateField_0416", Text = "You still can fight..." },
			},
		},

	},

	LightRanged_Elite =
	{
		InheritFrom = { "Elite", "LightRanged" },

		HealthBuffer = 130,

		WeaponOptions =
		{
			"LightRangedBolt_Elite",
		},
	},

	SpreadShotUnit =
	{
		InheritFrom = { "LightRanged", },
		GenusName = "SpreadShotUnit",

		AttachedAnimationName = "LightRangedAsphodelGlow",

		MaxHealth = 150,

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundDistance = 550,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 2,
		},
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"SpreadShotBolt",
		},

		GeneratorData =
		{
			DifficultyRating = 20,
			BlockEnemyTypes = {"SpreadShotUnit_Elite"},
		},
	},

	SpreadShotUnit_Elite =
	{
		InheritFrom = { "Elite", "SpreadShotUnit" },

		HealthBuffer = 225,

		ActiveCapWeight = 1.5, -- for encounter difficulty tuning
		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SpreadShotBolt_Elite",
		},
	},
	
}

OverwriteTableKeys( EnemyData, UnitSetData.LightRanged )