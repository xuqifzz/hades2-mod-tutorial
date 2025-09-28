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

			PreAttackDuration = 0.65,
			FireDuration = 0.6,
			PostAttackDuration = 0.85, -- animation is 0.73

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackStop = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.25,
			StopBeforeFire = true,

			AttackDistance = 750,
			AttackDistanceScaleY = 0.65,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			SkipSurroundAICount = true,

      		PreAttackSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			PreAttackAnimation = "Enemy_HarpyCutter_SlicePreFire",
			FireAnimation = "Enemy_HarpyCutter_SliceFire",
			PostAttackAnimation = "Enemy_HarpyCutter_SlicePostFire",
		},
	},

	HarpySlice2 =
	{
		InheritFrom = { "HarpySlice" },

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "HarpySlice2", PauseDuration = 0.1 },
				{ ProjectileName = "HarpySlice2" },
			},

      		PreAttackSound = "/SFX/Enemy Sounds/HarpyDropper/EmoteCharging",
		},

	},

	HarpyWind =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.07,
			ProjectileName = "HarpyCone",
			BarrelLength = 0,
			EndScale = 5.0,
			ScaleDuration = 2.7,

			ExpireProjectilesOnHitStun = true,
			ExpireProjectilesOnFreeze = true,

      		PreAttackEndShake = true,
			PreAttackDuration = 1.0,
			FireDuration = 2.7,
			PostAttackDuration = 1.5, -- animation is 1.48

			WaitForAngleTowardTarget = true,
			StopBeforeFire = true,

			AttackDistance = 450,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

      		PreAttackSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			PreAttackAnimation = "Enemy_HarpyCutter_WindPreFire",
			FireAnimation = "Enemy_HarpyCutter_WindFire",
			PostAttackAnimation = "Enemy_HarpyCutter_WindPostFire",

			-- Rifts ban
			DumbFireWeapons = {},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh" },
			},
		},
	},

	HarpyWind_Elite =
	{
		InheritFrom = { "HarpyWind" },

		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileAngleInterval = 50,
		},
	},

	HarpyFlapFast =
	{
		Requirements =
		{
			MinPlayerDistance = 700,
			MaxAttackers = 3,
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InAmbientBattle" },
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "HarpyFlapFast",
			FireProjectileStartDelay = 0.1,
			BarrelLength = 150,
			EndScale = 2.5,
			ScaleDuration = 1,
			FireSelfVelocity = 1100.0,
			FireSelfVelocityAngleOffset = 180,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.07,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.04,
			PostAttackStop = true,

			PreAttackDuration = 0.8,
			FireDuration = 0.3,
			PostAttackDuration = 1.2, -- animation is 1.05

			AttackDistance = 700,
			RequireProjectileLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			PreAttackSound = "/SFX/Enemy Sounds/HarpyDropper/EmoteCharging",
			PreAttackFlashSound = "/Leftovers/SFX/AuraOnLoud",
			PreAttackAnimation = "Enemy_HarpyCutter_FlapPreFire_Alt",
			FireAnimation = "Enemy_HarpyCutter_FlapFire_Alt",
			PostAttackAnimation = "Enemy_HarpyCutter_FlapPostFire_Alt",

			-- Rifts ban
			DumbFireWeapons = {},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HarpyDropper/EmoteAttacking" },
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
			},
		},
	},

	HarpyFlapFast_Elite =
	{
		InheritFrom = { "HarpyFlapFast" },
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 3,
			FireInterval = 0.5,
			Spread = 20,
		},
	},

	HarpyDashRight =
	{
		GenusName = "HarpyDash",
		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 2600,
			FireSelfVelocityAngleOffset = -60,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.05,
			FireDuration = 0.35,
			PostAttackDuration = 0.0, -- total anim is 0.6

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.2,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			SkipSurroundAICount = true,

			PreAttackAnimation = "Enemy_HarpyCutter_DashRight",
		},

		Requirements =
		{
			MaxConsecutiveUses = 3,
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InAmbientBattle" },
			},
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