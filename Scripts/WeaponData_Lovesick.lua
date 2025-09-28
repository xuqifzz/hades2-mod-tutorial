WeaponSetData =
{
	LovesickLauncher =
	{
		Requirements =
		{
			MinPlayerDistance = 380,
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,
			FireProjectileAtTarget = true,
			SpawnFromMarker = "Lovesick_Rig:frontHole_00_R_JNT",
			ProjectileName = "LovesickHeartLob",

			DoNotRepeatOnAttackFail = true,

			FireTickSelfVelocity = 500,
			FireTickSelfVelocityAngleOffset = 180,
			ImmuneToProjectileSlow = true,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.25,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.25,
			PostAttackStop = true,

			PreAttackFx = "LovesickChargeFx",
			PreAttackDuration = 0.6,
			FireDuration = 0.25,
			PostAttackDurationMin = 1.75,
			PostAttackDurationMax = 2.25,

			AttackDistance = 1050,
			AttackDistanceScaleY = 0.50,
			LoSBuffer = 50,
			RequireProjectileLoS = true,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 530,

			--NumProjectiles = 3,
			--ProjectileInterval = 0.08,

			PreAttackSound = "/SFX/Enemy Sounds/Heartless/EmotePowerCharging",
			PreAttackAnimation = "Enemy_Lovesick_LauncherFire",
			--FireAnimation = "Enemy_Lovesick_LauncherFire",
			PostAttackAnimation = "Enemy_Lovesick_LauncherPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Heartless/EmotePowerAttacking" },
			},
		},
	},

	LovesickLauncher_Elite =
	{
		InheritFrom = { "LovesickLauncher" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LovesickHeartLob_Elite",
		},
	},

	LovesickGround =
	{
		Requirements =
		{
			MaxPlayerDistance = 500,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LovesickHeartGround",
			FireProjectileStartDelay = 0.25,
			SpawnFromMarker = "Lovesick_Rig:grenade_00_M_JNT",
			TargetSelf = true,
			FireProjectileAtTarget = true,

			-- PreAttackFunctionName = "WeaponSetImmuneToStun",

			PreAttackFx = "LovesickChargeFx",
			PreAttackDuration = 1.67,
			FireWaitForAnimation = true,
			PostAttackDuration = 0.6,

			AttackDistance = 400,
			LoSBuffer = 85,
			RequireUnitLoS = true,
			PreAttackEndShake = true,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 600,
			RetreatDurationMin = 3.0,
			RetreatDurationMax = 4.0,

			PreAttackSound = "/SFX/Enemy Sounds/Heartless/EmotePowerCharging",
			PreAttackAnimation = "Enemy_Lovesick_GroundPreFire",
			FireAnimation = "Enemy_Lovesick_GroundFire",
			PostAttackAnimation = "Enemy_Lovesick_GroundPostFire",

			SkipSurroundAICount = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Heartless/EmotePowerAttacking" },
			},
		},
	},

	LovesickGround_Elite =
	{
		InheritFrom = { "LovesickGround" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "LovesickHeartGround_Elite",
		},
	},

	LovesickOverhand =
	{
		Requirements =
		{
			MaxAttackers = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LovesickHeartOverhand",
			BarrelLength = 0,
			FireProjectileStartDelay = 0.125,
			Spread = 5,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,
			StopBeforeFire = true,
			FireProjectileAtTarget = true,

			PreAttackWaitForAnimation = true,
			FireDuration = 0.3,
			PostAttackDurationMin = 1.75,
			PostAttackDurationMax = 2.25,
			PreAttackEndShake = true,
			
			PreAttackSound = "/SFX/Enemy Sounds/Heartless/EmoteCharging",
			PreAttackFx = "LovesickChargeFx",
			PreAttackAnimation = "Enemy_Lovesick_OverhandPreFire",
			FireAnimation = "Enemy_Lovesick_OverhandFire",
			PostAttackAnimation = "Enemy_Lovesick_OverhandPostFire",

			AttackDistance = 1040,
			AttackDistanceScaleY = 0.48,
			RequireProjectileLoS = true,
			LoSBuffer = 100,

			RetreatAfterAttack = true,
			--RetreatToSpawnPoints = true,
			RetreatBufferDistance = 1500,
			RetreatTimeoutMin = 6.5,
			RetreatTimeoutMax = 7.5,

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Heartless/EmoteAttacking" },
			},
		},
	},

	LovesickHeartMineBlast =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LovesickHeartMineBlast",

			FireProjectileAtSelf = true,
			FireFromTarget = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},
	},

	LovesickHeartMineBlast_Elite =
	{
		InheritFrom = { "LovesickHeartMineBlast" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LovesickHeartMineBlast_Elite",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil