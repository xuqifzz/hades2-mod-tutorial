WeaponSetData =
{
	-- Phase 1 break 75% remaining HP
	ChronosDefense =
	{
		AIData =
		{
			DeepInheritance = true,
			AlwaysForce = true,

			ProjectileName = "ChronosBoltDefense",
			NumProjectiles = 6,
			ProjectileAngleInterval = 60,
			FireTicks = 5,
			FireInterval = 0.25,
			FireProjectileStartDelay = 0.57,

			PreAttackDumbFireWeapons = { "ChronosCultistSpawn" },

			PreAttackDuration = 1.01,
			FireDuration = 0.72,
			PostAttackDuration = 1.25,

			PreMoveTeleport = true,
			TeleportToId = 626310,
			TargetId = 626385,
			AttackDistance = 9999,

			TeleportAnimation = "Enemy_Chronos_CastFastPostFire",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",

			--WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_DefenseIntro",
			--FireAnimation = "Enemy_Chronos_DefenseExplodePreFire",
			--PostAttackAnimation = "Enemy_Chronos_DefenseExplodePostFire",
			ForceUseIfReady = true,

			DoNotRepeatOnAttackFail = true,

			ExpireProjectilesOnFire = { "ChronosBoltOrbit1" }, -- so the circling projectiles don't overlap and blow out the projectile budget

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ChronosSummonVoiceLines" },
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
	ChronosDefense_Elite =
	{
		InheritFrom = { "ChronosDefense" },
		AIData =
		{
			DeepInheritance = true,
			PreAttackDumbFireWeapons = { "ChronosCultistSpawn_Elite" },
			ProjectileName = "ChronosBoltDefenseEM",
			PostAttackDuration = 0.0,
		},
	},

	-- Phase 1 break 25% remaining HP
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
	ChronosDefense3_SuperElite =
	{
		InheritFrom = { "ChronosDefense" },
		AIData =
		{
			DeepInheritance = true,

			PreAttackDumbFireWeapons = "nil",
			PreAttackRandomDumbFireWeapon = { "ChronosSuperEliteSpawn1", },
			ProjectileName = "ChronosBoltDefenseEM",
			PostAttackDuration = 0.0,
		},
	},

	-- Phase 2 break 50% remaining HP
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

			ExpireProjectilesOnFire = { "ChronosBoltOrbit1", "ChronosBoltOrbit2", "ChronosBoltOrbit3" }, -- so the circling projectiles don't overlap and blow out the projectile budget
		},
	},
	ChronosDefense2_Elite =
	{
		InheritFrom = { "ChronosDefense2" },
		AIData =
		{
			DeepInheritance = true,
			PreAttackDumbFireWeapons = { "ChronosTimeElementalSpawn_Elite" },
			ProjectileName = "ChronosBoltDefenseEM",
			PostAttackDuration = 0.0,
		},
	},

	-- Summons
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
	ChronosCultistSpawn_Elite =
	{
		InheritFrom = { "ChronosCultistSpawn" },
		AIData =
		{
			DeepInheritance = true,
			SpawnerOptions = { "SatyrCultist_Elite" },
		},
	},
	ChronosTimeElementalSpawn =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnBurstOnFire = true,
			SpawnerOptions = { "TimeElemental2" },
			SpawnOnIdsOrdered = { 645922, 645924, 645926, 645928, 645930, 645932, },
			SpawnsPerBurstMin = 6,
			SpawnsPerBurstMax = 6,
			MaxActiveSpawns = 6,
			SpawnRate = 2.5,
			SpawnAggroed = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},
	},
	ChronosTimeElementalSpawn_Elite =
	{
		InheritFrom = { "ChronosTimeElementalSpawn" },
		AIData =
		{
			DeepInheritance = true,
			SpawnerOptions = { "TimeElemental2_EM" },
			SpawnOnIdsOrdered = { 645922, 645923, 645924, 645925, 645926, 645927, 645928, 645929, 645930, 645931, 645932, 645933, },
			SpawnsPerBurstMin = 12,
			SpawnsPerBurstMax = 12,
			MaxActiveSpawns = 12,
			SpawnRate = 1.5,
		},
	},
	ChronosEliteSpawn1 =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnOnIdsOrdered = { 645917, 645920, },

			SpawnBurstOnFire = true,
			SpawnerOptions = { "SatyrLancer_Elite" },
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
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

			SpawnOnIdsOrdered = { 645917, 645920, },

			SpawnBurstOnFire = true,
			SpawnerOptions = { "GoldElemental_Elite" },
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
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

			SpawnOnIdsOrdered = { 645917, 645920, },

			SpawnBurstOnFire = true,
			SpawnerOptions = { "SatyrRatCatcher_Elite" },
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnRate = 0.02,

			AttackDistance = 9999,
			MoveWithinRange = false,
		},
	},
	ChronosSuperEliteSpawn1 =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			--SpawnOnIdsOrdered = { 645917, 645920, },
			SpawnOnIds = { 645916 },

			SpawnBurstOnFire = true,
			SpawnerOptions =
			{
				"Screamer2_SuperElite",
				"Treant2_SuperElite",

				"Octofish_SuperElite",

				"Vampire_SuperElite",
				"Lamia_SuperElite",

				"ClockworkHeavyMelee_SuperElite",
				"SatyrRatCatcher_SuperElite",
			},
			SpawnsPerBurstMin = 1,
			SpawnsPerBurstMax = 1,
			MaxActiveSpawns = 6,
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

			SpawnerOptions = { "BattleStandardChronos" },
			--RequiredSpawnPointType = "EnemyPointSupport",

			SpawnBurstOnFire = true,
			SpawnRate = 0.134,
			SpawnOnSpawnPoints = true,
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
				{ GlobalVoiceLines = "ChronosPreAttackVoiceLines" },
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
	ChronosWringerSpawns =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 15,
			MaxUses = 3,
		},

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = ">=",
					Value = 4,
				},
			}
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			AttackDistance = 9999,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointRanged",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

			SpawnBurstOnFire = true,
			RequiredSpawnPointType = "EnemyPointRanged",
			SpawnerOptions = { "Wringer" },
			SpawnsPerBurst = 6,
			SpawnRate = 0.1,
			MaxActiveSpawns = 8,
			SpawnOnSpawnPoints = true,
			SpawnNearPlayer = true,
			SpawnRadius = 1000,
			SpawnAggroed = true,

			PreAttackDuration = 1.4,
			FireDuration = 0.5,
			PostAttackDuration = 1.5,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_CastSlowPreFire",
			FireAnimation = "Enemy_Chronos_CastSlowFire",
			PostAttackAnimation = "Enemy_Chronos_CastSlowPostFire",

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ChronosPreAttackVoiceLines" },
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
	ChronosShadowSummon =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 15,
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			AttackDistance = 9999,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointRanged",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

			SpawnBurstOnFire = true,
			RequiredSpawnPointType = "EnemyPointRanged",
			SpawnerOptions = { "Chronos_EMShadow" },
			SpawnsPerBurst = 1,
			MaxActiveSpawns = 1,
			SpawnOnSpawnPoints = true,
			SpawnNearPlayer = true,
			SpawnRadius = 1000,
			SpawnAggroed = true,

			PreAttackDuration = 1.4,
			FireDuration = 0.5,
			PostAttackDuration = 1.5,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_CastSlowPreFire",
			FireAnimation = "Enemy_Chronos_CastSlowFire",
			PostAttackAnimation = "Enemy_Chronos_CastSlowPostFire",

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ChronosPreAttackVoiceLines" },
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
	ChronosShadowSummonUltimate =
	{
		InheritFrom = { "ChronosShadowSummon" },
		GenusName = "ChronosShadowSummon",
		Requirements =
		{
			MaxUses = 1,
		},

		AIData =
		{
			SpawnOverrides =
			{
				WeaponOptions = { "ChronosLungeMelee_Shadow", },
			},
			SpawnsPerBurst = 3,
			SpawnRate = 5,
			MaxActiveSpawns = 1,

			ChainedWeapon = "ChronosUltimateMeleeCombo_P3",
		},
	},

	-- Combos / Selectors
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
	ChronosScytheThrowDouble_P3 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosScytheThrow_P3", },
			{ WeaponName = "ChronosScytheThrow2_P3", },
		},
	},
	ChronosMeleeEMCombo =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosTelescopeSwingRight", DataOverrides = { PostAttackDuration = 0.0 } },
			{ WeaponName = "ChronosDownStrike", DataOverrides = { PreAttackEndShake = false, MoveWithinRange = false, PreAttackEndDuration = 0.0, PreAttackDuration = 0.0, } },
		},
	},
	ChronosNumberCombo =
	{
		WeaponComboOnly = true,
		Requirements =
		{
			MinAttacksBetweenUse = 35,
			MaxUses = 2,
		},

		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772109 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772110 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772112 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772111 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772113 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772114 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772115 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772116 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772117 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772118 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772119 } },
			{ WeaponName = "ChronosClockFaceCast", DataOverrides = { TeleportToId = 772120 } },
		},
	},
	ChronosEMComboSelector_P1 =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},
		WeaponSelectorOnly = true,
		SelectorOptions =
		{
			"ChronosEMTripleSwing",
			"ChronosEMRushThrow",
			"ChronosEMSwingRush",
		},
	},
	ChronosEMComboSelector_P2 =
	{
		WeaponSelectorOnly = true,
		SelectorOptions =
		{
			"ChronosEMSwingRush",
			"ChronosEMRushThrow",
			"ChronosMeleeEMCombo",
		},
	},
	ChronosEMTripleSwing =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},

		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosSwingRight", IgnoreRequirements = true, DataOverrides = { PostAttackDuration = 0.15, PostAttackAnimation = "Enemy_Chronos_SwingRightPostFire_Combo" } },
			{ WeaponName = "ChronosSwingLeft", IgnoreRequirements = true, DataOverrides = { WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.2, PreAttackAnimation = "Enemy_Chronos_SwingLeftPreFire_Combo", PreAttackDuration = 0.45, PostAttackDuration = 0.15, PostAttackAnimation = "Enemy_Chronos_SwingLeftPostFire_Combo", MoveWithinRange = false, } },
			{ WeaponName = "ChronosSwingRight", IgnoreRequirements = true, DataOverrides = { WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.2, PreAttackDuration = 0.45, MoveWithinRange = false, PreAttackAnimation = "Enemy_Chronos_SwingRightPreFireCombo", } },
		},
	},
	ChronosEMRushThrow =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},

		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosRush", IgnoreRequirements = true, DataOverrides = { PostAttackDuration = 0.15, PostAttackAnimation = "Enemy_Chronos_RushPostFire_Combo", } },
			{ WeaponName = "ChronosScytheThrow", IgnoreRequirements = true, DataOverrides = { WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.2, PreAttackDuration = 0.29, PreAttackEndMinWaitTime = "nil", PreAttackStartMinWaitTime = "nil", PreAttackAnimationSpeed = 3.0, PostAttackDuration = 0.8 } },
			{ WeaponName = "ChronosDownStrike", IgnoreRequirements = true, DataOverrides = { PreAttackDuration = 0.39, PreAttackAnimationSpeed = 3.0 } },
		},
	},
	ChronosEMSwingRush =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},

		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosSwingLeft", IgnoreRequirements = true, DataOverrides = { PostAttackDuration = 0.15, PostAttackAnimation = "Enemy_Chronos_SwingLeftPostFire_Combo", } },
			{ WeaponName = "ChronosRush", IgnoreRequirements = true, DataOverrides = { PreAttackDuration = 0.3, PreAttackEndMinWaitTime = "nil", PreAttackStartMinWaitTime = "nil", PostAttackDuration = 0.15, PostAttackAnimation = "Enemy_Chronos_RushPostFire_Combo", PreAttackAnimation = "Enemy_Chronos_RushPreFire_Combo", MoveWithinRange = false, } },
			{ WeaponName = "ChronosSwingRight", IgnoreRequirements = true, DataOverrides = { WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.2, PreAttackDuration = 0.45, MoveWithinRange = false, PreAttackAnimation = "Enemy_Chronos_SwingRightPreFireCombo", } },
		},
	},
	ChronosRushKnockback =
	{
		AIData =
		{
			DeepInheritance = true,

			DumbFireWakeUpDelay = 0.0,
			ProjectileName = "ChronosRushKnockback",
			FireTicks = 3,
			FireInterval = 0.1,

			NumProjectiles = 1,

			FireProjectileAtTarget = true,
			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 0,
			ResetTargetPerTick = true,
			PreAttackStop = false,

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/Leftovers/SFX/CaravanDamage" },
				--{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},
	},
	ChronosLungeMelee_P3 =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 5,
		},

		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosRushQuick_P3", IgnoreRequirements = true, },
			{ WeaponName = "ChronosSwingRight", IgnoreRequirements = true, DataOverrides = { PreAttackAnimation = "nil", PreAttackDuration = 0.0, WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.2, PreAttackEndShake = false, MoveWithinRange = false, AttackDistance = 9999, PostAttackDuration = 0.15, PostAttackAnimation = "Enemy_Chronos_SwingRightPostFire_Combo" } },
			{ WeaponName = "ChronosRushQuick_P3", IgnoreRequirements = true, DataOverrides = { PreMoveTeleport = false, MoveWithinRange = false, AttackDistance = 9999, PreAttackDuration = 0.3, PreAttackEndMinWaitTime = "nil", PreAttackStartMinWaitTime = "nil", PreAttackEndShake = false, } },
			{ WeaponName = "ChronosSwingLeft", IgnoreRequirements = true, DataOverrides = { PreAttackAnimation = "nil", PreAttackDuration = 0.0, WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.2, PreAttackEndShake = false, MoveWithinRange = false, AttackDistance = 9999, PostAttackDuration = 2.5, PostAttackMinWaitTime = 2.25 } },
		},
	},
	ChronosUltimateMeleeCombo_P3 =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosRushQuick_P3", IgnoreRequirements = true, },
			{
				WeaponName = "ChronosSwingRight",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreAttackAnimation = "nil",
					PreAttackDuration = 0.0,
					WaitForAngleTowardTarget = true,
					WaitForAngleTowardTargetTimeOut = 0.2,
					PreAttackEndShake = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PostAttackDuration = 0.15,
					PostAttackAnimation = "Enemy_Chronos_SwingRightPostFire_Combo"
				},
			},
			{
				WeaponName = "ChronosRushQuick_P3",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreMoveTeleport = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PreAttackDuration = 0.3,
					PreAttackEndMinWaitTime = "nil",
					PreAttackStartMinWaitTime = "nil",
					PreAttackEndShake = false,
				}
			},
			{
				WeaponName = "ChronosRushQuick_P3",
				IgnoreRequirements = true,
				GameStateRequirements = { ChanceToPlay = 0.5 },
				DataOverrides =
				{
					PreMoveTeleport = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PreAttackDuration = 0.3,
					PreAttackEndMinWaitTime = "nil",
					PreAttackStartMinWaitTime = "nil",
					PreAttackEndShake = false,
				}
			},
			{
				WeaponName = "ChronosSwingLeft",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreAttackAnimation = "nil",
					PreAttackDuration = 0.0,
					WaitForAngleTowardTarget = true,
					WaitForAngleTowardTargetTimeOut = 0.2,
					PreAttackEndShake = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PostAttackDuration = 0.15,
					PostAttackAnimation = "Enemy_Chronos_SwingLeftPostFire_Combo"
				}
			},
			{
				WeaponName = "ChronosRushQuick_P3",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreMoveTeleport = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PreAttackDuration = 0.3,
					PreAttackEndMinWaitTime = "nil",
					PreAttackStartMinWaitTime = "nil",
					PreAttackEndShake = false,
				}
			},
			{
				WeaponName = "ChronosRushQuick_P3",
				IgnoreRequirements = true,
				GameStateRequirements = { ChanceToPlay = 0.5 },
				DataOverrides =
				{
					PreMoveTeleport = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PreAttackDuration = 0.3,
					PreAttackEndMinWaitTime = "nil",
					PreAttackStartMinWaitTime = "nil",
					PreAttackEndShake = false,
				}
			},
			{
				WeaponName = "ChronosSwingRight",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreAttackAnimation = "nil",
					PreAttackDuration = 0.0,
					WaitForAngleTowardTarget = true,
					WaitForAngleTowardTargetTimeOut = 0.2,
					PreAttackEndShake = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PostAttackDuration = 0.15,
					PostAttackAnimation = "Enemy_Chronos_SwingRightPostFire_Combo"
				},
			},
			{
				WeaponName = "ChronosRushQuick_P3",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreMoveTeleport = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PreAttackDuration = 0.3,
					PreAttackEndMinWaitTime = "nil",
					PreAttackStartMinWaitTime = "nil",
					PreAttackEndShake = false,
				}
			},
			{
				WeaponName = "ChronosRushQuick_P3",
				IgnoreRequirements = true,
				GameStateRequirements = { ChanceToPlay = 0.5 },
				DataOverrides =
				{
					PreMoveTeleport = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PreAttackDuration = 0.3,
					PreAttackEndMinWaitTime = "nil",
					PreAttackStartMinWaitTime = "nil",
					PreAttackEndShake = false,
				}
			},
			{
				WeaponName = "ChronosSwingLeft",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreAttackAnimation = "nil",
					PreAttackDuration = 0.0,
					WaitForAngleTowardTarget = true,
					WaitForAngleTowardTargetTimeOut = 0.2,
					PreAttackEndShake = false,
					MoveWithinRange = false,
					AttackDistance = 9999,
					PostAttackMinWaitTime = 1.17,
				}
			},
		},
	},
	ChronosLungeMelee_Shadow =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosRushQuick_P3", IgnoreRequirements = true, },
			{ WeaponName = "ChronosSwingRight", IgnoreRequirements = true, DataOverrides = { PreAttackAnimation = "nil", PreAttackDuration = 0.0, WaitForAngleTowardTarget = true, WaitForAngleTowardTargetTimeOut = 0.2, PreAttackEndShake = false, MoveWithinRange = false, AttackDistance = 9999, PostAttackDuration = 0.15, PostAttackAnimation = "Enemy_Chronos_SwingRightPostFire_Combo" } },
			{ WeaponName = "ChronosShadowExit", },
		},
	},

	-- Melees
	ChronosRush =
	{
		Requirements =
		{
			UnitLoSDistanceTowardPlayer = 1100,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRush",
			DumbFireWeapons = { "ChronosRushRipple", "ChronosRushKnockback" },

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
				{ GlobalVoiceLines = "ChronosPreAttackVoiceLines" },
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
	ChronosRush_P3 =
	{
		InheritFrom = { "ChronosRush", },
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointRanged",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,
			PostAttackDuration = 2.5,
			PostAttackMinWaitTime = 2.25,

			DumbFireWeapons = { "ChronosRushRipple_P3" },
			FireSelfVelocity = 5000,
		},
	},
	ChronosRushQuick_P3 =
	{
		InheritFrom = { "ChronosRush", },
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointRanged",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

			FireDuration = 0.3,
			FireAnimation = "Enemy_Chronos_RushFire_Fast",
			PostAttackAnimation = "Enemy_Chronos_RushPostFire_Combo",

			AttackDistance = 1200,

			ProjectileName = "ChronosRush",
			DumbFireWeapons = { "ChronosRushKnockback" },

			PostAttackDuration = 0,

			FireSelfVelocity = 3000,
		},
	},
	ChronosRushRipple =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						AttackSlots =
						{
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 150, OffsetScaleY = 0.5, },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 150, OffsetScaleY = 0.5, PauseDuration = 0.06, },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 150, OffsetScaleY = 0.5, },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 150, OffsetScaleY = 0.5, PauseDuration = 0.06, },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 150, OffsetScaleY = 0.5, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" } },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 150, OffsetScaleY = 0.5, PauseDuration = 0.06, },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 150, OffsetScaleY = 0.5, },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 150, OffsetScaleY = 0.5, PauseDuration = 0.06, },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 150, OffsetScaleY = 0.5, },
							{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 150, OffsetScaleY = 0.5, PauseDuration = 0.06, },
						},
						AttackSlotInterval = 0,
						FireProjectileAtSelf = false,
					},
				},
			},

			ProjectileName = "ChronosRushRipple",

			AttackSlots =
			{
				{ UseAttackerAngle = true, },
				{ UseAttackerAngle = true, },
				{ UseAttackerAngle = true, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" } },
				{ UseAttackerAngle = true, },
				{ UseAttackerAngle = true, },
			},

			DumbFireWakeUpDelay = 0.0,
			AttackSlotInterval = 0.06,
			FireProjectileAtSelf = true,
			FireFromTarget = true,

			PreAttackDuration = 0.0,
		}
	},
	ChronosRushRipple_P3 =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 500, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 500, OffsetScaleY = 0.5, PauseDuration = 0.06, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 500, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 500, OffsetScaleY = 0.5, PauseDuration = 0.06, },
				--{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 500, OffsetScaleY = 0.5, },
				--{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 500, OffsetScaleY = 0.5, PauseDuration = 0.06, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" } },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 500, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 500, OffsetScaleY = 0.5, PauseDuration = 0.06, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = 90, AnchorOffset = 500, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 200, OffsetScaleY = 0.5, },
				{ UseAttackerAngle = true, OffsetFromAttacker = true, AnchorOffsetAngle = -90, AnchorOffset = 500, OffsetScaleY = 0.5, PauseDuration = 0.06, },
			},

			DumbFireWakeUpDelay = 0.0,
			ProjectileName = "ChronosRushRippleFast",
			FireFromTarget = true,
			PreAttackDuration = 0.0,
		}
	},
	ChronosSwingRight =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "ChronosSwingRight", AIDataOverrides = { FireFromTarget = false, }, PauseDuration = 0.05 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 60, OffsetDistance = 850, OffsetScaleY = 0.5, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 45, OffsetDistance = 300, OffsetScaleY = 0.51, },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 45, OffsetDistance = 850, OffsetScaleY = 0.51, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 30, OffsetDistance = 850, OffsetScaleY = 0.52, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 15, OffsetDistance = 850, OffsetScaleY = 0.53, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 300, OffsetScaleY = 0.54, },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 850, OffsetScaleY = 0.54, PauseDuration = 0.015, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" }  },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -15, OffsetDistance = 850, OffsetScaleY = 0.55, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -30, OffsetDistance = 850, OffsetScaleY = 0.56, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -45, OffsetDistance = 300, OffsetScaleY = 0.57, },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -45, OffsetDistance = 850, OffsetScaleY = 0.57, PauseDuration = 0.015 },
						},
					},
				},
			},

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
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.08,
			PostAttackStop = true,

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

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "ChronosSwingLeft", AIDataOverrides = { FireFromTarget = false }, PauseDuration = 0.05 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -72, OffsetDistance = 825, OffsetScaleY = 0.5, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -54, OffsetDistance = 300, OffsetScaleY = 0.51, },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -54, OffsetDistance = 825, OffsetScaleY = 0.51, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -36, OffsetDistance = 825, OffsetScaleY = 0.52, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -18, OffsetDistance = 825, OffsetScaleY = 0.53, PauseDuration = 0.015 },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 300, OffsetScaleY = 0.54, },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 825, OffsetScaleY = 0.54, PauseDuration = 0.015, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" } },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 18, OffsetDistance = 825, OffsetScaleY = 0.55, PauseDuration = 0.015  },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 36, OffsetDistance = 825, OffsetScaleY = 0.56, PauseDuration = 0.015  },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 54, OffsetDistance = 300, OffsetScaleY = 0.57, },
							{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 54, OffsetDistance = 825, OffsetScaleY = 0.57, PauseDuration = 0.015 },
						},
					},
				},
			},

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
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.08,
			PostAttackStop = true,

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
	ChronosTelescopeSwingRight =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosTelescopeSwingRight", AIDataOverrides = { FireFromTarget = false, }, PauseDuration = 0.05 },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 60, OffsetDistance = 850, OffsetScaleY = 0.5, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 45, OffsetDistance = 1700, OffsetScaleY = 0.51, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 45, OffsetDistance = 850, OffsetScaleY = 0.51, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 37.5, OffsetDistance = 1700, OffsetScaleY = 0.51, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 30, OffsetDistance = 850, OffsetScaleY = 0.52, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 30, OffsetDistance = 1700, OffsetScaleY = 0.52, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 22.5, OffsetDistance = 1700, OffsetScaleY = 0.52, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 15, OffsetDistance = 850, OffsetScaleY = 0.53, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 15, OffsetDistance = 1700, OffsetScaleY = 0.53, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 7.5, OffsetDistance = 1700, OffsetScaleY = 0.54,  PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 1700, OffsetScaleY = 0.54,  },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 850, OffsetScaleY = 0.54, PauseDuration = 0.0075, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" }  },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -7.5, OffsetDistance = 1700, OffsetScaleY = 0.55, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -15, OffsetDistance = 1700, OffsetScaleY = 0.55, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -15, OffsetDistance = 850, OffsetScaleY = 0.55, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -22.5, OffsetDistance = 1700, OffsetScaleY = 0.56, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -30, OffsetDistance = 1700, OffsetScaleY = 0.56, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -30, OffsetDistance = 850, OffsetScaleY = 0.56, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -37.5, OffsetDistance = 1700, OffsetScaleY = 0.57, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -45, OffsetDistance = 1700, OffsetScaleY = 0.57, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -45, OffsetDistance = 850, OffsetScaleY = 0.57, },
			},
			FireProjectileAtTarget = true,
			FireFromTarget = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.3,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.08,
			PostAttackStop = true,

			MoveWithinRange = true,
			AttackDistance = 1300,
			AttackDistanceScaleY = 0.8,

			FireProjectileStartDelay = 0.13,
			PreAttackDuration = 1.5,
			FireDuration = 0.56,
			PostAttackDuration = 1.22,

			PreAttackEndShake = true,
			PreAttackFx = "ChronosScythePreAttackSparkleSwingRight",
			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_Chronos_TelescopeSwing_Start",
			FireAnimation = "Enemy_Chronos_TelescopeSwing_Fire",
			PostAttackAnimation = "Enemy_Chronos_TelescopeSwing_End",

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
	ChronosTelescopeSwingRight_P3 =
	{
		InheritFrom = { "ChronosTelescopeSwingRight", },
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointRanged",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

			PreAttackDuration = 0.75,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.21,
			PreAttackAnimation = "Enemy_Chronos_TelescopeSwing_Start_Fast",
			PostAttackDuration = 1.75,
			PostAttackMinWaitTime = 1.55,

			PreAttackDumbFireWeapons = { "ChronosTelescopeSwingRightRipples_P3" },

			AttackSlots =
			{
				{ ProjectileName = "ChronosTelescopeSwingRight", AIDataOverrides = { FireFromTarget = false, }, PauseDuration = 0.05 },
			},
		},
	},
	ChronosTelescopeSwingRightRipples_P3 =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 60, OffsetDistance = 850, OffsetScaleY = 0.5, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 45, OffsetDistance = 1700, OffsetScaleY = 0.51, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 45, OffsetDistance = 850, OffsetScaleY = 0.51, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 37.5, OffsetDistance = 1700, OffsetScaleY = 0.51, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 30, OffsetDistance = 850, OffsetScaleY = 0.52, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 30, OffsetDistance = 1700, OffsetScaleY = 0.52, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 22.5, OffsetDistance = 1700, OffsetScaleY = 0.52, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 15, OffsetDistance = 850, OffsetScaleY = 0.53, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 15, OffsetDistance = 1700, OffsetScaleY = 0.53, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 7.5, OffsetDistance = 1700, OffsetScaleY = 0.54,  PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 1700, OffsetScaleY = 0.54,  },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = 0, OffsetDistance = 850, OffsetScaleY = 0.54, PauseDuration = 0.0075, AIDataOverrides = { FuseSound = "/SFX/Enemy Sounds/Alecto/AlectoRageGatherLoop" }  },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -7.5, OffsetDistance = 1700, OffsetScaleY = 0.55, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -15, OffsetDistance = 1700, OffsetScaleY = 0.55, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -15, OffsetDistance = 850, OffsetScaleY = 0.55, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -22.5, OffsetDistance = 1700, OffsetScaleY = 0.56, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -30, OffsetDistance = 1700, OffsetScaleY = 0.56, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -30, OffsetDistance = 850, OffsetScaleY = 0.56, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -37.5, OffsetDistance = 1700, OffsetScaleY = 0.57, PauseDuration = 0.0075, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -45, OffsetDistance = 1700, OffsetScaleY = 0.57, },
				{ ProjectileName = "ChronosRipple", UseAttackerAngle = true, OffsetFromAttacker = true, OffsetAngle = -45, OffsetDistance = 850, OffsetScaleY = 0.57, },
			},

			DumbFireWakeUpDelay = 0.2,
			PreAttackDuration = 0.0,
			FireDuration = 0,
			PostAttackDuration = 0,

			FireProjectileAtTarget = true,
			FireFromTarget = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingMelee" },
			},
		},
	},
	ChronosDownStrike =
	{
		Requirements =
		{
			MaxPlayerDistance = 1200,
			MaxConsecutiveUses = 2,
		},
		
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosScytheSlam", PauseDuration = 0.52 },
				{ ProjectileName = "ChronosScytheDrag", AIDataOverrides = { FireProjectileAngleRelative = 180 }, PauseDuration = 0.025  },
				{ ProjectileName = "ChronosRushRipple", OffsetDistance = 300, OffsetScaleY = 0.55, OffsetFromAttacker = true, UseAttackerAngle = true },
			},
			FireProjectileStartDelay = 0.23,

			CreateOwnTarget = true,
			TargetOffsetDistance = 320,
			TrackTargetDuringCharge = false,
			TrackTargetDuringFire = false,
			AngleTowardsTargetWhileFiring = false,
			PreAttackEndStop = true,
			PostAttackStop = true,

			MoveWithinRange = true,
			AttackDistance = 9999,
			AttackDistanceScaleY = 0.8,

			PreAttackDuration = 1.17,
			FireDuration = 0.65,
			PostAttackDuration = 1.22,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_Chronos_DownStrikePreFire",
			FireAnimation = "Enemy_Chronos_DownStrikeFire1",
			PostAttackAnimation = "Enemy_Chronos_DownStrikePostFire",

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
	ChronosDownStrike_P3 =
	{
		InheritFrom = { "ChronosDownStrike", },
		AIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.3,
			PreAttackAnimation = "Enemy_Chronos_DownStrikePreFire_Fast",
			PostAttackDuration = 1.75,
			PostAttackMinWaitTime = 1.55,

			PreAttackEndShake = false,

			AttackSlots =
			{
				{ ProjectileName = "ChronosScytheSlamLarge", PauseDuration = 0.52 },
				{ ProjectileName = "ChronosScytheDrag", AIDataOverrides = { FireProjectileAngleRelative = 180 }, PauseDuration = 0.025  },
				{ ProjectileName = "ChronosRushRipple", OffsetDistance = 300, OffsetScaleY = 0.55, OffsetFromAttacker = true, UseAttackerAngle = true },
			},
		},
	},

	-- Ranged
	ChronosGrind =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 12,
			MinPlayerDistance = 275,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ExpireProjectilesOnHitStun = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						AttackSlots =
						{
							{ ProjectileName = "ChronosGrindVacuumReverseWeak", },
							{ ProjectileName = "ChronosGrindVacuumWeak", PauseDuration = 1.0 },
							{ ProjectileName = "ChronosGrindWallReverse", },
							{ ProjectileName = "ChronosGrindWall", },
							{ ProjectileName = "ChronosGrindVacuumReverse", },
							{ ProjectileName = "ChronosGrindVacuum", PauseDuration = 4.0  },
							{ ProjectileName = "ChronosGrindWallForward", OffsetAngle = 180, },
							{ ProjectileName = "ChronosGrindWallForward", },
						},
					},
				},
			},

			AttackSlots =
			{
				{ ProjectileName = "ChronosGrindVacuumWeak", PauseDuration = 1.0  },
				{ ProjectileName = "ChronosGrindWall", },
				{ ProjectileName = "ChronosGrindVacuum", PauseDuration = 4.0  },
				{ ProjectileName = "ChronosGrindWallForward", },
			},
			
			PreAttackDuration = 0.53,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.02,
			FireDuration = 0.0,
			PostAttackDuration = 2.1,

			MoveWithinRangeTimeout = 0.75,
			AttackDistance = 600,
			StopMoveWithinRange = false,
			MoveWithinRange = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_Chronos_GrindPreFire",
			FireAnimation = "Enemy_Chronos_GrindFire",
			PostAttackAnimation = "Enemy_Chronos_GrindPostFire",

			PreAttackStop = false,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.25,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ChronosPreAttackVoiceLines" },
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
	ChronosGrind_P3 =
	{
		Requirements =
		{
			--MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ExpireProjectilesOnHitStun = true,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointRanged",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

			ProjectileName = "ChronosGrindVacuumStrong",
			
			PreAttackDuration = 0.53,
			FireDuration = 0.3,
			PostAttackDuration = 0,

			MoveWithinRangeTimeout = 0.75,
			AttackDistance = 1200,
			MoveWithinRange = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_Chronos_GrindPreFire",
			FireAnimation = "Enemy_Chronos_GrindFire",
			PostAttackAnimation = "Enemy_Chronos_GrindPostFire",

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.25,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ChronosPreAttackVoiceLines" },
			},

			ChainedWeaponOptions = { "ChronosDownStrike_P3", },

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
	ChronosScytheThrow =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosScytheThrow",
			BarrelLength = 600,

			MoveWithinRange = true,
			AttackDistance = 870,

			FireProjectileStartDelay = 0.07,
			PreAttackDuration = 0.87,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.3,
			FireDuration = 0.32,
			PostAttackDuration = 2.0,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.34,

			-- PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
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
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
						Comparison = ">=",
						Value = 0.2,
					},
				},
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
	},
	ChronosScytheThrow_P3 =
	{
		InheritFrom = { "ChronosScytheThrow", },
		AIData =
		{
			DeepInheritance = true,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointRanged",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

			PostAttackDuration = 0.0,

			ProjectileName = "ChronosScytheThrowMid",
		},
	},
	ChronosScytheThrow2_P3 =
	{
		InheritFrom = { "ChronosScytheThrow", },
		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackDuration = 0.0,
			PreAttackEndShake = false,
			PreAttackEndDuration = 0,

			PostAttackMinWaitTime = 1.8,

			AttackSlots =
			{
				{ ProjectileName = "ChronosScytheThrowClose", AIDataOverrides = { BarrelLength = 100, } },
				{ ProjectileName = "ChronosScytheThrowFar", },
			},
		},
	},

	-- Teleports
	ChronosDash =
	{
		AIData =
		{
			DeepInheritance = true,


			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						PostAttackDumbFireWeapons = { "ChronosDashRadialSmall" },
					},
				},
			},

			ProjectileName = "ChronosDashStasis",
			FireProjectileAtSelf = true,
			FireProjectileStartDelay = 0.7,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			StopBeforeFire = true,

			PostAttackEndTeleport = true,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportMinDistance = 660,
			TeleportMaxDistance = 5000,
			TeleportToSpawnPointType = "EnemyPoint",
		
			PreAttackDuration = 0.83,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.275,
			FireDuration = 0.7,
			PostAttackDuration = 0.0,
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.8,

			PreAttackDumbFireWeapons = { "ChronosDashRadial" },

			ChainedWeaponOptions = { "ChronosScytheThrow", "ChronosGrind" },

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
	},
	ChronosDashComboBreaker =
	{
		InheritFrom = { "ChronosDash" },
		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							PathTrue = { "MapState", "Flags", "ChronosStage2", },
						},
					},
					Data =
					{
						TeleportToSpawnPointType = "EnemyPointMelee",
					},
				},
			},
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
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosTock" },
			},
		},
	},

	ChronosSelfRadial =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosDashRadial", PauseDuration = 0.7 },
				{ ProjectileName = "ChronosStasisExtended", }
			},
			
			FireProjectileAtSelf = true,
			
			DumbFireWakeUpDelay = 2.0,

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
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosTock" },
			},
		},
	},

	ChronosDashRadialSmall =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRadial",
			FireProjectileAtTarget = true,

			AttackSlots =
			{
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 45 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 90 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 135 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 180 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 225 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 270 },
				{ UseAngleBetween = true, OffsetDistance = 930, OffsetScaleY = 0.48, OffsetFromAttacker = true, UseAttackerAngle = true, OffsetAngle = 315 },
			},

			PreAttackDuration = 0,
			FireDuration = 0,
			PostAttackDuration = 0,

			AttackDistance = 9999,

			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
		},
	},
	ChronosShadowExit =
	{
		Requirements =
		{
			RequireTotalAttacks = 1,
		},
		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			NoProjectile = true,
			StopBeforeFire = true,
		
			PreAttackDuration = 0.83,
			FireDuration = 0.3,
			PostAttackDuration = 0.0,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreTeleportClearAllEffects = true,

			PreAttackAnimation = "Enemy_Chronos_CastFastPreFire",
			FireAnimation = "Enemy_Chronos_CastFastFire",
			FireFx = "ChronosTeleportFxFront",

			FireAlpha = 0,
			PostAttackAlphaDuration = 0.3,
			PostAttackKillSelf = true,
			PostAttackKillSelfArgs = { SkipOnDeathFunction = true, Silent = true, SkipDestroyDelay = true, },
		},
	},

	-- Room weapons
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
	ChronosPassiveNumberSequence =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = "<",
								Value = 4,
							},
						},
					},
					Data =
					{
						ProjectileName = "nil",
						AttackSlots = {},
						ChainedWeaponOptions = "nil",
					},
				},
			},

			ProjectileName = "ChronosRadialOut",

			AttackSlots =
			{
				{ AIDataOverrides = { TargetId = 772109 }, },
				{ AIDataOverrides = { TargetId = 772110 }, },
				{ AIDataOverrides = { TargetId = 772112 }, },
				{ AIDataOverrides = { TargetId = 772111 }, },
				--{ AIDataOverrides = { TargetId = 772113 }, },
				--{ AIDataOverrides = { TargetId = 772114 }, },
				--{ AIDataOverrides = { TargetId = 772115 }, },
				--{ AIDataOverrides = { TargetId = 772116 }, },
				--{ AIDataOverrides = { TargetId = 772117 }, },
				--{ AIDataOverrides = { TargetId = 772118 }, },
				--{ AIDataOverrides = { TargetId = 772119 }, },
				--{ AIDataOverrides = { TargetId = 772120 }, },
			},
			AttackSlotInterval = 8.0,

			FireFromTarget = true,
			FireProjectileAtTarget = true,

			PreAttackDuration = 0.0,
			PostAttackDurationMin = 8.0,
			PostAttackDurationMax = 8.0,

			AlwaysUseDumbFireThreadName = true,

			ChainedWeaponOptions = { "ChronosPassiveNumberSequence2" },
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Enemy Sounds/Screamer/EmoteAttacking" },
			},
		},
	},
	ChronosPassiveNumberSequence2 =
	{
		InheritFrom = { "ChronosPassiveNumberSequence" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRift",
			AttackSlots =
			{
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772109, FireProjectileAngle = 0 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772109, FireProjectileAngle = 30 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772109, FireProjectileAngle = 60 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772109, FireProjectileAngle = 90 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772109, FireProjectileAngle = 120 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772109, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772110, FireProjectileAngle = 0 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772110, FireProjectileAngle = 30 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772110, FireProjectileAngle = 60 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772110, FireProjectileAngle = 90 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772110, FireProjectileAngle = 120 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772110, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772112, FireProjectileAngle = 0 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772112, FireProjectileAngle = 30 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772112, FireProjectileAngle = 60 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772112, FireProjectileAngle = 90 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772112, FireProjectileAngle = 120 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772112, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772111, FireProjectileAngle = 0 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772111, FireProjectileAngle = 30 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772111, FireProjectileAngle = 60 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772111, FireProjectileAngle = 90 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772111, FireProjectileAngle = 120 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772111, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772113, FireProjectileAngle = 0 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772113, FireProjectileAngle = 30 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772113, FireProjectileAngle = 60 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772113, FireProjectileAngle = 90 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772113, FireProjectileAngle = 120 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772113, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772114, FireProjectileAngle = 0 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772114, FireProjectileAngle = 30 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772114, FireProjectileAngle = 60 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772114, FireProjectileAngle = 90 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772114, FireProjectileAngle = 120 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772114, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772115, FireProjectileAngle = 0 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772115, FireProjectileAngle = 30 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772115, FireProjectileAngle = 60 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772115, FireProjectileAngle = 90 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772115, FireProjectileAngle = 120 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772115, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772116, FireProjectileAngle = 0 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772116, FireProjectileAngle = 30 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772116, FireProjectileAngle = 60 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772116, FireProjectileAngle = 90 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772116, FireProjectileAngle = 120 } },
				{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772116, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772117, FireProjectileAngle = 0 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772117, FireProjectileAngle = 30 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772117, FireProjectileAngle = 60 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772117, FireProjectileAngle = 90 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772117, FireProjectileAngle = 120 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772117, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772118, FireProjectileAngle = 0 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772118, FireProjectileAngle = 30 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772118, FireProjectileAngle = 60 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772118, FireProjectileAngle = 90 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772118, FireProjectileAngle = 120 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772118, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772119, FireProjectileAngle = 0 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772119, FireProjectileAngle = 30 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772119, FireProjectileAngle = 60 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772119, FireProjectileAngle = 90 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772119, FireProjectileAngle = 120 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772119, FireProjectileAngle = 150 }, PauseDuration = 8.0 },

				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772120, FireProjectileAngle = 0 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772120, FireProjectileAngle = 30 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772120, FireProjectileAngle = 60 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772120, FireProjectileAngle = 90 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772120, FireProjectileAngle = 120 } },
				--{ AnchorAngleOffset = 0, AIDataOverrides = { TargetId = 772120, FireProjectileAngle = 150 }, PauseDuration = 8.0 },
			},

			AttackSlotInterval = 0.0,

			ChainedWeaponOptions = { "ChronosPassiveNumberSequence3", },
		},
	},
	ChronosPassiveNumberSequence3 =
	{
		InheritFrom = { "ChronosPassiveNumberSequence" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosClockArm360",
			AttackSlots =
			{
				--{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772109 }, PauseDuration = 1.0 },
				--{ AIDataOverrides = { TargetId = 772109 }, PauseDuration = 8.0 },
				--{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772110 }, PauseDuration = 1.0 },
				--{ AIDataOverrides = { TargetId = 772110 }, PauseDuration = 8.0 },
				--{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772112 }, PauseDuration = 1.0 },
				--{ AIDataOverrides = { TargetId = 772112 }, PauseDuration = 8.0 },
				--{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772111 }, PauseDuration = 1.0 },
				--{ AIDataOverrides = { TargetId = 772111 }, PauseDuration = 8.0 },
				--{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772113 }, PauseDuration = 1.0 },
				--{ AIDataOverrides = { TargetId = 772113 }, PauseDuration = 8.0 },
				--{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772114 }, PauseDuration = 1.0 },
				--{ AIDataOverrides = { TargetId = 772114 }, PauseDuration = 8.0 },
				--{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772115 }, PauseDuration = 1.0 },
				--{ AIDataOverrides = { TargetId = 772115 }, PauseDuration = 8.0 },
				--{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772116 }, PauseDuration = 1.0 },
				--{ AIDataOverrides = { TargetId = 772116 }, PauseDuration = 8.0 },
				{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772117 }, PauseDuration = 1.0 },
				{ AIDataOverrides = { TargetId = 772117 }, PauseDuration = 8.0 },
				{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772118 }, PauseDuration = 1.0 },
				{ AIDataOverrides = { TargetId = 772118 }, PauseDuration = 8.0 },
				{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772119 }, PauseDuration = 1.0 },
				{ AIDataOverrides = { TargetId = 772119 }, PauseDuration = 8.0 },
				{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { TargetId = 772120 }, PauseDuration = 1.0 },
				{ AIDataOverrides = { TargetId = 772120 }, PauseDuration = 8.0 },
			},

			FireProjectileAngle = 90,
			AttackSlotInterval = 0.0,

			ChainedWeaponOptions = { "ChronosPassiveNumberSequence", },
		},
	},

	ChronosRadial2QuickClock =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosClockArm360Slow",
			AttackSlots =
			{
				{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { FireProjectileAngle = 45 }, },
				{ ProjectileName = "ChronosClockArm360Preview", AIDataOverrides = { FireProjectileAngle = 225 }, PauseDuration = 1.0 },
				{ AIDataOverrides = { FireProjectileAngle = 45 }, },
				{ AIDataOverrides = { FireProjectileAngle = 225 }, },
			},

			DumbFireWakeUpDelay = 0.5,
			FireProjectileAtSelf = true,
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

	-- Radials / AOE
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

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						ProjectileOptions = "nil",
						AttackSlots =
						{
							{ ProjectileName = "ChronosBoltOrbit1" },
							{ ProjectileName = "ChronosBoltOrbit2" },
						},
					},
				},
			},

			ProjectileOptions = { "ChronosBoltOrbit1", },--  "ChronosBoltOrbit2", "ChronosBoltOrbit3" },
			NumProjectiles = 12,
			ProjectileAngleInterval = 30,
			FireProjectileStartDelay = 0.7,

			PreAttackDuration = 0.83,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.275,
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
				{ GlobalVoiceLines = "ChronosPreAttackVoiceLines" },
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
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						PostAttackDuration = 1.1,
						ChainedWeaponOptions = { "ChronosTelescopeSwingRight", "ChronosGrind" },
					},
				},
			},
			AttackSlots =
			{
				{ ProjectileName = "ChronosBoltOrbit1" },
				{ ProjectileName = "ChronosBoltOrbit2" },
				{ ProjectileName = "ChronosBoltOrbit3" },
			},

			NumProjectiles = 9,
			ProjectileAngleInterval = 45,

			MoveToClosestId = "nil",

			PreMoveTeleport = true,
			TeleportToId = 645921,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

			UseTargetId = 645928,
			MoveWithinRange = false,

			PreAttackFx = "RadialNovaOrbitPreviewChronos",

			ChainedWeapon = nil,
			PostAttackDuration = 7.0,
		},
	},
	ChronosCastOrbitComboBreaker =
	{
		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 9,
			ProjectileAngleInterval = 45,
			FireProjectileStartDelay = 0.7,

			AttackSlots =
			{
				{ ProjectileName = "ChronosBoltOrbit1_Fast" },
				{ ProjectileName = "ChronosBoltOrbit2_Fast" },
				{ ProjectileName = "ChronosBoltOrbit3_Fast" },
			},

			PreAttackSetInvulnerable = true,
			PostAttackEndSetVulnerable = true,

			PreAttackDuration = 0.83,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.275,
			FireDuration = 1.3,
			PostAttackDuration = 2.45,

			AttackDistance = 9999,
			MoveWithinRange = false,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_CastFastPreFire",
			FireAnimation = "Enemy_Chronos_CastFastFire",
			PostAttackAnimation = "Enemy_Chronos_CastFastPostFire",
		},
	},
	ChronosRadial =
	{
		Requirements = 
		{
			MinAttacksBetweenUse = 8,
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
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.15,
			FireDuration = 1.21,
			PostAttackDuration = 0.95,

			AttackDistance = 9999,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_SwingRadialPreFire",
			--FireAnimation = "Enemy_Chronos_SwingRadialPreFire",
			PostAttackAnimation = "Enemy_Chronos_SwingRadialPostFire",

			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,

			ChainedWeaponOptions = { "ChronosScytheThrow", },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosTock" },
			},
		},
	},
	ChronosRadial_P3 =
	{
		InheritFrom = { "ChronosRadial" },
		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},
		GameStateRequirements = {},

		AIData =
		{
			DeepInheritance = true,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointRanged",
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

			ChainedWeaponOptions = {},
		},
	},
	ChronosRadialChained =
	{
		InheritFrom = { "ChronosRadial" },
		Requirements = {},
	},
	ChronosRadial2 =
	{
		Requirements = 
		{
			MinAttacksBetweenUse = 8,
			PreviousWeaponNot = { "ChronosRadial3", },
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						PreAttackDumbFireWeapons = { "ChronosRadial2QuickClock", },
						ExpireProjectilesOnPreAttackStart = { "ChronosRadialIn", "ChronosRadialIn2", "ChronosClockArm", "ChronosClockArm30", "ChronosClockArmShort", "ChronosClockArm30Short", "ChronosRift" },
						ExpireProjectilesOnFire = { "ChronosRadialIn", "ChronosRadialIn2", "ChronosClockArm", "ChronosClockArm30", "ChronosClockArmShort", "ChronosClockArm30Short", "ChronosRift" },
					},
				},
			},

			FireProjectileStartDelay = 0.45,
			AttackSlots =
			{
				{ AnchorAngleOffset = 0, ProjectileName = "ChronosCircle" },
				{ AnchorAngleOffset = 0, ProjectileName = "ChronosCircleInverted" },
			},

			PreAttackMultiFxAtTarget = { "ChronosInvertedCircleIn", "ChronosRadialCircleIn", },
			StopAnimationsOnHitStun = { "ChronosInvertedCircle", "ChronosRadialCircle", },
			EndPreAttackFx = true,

			PreAttackDuration = 3.17,
			FireDuration = 0.78,
			PostAttackDuration = 1.5,

			PreMoveTeleport = true,
			TeleportToId = 645921,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",
			PreTeleportWait = 0.3,
			PostTeleportWait = 0.3,

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
				{ GlobalVoiceLines = "ChronosUltimateVoiceLines" },
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
			MinAttacksBetweenUse = 8,
			PreviousWeaponNot = { "ChronosRadial2", },
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
			StopAnimationsOnHitStun = { "ChronosRadial3InvertedCircle", "ChronosRadial3InvertedCircleIn" },
			EndPreAttackFx = true,

			TargetFromGroup = "ClockFacePoints",
			TargetMinDistance = 800,
			TargetMinDistanceScaleY = 0.5,

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
				{ GlobalVoiceLines = "ChronosUltimateVoiceLines" },
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

	ChronosRadial3_EM =
	{
		Requirements = 
		{
			MaxUses = 1,
		},

		WeaponComboOnly = true,
		AIData =
		{
			ForceUseIfReady = true,
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{
				WeaponName = "ChronosRadial3",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreAttackDumbFireWeapons = { "ChronosRadial3Bubbles", "ChronosSelfRadial" },
					PostAttackDuration = 0.1,
				},
			},
			{
				WeaponName = "ChronosRadial3",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreAttackEndMinWaitTime = 0.5,
					PreAttackStartMinWaitTime = 2.67,
					FireDuration = 0.5,
					FireDurationMinWaitTime = 0.5,
					PostAttackDuration = 0.1,
				},
			},
			{
				WeaponName = "ChronosRadial3",
				IgnoreRequirements = true,
				DataOverrides =
				{
					PreAttackEndMinWaitTime = 0.5,
					PreAttackStartMinWaitTime = 2.67,
					FireDuration = 0.5,
					FireDurationMinWaitTime = 0.5,
				},
			},
		},
	},

	ChronosRadial3Bubbles =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosRadialExtended",
			FireProjectileAtTarget = true,

			UseTargetId = 645921,

			DumbFireWakeUpDelay = 3.0,

			PreAttackDuration = 0,
			FireDuration = 0,
			PostAttackDuration = 0,

			AttackDistance = 9999,
		},
	},

	ChronosUltimate =
	{
		AIData =
		{
			DeepInheritance = true,


			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 4,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions = { "ChronosTelescopeSwingRight", "ChronosRush", },
					},
				},
			},

			NoProjectile = true,

			PreAttackDuration = 1.40,
			FireDuration = 0.25,
			PostAttackDuration = 1.35,

			FireFunctionName = "ChronosTimeSlow",
			TimeSlowDuration = 7,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/ChronosPreDash",
			PreAttackAnimation = "Enemy_Chronos_CastSlowPreFire",
			FireAnimation = "Enemy_Chronos_CastSlowFire",
			--PostAttackAnimation = "Enemy_Chronos_CastSlowPostFire",

			AttackDistance = 9999,

			ChainedWeaponOptions = { "ChronosRadialChained","ChronosRadial2", },

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "ChronosUltimateVoiceLines" },
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
	ChronosUltimate_P3 =
	{
		InheritFrom = { "ChronosUltimate" },

		Requirements =
		{
			MinAttacksBetweenUse = 24,
			MaxUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ConditionalData = {},
			PostAttackDuration = 1.0,
			ChainedWeaponOptions = { "ChronosTelescopeSwingRight_P3", },
		},
	},
	ChronosClockFaceCast =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosClockArmBolt",

			PreMoveTeleport = true,
			MoveWithinRange = false,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "ChronosTeleportFxFront",
			TeleportEndFx = "ChronosTeleportFxFront",

			PreAttackFx = "ChronosCastLineAimLine",
			EndPreAttackFx = true,

			PreAttackDuration = 0.75,
			FireDuration = 0.1,
			PostAttackDuration = 0.0,

			AttackDistance = 9999,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_SwingRadialPreFire_Slow",
			--FireAnimation = "Enemy_Chronos_SwingRadialPreFire",
			PostAttackAnimation = "Enemy_Chronos_SwingRadialPostFire",

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = false,
			PreAttackEndStop = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosTock" },
			},
		},
	},

	-- Typhon Weapons
	ChronosGrind_Assist =
	{
		InheritFrom = { "ChronosGrind" },

		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosLevel2" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData = {},

			ChainedWeapon = "ChronosTeleportOut",

			MoveWithinRange = false,
			AttackDistance = 9999,
			PostAttackDuration = 1.0,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointSupport",
			TeleportMaxDistance = 9999,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			PostTeleportAngleTowardTarget = true,
		}
	},
	ChronosTelescopeSwingRight_Assist =
	{
		InheritFrom = { "ChronosTelescopeSwingRight" },

		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosLevel3" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ChainedWeapon = "ChronosTeleportOut",

			MoveWithinRange = false,
			AttackDistance = 9999,
			PostAttackDuration = 0.5,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointSupport",
			TeleportMaxDistance = 9999,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			PostTeleportAngleTowardTarget = true,
		},
	},
	ChronosScytheThrow_Assist =
	{
		InheritFrom = { "ChronosScytheThrow" },

		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ChainedWeapon = "ChronosTeleportOut",

			ProjectileName = "ChronosScytheThrowLarge",

			MoveWithinRange = false,
			AttackDistance = 9999,
			PostAttackDuration = 1.0,

			PreMoveTeleport = true,
			TeleportToSpawnPointType = "EnemyPointSupport",
			TeleportMaxDistance = 9999,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			PostTeleportAngleTowardTarget = true,
		},
	},
	ChronosCastOrbit_Assist =
	{
		InheritFrom = { "ChronosCastOrbit" },

		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosLevel2" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData = {},

			MoveToClosestId = "nil",
			PreMoveTeleport = true,
			TeleportToId = 779867,
			TeleportMaxDistance = 9999,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			PostTeleportAngleTowardTarget = true,

			MoveWithinRange = false,

			ChainedWeapon = "ChronosRush_Assist",
		},
	},
	ChronosRush_Assist =
	{
		InheritFrom = { "ChronosRush" },
		Requirements = {},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.32,

			AttackDistance = 9999,
			MoveWithinRange = false,
			RequireUnitLoS = false,

			PostAttackDuration = 1.0,

			ChainedWeapon = "ChronosTeleportOut",
		},
	},
	ChronosTeleport_CurseAssist =
	{
		Requirements =
		{
			MaxUses = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			PreMoveTeleport = true,
			TeleportToId = 779867,
			TeleportMaxDistance = 9999,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			PostTeleportAngleTowardTarget = true,

			MoveWithinRange = false,
			NoProjectile = true,

			ChainedWeaponOptions = { "ChronosOrbit1_CurseAssist", "ChronosOrbit2_CurseAssist", "ChronosOrbit3_CurseAssist", "ChronosOrbit4_CurseAssist", }
		},
	},
	ChronosOrbit1_CurseAssist =
	{

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosBoltOrbit1_Curse",

			ProjectileStartAngleOffset = 180,
			ProjectileAngleInterval = 30,
			NumProjectiles = 3,

			FireProjectileStartDelay = 0.7,

			PreAttackDuration = 0.83,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.275,
			FireDuration = 1.3,
			PostAttackDuration = 1.5,

			AttackDistance = 9999,
			MoveWithinRange = false,
			PreAttackEndShake = true,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/Chronos/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Chronos_CastFastPreFire",
			FireAnimation = "Enemy_Chronos_CastFastFire",
			PostAttackAnimation = "Enemy_Chronos_CastFastPostFire",

			ChainedWeaponOptions = { "ChronosOrbit2_CurseAssist", "ChronosOrbit3_CurseAssist", "ChronosOrbit4_CurseAssist", }
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteAttackingRanged" },
			},
		},
	},
	ChronosOrbit2_CurseAssist =
	{
		InheritFrom = { "ChronosOrbit1_CurseAssist" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosBoltOrbit2Reverse_Curse",
			ProjectileAngleInterval = 20,
			NumProjectiles = 4,

			ChainedWeaponOptions = { "ChronosOrbit1_CurseAssist", "ChronosOrbit3_CurseAssist", "ChronosOrbit4_CurseAssist", }
		},
	},
	ChronosOrbit3_CurseAssist =
	{
		InheritFrom = { "ChronosOrbit1_CurseAssist" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChronosBoltOrbit3_Curse",
			ProjectileAngleInterval = 20,
			NumProjectiles = 5,

			ChainedWeaponOptions = { "ChronosOrbit1_CurseAssist", "ChronosOrbit2_CurseAssist", "ChronosOrbit4_CurseAssist", }
		},
	},
	ChronosOrbit4_CurseAssist =
	{
		InheritFrom = { "ChronosOrbit1_CurseAssist" },

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ChronosPolymorph" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "EncountersCompletedCache", "BossTyphonHead02" },
				Comparison = ">=",
				Value = 2,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ChronosBoltOrbit1Reverse_Curse", AIDataOverrides = { NumProjectiles = 2, ProjectileAngleInterval = 30, }, },
				{ ProjectileName = "ChronosBoltOrbit2_Curse", AIDataOverrides = { NumProjectiles = 3, ProjectileAngleInterval = 20, }, },
				{ ProjectileName = "ChronosBoltOrbit3Reverse_Curse", AIDataOverrides = { NumProjectiles = 4, ProjectileAngleInterval = 20, }, },
			},

			PostAttackDuration = 4.5,

			ChainedWeaponOptions = { "ChronosOrbit1_CurseAssist", "ChronosOrbit2_CurseAssist", "ChronosOrbit3_CurseAssist", }
		},
	},

	ChronosBannerSummon_Assist =
	{
		InheritFrom = { "ChronosBannerSummon" },

		Requirements = {},

		AIData =
		{
			DeepInheritance = true,

			PreMoveTeleport = true,
			TeleportToId = 779867,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "nil",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			PostTeleportAngleTowardTarget = true,

			SpawnOnIds = { 793230, 793229, 793227, 793228, },

			ChainedWeapon = "ChronosTeleportOut",
		}
	},
	ChronosRadial2_Assist =
	{
		InheritFrom = { "ChronosRadial2" },
		Requirements = {},

		AIData =
		{
			DeepInheritance = true,

			ConditionalData = {},

			PreMoveTeleport = true,
			TeleportToId = 779867,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "nil",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			PostTeleportAngleTowardTarget = true,

			UseTargetId = 779867,

			ChainedWeapon = "ChronosTeleportOut",
		},
	},
	ChronosRadial3_Assist =
	{
		InheritFrom = { "ChronosRadial3" },
		Requirements = {},

		AIData =
		{
			DeepInheritance = true,

			PreMoveTeleport = true,
			TeleportToId = 779867,
			TeleportationInterval = 0,
			TeleportAnimation = "Enemy_Chronos_TeleportDashIn",
			TeleportStartFx = "nil",
			TeleportEndFx = "ChronosTeleportFxFront",
			TeleportAlpha = 1,
			PreTeleportWait = 0.0,
			MidTeleportWait = 1.1,
			PostTeleportWait = 0.2,
			PostTeleportAngleTowardTarget = true,

			TargetFromGroup = "nil",
			UseRandomTargetId = { 800616, 800617, 800618, 800619, 800620, 800621 },
			
			ChainedWeapon = "ChronosTeleportOut",
		},
	},

	ChronosEggPhaseCombo1 =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosRadial2_Assist", },
			{ WeaponName = "ChronosBannerSummon_Assist", },
		},
	},
	ChronosEggPhaseCombo2 =
	{
		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "ChronosRadial3_Assist", },
			{ WeaponName = "ChronosBannerSummon_Assist", },
		},
	},
	ChronosTeleportOut =
	{
		AIData =
		{
			DeepInheritance = true,

			ExpireProjectilesOnPreAttackStart = { "ChronosBoltOrbit1" },

			MoveWithinRange = false,
			NoProjectile = true,

			FireFx = "ChronosTeleportFxFront",
			PreAttackAnimation = "Enemy_Chronos_TeleportDashOut",
			PreAttackDuration = 0.3,
			FireDuration = 0.4,
			PostAttackDurationMin = 3.0,
			PostAttackDurationMax = 7.0,
			PostAttackAlpha = 0,
			PostAttackAlphaDuration = 0.1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Chronos/EmoteEvading" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosDashStraight" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil