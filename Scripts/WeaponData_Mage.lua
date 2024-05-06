WeaponSetData =
{
	MageRanged =
	{
		AIData =
		{
			DeepInheritance = true,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			StopBeforeFire = true,

			ProjectileName = "MageRanged",
			BarrelLength = 55,

			PreAttackDuration = 1.0,
			FireDuration = 0.2,
			PostAttackDurationMin = 0.7,
			PostAttackDurationMax = 0.9,

			FireTicks = 3,
			FireInterval = 0.085,
			FireTickSelfVelocity = 400,
			FireTickSelfVelocityAngleOffset = 180,
			FireTickSelfVelocityConsecutiveMultiplier = 0.95,

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Mage_CastPreAttack",
			FireAnimation = "Enemy_Mage_CastFire",
			FireFx = "MageProjectileFireFx",
			PreAttackFx = "EnemyChargeFxIn_Mage",
			EndPreAttackFx = true,

			--PostAttackAnimation = "",

			AttackDistance = 1050,
			AttackDistanceScaleY = 0.48,
			RequireProjectileLoS = true,
			LoSBuffer = 25,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Mage/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	MageRanged_Elite =
	{
		InheritFrom = { "MageRanged" },

		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 1300,
			AttackDistanceScaleY = 0.5,

			FireTicks = 7,
		},
	},

	Mage2Ranged =
	{
		InheritFrom = { "MageRanged" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "Mage2Ranged",

			AttackSlots =
			{
				{ ProjectileName = "Mage2Ranged", AIDataOverrides = { FireProjectileAngleRelative = -35, },  },
				{ ProjectileName = "Mage2Ranged", AIDataOverrides = { FireProjectileAngleRelative = 0, },  },
				{ ProjectileName = "Mage2Ranged", AIDataOverrides = { FireProjectileAngleRelative = 35, },  },
			},

			AttackDistance = 1300,
			AttackDistanceScaleY = 0.5,

			FireTicks = 3,
			FireInterval = 0.35,

			FireAnimation = "Enemy_Mage_CastFire_Slow",
		},
	},

	Mage2Ranged_Elite =
	{
		InheritFrom = { "Mage2Ranged" },

		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 1300,
			AttackDistanceScaleY = 0.5,

			FireTicks = 7,
			FireInterval = 0.225,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil