WeaponSetData =
{
	LightRangedBolt =
	{
		AIData =
		{
			DeepInheritance = true,

			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.RootedAttacker,
			},

			ProjectileName = "LightRangedBolt",
			BarrelLength = 55,

			PreAttackDuration = 1.0,
			FireWaitForAnimation = true,
			PostAttackDurationMin = 1.0,
			PostAttackDurationMax = 1.5,
			FireInterval = 0.2,
			FireTicks = 1,

			PreAttackEndShake = true,
			PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",
			PreAttackAnimation = "Enemy_LightRanged_CastPreAttack",
			FireAnimation = "Enemy_LightRanged_CastFire",
			PostAttackAnimation = "Enemy_LightRanged_CastReturnToIdle",
			PreAttackFx = "EnemyChargeFxIn_LightRanged",
			AttackDistance = 1300,
			RequireProjectileLoS = true,
			LoSBuffer = 100,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Caster/EmoteAttacking" },
			},
		},
	},
	LightRangedBolt_Elite =
	{
		InheritFrom = { "LightRangedBolt" },
		AIData =
		{
			DeepInheritance = true,
			FireTicks = 3,

			PostAttackDurationMin = 0.9,
			PostAttackDurationMax = 1.1,
		},
	},

	SpreadShotBolt =
	{
		InheritFrom = { "LightRangedBolt" },
		AIData =
		{
			DeepInheritance = true,
			
		 	PreAttackSound = "/SFX/Enemy Sounds/Caster/EmoteCharging",

		 	ProjectileName = "SpreadShotBolt",

			NumProjectiles = 5,
			ProjectileAngleInterval = 30,

			PreAttackDuration = 0.98,
			PostAttackDuration = 2.0,

			AngleTowardsTargetWhileFiring = false,
			RequireProjectileLoS = true,
			LoSBuffer = 160,
		},
	},

	SpreadShotBolt_Elite =
	{
		InheritFrom = { "SpreadShotBolt" },

		AIData =
		{
			DeepInheritance = true,
			
			FireTicks = 3,
			FireInterval = 0.3,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil