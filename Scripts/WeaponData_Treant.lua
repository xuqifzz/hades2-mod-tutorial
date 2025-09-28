WeaponSetData =
{
	TreantMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TreantMelee",

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.45,
			FireWaitForAnimation = true,
			PostAttackDuration = 2.5,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.2,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.09,
			StopBeforeFire = true,

			AttackDistance = 400,

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Treant_MeleePreAttack",
			FireAnimation = "Enemy_Treant_MeleeFire",
			PostAttackAnimation = "Enemy_Treant_MeleeReturnToIdle",

			ExpireProjectilesOnHitStun = true,
		},

		Requirements =
		{
			MaxPlayerDistance = 330,
			MinAttacksBetweenUse = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Guard/EmoteAttacking" },
			},
		},
	},

	TreantRangedRoots =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "HealthBuffer" },
				Comparison = ">",
				Value = 0,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TreantRangedRoots",
			FireProjectileAtTarget = true,
			CreateOwnTargetFromOriginalTarget = true,
			PreAttackStop = true,

			--PreAttackFxAtTarget = "TreantRootsPreviewFx",
			EndPreAttackFx = true,
			PreAttackDuration = 0.0,
			FireDuration = 1.5,
			--FireWaitForAnimation = true,
			PostAttackDuration = 1.33,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Treant_RootsPreAttack",
			FireAnimation = "Enemy_Treant_RootsPreAttack",
			PostAttackAnimation = "Enemy_Treant_RootsReturnToIdle",
		},
	},

	TreantRangedRootsTriple =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},

		GameStateRequirements =
		{
			{
				PathFromSource = true,
				Path = { "HealthBuffer" },
				Comparison = "<=",
				Value = 0,
			},
		},


		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			AttackSlots =
			{
				{ OffsetAngle = 0, OffsetDistance = 455, OffsetScaleY = 0.6, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = -120, OffsetDistance = 455, OffsetScaleY = 0.6, UseAttackerAngle = true, OffsetFromAttacker = true },
				{ OffsetAngle = 120, OffsetDistance = 455, OffsetScaleY = 0.6, UseAttackerAngle = true, OffsetFromAttacker = true }, 
			},

			ProjectileName = "TreantRangedRoots",
			FireProjectileAtTarget = true,
			--CreateOwnTargetFromOriginalTarget = true,
			PreAttackStop = true,

			--PreAttackFxAtTarget = "TreantRootsPreviewFx",
			EndPreAttackFx = true,
			PreAttackDuration = 0.0,
			FireDuration = 1.5,
			--FireWaitForAnimation = true,
			PostAttackDuration = 1.33,

			AttackDistance = 9999,
			MoveWithinRange = false,
			
			DoNotRepeatOnAttackFail = true,

			PreAttackAnimation = "Enemy_Treant_RootsPreAttack",
			FireAnimation = "Enemy_Treant_RootsPreAttack",
			PostAttackAnimation = "Enemy_Treant_RootsReturnToIdle",
		},
	},

	TreantRangedSpray =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.12,

			ProjectileName = "TreantRanged",
			BarrelLength = 125,
			Spread = 15,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.8,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.14,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.14,
			PostAttackStop = true,

			NumProjectiles = 60,
			ProjectileInterval = 0.0485,

			PreAttackDuration = 1.0,
			FireDuration = 3.5,
			PostAttackDurationMin = 2.05,
			PostAttackDurationMax = 2.25,

			--PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Treant/EmotePowerCharging",
			PreAttackAnimation = "Enemy_Treant_SprayPreAttack",
			FireAnimation = "Enemy_Treant_SprayFire",
			PostAttackAnimation = "Enemy_Treant_SprayReturnToIdle",

			WeaponFireLoopingSound = "/SFX/Enemy Sounds/Treant/TreantFlurryLoop",
			AttackSound = "/SFX/Enemy Sounds/Treant/EmotePowerAttacking",

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackVoiceLines =
			{
				PlayOnce = true,
				PlayOnceContext = "TreantSprayReactionVO",
				PreLineWait = 0.85,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "EnemyKills", "Treant" },
					},
				},
				
				{ Cue = "/VO/MelinoeField_2249", Text = "Got to move...!" },
			},			
		},
	},

	Treant2RangedSpray =
	{
		InheritFrom = { "TreantRangedSpray", },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "Treant2Ranged",

			AttackDistance = 1100,
			AttackDistanceScaleY = 0.5,
			RequireProjectileLoS = true,
			LoSBuffer = 100,
			MoveWithinRange = true,
		},
	},

	TreantTailSpawn =
	{
		AIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.2,
			AttackDistance = 9999,

			MoveWithinRange = false,
			NoProjectile = true,

			SpawnBurstOnFire = true,
			SpawnOnSpawnPoints = true,
			SpawnsPerBurst = 2,
			SpawnRadius = 700,
			SpawnRate = 0.35,
			MaxActiveSpawns = 2,
			RequiredSpawnPointType = "EnemyPointMelee",
			
			SpawnerOptions =
			{
				"TreantTail",
			},

			MaxUses = 1,
			ForceFirst = true,
			ForceUseIfReady = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Hecate/EmoteCharging" },
			},
		},
	},

	TreantTailSpawn_Shadow =
	{
		InheritFrom = { "TreantTailSpawn", },

		AIData =
		{
			DeepInheritance = true,
			
			SpawnsPerBurst = 3,
			MaxActiveSpawns = 3,
			SpawnerOptions = { "TreantTail_Shadow", },

		},
	},

	Treant2TailSpawn =
	{
		InheritFrom = { "TreantTailSpawn", },

		AIData =
		{
			DeepInheritance = true,
			
			SpawnsPerBurst = 1,
			MaxActiveSpawns = 1,
			SpawnRadiusMin = 100,
			RequiredSpawnPointType = "nil",
			SpawnerOptions = { "TreantTail2", },

		},
	},

	Treant2SuperEliteTailSpawn =
	{
		InheritFrom = { "TreantTailSpawn", },

		AIData =
		{
			DeepInheritance = true,
			
			SpawnsPerBurst = 1,
			MaxActiveSpawns = 1,
			SpawnRadiusMin = 100,
			RequiredSpawnPointType = "nil",
			SpawnerOptions = { "TreantTail2_SuperElite", },

		},
	},

	Treant2RangedRoots =
	{
		InheritFrom = { "TreantRangedRoots", },

		Requirements =
		{
			MinAttacksBetweenUse = 0,
		},

		GameStateRequirements = {},

		AIData =
		{
			DeepInheritance = true,
			AttackDistance = 1000,
			MoveWithinRange = true,
			PostAttackDuration = 0.7,
		},
	},

	TreantTailSwipe =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TreantTailSwipe",
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			FireTicks = 2,
			FireInterval = 0.15,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			--PreAttackAnimation = "Enemy_TreantTail_Hidden",
			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 0.6,
			FireDuration = 1.0,
			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_TreantTail_Swipe_PreAttack",
			FireAnimation = "Enemy_TreantTail_Swipe_Fire",
			PostAttackAnimation = "Enemy_TreantTail_Idle",
			PostAttackDurationMin = 1.75,
			PostAttackDurationMax = 2.65,

			AttackDistance = 9999,

			ForceUseIfReady = true,
		},

		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},
	},

	TreantTail2Swipe =
	{
		InheritFrom = { "TreantTailSwipe", },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "TreantTail2Swipe",
		},
	},

	TreantTailUnburrow =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TreantTailUnburrow",
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 675,
			TargetSpawnPointsRadiusMin = 55,
			OccupyTargetSpawnPoint = true,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_TreantTail_Hidden",
			PreAttackDuration = 0.0,
			PreAttackFx = "EnemyBurrowDirt",
			FireAnimation = "Enemy_TreantTail_Unburrow",
			FireWaitForAnimation = true,
			PostAttackAnimation = "Enemy_TreantTail_Idle",
			PostAttackDurationMin = 0.55,
			PostAttackDurationMax = 0.65,

			AttackDistance = 100,
			MoveSuccessDistance = 50,

			DoNotRepeatOnAttackFail = true,
			PreAttackCreateHealthBar = true,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},
	},

	TreantTail2Unburrow =
	{
		InheritFrom = { "TreantTailUnburrow", },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "TreantTail2Unburrow",

			TargetSpawnPoints = false,
		},
	},

	TreantTailBurrow =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 0.0,
			PreAttackFx = "EnemyBurrowDirt",
			FireAnimation = "Enemy_TreantTail_Burrow",
			FireWaitForAnimation = true,
			PostAttackAnimation = "Enemy_TreantTail_Hidden",
			PostAttackDuration = 0.0,

			AttackDistance = 9999,

			ChainedWeapon = "TreantTailUnburrow",

			PostAttackRemoveEnemyUI = true,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},
	},

	TreantTail2Burrow =
	{
		InheritFrom = { "TreantTailBurrow", },
		AIData =
		{
			DeepInheritance = true,
			ChainedWeapon = "TreantTail2Unburrow",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil