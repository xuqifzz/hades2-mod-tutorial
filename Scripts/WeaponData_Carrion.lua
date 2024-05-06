WeaponSetData =
{
	CarrionSweep =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CarrionSweep",
			ExpireProjectilesOnHitStun = true,

  			FireSelfVelocity = 2700.0,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGripLong,
			},

			PreAttackDuration = 0.74,
			FireDuration = 0.3,
			PostAttackDuration = 0.0,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.3,

			PreAttackAnimation = "Enemy_Carrion_SweepPreAttack",
			FireAnimation = "Enemy_Carrion_SweepFire",
			FireProjectileStartDelay = 0.03,

			PostAttackAI = "OrbitAI",

			AttackDistance = 600,
			AttackDistanceMin = 450,
			RetreatBufferDistance = 500,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			PreAttackStop = true,
			StopMoveWithinRange = false,
			AngleTowardsTargetWhileFiring = true,

			PreAttackSound = "/SFX/Enemy Sounds/Carrion/EmoteCharging",
			--PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0.1 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Carrion/EmoteAttacking" },
			},
		},
	},
	CarrionSweep_Elite =
	{
		InheritFrom = { "CarrionSweep" },

		AIData =
		{
			DeepInheritance = true,

			PostAttackAI = "nil",
			ChainedWeapon = "CarrionSweep2_Elite",
		},
	},
	CarrionSweep2_Elite =
	{
		InheritFrom = { "CarrionSweep" },

		AIData =
		{
			DeepInheritance = true,

			PostAttackAI = "nil",
			ChainedWeapon = "CarrionSweep3_Elite",
		},
	},
	CarrionSweep3_Elite =
	{
		InheritFrom = { "CarrionSweep" },

		AIData =
		{
			DeepInheritance = true,

			PostAttackAI = "OrbitAI",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil