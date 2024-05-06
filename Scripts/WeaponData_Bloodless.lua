WeaponSetData =
{
	BloodlessMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BloodlessMelee",
			PreAttackSelfVelocity = 400,
			PreAttackSelfVelocityAngleOffset = 180,
			FireSelfVelocity = 1500,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},
			FireProjectileStartDelay = 0.09,

			PreAttackSound = "/SFX/Enemy Sounds/Bloodless01/EmoteCharging",
			PreAttackAnimationSpeed = 0.80,
			PreAttackDuration = 0.92,
			FireDuration = 0.25,
			PostAttackDuration = 0.93,
			--PostAttackCooldown = 0.35,

			AttackDistance = 350,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.42,
			PreAttackEndFlashFraction = 0.6,

			PreAttackAnimation = "Enemy_BloodlessNaked_AttackPreFire",
			FireAnimation = "Enemy_BloodlessNaked_AttackFire",
			PostAttackAnimation = "Enemy_BloodlessNaked_AttackPostFire",
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Bloodless01/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},
	},

	BloodlessMeleeBerserkerCombo1 =
	{
		AIData =
		{
			DeepInheritance = true,
		},

		WeaponComboOnly = true,
		WeaponCombo =
		{
			"BloodlessMeleeBerserkerAttackStart",
			"BloodlessMeleeBerserker2",
			"BloodlessMeleeBerserker1",
			"BloodlessMeleeBerserker2",
			"BloodlessMeleeBerserker1",
			"BloodlessMeleeBerserkerAttackEnd",
		},
	},

	BloodlessMeleeBerserker1 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BloodlessMeleeBerserker",

			PreAttackAnimation = "Enemy_BloodlessNaked_WildAttack1_Start",
			FireAnimation = "Enemy_BloodlessNaked_WildAttack1_Fire",

			FireProjectileStartDelay = 0.05,
			FireSelfVelocity = 1200,

			FireFx = "BloodlessBerserkerSwipe",

			PreAttackSound = nil,
			PreAttackDuration = 0.2,
			FireDuration = 0.22,
			PostAttackDuration = 0.0,

			PreAttackRotationDampening = 0.09,
			FireRotationDampening = 0.09,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Bloodless01/EmoteThrustAttacking" },
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessMeleeBerserkerAttackStart =
	{
		InheritFrom = { "BloodlessMeleeBerserker1" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Bloodless01/EmoteCharging",
			PreAttackAnimation = "Enemy_BloodlessNaked_WildAttack1_Start",
			PreAttackAnimationSpeed = 0.4,
			PreAttackDuration = 0.5,
			PreAttackEndShake = true,

			AttackDistance = 500,
			MoveWithinRange = true,
		}
	},

	BloodlessMeleeBerserker2 =
	{
		InheritFrom = { "BloodlessMeleeBerserker1" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BloodlessMeleeBerserker2",

			FireFx = "BloodlessBerserkerSwipeFlipped",

			PreAttackSound = nil,
			PreAttackAnimation = "Enemy_BloodlessNaked_WildAttack2_Start",
			FireAnimation = "Enemy_BloodlessNaked_WildAttack2_Fire",
			PreAttackDuration = 0.26,
			FireDuration = 0.23,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessMeleeBerserkerAttackEnd =
	{
		InheritFrom = { "BloodlessMeleeBerserker2" },
		AIData =
		{
			DeepInheritance = true,

			PostAttackAnimation = "Enemy_BloodlessNaked_WildAttack_End",
			PostAttackDuration = 1.21,

			RetreatLeapAfterUse = true,
		}
	},

	BloodlessWaveFistWeapon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BloodlessWaveFistWeapon",
			FireProjectileStartDelay = 0.225,
			BarrelLength = 300,

			PreAttackSound = "/SFX/Enemy Sounds/BloodlessWaveFist/EmoteWaveFistCharge",
			PreAttackDuration = 0.8,
			PreAttackEndShake = true,
			FireDuration = 0.35,
			PostAttackDuration = 1.47,
			RequireProjectileLoS = false,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			AttackDistance = 700,
			RetreatDistance = 600,

			PreAttackAnimation = "Enemy_BloodlessNaked_WavePreFire",
			FireAnimation = "Enemy_BloodlessNaked_WaveFire",
			PostAttackAnimation = "Enemy_BloodlessNaked_WavePostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/BloodlessWaveFist/EmoteWaveFistAttack" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	BloodlessWaveFistWeaponElite =
	{
		InheritFrom = { "BloodlessWaveFistWeapon" },
		AIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 0.0,

			ChainedWeapon = "BloodlessWaveFistWeaponElite2",
		},
	},

	BloodlessWaveFistWeaponElite2 =
	{
		InheritFrom = { "BloodlessWaveFistWeapon" },

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			PreAttackDuration = 0.4,
			PostAttackDuration = 2.0,

			LeapWhenTargetBeyondDistance = 9999,
			LeapWhenTargetOutOfSight = false,
		},
	},

	BloodlessGrenadierRanged =
	{
		AIData =
		{
			DeepInheritance = true,
			BarrelLength = 150,
			Spread = 30,

			FireProjectileStartDelay = 0.15,

			FireProjectileAtTarget = true,

			ProjectileName = "BloodlessGrenadierRanged",

			ImmuneToProjectileSlow = true,

			PreAttackStop = true,
			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackSound = "/SFX/Enemy Sounds/Bloodless02/EmoteCharging",
			PreAttackDuration = 0.28,
			FireDuration = 0.31,
			PostAttackDuration = 0.95,
			PostAttackCooldownMin = 0.3,
			PostAttackCooldownMax = 0.7,

			AttackDistance = 1050,
			LoSBuffer = 50,
			RequireProjectileLoS = true,

			PreAttackAnimation = "Enemy_BloodlessGrenadier_LobPreFire",
			FireAnimation = "Enemy_BloodlessGrenadier_LobFire",
			PostAttackAnimation = "Enemy_BloodlessGrenadier_LobPostFire",

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
				{ Name = "/SFX/Enemy Sounds/Bloodless02/EmoteAttackingMultiMortars" },
			},
		},
	},

	BloodlessGrenadierRangedElite =
	{
		InheritFrom = { "BloodlessGrenadierRanged" },

		AIData =
		{
			DeepInheritance = true,
			PostAttackCooldownMin = 0.0,
			PostAttackCooldownMax = 0.3,
		},
	},

	BloodlessGrenadierCluster =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 3,
			MaxPlayerDistance = 300,
		},

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "BloodlessGrenadierRanged",

			PreAttackAngleTowardTarget = false,

			NumProjectiles = 3,
			ProjectileAngleInterval = 120,
			ProjectileInterval = 0.075,
			ProjectileOffsetDistanceScaleY = 0.75,
			RequireProjectileLoS = true,
			LoSBuffer = 150,

			AttackDistance = 300,

			RetreatLeapAfterUse = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PreAttackAnimation = "Enemy_BloodlessGrenadier_Leap",
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	BloodlessGrenadierDeathDrop =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BloodlessGrenadierDrop",

			FireProjectileAtSelf = true,
			TargetSelf = true,
			FireFromTarget = true,
			PreAttackStop = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},	
	},

	BloodlessGrenadierDive =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BloodlessGrenadierDive",
			BarrelLength = 150,
			PreAttackEndStop = true,
			FireProjectileStartDelay = 0.28,

			AttackDistance = 300,
			RequireProjectileLoS = true,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			RetreatAfterAttack = true,
			RetreatBufferDistance = 450,

			PreAttackSound = "/SFX/Enemy Sounds/Bloodless02/EmoteCharging",
			PreAttackDuration = 1.15,
			FireDuration = 0.34,
			PostAttackDuration = 0.8,
			PostAttackCooldownMin = 0.2,
			PostAttackCooldownMax = 0.5,

			MaxConsecutiveUses = 1,

			PreAttackAnimation = "Enemy_BloodlessGrenadier_SelfDestruct_Start",
			FireAnimation = "Enemy_BloodlessGrenadier_SelfDestruct_Fire",
			PostAttackAnimation = "Enemy_BloodlessGrenadier_SelfDestruct_End",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Bloodless02/EmoteAttackingMultiMortars" },
				{ Name = "/SFX/Explosion1" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessReposition =
	{
		Requirements = 
		{
			MaxConsecutiveUses = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			RepositionLeap = true,

			AttackDistance = 1000,

			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 0.5,
			PostAttackCooldownMin = 0.0,
			PostAttackCooldownMax = 0.1,

			SkipFireWeapon = true,
		}
	},

	BloodlessPitch =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BloodlessPitch",
			BarrelLength = 65,

			PreAttackAnimation = "Enemy_BloodlessGrenadier_LobPreFire",
			PreFireAnimation = "Enemy_BloodlessGrenadier_LobFire",

			PreAttackEndShake = true,

			FireProjectileStartDelay = 0.11,

			WaitForAngleTowardTarget = true,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			PreAttackRotationDampening = 0.09,

			PreAttackSound = "/SFX/Enemy Sounds/Bloodless02/EmoteCharging",
			PreAttackDuration = 0.56,
			PreAttackAnimationSpeed = 0.5,
			FireDuration = 0.31,
			PostAttackDuration = 1.5,

			AttackDistance = 750,
			RequireProjectileLoS = true,
			LoSBuffer = 100,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/BloodlessPitcher/EmoteFastBall" }
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessPitchCurve =
	{
		InheritFrom = { "BloodlessPitch" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "BloodlessPitchCurve",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/World Sounds/TrainingMontageWhoosh" },
				{ Name = "/SFX/Enemy Sounds/BloodlessPitcher/EmoteCurveBall" }
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BloodlessPitchCurveVolley =
	{
		InheritFrom = { "BloodlessPitch" },
		AIData =
		{
			DeepInheritance = true,

			Spread = 15,

			PreAttackDurationMin = 1.7,
			PreAttackDurationMax = 1.7,
			FireTicks = 1,
			FireCooldown = 0.5,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
				{ Name = "/SFX/Enemy Sounds/BloodlessPitcher/EmoteCurveBall" }
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil