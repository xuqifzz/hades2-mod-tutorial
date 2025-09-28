WeaponSetData =
{
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
			TrackTargetDuringFire = true,
			PostAttackStop = true,

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

	SatyrCrossbowFadeBolt_PreCombat =
	{
		InheritFrom = { "SatyrCrossbowFadeBolt" },

		Requirements =
		{
		},
	},

	SatyrCrossbow2ShieldedBolt =
	{
		InheritFrom = { "SatyrCrossbowShieldedBolt" },
		AIData =
		{
			ProjectileName = "SatyrCrossbow2Bolt",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.5,

			PreAttackRotationDampening = 0.06,
			PostAttackDurationMin = 1.45,
			PostAttackDurationMax = 1.90,
		},
	},

	SatyrCrossbow2ShieldRush =
	{
		InheritFrom = { "SatyrCrossbowShieldRush" },
		AIData =
		{
			ProjectileName = "SatyrCrossbow2ShieldRush",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			PreAttackRotationDampening = 0.09,
			PostAttackDurationMin = 1.10,
			PostAttackDurationMax = 1.55,
		},
	},

	SatyrRatCatcherSummon =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 2,
			MaxActiveSpawns = 3,
			RequiresNotCharmed = true,
			MaxRequiredKillEnemies = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			PreAttackStop = true,
			DoNotRepeatOnAttackFail = true,

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
		Requirements =
		{
			RequiresNotCharmed = true,
			MaxUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			PreAttackStop = true,
			DoNotRepeatOnAttackFail = true,

			PreAttackAnimationSpeed = 2.0,
			PreAttackDuration = 0.5,
			FireDuration = 0.66,
			PostAttackDuration = 1.0,

			DumbFireWeapons = { "SatyrRatCatcherSummonSpawner", },

			PreAttackSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteSummoning",
			PreAttackFx = "EnemyChargeFxIn_SatyrRatCatcher_Summon",
			PreAttackAnimation = "Enemy_SatyrRatCatcher_SummonPreFire",
			FireAnimation = "Enemy_SatyrRatCatcher_SummonFire_Fast",
			PostAttackAnimation = "Enemy_SatyrRatCatcher_SummonPostFire",

			AttackDistance = 99999,
			MoveWithinRange = false,
		},
	},

	SatyrRatCatcherSummonSpawner =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			SpawnBurstOnFire = true,
			SpawnOnSpawnPoints = true,
			SpawnAggroed = true,
			SpawnerOptions = { "Crawler_Elite" },
			SpawnsPerBurstMin = 8,
			SpawnsPerBurstMax = 8,
			MaxActiveSpawns = 24,
			SpawnBurstDelay = 0.5,
			SpawnRateMin = 0.75,
			SpawnRateMax = 1.25,
			SpawnRadius = 750,

			DumbFireInterval = 10,
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
			
			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.5,
			PreAttackStop = true,
			
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
		AIData =
		{
			DeepInheritance = true,
			NumProjectiles = 3,
			ProjectileAngleInterval = 40,
			AttackDistance = 800,
			AttackDistanceScaleY = 0.7,

			PostAttackDurationMin = 0.8,
			PostAttackDurationMax = 1.2,

			RetreatAfterAttack = true,
			RetreatTimeoutMin = 0.2,
			RetreatTimeoutMax = 1,
			RetreatBufferDistance = 800,

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

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.5,
			PreAttackStop = true,

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
	},

	SatyrCultistMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "SatyrCultistMelee", PauseDuration = 0.4 },
				{ ProjectileName = "SatyrCultistMeleeRadial", AIDataOverrides = { SpawnFromMarker = "SatyrCultist_Rig:pinky_00_L_JNT" } },
			},

			ChargeSelfVelocity = 1800, 
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			--PreAttackFx = "SatyrRatCatcherMeleeChargeFx",
			PreAttackStop = true,
			PreAttackDuration = 1.5,
			FireDuration = 3.0,
			PostAttackDuration = 1.0, --anim is 0.98

			AttackDistance = 600,
			AttackDistanceScaleY = 0.80,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			WaitForAngleTowardTarget = true,
			MaxAttackers = 99,

			PreAttackAnimation = "Enemy_SatyrCultist_Stab_Start",
			FireAnimation = "Enemy_SatyrCultist_Stab_Fire",
			PostAttackAnimation = "Enemy_SatyrCultist_Stab_End",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteAttacking" },
			},
		},
	},

	SatyrCultistMelee_Elite =
	{
		InheritFrom = { "SatyrCultistMelee" },

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "SatyrCultistMelee_Elite", PauseDuration = 0.4 },
				{ ProjectileName = "SatyrCultistMeleeRadial_Elite", AIDataOverrides = { SpawnFromMarker = "SatyrCultist_Rig:pinky_00_L_JNT" } },
			},

			ChargeSelfVelocity = 2100, 
		},
	},

	SatyrCultistThrow =
	{
		Requirements =
		{
			MinPlayerDistance = 400,
		},
		
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CultistThrow",

			BarrelLength = 200,

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 1100,
			RetreatTimeout = 3.0,

			FireProjectileStartDelay = 0.02,

			--PreAttackFx = "SatyrRatCatcherMeleeChargeFx",
			PreAttackStop = true,
			PreAttackDuration = 1.5,
			FireDuration = 0.1,
			PostAttackDuration = 1.0, --anim is 0.98

			AttackDistance = 1000,
			AttackDistanceScaleY = 0.55,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			WaitForAngleTowardTarget = true,
			MaxAttackers = 99,

			PreAttackAnimation = "Enemy_SatyrCultist_Throw_Start",
			FireAnimation = "Enemy_SatyrCultist_Throw_Fire",
			PostAttackAnimation = "Enemy_SatyrCultist_Throw_End"
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteAttacking" },
			},
		},
	},

	SatyrCultistThrow_Elite =
	{
		InheritFrom = { "SatyrCultistThrow" },
		
		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 3,
			ProjectileAngleInterval = 12,
		},
	},

	SatyrCultistRitual =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CultistShockwave",
			FireProjectileAtSelf = true,
			
			PreAttackSetThingProperties =
			{
				ImmuneToForce = true
			},

			PreAttackDuration = 1.5,
			FireDuration = 0.2,
			PostAttackDuration = 0.0,

			PostAttackKillSelf = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
			TargetSelf = true,

			PreAttackAngleTowardTarget = false,

			PreAttackAnimation = "Enemy_SatyrCultist_Ritual",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteAttacking" },
			},
		},
	},

	SatyrCultistCast =
	{
		Requirements = 
		{
			MinPlayerDistance = 400,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrCultistCast",
			BarrelLength = 150,
			FireProjectileStartDelay = 0.4,

			ExpireProjectilesOnHitStun = true,
			ExpireProjectilesOnFreeze = true,

			RequireUnitLoS = true,

			PreAttackStop = true,
			PreAttackDuration = 1.0,
			FireDuration = 11.2,
			PostAttackDuration = 0.9,

			PreAttackEndShake = true,
			PreAttackFxAtProjectileStartLocation = "EnemyChargeFxIn",
			
			PreAttackSound = "/SFX/Enemy Sounds/Lamia/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_SatyrCultist_Cast_Start",
			--FireAnimation = "Enemy_SatyrCultist_Stab_Fire",
			PostAttackAnimation = "Enemy_SatyrCultist_Stab_End",

			AttackDistance = 2000,
			AttackDistanceScaleY = 0.45,
			DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},
	},

	SatyrCultistCast_Elite =
	{
		InheritFrom = { "SatyrCultistCast" },
		AIData =
		{
			DeepInheritance = true,

			FireDuration = 3.25,
		},
	},

	SatyrRatCatcherMelee_Miniboss =
	{
		InheritFrom = { "SatyrRatCatcherMelee" },

		Requirements =
		{
			MaxPlayerDistance = 600,
		},

		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.2,
						Modifier = 0.6,
						HaltOnEnd = true,
					},
				},
			},

			ProjectileName = "SatyrRatCatcherMelee_Miniboss",
			FireSelfVelocity = 1900,
			PreAttackAnimationSpeed = 2.0,
			PreAttackDuration = 0.7,
			FireProjectileStartDelay = 0.2,

			RetreatDurationMin = 1.0,
			RetreatDurationMax = 1.2,

			AttackDistance = 600,
			DoNotRepeatOnAttackFail = true,
			PreAttackSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteChargingMelee",
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
			RequireTotalAttacks = 3,
			RequiresNotCharmed = true,
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
	},

	SatyrLancerThrust =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrLancerThrust",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.5,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.07,
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

			AttackDistance = 550,
			AttackDistanceScaleY = 0.6,

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

	SatyrLancer2Thrust =
	{
		InheritFrom = { "SatyrLancerThrust" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrLancer2Thrust",
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

	SatyrLancer2Thrust_Elite =
	{
		InheritFrom = { "SatyrLancer2Thrust" },
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
			WaitForAngleTowardTargetTimeOut = 0.5,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
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

	SatyrLancer2Throw =
	{
		InheritFrom = { "SatyrLancerThrow" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrLancer2Throw",
		},
	},

	SatyrLancerThrow_Elite =
	{
		InheritFrom = { "SatyrLancerThrow" },

		AIData =
		{
			DeepInheritance = true,
			FireTicks = 3,
			FireInterval = 0.4,
		},
	},

	SatyrLancerThrow_Prometheus =
	{
		InheritFrom = { "SatyrLancer2Throw" },

		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 2000,
			ChainedWeapon = "SatyrLancerEscape",
		},
	},

	SatyrLancerThrow_PrometheusAlly =
	{
		InheritFrom = { "SatyrLancer2Throw" },

		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 2000,
		},
	},

	SatyrLancerEscape =
	{
		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackAnimation = "Enemy_SatyrLancer_Escape",
			PreAttackDuration = 0.83,
			FireDuration = 0.0,
			PostAttackDuration = 0.1,
			PostAttackAlpha = 0,
			PostAttackAlphaDuration = 0.1,
			FireSelfUpwardVelocity = 8000,
			PostAttackKillSelf = true,
			PostAttackKillSelfArgs = { SkipOnDeathFunction = true, Silent = true, SkipDestroyDelay = true, },
		},
	},

	SatyrLancer2Throw_Elite =
	{
		InheritFrom = { "SatyrLancer2Throw" },
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 3,
			FireInterval = 0.4,
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
			TrackTargetDuringFire = true,
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
			TrackTargetDuringFire = true,
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
			TrackTargetDuringFire = true,
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

	SatyrSapperRocket =
	{
		Requirements =
		{
			MaxAttackers = 3,
			MinPlayerDistance = 300,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "SatyrRocket",
			FireFx = "SatyrRocketFireFx",
			BarrelLength = 125,
			FireProjectileStartDelay = 0.05,

			WaitForAngleTowardTarget = true,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.06,
			TrackTargetDuringFire = false,
			PostAttackStop = true,

			PreAttackDuration = 1.5,
			FireDuration = 0.48,
			PostAttackDurationMin = 1.32, -- anim is 1.32
			PostAttackDurationMax = 1.65,

			ChainedWeapon = "SatyrSapperBackDash",
			
			PreAttackSound = "/SFX/Enemy Sounds/SatyrSapper/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_SatyrSapper_RocketPreFire",
			FireAnimation = "Enemy_SatyrSapper_RocketFire",
			PostAttackAnimation = "Enemy_SatyrSapper_RocketPostFire",

			DoNotRepeatOnAttackFail = true,

			AttackDistance = 980,
			AttackDistanceScaleY = 0.55,
			RequireProjectileLoS = true,
			LoSBuffer = 70,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrSapper/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/Theseus/TheseusMortarLaunch" },
			},
		},
	},

	SatyrSapperRocket_Elite =
	{
		InheritFrom = { "SatyrSapperRocket" },
		AIData =
		{
			DeepInheritance = true,

			NumProjectiles = 2,
			ProjectileStartAngleOffset = -15,
			ProjectileAngleInterval = 30,
			ProjectileInterval = 0.08,
			Spread = 6,
		},
	},

	SatyrSapperRocket_Prometheus =
	{
		InheritFrom = { "SatyrSapperRocket" },

		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 9999,
			MoveWithinRange = false,

			ProjectileName = "SatyrRocket_Prometheus",

			ChainedWeapon = "SatyrSapperEscape",
			PostAttackDuration = 1.33,
			PostAttackDurationMin = "nil",
			PostAttackDurationMax = "nil",
		},
	},

	SatyrSapperRocket_PrometheusAlly =
	{
		InheritFrom = { "SatyrSapperRocket" },

		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 2000,
		},
	},

	SatyrSapperEscape =
	{
		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackAnimation = "Enemy_SatyrSapper_Escape",
			PreAttackDuration = 1.23,
			FireDuration = 0.0,
			PostAttackDuration = 0.1,
			PostAttackAlpha = 0,
			PostAttackAlphaDuration = 0.1,
			FireSelfUpwardVelocity = 8000,
			PostAttackKillSelf = true,
			PostAttackKillSelfArgs = { SkipOnDeathFunction = true, Silent = true, SkipDestroyDelay = true, },
		},
	},

	SatyrSapperShotgun =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrShotgunBolt",
			FireFx = "SatyrRocketFireFx",
			NumProjectiles = 5,
			ProjectileAngleInterval = 8,
			ProjectileInterval = 0.05,
			BarrelLength = 125,
			FireProjectileStartDelay = 0.05,
			--ProjectileStartZHeight = 900,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,

			PreAttackDuration = 1.5,
			FireDuration = 0.48,
			PostAttackDurationMin = 1.4, -- anim is 1.32
			PostAttackDurationMax = 2.4,
			
			PreAttackSound = "/SFX/Enemy Sounds/SatyrSapper/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_SatyrSapper_RocketPreFire",
			FireAnimation = "Enemy_SatyrSapper_RocketFire",
			PostAttackAnimation = "Enemy_SatyrSapper_RocketPostFire",

			AttackDistance = 1100,
			AttackDistanceScaleY = 0.5,
			RequireProjectileLoS = true,
			LoSBuffer = 5,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrSapper/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/Theseus/TheseusMortarLaunch" },
			},
		},
	},

	SatyrSapperLob =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
			MinPlayerDistance = 400,
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathFalse = { "InAmbientBattle" },
			}
		},

		AIData =
		{
			DeepInheritance = true,

			SkipSurroundAICount = true,

			ProjectileName = "SatyrSapperLob",
			FireProjectileAtTarget = true,
			FireProjectileStartDelay = 0.13,
			SpawnFromMarker = "SatyrSapper_Rig:hips_00_M_JNT",
			BarrelLength = 75,
			ImmuneToProjectileSlow = true,

			CreateOwnTargetFromOriginalTarget = true,
			OffsetY = 75,
			SkipIfTargetLocationBlocked = true,

			DoNotRepeatOnAttackFail = true,

			WaitForAngleTowardTarget = true,

			PreAttackStop = true,
			PreAttackDuration = 0.1875,
			PreAttackAnimationSpeed = 4,
			FireDuration = 0.32,
			PostAttackDuration = 1.5, -- anim is 1.48

			AttackDistance = 1050,
			AttackDistanceScaleY = 0.50,
			LoSBuffer = 50,
			RequireProjectileLoS = true,

			PreAttackSound = "/SFX/Enemy Sounds/SatyrSapper/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_SatyrSapper_LobPreFire",
			FireAnimation = "Enemy_SatyrSapper_LobFire",
			PostAttackAnimation = "Enemy_SatyrSapper_LobPostFire",

			ChainedWeapon = "SatyrSapperBackDash",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrSapper/EmoteAttackingLob" },
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},
	},

	SatyrSapperLob_PreCombat =
	{
		InheritFrom = { "SatyrSapperLob" },

		Requirements =
		{
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				PathTrue = { "InAmbientBattle" },
			}
		},

		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "nil",
			RequireProjectileLoS = false,
			SkipIfTargetLocationBlocked = false,
			ForceUseIfReady = true,
		},
	},

	SatyrSapperMelee =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
			MaxPlayerDistance = 400,
		},

		AIData =
		{
			DeepInheritance = true,

			SkipSurroundAICount = true,

			ProjectileName = "SatyrSapperMelee",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.02,
			StopBeforeFire = true,

			FireProjectileStartDelay = 0.05,
			PreAttackDuration = 0.665,
			FireDuration = 0.32,
			PostAttackDuration = 0.95, -- anim is 0.9

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackSound = "/SFX/Enemy Sounds/SatyrSapper/EmoteCharging",
			PreAttackAnimation = "Enemy_SatyrSapper_MeleePreFire",
			FireAnimation = "Enemy_SatyrSapper_MeleeFire",
			PostAttackAnimation = "Enemy_SatyrSapper_MeleePostFire",

			AttackDistance = 300,
			AttackDistanceScaleY = 0.7,

			RequireProjectileLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,


			ChainedWeapon = "SatyrSapperBackDash",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrSapper/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerMeleeAttackWhoosh" },
			},
		},
	},

	SatyrSapperMelee_Fiend =
	{
		InheritFrom = { "SatyrSapperMelee" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SatyrSapperMelee",
		},
	},

	SatyrSapperBackDash =
	{
		Requirements =
		{
			MaxConsecutiveUses = 2,
			MaxPlayerDistance = 600,
		},

		ChainChance = 0.33,

		AIData =
		{
			DeepInheritance = true,

			SkipSurroundAICount = true,

			AttackFailWeapon = "nil",

			FireSelfVelocity = 1500,
			FireSelfVelocityAngleOffset = 180,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.43,
			FireDuration = 0.22,
			PostAttackDuration = 0.55, -- anim is 0.48

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_SatyrSapper_BackStepPreFire",
			FireAnimation = "Enemy_SatyrSapper_BackStepFire",
			PostAttackAnimation = "Enemy_SatyrSapper_BackStepPostFire",

			-- Blink ban
			PreMoveTeleport = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SatyrLancer/LancerEvade" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil