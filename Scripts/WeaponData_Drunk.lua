WeaponSetData =
{
	DrunkStab =
	{
		Requirements =
		{
 			MaxPlayerDistance = 2000,
 			MinAttacksBetweenUse = 4,
			RequireTotalAttacks = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DrunkStab",
			FireProjectileStartDelay = 0.05,

			ChargeSelfVelocity = 600,
			ChargeSelfVelocityAngleOffset = 180,

			FireSelfVelocity = 2600,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.15,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.05,

			RequireUnitLoS = true,
			LoSBuffer = 50,
			LoSEndBuffer = 75,

			PreAttackSound = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteChargingStab",
			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Drunk_StabPreFire",
			FireAnimation = "Enemy_Drunk_StabFire",
			PostAttackAnimation = "Enemy_Drunk_StabPostFire",
			PreAttackDuration = 0.2,
			PreFireDuration = 0.9,
			FireDuration = 0.28,
			PostAttackDuration = 1.7, -- animation is 1.54

			AttackDistance = 500,
			ForceUseIfReady = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteAttackingStab" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearSwipe" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},
	DrunkStab_Elite =
	{
		InheritFrom = { "DrunkStab", },
		Requirements =
		{
 			MaxPlayerDistance = 500,
 			MinAttacksBetweenUse = 7,
			RequireTotalAttacks = 3,
		},
		AIData =
		{
			DeepInheritance = true,
			FireSelfVelocity = 2900,
		},
	},

	DrunkSwingLeft =
	{
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DrunkSwingLeft",
			FireProjectileStartDelay = 0.14,
			FireSelfVelocity = 1600,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.3,

			RequireUnitLoS = true,
			LoSBuffer = 50,
			LoSEndBuffer = 50,

			PreAttackSound = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteCharging",
			--FireFx = "ScimiterrorSlashLeft",

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Drunk_LeftSwingPreFire",
			FireAnimation = "Enemy_Drunk_LeftSwingFire",
			PostAttackAnimation = "Enemy_Drunk_LeftSwingPostFire",
			PreAttackDuration = 0.6,
			FireDuration = 0.28,
			PostAttackDuration = 0.22, -- animation is 0.87

			AttackDistance = 800,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},
	DrunkSwingLeft_Elite =
	{
		InheritFrom = { "DrunkSwingLeft" },
		AIData =
		{
			DeepInheritance = true,
			FireSelfVelocity = 1900,
		},
	},

	DrunkSwingRight =
	{
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DrunkSwingRight",
			FireProjectileStartDelay = 0.06,
			FireSelfVelocity = 1200,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,

			RequireUnitLoS = true,
			LoSBuffer = 50,
			LoSEndBuffer = 50,

			PreAttackSound = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteCharging",
			--FireFx = "ScimiterrorSlashRight",

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Drunk_RightSwingPreFire",
			FireAnimation = "Enemy_Drunk_RightSwingFire",
			PostAttackAnimation = "Enemy_Drunk_RightSwingPostFire",
			PreAttackDuration = 0.6,
			FireDuration = 0.28,
			PostAttackDuration = 0.22, -- animation is 0.88

			AttackDistance = 800,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},
	DrunkSwingRight_Elite =
	{
		InheritFrom = { "DrunkSwingRight" },
		AIData =
		{
			DeepInheritance = true,
			FireSelfVelocity = 1900,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil