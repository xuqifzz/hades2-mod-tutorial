WeaponSetData =
{
	DragonBreath =
	{
		Requirements =
		{
			MinPlayerDistance = 700,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonBreathGround",
			FireProjectileStartDelay = 0.0,

			AttackSlots =
			{
				{ OffsetDistance = 250, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.2 },
				{ OffsetDistance = 400, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.175 },
				{ OffsetDistance = 600, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.15 },
				{ OffsetDistance = 800, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.1 },
				{ OffsetDistance = 1000, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.05 },
				{ OffsetDistance = 1200, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.025 },
			},
			FireInterval = 1.2,

			DoNotRepeatOnAttackFail = true,
			SkipIfInvalidLocation = true,

			MoveWithinRange = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,
			PreAttackRotationDampening = 0.15,
			FireRotationDampening = 0.07,

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
		Requirements = { },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonBreathGround_Miniboss",
			PreAttackDuration = 0.75,
			PreAttackAnimationSpeed = 1.5,
			PostAttackDuration = 0.5, 

			AttackSlots =
			{
				{ OffsetDistance = 250, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.2 },
				{ OffsetDistance = 400, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.175 },
				{ OffsetDistance = 600, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.15 },
				{ OffsetDistance = 800, OffsetAngle = 0, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 800, OffsetAngle = -5, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 800, OffsetAngle = 5, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.1 },
				{ OffsetDistance = 1000, OffsetAngle = 0, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 1000, OffsetAngle = -7.5, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 1000, OffsetAngle = 7.5, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.1 },
				{ OffsetDistance = 1200, OffsetAngle = 0, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 1200, OffsetAngle = -7.5, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 1200, OffsetAngle = 7.5, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.1 },
				{ OffsetDistance = 1500, OffsetAngle = 0, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 1500, OffsetAngle = -10, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 1500, OffsetAngle = 10, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.1 },
				{ OffsetDistance = 1800, OffsetAngle = 0, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 1800, OffsetAngle = -12.5, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 1800, OffsetAngle = 12.5, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.1 },
				{ OffsetDistance = 2100, OffsetAngle = 0, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 2100, OffsetAngle = -12.5, OffsetFromAttacker = true, UseAttackerAngle = true, },
				{ OffsetDistance = 2100, OffsetAngle = 12.5, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.1 },
			},
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
			PostAttackStop = false,
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

			TrackTargetDuringCharge = true,

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

			MoveWithinRangeTimeoutMin = 1.5,
			MoveWithinRangeTimeoutMax = 2.1,

		},

	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil