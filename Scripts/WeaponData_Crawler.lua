WeaponSetData =
{
	CrawlerRush =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CrawlerRush",

			FireSelfVelocity = 2600,
			FireProjectileStartDelay = 0.03,

			PreAttackSound = "/SFX/Enemy Sounds/RatThug/EmoteCharging",
			PreAttackAnimation = "Enemy_SatyrRat_RushPreFire",
			FireAnimation = "Enemy_SatyrRat_RushFire",
			PostAttackAnimation = "Enemy_SatyrRat_RushPostFire",

			PreAttackDuration = 0.7,
			PreAttackEndShake = true,
			FireDuration = 0.3,
			PostAttackDuration = 0.0,

			WaitForAngleTowardTarget = false,

			AttackDistance = 300,
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
		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CrawlerMinibossRush",

			FireSelfVelocity = 3250,
			FireProjectileStartDelay = 0.03,

			LoSBuffer = 25,
			LoSEndBuffer = 32,
			RequireUnitLoS = true,

			AttackDistance = 750,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.8,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			StopBeforeFire = true,

			PreAttackDuration = 0.675,
			PreAttackEndShake = true,
			FireDuration = 0.27,
			PostAttackDuration = 0.4,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 450,
			RetreatTimeout = 1.0,

			PreAttackSound = "/SFX/Enemy Sounds/RatThug/EmoteCharging",
			PreAttackAnimation = "Enemy_Crawler_RushAntic",
			FireAnimation = "Enemy_Crawler_RushFire",
			PostAttackAnimation = "Enemy_Crawler_RushToIdle",
		},
	},

	CrawlerRush_Shadow =
	{
		InheritFrom = { "CrawlerRush_Miniboss" },
		Requirements =
		{

		},

		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 400,
			FireSelfVelocity = 2000,
			ProjectileName = "CrawlerShadowRush",

			PreAttackAnimation = "Enemy_CrawlerShadow_RushAntic",
			FireAnimation = "Enemy_CrawlerShadow_RushFire",
			PostAttackAnimation = "Enemy_CrawlerShadow_RushToIdle",
		},
	},

	CrawlerMinibossSummon =
	{
		AIData =
		{
			PreAttackDuration = 0.5,
			FireDuration = 1.0,
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
			SpawnsPerBurstMax = 5,
			SpawnRadiusMin = 250,
			SpawnRadiusMax = 9999,
			SpawnRate = 0.55,
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
		Requirements =
		{
			MaxConsecutiveUses = 2,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CrawlerMinibossSlam",
			FireProjectileStartDelay = 0.15,
			FireProjectileAtSelf = true,

			LoSBuffer = 25,
			RequireUnitLoS = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			AttackDistance = 500,
			AttackDistanceScaleY = 0.85,
			MoveWithinRange = true,
			PreAttackStop = true,

			ChargeSelfVelocity = 700,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.6,
						Modifier = 0.1,
						HaltOnEnd = true,
					}
				}
			},

			PreAttackDuration = 0.4,
			PreFireDuration = 0.5,
			FireDuration = 0.5,
			PostAttackDuration = 0.5,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 450,
			RetreatTimeout = 1.0,

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

			PreMoveTeleport = true,
			TeleportMaxDistance = 900,
			TeleportationInterval = 0,
			TeleportPreWaitFx = "BurrowHoleIn",
			TeleportEndFx = "BurrowHoleOut",
			PreTeleportWait = 1.5,
			PostTeleportWait = 0.5,
			StopBeforeTeleport = true,
			TeleportToSpawnPointType = "EnemyPoint",
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