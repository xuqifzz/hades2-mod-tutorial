
WeaponSetData =
{

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
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil