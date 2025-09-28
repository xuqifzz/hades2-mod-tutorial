WeaponSetData =
{
	FishmanImpale =
	{
		AIData =
		{
			DeepInheritance = true,

			ChainedWeapon = "FishmanDrag",
			DoNotRepeatOnAttackFail = false,

			CancelChainedWeaponOnHitStun = true,
			AttackFailWeapon = "FishmanMeleeSlam",
			AttackFailWeaponRequirements =
			{
				HasEffectFalse = "ImpactSlow"
			},

			ProjectileName = "FishmanImpale",
			BarrelLength = 50,
			FireProjectileStartDelay = 0.04,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.5,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.04,
			StopBeforeFire = true,

			PreAttackSound = "/SFX/Enemy Sounds/FishmanMelee/EmotePowerCharging",
			PreAttackEndShake = true,

			PreAttackDuration = 1.0,
			PreAttackEndDuration = 0.4,
			FireDuration = 0.35,
			PostAttackDuration = 0.0,

			AttackDistance = 455,

			PreAttackAnimation = "Enemy_FishmanMelee_ImpaleCharge",
			FireAnimation = "Enemy_FishmanMelee_ImpaleFire",
			PostAttackAnimation = "Enemy_FishmanMelee_ImpaleReturnToIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FishmanMelee/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},
	},

	FishmanImpale_Elite =
	{
		InheritFrom = { "FishmanImpale" },
		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "FishmanMeleeDrag_Elite",
			FireDuration = 0.2,
		},
	},

	Fishman2Impale =
	{
		InheritFrom = { "FishmanImpale" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "Fishman2Impale",

			ChainedWeapon = "FishmanMelee2Drag",
			FireDuration = 0.2,
		},
	},

	Fishman2Impale_Ally =
	{
		InheritFrom = { "Fishman2Impale" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "Fishman2Impale",

			AttackDistance = 600,
		},
	},

	FishmanDrag =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FishmanDrag",
			FireProjectileStartDelay = 0.22,
			FireProjectileAngleRelative = 180,

			BarrelLength = -430,
			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,
			MoveWithinRange = false,
			DoNotRepeatOnAttackFail = true,
			PreAttackDuration = 0.0,
			FireWaitForAnimation = true,
			PostAttackDuration = 1.2,

			AttackDistance = 9999,

			FireAnimation = "Enemy_FishmanMelee_PullSwingFire",
			PostAttackAnimation = "Enemy_FishmanMelee_PullSwingReturnToIdle",

			-- Blink ban
			PreMoveTeleport = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FishmanMelee/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},
	},

	FishmanMeleeDrag_Elite =
	{
		InheritFrom = {"FishmanDrag"},
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.05,
			ChainedWeapon = "FishmanMeleeSlam",
			
			PostAttackDuration = 0,

			FireAnimation = "Enemy_FishmanMelee_Elite_PullSwing_Fire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FishmanMelee/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},
	},

	FishmanMelee2Drag =
	{
		InheritFrom = {"FishmanDrag"},
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.05,
			ProjectileName = "Fishman2Drag",
			ChainedWeapon = "FishmanMeleeSlam",
			
			PostAttackDuration = 0,

			FireAnimation = "Enemy_FishmanMelee_Elite_PullSwing_Fire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FishmanMelee/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},
	},

	FishmanMeleeSlam =
	{

		-- don't use when unit has armor
		GameStateRequirements =
		{
		  {
		    PathFromSource = true,
		    Path = { "HealthBuffer" },
		    Comparison = "<=",
		    Value = 0,
		  },
		},

		Requirements = 
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FishmanMeleeSlam",
			FireProjectileStartDelay = 0.29,

			ApplyEffectsOnPreAttackStart =
			{
				{
					EffectName = "FishmanMeleeSlamRotationBonus",
					DataProperties = 
					{
						Duration = 0.3,
						RotationMultiplier = 4.0,
					},
				}
			},

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.2,
			StopBeforeFire = true,
			--PreAttackEndStop = true,
			--PreAttackStop = true,
			MoveWithinRange = false,
			DoNotRepeatOnAttackFail = true,
			PreAttackDuration = 0.3,
			FireDuration = 0.3,
			PostAttackDuration = 0.6,

			ChargeSelfVelocity = 1450,
			ChargeSelfVelocityAngleOffset = 180,

			PreAttackFunctionName = "WeaponSetImmuneToStun",
			PostAttackFunctionName = "WeaponRevertStunImmunity",

			AttackDistance = 9999,
			
			PreAttackAnimation = "Enemy_FishmanMelee_Slam_Start",
			FireAnimation = "Enemy_FishmanMelee_Slam_Fire",
			PostAttackAnimation = "Enemy_FishmanMelee_Slam_End",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FishmanMelee/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/WrechPunchSwing" },
			},
		},

		FireScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000, Angle = 90 },
	},

	FishmanRanged =
	{
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.RootedAttacker,
			},

			ProjectileName = "FishmanRanged",
			BarrelLength = 65,

			PreAttackStop = true,
			
			FireProjectileStartDelay = 0.16,

			PreAttackDuration = 1.35,
			PreAttackEndDuration = 0.415,
			PreAttackEndShake = true,
			--FireWaitForAnimation = true,
			PostAttackDuration = 2.5,

			PreAttackAnimation = "Enemy_FishmanRanged_AttackSpitCharge",
			FireAnimation = "Enemy_FishmanRanged_AttackSpitFireSingle",
			PostAttackAnimation = "Enemy_FishmanRanged_AttackSpitReturnToIdle",

			RetreatAfterAttack = true,
			--RetreatToSpawnPoints = true,
			RetreatBufferDistance = 9999,
			--RetreatToSpawnPointRadiusMin = 600,
			--RetreatToSpawnPoints = 2000,
			RetreatTimeoutMin = 3.5,
			RetreatTimeoutMax = 4.5,

			AttackDistance = 1100,
			AttackDistanceScaleY = 0.5,
			RequireProjectileLoS = true,
			LoSBuffer = 80,

			DoNotRepeatOnAttackFail = true,

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FishmanRanged/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
			},
		},		
	},
	FishmanRanged_Elite =
	{
		InheritFrom = { "FishmanRanged" },
		AIData =
		{
			DeepInheritance = true,
			AttackDistance = 1200,

			NumProjectiles = 3,
			FireProjectileStartDelay = 0.25,
			ProjectileInterval = 0.4,
			FireDuration = 1.2,
			PostAttackDuration = 1.2,

			PreAttackAnimation = "Enemy_FishmanRanged_AttackSpitCharge",
			FireAnimation = "Enemy_FishmanRanged_AttackSpitFireInitial",
			PostAttackAnimation = "Enemy_FishmanRanged_AttackSpitReturnToIdle",
		},
	},

	FishmanRangedSelfDestruct =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FishmanRangedSelfDestruct",

			FireProjectileAtSelf = true,
			FireFromTarget = true,
			PreAttackStop = true,

			PreAttackFx = "LobWarningDecalFishmanRanged",
			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/FishmanRanged/EmoteAboutToExplode",

			PreAttackDuration = 1.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			PreAttackAnimation = "Enemy_FishmanRanged_SelfDestruct",

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Explosion1" },
				{ Name = "/SFX/Enemy Sounds/EnemyDeathExplode" },
			},
		},		
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil