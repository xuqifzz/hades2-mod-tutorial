WeaponSetData =
{
	ThugShove =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ThugShove",
			WaitForAngleTowardTarget = false, -- causes a lot of rotation in place
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.10,
			StopBeforeFire = true,

			FireSelfVelocity = 1600,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.35,

			PreAttackDuration = 0.7,
			FireDuration = 0.28,
			PostAttackDuration = 0.75,
			
			PreAttackSound = "/SFX/Enemy Sounds/HeavyMelee/EmoteCharging",
			PreAttackAnimation = "Enemy_CWHeavyMelee_ShovePreFire",
			FireAnimation = "Enemy_CWHeavyMelee_ShoveFire",
			PostAttackAnimation = "Enemy_CWHeavyMelee_ShovePostFire",

			MoveWithinRange = true,
			AttackDistance = 410,
			AttackDistanceScaleY = 0.75,

			RequireProjectileLoS = true,
			LoSBuffer = 32,
		},

		Requirements =
		{
			MaxConsecutiveUses = 2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HeavyMelee/EmoteAttacking" },
				-- { Name = "/SFX/Enemy Sounds/WretchedThug/EmoteAttackingShove" }
			},
		},
	},

	ThugShove_Elite =
	{
		InheritFrom = { "ThugShove" },

		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 2300,
		},
	},

	-- currently ThugSlam is elite only
	ThugSlam =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ThugSlam" },
				{ ProjectileName = "ThugSlamWave" },
			},
			FireProjectileStartDelay = 0.27,

			WaitForAngleTowardTarget = true,

			PreAttackDuration = 1.3,
			FireDuration = 0.3,
			PostAttackDuration = 0.0,
			PreAttackSound = "/SFX/Enemy Sounds/WretchedThug/EmoteChargingLong",
			PreAttackAnimation = "Enemy_CWHeavyMelee_SlamPreFire",
			FireAnimation = "Enemy_CWHeavyMelee_SlamFire",

			AttackDistance = 575,

			RequireProjectileLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			ChainedWeapon = "ThugSlamReverse",

			-- Rifts ban
			DumbFireWeapons = {},
		},

		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WretchedThug/EmoteAttackingShove" },
			},
		},		
	},

	ThugSlam_Elite =
	{
		InheritFrom = { "ThugSlam" },

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "ThugSlamWave" },
				{ ProjectileName = "ThugSlam", PauseDuration = 0.1, },
			},
			FireDuration = 0.2,

			ChainedWeapon = "ThugSlamNova",
		},

		Requirements =
		{
			MaxConsecutiveUses = 1,
			MinPlayerDistance = 350,
		},
	},

	ThugSlamNova =
	{
		AIData =
		{
			ProjectileName = "ThugSlamNova",
			CreateOwnTarget = true,
			TargetOffsetDistance = 550,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,
			AttackDistance = 9999,
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			ChainedWeapon = "ThugSlamReverse",

			-- Blink ban
			PreMoveTeleport = false,
			-- Rifts ban
			DumbFireWeapons = {},
		}
	},

	ThugSlamReverse =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ThugSlamWave",

			CreateOwnTarget = true,
			TargetAngleOffset = 180,
			TargetOffsetDistance = 580,
			FireProjectileTowardTarget = true,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,
			AttackDistance = 9999,

			PreAttackDuration = 0.6,
			FireDuration = 0.43,
			PostAttackDuration = 2.45,
			PreAttackAnimation = "Enemy_CWHeavyMelee_SlamReversePreFire",
			FireAnimation = "Enemy_CWHeavyMelee_SlamReverseFire",
			PostAttackAnimation = "Enemy_CWHeavyMelee_SlamPostFire",

			DoNotRepeatOnAttackFail = true,

			-- Blink ban
			PreMoveTeleport = false,
			-- Rifts ban
			DumbFireWeapons = {},
		},
	},

	ThugSwipe =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ThugSwipe",

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			FireProjectileStartDelay = 0.07,

			PreAttackEndShake = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.3,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.05,
			StopBeforeFire = true,

			PreAttackDuration = 1.0,
			FireDuration = 0.4,
			PostAttackDuration = 2.45,
			PreAttackSound = "/SFX/Enemy Sounds/WretchedThug/EmoteChargingLong",
			PreAttackAnimation = "Enemy_CWHeavyMelee_SwipePreFire",
			FireAnimation = "Enemy_CWHeavyMelee_SwipeFire",
			PostAttackAnimation = "Enemy_CWHeavyMelee_SwipePostFire",

			AttackDistance = 580,
			AttackDistanceScaleY = 0.6,
			SkipAttackIfMoveTimeout = true,

			RequireProjectileLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,

			-- Rifts ban
			DumbFireWeapons = {},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WretchedThug/ThugAxeAttackSwing" },
				{ Name = "/SFX/Enemy Sounds/WretchedThug/EmoteAttackingSlam" },
			},
		},
		
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},
	},

	ThugSwipe_Elite =
	{
		InheritFrom = { "ThugSwipe", },
		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.1,
			PostAttackAnimation = "Enemy_CWHeavyMelee_SwipePostFire_Alt",
			ChainedWeapon = "ThugSwipeCombo_Elite",
		},

		Requirements =
		{
			MaxPlayerDistance = 450,
		},
	},

	ThugSwipeCombo_Elite =
	{
		InheritFrom = { "ThugSwipe", },
		AIData =
		{
			DeepInheritance = true,
			PreAttackAnimation = "Enemy_CWHeavyMelee_SwipePreFire_Alt",
			AttackDistance = 9999,
			MoveWithinRange = false,
			PreAttackDuration = 0.5,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil