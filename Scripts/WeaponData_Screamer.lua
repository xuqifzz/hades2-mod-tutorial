WeaponSetData =
{
	ScreamerCone =
	{
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "ScreamerCone",

			ApplyEffectsOnPreAttackStart =
			{
				{
					EffectName = "ScreamerChargeSlow",
					ClearEffectOnHit = true,					
					DataProperties = 
					{
						Type = "SPEED",
						Duration = 1.0,
						Modifier = 0.8,
					}
				},
			},
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "ScreamerGrip",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 3.8,
						Modifier = 1.3,
						HaltOnEnd = true,
					}
				},
				{
					EffectName = "ScreamerFireSlow",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "SPEED",
						Duration = 3.8,
						Modifier = 1.05,
					}
				},
			},

			PreAttackRotationDampening = 0.8,
			FireRotationDampening = 0.25,

			ClearWeaponFireEffectsOnFireEnd = true,
			ExpireProjectilesOnHitStun = true,

			PreAttackDuration = 1.2,
			PreAttackAnimationSpeed = 0.9,
			FireDuration = 3.8,
			PostAttackDuration = 0.6,
			PreAttackEndShake = true,
			PreAttackStop = false,
			StopMoveWithinRange = false,
			PostAttackStop = true,

			AttackDistance = 380,
			AttackDistanceScaleY = 0.9,
			MoveSuccessDistance = 200,
			TrackAtPathEnd = true,

			--PreAttackFx = "ScreamerPreAttackChargeFx",
			--EndPreAttackFx = true,
			PreAttackAnimation = "Enemy_Screamer_PreFire",
			FireAnimation = "Enemy_Screamer_Fire",
			PostAttackAnimation = "Enemy_Screamer_EndFire",
			PreAttackFx = "EnemyChargeFxIn_Screamer",
			EndPreAttackFx = true,

			--DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Screamer/EmoteAttacking" },
			},
		},
	},

	ScreamerVacuum =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ScreamerVacuum",
			FireProjectileStartDelay = 0.035,
			FireProjectileAtSelf = true,

			PreAttackDuration = 0.69,
			FireDuration = 1.50,
			PostAttackDuration = 0.0,
			PreAttackAngleTowardTarget = false,
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
			StopBeforeFire = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,
			
			PreAttackAnimation = "Enemy_Screamer_PreFire",
			FireAnimation = "Enemy_Screamer_Fire",
			PostAttackAnimation = "Enemy_Screamer_EndFire",

			AttackDistance = 430,
			AttackDistanceScaleY = 0.8,
			RequireProjectileLoS = true,
			LoSBuffer = 100,

			DoNotRepeatOnAttackFail = true,

			ChainedWeapon = "ScreamerConeFast",
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

	ScreamerConeFast =
	{
		InheritFrom = { "ScreamerCone", },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "ScreamerConeLarge",
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "ScreamerGrip",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 3.8,
						Modifier = 1.3,
						HaltOnEnd = true,
					}
				},
				{
					EffectName = "ScreamerFireSpeed",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "SPEED",
						Duration = 3.80,
						Modifier = 0.85,
					}
				},
			},

			FireRotationDampening = 0.4,
			RequireProjectileLoS = false,
			DoNotRepeatOnAttackFail = true,
			AttackDistance = 9999,

			PostAttackDuration = 2.8,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil