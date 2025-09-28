UnitSetData.SatyrCrossbow =
{
	SatyrCrossbow =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 600,
		HealthBuffer = 2550,

		ActivateAnimation = "Enemy_SatyrCB_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronos",
		ActivateFx2 = "EnemyPreSpawnStandingMediumChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 200 },
		DeathFx = "EnemyDeathFxChronos",
		DeathAnimation = "Enemy_SatyrCB_Death",

		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -120,
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteDying",

		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
		InvulnerableFx = "SatyrShielded",
		InvulnerableHitFx = "SatyrShieldBlock",
		
		BlockRespawnShrineUpgrade = true,

		StunAnimations = 
		{
			Default = "Enemy_SatyrCB_OnHit",
			Heavy = "Enemy_SatyrCB_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},

		WeaponOptions =
		{
			"SatyrCrossbowShieldedBolt", "SatyrCrossbowShieldRush", "SatyrCrossbowFadeBolt",
		},

		GeneratorData =
		{
			DifficultyRating = 100,
		},
	},

	SatyrCrossbow_Shadow =
	{
		InheritFrom = { "Shadow", "SatyrCrossbow" },
		GenusName = "SatyrCrossbow",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
	},

	SatyrCrossbow2 =
	{
		InheritFrom = { "BasePEnemy", "BaseChronosForces", "SatyrCrossbow" },
		MaxHealth = 750,
		HealthBuffer = "nil",

		Groups = { "GroundEnemies", "ChronosForces" },

		ActivateAnimation = "Enemy_SatyrCB_SpawnOlympus",
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

		HealthBarAttachToMarkerName = "nil",
		HealthBarOffsetY = -220,

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

		GrannyTexture = "GR2/SatyrCrossbow2_Color",
		DeathFx = "null",
		DeathAnimation = "Enemy_SatyrCB2_Death",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrCrossbow2ShieldedBolt", 
			"SatyrCrossbow2ShieldRush",
		},

		HeraclesCombatMoneyValue = 6,
		ActiveCapWeight = 1.9,
		GeneratorData =
		{
			DifficultyRating = 240,
			BlockEnemyTypes = {"SatyrCrossbow2_Elite"}
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
				SuccessiveChanceToPlay = 0.1,

				{ Cue = "/VO/MelinoeField_2745", Text = "Raiders..." },
				{ Cue = "/VO/MelinoeField_2746", Text = "Raiders...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2747", Text = "More Raiders." },
				{ Cue = "/VO/MelinoeField_2748", Text = "Blasted Raiders..." },
			},
			{ GlobalVoiceLines = "ChronosLegionsSightedVoiceLines" },
			{ GlobalVoiceLines = "SatyrsSightedVoiceLines" },
		},
	},

	SatyrCrossbow2_Elite =
	{
		InheritFrom = { "Elite", "SatyrCrossbow2" },
		HealthBuffer = 590,
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrCrossbow2ShieldedBolt", 
			"SatyrCrossbow2ShieldRush", 
		},

		HeraclesCombatMoneyValue = 10,
		ActiveCapWeight = 2.0,
		GeneratorData =
		{
			DifficultyRating = 390,
			BlockEnemyTypes = {"SatyrCrossbow2"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SatyrCrossbow )