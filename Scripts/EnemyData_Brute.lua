UnitSetData.Brute =
{

	Brute =
	{
		InheritFrom = { "BaseQEnemy", "BaseVulnerableEnemy", "LowPolyEnemy" },

		ActivateAnimation = "Enemy_Brute_Spawn",
		ActivateFx = "TyphonBruteSpawnFx",
		ActivateFx2 = "null",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1, 
		ActivateDuration = 0.25,
		WakeUpDelay = 1,
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.6, Angle = 90, DistanceThreshold = 200 },

		MaxHealth = 2800,

		HealthBarOffsetY = -310,
		HealthBarType = "ExtraLarge",
		ArmorSparkAnimation = "HitSparkArmor_Large",
		DeathFx = "EnemyDeathFxTyphon",
		DeathAnimation = "Enemy_Brute_Death",
		DeathSound = "/SFX/Enemy Sounds/TyphonBrute/EmoteDying",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/TyphonBrute/EmoteAlerted",
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_Brute_OnHit",
			Heavy = "Enemy_Brute_OnHit_Heavy",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 1
			},
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "MiniBossBrute" },
			},
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,
		PostAggroAI = "SurroundAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundRetaliateDistance = 550,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 1,
		},

		WeaponOptions =
		{
			"BruteMelee1",
			"BruteCharge",
		},

		BlockAttributes = { "Orbit", "Vacuum" },

		ActiveCapWeight = 10/12,
		GeneratorData =
		{
			DifficultyRating = 200,
			BlockEnemyTypes = {"Brute_Elite"}
		},

		EnemySightedVoiceLines =
		{
			{ GlobalVoiceLines = "MonstersSightedVoiceLines" },
		},
	},

	Brute_Elite =
	{
		InheritFrom = { "Elite", "Brute" },
		HealthBuffer = 2800,
		IsAggroedSound = "/SFX/Enemy Sounds/TyphonBrute/EmoteTaunting",
		
		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex", "Metallic" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		WeaponOptions =
		{
			"BruteMelee1_Elite", "BruteMeleeRetaliate_Elite",
			"BruteCharge_Elite",
		},

		GeneratorData =
		{
			DifficultyRating = 400,
			BlockEnemyTypes = {"Brute"}
		},
	},

	Brute_Miniboss =
	{
		InheritFrom = { "BaseBossEnemy", "Brute" },
		RunHistoryKilledByName = "BruteMinibossCodex",
		WakeUpDelay = 0,
		MaxHealth = 25000,
		HealthBarOffsetY = -370,
		HealthBarType = "ExtraLarge",
		DeathFx = "EnemyDeathFxTyphon",
		IsBoss = false,
		BlockRaiseDead = true,
		BlockPostBossMetaUpgrades = true,
		IgnoreSprintPhasingStasisStun = true,
		BlockCharm = true,
		ImmuneToPolymorph = true,
		DeathAnimation = "Enemy_Brute_Miniboss_Death",
		OnDeathFunctionName = "GenericBossKillPresentation",
		CauseOfDeathDisplayData = 
		{
			GameStateRequirements = 
			{
				{
					PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
				}
			},
			Name = "Brute_Miniboss_Alt",
		},
		GrannyTexture = "GR2/TyphonBruteMiniboss_Color",

		InvulnerableFx = "nil",
		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		OnDeathFunctionArgs =
		{
			MusicMutedStems = { "Guitar", "Bass" },
			Message = "BruteMinibossDefeatedMessage",
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			FlashRed = true,
			IgnoreEndMusic = true
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"BruteMelee1_Miniboss",
			"BruteCharge_Miniboss",
			"BruteSlam",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0.0,
			}
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		GeneratorData =
		{
			DifficultyRating = 200,
			BlockEnemyTypes = {"Brute"}
		},

		AltHealthBarTextIds =
		{
			{ TextId = "Brute_Miniboss_Alt",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					}
				},
			},
		},
	},

	Brute_Shadow =
	{
		InheritFrom = { "Shadow", "Brute" },
		MaxHealth = 2400,
		HealthBuffer = 5800,
		HealthBarOffsetY = -370,
		HealthBarType = "ExtraLarge",
		IsAggroedSound = "/SFX/Enemy Sounds/EarthElemental/EmoteTaunting",
		DeathFx = "EnemyDeathFxTyphon",

		InvulnerableFx = "nil",
		SkipDamagedFx = true,
		SkipUnitHitFlash = true,
		ArmorSparkAnimation = "Blank",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"BruteMelee1_Elite", "BruteMeleeRetaliate_Elite",
			"BruteCharge_Elite",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0.0,
			}
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		GeneratorData =
		{
			DifficultyRating = 200,
			BlockEnemyTypes = {"Brute"}
		},
	},

	Brute2 =
	{
		InheritFrom = { "Brute_Elite" },
		GenusName = "Brute_Elite",
		RunHistoryKilledByName = "Brute",
		MaxHealth = 2800,
		HealthBuffer = 2800,

		DefaultAIData =
		{
			DeepInheritance = true,

			MaxAttackers = 3,
		},

		SpellSummonDataOverrides =
		{
			WeaponOptions =
			{
				"Brute2Melee_Ally"
			},
		},

		WeaponOptions =
		{
			"Brute2Melee",
			"Brute2Charge",
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Brute )

WeaponSetData =
{
	BruteMelee1 =
	{
		Requirements =
		{
			MaxPlayerDistance = 550,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BruteMelee1",
			FireProjectileStartDelay = 0.08,

			AttackDistance = 400,
			AttackDistanceScaleY = 0.5,
			MoveWithinRangeTimeout = 4.5,
			SkipAttackIfMoveTimeout = true,
			FireSelfVelocity = 600,

			PreAttackFx = "EnemyChargeFxIn_Brute",
			PreAttackAnimation = "Enemy_Brute_Melee1_PreFire",
			PreAttackSound = "/SFX/Enemy Sounds/TyphonBrute/EmoteCharging",
			FireAnimation = "Enemy_Brute_Melee1_Fire",
			PostAttackAnimation = "Enemy_Brute_Melee1_PostFire",

			PreAttackDuration = 0.8,
			FireDuration = 0.28,
			PostAttackDuration = 1.32, -- anim is 0.88

			RequireUnitLoS = true,
			LoSBuffer = 100,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.03,
			StopBeforeFire = true,

			DoNotRepeatOnAttackFail = true,
			SkipSurroundAICount = true,

			--ChainedWeaponOptions = { "BruteMelee2", },
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Player Sounds/GunFinalBulletBlastSFX" },
				{ Name = "/SFX/Enemy Sounds/TyphonBrute/EmoteAttacking" },
			},
		},
	},
	BruteMelee1_Elite =
	{
		InheritFrom = { "BruteMelee1" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BruteMelee1_Elite",
		},
	},
	BruteMelee1_Miniboss =
	{
		InheritFrom = { "BruteMelee1" },

		Requirements =
		{
			MaxPlayerDistance = 700,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BruteMelee1_Miniboss",

			FireSelfVelocity = 800,
			AttackDistance = 600,
			RequireUnitLoS = false,
			MoveWithinRangeTimeout = 3.5,
			SkipAttackIfMoveTimeout = false,

			PostAttackDuration = 0.3, -- anim is 0.88

			ChainedWeaponOptions = { "BruteMelee2_Miniboss", },
		},
	},
	Brute2Melee =
	{
		InheritFrom = { "BruteMelee1" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "Brute2Melee1",
		},
	},
	Brute2Melee_Ally =
	{
		InheritFrom = { "Brute2Melee" },

		Requirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 800,
			AttackDistance = 1000,
			RequireUnitLoS = false,
			MoveWithinRangeTimeout = 3.5,
			SkipAttackIfMoveTimeout = false,
		},
	},
	BruteMelee2 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BruteMelee2",
			FireProjectileStartDelay = 0.08,

			AttackDistance = 9999,
			MoveWithinRange = false,
			FireSelfVelocity = 800,

			PreAttackFx = "EnemyChargeLeftFxIn_Brute",
			PreAttackAnimation = "Enemy_Brute_Melee2_PreFire",
			PreAttackSound = "/SFX/Enemy Sounds/TyphonBrute/EmoteCharging",
			FireAnimation = "Enemy_Brute_Melee2_Fire",
			PostAttackAnimation = "Enemy_Brute_Melee2_PostFire",

			PreAttackDuration = 0.4,
			FireDuration = 0.28,
			PostAttackDuration = 1.32, -- anim is 0.88

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.2,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.03,
			StopBeforeFire = true,

			DoNotRepeatOnAttackFail = true,
			SkipSurroundAICount = true,

			--ChainedWeaponOptions = { "BruteHeadbutt", },
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Player Sounds/GunFinalBulletBlastSFX" },
				{ Name = "/SFX/Enemy Sounds/TyphonBrute/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/ZombieCaptain/EmoteFiring" }
			},
		},
	},
	BruteMelee2_Miniboss =
	{
		InheritFrom = { "BruteMelee2" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "BruteMelee2_Miniboss",

			PostAttackDuration = 0.3,

			ChainedWeaponOptions = { "BruteHeadbutt_Miniboss", },
		},
	},
	BruteHeadbutt =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BruteHeadbutt",
			FireProjectileStartDelay = 0.12,

			CreateOwnTarget = true,
			TargetOffsetDistance = 220,
			FireSelfVelocity = 800,
			FireSelfVelocityAngleOffset = 180,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Brute_Melee3_PreFire",
			PreAttackSound = "/SFX/Enemy Sounds/TyphonBrute/EmoteCharging",
			FireFx = "BruteHeadbuttFx_In",
			FireAnimation = "Enemy_Brute_Melee3_Fire",
			PostAttackAnimation = "Enemy_Brute_Melee3_PostFire",

			PreAttackDuration = 0.8,
			FireDuration = 0.28,
			PostAttackDuration = 1.62, -- anim is 1.22

			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.03,
			StopBeforeFire = true,

			DoNotRepeatOnAttackFail = true,
			SkipSurroundAICount = true,
		},

		Sounds =
		{
			FireSounds =
			{
				-- { Name = "/SFX/Player Sounds/GunFinalBulletBlastSFX" },
				{ Name = "/SFX/Enemy Sounds/TyphonBrute/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/ZombieCaptain/EmoteFiring" }
			},
		},
	},

	BruteHeadbutt_Miniboss =
	{
		InheritFrom = { "BruteHeadbutt" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "BruteHeadbutt_Miniboss",
		},
	},

	BruteMeleeRetaliate =
	{
		InheritFrom = { "BruteMelee1" },

		AIData =
		{
			DeepInheritance = true,
		},
		Requirements =
		{
			MinAttackers = 1,
		},
	},
	BruteMeleeRetaliate_Elite =
	{
		InheritFrom = { "BruteMelee1_Elite" },
		Requirements =
		{
			MinAttackers = 1,
		},
	},

	BruteCharge =
	{
		Requirements =
		{
			MinPlayerDistance = 550,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BruteChargeHorn",
			FireProjectileStartDelay = 0.1,

			ApplyEffectsOnMove =
			{
				{
					EffectName = "ChargeRotationDamp",
					DataProperties = 
					{
						Duration = 9999,
						RotationMultiplier = 1.5,
					}
				},

				{
					EffectName = "SpeedIncrease",
					DataProperties = 
					{
						Type = "Speed",
						Duration = 9999,
						Modifier = 3.25,
					}
				},
			},

			PreMoveFunctionName = "WeaponSetImmuneToStun",
			PreAttackFunctionName = "WeaponRevertStunImmunity",
			MoveDumbFireWeapons = { "BruteChargeRadial" },
			EndMoveDumbFireWeapons = true,

			PreMoveAngleTowardTarget = true,
			PreMoveWaitForAngleTowardTarget = true,
			PreMoveStop = true,
			PreMoveDuration = 1.3,
			PreMoveAnimation = "Enemy_Brute_ChargePreFire",
			MoveAnimation = "Enemy_Brute_ChargeRunStart",
			StopMoveWithinRange = false,
			PreAttackDuration = 0.0,
			FireDuration = 0.25,
			PostAttackDuration = 1.0, -- anim is 0.55

			StopBeforeFire = true,

			MoveWithinRangeTimeout = 2.5,
			AttackDistance = 450,
			AttackDistanceScaleY = 0.5,
			TrackAtPathEnd = true,

			FireAnimation = "Enemy_Brute_ChargeFire",
			PostAttackAnimation = "Enemy_Brute_ChargePostFire",

			DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			PreMoveSounds =
			{ Name = "/SFX/Enemy Sounds/TyphonBrute/EmotePowerCharging" },
		},
	},

	BruteCharge_Elite =
	{
		InheritFrom = { "BruteCharge" },

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRangeTimeout = 1.5,
		},
	},
	Brute2Charge =
	{
		InheritFrom = { "BruteCharge" },

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRangeTimeout = 1.5,
		},
	},

	BruteCharge_Miniboss =
	{
		InheritFrom = { "BruteCharge" },

		Requirements =
		{
			MinPlayerDistance = 425,
			MaxAttackers = 1,
			MaxConsecutiveUses = 2,
			RequireUnitLoS = true,
			LoSBuffer = 100,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			AttackSlots =
			{
				{ ProjectileName = "BruteChargeHorn_Miniboss", },
				{ ProjectileName = "BruteChargeWave_Miniboss", },
			},

			MoveDumbFireWeapons = { "BruteChargeRadial_Miniboss" },
			EndMoveDumbFireWeapons = true,

			PostAttackDuration = 1.0, -- anim is 0.55

			AttackDistance = 550,

			MoveWithinRangeTimeout = 1.5,
			AngleTowardsTargetWhileFiring = true,
			
			MoveAnimation = "Enemy_Brute_ChargeRunStart_Miniboss",
		},
	},

	BruteChargeRadial =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BruteChargeRadial",
			AttackSlots =
			{
				{ OffsetFromAttacker = true, PauseDuration = 0.2, },
				{ OffsetFromAttacker = true, PauseDuration = 0.25, },
			},
			DumbFireInterval = 0,
			AlwaysUseDumbFireThreadName = true,
			CancelOnPolymorph = true,
			BarrelLength = 200,

			PreAttackSlotsWait = 0.3,
			FireProjectileStartDelay = 0.0,

			FireProjectileAtTarget = true,
			TargetSelf = true,
			PreAttackStop = true,
			SkipCanAttack = true,
		},

		FireScreenshake = { Distance = 5, Speed = 300, Duration = 0.5, FalloffSpeed = 3000, Angle = 90 },
	},

	BruteChargeRadial_Miniboss =
	{
		InheritFrom = { "BruteChargeRadial" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "BruteChargeRadial_Miniboss",
		},
	},

	BruteSlam =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "BruteSlamShockwave", },
				{ ProjectileName = "BruteSlamShockwave2", },
				{ ProjectileName = "BruteSlamShockwave3", },
			},
			FireProjectileAtSelf = true,

			AttackDistance = 1000,

			PreAttackAnimation = "Enemy_Brute_ChargePreFire",
			PreFireAnimation = "Enemy_Brute_SlamLeap",
			FireAnimation = "Enemy_Brute_SlamLanding",
			--PostAttackAnimation = "Enemy_Brute_ChargePostFire",

			ChargeSelfVelocity = 1200,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackVeryLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.29,
						Modifier = 0.05,
						HaltOnEnd = true,
					}
				}
			},

			PreAttackDuration = 1.3,
			PreFireDuration = 0.3,
			FireDuration = 1.0,
			PostAttackDuration = 0.8,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.01,
			StopBeforeFire = true,

		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil