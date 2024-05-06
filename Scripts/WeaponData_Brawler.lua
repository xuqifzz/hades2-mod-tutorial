WeaponSetData =
{
	BrawlerMelee =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BrawlerMelee",
			FireSelfVelocity = 1800,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			PreAttackDuration = 1.15,
			FireDuration = 0.4,
			PostAttackDuration = 0.0,
			PreAttackEndShake = true,
			PreAttackEndDuration = 0.4,

			AttackDistance = 500,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackAnimation = "Enemy_Brawler_MeleePreAttack",
			FireAnimation = "Enemy_Brawler_MeleeFire",
			PostAttackAnimation = "Enemy_Brawler_MeleeReturnToIdle",

			ChainedWeapon = "BrawlerMeleeClose",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Brawler/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	BrawlerMeleeClose =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "BrawlerMeleeClose",
			FireSelfVelocity = 300,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			PreAttackRotationDampening = 0.02,
			FireRotationDampening = 0.1,

			PreAttackDuration = 0.65,
			FireDuration = 0.4,
			PostAttackDuration = 1.1,
			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,
			PreAttackFlash = true,

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Brawler_MeleePreAttack_2",
			FireAnimation = "Enemy_Brawler_MeleeFire_2",
			PostAttackAnimation = "Enemy_Brawler_MeleeReturnToIdle",

			DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Brawler/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil