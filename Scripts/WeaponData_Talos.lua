WeaponSetData =
{
	TalosShieldThrow =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.05,

			AngleTowardsTargetWhileFiring = true,
			PreAttackStop = true,
			FireProjectileTowardTarget = true,

			AttackSlots =
			{
				{ ProjectileName = "TalosShieldThrowRight", UseAttackerAngle = true, OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, OffsetAngle = -60, },
				{ ProjectileName = "TalosShieldThrowLeft", UseAttackerAngle = true, OffsetDistance = 850, OffsetScaleY = 0.48, OffsetFromAttacker = true, OffsetAngle = 60 },
			},
			BarrelLength = 50,

			MoveWithinRange = true,
			AttackDistance = 870,

			PreAttackDuration = 0.8,
			FireDuration = 1.9,
			PostAttackDuration = 2.0,

			PreAttackSound = "/SFX/Enemy Sounds/Talos/EmoteCharging",
			PreAttackAnimation = "Enemy_Talos_ThrowPreFire",
			FireAnimation = "Enemy_Talos_ThrowFire",
			PostAttackAnimation = "Enemy_Talos_ThrowPostFire",

		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Talos/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosScytheWhirl" },
			},
		},
	},


	TalosShieldStraightThrowSelector =
	{
		GenusName = "TalosShieldStraightThrow",
		WeaponSelectorOnly = true,
		Requirements =
		{
			MaxConsecutiveUses = 1,
			MinPlayerDistance = 300,
		},
		SelectorOptions =
		{
			"TalosShieldThrowLeft",
			"TalosShieldThrowRight",
		},
	},

	TalosShieldThrowLeft =
	{
		GenusName = "TalosShieldStraightThrow",

		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.05,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.1,
			StopBeforeFire = true,

			ProjectileName = "TalosShieldThrowStraightL",
			BarrelLength = 50,

			MoveWithinRange = true,
			AttackDistance = 870,

			PreAttackDuration = 0.8,
			FireDuration = 0.8,
			PostAttackDuration = 1.2,

			PreAttackSound = "/SFX/Enemy Sounds/Talos/EmoteCharging",
			PreAttackAnimation = "Enemy_Talos_ThrowLeftPreFire",
			FireAnimation = "Enemy_Talos_ThrowLeftFire",
			PostAttackAnimation = "Enemy_Talos_ThrowLeftPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Talos/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Chronos/ChronosScytheWhirl" },
			},
		},
	},

	TalosShieldThrowRight =
	{
		InheritFrom = { "TalosShieldThrowLeft" },
		GenusName = "TalosShieldStraightThrow",

		AIData =
		{
			DeepInheritance = true,
			FireProjectileStartDelay = 0.06,
			ProjectileName = "TalosShieldThrowStraight",
			PreAttackAnimation = "Enemy_Talos_ThrowRightPreFire",
			FireAnimation = "Enemy_Talos_ThrowRightFire",
			PostAttackAnimation = "Enemy_Talos_ThrowRightPostFire",
		},
	},

	TalosMagnet =
	{
		GenusName = "TalosMagnet",

		Requirements =
		{
			--MaxConsecutiveUses = 1,
			MinPlayerDistance = 300,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TalosMagnet",

			PreAttackFx = "TalosMagnetFx",
			EndPreAttackFx = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,

			PreAttackDuration = 1.0,
			FireDuration = 0.41,
			PostAttackDuration = 0.0,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.1,
			StopBeforeFire = true,

			PreAttackSound = "/SFX/Enemy Sounds/Talos/EmotePowerCharging",
			PreAttackAnimation = "Enemy_Talos_MagnetPreFire",
			FireAnimation = "Enemy_Talos_MagnetFire",

			AttackDistance = 700,
			RequireProjectileLoS = true,
			LoSBuffer = 100,

			ChainedWeapon = "TalosPunch",

			WeaponFireLoopingSound = "/SFX/Enemy Sounds/Chronos/ChronosSuctionStartAndLoop",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Talos/EmotePowerAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusFistMagnetismVacuumActivate" },
			},
		},
	},

	TalosPunch =
	{
		GenusName = "TalosMagnet",

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TalosPunch",

			FireProjectileStartDelay = 0.07,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.1,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.11,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.03,
			PostAttackStop = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.4,
			PostAttackDurationMin = 0.6,
			PostAttackDurationMax = 1.2,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackSound = "/SFX/Enemy Sounds/Talos/EmotePowerCharging",

			PreAttackAnimation = "Enemy_Talos_MagnetPunchPreFire",
			FireAnimation = "Enemy_Talos_MagnetPunchFire",
			PostAttackAnimation = "Enemy_Talos_MagnetPunchPostFire",
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Talos/TalosPunch" },
			},
		},
	},

	TalosSpin =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
			MaxPlayerDistance = 900,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TalosSpin",

			FireTicks = 7,
			FireInterval = 0.16,
			FireSelfVelocity = 700,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "WhirlwindLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 1.6,
						Modifier = 0.1,
					}
				},
			},

			PreAttackFx = "TalosSpinChargeR",

			PreAttackDuration = 1.4,
			FireDuration = 0.0,
			PostAttackDurationMin = 1.5, -- anim is 0.98
			PostAttackDurationMax = 2.0,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.09,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,

			AttackDistance = 600,
			MoveWithinRange = false,

			DoNotRepeatOnAttackFail = true,

			PreAttackSound = "/SFX/Enemy Sounds/Talos/EmotePowerCharging",
			PreAttackAnimation = "Enemy_Talos_SpinPreFire",
			FireAnimation = "Enemy_Talos_SpinFire",
			PostAttackAnimation = "Enemy_Talos_SpinPostFire",

			WeaponFireLoopingSound = "/SFX/Enemy Sounds/Talos/TalosSpinLoop",
		},
	},

	TalosSprint =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
		},

		AIData =
		{
			DeepInheritance = true,
			AlwaysForce = true,
			ProjectileName = "TalosFireLob",

			DumbFireWeapons = { "TalosSprintKnockback" },

			SpawnFromMarker = "Talos_Rig:legParts_05_M_JNT",

			NumProjectiles = 20,
			ProjectileInterval = 0.1,
			Spread = 180,

			PreAttackRotationDampening = 0.8,
			FireRotationDampening = 0.3,

			PreAttackDuration = 0.65, -- anim is 1.2 but speed boost starts early
			PreAttackSound = "/SFX/Enemy Sounds/Talos/EmoteCharging",

			FireDuration = 2.35,
			PostAttackDuration = 2.0,
			PreAttackStop = false,
			StopMoveWithinRange = false,
			PostAttackStop = true,

			FireSound = "/Leftovers/World Sounds/AirshipIgnitionStart",

			AttackDistance = 900,
			AttackDistanceScaleY = 0.9,
			MoveSuccessDistance = 1,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "TalosSprint",
					ClearEffectOnHit = true,
					DataProperties = 
					{
						Type = "SPEED",
						Duration = 2.3,
						Modifier = 3.0,
					}
				},
			},

			PreAttackAnimation = "Enemy_Talos_SprintStart",
			PostAttackAnimation = "Enemy_Talos_SprintStop",
		},

	},

	TalosSprintKnockback =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TalosSprintKnockback",

			NumProjectiles = 1,

			FireProjectileAtTarget = true,
			CreateOwnTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 0,
			ResetTargetPerTick = true,
			PreAttackStop = false,

			MoveWithinRange = false,
			AttackDistance = 9999,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil