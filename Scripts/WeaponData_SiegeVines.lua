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
			FireInterval = 0.7,
			FireDuration = 2.1,
			PostAttackDuration = 2.25,

			AttackDistance = 1800,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil