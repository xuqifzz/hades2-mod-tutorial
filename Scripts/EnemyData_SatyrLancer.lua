UnitSetData.SatyrLancer =
{
	SatyrLancer =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		ActivateAnimation = "Enemy_SatyrLancer_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronos",
		ActivateFx2 = "EnemyPreSpawnStandingMediumChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 200 },
		DeathFx = "EnemyDeathFxChronos",
		DeathAnimation = "Enemy_SatyrLancer_Death",

		MaxHealth = 990,
		HealthBarOffsetY = -220,
		HealthBarType = "MediumLarge",

		Groups = { "GroundEnemies", "ChronosForces" },
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteDying",
		Material = "Bone",

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,

			AmbientBattleTargetGroups = { "Automatons" },
		},

		StunAnimations = 
		{
			Default = "Enemy_SatyrLancer_OnHit",
			Heavy = "Enemy_SatyrLancer_OnHit_Heavy",
		},

		InvulnerableFx = "SatyrShielded",
		InvulnerableHitFx = "SatyrShieldBlock",
		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 780,
		WeaponOptions =
		{
			"SatyrLancerThrust", "SatyrLancerThrow",
			"SatyrLancerBackDash", "SatyrLancerStrafeRight", "SatyrLancerStrafeLeft",
		},
		OnDamagedWeaponInterrupt = "SatyrLancerBackDash",
		OnDamagedWeaponCooldown = 5.0,

		HeraclesCombatMoneyValue = 2,
		ActiveCapWeight = 1,
		GeneratorData =
		{
			DifficultyRating = 120,
			BlockEnemyTypes = {"SatyrLancer_Elite"}
		},

		EnemySightedVoiceLines =
		{
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

				{ Cue = "/VO/MelinoeField_1631", Text = "Hoplites!" },
				{ Cue = "/VO/MelinoeField_1632", Text = "Hoplites...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1633", Text = "Those Hoplites." },
				{ Cue = "/VO/MelinoeField_1634", Text = "More Hoplites..." },
			},
			[2] = { GlobalVoiceLines = "SatyrsSightedVoiceLines" },
		},
	},

	SatyrLancer_Elite =
	{
		InheritFrom = { "Elite", "SatyrLancer" },
		HealthBuffer = 790,
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Homing" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrLancerThrust_Elite", "SatyrLancerThrow_Elite",
			"SatyrLancerBackDash", "SatyrLancerStrafeRight", "SatyrLancerStrafeLeft",
		},

		HeraclesCombatMoneyValue = 5,
		GeneratorData =
		{
			DifficultyRating = 220,
			BlockEnemyTypes = {"SatyrLancer"}
		},

		EnemySightedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "SatyrsSightedVoiceLines" },
		},
	},


	SatyrLancer_Shadow =
	{
		InheritFrom = { "Shadow", "SatyrLancer" },
		GenusName = "SatyrLancer",
		MaxHealth = 1800,
		HealthBuffer = 1600,

		WeaponOptions =
		{
			"SatyrLancerThrust_Elite", "SatyrLancerThrow_Elite",
			"SatyrLancerBackDash", "SatyrLancerStrafeRight", "SatyrLancerStrafeLeft",
		},
	},

	SatyrLancer2 =
	{
		InheritFrom = { "BasePEnemy", "BaseChronosForces", "SatyrLancer" },
		MaxHealth = 1090,

		ActivateAnimation = "Enemy_SatyrLancer_SpawnOlympus",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0, 
		ActivateDuration = 0.55,
		WakeUpDelay = 1.3,
		ActivateStartOffsetZ = 2000,
		PostActivateStop = true,

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args = { CreateAnimation = "OlympusColdBreathEmitterLarge", },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "P_Boss01" },
					},
				},
			},
		},

		GrannyTexture = "GR2/SatyrLancer2_Color",
		DeathFx = "null",
		DeathAnimation = "Enemy_SatyrLancer2_Death",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrLancer2Thrust", "SatyrLancer2Throw",
			"SatyrLancerBackDash", "SatyrLancerStrafeRight", "SatyrLancerStrafeLeft",
		},

		HeraclesCombatMoneyValue = 6,
		GeneratorData =
		{
			DifficultyRating = 220,
			BlockEnemyTypes = {"SatyrLancer2_Elite"}
		},
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysicalOlympus",
			Rapid = "HitSparkEnemyDamagedPhysicalOlympusRapid",
		},

		EnemySightedVoiceLines =
		{
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
					{ Name = "OlympusEnemiesSightedVO", Time = 12 },
				},
				SuccessiveChanceToPlay = 0.1,

				{ Cue = "/VO/MelinoeField_2741", Text = "Goldpikes..." },
				{ Cue = "/VO/MelinoeField_2742", Text = "Goldpikes...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2743", Text = "More Goldpikes." },
				{ Cue = "/VO/MelinoeField_2744", Text = "Goldpikes again...!" },
			},
			{ GlobalVoiceLines = "ChronosLegionsSightedVoiceLines" },
			{ GlobalVoiceLines = "SatyrsSightedVoiceLines" },
		},
	},

	SatyrLancer2_Elite =
	{
		InheritFrom = { "Elite", "SatyrLancer2" },
		HealthBuffer = 880,
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Homing" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrLancer2Thrust_Elite", "SatyrLancer2Throw_Elite",
			"SatyrLancerBackDash", "SatyrLancerStrafeRight", "SatyrLancerStrafeLeft",
		},

		HeraclesCombatMoneyValue = 7,
		GeneratorData =
		{
			DifficultyRating = 260,
			BlockEnemyTypes = {"SatyrLancer2"}
		},
	},

	SatyrLancer_Prometheus =
	{
		InheritFrom = { "SatyrLancer2" },
		HideHealthBar = true,
		GenusName = "SatyrLancer",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			"AttackerAI",
		},

		WeaponOptions =
		{
			"SatyrLancerThrow_Prometheus",
		},

		SpellSummonDataOverrides =
		{
			HideHealthBar = false,
			WeaponOptions =
			{
				"SatyrLancerThrow_PrometheusAlly"
			},
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SatyrLancer )