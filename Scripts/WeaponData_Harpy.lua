WeaponSetData =
{
	HarpySlice =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.07,
			AttackSlots =
			{
				{ ProjectileName = "HarpySlice", PauseDuration = 0.1 },
				{ ProjectileName = "HarpySlice" },
			},

      		ChargeSelfVelocity = 3000.0,

      		PreAttackEndShake = true,
			PreAttackDuration = 1.0,
			FireDuration = 0.6,
			PostAttackDuration = 0.85, -- animation is 0.73

			WaitForAngleTowardTarget = true,
			StopBeforeFire = true,

			AttackDistance = 450,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

      		PreAttackSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			PreAttackAnimation = "Enemy_HarpyCutter_SlicePreFire",
			FireAnimation = "Enemy_HarpyCutter_SliceFire",
			PostAttackAnimation = "Enemy_HarpyCutter_SlicePostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh" },
			},
		},
	},

	HarpyFlap =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HarpyFlap",
			FireProjectileStartDelay = 0.1,
			BarrelLength = 150,
			EndScale = 3,
			ScaleDuration = 3,
      		FireSelfVelocity = 1100.0,
      		FireSelfVelocityAngleOffset = 180,

			PreAttackDuration = 0.8,
			FireDuration = 0.3,
			PostAttackDuration = 1.2, -- animation is 1.05

			AttackDistance = 900,
			RequireProjectileLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			PreAttackSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			PreAttackAnimation = "Enemy_HarpyCutter_FlapPreFire_Alt",
			FireAnimation = "Enemy_HarpyCutter_FlapFire_Alt",
			PostAttackAnimation = "Enemy_HarpyCutter_FlapPostFire_Alt",
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HarpyCutter/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusSwordLunge" },
			},
		},

		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

	},

	HarpyFlap_Elite =
	{
		InheritFrom = { "HarpyFlap" },
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 3,
			FireInterval = 0.5,
			Spread = 45,
		},
	},

	HarpyDashRight =
	{
		GenusName = "HarpyDash",
		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 2200,
			FireSelfVelocityAngleOffset = -60,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.05,
			FireDuration = 0.45,
			PostAttackDuration = 0.2, -- total anim is 0.6

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_HarpyCutter_DashRight",
		},

		Requirements =
		{
			MaxConsecutiveUses = 3,
		},
	},

	HarpyDashLeft =
	{
		InheritFrom = { "HarpyDashRight", },
		AIData =
		{
			FireSelfVelocityAngleOffset = 60,
			PreAttackAnimation = "Enemy_HarpyCutter_DashLeft",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil