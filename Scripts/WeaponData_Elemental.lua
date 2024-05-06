WeaponSetData =
{
	DespairElementalChase =
	{
		AIData =
		{
			DeepInheritance = true,
			WaitForAngleTowardTarget = false,
			NoProjectile = true,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "RamRotationDamp",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Duration = 9999,
						RotationMultiplier = 0.50,
					}
				},

				{
					EffectName = "SpeedIncrease",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "Speed",
						Duration = 9999,
						Modifier = 1.2,
					}
				},
			},

			ClearWeaponFireEffectsOnFireEnd = true,
			ExpireProjectilesOnHitStun = true,

			PreAttackStop = true,
			PreAttackDuration = 0.8,
			FireDuration = 9999.0,
			PostAttackDuration = 1.0,
			PostAttackCooldownMin = 0.0,
			PostAttackCooldownMax = 0.1,
			StopMoveWithinRange = false,
			FireMoveTowardTarget = true,
			--PostAttackStop = true,

			--PreAttackEndShake = true,
			--PreAttackEndDuration = 0.385,
			--PreAttackEndFlashFraction = 0.5,

			AttackDistance = 9999,
			MoveSuccessDistance = 25,
			TrackAtPathEnd = true,

			PreAttackSound = "/SFX/Enemy Sounds/DespairElementalRegular/EmoteCharging",
			PreAttackAnimation = "Enemy_DespairElemental_Chase_Start",
			FireAnimation = "Enemy_DespairElemental_Chase_FireLoop",
			PostAttackAnimation = "Enemy_DespairElemental_Chase_End",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/DespairElementalRegular/EmoteAttacking" },
			},
		},
	},

	DespairElementalRam =
	{
		ProjectileName = "DespairElementalRam",

		SkipCanAttack = true,
		CancelOnPolymorph = true,
		ExpireProjectilesOnPolymorph = true,

		DumbFireInterval = 10.0,
	},

	DespairElementalLargeRam =
	{
		ProjectileName = "DespairElementalLargeRam",

		SkipCanAttack = true,
		CancelOnPolymorph = true,
		ExpireProjectilesOnPolymorph = true,

		DumbFireInterval = 10.0,
	},


	TimeElementalBuff =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TimeElementalBuff",
			FireProjectileAtSelf = true,
			TargetRequiredKillEnemy = true,

			PreAttackDuration = 1.6,
			FireDuration = 1.25,
			PostAttackDuration = 1.1,

			MoveWithinRange = true,
			AttackDistance = 250,

			RetreatBufferDistance = 1200,
			RetreatAfterAttack = true,
			RetreatTimeoutMin = 4.0,
			RetreatTimeoutMax = 5.0,
			
			PreAttackAnimation = "Enemy_TimeElemental_PreAttack",
			FireAnimation = "Enemy_TimeElemental_Attack",
			PostAttackAnimation = "Enemy_TimeElemental_AttackPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeSmall/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeSmall/Attack" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TimeElementalOrbit =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TimeElementalOrbit",
			FireProjectileStartDelay = 0.1,
			--NoProjectile = true,

			ApplyEffectsOnMove =
			{
				{
					EffectName = "TimeElementalSpeedBoost",
					DataProperties = 
					{
						Type = "Speed",
						Duration = 2.0,
						Modifier = 3.0,
						HaltOnEnd = true,
					}
				},
			},
			SkipClearEffectsOnMoveEnd = true,

			PreMoveAnimation = "Enemy_TimeElemental_PreAttack",
			PreMoveDuration = 1.05,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,
			PreAttackDuration = 2.5,
			PreAttackEndStop = true,
			PreAttackSound = "/SFX/Enemy Sounds/TimeElemental/TimeElementalChargeUp",
			PreAttackFx = "TimeElementalOrbitPreAttackFx",
			FireDuration = 0.5,
			--PostAttackDuration = 5.0,
			RetreatAfterAttack = true,
			RetreatBufferDistance = 1200,
			RetreatTimeoutMin = 6,
			RetreatTimeoutMax = 6,

			MoveWithinRange = true,
			MoveSuccessDistance = 630,
			AttackDistance = 9999,
			StopMoveWithinRange = false,
			
			FireAnimation = "Enemy_TimeElemental_AttackPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedShadeSmall/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/TimeElemental/TimeElementalProjectileFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TimeElementalOrbit_Elite =
	{
		InheritFrom = { "TimeElementalOrbit" },

		AIData =
		{
			DeepInheritance = true,

			FireTicks = 3,
			FireInterval = 0.75,
			FireDuration = 2.25,
		},
	},

	TimeElementalDeath =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TimeElementalDeathRadial",
			FireProjectileAtSelf = true,

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.6,
			PreAttackDuration = 0.0,
			FireDuration = 1.6,
			PostAttackDuration = 0.0,
			
			--PreAttackFx = "LobWarningDecalTimeElemental",
			--PreAttackSound = "/SFX/Enemy Sounds/FishmanRanged/EmoteAboutToExplode",

			FireAnimation = "Enemy_TimeElemental_Death",

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGrab" },
			},
		},

		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.03, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	GoldElementalBeam =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GoldElementalBeam",
			ExpireProjectilesOnHitStun = true,
			ExpireProjectilesOnFreeze = true,
			
			MaxAttackers = 4,

			FireSelfVelocity = 1050,
			FireSelfVelocityAngleOffset = 180,

			WaitForAngleTowardTarget = true,
			PreAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/GoldElemental/EmoteChargingRanged",
			PreAttackFx = "GoldElementalBeamPreview",
			--PreAttackFxBetween = "GoldBeamPreview",
			--PreAttackFxMaintainStretch = true,
			--PreAttackFxBetweenTarget = true,
			EndPreAttackFx = true,

			AttackDistance = 1250,
			AttackDistanceScaleY = 0.45,
			PreAttackAngleTowardTarget = true,
			PreAttackEndShake = true,

			PreAttackDuration = 2.12,
			PreAttackAnimationSpeed = 0.5,
			FireDuration = 0.95,
			PostAttackDuration = 1.15,

			RequireProjectileLoS = true,
			LoSBuffer = 30,

			PreAttackAnimation = "Enemy_GoldElemental_BeamPreFire",
			FireAnimation = "Enemy_GoldElemental_BeamFire",
			PostAttackAnimation = "Enemy_GoldElemental_BeamPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/GoldElemental/EmoteAttackingRanged" },
			},
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	GoldElementalBeam_Elite =
	{
		InheritFrom = { "GoldElementalBeam" },
		AIData =
		{
			DeepInheritance = true,

			MaxAttackers = 8,

			TrackTargetDuringFire = true,
			FireRotationDampening = 0.007,
			PostAttackStop = true,

			ProjectileName = "GoldElementalBeam_Elite",
			FireDuration = 1.8,
			PostAttackDuration = 0.7,
		},
	},

	GoldElementalBeam_MiniBoss =
	{
		InheritFrom = { "GoldElementalBeam" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GoldElementalBeam_MiniBoss",

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGripLong,
			},

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.026,
			StopBeforeFire = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.076,
			PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteChargingRanged",
			FireDuration = 1.8,
			PostAttackDuration = 1.3,
		},
	},

	GoldElementalSky =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GoldElementalSky",
			FireProjectileStartDelay = 0.3,

			CreateOwnTarget = true,
			TargetSelf = true,
			FireProjectileAtSelf = true,
			TargetOffsetDistance = 100,

			FireSelfVelocity = 1600,
			FireSelfUpwardVelocity = 0,

			MoveWithinRange = false,
			AttackDistance = 9999,

			PreAttackDuration = 0.28,
			FireDuration = 0,
			PostAttackDuration = 0.5,

			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,

			PreAttackSound = "/SFX/Enemy Sounds/Wringer/WringerChargeUp",
			PreAttackAnimation = "Enemy_GoldElemental_SkyPreFire",
			--FireAnimation = "Enemy_GoldElemental_SkyFire",
			PostAttackAnimation = "Enemy_GoldElemental_SkyFire",
		},

		Requirements =
		{
			MaxConsecutiveUses = 2
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/GoldElementalMiniboss/GoldElementalSlam" },
				{ Name = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteAttackingRanged" },
			},
		},
	},

	GoldElementalGround =
	{
		AIData =
		{
			DeepInheritance = true,
			ImmuneToProjectileSlow = true,

			ProjectileName = "GoldElementalGround",
			FireProjectileAtSelf = true,
			FireTicksMin = 16,
			FireTicksMax = 20,
			FireIntervalMin = 0.1,
			FireIntervalMax = 0.2,
			Spread = 360,

			AttackDistance = 9999,

			PreAttackDuration = 1.03,
			FireDuration = 0.3,
			PostAttackDuration = 0.65,

			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,

			PreAttackSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_GoldElemental_GroundPreFire",
			FireAnimation = "Enemy_GoldElemental_GroundFire",
			PostAttackAnimation = "Enemy_GoldElemental_GroundPostFire",
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.06, LerpTime = 0 },
			{ ScreenPreWait = 0.18, Fraction = 1.0, LerpTime = 0.1 },
		},

		Requirements =
		{
			MaxConsecutiveUses = 2
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteAttackingMelee" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil