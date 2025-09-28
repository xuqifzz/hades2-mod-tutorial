WeaponSetData =
{
	DragonBreath =
	{
		Requirements =
		{
			MaxPlayerDistance = 600,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonBreathGround",
			FireProjectileStartDelay = 0.0,

			AttackSlots =
			{
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.0 }, PauseDuration = 0.2 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.3 }, PauseDuration = 0.175 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.6 }, PauseDuration = 0.15 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.9 }, PauseDuration = 0.1 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 2.2 }, PauseDuration = 0.05 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 2.5 }, PauseDuration = 0.025 },
			},

			CreateOwnTarget = true,
			UseAngleBetweenPlayer = true,
			TargetOffsetDistance = 220,

			PreAttackStop = true,

			DoNotRepeatOnAttackFail = true,

			MoveWithinRange = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.5,

			PreAttackDuration = 1.5,
			FireDuration = 0.1,
			PostAttackDuration = 0.7, -- anim is 1.3

			AttackDistance = 800,

			SoundManagerCap = 30,

			PreAttackSound = "/SFX/Enemy Sounds/Dragon/EmoteCharging",
			PreAttackAnimation = "Enemy_Dragon_BreathPreFire",
			FireAnimation = "Enemy_Dragon_BreathFire",
			PostAttackAnimation = "Enemy_Dragon_BreathPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Dragon/DragonFireBurst", },
				{ Name = "/SFX/HellFireImpactQuiet" },
			},

			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Dragon/EmoteAttacking" },
			}
		},

	},

	DragonBreath_MiniBoss =
	{
		InheritFrom = { "DragonBreath", },
		Requirements = { MaxConsecutiveUses = 1 },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonBreathGround_Miniboss",
			PreAttackDuration = 0.65,
			PreAttackAnimationSpeed = 2,
			PostAttackDuration = 0.5,

			TargetOffsetDistance = 330,

			AttackSlots =
			{
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 0.8 }, PauseDuration = 0.2 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.0 }, PauseDuration = 0.175 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.2 }, PauseDuration = 0.15 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.4 }, PauseDuration = 0.1 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.6 }, PauseDuration = 0.1 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.6 }, PauseDuration = 0.1 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.6 }, PauseDuration = 0.1 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 1.8 }, PauseDuration = 0.05 },
				{ AIDataOverrides = { ProjectileBlastRadiusMultiplier = 2.0 }, PauseDuration = 0.025 },
			},
		},

		WeaponFireSounds =
		{
			{ Name = "/SFX/Enemy Sounds/DragonMiniboss/EmoteAttacking" },
		}
	},

	DragonBreath_MiniBoss_Ally =
	{
		InheritFrom = { "DragonBreath_MiniBoss", },

		AIData =
		{
			DeepInheritance = true,
			CreateOwnTarget = false,
		},
	},

	DragonGlide =
	{
		Requirements =
		{
			MinPlayerDistance = 500,
		},

		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "DragonGlideBoost",
					DataProperties = 
					{
						Type = "Speed",
						Duration = 0.8,
						Modifier = 3.5,
					}
				},
			},

			AttackSlots =
			{
				{ AnchorAngleOffset = 0, OffsetAngle = 225, OffsetDistance = 150, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ AnchorAngleOffset = 0, OffsetAngle = 0, OffsetDistance = 0, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ AnchorAngleOffset = 0, OffsetAngle = -225, OffsetDistance = 150, OffsetFromAttacker = true, UseAttackerAngle = true, },
			},

			ProjectileName = "DragonGlideGround",
			FireProjectileStartDelay = 0.0,
			BarrelLength = 150,
			FireTicks = 8,
			FireInterval = 0.1,
			--NumProjectiles = 8,
			--ProjectileInterval = 0.1,
			--FireProjectileAtSelf = true,

			MoveSuccessDistance = 1,

			DoNotRepeatOnAttackFail = true,

			MoveWithinRange = true,
			PreAttackRotationDampening = 0.15,
			FireRotationDampening = 0.0,
			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			StopMoveWithinRange = false,
			PostAttackStop = true,

			PreAttackDuration = 0.83,
			FireDuration = 0.0,
			PostAttackDuration = 0.85, -- anim is 1.65

			AttackDistance = 9999,
			RequireUnitLoS = true,
			LoSBuffer = 50,

			SoundManagerCap = 30,

			PreAttackSound = "/SFX/Enemy Sounds/Dragon/EmoteCharging",
			PreAttackAnimation = "Enemy_Dragon_GlidePreFire",
			FireAnimation = "Enemy_Dragon_GlideLoop",
			PostAttackAnimation = "Enemy_Dragon_GlidePostFire",
		},
		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Dragon/EmoteAttacking" },
			},
			WeaponFireTickSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Dragon/DragonFireBurst", }
			},
		},
	},

	DragonGlide_Miniboss =
	{
		InheritFrom = { "DragonGlide" },

		Requirements = { },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonGlideGround_Miniboss",		

			AttackSlots =
			{
				{ AnchorAngleOffset = 0, OffsetAngle = 225, OffsetDistance = 360, OffsetScaleY = 0.5, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ AnchorAngleOffset = 0, OffsetAngle = 0, OffsetDistance = 0, OffsetScaleY = 0.5, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ AnchorAngleOffset = 0, OffsetAngle = -225, OffsetDistance = 360, OffsetScaleY = 0.5, OffsetFromAttacker = true, UseAttackerAngle = true, },
			},

			WaitForAngleTowardTargetTimeOut = 0.25,
			PreAttackDuration = 0.65,
			PreAttackAnimationSpeed = 1.4,

			PostAttackStop = false,
			PostAttackDuration = 1.64,

			MoveWithinRangeTimeoutMin = 1.15,
			MoveWithinRangeTimeoutMax = 1.15,

		},
	},

	DragonWhirlLeft =
	{
		GenusName = "DragonWhirl",

		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonBreath",
			FireProjectileStartDelay = 0.0,
			BarrelLength = 100,
			NumProjectiles = 15,
			ProjectileInterval = 0.1,
			Spread = 5,

			DoNotRepeatOnAttackFail = true,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "DragonGlideBoost",
					DataProperties = 
					{
						Type = "Speed",
						Duration = 4.9,
						Modifier = 1.75,
					}
				},
			},

			CreateOwnTarget = true,
			TargetAngleOffset = 75,
			MoveSuccessDistance = 1,
			TargetOffsetDistance = 300,
			SkipIfTargetLocationBlocked = true,

			MoveWithinRange = true,
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
			PreAttackRotationDampening = 0.01,
			FireRotationDampening = 0.15,
			PreAttackAngleTowardTarget = false,
			StopMoveWithinRange = false,
			PostAttackStop = false,

			PreAttackDuration = 0.83,
			PreAttackSound = "/SFX/Enemy Sounds/DragonMiniboss/EmoteCharging",
			FireDuration = 1.9,
			PostAttackDuration = 2.2,

			AttackDistance = 9999,

			SoundManagerCap = 30,

			-- PreAttackSound = "/SFX/Enemy Sounds/DragonMiniboss/EmoteCharging",
			PreAttackAnimation = "Enemy_Dragon_GlidePreFire",
			FireAnimation = "Enemy_Dragon_GlideBankLeft",
			PostAttackAnimation = "Enemy_Dragon_GlidePostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/DragonMiniboss/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerEvade" },
			},
		},
	},

	DragonWhirlRight =
	{
		InheritFrom = { "DragonWhirlLeft" },
		GenusName = "DragonWhirl",
		AIData =
		{
			DeepInheritance = true,

			TargetAngleOffset = -75,

			FireAnimation = "Enemy_Dragon_GlideBankRight",
		},
	},

	DragonTailWhip =
	{
		Requirements =
		{
			MaxPlayerDistance = 500,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonTailWhip",

			PreAttackDuration = 0.835,
			FireDuration = 0.57,
			PostAttackDuration = 0.8, -- anim is 1.57

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			MoveWithinRangeTimeoutMin = 1.0,
			MoveWithinRangeTimeoutMax = 3.0,

			AttackDistance = 290,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackSound = "/SFX/Enemy Sounds/Dragon/EmotePowerCharging",
			PreAttackAnimation = "Enemy_Dragon_TailPreFire",
			FireAnimation = "Enemy_Dragon_TailFire",
			PostAttackAnimation = "Enemy_Dragon_TailPostFire",

			ExpireProjectilesOnHitStun = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Dragon/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Dragon/DragonTailWhipWhoosh" },
			},
		},
	},

	DragonTailWhip_Miniboss =
	{
		InheritFrom = { "DragonTailWhip", },

		Requirements =
		{
			MaxPlayerDistance = 550,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonTailWhip_Miniboss",
			AttackDistance = 380,

			FireSelfVelocity = 2000,

			MoveWithinRangeTimeoutMin = 1.0,
			MoveWithinRangeTimeoutMax = 1.1,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil