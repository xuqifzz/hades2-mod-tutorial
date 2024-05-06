WeaponSetData =
{
	WaterUnitSpit =
	{
		Requirements =
		{
			MinPlayerDistance = 330,
			MaxPlayerDistance = 900,
		},
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.RootedAttacker,
			},

			ProjectileName = "WaterUnitSpit",
			BarrelLength = 150,
			Spread = 5,

			PreAttackDuration = 0.8,
			FireDuration = 0.1,
			PostAttackDurationMin = 2.5,
			PostAttackDurationMax = 3.5,
			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/WaterUnit/EmoteCharging",
			PreAttackAnimation = "Enemy_WaterUnit_SpitAttackPreFire",
			FireAnimation = "Enemy_WaterUnit_SpitAttackInitialFire",
			PostAttackAnimation = "Enemy_WaterUnit_SpitAttackReturnToIdle",

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			StopBeforeFire = true,

			AttackDistance = 1800,
			MoveWithinRange = false,

			--ForceFirst = true,
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterUnit/EmoteAttacking" },
			},
		},
	},

	WaterUnitSpitElite =
	{
		InheritFrom = { "WaterUnitSpit" },
		AIData =
		{
			DeepInheritance = true,

			Spread = 25,

			FireDuration = 0.5,
			PostAttackDurationMin = 2.45,
			PostAttackDurationMax = 2.95,

			NumProjectiles = 3,
			ProjectileInterval = 0.2,
		},
	},

	WaterUnitSpitMiniBoss =
	{
		InheritFrom = { "WaterUnitSpit" },
		Requirements =
		{
			MinPlayerDistance = 440,
			MaxPlayerDistance = 900,
		},
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "WaterUnitSpitSplit",
			BarrelLength = 220,
			Spread = 0,

			PreAttackAnimation = "Enemy_WaterUnit_MiniBoss_Spit_Start",

			PreAttackDuration = 1.5,
			PostAttackDuration = 3.50,
			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteCharging",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},		
	},

	WaterUnitLob =
	{
		Requirements =
		{
			MinPlayerDistance = 900,
		},
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.RootedAttacker,
			},

			ProjectileName = "WaterUnitLob",
			BarrelLength = 0,
			Spread = 5,

			PreAttackDuration = 0.5,
			FireWaitForAnimation = true,
			PostAttackDuration = 1.5,
			FireProjectileStartDelay = 0.05,

			PreAttackAnimation = "Enemy_WaterUnit_LobAttackPreFire",
			FireAnimation = "Enemy_WaterUnit_LobAttackFire",
			PostAttackAnimation = "Enemy_WaterUnit_LobAttackReturnToIdle",
			PreAttackSound = "/SFX/Enemy Sounds/WaterUnit/EmoteCharging",

			AngleTowardsTargetWhileFiring = true,

			AttackDistance = 2500,
			MoveWithinRange = false,
			ImmuneToProjectileSlow = true,

			--ForceFirst = true,
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterUnit/EmoteAttacking" },
			},
		},
	},

	WaterUnitLobElite =
	{
		InheritFrom = { "WaterUnitLob" },
		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileInterval = 0.1,
			Spread = 60,
		},
	},

	WaterUnitLobMiniboss =
	{
		InheritFrom = { "WaterUnitLob" },
		Requirements =
		{
			MinPlayerDistance = 900,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "WaterUnitLobMiniboss",
			SpawnFromMarker = "WaterUnit_rig:jaw_00_M_JNT",
			Spread = 0,

			PostAttackDuration = 2.75,

			FireTicks = 20,
			FireInterval = 0.03,
			ResetTargetPerTick = true,

			--[[UseTargetId = 568842,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 1200,
			OffsetDistanceScaleY = 0.3,]]

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 9999,

			PreAttackSound = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteCharging",
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.00, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteAttacking" },
			},
		},
	},

	WaterUnitSurface =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_WaterUnit_Hidden",
			PreAttackAlpha = 0,
			PreAttackDurationMin = 0.8,
			PreAttackDurationMax = 1.8,
			FireFx = "WaterUnitSurface",
			FireAlpha = 1,
			FireAnimation = "Enemy_WaterUnit_Resurface",
			FireWaitForAnimation = true,
			PostAttackAnimation = "Enemy_WaterUnit_Idle",
			PostAttackDurationMin = 0.55,
			PostAttackDurationMax = 0.65,

			DoNotRepeatOnAttackFail = true,
			FireCreateHealthBar = true,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	WaterUnitDive =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 0.0,
			PreAttackFx = "WaterTeleportStartFx",
			FireAnimation = "Enemy_WaterUnit_Dive",
			FireWaitForAnimation = true,
			PostAttackAnimation = "Enemy_WaterUnit_Hidden",
			PostAttackAlpha = 0,
			PostAttackDuration = 0.0,

			PostAttackTeleportToSpawnPoints = true,
			TeleportMinDistance = 400,
			TeleportMaxDistance = 99999,
			TeleportToSpawnPointType = "EnemyPointRanged",

			AttackDistance = 9999,
			MoveWithinRange = false,

			ChainedWeapon = "WaterUnitSurface",

			PostAttackRemoveEnemyUI = true,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 3,
			MinRequiredKillEnemies = 5,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	WaterUnitDiveMiniBoss =
	{
		InheritFrom = { "WaterUnitDive" },

		AIData =
		{
			DeepInheritance = true,
			FireAnimation = "Enemy_WaterUnit_Dive_Large",
		},

		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},
	},

	WaterUnitRoar =
	{
		AIData =
		{
			PreAttackDuration = 0.27,
			FireDuration = 1.77,
			PostAttackDuration = 0.6,
			AttackDistance = 9999,

			MoveWithinRange = false,
			NoProjectile = true,
			PreAttackStop = true,
			PreAttackAngleTowardTarget = false,

			PreAttackAnimation = "Enemy_WaterUnit_Roar_Start",
			FireAnimation = "Enemy_WaterUnit_Roar_Fire",
			PostAttackAnimation = "Enemy_WaterUnit_Roar_End",

			FireFx = "CrawlerSpawnsHowl",

			SpawnBurstOnFire = true,
			SpawnOnSpawnPoints = true,
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 3,
			SpawnRadiusMin = 250,
			SpawnRadiusMax = 9999,
			SpawnRate = 0.85,
			MaxActiveSpawns = 5,
			
			SpawnerOptions =
			{
				"Radiator2_Elite",
			},
		},
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
	},

	WaterUnitSwipe =
	{
		Requirements =
		{
			MaxPlayerDistance = 330,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "WaterUnitSwipe",

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.4,

			PreAttackDuration = 1.17,
			FireProjectileStartDelay = 0.17,
			FireDuration = 0.32,
			PostAttackDuration = 0.6,

			AttackDistance = 350,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			MoveWithinRange = false,

			PreAttackSound = "/SFX/Enemy Sounds/WaterUnit/EmoteCharging",
			PreAttackAnimation = "Enemy_WaterUnit_Swipe_Start",
			FireAnimation = "Enemy_WaterUnit_Swipe_Fire",
			PostAttackAnimation = "Enemy_WaterUnit_Swipe_End",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterUnit/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonBigSwipe1" },
			},
		},

		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.06, Fraction = 1.00, LerpTime = 0.08 },
		},
	},

	WaterUnitSwipeMiniboss =
	{
		InheritFrom = { "WaterUnitSwipe" },
		Requirements =
		{
			MaxPlayerDistance = 450,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "WaterUnitSwipeMiniboss",

			AttackDistance = 450,
			LoSBuffer = 85,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterUnitMiniboss/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonBigSwipe2" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.03, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.00, LerpTime = 0.08 },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil