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
			WaitForAngleTowardTargetTimeOut = 1.0,
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
			PostAttackDuration = 1.5,
			PreAttackCancelSound = "/Leftovers/SFX/ImpRef02_GoDown",
			PreAttackEndShakeSound = "/Leftovers/SFX/SprintChargeUp",

			AttackDistance = 800,
			AttackDistanceScaleY = 0.6,
		},

		Requirements =
		{
			RequireProjectileLoS = true,
			MaxAttackers = 2,
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
			LeapAgainIfBlocked = true,
			RequireLeapTargetLoS = true,
			AttackDistance = 1000,

			ProjectileName = "SticklerLeap",
			FireProjectileStartDelay = 0.05,

			FireProjectileAtSelf = true,

			MoveWithinRange = false,

			PreAttackDuration = 0.0,
			PreFireDuration = 0.0,
			FireDuration = 0,
			PostAttackDuration = 0.35,

			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			PostAttackStop = true,

			SkipSurroundAICount = true,
		},

		Requirements =
		{
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