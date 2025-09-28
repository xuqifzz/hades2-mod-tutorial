WeaponSetData =
{
	BrokenHeartedSlam =
	{
		AIData =
		{
			DeepInheritance = true,

			Requirements =
			{
				MaxPlayerDistance = 475,
			},

			ProjectileName = "BrokenHeartedSlam",
			FireProjectileStartDelay = 0.035,
			FireSelfVelocity = 900,
			FireSelfVelocityAngleOffset = 180,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},
			FireProjectileAtSelf = true,

		--	PreAttackFunctionName = "WeaponSetImmuneToStun",
			PreAttackDuration = 0.97,
			FireDuration = 0.72,
			PostAttackDuration = 1.75,
			PreAttackEndShake = true,

			AttackDistance = 320,
			LoSBuffer = 55,
			RequireUnitLoS = true,

			PreAttackSound = "/SFX/Enemy Sounds/BrokenHearted/EmoteCharging",
			PreAttackAnimation = "Enemy_BrokenHearted_SlamPreFire",
			FireAnimation = "Enemy_BrokenHearted_SlamFire",
			PostAttackAnimation = "Enemy_BrokenHearted_SlamPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/BrokenHearted/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Charon/CharonRadialBlast" },
			},
		}
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil