WeaponSetData =
{
	VampireCast =
	{
		Requirements =
		{
			MinPlayerDistance = 450,
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "VampireCast",
			BarrelLength = 50,
			FireProjectileStartDelay = 0.22,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.045,			
			StopBeforeFire = true,

			AngleTowardsTargetWhileFiring = true,
			FireRotationDampening = 0.030,

			PostAttackStop = true,

			PreAttackEndShake = true,

			PreAttackDuration = 1.18,
			FireDuration = 1.03,
			PostAttackDuration = 1.10,

			AttackDistance = 700,
			AttackDistanceScaleY = 0.75,

			PreAttackSound = "/SFX/Enemy Sounds/Vampire/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Vampire_Cast_Start",
			FireAnimation = "Enemy_Vampire_Cast_Fire",
			PostAttackAnimation = "Enemy_Vampire_Cast_End",

			--AttackFailWeapon = "VampireInstantTeleport",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalBeamFireStart" },
				{ Name = "/SFX/Enemy Sounds/Vampire/EmoteAttackingRanged" },
			},
		},
	},

	VampireSwipe =
	{
		Requirements =
		{
			MaxPlayerDistance = 600,
		},
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "VampireSwipe",

			FireProjectileStartDelay = 0.26,

			NumProjectiles = 2,
			ProjectileInterval = 0.08,

			PreAttackDuration = 0.6,
			PreAttackAnimationSpeed = 1.0,
			FireDuration = 0.73,
			PostAttackDuration = 0.62,

			MoveWithinRange = true,
			AttackDistance = 500,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.1,
			StopBeforeFire = true,

			PreAttackEndShake = true,

			FireSelfVelocity = 1550,

			LoSBuffer = 85,
			RequireUnitLoS = true,
			
			PreAttackAnimation = "Enemy_Vampire_Swipe_Start",
			FireAnimation = "Enemy_Vampire_Swipe_Fire",
			PostAttackAnimation = "Enemy_Vampire_Swipe_End",

			--AttackFailWeapon = "VampireInstantTeleport",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Vampire/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},		
	},

	VampireUppercut =
	{
		Requirements =
		{
			MaxPlayerDistance = 1000,
		},
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "VampireUppercut",

			FireProjectileStartDelay = 0.1,

			NumProjectiles = 2,
			ProjectileInterval = 0.12,

			PreAttackDuration = 1.0,
			FireDuration = 0.48,
			PostAttackDuration = 0.32,

			MoveWithinRange = true,
			AttackDistance = 700,

			FireSelfVelocity = 2200,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.1,
			StopBeforeFire = true,

			PreAttackEndShake = true,

			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackAnimation = "Enemy_Vampire_Uppercut_Start",
			FireAnimation = "Enemy_Vampire_Uppercut_Fire",
			PostAttackAnimation = "Enemy_Vampire_Uppercut_End",

			ChainedWeapon = "VampireSweep",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Vampire/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},		
	},

	VampireSweep =
	{
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "VampireSweep",

			FireProjectileStartDelay = 0.05,

			PreAttackDuration = 0.5,
			FireDuration = 0.48,
			PostAttackDuration = 1.48, -- anim is 0.98

			MoveWithinRange = false,
			AttackDistance = 9999,

			WaitForAngleTowardTarget = false,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackEndShake = true,
			FireSelfVelocity = 1700,

			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackAnimation = "Enemy_Vampire_Sweep_Start",
			FireAnimation = "Enemy_Vampire_Sweep_Fire",
			PostAttackAnimation = "Enemy_Vampire_Sweep_End",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Vampire/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},		
	},

	VampireCombo =
	{
		Requirements =
		{
			MaxPlayerDistance = 800,
		},
		AIData =
		{
			DeepInheritance = true,
		},

		WeaponComboOnly = true,
		WeaponCombo =
		{
			"VampireComboSwing1",
			"VampireComboSwing2",
		},
	},

	VampireComboSwing1 =
	{
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "VampireComboSwing1",

			FireProjectileStartDelay = 0.03,

			PreAttackDuration = 1.0,
			FireDuration = 0.37,
			PostAttackDuration = 0.0,

			MoveWithinRange = true,
			AttackDistance = 300,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.06,
			StopBeforeFire = true,

			PreAttackEndShake = true,

			FireSelfVelocity = 1700,

			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackAnimation = "Enemy_Vampire_Combo_Start",
			FireAnimation = "Enemy_Vampire_Combo_Fire1",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Vampire/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},		
	},
	VampireComboSwing2 =
	{
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "VampireComboSwing2",

			FireProjectileStartDelay = 0.11,

			PreAttackDuration = 0.0,
			FireDuration = 0.38,
			PostAttackDuration = 1.55,

			MoveWithinRange = false,
			AttackDistance = 9999,

			WaitForAngleTowardTarget = false,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.06,
			StopBeforeFire = true,

			FireSelfVelocity = 1700,

			LoSBuffer = 85,
			RequireUnitLoS = true,

			FireAnimation = "Enemy_Vampire_Combo_Fire2",
			PostAttackAnimation = "Enemy_Vampire_Combo_End",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Vampire/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},		
	},

	VampireTeleport =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
		},
		AIData =
		{
			DeepInheritance = true,
			NoProjectile = true,

			AttackDistance = 9999,

			TeleportPreWaitAnimation = "Enemy_Vampire_Teleport_Disappear",
			TeleportAnimation = "Enemy_Vampire_Teleport_Appear",

			PreTeleportWait = 0.68,
			PostTeleportWait = 0.7,
			TeleportToSpawnPoints = true,
			TeleportMinDistance = 400,
			TeleportMaxDistance = 2500,
			TeleportationInterval = 0,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil