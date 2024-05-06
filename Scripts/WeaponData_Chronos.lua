WeaponSetData =
{
	-- Chronos
	ChronosUltimate =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 1.40,
			FireDuration = 0.25,
			PostAttackDuration = 3.90,

			FireFunctionName = "ChronosTimeSlow",
			TimeSlowDuration = 5,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/ChronosPreDash",
			PreAttackAnimation = "Enemy_Chronos_CastSlowPreFire",
			FireAnimation = "Enemy_Chronos_CastSlowFire",
			--PostAttackAnimation = "Enemy_Chronos_CastSlowPostFire",

			AttackDistance = 9999,

			AttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ChronosUltimateVoiceLines,
			},

		},

		Requirements =
		{
			MinAttacksBetweenUse = 24,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
			},
		},
	},

	ChronosDefense =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosBoltDefense",
			NumProjectiles = 6,
			ProjectileAngleInterval = 60,
			FireTicks = 5,
			FireInterval = 0.3,
			FireProjectileStartDelay = 1.3,

			PreAttackDumbFireWeapons = { "ChronosCultistSpawn" },

			PreAttackDurationMin = 3.3,
			PreAttackDurationMax = 3.3,
			FireDuration = 0.72,
			PostAttackDurationMin = 1.5,
			PostAttackDurationMax = 2.5,

			TeleportToId = 626310,
			TargetId = 626385,
			AttackDistance = 9999,

			TeleportAnimation = "Enemy_Chronos_CastFastPostFire",
			TeleportStartFx = "HecateTeleportFxFront",
			TeleportEndFx = "HecateTeleportFxFront",

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_DefenseIntro",
			FireAnimation = "Enemy_Chronos_DefenseExplodePreFire",
			PostAttackAnimation = "Enemy_Chronos_DefenseExplodePostFire",
			ForceUseIfReady = true,

			DoNotRepeatOnAttackFail = true,

			ExpireProjectilesOnFire = { "ChronosBoltOrbit" }, -- so the circling projectiles don't overlap and blow out the projectile budget

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ChronosSummonVoiceLines,
			},

		},

		Requirements =
		{
			MinAttacksBetweenUse = 16,
			RequireTotalAttacks = 10,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
			},
		},
	},

	ChronosCultistSpawn =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnBurstOnFire = true,
			SpawnerOptions = { "SatyrCultist" },
			RequiredSpawnPointType = "EnemyPointMelee",
			SpawnsPerBurstMin = 6,
			SpawnsPerBurstMax = 6,
			MaxActiveSpawns = 6,
			SpawnRadius = 2500,
			SpawnRadiusMax = 3500,
			SpawnRate = 0.7,
			SpawnOnSpawnPoints = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},
	},

	ChronosDefense2 =
	{
		InheritFrom = { "ChronosDefense" },
		AIData =
		{
			DeepInheritance = true,
			RequiredSpawnPointType = "EnemyPointMelee",

			TeleportToId = 645921,
			TargetId = 645928,

			PreAttackDumbFireWeapons = { "ChronosTimeElementalSpawn" },

			ExpireProjectilesOnFire = { "ChronosBoltOrbit", "ChronosBoltOrbit2", "ChronosBoltOrbit3" }, -- so the circling projectiles don't overlap and blow out the projectile budget
		},
	},

	ChronosTimeElementalSpawn =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnBurstOnFire = true,
			SpawnerOptions = { "TimeElemental" },
			SpawnOnIdsOrdered = { 645922, 645923, 645924, 645925, 645926, 645927, 645928, 645929, 645930, 645931, 645932, 645933, },
			SpawnsPerBurstMin = 12,
			SpawnsPerBurstMax = 12,
			MaxActiveSpawns = 12,
			SpawnRate = 2.5,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},
	},

	ChronosDefense3 =
	{
		InheritFrom = { "ChronosDefense" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackDumbFireWeapons = "nil",
			PreAttackRandomDumbFireWeapon = { "ChronosEliteSpawn1", "ChronosEliteSpawn2", "ChronosEliteSpawn3" },
		},
	},

	ChronosEliteSpawn1 =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnOnIdsOrdered = { 704860, 704859, },

			SpawnBurstOnFire = true,
			SpawnerOptions = { "SatyrLancer_Elite" },
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 4,
			SpawnRate = 0.02,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},
	},

	ChronosEliteSpawn2 =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnOnIdsOrdered = { 704860, 704859, },

			SpawnBurstOnFire = true,
			SpawnerOptions = { "GoldElemental_Elite" },
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 4,
			SpawnRate = 0.6,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},
	},

	ChronosEliteSpawn3 =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnOnIdsOrdered = { 704860, 704859, },

			SpawnBurstOnFire = true,
			SpawnerOptions = { "SatyrRatCatcher_Elite" },
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 4,
			SpawnRate = 0.02,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},
	},

	ChronosBannerSummon =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 25,
			RequireTotalAttacks = 5,
			MaxUses = 2,
			--RequireNumIdsOfType = { Name = "BattleStandard", Count = 0 }, -- this seems to make it never fire
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnBurstOnFire = true,
			SpawnerOptions = { "BattleStandardChronos" },
			--RequiredSpawnPointType = "EnemyPointSupport",

			SpawnBurstOnFire = true,
			SpawnRate = 0.134,
			SpawnOnSpawnPoints = true,
			SpawnRadius = 9999,

			SpawnsPerBurstMin = 4,
			SpawnsPerBurstMax = 4,
			SpawnRadiusMin = 1,
			SpawnRadius = 9999,
			--SpawnRadiusMax = 9999,
			MaxActiveSpawns = 5,
			--SpawnOnSpawnPoints = true,
			SpawnOnIds = { 704863, 704864, 704859, 704860, },
			--PreAttackFunctionName = "SpawnChronosBanners",

			PreAttackDuration = 1.4,
			FireDuration = 0.5,
			PostAttackDuration = 1.5,

			MoveToClosestId = { 626310, 713403, 713402, 713399, 713398, 713401, 713397, 713396, 713400, 713395, 713394, },
			AttackDistance = 150,
			MoveSuccessDistance = 35,
			StopMoveWithinRange = false,
			PreAttackEndStop = true,
			MoveWithinRangeTimeout = 3.5,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_CastSlowPreFire",
			FireAnimation = "Enemy_Chronos_CastSlowFire",
			PostAttackAnimation = "Enemy_Chronos_CastSlowPostFire",

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ChronosPreAttackVoiceLines,
			},

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmotePowerAttackingMelee" },
			},
		},
	},

	ChronosDash =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosDashStasis",
			FireProjectileAtSelf = true,
			FireProjectileStartDelay = 0.7,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			StopBeforeFire = true,

			PostAttackTeleportToSpawnPoints = true,
			TeleportToSpawnPointType = "EnemyPoint",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportMinDistance = 660,
			TeleportMaxDistance = 99999,
			TeleportToSpawnPointType = "EnemyPoint",
		
			PreAttackDuration = 0.83,
			FireDuration = 0.7,
			PostAttackDuration = 0.0,
			PreTeleportWait = 0.6,
			PostTeleportWait = 1.2,

			PreAttackDumbFireWeapons = { "ChronosDashRadial" },

			AttackDistance = 9999,

			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreTeleportClearAllEffects = true,

			PreAttackAnimation = "Enemy_Chronos_CastFastPreFire",
			FireAnimation = "Enemy_Chronos_CastFastFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteEvading" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosDashStraight" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ChronosDashRadial =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosDashRadial",
			FireProjectileAtSelf = true,
			
			PreAttackDuration = 0,
			FireDuration = 0,
			PostAttackDuration = 0,

			AttackDistance = 9999,

			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGrab" },
			},
		},

		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.03, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},


	ChronosRush =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRush",
			DumbFireWeapons = { "ChronosRushRipple" },

			FireSelfVelocity = 3800,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.5,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.07,
			StopBeforeFire = true,

			FireProjectileStartDelay = 0.05,
			PreAttackDuration = 1.17,
			PreAttackFx = "ChronosScythePreAttackSparkleRush",
			FireDuration = 0.67,
			PostAttackDuration = 1.6,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.32,

			AttackDistance = 850,
			AttackDistanceScaleY = 0.55,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			FireFx = "EnemyHeavySlash",
			FireFxOffset = 300,
			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_Chronos_RushPreFire",
			FireAnimation = "Enemy_Chronos_RushFire",
			PostAttackAnimation = "Enemy_Chronos_RushPostFire",

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ChronosPreAttackVoiceLines,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingMelee" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosDashStraight" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ChronosRushComboStart =
	{
		InheritFrom = { "ChronosRush" },
		AIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 0.15,
			PostAttackAnimation = "Enemy_Chronos_RushPostFire_Combo",
			MoveWithinRange = false,
		},
	},

	ChronosRushComboMiddle =
	{
		InheritFrom = { "ChronosRush" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.3,
			PostAttackDuration = 0.15,

			PostAttackAnimation = "Enemy_Chronos_RushPostFire_Combo",
			PreAttackAnimation = "Enemy_Chronos_RushPreFire_Combo",
			MoveWithinRange = false,
		},
	},

	ChronosRushComboEnd =
	{
		InheritFrom = { "ChronosRush" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "Enemy_Chronos_RushPreFire_Combo",
			PreAttackDuration = 0.3,
			MoveWithinRange = false,
		},
	},

	ChronosRushCombo =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ChronosRushComboStart",
			"ChronosRushComboMiddle",
			"ChronosRushComboEnd",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	ChronosRushRipple =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosRushRipple", UseAttackerAngle = true, },
				{ ProjectileName = "ChronosRushRipple", UseAttackerAngle = true, },
				{ ProjectileName = "ChronosRushRipple", UseAttackerAngle = true, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" } },
				{ ProjectileName = "ChronosRushRipple", UseAttackerAngle = true, },
				{ ProjectileName = "ChronosRushRipple", UseAttackerAngle = true, },
			},
			AttackSlotInterval = 0.06,
			FireProjectileAtSelf = true,
			FireFromTarget = true,

			PreAttackDuration = 0.0,
		}
	},

	ChronosCrossRifts =
	{
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosRoomWeapons2" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRift",
			AttackSlots =
			{
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 0 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 30 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 60 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 90 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 120 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 150 } },
			},
			AttackSlotsPerTick = 2,

			FireProjectileAtTarget = true,
			FireFromTarget = true,
			UseTargetId = 645921,
			
			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackDuration = 0.83,
			PostAttackDurationMin = 6.0,
			PostAttackDurationMax = 12.0,

			AlwaysUseDumbFireThreadName = true,

			ChainedWeaponOptions = { "ChronosClockwise", "ChronosClockwise2", "ChronosRadialIn", "ChronosRadialIn2" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingRanged" },
			},
		},
	},

	ChronosCrossRifts2 =
	{
		InheritFrom = { "ChronosCrossRifts" },
		
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosRoomWeapons2" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			AttackSlotsPerTick = 6,

			PostAttackDurationMin = 6.0,
			PostAttackDurationMax = 12.0,

			ChainedWeaponOptions = { "ChronosRadialIn2", "ChronosClockwise2" },
		},
	},

	ChronosClockwise =
	{
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosRoomWeapons2" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},
		
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ AnchorAngleOffset = 0,  AIDataOverrides = { FireProjectileAngle = 60 }, PauseDuration = 3.0, ProjectileName = "ChronosClockArmPreview" },
			--	{ UseTargetPosition = true, AIDataOverrides = { FireProjectileAngle = 60 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 60 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 30 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 30 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 0 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 0 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -30 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -30 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -60 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -60 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -90 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -90 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -120 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -120 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -150 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -150 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -180 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -180 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -210 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -210 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -240 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -240 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -270 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -270 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArm" },
			},

			FireProjectileAtTarget = true,
			FireFromTarget = true,
			UseTargetId = 645921,
			
			FireProjectileTowardTarget = true,

			PreAttackDuration = 0.83,
			PostAttackDurationMin = 6.0,
			PostAttackDurationMax = 12.0,

			AlwaysUseDumbFireThreadName = true,

			ChainedWeaponOptions = { "ChronosCrossRifts", "ChronosCrossRifts2", "ChronosRadialIn", "ChronosRadialIn2" },
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Enemy Sounds/Screamer/EmoteAttacking" },
			},
		},
	},

	ChronosClockwise2 =
	{
		InheritFrom = { "ChronosClockwise" },
		
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosRoomWeapons2" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			DumbFireWeapons = { "ChronosClockwiseShort" },

			PostAttackDurationMin = 12.0,
			PostAttackDurationMax = 15.0,
		},
	},

	ChronosClockwiseShort =
	{
		InheritFrom = { "ChronosClockwise" },

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -30 }, PauseDuration = 3.0, ProjectileName = "ChronosClockArmShortPreview" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -30 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -30 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -60 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -60 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -90 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -90 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -120 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -120 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -150 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -150 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -180 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -180 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -210 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -210 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -240 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -240 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -270 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = -270 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 60 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 60 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 30 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 30 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 0 }, PauseDuration = 0.2, ProjectileName = "ChronosClockArm30Short" },
				{ AnchorAngleOffset = 0, AIDataOverrides = { FireProjectileAngle = 0 }, PauseDuration = 1.0, ProjectileName = "ChronosClockArmShort" },
			},

			ChainedWeaponOptions = { },
		},
	},

	ChronosRadialIn =
	{
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosRoomWeapons2" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRadialIn",

			UseTargetId = 645921,
			FireFromTarget = true,
			FireProjectileAtTarget = true,

			PreAttackDuration = 3.83,
			PostAttackDurationMin = 9.0,
			PostAttackDurationMax = 13.0,

			AlwaysUseDumbFireThreadName = true,

			ChainedWeaponOptions = { "ChronosCrossRifts", "ChronosCrossRifts2", "ChronosClockwise", "ChronosClockwise2" },
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Enemy Sounds/Screamer/EmoteAttacking" },
			},
		},
	},

	ChronosRadialIn2 =
	{
		InheritFrom = { "ChronosRadialIn" },
		
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosRoomWeapons2" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			
			NumProjectiles = 2,
			ProjectileInterval = 2.25,

			PostAttackDurationMin = 10.0,
			PostAttackDurationMax = 14.0,

			ChainedWeaponOptions = { "ChronosCrossRifts2", "ChronosClockwise2" },
		},
	},

	ChronosCastOrbit =
	{
		GenusName = "ChronosCastOrbit",
		Requirements = 
		{
			MinAttacksBetweenUse = 12,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileOptions = { "ChronosBoltOrbit", },--  "ChronosBoltOrbit2", "ChronosBoltOrbit3" },
			NumProjectiles = 12,
			ProjectileAngleInterval = 30,
			FireProjectileStartDelay = 0.7,

			PreAttackDuration = 0.83,
			FireDuration = 1.3,
			PostAttackDuration = 1.1,

			MoveToClosestId = { 626310, 713403, 713402, 713399, 713398, 713401, 713397, 713396, 713400, 713395, 713394, },
			AttackDistance = 150,
			MoveSuccessDistance = 35,
			PreAttackStop = false,
			StopMoveWithinRange = false,
			PreAttackEndStop = true,
			MoveWithinRangeTimeout = 5.0,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_CastFastPreFire",
			FireAnimation = "Enemy_Chronos_CastFastFire",
			PostAttackAnimation = "Enemy_Chronos_CastFastPostFire",

			ChainedWeapon = "ChronosRush",

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ChronosPreAttackVoiceLines,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingRanged" },
			},
		},
	},

	ChronosCastOrbit2 =
	{
		InheritFrom = { "ChronosCastOrbit" },
		GenusName = "ChronosCastOrbit",
		Requirements =
		{
			MinAttacksBetweenUse = 14,
		},
		AIData =
		{
			DeepInheritance = true,
			ProjectileOptions = "nil",
			AttackSlots =
			{
				{ ProjectileName = "ChronosBoltOrbit1" },
				{ ProjectileName = "ChronosBoltOrbit2" },
				{ ProjectileName = "ChronosBoltOrbit3" },
			},

			NumProjectiles = 9,
			ProjectileAngleInterval = 45,

			MoveToClosestId = "nil",
			MoveToId = 645921,
			UseTargetId = 645928,
			AttackDistance = 100,
			MoveSuccessDistance = 35,
			StopMoveWithinRange = true,

			PreAttackFx = "RadialNovaOrbitPreviewChronos",

			ChainedWeapon = nil,
			PostAttackDuration = 7.0,
		},
	},

	ChronosGrind =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 3,
			MinPlayerDistance = 275,
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosGrindVacuumWeak", PauseDuration = 1.0  },
				{ ProjectileName = "ChronosGrindWall", },
				{ ProjectileName = "ChronosGrindVacuum", PauseDuration = 5.0  },
				{ ProjectileName = "ChronosGrindWallForward" },

			},
			
			PreAttackDuration = 0.53,
			FireDuration = 0.0,
			PostAttackDuration = 2.1,

			MoveWithinRangeTimeout = 0.75,
			AttackDistance = 600,
			PreAttackStop = false,
			StopMoveWithinRange = false,
			PostAttackStop = true,
			MoveWithinRange = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_Chronos_GrindPreFire",
			FireAnimation = "Enemy_Chronos_GrindFire",
			PostAttackAnimation = "Enemy_Chronos_GrindPostFire",

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.25,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.05,

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ChronosPreAttackVoiceLines,
			},

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosBallFire" },
			},
		},
	},

	ChronosRadial =
	{
		Requirements = 
		{
			MinAttacksBetweenUse = 5,
		},

		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = "<=",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRadial",
			FireProjectileAtTarget = true,
			AttackSlots =
			{
				{ UseAngleBetween = true, OffsetDistance = 0, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, PauseDuration = 0.34 },

				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 45 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 90 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 135 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 180 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 225 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 270 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 315, PauseDuration = 0.34 },

				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 22.5 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 45 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 67.5 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 90 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 112.5 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 135 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 157.5 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 180 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 202.5 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 225 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 247.5 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 270 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 292.5 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 315 },
				{ UseAngleBetween = true, OffsetDistance = 1810, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 337.5 },
			},

			PreAttackDuration = 0.68,
			FireDuration = 1.21,
			PostAttackDuration = 2.1,

			AttackDistance = 9999,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_SwingRadialPreFire",
			--FireAnimation = "Enemy_Chronos_SwingRadialPreFire",
			PostAttackAnimation = "Enemy_Chronos_SwingRadialPostFire",

			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGrab" },
			},
		},
	},

	ChronosRadial2 =
	{
		Requirements = 
		{
			MinAttacksBetweenUse = 6,
		},

		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.45,
			AttackSlots =
			{
				{ AnchorAngleOffset = 0, ProjectileName = "ChronosCircle" },
				{ AnchorAngleOffset = 0, ProjectileName = "ChronosCircleInverted" },
			},

			PreAttackMultiFxAtTarget = { "ChronosInvertedCircleIn", "ChronosRadialCircleIn", },
			EndPreAttackFx = true,

			PreAttackDuration = 3.17,
			FireDuration = 0.78,
			PostAttackDuration = 1.5,

			MoveToId = 645921,

			FireProjectileAtTarget = true,
			FireFromTarget = true,
			UseTargetId = 645921,

			AttackDistance = 100,
			MoveSuccessDistance = 35,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmotePowerChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_UltimatePreFire",
			FireAnimation = "Enemy_Chronos_UltimateFire",
			PostAttackAnimation = "Enemy_Chronos_UltimatePostFire",

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ChronosPreAttackVoiceLines,
			},

			ExpireProjectilesOnPreAttackStart = { "ChronosRadialIn", "ChronosRadialIn2" },
			ExpireProjectilesOnFire = { "ChronosRadialIn", "ChronosRadialIn2" },

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmotePowerAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/CerberusGroundSlam" },
			},
		},
	},

	ChronosRadial3 =
	{
		Requirements = 
		{
			MinAttacksBetweenUse = 6,
		},

		AIData =
		{
			DeepInheritance = true,
			DoNotRepeatOnAttackFail = true,
			ForceUseIfReady = true,

			ProjectileName = "ChronosCircleInvertedSmall",
			FireProjectileAtTarget = true,
			FireFromTarget = true,
			FireProjectileStartDelay = 0.45,

			PreAttackFxAtTarget = "ChronosRadial3InvertedCircleIn",
			EndPreAttackFx = true,

			UseRandomTargetId = { 645922, 645923, 645924, 645925, 645926, 645927, 645928, 645929, 645930, 645931, 645932, 645933, },

			PreAttackDuration = 3.17,
			FireDuration = 0.78,
			PostAttackDuration = 1.5,

			SetDumbFireThreadWait = 5.5,

			AttackDistance = 9999,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmotePowerChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_UltimatePreFire",
			FireAnimation = "Enemy_Chronos_UltimateFire",
			PostAttackAnimation = "Enemy_Chronos_UltimatePostFire",

			PreAttackVoiceLines =
			{
				[1] = GlobalVoiceLines.ChronosPreAttackVoiceLines,
			},

			ExpireProjectilesOnPreAttackStart = { "ChronosRadialIn", "ChronosRadialIn2", "ChronosClockArm", "ChronosClockArm30", "ChronosClockArmShort", "ChronosClockArm30Short", "ChronosRift" },
			ExpireProjectilesOnFire = { "ChronosRadialIn", "ChronosRadialIn2", "ChronosClockArm", "ChronosClockArm30", "ChronosClockArmShort", "ChronosClockArm30Short", "ChronosRift" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmotePowerAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/CerberusGroundSlam" },
			},
		},
	},

	ChronosSwingRight =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosSwingRight", AIDataOverrides = { FireFromTarget = false, }, PauseDuration = 0.05 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 60, OffsetDistance = 850, OffsetScaleY = 0.5, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 45, OffsetDistance = 850, OffsetScaleY = 0.51, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 30, OffsetDistance = 850, OffsetScaleY = 0.52, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 15, OffsetDistance = 850, OffsetScaleY = 0.53, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 850, OffsetScaleY = 0.54, PauseDuration = 0.015, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" }  },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -15, OffsetDistance = 850, OffsetScaleY = 0.55, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -30, OffsetDistance = 850, OffsetScaleY = 0.56, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -45, OffsetDistance = 850, OffsetScaleY = 0.57, PauseDuration = 0.015 },
			},
			FireProjectileAtTarget = true,
			FireFromTarget = true,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.08,

			MoveWithinRange = true,
			AttackDistance = 500,
			AttackDistanceScaleY = 0.8,

			FireProjectileStartDelay = 0.13,
			PreAttackDuration = 1.34,
			FireDuration = 0.45,
			PostAttackDuration = 1.3,

			PreAttackEndShake = true,
			PreAttackFx = "ChronosScythePreAttackSparkleSwingRight",
			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_Chronos_SwingRightPreFire",
			FireAnimation = "Enemy_Chronos_SwingRightFire",
			PostAttackAnimation = "Enemy_Chronos_SwingRightPostFire",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingMelee" },
			},
		},

		FireScreenshake = { Distance = 3, Speed = 300, FalloffSpeed = 3000, Duration = 0.12, DynamicAngleOffset = 0 },
	},

	ChronosSwingLeft =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosSwingLeft", AIDataOverrides = { FireFromTarget = false }, PauseDuration = 0.05 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -72, OffsetDistance = 825, OffsetScaleY = 0.5, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -54, OffsetDistance = 825, OffsetScaleY = 0.51, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -36, OffsetDistance = 825, OffsetScaleY = 0.52, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -18, OffsetDistance = 825, OffsetScaleY = 0.53, PauseDuration = 0.015 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 825, OffsetScaleY = 0.54, PauseDuration = 0.015, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" } },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 18, OffsetDistance = 825, OffsetScaleY = 0.55, PauseDuration = 0.015  },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 36, OffsetDistance = 825, OffsetScaleY = 0.56, PauseDuration = 0.015  },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 54, OffsetDistance = 825, OffsetScaleY = 0.57, PauseDuration = 0.015 },
			},
			FireProjectileAtTarget = true,
			FireFromTarget = true,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.08,

			MoveWithinRange = true,
			AttackDistance = 500,
			AttackDistanceScaleY = 0.8,

			FireProjectileStartDelay = 0.13,
			PreAttackDuration = 1.96,
			FireDuration = 0.32,
			PostAttackDuration = 1.3,

			PreAttackEndShake = true,
			PreAttackFx = "ChronosScythePreAttackSparkleSwingLeft",
			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_Chronos_SwingLeftPreFireSlow",
			FireAnimation = "Enemy_Chronos_SwingLeftFire",
			PostAttackAnimation = "Enemy_Chronos_SwingLeftPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingMelee" },
			},
		},

		FireScreenshake = { Distance = 3, Speed = 300, FalloffSpeed = 3000, Duration = 0.12, DynamicAngleOffset = 0 },
	},

	ChronosSwingRightComboStart =
	{
		InheritFrom = { "ChronosSwingRight" },
		AIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 0.15,
			PostAttackAnimation = "Enemy_Chronos_SwingRightPostFire_Combo"
		},
	},

	ChronosSwingRightComboMiddle =
	{
		InheritFrom = { "ChronosSwingRight" },
		AIData =
		{
			DeepInheritance = true,

			WaitForAngleTowardTarget = true,
			PreAttackDuration = 0.45,
			MoveWithinRange = false,
			PreAttackAnimation = "Enemy_Chronos_SwingRightPreFireCombo",
			PostAttackDuration = 0.15,
			PostAttackAnimation = "Enemy_Chronos_SwingRightPostFire_Combo",
		},
	},

	ChronosSwingLeftComboEnd =
	{
		InheritFrom = { "ChronosSwingLeft" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "Enemy_Chronos_SwingLeftPreFire_Combo",
			PreAttackDuration = 0.45,
			MoveWithinRange = false,
		},
	},

	ChronosSwingLeftComboMiddle =
	{
		InheritFrom = { "ChronosSwingLeft" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackAnimation = "Enemy_Chronos_SwingLeftPreFire_Combo",
			PreAttackDuration = 0.45,
			PostAttackDuration = 0.15,
			PostAttackAnimation = "Enemy_Chronos_SwingLeftPostFire_Combo",
			MoveWithinRange = false,
		},
	},

	ChronosSwingCombo =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ChronosSwingRightComboStart",
			"ChronosSwingLeftComboEnd",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	ChronosMeleeComboSelector =
	{	
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		WeaponSelectorOnly = true,
		SelectorOptions =
		{
			"ChronosSwingCombo",
			"ChronosSwingRushCombo",
			"ChronosRushSwingCombo",
			"ChronosRushCombo",
		},
	},

	ChronosSwingRushCombo =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ChronosSwingRightComboStart",
			"ChronosSwingLeftComboMiddle",
			"ChronosRushComboEnd",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	ChronosRushSwingCombo =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ChronosRushComboStart",
			"ChronosSwingRightComboMiddle",
			"ChronosSwingLeftComboEnd",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	ChronosScytheThrow =
	{	
		--[[
		Requirements =
		{
			MinPlayerDistance = 550,
			MinAttacksBetweenUse = 1,
		},
		]]

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosScytheThrow",
			BarrelLength = 600,

			MoveWithinRange = true,
			AttackDistance = 870,

			FireProjectileStartDelay = 0.07,
			PreAttackDuration = 0.87,
			FireDuration = 0.44,
			PostAttackDuration = 2.0,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.34,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_ScytheThrowPreFire",
			FireAnimation = "Enemy_Chronos_ScytheThrowFire",
			PostAttackAnimation = "Enemy_Chronos_ScytheThrowPostFire",

			AngleTowardsTargetWhileFiring = true,
			PreAttackStop = true,

			PreAttackVoiceLines =
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.25,
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 20 },
				},

				{ Cue = "/VO/Chronos_0407", Text = "Catch!" },
				{ Cue = "/VO/Chronos_0408", Text = "Catch...!" },
				{ Cue = "/VO/Chronos_0409", Text = "Catch this...!", PlayFirst = true },
				{ Cue = "/VO/Chronos_0410", Text = "Catch, Granddaughter!" },
				{ Cue = "/VO/Chronos_0411", Text = "Here you are!" },
				{ Cue = "/VO/Chronos_0412", Text = "Here, I insist!" },
				{ Cue = "/VO/Chronos_0413", Text = "Here!" },
				{ Cue = "/VO/Chronos_0414", Text = "For you!" },
				{ Cue = "/VO/Chronos_0415", Text = "A little gift!" },
				{ Cue = "/VO/Chronos_0416", Text = "Cut to pieces!" },
				{ Cue = "/VO/Chronos_0417", Text = "Rend in twain!" },
				{ Cue = "/VO/Chronos_0418", Text = "Slice you to ribbons!" },
				{ Cue = "/VO/Chronos_0419", Text = "Shred to tiny bits!" },
				{ Cue = "/VO/Chronos_0420", Text = "I have something for you!" },
				{ Cue = "/VO/Chronos_0421", Text = "Fly, Hrodreptus!" },
				{ Cue = "/VO/Chronos_0422", Text = "Hrodreptus!" },
			},

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosScytheWhirlStart" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosScytheWhirl" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil