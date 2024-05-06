WeaponSetData =
{
	SiegeVines =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "ChasingVines",
			MoveWithinRange = false,

			PreAttackDuration = 0.8,
			FireWaitForAnimation = true,
			PostAttackDuration = 3.25,

			AttackDistance = 1800,

			PreAttackAnimation = "Enemy_SiegeVine_PreAttack",
			FireAnimation = "Enemy_SiegeVine_AttackFire",
			PostAttackAnimation = "Enemy_SiegeVine_AttackReturnToIdle",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SiegeVine/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/TreeAttack" },
			},
		},
	},

	SiegeVinesElite =
	{
		InheritFrom = { "SiegeVines", },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "ChasingVinesElite",

			PreAttackDuration = 0.8,
			FireTicks = 3,
			FireInterval = 0.5,
			FireDuration = 1.5,
			PostAttackDuration = 2.25,

			AttackDistance = 1800,
		},
	},

	SiegeVine2FastVines =
	{
		InheritFrom = { "SiegeVines", },
		Requirements =
		{
			MaxPlayerDistance = 600,
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackFx = "AuraAimLineSirenKeytarist",
			EndPreAttackFx = true,

			AttackSlots =
			{
				{ ProjectileName = "SiegeVine2FastVines", AIDataOverrides = { FireProjectileAngleRelative = 0, },  },
				{ ProjectileName = "SiegeVine2FastVines", AIDataOverrides = { FireProjectileAngleRelative = 90, },  },
				{ ProjectileName = "SiegeVine2FastVines", AIDataOverrides = { FireProjectileAngleRelative = 180, },  },
				{ ProjectileName = "SiegeVine2FastVines", AIDataOverrides = { FireProjectileAngleRelative = 270, }, PauseDuration = 0.6 },

				{ ProjectileName = "SiegeVine2FastVines", AIDataOverrides = { FireProjectileAngleRelative = 45, },  },
				{ ProjectileName = "SiegeVine2FastVines", AIDataOverrides = { FireProjectileAngleRelative = 135, },  },
				{ ProjectileName = "SiegeVine2FastVines", AIDataOverrides = { FireProjectileAngleRelative = 215, },  },
				{ ProjectileName = "SiegeVine2FastVines", AIDataOverrides = { FireProjectileAngleRelative = 305, },  },
			},

			PreAttackDuration = 0.8,
			FireDuration = 0.8,
			PostAttackDuration = 2.6,


			AttackDistance = 700,
		},
	},

	SiegeVine2RootVines =
	{
		InheritFrom = { "SiegeVines", },

		Requirements =
		{
			MinPlayerDistance = 400,
		},

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "SiegeVine2RootVines",
			NumProjectiles = 4,
			ProjectileInterval = 0.15,
			ProjectileAngleInterval = 90,
			ProjectileStartAngleOffsetMin = 0,
			ProjectileStartAngleOffsetMax = 45,

			PreAttackDuration = 0.8,
			FireDuration = 0.6,
			PostAttackDuration = 2.6,


			AttackDistance = 1800,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil