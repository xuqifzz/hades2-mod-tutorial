WeaponSetData =
{
	CrawlerRush =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CrawlerRush",

			FireSelfVelocity = 3250,
			FireProjectileStartDelay = 0.03,

			PreAttackSound = "/SFX/Enemy Sounds/RatThug/EmoteCharging",
			PreAttackAnimation = "Enemy_SatyrRat_RushPreFire",
			FireAnimation = "Enemy_SatyrRat_RushFire",
			PostAttackAnimation = "Enemy_SatyrRat_RushPostFire",

			PreAttackDuration = 0.1,
			FireDuration = 0.3,
			PostAttackDuration = 0.0,

			WaitForAngleTowardTarget = false,

			AttackDistance = 525,
			RetreatBufferDistance = 650,
			RetreatAfterAttack = true,

			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/RatThug/EmoteAttacking" },
			},
		},
	},

	CrawlerRush_Miniboss =
	{
		InheritFrom = { "CrawlerRush" },
		AIData =
		{
			DeepInheritance = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.8,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			StopBeforeFire = true,

			PreAttackDuration = 1.5,
			PreAttackEndShake = true,
			PreAttackAnimationSpeed = 0.75,
			FireDuration = 1.0,
			PostAttackDuration = 0.5,

			PreAttackAnimation = "Enemy_Crawler_RushAntic",
			FireAnimation = "Enemy_Crawler_RushFire",
			PostAttackAnimation = "Enemy_Crawler_RushToIdle",
			ProjectileName = "CrawlerMinibossRush",
		},
	},

	CrawlerMinibossSummon =
	{
		AIData =
		{
			PreAttackDuration = 0.5,
			FireDuration = 2.5,
			PostAttackDuration = 0.5,
			AttackDistance = 9999,

			MoveWithinRange = false,
			NoProjectile = true,
			PreAttackStop = true,
			PreAttackAngleTowardTarget = false,

			PreAttackAnimation = "Enemy_Crawler_RoarAntic",
			FireAnimation = "Enemy_Crawler_RoarLoop",
			PostAttackAnimation = "Enemy_Crawler_RoarReturnToIdle",

			FireFx = "CrawlerSpawnsHowl",

			SpawnBurstOnFire = true,
			SpawnOnSpawnPoints = true,
			SpawnsPerBurstMin = 5,
			SpawnsPerBurstMax = 7,
			SpawnRadiusMin = 250,
			SpawnRadiusMax = 9999,
			SpawnRate = 0.85,
			MaxActiveSpawns = 15,
			
			SpawnerOptions =
			{
				"ThiefMineLayer_Elite",
			},
		},

		Requirements =
		{
			MinAttacksBetweenUse = 10,
			BlockAsFirstWeapon = true,
		},

		FireRadialBlur = { Distance = 1.0, Strength = 1.0, FXHoldTime = 0.4, FXInTime = 0.15, FXOutTime = 0.15 },
		FireScreenshake = { Distance = 5, Speed = 800, Duration = 0.7, FalloffSpeed = 3000 },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 },
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				--{ Name = "/SFX/Enemy Sounds/Crawler/CrawlerMinibossRoar" },
			},
		},
	},

	CrawlerMinibossSlam =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CrawlerMinibossSlam",
			FireProjectileStartDelay = 0.15,
			FireProjectileAtSelf = true,

			AttackDistance = 200,
			AttackDistanceScaleY = 0.85,
			MoveWithinRange = true,
			PreAttackStop = true,

			PreAttackDuration = 0.9,
			PreAttackAnimationSpeed = 0.5,
			FireDuration = 0.5,
			PostAttackDuration = 0.5,

			PreAttackSound = "/SFX/Enemy Sounds/FogEmitter/EmoteCharging",
			PreAttackAnimation = "Enemy_Crawler_GroundPoundAntic",
			FireAnimation = "Enemy_Crawler_GroundPoundFire",
			PostAttackAnimation = "Enemy_Crawler_GroundPoundReturnToIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Enemy Sounds/RatThug/EmoteCharging" },
				{ Name = "/SFX/Enemy Sounds/Crawler/EmoteAlerted" }
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	CrawlerBurrow =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			FireProjectileStartDelay = 0.15,
			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,
			PreAttackEndStop = true,
			PostAttackStop = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			AttackDistance = 9999,

			TeleportPreWaitAnimation = "Enemy_SatyrRat_Burrow",
			TeleportAnimation = "Enemy_SatyrRat_Unburrow",

			TeleportToSpawnPoints = true,
			TeleportMaxDistance = 900,
			TeleportationInterval = 0,
			TeleportPreWaitFx = "BurrowHoleIn",
			TeleportEndFx = "BurrowHoleOut",
			PreTeleportWait = 1.5,
			PostTeleportWait = 0.5,
			StopBeforeTeleport = true,
			TeleportToSpawnPointType = "EnemyPoint",
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	CrawlerBurrow_Miniboss =
	{
		InheritFrom = { "CrawlerBurrow", },
		AIData =
		{
			DeepInheritance = true,
			TeleportPreWaitAnimation = "Enemy_Crawler_BurrowIntoGround",
			TeleportAnimation = "Enemy_Crawler_BurrowOutOfGround",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil