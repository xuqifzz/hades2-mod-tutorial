
WeaponSetData =
{
	WispFuse =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "WispFuse",

			PreAttackDuration = 0.53,
			FireDuration = 0.00,
			PreAttackEndShake = true,

			AttackDistance = 200,
			MoveWithinRange = true,
			MoveWithinRangeTimeout = 4,

			FireFunctionName = "SelfDestruct",

			PreMoveAnimation = "Enemy_Wisp_Fuse_Start",
			PreMoveFx = "WispFuseBurn",
			PreAttackAnimation = "Enemy_Wisp_Fuse_Fire",	
			PreAttackFx = "LobWarningDecalWisp",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HeavyRangedSplitterMiniboss/CrystalBeamFireStartBIG" },
			},
		},
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.07 },
		},	
	},

	TestCharacterRanged =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "MageRanged",
			BarrelLength = 55,

			PreAttackDuration = 1.0,
			FireDuration = 0.3,
			PostAttackDuration = 1.5,

			PreAttackAnimation = "Enemy_Mage_CastPreAttack",
			FireAnimation = "Enemy_Mage_CastFire",

			AttackDistance = 1000,
			RequireProjectileLoS = true,
			LoSBuffer = 40,
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil