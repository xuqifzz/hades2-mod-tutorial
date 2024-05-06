WeaponSetData =
{
	MournerRampage =
	{	
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MournerRampage",

			ChargeSelfVelocity = -2000,
			FireTickSelfVelocity = 710,
			
			BarrelLength = -30,
			NumProjectiles = 20,
			ProjectileInterval = 0.11,
			Spread = 15,
			FireProjectileStartDelay = 0.03,

			PreAttackDuration = 1.0,
			FireDuration = 2.32,
			PostAttackDuration = 3.5,

			PreAttackEndShake = true,
			--PreAttackEndDuration = 0.4,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.01,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.09,

			AttackDistance = 400,
			LoSBuffer = 200,
			RequireUnitLoS = true,

			PreAttackSound = "/SFX/Enemy Sounds/Mourner/EmoteCharging",
			PreAttackAnimation = "Enemy_Mourner_Rampage_Start",
			FireAnimation = "Enemy_Mourner_Rampage_Fire",
			PostAttackAnimation = "Enemy_Mourner_Rampage_End",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/Mourner/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 700, Duration = 0.07, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.2, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	MournerCast =
	{
		Requirements =
		{
			MinPlayerDistance = 500,
		},

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "MournerCast",

			BarrelLength = 110,

			PreAttackDuration = 1.80,
			FireDuration = 0.3,
			PostAttackDuration = 4.0,

			TrackTargetDuringCharge = true,

			PreAttackSound = "/SFX/Enemy Sounds/Mourner/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Mourner_Cast_Start",
			FireAnimation = "Enemy_Mourner_Cast_FireLoop",
			PostAttackAnimation = "Enemy_Mourner_Cast_End",

			AttackDistance = 700,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Brimstone/CrystalBeamFireStart" },
				{ Name = "/SFX/Enemy Sounds/Mourner/EmoteAttackingRanged" },
			},
		},

	},

	MournerScream =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},
		AIData =
		{
			DeepInheritance = true,
			NoProjectile = true,

			PreAttackDuration = 0,
			FireDuration = 0,
			PostAttackDuration = 2.2,

			PostAttackAnimation = "Enemy_Mourner_Scream_Fire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HeavyRangedSplitterMiniboss/CrystalBeamFireStartBIG" },
				{ Name = "/SFX/Enemy Sounds/Mourner/EmoteAttackingRanged" },
			},
		},
	},

	MournerRampage_Elite =
	{
		InheritFrom = {"MournerRampage"},
		AIData =
		{
			DeepInheritance = true,

			FireTickSelfVelocity = 830,

			PostAttackDurationMin = 3.1,
			PostAttackDurationMax = 4.0,
			PreAttackEndStop = false,
		},
	},

	MournerCast_Elite =
	{
		InheritFrom = {"MournerCast"},
		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 2.0,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil