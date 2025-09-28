WeaponSetData =
{
	MudmanStraightThrow =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MudmanEyeThrow",
			BarrelLength = 280,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,
			StopBeforeFire = true,
			FireProjectileStartDelay = 0.135,

			PreAttackDurationMin = 1.5,
			PreAttackDurationMax = 1.5,
			FireDuration = 0.45,
			PostAttackDuration = 1.0,
			
			PreAttackSound = "/SFX/Enemy Sounds/Mudman/EmoteCharging",
			PreAttackAnimation = "Enemy_Mudman_ThrowPreFire",
			FireAnimation = "Enemy_Mudman_ThrowFire",
			PostAttackAnimation = "Enemy_Mudman_ThrowReturnToIdle",

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,

			AttackDistance = 700,
			RequireProjectileLoS = true,
			LoSBuffer = 100,

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 900,
			RetreatTimeout = 3.0,

			DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Mudman/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Mudman/MudmanRangedAttackFire" },
			},
		},
	},

	MudmanStraightThrow_Elite =
	{
		InheritFrom = { "MudmanStraightThrow" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "MudmanEyeThrow_Elite",
		},
	},

	MudmanStraightThrow_Shadow =
	{
		InheritFrom = { "MudmanStraightThrow" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "MudmanEyeThrow_Elite",
		},
	},

	Mudman2Throw =
	{
		InheritFrom = { "MudmanStraightThrow" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "Mudman2EyeThrow",

			FireTicks = 1,
			NumProjectiles = 3,
			ProjectileAngleInterval = 45,

			PreAttackDuration = 3.0,
			--FireDuration = 3.0,
		},
	},

	Mudman2Throw_NoSpawn =
	{
		InheritFrom = { "Mudman2Throw" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "Mudman2EyeThrow_NoSpawn",

			AttackDistance = 900,
		}
	},

	MudmanShove =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MudmanShove",
			BarrelLength = 50,
			FireProjectileStartDelay = 0.05,

			FireSelfVelocity = 1400,
			FireSelfVelocityAngleOffset = 180,

			PreAttackDuration = 1.0,
			FireDuration = 0.4,
			PostAttackDuration = 0.7,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.4,
			
			PreAttackSound = "/SFX/Enemy Sounds/Mudman/EmoteCharging",
			PreAttackAnimation = "Enemy_Mudman_ShovePreFire",
			FireAnimation = "Enemy_Mudman_ShoveFire",
			PostAttackAnimation = "Enemy_Mudman_ShoveReturnToIdle",

			AttackDistance = 280,
			RequireProjectileLoS = true,
			LoSBuffer = 50,

			ForceUseIfReady = true,
		},

		Requirements =
		{
			MaxConsecutiveUses = 1,
			MaxPlayerDistance = 280,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Mudman/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Mudman/MudmanMeleeAttackFire" },
			},
		},
	},

	MudmanShove_Elite =
	{
		InheritFrom = { "MudmanShove" },
		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "MudmanShove_Elite2",
			PostAttackDuration = 0.1,

			FireSelfVelocity = 200,
			FireSelfVelocityAngleOffset = 180,
		},
	},

	Mudman2Shove =
	{
		InheritFrom = { "MudmanShove" },
		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.1,
			ProjectileName = "Mudman2Shove",

			FireSelfVelocity = 200,
			FireSelfVelocityAngleOffset = 180,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,
		},
	},

	MudmanShove_Elite2 =
	{
		InheritFrom = { "MudmanShove" },
		AIData =
		{
			DeepInheritance = true,
			
			PreAttackDuration = 0.5,
			PreAttackAnimationSpeed = 2.0,

			AttackDistance = 9999,
			RequireProjectileLoS = false,

			DoNotRepeatOnAttackFail = true,
			-- Blink ban
			PreMoveTeleport = false,
		},
	},

	MudmanEyeExplode =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MudmanEyeExplode",

			FireProjectileAtSelf = true,
			FireFromTarget = true,
			PreAttackStop = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,
			PreAttackSound = "/SFX/Enemy Sounds/MudmanEye/EmoteActivated",

			PreAttackDuration = 0.6,
			PreAttackFx = "MudmanEyeChargeFx",
			
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = true,
			AttackDistance = 170,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Explosion1" },
				{ Name = "/SFX/Enemy Sounds/MudmanEye/MudmanEyeExplode" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil