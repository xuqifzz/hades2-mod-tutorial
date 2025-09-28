WeaponSetData =
{
	ScyllaSpotlightCombo =
	{
		Requirements =
		{
			MaxUses = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ScyllaBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		WeaponComboOnly = true,
		WeaponCombo =
		{
			"ScyllaSpin",
			"ScyllaBelt",
			"ScyllaNotes",
		},

		AIData =
		{
			ForceUseIfReady = true,
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	ScyllaSpotlightPassive =
	{
		Requirements =
		{
			MaxUses = 1,
		},
		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ScyllaBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			ForceUseIfReady = true,
			MoveWithinRange = false,
			SkipFireWeapon = true,

			PreMoveFunctionName = "ScyllaFightTrackSpotlight",

			PreAttackDuration = 0.1,
			FireDuration = 0.0,
			PostAttackDuration = 5.5,

			PostAttackEndMusicStemVolume = 1.0,
			PostAttackEnemyDataOverrides = 
			{
				TargetMusicStemVolume = 1.0
			},
		},
	},

	ScyllaBelt =
	{
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnPreAttackStart =
			{
				{
					EffectName = "ScyllaBeltSelfSlow",
					DataProperties = 
					{
						Type = "SPEED",
						Duration = 9999,
						Modifier = 0.83,
					}
				},
			},
			ClearPreAttackStartEffectsOnFireEnd = true,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "ScyllaBeltGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 999,
						Modifier = 1.3,
						HaltOnEnd = true,
					}
				},
			},
			ClearWeaponFireEffectsOnFireEnd = true,
			ExpireProjectilesOnHitStun = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "ScyllaCone",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "ScyllaConeBoosted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			ConditionalData =
			{
				{
					Data =
					{
						RetreatAfterAttack = false,
						PostAttackDurationMin = 1,
						PostAttackDurationMax = 1,
					},

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			PreAttackDuration = 2.6,
			FireDuration = 7.0,
			PostAttackDurationMin = 1.00,
			PostAttackDurationMax = 1.35,
			FireFx = "ScyllaAttackWave",
			PreAttackFx = "ScyllaChargeFxBelt",
			EndPreAttackFx = true,

			AttackDistance = 1000,
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.6,
			PreAttackStop = false,
			StopMoveWithinRange = false,
			PostAttackStop = true,

			PreAttackRotationDampening = 0.07,
			FireRotationDampening = 0.07,

			RetreatAfterAttack = true,
			RetreatToId = 616838,
			RetreatSetAngle = 330,
			RetreatWaitDuration = 4.0,

			MoveSuccessDistance = 150,
			TrackAtPathEnd = true,

			PreAttackAnimation = "Enemy_Scylla_AttackBeltPrefire",
			FireAnimation = "Enemy_Scylla_AttackBeltInitialFire",
			PostAttackAnimation = "Enemy_Scylla_AttackBeltReturnToIdle",

			WeaponFireLoopingSound = "/SFX/Enemy Sounds/Scylla/ScyllaBeltScreamAttack",
		},

		Requirements =
		{
			--MinPlayerDistance = 500,
			MinAttacksBetweenUse = 8,
		},
	},

	ScyllaWhip =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "ScyllaWhip",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "ScyllaWhipBoosted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			BarrelLength = 100,
			FireProjectileStartDelay = 0.05,
			PreAttackFx = "ScyllaChargeFxMic",
			EndPreAttackFx = true,

			PreAttackAngleTowardTarget = true,

			PreAttackAnimationSpeed = 0.95,
			PreAttackDuration = 0.85,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackStartMinWaitTime = 0.29,
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.6,
			FireDuration = 0.32,
			PostAttackDurationMin = 2.25,
			PostAttackDurationMax = 3.45,

			AttackDistance = 380,
			MoveWithinRange = true,
			MoveWithinRangeTimeout = 6,

			PreAttackAnimation = "Enemy_Scylla_AttackWhipPrefire",
			FireAnimation = "Enemy_Scylla_AttackWhipFire",
			PostAttackAnimation = "Enemy_Scylla_AttackWhipReturnToIdle",
		},

		Requirements =
		{
			MaxPlayerDistance = 700,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "ScyllaBoost" },
				UseLength = true,
				Comparison = "<=",
				Value = 0,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Scylla/ScyllaMeleeAttackSwipe" },
				{ Name = "/SFX/Enemy Sounds/Minotaur/HugeAxeSwing" },
			},
		},
	},

	ScyllaClamUp =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "IdleUnits" },
				UseLength = true,
				Comparison = "<",
				Value = 2,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackLowPass = true,

			PreAttackDurationMin = 4.8,
			PreAttackDurationMax = 6.8,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			NoProjectile = true,
			SkipFireWeapon = true,
			AttackDistance = 9999,
			MoveWithinRange = false,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,

			RetreatBeforeAttack = true,
			RetreatToSpawnPoints = true,
			RetreatBufferDistance = 1250,
			RetreatTimeout = 8,
			RetreatAfterAttack = false,

			ChainedWeapon = "ScyllaClamUpBlast",

			PreAttackAnimation = "Enemy_Scylla_ClamDefenseIntro",
		},
	},

	ScyllaClamUpBlast =
	{
		AIData =
		{
			DeepInheritance = true,

			ConditionalProjectiles =
			{
				{
					ProjectileName = "ScyllaBeltBolt",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{
					ProjectileName = "ScyllaBeltBoltBoosted",

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},
			NumProjectiles = 13,
			ProjectileAngleInterval = 10,
			FireProjectileStartDelay = 0.54,

			PreAttackDuration = 0.5,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,
			PreAttackEndFlashFraction = 0.65,
			FireDuration = 0.0,
			PostAttackDurationMin = 3.5,
			PostAttackDurationMax = 4.5,
			BarrelLength = 100,
			AttackDistance = 9999,
			MoveWithinRange = false,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.10,
			PostAttackStop = true,

			PreAttackAnimation = "Enemy_Scylla_ClamDefenseReturnToIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
			},
		},

	},

	ScyllaClamUp2 =
	{
		InheritFrom = { "ScyllaClamUp" },

		Requirements =
		{
			MinAttacksBetweenUse = 5,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			RetreatBeforeAttack = false,

			PreAttackDurationMin = 0.32,
			PreAttackDurationMax = 0.64,

			ChainedWeapon = "ScyllaClamUpRush",
		},
	},

	ScyllaClamUpRush =
	{
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 2,
			}
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ScyllaClamRush",
			ChainedWeapon = "ScyllaClamUpBlast",

			PreAttackLowPass = true,

			PreAttackSound = "/SFX/Enemy Sounds/Scylla/ScyllaClamChargeup",
			PreAttackDuration = 1.0,
			PreAttackStartMinWaitTime = 0.42,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.65,
			FireDuration = 0.35,
			PostAttackDuration = 0.0,

			AttackDistance = 9999,
			MoveWithinRange = false,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.10,
			PostAttackStop = true,

			FireSelfVelocity = 3000,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "DashGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.35,
						Modifier = 0.1,
						HaltOnEnd = true,
					}
				},
			},

			PreAttackAnimation = "Enemy_Scylla_ClamRushPreFire",
			FireAnimation = "Enemy_Scylla_ClamRushFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Scylla/ScyllaClamFire2" },
			},
		},

	},

	ScyllaClamUp3 =
	{
		InheritFrom = { "ScyllaClamUp" },

		Requirements =
		{
			MinAttacksBetweenUse = 5,
			MinPlayerDistance = 500,
			RequireTotalAttacks = 5,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			RetreatBeforeAttack = false,

			PreAttackDurationMin = 0.32,
			PreAttackDurationMax = 0.64,

			ChainedWeapon = "ScyllaClamUpChase",
		},
	},

	ScyllaClamUpChase =
	{
		GameStateRequirements =
		{
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 2,
			}
		},

		AIData =
		{
			DeepInheritance = true,

			ChainedWeapon = "ScyllaClamUpRush",

			NoProjectile = true,
			ApplyEffectsOnMove =
			{
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

			MoveLowPass = true,
			PreMoveAnimation = "Enemy_Scylla_ClamRushPreFire",
			MoveAnimation = "Enemy_Scylla_ClamRushFireLoop",

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			AttackDistance = 550,
			MoveWithinRange = true,
			SkipFireWeapon = true,

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
			},
		},

	},

	ScyllaSpin =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ScyllaSpin", },
				{ ProjectileName = "ScyllaSpin2", },
				{ ProjectileName = "ScyllaSpin3", },
				{ ProjectileName = "ScyllaSpin4", },
			},
			ExpireProjectilesOnHitStun = true,

			ConditionalData =
			{
				{
					Data =
					{
						RetreatAfterAttack = false,
						PostAttackDurationMin = 3.25,
						PostAttackDurationMax = 3.85,
						PreAttackDumbFireWeapons = { "ScyllaPreviewBolts", "ScyllaSpinBolts" },
					},

					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			ImmuneToProjectileSlow = true,

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			StopBeforeFire = true,

			PreAttackDuration = 1.0,
			FireDuration = 6.5,
			PostAttackDurationMin = 1.55,
			PostAttackDurationMax = 1.85,

			RetreatAfterAttack = true,
			RetreatToId = 616839,
			RetreatSetAngle = 330,
			RetreatWaitDuration = 4.5,

			MoveSuccessDistance = 150,

			AttackDistance = 600,
			AttackDistanceScaleY = 0.9,

			MoveWithinRange = true,
			MoveWithinRangeTimeout = 3.5,

			PreAttackStop = true,
			PostAttackStop = true,
			PreAttackEndShake = true,

			PreAttackAnimation = "Enemy_Scylla_PoseIntro",
			FireAnimation = "Enemy_Scylla_PoseLoop",
			PostAttackAnimation = "Enemy_Scylla_PoseReturnToIdle",

			PreAttackDumbFireWeapons = { "ScyllaPreviewBolts" },
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/SFX/Enemy Sounds/Radiator/EmoteAttacking" },
			},
		},

		Requirements =
		{
			MinAttacksBetweenUse = 3,
		},
	},

	ScyllaPreviewBolts =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ScyllaSpinPreview1", },
				{ ProjectileName = "ScyllaSpinPreview2", },
				{ ProjectileName = "ScyllaSpinPreview3", },
				{ ProjectileName = "ScyllaSpinPreview4", },
			},

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
		}
	},

	ScyllaSpinBolts =
	{
		AIData =
		{
			DeepInheritance = true,
			BarrelLength = 150,

			ProjectileName = "ScyllaBeltBolt",
			NumProjectiles = 6,
			ProjectileAngleEvenlySpaced = true,

			FireTicks = 6,
			FireInterval = 1.0,

			PreAttackDuration = 2.0,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "IdleUnits" },
				UseLength = true,
				Comparison = "<",
				Value = 2,
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire" },
			},
		},

	},

	ScyllaNotes =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ScyllaNotes",

			ConditionalData =
			{
				{
					Data =
					{
						FireDuration = 2.8,
						NumProjectiles = 4,
						ProjectileInterval = 0.70,
						PostAttackDuration = 3.45,
					},
					GameStateRequirements =
					{
						{
							Path = { "MapState", "Flags", "ScyllaBoost" },
							UseLength = true,
							Comparison = ">=",
							Value = 1,
						},
					},
				}
			},

			BarrelLength = 120,

			PreAttackStop = true,
			
			FireProjectileStartDelay = 0.2,

			PreAttackDuration = 1.0,
			FireDuration = 0.9,
			PostAttackDuration = 2.75,

			NumProjectiles = 1,

			PreAttackAnimation = "Enemy_Scylla_HeadbangIntro",
			FireAnimation = "Enemy_Scylla_HeadbangLoop",
			PostAttackAnimation = "Enemy_Scylla_HeadbangReturnToIdle",

			AttackDistance = 1300,
			AttackDistanceScaleY = 0.8,
			RequireProjectileLoS = true,
			LoSBuffer = 80,

			MoveWithinRangeTimeout = 5.0,

			DoNotRepeatOnAttackFail = true,

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Megaera/MegaeraRapidEnergyBlastFire" },
				{ Name = "/SFX/Player Sounds/LyreWeaponPojectileCollide" },
			},
		},

		Requirements =
		{
			MinPlayerDistance = 550,
		},		
	},

	ScyllaHeadbangFinisher =
	{
		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			NoProjectile = true,

			PreAttackDuration = 1.00,
			FireDuration = 10.0,
			PostAttackDuration = 5.5,

			AttackDistance = 9999,
			--MoveToId = 595506,
			MoveWithinRange = false,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			FireFx = "ScyllaAttackWave",
			PreAttackAnimation = "Enemy_Scylla_HeadbangIntro",
			FireAnimation = "Enemy_Scylla_HeadbangLoop",
			PostAttackAnimation = "Enemy_Scylla_HeadbangReturnToIdle",

			--PreAttackFunctionName = "FireFloodTraps",

			SpawnBurstOnFire = true,
			SpawnRate = 0.134,
			SpawnOnSpawnPoints = true,
			SpawnRadius = 9999,
			SpawnsPerBurstMin = 75,
			SpawnsPerBurstMax = 75,
			MaxActiveSpawns = 40,
			SpawnerOptions = { "FishSwarmer" },
			SpawnAggroed = true,
			SkipLocationBlockedCheck = true,
		},

		Requirements =
		{
			MaxUses = 5,
		},

		FireRadialBlur = { Distance = 0.5, Strength = 0.5, FXHoldTime = 8.0, FXInTime = 0.15, FXOutTime = 0.15 },
		FireScreenshake = { Distance = 5, Speed = 800, Duration = 0.7, FalloffSpeed = 3000 },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 },
		},
	},

	ScyllaHeadbangFinisher2 =
	{
		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "ScyllaNotesFinale",
			NumProjectiles = 4,
			ProjectileInterval = 0.70,

			FireTicks = 999,
			FireInterval = 5.6,

			PreAttackDuration = 1.00,
			FireDuration = 0.0,
			PostAttackDuration = 3.0,

			AttackDistance = 700,
			MoveWithinRange = true,
			MoveToClosestId = { 743884, 40191, 743880, 743879, 743883, },

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.08,
			TrackTargetDuringFire = true,
			TrackTargetAngleOffset = 180,
			FireRotationDampening = 0.04,
			PostAttackStop = true,

			FireFx = "ScyllaAttackWave",
			PreAttackAnimation = "Enemy_Scylla_HeadbangIntro",
			FireAnimation = "Enemy_Scylla_HeadbangLoop",
			PostAttackAnimation = "Enemy_Scylla_HeadbangReturnToIdle",

			SpawnBurstPerTick = true,
			SpawnRate = 0.18,
			SpawnOnSpawnPoints = true,
			SpawnRadius = 9999,
			SpawnsPerBurstMin = 8,
			SpawnsPerBurstMax = 8,
			MaxActiveSpawns = 30,
			SpawnerOptions = { "FishSwarmer_Elite", "Jellyfish_Scylla" },
			SpawnAggroed = true,
			SkipLocationBlockedCheck = true,
		},

		FireRadialBlur = { Distance = 0.5, Strength = 0.5, FXHoldTime = 8.0, FXInTime = 0.15, FXOutTime = 0.15 },
		FireScreenshake = { Distance = 5, Speed = 800, Duration = 0.7, FalloffSpeed = 3000 },
		FireRumbleParameters =
		{
			{ ScreenPreWait = 0.02, RightFraction = 0.17, Duration = 0.7 },
		},

	},

	ScyllaHeadbangFinisherHold =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			MoveWithinRange = false,

			PreAttackFunctionName = "FireFloodTraps",

			PreAttackDuration = 1.00,
			FireDuration = 4.0,
			PostAttackDuration = 2.25,

			PreAttackAnimation = "Enemy_Scylla_HeadbangIntro",
			FireAnimation = "Enemy_Scylla_HeadbangLoop",
			PostAttackAnimation = "Enemy_Scylla_HeadbangReturnToIdle",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil