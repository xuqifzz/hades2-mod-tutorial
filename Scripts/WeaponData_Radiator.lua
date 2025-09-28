WeaponSetData =
{
	RadiatorMelee360 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "RadiatorMelee360",
			ImmuneToProjectileSlow = true,
			
			ExpireProjectilesOnHitStun = true,
			ExpireProjectilesOnFreeze = true,

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
			MoveToSpawnPointDistanceMin = 300,
			MoveToSpawnPointDistanceMax = 610,
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


	RadiatorMelee360_AutoFire_Seek =
	{
		InheritFrom = { "RadiatorMelee360_AutoFire" },
		AIData =
		{
			DeepInheritance = true,
			
			MoveSuccessDistance = 130,
			MoveWithinRangeTimeout = 2.5,
			AttackDistance = 430,

			TargetSpawnPoints = false,
			TargetSpawnPointsNearSelf = false,
			MoveToRandomSpawnPoint = false,

		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil