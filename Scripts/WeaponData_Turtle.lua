WeaponSetData =
{
	TurtleBounceLob =
	{

		Requirements =
		{
			MinPlayerDistance = 300,
		},

		AIData =
		{
			DeepInheritance = true,


			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.RootedAttacker,
			},

			DoNotRepeatOnAttackFail = true,
			ImmuneToProjectileSlow = true,

			ProjectileName = "TurtleBounce",
			BarrelLength = 200,
			Spread = 0,
			--FireProjectileTowardTarget = true,
			FireProjectileStartDelay = 0.125,

			PreAttackDuration = 1.0,
			FireDuration = 0.7,
			--FireWaitForAnimation = true,
			PostAttackDurationMin = 1.5,
			PostAttackDurationMax = 2.0,
			PreAttackSound = "/SFX/Enemy Sounds/Turtle/EmotePowerCharging",

			WaitForAngleTowardTarget = true,

			AttackDistance = 1000,
			AttackDistanceScaleY = 0.58,

			PreAttackAnimation = "Enemy_Turtle_SpitAttackPreAttack",
			FireAnimation = "Enemy_Turtle_SpitAttackFire",
			PostAttackAnimation = "Enemy_Turtle_SpitAttackReturnToIdle",

			FireFx = "OceanusEnemySpitFireFx_Turtle"
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
				{ Name = "/SFX/Enemy Sounds/Turtle/EmotePowerAttacking" },
			},
		},		
	},

	TurtleBounceLobElite =
	{
		InheritFrom = { "TurtleBounceLob" },
		AIData =
		{
			DeepInheritance = true,

			--FireRotationDampening = 0.01,
			--TrackTargetDuringFire = true,
			--PostAttackStop = true,
			FireTicks = 3,
			FireInterval = 0.25,
			FireDuration = 0.45,
		},
	},

	TurtleClaw =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TurtleClaw",

			FireSelfVelocity = 1100,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			DoNotRepeatOnAttackFail = true,
			FireProjectileStartDelay = 0.035,

			PreAttackDuration = 1.0,
			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Turtle/EmoteCharging",

			NumProjectiles = 2,
			ProjectileInterval = 0.11,

			FireDuration = 0.725,
			PostAttackDuration = 0.5,
			PreAttackAnimation = "Enemy_Turtle_ClawAttackPreAttack",
			FireAnimation = "Enemy_Turtle_ClawAttackFire",
			PostAttackAnimation = "Enemy_Turtle_ClawAttackReturnToIdle",

			AttackDistance = 350,
			MoveWithinRange = false,

			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,
		},

		Requirements =
		{
			MaxPlayerDistance = 300,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},	

		HitScreenshake = { Distance = 2, Speed = 600, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.03 },
		},	
	},

	TurtleHide =
	{
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">=",
				Value = 2,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			MoveWithinRange = false,
			SkipFireWeapon = true,
			DoNotRepeatOnAttackFail = true,

			PreAttackDuration = 1.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			PreAttackAnimation = "Enemy_Turtle_Fidget",
			FireAnimation = "Enemy_Turtle_Idle",
			PostAttackAnimation = "Enemy_Turtle_Idle",

		},

		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},	
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil