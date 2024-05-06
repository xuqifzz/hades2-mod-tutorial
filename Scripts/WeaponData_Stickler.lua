WeaponSetData =
{
	SticklerThrow =
	{
		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "SticklerThrow",
			BarrelLength = 175,

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.04,
			StopBeforeFire = true,
			
			FireProjectileStartDelay = 0.06,
			FireSelfVelocity = 900,

			MoveWithinRange = false,

			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/DeadSeaStickler/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Stickler_ThrowPreFire",
			FireAnimation = "Enemy_Stickler_ThrowFire",
			PostAttackAnimation = "Enemy_Stickler_ThrowPostFire",
			PreAttackDuration = 1.0,
			FireDuration = 0.32,
			PostAttackDuration = 2.0, -- animation is 0.65
			PreAttackCancelSound = "/Leftovers/SFX/ImpRef02_GoDown",
			PreAttackEndShakeSound = "/Leftovers/SFX/SprintChargeUp",

			AttackDistance = 900,
			AttackDistanceScaleY = 0.6,
		},

		Requirements =
		{
			RequireProjectileLoS = true,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/DeadSeaStickler/EmoteAttackingRanged" },
				{ Name = "/Leftovers/SFX/AuraThrow" },
				{ Name = "/SFX/Player Sounds/ZagreusSpearThrust" },

			},
		},
	},

	SticklerThrow_Elite =
	{
		InheritFrom = { "SticklerThrow", },
		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 1.0,
			ProjectileName = "SticklerThrow_Elite",
		},
	},

	SticklerLeapCombo =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"SticklerLeap_Elite",
			"SticklerLeap_Elite",
			"SticklerLeap",
		},
	},

	SticklerLeap =
	{
		AIData =
		{
			DeepInheritance = true,

			PreMoveLeap = true,
			RequireLeapTargetLoS = true,
			AttackDistance = 1000,

			ProjectileName = "SticklerLeap",
			FireProjectileStartDelay = 0.05,

			FireProjectileAtSelf = true,
			--SpawnFromMarker = "DeadSeaStickler_Rig:hipSpear_01_M_JNT",

			MoveWithinRange = false,

			PreAttackDuration = 0.0,
			PreFireDuration = 0.0,
			FireDuration = 0,
			PostAttackDuration = 1.1,

			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			PostAttackStop = true,

			-- PreAttackSound = "/SFX/Enemy Sounds/DeadSeaStickler/EmoteLeaping",
			--PreAttackAnimation = "Enemy_Stickler_LeapPreFire",
			--FireAnimation = "Enemy_Stickler_LeapAirLoop",
			--PostAttackAnimation = "Enemy_Stickler_LeapLand",
		},

		Requirements =
		{
			--MaxConsecutiveUses = 1,
			--MinAttacksBetweenUse = 5,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},
	},

	SticklerLeap_Elite =
	{
		InheritFrom = { "SticklerLeap" },
		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.8,
		},

		Requirements =
		{
			MaxConsecutiveUses = 2,
			MinAttacksBetweenUse = 3,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil