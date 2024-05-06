WeaponSetData =
{
	CorruptedShadeSCast =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CorruptedShadeSCast",
			BarrelLength = 75,
			FireProjectileStartDelay = 0.1,

			PreAttackDuration = 0.7,
			FireDuration = 0.3,
			PostAttackDuration = 1.1,
			
			PreAttackSound = "/SFX/Enemy Sounds/CorruptedShadeSmall/EmoteCharging",
			PreAttackAnimation = "Enemy_CorruptedShadeS_CastPreFire",
			FireAnimation = "Enemy_CorruptedShadeS_CastFire",
			PostAttackAnimation = "Enemy_CorruptedShadeS_CastPostFire",

			AttackDistance = 680,
			RequireProjectileLoS = true,
			LoSBuffer = 100,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeSmall/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeSmall/Attack" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	CorruptedShadeSCast_Elite =
	{
		InheritFrom = { "CorruptedShadeSCast" },

		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileAngleInterval = 20,

			PostAttackDuration = 0.6,
		}
	},

	CorruptedShadeMRam =
	{
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "CorruptedShadeMRam",
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "RamSpeed",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "SPEED",
						Modifier = 4.0,
						Duration = 2.20,
					}
				},
			},

			ClearWeaponFireEffectsOnFireEnd = true,
			ExpireProjectilesOnHitStun = true,

			PreAttackFx = "CorruptedShadeMChargeFx",
			PreAttackDuration = 1.42,
			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,
			WaitUntilProjectileDeath = "CorruptedShadeMRam",
			--FireDuration = 2.2,
			PostAttackDuration = 0.7,
			PreAttackStop = true,
			StopMoveWithinRange = true,
			FireMoveTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.20,
			FireRotationDampening = 0.8,
			PostAttackStop = true,

			WeaponFireLoopingSound = "/SFX/Enemy Sounds/CorruptedShadeMedium/AttackLoop",

			AttackDistance = 550,
			MoveSuccessDistance = 25,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedShadeMedium/EmoteCharging",
			PreAttackAnimation = "Enemy_CorruptedShadeM_RamPreFire",
			FireAnimation = "Enemy_CorruptedShadeM_RamFire",
			PostAttackAnimation = "Enemy_CorruptedShadeM_RamPostFire",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeMedium/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeMedium/Attack" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	CorruptedShadeLCast =
	{
		Requirements =
		{
			MinPlayerDistance = 400,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CorruptedShadeLCast",
			BarrelLength = 145,
			FireProjectileStartDelay = 0.035,

			PreAttackDuration = 1.33,
			FireDuration = 0.3,
			PostAttackDuration = 0.3,
			TrackTargetDuringCharge = true,
			PreAttackEndShake = true,
			
			PreAttackAnimation = "Enemy_CorruptedShadeL_CastPreFire",
			FireAnimation = "Enemy_CorruptedShadeL_CastFire",
			PostAttackAnimation = "Enemy_CorruptedShadeL_CastPostFire",

			AttackDistance = 1330,
			RequireProjectileLoS = true,
			LoSBuffer = 100,
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
	CorruptedShadeLCast_Elite =
	{
		InheritFrom = { "CorruptedShadeLCast" },

		AIData =
		{
			DeepInheritance = true,
			NumProjectiles = 3,
			ProjectileInterval = 0.1,
			ProjectileAngleInterval = 30,
		},
	},

	CorruptedShadeLVacuum =
	{
		Requirements =
		{
			MinPlayerDistance = 300,
		},
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "CorruptedShadeLVacuumWeak", PauseDuration = 0.69  },
				{ ProjectileName = "CorruptedShadeLVacuum", },
			},

			ExpireProjectilesOnHitStun = true,
			ExpireProjectilesOnFreeze = true,

			--ProjectileName = "CorruptedShadeLVacuum",
			FireProjectileStartDelay = 0.035,

			PreAttackDuration = 0.69,
			FireDuration = 0.80,
			PostAttackDuration = 0.0,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.20,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.03,
			PostAttackStop = true,

			PreAttackFx = "CorruptedShadeLChargeQuick",
			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedShadeLarge/EmoteCharging",			
			PreAttackAnimation = "Enemy_CorruptedShadeL_VacuumPreFire",
			FireAnimation = "Enemy_CorruptedShadeL_VacuumFire",
			--PostAttackAnimation = "Enemy_CorruptedShadeL_CastPostFire",

			AttackDistance = 1330,
			RequireProjectileLoS = true,
			LoSBuffer = 100,

			ChainedWeapon = "CorruptedShadeLNovaChained",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeLarge/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	CorruptedShadeLVacuum_Elite =
	{
		InheritFrom = { "CorruptedShadeLVacuum" },

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "CorruptedShadeLNovaChained_Elite"
		},
	},

	CorruptedShadeLNova =
	{
		Requirements =
		{
			MaxPlayerDistance = 500,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CorruptedShadeLNova",
			FireProjectileAtSelf = true,

			PreAttackDuration = 1.0,
			FireDuration = 0.72,
			PostAttackDuration = 1.1,
			PreAttackEndShake = true,

			AttackDistance = 225,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedShadeLarge/EmoteCharging",
			PreAttackFx = "CorruptedShadeLCharge",
			PreAttackAnimation = "Enemy_CorruptedShadeL_NovaPreFire",
			FireAnimation = "Enemy_CorruptedShadeL_NovaFire",
			PostAttackAnimation = "Enemy_CorruptedShadeL_NovaPostFire",

			DoNotRepeatOnAttackFail = true,
			MoveWithinRangeTimeout = 4.0,
			SkipAttackAfterMoveTimeout = true,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeLarge/Attack" },
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeLarge/EmoteAttacking" },
			},
		}
	},
	CorruptedShadeLNova_Elite =
	{
		InheritFrom = { "CorruptedShadeLNova" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "CorruptedShadeLNova_Elite",
		},
	},

	CorruptedShadeLNovaChained =
	{
		InheritFrom = { "CorruptedShadeLNova" },

		AIData =
		{
			DeepInheritance = true,
			AttackDistance = 9999,
		},
	},
	CorruptedShadeLNovaChained_Elite =
	{
		InheritFrom = { "CorruptedShadeLNova_Elite" },

		AIData =
		{
			DeepInheritance = true,
			AttackDistance = 9999,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil