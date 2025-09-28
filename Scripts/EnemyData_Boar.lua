UnitSetData.Boar =
{
	Boar =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy" },

		BlockRaiseDead = true,
		IsBoss = false,
		BlockCharm = true,
		IgnoreSpeedShrine = true,
		ImmuneToPolymorph = true,
		IgnoreSprintPhasingStasisStun = true,

		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs = { Message = "BoarMinibossDefeatedMessage", StartPanTime = 1.0, EndPanTime = 5.0, EndAngle = 270, FlashRed = true, MessageDelay = 0.5, EndMusicEarly = true, },
		DeathAnimation = "Enemy_Boar_Miniboss_Death",
		DeathSound = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteDying",

		MaxHealth = 5000,

		HealthBarOffsetY = -250,
		HealthDamageSound = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteHurt",
		Material = "Organic",
		
		BlockRespawnShrineUpgrade = true,
		StartAggroed = true,

		StunAnimations = 
		{
			--Default = "Enemy_Boar_OnHit",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			MoveWithinRangeTimeout = 3.0,
		},

		CollisionReactions =
		{
			DeepInheritance = true,
			Append = true,
			{
				FunctionName = "HandleEnemyRushCollision",
			}
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			}
		},

		AIOptions =
		{
			"AttackerAI",
		},

		WeaponOptions =
		{
			"BoarPound", "BoarBackKick", "BoarRush",
		},

		GeneratorData =
		{
			DifficultyRating = 100,
		},
	},

	Boar_Shadow =
	{
		InheritFrom = { "Shadow", "Boar" },
		GenusName = "Boar",
		MaxHealth = 800,
		HealthBuffer = 800,
		UseBossHealthBar = false,
		DeathAnimation = "Enemy_Boar_Death",
		OnDeathFunctionName = "nil",

		ManualDeathAnimation = false,

		WakeUpDelayMin = 0.0,
		WakeUpDelayMax = 1.0,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"BoarPound_Shadow", "BoarBackKick_Shadow", "BoarRush_Shadow",
		},
	},

	Boar_SuperElite =
	{
		InheritFrom = { "SuperElite", "BaseVulnerableEnemy" },
		GenusName = "Boar",
		MaxHealth = 3000,
		HealthBuffer = 6000,
		BlockRaiseDead = false,

		HealthBarOffsetY = -250,
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteHurt",
		DeathAnimation = "Enemy_Boar_Death",
		
		StartAggroed = true,
		UseActivatePresentation = false,
		WakeUpDelay = 0.0,
		CreateAnimations = { "EnemyPreSpawnTerrainChronosLarge" },

		StunAnimations = 
		{
			--Default = "Enemy_Boar_OnHit",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			MoveWithinRangeTimeout = 3.0,
		},

		CollisionReactions =
		{
			DeepInheritance = true,
			Append = true,
			{
				FunctionName = "HandleEnemyRushCollision",
			}
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			}
		},

		AIOptions =
		{
			"AttackerAI",
		},

		SpellSummonDataOverrides =
		{
			WeaponOptions =
			{
				"BoarPound_Summon"
			},
		},

		WeaponOptions =
		{
			"BoarPound_Shadow", "BoarBackKick_Shadow", "BoarRush_Shadow",
		},

		GeneratorData =
		{
			DifficultyRating = 100,
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Boar )

WeaponSetData =
{
	BoarPound =
	{
		Requirements =
		{
			MaxPlayerDistance = 800,
			MaxConsecutiveUses = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BoarGroundPound",
			FireSelfVelocity = 800,
			BarrelLength = 300,
			FireProjectileStartDelay = 0.175,
			FireProjectileAtSelf = true,

			PreAttackDuration = 0.8,
			FireDuration = 0.28,
			PostAttackDuration = 0.98,

			AttackDistance = 550,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackSound = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteCharging1",
			PreAttackAnimation = "Enemy_Boar_PoundPreFire",
			FireAnimation = "Enemy_Boar_PoundFire",
			PostAttackAnimation = "Enemy_Boar_PoundPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteAttacking1" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},
	},

	BoarPound_Shadow =
	{
		InheritFrom = { "BoarPound" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BoarGroundPound_Shadow",
			BarrelLength = 200,
		},
	},

	BoarPound_Summon =
	{
		InheritFrom = { "BoarPound" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BoarGroundPound_Summon",
		},
	},

	BoarBackKick =
	{
		Requirements =
		{
			MinPlayerArc = 140,
			MaxPlayerDistance = 525,
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "BoarBackKick",
			FireFromSelf = true,
			FireProjectileAngleRelative = 180,
			FireProjectileStartDelay = 0.05,
			FireSelfVelocity = 400,
			BarrelLength = -600,

			PreAttackDuration = 0.5,
			FireDuration = 0.48,
			PostAttackDuration = 0.65,

			AttackDistance = 9999,
			PreAttackStop = true,
			MoveWithinRange = false,
			AngleTowardsTargetWhileFiring = false,
			PreAttackAngleTowardTarget = false,

			PreAttackSound = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteCharging2",
			PreAttackAnimation = "Enemy_Boar_BackKickPreFire",
			FireAnimation = "Enemy_Boar_BackKickFire",
			PostAttackAnimation = "Enemy_Boar_BackKickPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/ZombieBoarMiniboss/EmoteAttacking2" },
				{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},
	},

	BoarBackKick_Shadow =
	{
		InheritFrom = { "BoarBackKick" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BoarBackKick_Shadow",
		},
	},

	BoarRush =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BoarRushMelee",
			FireProjectileStartDelay = 0.3,

			ApplyEffectsOnMove =
			{
				{
					EffectName = "ChargeRotationDamp",
					DataProperties = 
					{
						Duration = 9999,
						RotationMultiplier = 0.02,
					}
				},

				{
					EffectName = "SpeedIncrease",
					DataProperties = 
					{
						Type = "Speed",
						Duration = 9999,
						Modifier = 3.0,
					}
				},
			},

			IsRushWeapon = true,
			PreMoveFunctionName = "WeaponSetImmuneToStun",
			PreAttackFunctionName = "WeaponRevertStunImmunity",
			--MoveDumbFireWeapons = { "BruteChargeRadial" },
			--EndMoveDumbFireWeapons = true,
			RushCollisionWeapon = "BoarWallSlam",

			MoveStartSelfVelocity = 500,
			PreMoveAngleTowardTarget = true,
			PreMoveWaitForAngleTowardTarget = true,
			PreMoveStop = true,
			PreMoveDuration = 1.5,
			PreMoveAnimation = "Enemy_Boar_RushPreFire",
			MoveAnimation = "Enemy_Boar_RushFire",
			StopMoveWithinRange = false,
			PreAttackDuration = 0.0,
			FireDuration = 0.25,
			PostAttackDuration = 3.0, -- anim is 0.55

			StopBeforeFire = true,

			MoveDumbFireWeapons = { "BoarRushRam", "BoarRushRadial" },
			EndMoveDumbFireWeapons = true,
			MoveWithinRangeTimeout = 1.5,
			AttackDistance = 350,
			AttackDistanceScaleY = 0.6,
			TrackAtPathEnd = true,
			PostAttackStop =  true,

			FireAnimation = "Enemy_Boar_RushPostFire",

			DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			PreMoveSounds =
			{ Name = "/SFX/Enemy Sounds/ZombieBoarMiniboss/BoarSqueal" },
		},
	},

	BoarRush_Shadow =
	{
		InheritFrom = { "BoarRush" },

		AIData =
		{
			DeepInheritance = true,

			MoveDumbFireWeapons = { "BoarRushRam", "BoarRushRadial_Shadow" },
		},
	},

	BoarRushRam =
	{
		AIData =
		{
			DeepInheritance = true,
			
			SkipCanAttack = true,
			CancelOnPolymorph = true,
			RestartOnHitStunClear = true,
			ExpireProjectilesOnPolymorph = true,
			ExpireProjectilesOnHitStun = true,

			DumbFireInterval = 0.5,

			ProjectileName = "BoarRushRam",
		},
	},

	BoarRushRadial =
	{
		AIData =
		{
			DeepInheritance = true,
			
			ProjectileName = "BoarRushRadial",

			TargetSelf = true,
			BarrelLength = 400,

			SkipCanAttack = true,
			CancelOnPolymorph = true,
			RestartOnHitStunClear = true,
			ExpireProjectilesOnPolymorph = true,
			ExpireProjectilesOnHitStun = true,

			AlwaysUseDumbFireThreadName = true,

			DumbFireInterval = 0.2,
		},
	},

	BoarRushRadial_Shadow =
	{
		InheritFrom = { "BoarRushRadial" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BoarRushRadial_Shadow",
			BarrelLength = 300,
		},
	},

	BoarWallSlam =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BoarWallSlam",
			BarrelLength = 300,
			FireProjectileAtSelf = true,

			PreAttackDuration = 0.0,
			FireDuration = 3.0,
			PostAttackDuration = 0.0,

			AttackDistance = 9999,
			MoveWithinRange = false,

			FireAnimation = "Enemy_Boar_RushWallSlam",
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/SFX/Player Sounds/ZagreusShieldRush" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil