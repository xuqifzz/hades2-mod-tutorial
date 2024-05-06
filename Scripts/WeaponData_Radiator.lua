WeaponSetData =
{
	RadiatorMelee360 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "RadiatorMelee360",
			ImmuneToProjectileSlow = true,

			PreAttackDuration = 1.5,
			PreAttackAnimationSpeed = 1.0,
			FireDuration = 1.6,
			PostAttackDuration = 1.35,
			PreAttackStop = true,
			StopMoveWithinRange = true,
			PostAttackStop = true,
			PreAttackEndShake = true,

			MoveSuccessDistance = 50,
			MoveWithinRangeTimeout = 4.0,
			AttackDistance = 150,

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 500,
			TargetSpawnPointsNearSelf = true,

			MoveToRandomSpawnPoint = true,
			MoveToSpawnPointDistanceMin = 200,
			MoveToSpawnPointDistanceMax = 450,
			MoveToSpawnPointType = "EnemyPoint",

			PreAttackAnimation = "Enemy_Radiator_360PreAttack",
			FireAnimation = "Enemy_Radiator_360Fire",
			PostAttackAnimation = "Enemy_Radiator_360ReturnToIdle",

			FireFx = "EnemyAttackSparkle",
			FireFxOffset = 50,

			PreAttackFx = "EnemyChargeFxIn_Radiator",
			EndPreAttackFx = true,

			DeathFx = "RadiatorBeamEnd",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Radiator/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	RadiatorMelee360_Elite =
	{
		InheritFrom = { "RadiatorMelee360" },
		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.5,
		},
	},

	RadiatorMelee360_AutoFire =
	{
		InheritFrom = { "RadiatorMelee360" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "RadiatorMelee360Slow",
			ImmuneToProjectileSlow = true,

			MoveToRandomSpawnPoint = true,
			MoveToSpawnPointDistanceMin = 200,
			MoveToSpawnPointDistanceMax = 600,
			MoveToSpawnPointType = "EnemyPoint",

			PreAttackDuration = 1.5,
			FireDuration = 0.0,
			PostAttackDuration = 0.5,

			FireTicksMin = 1,
			FireTicksMax = 1,
			FireInterval = 6,

			FireAnimation = "Enemy_Radiator_360Fire_Slow",
			PostAttackAnimation = "Enemy_Radiator_Idle",
		},
	},

	RadiatorExplode =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "RadiatorMelee360",
			ImmuneToProjectileSlow = true,

			PreAttackDuration = 0.4,
			FireDuration = 1.6,
			PostAttackDuration = 0.5,
			--PreAttackEndShake = true,
			PreAttackStop = false,
			StopMoveWithinRange = false,

			AttackDistance = 600,

			FireSelfUpwardVelocity = 1300,
			FireSelfVelocity = 600,

			PreAttackAnimation = "Enemy_Radiator_360PreAttack",
			FireAnimation = "Enemy_Radiator_360Fire",
			PostAttackAnimation = "Enemy_Radiator_360ReturnToIdle",

			FireFx = "EnemyAttackSparkle",
			FireFxOffset = 50,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Radiator/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/HeavyRangedSplitterMiniboss/CrystalBeamFireStartBIG" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.00, LerpTime = 0.04 },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil