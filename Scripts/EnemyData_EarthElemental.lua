UnitSetData.EarthElemental =
{

	EarthElemental =
	{
		InheritFrom = { "BaseQEnemy", "BaseVulnerableEnemy", "LowPolyEnemy" },

		ActivateAnimation = "Enemy_EarthElemental_Spawn",
		ActivateFx = "EarthElementalHoleIn",
		ActivateFx2 = "null",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1, 
		ActivateDuration = 0.5,
		WakeUpDelay = 0.7,

		MaxHealth = 900,
		HealthBarOffsetY = -170,
		HealthBarType = "Small",

		ArmorSparkAnimation = "HitSparkArmor_Small",
		DeathSound = "/SFX/Enemy Sounds/EarthElemental/EmoteDying",
		DeathAnimation = "Enemy_EarthElemental_Death",
		DestroyDelay = 6,

		PreferredSpawnPoint = "EnemyPointRanged",

		GrannyTexture = "GR2/EarthElementalTyphon_Color",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetalRapid",
			Rapid = "HitSparkEnemyDamagedMetalRapid",
		},

		Groups = { "GroundEnemies", "ChronosForces", "Automatons" },
		IsAggroedSound = "/SFX/Enemy Sounds/EarthElemental/EmoteAlerted",
		Material = "Stone",

		StunAnimations = 
		{
			Default = "Enemy_EarthElemental_OnHit",
			Heavy = "Enemy_EarthElemental_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,
		SpawnAwayFromTypes = { "EarthElemental" },
		SpawnAwayFromTypesDistance = 550,

		DefaultAIData =
		{
			DeepInheritance = true,

			DoNotRepeatOnAttackFail = true,
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0.0
			},
		},

		WeaponOptions =
		{
			"EarthElementalLaser",
		},

		SpellSummonDataOverrides =
		{
			DeepInheritance = true,

			WeaponOptions =
			{
				"EarthElementalSelfDestruct"
			},

			OutgoingDamageModifiers =
			{
				{
					NonPlayerMultiplier = 1.0
				},
			},
		},

		BlockAttributes = { "Orbit", "Vacuum", },

		ActiveCapWeight = 0.34,
		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"EarthElemental_Elite"}
		},
	},

	EarthElemental_Elite =
	{
		InheritFrom = { "Elite", "EarthElemental" },
		HealthBuffer = 900,
		IsAggroedSound = "/SFX/Enemy Sounds/EarthElemental/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		
		WeaponOptions =
		{
			"EarthElementalLaser_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 60,
			BlockEnemyTypes = {"EarthElemental"}
		},
	},

	EarthElemental_Shadow =
	{
		InheritFrom = { "Shadow", "EarthElemental" },
		GenusName = "EarthElemental",
		HealthBuffer = 900,

		DeathAnimation = "Enemy_EarthElemental_Shadow_Death",
		
		WeaponOptions =
		{
			"EarthElementalLaser_Shadow",
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.EarthElemental )

WeaponSetData =
{
	EarthElementalLaser =
	{
		Requirements =
		{
			--RequireMinIdsOfTypes = { Names = "EarthElemental", "EarthElemental_Elite", Count = 2 }, -- this seems to make it never fire
		},

		AIData =
		{
			DeepInheritance = true,
			TargetClosestOfTypes = { "EarthElemental", "EarthElemental_Elite", "EarthElemental_Shadow" },
			--TargetPlayerIfNoTarget = true,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "FireSpeedDamp",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "SPEED",
						Duration = 3.4,
						Modifier = 0.25,
					}
				},
			},

			ProjectileName = "EarthElementalLaser",
			BarrelLength = 0,
			FireProjectileStartDelay = 0.12,
			ExpireProjectilesOnHitStun = true,
			ExpireProjectilesOnFreeze = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,
			SkipRetreatEndStop = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackSound = "/SFX/Enemy Sounds/EarthElemental/EmoteCharging",
			PreAttackAnimation = "Enemy_EarthElemental_BoltPreFire",
			FireAnimation = "Enemy_EarthElemental_BoltFire",
			PostAttackAnimation = "Enemy_EarthElemental_BoltPostFire",
			PreAttackFx = "EarthElementalBeamPreview",
			EndPreAttackFx = true,

			PreAttackDuration = 1.0,
			FireDuration = 3.4,
			PostAttackDurationMin = 1.3, -- anim is 0.65
			PostAttackDurationMax = 1.8,

			RetreatWhileFiring = true,
			RetreatToSpawnPoints = true,
			RetreatBufferDistance = 1000,
			RetreatProximity = 50,
			RetreatOccupySpawnPoint = true,

			RequireProjectileLoS = true,
			AttackDistance = 1200,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EarthElemental/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusBloodshotFire" },
			},
		},
	},

	EarthElementalLaser_Elite =
	{
		InheritFrom = { "EarthElementalLaser" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EarthElementalLaser_Elite",
		},
	},
	EarthElementalLaser_Shadow =
	{
		InheritFrom = { "EarthElementalLaser" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EarthElementalLaser_Shadow",
		},
	},

	EarthElementalSelfDestruct =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EarthElementalSelfDestruct",

			FireProjectileAtSelf = true,
			FireFromTarget = true,
			PreAttackStop = true,

			PreAttackEndDuration = 1.3,
			PreAttackEndShake = true,
			PreAttackSound = "/SFX/BombFusePreExplode",

			PreAttackDuration = 1.3,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = true,
			AttackDistance = 150,

			PostAttackKillSelf = true,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil