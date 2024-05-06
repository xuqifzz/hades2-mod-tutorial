WeaponSetData =
{
	FogEmitterSweep =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FogEmitterSweep",

			AttackDistance = 725,
			AttackDistanceScaleY = 0.85,
			MoveWithinRange = false,

			PreAttackDuration = 1.23,
			FireDuration = 0.6,
			PostAttackDuration = 1.5,

			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/FogEmitter/EmotePowerCharging",
			PreAttackAnimation = "Enemy_FogEmitter_SweepPreAttack",
			FireAnimation = "Enemy_FogEmitter_SweepFire",
			PostAttackAnimation = "Enemy_FogEmitter_SweepReturnToIdle",

			MaxConsecutiveUses = 2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FogEmitter/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/FogEmitter/FogEmitterSwipe" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	FogEmitterSlam =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FogEmitterSlam",
			SpawnFromMarker = "FogEmitter_Rig:jaw_00_M_JNT",
			FireProjectileNoDestination = true,

			AttackDistance = 725,
			AttackDistanceScaleY = 0.85,
			WaitForAngleTowardTarget = true,
			MoveWithinRange = false,

			PreAttackDuration = 1.60,
			PreAttackAnimationSpeed = 0.5,
			FireWaitForAnimation = true,
			--FireDuration = 0.1,
			PostAttackDuration = 0.75,

			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/FogEmitter/EmoteCharging",
			PreAttackAnimation = "Enemy_FogEmitter_SlamPreAttack",
			FireAnimation = "Enemy_FogEmitter_SlamFire",
			PostAttackAnimation = "Enemy_FogEmitter_SlamReturnToIdle",
			--FireFx = "EnemyHeavySlash",
			FireFxOffset = 300,

			MaxConsecutiveUses = 2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FogEmitter/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/FogEmitter/FogEmitterSlam" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	FogEmitter2Sweep =
	{
		InheritFrom = { "FogEmitterSweep", },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FogEmitterSweepSmall",

			PreAttackAnimationSpeed = 2,
			PreAttackDuration = 0.8,
			PostAttackDuration = 0.8,

			ChargeSelfVelocity = 1000,
			MoveWithinRange = true,

			AttackDistance = 320,

			MaxConsecutiveUses = nil,
		},
	},

	FogEmitter2Slam =
	{
		InheritFrom = { "FogEmitterSlam", },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FogEmitterSlamSmall",
			MoveWithinRange = true,

			AttackDistance = 230,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil