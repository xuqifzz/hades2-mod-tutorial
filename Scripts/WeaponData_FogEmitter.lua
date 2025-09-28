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
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil