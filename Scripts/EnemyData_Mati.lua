UnitSetData.Mati =
{

	Mati =
	{
		InheritFrom = { "BaseQEnemy", "BaseVulnerableEnemy","LowPolyEnemy" },
		IntroEncounterName = "MatiIntro",

		Material = "Bone",

		ActivateAnimation = "Enemy_Mati_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "MatiLandDust",
		ActivateFxPreSpawnDelay = 0.5,
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0,
		ActivateDuration = 0.45,
		ActivateStartOffsetZ = 2000,
		WakeUpDelay = 0.6,
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 200 },

		MaxHealth = 1510,
		HealthBarOffsetY = -190,
		HealthBarType = "Medium",
		ArmorSparkAnimation = "HitSparkArmor_Medium",
		HitSparkOffsetZ = 50,
		
		GrannyTexture = "GR2/MatiTyphon_Color",

		IsAggroedSound = "/SFX/Enemy Sounds/Mati/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Mati/EmoteDying",

		DeathFx = "EnemyDeathFxTyphonSmall",
		DeathAnimation = "Enemy_Mati_Death",
		
		Groups = { "FlyingEnemies", "ChronosForces" },

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysicalOlympus",
			Rapid = "HitSparkEnemyDamagedPhysicalOlympusRapid",
		},
		
		StunAnimations = 
		{
			Default = "Enemy_Mati_OnHit",
			Heavy = "Enemy_Mati_OnHit_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,
			SurroundRetaliateDistance = 850,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 2,
			SurroundMinTrackTime = 0,
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,
		PostAggroAI = "SurroundAI",

		WeaponOptions = { "MatiHypno", "MatiHypno", "MatiHypno", "MatiHypno", "MatiEyeClose" },

		CloseEyeAddIncomingDamageModifier =
		{
			Name = "MatiEyeClosed",
			PlayerMultiplier = 0.1,
		},

		GeneratorData =
		{
			DifficultyRating = 95,
			BlockEnemyTypes = {"Mati_Elite"}
		},
		ActiveCapWeight = 0.25,

		EnemySightedVoiceLines =
		{
			{ GlobalVoiceLines = "MonstersSightedVoiceLines" },
		},
	},

	Mati_Elite =
	{
		InheritFrom = { "Elite", "Mati" },
		HealthBuffer = 1990,

		IsAggroedSound = "/SFX/Enemy Sounds/Mati/EmoteTaunting",

		WeaponOptions = { "MatiHypno_Elite", "MatiHypno_Elite", "MatiHypno_Elite", "MatiHypno_Elite", "MatiEyeClose" },

		HeraclesCombatMoneyValue = 2,

		GeneratorData =
		{
			DifficultyRating = 190,
			BlockEnemyTypes = {"Mati"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Mati )


WeaponSetData =
{
	MatiHypno =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MatiSlowBolt",
			FireProjectileStartDelay = 0.25,

			PreAttackDuration = 1.05,
			FireDuration = 3.6,
			PostAttackDuration = 1.0,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "MatiFireSpeed",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "SPEED",
						Duration = 1.5,
						Modifier = 1.4,
					}
				},
			},

			MoveWithinRange = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.3,
			PostAttackStop = true,
			
			PreAttackSound = "/SFX/Enemy Sounds/Mati/EmoteCharging",
			PreAttackAnimation = "Enemy_Mati_HypnoPreFire",
			FireAnimation = "Enemy_Mati_HypnoFire",
			PostAttackAnimation = "Enemy_Mati_HypnoPostFire",

			AttackDistance = 800,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Mati/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosBallFireLow" },
			},
		},
	},

	MatiHypno_Elite =
	{
		InheritFrom = { "MatiHypno" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MatiSlowBolt_Elite",
			PreAttackAnimation = "Enemy_Mati_HypnoPreFire",
		}
	},

	MatiEyeClose =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreMoveFunctionName = "MatiCloseEye",
			PostAttackEndFunctionName = "MatiOpenEye",

			MaxAttackers = 99,

			MoveWithinRange = false,
			AttackDistance = 9999,

			PreAttackDuration = 0,
			FireDuration = 3,
			PostAttackDuration = 0,

			DoNotRepeatOnAttackFail = true,
		},
	},

}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil