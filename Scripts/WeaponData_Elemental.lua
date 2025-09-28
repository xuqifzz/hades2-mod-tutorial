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
						RotationMultiplier = 0.7,
					}
				},

				{
					EffectName = "SpeedIncrease",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "Speed",
						Duration = 9999,
						Modifier = 1.4,
					}
				},
			},

			ClearWeaponFireEffectsOnFireEnd = true,

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
	DespairElementalChase_Ally =
	{
		InheritFrom = { "DespairElementalChase" },
		AIData =
		{
			DeepInheritance = true,

			FireDuration = 8.0,
		},
	},

	DespairElementalRam =
	{
		AIData =
		{
			ProjectileName = "DespairElementalRam",

			SkipCanAttack = true,
			CancelOnPolymorph = true,
			RestartOnHitStunClear = true,
			ExpireProjectilesOnPolymorph = true,
			ExpireProjectilesOnHitStun = true,

			DumbFireInterval = 10.0,
		}
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
			PreAttackDuration = 1.75,
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
			MoveSuccessDistance = 410,
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
			
			PreAttackFunctionName = "WeaponSetImmuneToStun",
			PreAttackSetThingProperties =
			{
				ImmuneToForce = true
			},

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
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosTock" },
			},
		},
	},

	TimeElementalHealBeam =
	{
		AIData =
		{
			DeepInheritance = true,
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							PathFromSource = true,
							PathTrue = { "Charmed" },
						},
					},
					Data =
					{
						TargetClosestOfTypes = "nil",
						TargetPlayer = true,
						ProjectileName = "TimeElementalHealBeam_Ally",
					},
				},
			},
			TargetClosestOfTypes = { "Chronos", },

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "FireSpeedDamp",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "SPEED",
						Duration = 3.4,
						Modifier = 0.25,
					}
				},
			},

			ProjectileName = "TimeElementalHealBeam",
			BarrelLength = 0,
			FireProjectileStartDelay = 0.12,
			ExpireProjectilesOnHitStun = true,
			ExpireProjectilesOnFreeze = true,
			ExpireProjectilesOnPolymorph = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,
			SkipRetreatEndStop = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackSound = "/SFX/Enemy Sounds/EarthElemental/EmoteCharging",
			PreAttackAnimation = "Enemy_TimeElemental_PreAttack",
			FireAnimation = "Enemy_TimeElemental_AttackPostFire",
			PreAttackFx = "TimeElementalBeamPreview",
			EndPreAttackFx = true,

			PreAttackDuration = 1.0,
			FireDuration = 3.4,
			PostAttackDurationMin = 1.3, -- anim is 0.65
			PostAttackDurationMax = 1.8,

			RetreatWhileFiring = true,
			RetreatToSpawnPoints = true,
			RetreatBufferDistance = 1000,
			RetreatProximity = 50,
			RetreatOccupySpawnPoint = true,

			AttackDistance = 150,
			AttackDistanceScaleY = 0.5,

			MoveToClosestSpawnPoint = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EarthElemental/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusBloodshotFire" },
			},
		},
	},

	TimeElementalHealBeam_EM =
	{
		InheritFrom = { "TimeElementalHealBeam" },
		AIData =
		{
			DeepInheritance = true,
			
			ProjectileName = "TimeElementalHealBeam_EM",
		},
	},

	TimeElementalHealBeam_Typhon =
	{
		InheritFrom = { "TimeElementalHealBeam" },
		AIData =
		{
			DeepInheritance = true,
			
			ProjectileName = "TimeElementalHealBeam_Typhon",
			TargetClosestOfTypes = { "TyphonHead", },
		},
	},

	TimeElementalHealBeam_Ally =
	{
		InheritFrom = { "TimeElementalHealBeam" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TimeElementalHealBeam_Ally",
			TargetClosestOfTypes = "nil",
			TargetPlayerIfNoTarget = true,
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

			PreAttackDuration = 1.41,
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
	},

	GoldElementalBeam_Elite =
	{
		InheritFrom = { "GoldElementalBeam" },
		AIData =
		{
			DeepInheritance = true,

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

		Requirements =
		{
			MinPlayerDistance = 800,
		},

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GoldElementalBeam_MiniBoss",

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGripLong,
			},

			AttackDistance = 9999,
			MoveWithinRange = false,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.3,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.036,
			StopBeforeFire = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.024,
			PostAttackStop = true,

			PreAttackSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteChargingRanged",
			FireDuration = 1.8,
			PostAttackDuration = 1.3,
		},
	},

	GoldElementalGround =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1
		},

		AIData =
		{
			DeepInheritance = true,
			ImmuneToProjectileSlow = true,

			ProjectileName = "GoldElementalGround",
			FireProjectileAtSelf = true,
			FireProjectileTowardTarget = true,
			FireTicksMin = 15,
			FireTicksMax = 20,
			FireIntervalMin = 0.1,
			FireIntervalMax = 0.2,
			Spread = 90,

			AttackDistance = 9999,

			PreAttackDuration = 1.03,
			FireDuration = 0.3,
			PostAttackDuration = 0.65,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.2,

			PreAttackSound = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_GoldElemental_GroundPreFire",
			FireAnimation = "Enemy_GoldElemental_GroundFire",
			PostAttackAnimation = "Enemy_GoldElemental_GroundPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/GoldElementalMiniboss/EmoteAttackingMelee" },
			},
		},
	},


	GoldElementalJumpCombo =
	{
		Requirements =
		{
			MaxPlayerDistance = 800,
			MinAttacksBetweenUse = 3,
		},

		WeaponComboOnly = true,
		AIData =
		{
			SkipFireWeapon = true,
		},

		WeaponCombo =
		{
			{ WeaponName = "GoldElementalSky", },
			{ WeaponName = "GoldElementalSky", DataOverrides = { TargetSpawnPoints = false, PreAttackAngleTowardTarget = false, WaitForAngleTowardTarget = false, }},
		},
	},

	GoldElementalSky =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "GoldElementalSky",
			FireProjectileStartDelay = 0.3,

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 9999,
			TargetSpawnPointsRadiusMin = 1400,
			TargetSpawnPointsRequireLoS = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			FireProjectileAtSelf = true,
			TargetOffsetDistance = 100,

			FireSelfVelocity = 1800,

			MoveWithinRange = false,
			AttackDistance = 9999,

			PreAttackDuration = 0.28,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,

			PreAttackSound = "/SFX/Enemy Sounds/Wringer/WringerChargeUp",
			PreAttackAnimation = "Enemy_GoldElemental_SkyPreFire",
			FireAnimation = "Enemy_GoldElemental_SkyFire",
			--PostAttackAnimation = "Enemy_GoldElemental_SkyFire",
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
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil