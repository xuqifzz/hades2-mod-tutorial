WeaponSetData =
{
	TreantMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TreantMelee",

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.45,
			FireWaitForAnimation = true,
			PostAttackDuration = 2.5,

			PreAttackEndShake = true,

			AttackDistance = 400,

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Treant_MeleePreAttack",
			FireAnimation = "Enemy_Treant_MeleeFire",
			PostAttackAnimation = "Enemy_Treant_MeleeReturnToIdle",

			ExpireProjectilesOnHitStun = true,
		},

		Requirements =
		{
			MaxPlayerDistance = 330,
			MinAttacksBetweenUse = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Guard/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	TreantRangedRoots =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TreantRangedRoots",
			FireProjectileAtTarget = true,
			CreateOwnTargetFromOriginalTarget = true,
			PreAttackStop = true,

			PreAttackFxAtTarget = "TreantRootsPreviewFx",
			EndPreAttackFx = true,
			PreAttackDuration = 1.0,
			FireWaitForAnimation = true,
			PostAttackDuration = 1.33,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Treant_RootsPreAttack",
			FireAnimation = "Enemy_Treant_RootsFire",
			PostAttackAnimation = "Enemy_Treant_RootsReturnToIdle",
		},
	},

	TreantRangedSpray =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.12,

			ProjectileName = "TreantRanged",
			BarrelLength = 125,
			Spread = 15,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.8,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.14,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.14,

			NumProjectiles = 60,
			ProjectileInterval = 0.0485,

			PreAttackDuration = 1.0,
			FireDuration = 3.5,
			PostAttackDurationMin = 2.85,
			PostAttackDurationMax = 3.65,

			--PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Treant/EmotePowerCharging",
			PreAttackAnimation = "Enemy_Treant_SprayPreAttack",
			FireAnimation = "Enemy_Treant_SprayFire",
			PostAttackAnimation = "Enemy_Treant_SprayReturnToIdle",

			AttackSound = "/SFX/Enemy Sounds/Treant/EmotePowerAttacking",

			AttackDistance = 900,
			RequireProjectileLoS = true,
			LoSBuffer = 100,

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "TreantSprayReactionVO",
				PreLineWait = 0.85,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "EnemyKills", "Treant" },
					},
				},
				
				{ Cue = "/VO/MelinoeField_2249", Text = "Got to move...!" },
			},			
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	Treant2RangedSpray =
	{
		InheritFrom = { "TreantRangedSpray", },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "Treant2Ranged",

			FireRotationDampening = 0.26,
		},
	},


	TreantTailSpawn =
	{
		AIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.5,
			AttackDistance = 9999,

			MoveWithinRange = false,
			NoProjectile = true,

			SpawnBurstOnFire = true,
			SpawnOnSpawnPoints = true,
			SpawnsPerBurst = 1,
			SpawnRadiusMin = 150,
			SpawnRadius = 600,
			SpawnRate = 0.35,
			MaxActiveSpawns = 1,
			
			SpawnerOptions =
			{
				"TreantTail",
			},

			MaxUses = 1,
			ForceFirst = true,
			ForceUseIfReady = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteCharging" },
			},
		},
	},

	Treant2TailSpawn =
	{
		InheritFrom = { "TreantTailSpawn", },

		AIData =
		{
			DeepInheritance = true,
			
			SpawnsPerBurst = 1,
			MaxActiveSpawns = 1,
			SpawnerOptions = { "TreantTail2", },

		},
	},

	Treant2RangedRoots =
	{
		InheritFrom = { "TreantRangedRoots", },

		Requirements =
		{
			MinAttacksBetweenUse = 0,
		},

		AIData =
		{
			DeepInheritance = true,
			AttackDistance = 1000,
			MoveWithinRange = true,
			PostAttackDuration = 0.7,
		},
	},

	TreantTailSwipe =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TreantTailSwipe",
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			FireTicks = 2,
			FireInterval = 0.15,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,

			--PreAttackAnimation = "Enemy_TreantTail_Hidden",
			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.6,
			FireDuration = 1.0,
			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_TreantTail_Swipe_PreAttack",
			FireAnimation = "Enemy_TreantTail_Swipe_Fire",
			PostAttackAnimation = "Enemy_TreantTail_Idle",
			PostAttackDurationMin = 2.5,
			PostAttackDurationMax = 3.5,

			AttackDistance = 9999,

			ForceUseIfReady = true,
		},

		Requirements =
		{
			MaxPlayerDistance = 260,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.00, LerpTime = 0.06 },
		},
	},

	TreantTail2Swipe =
	{
		InheritFrom = { "TreantTailSwipe", },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "TreantTail2Swipe",
		},
	},

	TreantTailUnburrow =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TreantTailUnburrow",
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			FireProjectileStartDelay = 0.8,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,

			PreAttackAnimation = "Enemy_TreantTail_Hidden",
			PreAttackDuration = 0.0,
			PreAttackFx = "EnemyBurrowDirt",
			FireAnimation = "Enemy_TreantTail_Unburrow",
			FireWaitForAnimation = true,
			PostAttackAnimation = "Enemy_TreantTail_Idle",
			PostAttackDurationMin = 0.55,
			PostAttackDurationMax = 0.65,

			AttackDistance = 145,
			MoveSuccessDistance = 50,

			DoNotRepeatOnAttackFail = true,
			PreAttackCreateHealthBar = true,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	TreantTail2Unburrow =
	{
		InheritFrom = { "TreantTailUnburrow", },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "TreantTail2Unburrow",
		},
	},

	TreantTailBurrow =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 0.0,
			PreAttackFx = "EnemyBurrowDirt",
			FireAnimation = "Enemy_TreantTail_Burrow",
			FireWaitForAnimation = true,
			PostAttackAnimation = "Enemy_TreantTail_Hidden",
			PostAttackDuration = 0.0,

			AttackDistance = 9999,

			ChainedWeapon = "TreantTailUnburrow",

			PostAttackRemoveEnemyUI = true,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	TreantTail2Burrow =
	{
		InheritFrom = { "TreantTailBurrow", },
		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "TreantTail2Unburrow",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil