WeaponSetData =
{
	TurtleBounceLob =
	{

		Requirements =
		{
			MinPlayerDistance = 370,
			MaxAttackers = 3,
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

			PreAttackStop = true,

			AttackDistance = 1000,
			AttackDistanceScaleY = 0.58,

			RetreatAfterAttack = true,
			--RetreatToSpawnPoints = true,
			RetreatBufferDistance = 1100,
			RetreatDurationMin = 1.5,
			RetreatDurationMax = 2.0,

			PreAttackAnimation = "Enemy_Turtle_SpitAttackPreAttack",
			FireAnimation = "Enemy_Turtle_SpitAttackFire",
			PostAttackAnimation = "Enemy_Turtle_SpitAttackReturnToIdle",

			FireFx = "OceanusEnemySpitFireFx_Turtle"
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
			ProjectileName = "TurtleBounceElite",
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

			PreAttackDurationMin = 1.0,
			PreAttackDurationMax = 1.5,
			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Turtle/EmoteCharging",

			PreAttackStop = true,

			NumProjectiles = 2,
			ProjectileInterval = 0.11,

			FireDuration = 0.725,
			PostAttackDuration = 0.5,
			PreAttackAnimation = "Enemy_Turtle_ClawAttackPreAttack",
			FireAnimation = "Enemy_Turtle_ClawAttackFire",
			PostAttackAnimation = "Enemy_Turtle_ClawAttackReturnToIdle",

			AttackDistance = 400,
			MoveWithinRange = false,
			AttackDistanceScaleY = 0.8,

			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			SkipSurroundAICount = true,
		},

		Requirements =
		{
			MaxPlayerDistance = 370,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},
	},

	-- Only for when there are too many turtles lobbing and these are out of range of the regular claw
	TurtleClawRush =
	{
		InheritFrom = { "TurtleClaw" },

		Requirements =
		{
			MinAttackers = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = true,
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

			SkipSurroundAICount = true,
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