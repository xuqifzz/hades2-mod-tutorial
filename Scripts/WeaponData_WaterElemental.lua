WeaponSetData =
{
	WaterElementalBite =
	{
		Requirements =
		{
			-- MaxPlayerDistance = 300,
			MaxAttackers = 5,
		},
		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,

			ProjectileName = "WaterElementalBite",
			FireSelfVelocity = 1700,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,
			PreAttackEndShake = true,

			PreAttackSound = "/SFX/Enemy Sounds/WaterElemental/EmoteCharging",
			PreAttackAnimation = "Enemy_WaterElemental_BitePreFire",
			FireAnimation = "Enemy_WaterElemental_BiteFire",
			PostAttackAnimation = "Enemy_WaterElemental_BitePostFire",
			--PreAttackDuration = 0.88,
			PreAttackDuration = 0.66,
			PreAttackAnimationSpeed = 1.25,
			FireDuration = 0.23,
			PostAttackDuration = 0.8, -- animation is 0.7

			AttackDistance = 335,

			RetreatAfterAttack = true,
			RetreatTimeoutMin = 2,
			RetreatTimeoutMax = 3,
			RetreatBufferDistance = 1400,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterElemental/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusBite" },
			},
		},
	},

	WaterElementalBite_Elite =
	{
		InheritFrom = { "WaterElementalBite", },
		AIData =
		{
			DeepInheritance = true,
			PostAttackDuration = 0.1,
			ChainedWeapon = "WaterElementalBiteChained_Elite",

			RetreatAfterAttack = false,
			AttackDistance = 500,
			AttackDistanceScaleY = 0.5,
		},
	},

	WaterElementalBiteChained_Elite =
	{
		InheritFrom = { "WaterElementalBite", },
		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0.2,
			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,
			WaitForAngleTowardTarget = false,
			
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			PreAttackRotationDampening = 0.3,
		},
	},

	WaterElementalFidget =
	{
		Requirements =
		{
			MinAttackers = 5,
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			NoProjectile = true,
			MoveWithinRange = false,
			SkipSurroundAICount = true,

			WaitForAngleTowardTarget = true,

			--PreAttackAnimation = "Enemy_WaterElemental_BurstPreFire",
			--FireAnimation = "Enemy_WaterElemental_BurstFire",
			--PostAttackAnimation = "Enemy_WaterElemental_BurstPostFire",

			PreAttackSound = "/SFX/Enemy Sounds/WaterElemental/EmoteCharging",
			PreAttackDuration = 0.92,
			FireDuration = 0.63,
			PostAttackDuration = 0.55,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/WaterElemental/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/ZagreusBloodshotFire" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil