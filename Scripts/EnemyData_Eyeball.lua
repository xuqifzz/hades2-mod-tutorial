UnitSetData.Eyeball =
{
	Eyeball =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		GenusName = "TyphonEye",
		RunHistoryPortrait = "Codex_Portrait_TyphonEye",
		MaxHealth = 3000,
		BlockCharm = true,
		IgnoreAllyHitPresentation = true,
		ActivateAnimation = "Enemy_Eyeball_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		DoActivateFxAtNearestTypeId = "EnemyPointRanged",
		ActivateMoveToSpawnPoint = true,
		ActivateMoveInvulnerable = true,
		ActivateFxPreSpawnDelay = 0.80,
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1.0, 
		ActivateDuration = 0.95,
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 200 },

		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,

		SkipUnitHitFlash = true,

		AttachedAnimationName = "TyphonEyeballHighlight",

		HealthBarOffsetY = -400,

		--DeathAnimation = "Enemy_DespairElemental_Death",
		DeathFx = "EnemyDeathFxIris",

		PreferredSpawnPoint = "EnemyPointMelee",
		Material = "Organic",

		CreateProjectileOnActivationFinished = "EyeballRadial",

		AIAggroRange = 2500,
		AIChainAggroRange = 0,
		ChainAggroAllEnemies = false,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions = { "AttackerAI" },

		DumbFireWeapons =
		{
			"EyeballRam",
			--"EyeballSplash",
		},

		OnDeathFireWeapons = { "EyeballExplode" },

		WeaponOptions = { "EyeballChase" },
	}
}

OverwriteTableKeys( EnemyData, UnitSetData.Eyeball )


WeaponSetData =
{
	EyeballChase =
	{
		AIData =
		{
			DeepInheritance = true,
			WaitForAngleTowardTarget = false,
			NoProjectile = true,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "RamRotationDamp",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Duration = 9999,
						RotationMultiplier = 0.50,
					}
				},

				{
					EffectName = "SpeedIncrease",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "Speed",
						Duration = 9999,
						Modifier = 1.2,
					}
				},
			},

			ClearWeaponFireEffectsOnFireEnd = true,

			PreAttackStop = true,
			PreAttackDuration = 0.8,
			FireDuration = 9999.0,
			PostAttackDuration = 1.0,
			PostAttackCooldownMin = 0.0,
			PostAttackCooldownMax = 0.1,
			StopMoveWithinRange = false,
			FireMoveTowardTarget = true,

			AttackDistance = 9999,
			MoveSuccessDistance = 25,
			TrackAtPathEnd = true,

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/DespairElementalRegular/EmoteAttacking" },
			},
		},
	},

	EyeballRam =
	{
		AIData =
		{
			ProjectileName = "EyeballRam",

			SkipCanAttack = true,
			CancelOnPolymorph = true,
			RestartOnHitStunClear = true,
			ExpireProjectilesOnPolymorph = true,
			ExpireProjectilesOnHitStun = true,

			DumbFireInterval = 10.0,
		},
	},

	EyeballSplash =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonHeadBoltChaotic",
			NumProjectiles = 2,
			Spread = 180,
			BarrelLength = 100,

			SkipCanAttack = true,
			CancelOnPolymorph = true,
			RestartOnHitStunClear = true,
			ExpireProjectilesOnPolymorph = true,
			ExpireProjectilesOnHitStun = true,

			DumbFireIntervalMin = 0.75,
			DumbFireIntervalMax = 1.4,
		},
	},

	EyeballExplode =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EyeballRadialDeath",

			FireProjectileAtSelf = true,
			FireFromTarget = true,
			PreAttackStop = true,

			PreAttackEndShake = true,
			PreAttackSound = "/SFX/BombFusePreExplode",

			PreAttackDuration = 1.3,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = true,
			AttackDistance = 150,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil