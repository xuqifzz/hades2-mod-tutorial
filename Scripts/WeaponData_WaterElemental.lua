WeaponSetData =
{
	WaterElementalBite =
	{
		Requirements =
		{
			-- MaxPlayerDistance = 300,
		},
		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,

			ProjectileName = "WaterElementalBite",
			FireSelfVelocity = 3100,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,
			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/WaterElemental/EmoteCharging",
			PreAttackAnimation = "Enemy_WaterElemental_BitePreFire",
			FireAnimation = "Enemy_WaterElemental_BiteFire",
			PostAttackAnimation = "Enemy_WaterElemental_BitePostFire",
			--PreAttackDuration = 0.88,
			PreAttackDuration = 0.66,
			PreAttackAnimationSpeed = 1.25,
			FireDuration = 0.23,
			PostAttackDuration = 0.8, -- animation is 0.7

			AttackDistance = 335,

			RetreatAfterAttack = true,
			RetreatTimeoutMin = 2,
			RetreatTimeoutMax = 3,
			RetreatBufferDistance = 1400,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterElemental/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusBite" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	WaterElementalBite_Elite =
	{
		InheritFrom = { "WaterElementalBite", },
		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.1,
			ChainedWeapon = "WaterElementalBiteChained_Elite",
		},
	},

	WaterElementalBiteChained_Elite =
	{
		InheritFrom = { "WaterElementalBite", },
		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.2,
			MoveWithinRange = false,
			WaitForAngleTowardTarget = false,
		},
	},

	WaterElementalBurst =
	{
		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,

			ProjectileName = "WaterElementalRanged",
			BarrelLength = 35,

			WaitForAngleTowardTarget = true,

			PreAttackAnimation = "Enemy_WaterElemental_BurstPreFire",
			FireAnimation = "Enemy_WaterElemental_BurstFire",
			PostAttackAnimation = "Enemy_WaterElemental_BurstPostFire",

			PreAttackSound = "/SFX/Enemy Sounds/WaterElemental/EmoteCharging",
			PreAttackDuration = 0.92,
			FireDuration = 0.63,
			PostAttackDuration = 0.75, -- animation is 0.55

			RequireProjectileLoS = true,
			AttackDistance = 750,

			AttackDistanceMin = 300,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 1200,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterElemental/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusBloodshotFire" },
			},
		},
	},

	WaterElementalBurst_Elite =
	{
		InheritFrom = { "WaterElementalBurst", },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "WaterElementalRanged_Elite",
		},
	},

	WaterElementalDuplicate =
	{
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = "<=",
				Value = 10,
			},
		},
		Requirements =
		{
			MinAttacksBetweenUse = 5,
			MaxUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,
			SkipSurroundAICount = true,

			PreAttackStop = true,

			NoProjectile = true,
			MoveWithinRange = false,
			DoNotRepeatOnAttackFail = true,

			FireSelfVelocity = 1000,
			FireSelfVelocityAngleOffset = 180,
			FireTicks = 3,
			FireInterval = 1.8,

			PreAttackSound = "/SFX/Enemy Sounds/WaterElemental/EmoteChargingSplit",
			PreAttackDuration = 1.8,
			FireDuration = 0.0,
			PostAttackDuration = 0.5,
			AttackDistance = 9999,

			SpawnBurstPerTick = true,
			SpawnerOptions = { "WaterElemental" },
			SpawnsPerBurst = 1,
			SpawnTowardSpawnPoints = true,
			SpawnAggroed = true,
			MaxActiveSpawns = 3,
			SpawnsSkipActivatePresentation = true,
			SpawnFx = "WaterUnitSurfaceSmall",

			PreAttackAnimation = "Enemy_WaterElemental_Duplicate",
			FireAnimation = "Enemy_WaterElemental_Duplicate",

			RetreatAfterAttack = true,
			RetreatBufferDistance = 1200,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterElemental/EmoteAttackingSplit" },
				{ Name = "/Leftovers/SFX/BallTossWyrm" },
			},
		},

	},

	WaterElementalDuplicate_Elite =
	{
		InheritFrom = { "WaterElementalDuplicate", },
		AIData =
		{
			DeepInheritance = true,
			SpawnerOptions = { "WaterElemental_Elite", },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil