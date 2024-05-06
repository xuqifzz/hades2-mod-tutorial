WeaponSetData =
{
	BrokenHeartedSpit =
	{
		Requirements =
		{
			MinPlayerDistance = 350,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BrokenHeartedSpit",
			--NumProjectiles = 1,
			--ProjectileInterval = 0,
			BarrelLength = 40,
			Spread = 0,
			FireProjectileStartDelay = 0.025,

			AttackSlots =
			{
				{ ProjectileName = "BrokenHeartedSpit", AIDataOverrides = { BarrelLength = 0 }  },
				{ ProjectileName = "BrokenHeartedSpit2", AIDataOverrides = { BarrelLength = 0 } },
				{ ProjectileName = "BrokenHeartedSpit3", AIDataOverrides = { BarrelLength = 0 }  },
			},
			FireTicks = 1,
			AttackSlotInterval = 0.15,
						
			--PreAttackEndStop = true,

			PreAttackAnimationSpeed = 1.8,
			PreAttackDuration = 0.4,
			FireDuration = 0.45,
			PostAttackDurationMin = 0.45,
			PostAttackDurationMax = 0.45,

			PreAttackEndShake = true,

			MoveWithinRange = true,

			AttackDistance = 830,

			PreAttackSound = "/SFX/Enemy Sounds/BrokenHearted/EmoteCharging",
			PreAttackAnimation = "Enemy_BrokenHearted_SpitPreFire",
			FireAnimation = "Enemy_BrokenHearted_SpitFire",
			PostAttackAnimation = "Enemy_BrokenHearted_SpitPostFire",

		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/BrokenHearted/EmoteAttacking" },
			},
		}
	},

	BrokenHeartedSpit_Elite =
	{
		InheritFrom = { "BrokenHeartedSpit" },
		Requirements =
		{
			MinPlayerDistance = 350,
			MaxPlayerDistance = 1000,
		},
		AIData =
		{
			DeepInheritance = true,
		}
	},

	BrokenHeartedSlam =
	{
		AIData =
		{
			DeepInheritance = true,

			Requirements =
			{
				MaxPlayerDistance = 475,
			},

			ProjectileName = "BrokenHeartedSlam",
			FireProjectileStartDelay = 0.035,
			FireSelfVelocity = 900,
			FireSelfVelocityAngleOffset = 180,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},
			FireProjectileAtSelf = true,

		--	PreAttackFunctionName = "WeaponSetImmuneToStun",
			PreAttackDuration = 0.97,
			FireDuration = 0.72,
			PostAttackDuration = 1.75,
			PreAttackEndShake = true,

			AttackDistance = 320,
			LoSBuffer = 55,
			RequireUnitLoS = true,

			PreAttackSound = "/SFX/Enemy Sounds/BrokenHearted/EmoteCharging",
			PreAttackAnimation = "Enemy_BrokenHearted_SlamPreFire",
			FireAnimation = "Enemy_BrokenHearted_SlamFire",
			PostAttackAnimation = "Enemy_BrokenHearted_SlamPostFire",
		},

		HitSimSlowCooldown = 0.2,
		HitScreenshake = { Distance = 5, Speed = 900, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.08, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.07 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/BrokenHearted/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonRadialBlast" },
			},
		}
	},

	BrokenHeartedSlam_Elite =
	{
		InheritFrom = { "BrokenHeartedSlam" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "BrokenHeartedSlam_Elite",

			NumProjectiles = 2,
			ProjectileInterval = 0.12,
			FireTickSelfVelocity = -900,
			PostAttackDuration = 1.5,

			DoNotRepeatOnAttackFail = true,
			MoveWithinRangeTimeout = 4,
			SkipAttackAfterMoveTimeout = true,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil