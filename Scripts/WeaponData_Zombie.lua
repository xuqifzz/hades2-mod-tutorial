WeaponSetData =
{
	ZombieSpawnerSummon =
	{
		AIData =
		{
			DeepInheritance = true,
			AttackDistance = 9999,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,

			ProjectileName = "ZombieSpawnerLob",
			SpawnFromMarker = "ZombieSpawner_Rig:middle_01_R_JNT",
			FireProjectileTowardTarget = true,
			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 600,
			TargetSpawnPointsRadiusMin = 200,
			TargetSpawnPointsNearSelf = true,
			ImmuneToProjectileSlow = true,

			FireProjectileStartDelay = 0.04,

			PreAttackAnimation = "Enemy_ZombieSpawner_Spawn_Start",
			FireAnimation = "Enemy_ZombieSpawner_Spawn_Fire",

			PreAttackDuration = 1.0,
			FireDuration = 0.5,
			PostAttackDurationMin = 1.35,
			PostAttackDurationMax = 1.85,
		},

		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = "<=",
				Value = 9,
			},
		},
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/ZombieSpawner/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/HydraHead/HydraEggSpit" },
			},
		},
	},

	ZombieSpawnerSummon_Elite =
	{
		InheritFrom = { "ZombieSpawnerSummon" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "ZombieSpawnerLob_Elite",
		},
	},

	ZombieSpawnerWait =
	{
		AIData =
		{
			AttackDistance = 9999,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,
			NoProjectile = true,

			PreAttackDuration = 3.0,
		},

		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">",
				Value = 9,
			},
		},

	},

	ZombieAssassinStab =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZombieAssassinStab",
			FireTickSelfVelocity = 700,

			NumProjectiles = 6,
			ProjectileInterval = 0.14,
			Spread = 10,
			FireProjectileStartDelay = 0.03,

			PreAttackDuration = 0.9,
			FireDuration = 0.75,
			PostAttackDuration = 0.6,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.4,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			StopBeforeFire = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.09,
			PostAttackStop = true,

			AttackDistance = 380,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackSound = "/SFX/Enemy Sounds/Assassin/EmoteCharging",
			PreAttackAnimation = "Enemy_ZombieAssassin_StabPreFire",
			FireAnimation = "Enemy_ZombieAssassin_StabFire",
			PostAttackAnimation = "Enemy_ZombieAssassin_StabPostFire",

			AttackFailWeapon = "ZombieAssassinLateralDash",
		},

		HitScreenshake = { Distance = 3, Speed = 700, Duration = 0.07, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Assassin/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Assassin/AssassinSwipe" },
			},
		},
	},

	ZombieAssassinStab_Elite =
	{
		InheritFrom = { "ZombieAssassinStab" },
		AIData =
		{
			DeepInheritance = true,
			FireTickSelfVelocity = 1000,
		},
	},

	ZombieAssassinLateralDash =
	{
		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 1500,
			FireSelfVelocityAngleOffset = 60,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			AttackDistance = 900,
			MoveWithinRange = true,
			NoProjectile = true,
			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			FireAnimation = "Enemy_ZombieAssassin_Dash",

      		FireFx = "ZombieAssassinDashFx"
		},

		Requirements =
		{
			MaxConsecutiveUses = 3,
		},

		-- Sounds in Enemy_ZombieAssassin_Dash anim
	},

	ZombieAssassinStalk =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = true,
			AttackDistance = 100,
			MoveSuccessDistance = 50,
			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 600,
			TargetSpawnPointsRadiusMin = 400,

			ApplyEffectsOnMove = 
			{
				WeaponEffectData.AssassinStalkSpeed,
			},

			NoProjectile = true,

			PreMoveDuration = 0.3,
			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			DoNotRepeatOnAttackFail = true,

			PreMoveAnimation = "Enemy_ZombieAssassin_StalkEntrance",
      		PreMoveFx = "ZombieAssassinCloakFront",
			FireAnimation = "Enemy_ZombieAssassin_StalkExit",
      		FireFx = "ZombieAssassinUncloakFront",
      		PreMoveRemoveEnemyUI = true,
			FireCreateHealthBar = true,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 5,
			MinRequiredKillEnemies = 3,
			RequiresNotCharmed = true,
		},

		Sounds =
		{
			PreMoveSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Assassin/EmoteTaunting" },
			},
		},		
	},

	ZombieMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZombieMelee",
			FireSelfVelocity = 450,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},
			FireProjectileStartDelay = 0.09,

			NumProjectiles = 2,
			ProjectileInterval = 0.05,

			PreAttackDuration = 0.9,
			FireDuration = 0.4,
			PostAttackDuration = 0.8,

			AttackDistance = 280,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			TrackTargetDuringCharge = false,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.4,
			PreAttackEndFlashFraction = 0.6,

			PreAttackSound = "/SFX/Enemy Sounds/Zombie/EmoteCharging",
			PreAttackAnimation = "Enemy_Zombie_MeleePreFire",
			FireAnimation = "Enemy_Zombie_MeleeFire",
			PostAttackAnimation = "Enemy_Zombie_MeleeReturnToIdle",
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Zombie/EmoteAttacking" },
			},
		},
	},

	ZombieMelee_Elite =
	{
		InheritFrom = { "ZombieMelee" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZombieMelee_Elite",
			FireSelfVelocity = 1300,

			RetreatAfterAttackChance = 0.0,

			AttackDistance = 400,
			LoSBuffer = 85,

			PostAttackDuration = 0.2,
			ChainedWeaponOptions = { "ZombieMelee_Elite2" },
		},
	},

	ZombieMelee_Elite2 =
	{
		InheritFrom = { "ZombieMelee" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZombieMelee_Elite",
			FireSelfVelocity = 400,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.11,
			StopBeforeFire = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
			DoNotRepeatOnAttackFail = true,

			PreAttackDuration = 0.3,
			PreAttackEndShake = false,
			PreAttackEndDuration = 0.0,
			PreAttackEndFlashFraction = 0.0,
			PreAttackAnimationSpeed = 2.5,
		},
	},

	ZombieHeavyRangedToss =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZombieHeavyRangedToss",

			PreAttackSound = "/SFX/Enemy Sounds/ZombieHeavyRanged/EmoteChargingRanged",

			MoveWithinRange = true,

			PreAttackDuration = 2.1,
			FireWaitForAnimation = true,
			PostAttackDuration = 1.75,

			FireProjectileStartDelay = 0.165,
			BarrelLength = 275,

			PreAttackAnimation = "Enemy_ZombieHR_TossPreFire",
			FireAnimation = "Enemy_ZombieHR_TossFire",
			PostAttackAnimation = "Enemy_ZombieHR_TossReturnToIdle",
			
			AttackDistance = 1100,
			AttackDistanceScaleY = 0.58,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.20,
			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.10,
			PostAttackStop = true,

			RetreatBufferDistance = 1000,
			RetreatAfterAttackChance = 1.0,
			RetreatTimeoutMin = 2.0,
			RetreatTimeoutMax = 3.0,

			DoNotRepeatOnAttackFail = true,
		},

		Requirements =
		{
			MinPlayerDistance = 350,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/ZombieHeavyRanged/EmoteAttackingRanged" },
			},
		},
	},

	ZombieHeavyRangedToss_Elite =
	{		
		InheritFrom = { "ZombieHeavyRangedToss" },

		AIData =
		{		
			RetreatAfterAttackChance = 0.0,
			PostAttackAnimation = "Enemy_ZombieHR_TossReturnToIdle_Elite",
		},
	},

	ZombieHeavyRangedToss_Hub =
	{		
		InheritFrom = { "ZombieHeavyRangedToss" },

		AIData =
		{		
			ProjectileName = "ZombieHeavyRangedToss_Hub",
			AttackDistance = 99999,
			DoNotRepeatOnAttackFail = false,
			RetreatAfterAttackChance = 0.0,
		},

		Requirements =
		{
			MinPlayerDistance = 0,
		},		
	},	

	ZombieHeavyRangedShove =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ZombieHeavyRangedShove",
			FireSelfVelocity = 0,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			PreAttackDuration = 1.0,
			FireDuration = 0.4,
			PostAttackDuration = 1.1,
			PreAttackEndDuration = 0.4,
			FireProjectileStartDelay = 0.13,

			PreAttackEndShake = true,

			AttackDistance = 350,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			WaitForAngleTowardTarget = false, -- causes heavy swiveling with hand
			StopBeforeFire = true,

			PreAttackSound = "/SFX/Enemy Sounds/ZombieHeavyRanged/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_ZombieHR_ShovePreFire",
			FireAnimation = "Enemy_ZombieHR_ShoveFire",
			PostAttackAnimation = "Enemy_ZombieHR_ShoveReturnToIdle",

			DoNotRepeatOnAttackFail = true,
	
		},

		Requirements =
		{
			MaxPlayerDistance = 525,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
				{ Name = "/SFX/Enemy Sounds/ZombieHeavyRanged/EmoteAttackingMelee" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	ZombieHeavyRangedShove_Elite =
	{
		InheritFrom = { "ZombieHeavyRangedShove" },
		AIData =
		{
			FireSelfVelocity = 1800,
			ProjectileName = "ZombieHeavyRangedShove_Elite",
			--PreAttackDuration = 1.25,
			PreAttackAnimation = "Enemy_ZombieHR_ShovePreFire_Elite",

			-- ChainedWeaponOptions = { "ZombieHeavyRangedShove_Elite2" },
			--PostAttackDuration = 0,
			PostAttackDuration = 1.1,
		},
	},

	ZombieHeavyRangedShove_Elite2 =
	{
		InheritFrom = { "ZombieHeavyRangedShove" },
		AIData =
		{	
			ProjectileName = "ZombieHeavyRangedShove_Elite2",
			FireSelfVelocity = 0,
			
			PreAttackAnimation = "Enemy_ZombieHR_ShovePreFireReverse",
			FireAnimation = "Enemy_ZombieHR_ShoveFireReverse",
			PostAttackAnimation = "Enemy_ZombieHR_Idle",

			PreAttackDuration = 0.375,
			FireDuration = 1.0,
			PostAttackDuration = 0,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil