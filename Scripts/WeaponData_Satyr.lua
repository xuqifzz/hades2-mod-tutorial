WeaponSetData =
{
	SatyrCombo01 =
	{

		WeaponCombo =
		{
			"SatyrMeleeCombo01",
			"SatyrMeleeCombo01",
			"SatyrRetreatDash",
			"SatyrVolley01",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 325,
		},
	},

	SatyrMeleeCombo01 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrCommandoKick",
			FireSelfVelocity = 500,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,

			PreAttackDuration = 0.4,
			FireDuration = 0.1,
			PostAttackDuration = 0.0,
			PreAttackEndShake = true,

			FireFx = "EnemyHeavySlashWretchAssassin",
			FireFxOffset = 300,

			MoveWithinRange = false,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrMeleeCombo02 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrCommandoKick",
			FireSelfVelocity = 650,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,

			PreAttackDuration = 0.1,
			FireDuration = 0.1,
			PostAttackDuration = 0.0,
			PreAttackEndShake = true,

			FireFx = "EnemyHeavySlashWretchAssassin",
			FireFxOffset = 300,

			MoveWithinRange = false,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrRetreatDash =
	{

		AIData =
		{
			DeepInheritance = true,

			CreateOwnTarget = true,
			TargetOffsetDistance = 300,
			TargetAngleOptions = { 0 },

			FireSelfVelocity = 2000,

			MoveWithinRange = false,
			NoProjectile = true,
			WaitForAngleTowardTarget = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

      		FireFx = "ShadeTeleportFlare"
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Exalted/EmoteEvading" },
			},
		},
	},

	SatyrVolley01 =
	{

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChariotRanged",
			FireTicks = 3,
			Spread = 5,
			FireInterval = 0.35,
			BarrelLength = 55,
			FireProjectileTowardTarget = true,

			PreAttackStartWait = 0.1,
			PreAttackDuration = 0.8,
			FireDuration = 0.3,
			PostAttackDuration = 0.8,

			MoveWithinRange = false,
			RetreatBufferDistance = 1500,
			RetreatBeforeAttack = true,
			RetreatTimeout = 0.5,
			RetreatBufferDistance = 1500,

			PreAttackAnimation = "Enemy_MaleGrey_HidingFace",
			FireAnimation = "Enemy_MaleGrey_CastForward",
		},
	},

	SatyrCrossbowShieldedBolt =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrCrossbowBolt",
			BarrelLength = 55,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.15,
			StopBeforeFire = true,

			PreAttackDurationMin = 1.5,
			PreAttackDurationMax = 3.8,
			FireDuration = 0.3,
			PostAttackDuration = 1.4,

			PreAttackFx = "SatyrCrossbowAimLine",
			EndPreAttackFx = true,
			
			PreAttackSound = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteCharging",
			PreAttackAnimation = "Enemy_SatyrCB_ShieldedBoltPreFire",
			FireAnimation = "Enemy_SatyrCB_ShieldedBoltFire",
			PostAttackAnimation = "Enemy_SatyrCB_ShieldedBoltPostFire",

			AttackDistance = 900,
			RequireProjectileLoS = true,
			LoSBuffer = 100,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SatyrCrossbowShieldRush =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrShieldRush",
			FireSelfVelocity = 2300,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,
			StopBeforeFire = true,

			PreAttackFx = "SatyrCrossbowShieldRushPreAttackFx",
			PreAttackDuration = 1.0,
			FireDuration = 0.5,
			PostAttackDuration = 0.9,

			AttackDistance = 600,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			-- FireFx = "EnemyHeavySlash",
			FireFxOffset = 300,
			PreAttackSound = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_SatyrCB_ShieldRushPreFire",
			FireAnimation = "Enemy_SatyrCB_ShieldRushFire",
			PostAttackAnimation = "Enemy_SatyrCB_ShieldRushPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteAttackingMelee" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrCrossbowFadeBolt =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
			MaxPlayerDistance = 550,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "SatyrCrossbowHomingBolt",
			--BarrelLength = 55,

			NumProjectiles = 3,			
			ProjectileAngleInterval = 55,
			--ProjectileInterval = 0.3,
			--Spread = 30,

			FireSelfVelocity = 1500,
			FireSelfVelocityAngleOffset = 180,

			AttackDistance = 9999,
			MoveWithinRange = false,
			WaitForAngleTowardTarget = true,

			PreAttackDuration = 0.6,
			FireDuration = 0.3,
			PostAttackDuration = 0.9,

			PreAttackEndShake = true,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,
			AngleTowardsTargetWhileFiring = true,

			PreAttackSound = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteCharging",
			PreAttackAnimation = "Enemy_SatyrCB_FadeBoltPreFire",
			FireAnimation = "Enemy_SatyrCB_FadeBoltFire",
			PostAttackAnimation = "Enemy_SatyrCB_FadeBoltPostFire",

      		FireFx = "ZombieAssassinDashFx"
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusBowFire" },
			},
		},
	},

	SatyrRatCatcherSummon =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 2,
			MaxActiveSpawns = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			PreAttackStop = true,

			AttackDistance = 99999,
			MoveWithinRange = false,

			PreAttackSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteSummoning",
			PreAttackFx = "EnemyChargeFxIn_SatyrRatCatcher_Summon",
			PreAttackAnimation = "Enemy_SatyrRatCatcher_SummonPreFire",
			FireAnimation = "Enemy_SatyrRatCatcher_SummonFire",
			PostAttackAnimation = "Enemy_SatyrRatCatcher_SummonPostFire",

			PreAttackDuration = 1.0,
			FireDuration = 1.32,
			PostAttackDuration = 1.0,

			SpawnBurstOnFire = true,
			SpawnBurstDelay = 1.0,
			SpawnRate = 0.25,
			SpawnOnSpawnPoints = true,
			SpawnRadius = 400,
			SpawnRadiusMin = 100,
			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 5,
			MaxActiveSpawns = 5,
			SpawnerOptions = { "Crawler" },
			SpawnAggroed = true,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	SatyrRatCatcherSummon_Elite =
	{
		InheritFrom = { "SatyrRatCatcherSummon" },

		AIData =
		{
			DeepInheritance = true,
			SpawnerOptions = { "Crawler_Elite" },
		},

	},

	SatyrRatCatcherSummon_Miniboss =
	{
		InheritFrom = { "SatyrRatCatcherSummon" },

		AIData =
		{
			DeepInheritance = true,
			SpawnerOptions = { "Crawler_Elite" },
			SpawnsPerBurstMin = 12,
			SpawnsPerBurstMax = 12,
			MaxActiveSpawns = 24,
			SpawnBurstDelay = 0.5,
			SpawnRate = 0.12,
			SpawnRadius = 750,

			PreAttackSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteSummoning",
		},

	},

	SatyrRatCatcherCast =
	{
		Requirements =
		{
			MinPlayerDistance = 430,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrCast",
			BarrelLength = 300,
			FireProjectileStartDelay = 0.29,

			PreAttackFx = "EnemyChargeFxIn_SatyrRatCatcher",
			EndPreAttackFx = true,

			PreAttackEndShake = true,
			PreAttackDuration = 1.17,
			FireDuration = 0.3,
			PostAttackDurationMin = 1.0,
			PostAttackDurationMax = 2.0,

			RetreatAfterAttack = true,
			RetreatTimeoutMin = 3,
			RetreatTimeoutMax = 4,
			RetreatBufferDistance = 800,
			
			PreAttackSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteCharging",
			PreAttackAnimation = "Enemy_SatyrRatCatcher_CastPreFire",
			FireAnimation = "Enemy_SatyrRatCatcher_CastFire",
			PostAttackAnimation = "Enemy_SatyrRatCatcher_CastPostFire",

			AttackDistance = 710,
			AttackDistanceScaleY = 0.8,
			RequireProjectileLoS = true,
			LoSBuffer = 100,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Brimstone/CrystalBeamFireStart" },
			},
		},
	},

	SatyrRatCatcherCast_Elite =
	{
		InheritFrom = { "SatyrRatCatcherCast" },

		PostAttackDurationMin = 3.0,
		PostAttackDurationMax = 3.5,

		AIData =
		{
			DeepInheritance = true,
			NumProjectiles = 2,
			ProjectileStartAngleOffsetMin = -20,
			ProjectileStartAngleOffsetMax = -20,
			ProjectileAngleInterval = 40,
		},
	},

	SatyrRatCatcherCast_Miniboss =
	{
		InheritFrom = { "SatyrRatCatcherCast" },

		Requirements =
		{
			MinPlayerDistance = 200,
		},

		PostAttackDurationMin = 0.8,
		PostAttackDurationMax = 1.2,

		AIData =
		{
			DeepInheritance = true,
			NumProjectiles = 3,
			ProjectileAngleInterval = 40,
			AttackDistance = 800,
			AttackDistanceScaleY = 0.7,

			PreAttackSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteCharging",
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Brimstone/CrystalBeamFireStart" },
			},
		},
	},

	SatyrRatCatcherMelee =
	{
		Requirements =
		{
			MaxPlayerDistance = 430,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrRatCatcherMelee",
			FireProjectileAtSelf = true,
			FireSelfVelocity = 1550, 

			PreAttackFx = "SatyrRatCatcherMeleeChargeFx",
			PreAttackDuration = 1.4,
			FireDuration = 0.25,
			PostAttackDuration = 1.1,
			FireProjectileStartDelay = 0.25,

			AttackDistance = 550,
			AttackDistanceScaleY = 0.80,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			WaitForAngleTowardTarget = true,

			RetreatAfterAttack = true,
			RetreatTimeoutMin = 2,
			RetreatTimeoutMax = 3,
			RetreatBufferDistance = 600,

			PreAttackAnimation = "Enemy_SatyrRatCatcher_MeleePreFire",
			FireAnimation = "Enemy_SatyrRatCatcher_MeleeFire",
			PostAttackAnimation = "Enemy_SatyrRatCatcher_MeleePostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	SatyrRatCatcherMeleeCultist =
	{

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrRatCatcherMelee",
			FireProjectileAtSelf = true,
			FireSelfVelocity = 1400, 

			PreAttackFx = "SatyrRatCatcherMeleeChargeFx",
			PreAttackDuration = 1.4,
			FireDuration = 0.25,
			PostAttackDuration = 1.1,
			FireProjectileStartDelay = 0.25,

			AttackDistance = 600,
			AttackDistanceScaleY = 0.80,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			WaitForAngleTowardTarget = true,

			PreAttackAnimation = "Enemy_SatyrRatCatcher_MeleePreFire",
			FireAnimation = "Enemy_SatyrRatCatcher_MeleeFire",
			PostAttackAnimation = "Enemy_SatyrRatCatcher_MeleePostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	SatyrRatCatcherMelee_Miniboss =
	{
		InheritFrom = { "SatyrRatCatcherMelee" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "SatyrRatCatcherMelee_Miniboss",
			FireSelfVelocity = "nil",
			FireProjectileStartDelay = 0.1,

			AttackDistance = 300,
			DoNotRepeatOnAttackFail = true,
			PreAttackSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteChargingMelee",
		},

		Requirements =
		{
			MaxPlayerDistance = 600,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/RatcatcherSpin" },
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteAttacking" },
			},
		},

	},

	SatyrRatCatcherSpell =
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
		Requirements = 
		{
			MinAttacksBetweenUse = 4,
		},

		AIData =
		{
			DeepInheritance = true,

			ForceUseIfReady = true,

			AttackSlots =
			{
				{ ProjectileName = "SatyrRatCatcherSpellKnockback", },
				{ ProjectileName = "SatyrRatCatcherSpellBuff",  },
			},
			BarrelLength = 125,
			FireProjectileStartDelay = 0.25,

			TargetRequiredKillEnemy = true,
			FireProjectileAtTarget = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackDuration = 0.83,
			FireDuration = 0.32,
			PostAttackDuration = 1.33,
			
			PreAttackSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteCharging",
			PreAttackAnimation = "Enemy_SatyrRatCatcher_SpellPreFire",
			FireAnimation = "Enemy_SatyrRatCatcher_SpellFire",
			PostAttackAnimation = "Enemy_SatyrRatCatcher_SpellPostFire",

			AttackDistance = 500,
			RequireProjectileLoS = true,
			LoSBuffer = 100,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcher/RatcatcherRangedFireSingle" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SatyrLancerThrust =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrLancerThrust",

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.02,
			StopBeforeFire = true,

			PreAttackEndShake = true,

			FireProjectileStartDelay = 0.03,
			PreAttackDuration = 0.8,
			FireDuration = 0.18,
			PostAttackDuration = 0.95,
			PreAttackSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_SatyrLancer_ThrustPreFire",
			FireAnimation = "Enemy_SatyrLancer_ThrustFire",
			PostAttackAnimation = "Enemy_SatyrLancer_ThrustPostFire",

			AttackDistance = 410,
			AttackDistanceScaleY = 0.7,

			RequireProjectileLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteAttackingMelee" },
				{ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerMeleeAttackWhoosh" },
			},
		},

	},

	SatyrLancerThrust_Elite =
	{
		InheritFrom = { "SatyrLancerThrust" },

		AIData =
		{
			DeepInheritance = true,
			FireTicks = 3,
			FireInterval = 0.31,
		},
	},

	SatyrLancerThrow =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrLancerThrow",

			FireProjectileAtTarget = true,
			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.05,
			StopBeforeFire = true,
			PostAttackStop = true,

			FireProjectileStartDelay = 0.07,
			BarrelLength = 200,

			PreAttackDuration = 0.8,
			FireDuration = 0.3,
			PostAttackDuration = 0.85,
			
			AttackDistanceMin = 500,
			AttackDistance = 800,
			AttackDistanceScaleY = 0.45,

			RetreatBufferDistance = 530,

			PreAttackSound = "/SFX/Enemy Sounds/SatyrLancer/EmoteCharging",
			PreAttackAnimation = "Enemy_SatyrLancer_ThrowPreFire",
			FireAnimation = "Enemy_SatyrLancer_ThrowFire",
			PostAttackAnimation = "Enemy_SatyrLancer_ThrowPostFire",
		},

		Requirements =
		{
			MinPlayerDistance = 400,
			MinAttacksBetweenUse = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrLancer/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerRangedAttackWhoosh" },
			},
		},

	},

	SatyrLancerThrow_Elite =
	{
		InheritFrom = { "SatyrLancerThrow" },

		AIData =
		{
			DeepInheritance = true,
			NumProjectiles = 3,
			ProjectileAngleInterval = 15,
		},
	},

	SatyrLancerDefense =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.7,
			PostAttackDuration = 0.5,
			AttackDistance = 9999,

			FireSelfVelocity = 1500,
			FireSelfVelocityAngleOffset = 180,

			--PostAttackThreadedFunctionName = "HandleUnitDefenseApply",

			FireAnimation = "Enemy_SatyrLancer_Defense",
			PostAttackAnimation = "Enemy_SatyrLancer_Defense_End",
			--FireFx = "ShadeShieldBlock",
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				--{ Name = "/SFX/Enemy Sounds/Exalted/EnemyShieldBlock" },
			},
		},
	},

	SatyrLancerBackDash =
	{
		GenusName = "SatyrLancerDash",
		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 1500,
			FireSelfVelocityAngleOffset = 180,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.3,
			FireDuration = 0.18,
			PostAttackDuration = 0.55,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_SatyrLancer_BackDashPreFire",
			FireAnimation = "Enemy_SatyrLancer_BackDashFire",
			PostAttackAnimation = "Enemy_SatyrLancer_BackDashPostFire",
		},

		Requirements =
		{
			MaxConsecutiveUses = 3,
			MaxPlayerDistance = 300,
		},
	},

	SatyrLancerStrafeRight =
	{
		GenusName = "SatyrLancerDash",
		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 1500,
			FireSelfVelocityAngleOffset = -60,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.3,
			FireDuration = 0.18,
			PostAttackDuration = 0.55,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_SatyrLancer_StrafeRightPreFire",
			FireAnimation = "Enemy_SatyrLancer_StrafeRightFire",
			PostAttackAnimation = "Enemy_SatyrLancer_StrafeRightPostFire",
		},

		Requirements =
		{
			MaxConsecutiveUses = 3,
			MinPlayerDistance = 200,
		},
	},

	SatyrLancerStrafeLeft =
	{
		GenusName = "SatyrLancerDash",
		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 1500,
			FireSelfVelocityAngleOffset = 60,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.3,
			FireDuration = 0.18,
			PostAttackDuration = 0.55,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_SatyrLancer_StrafeLeftPreFire",
			FireAnimation = "Enemy_SatyrLancer_StrafeLeftFire",
			PostAttackAnimation = "Enemy_SatyrLancer_StrafeLeftPostFire",
		},

		Requirements =
		{
			MaxConsecutiveUses = 3,
			MinPlayerDistance = 200,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil