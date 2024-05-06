WeaponSetData =
{
	GuardMelee =
	{
		AIData =
		{
			DeepInheritance = true,


			ProjectileName = "GuardMelee",

			PreAttackDuration = 0.9,
			PreAttackAnimationSpeed = 0.45,
			FireDuration = 0.3,
			PostAttackDuration = 2.1,

			--AttackDistance = 170,
			AttackDistance = 290,
			FireSelfVelocity = 700,

			TrackTargetDuringCharge = true,

			PreAttackEndShake = true,
			PreAttackAnimation = "Enemy_Guard_MeleePreAttack",
			FireAnimation = "Enemy_Guard_MeleeFire",
			PostAttackAnimation = "Enemy_Guard_MeleeReturnToIdle",
			--FireFx = "EnemyAura",
			--FireFxOffset = 300,
			PreAttackFx = "EnemyChargeFxIn_Guard",
			EndPreAttackFx = true,

			ExpireProjectilesOnHitStun = true,
			--DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Guard/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	GuardMelee_Elite =
	{
		InheritFrom = { "GuardMelee" },

		AIData =
		{
			DeepInheritance = true,
			AttackDistance = 330,

			PostAttackDuration = 1.5,

			NumProjectiles = 2,
			ProjectileInterval = 0.2,
			FireSelfVelocity = 900,

			PreAttackStop = false,
			StopMoveWithinRange = false,

			--ChainedWeapon = "GuardMelee_Elite2",
		},
	},

	GuardMelee_Elite2 =
	{
		InheritFrom = { "GuardMelee" },

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0,
			PostAttackDuration = 0.1,
			AttackDistance = 2500,
			ChainedWeapon = "GuardMelee_Elite3",

			FireSelfVelocity = 770,

			PreAttackStop = false,
			StopMoveWithinRange = false,
		},
	},

	GuardMelee_Elite3 =
	{
		InheritFrom = { "GuardMelee" },

		AIData =
		{
			DeepInheritance = true,
			PreAttackDuration = 0,
			AttackDistance = 2500,
			PostAttackDuration = 1.75,

			FireSelfVelocity = 730,

			PreAttackStop = false,
			StopMoveWithinRange = true,
		},
	},

	GuardSaw =
	{
		InheritFrom = { "GuardMelee" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GuardMelee2",

			TrackTargetDuringCharge = false,
			PreAttackEndShake = true,

			MoveWithinRange = true,
			StopMoveWithinRange = false,
			PreAttackStop = false,

			AttackDistance = 800,
			FireAnimation = "Enemy_Guard_MeleeFireMulti",
			PostAttackAnimation = "Enemy_Guard_Move",

			FireTicksMin = 9,
			FireTicksMax = 9,
			FireInterval = 0.7,
			FireSelfVelocity = 400,

			PreAttackDuration = 0.9,
			PreAttackAnimationSpeed = 0.45,
			FireDuration = 0.0,
			PostAttackDuration = 2.1,
			--DoNotRepeatOnAttackFail = true,
		},
	},

	GuardHyperSpin =
	{
		InheritFrom = { "GuardMelee" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GuardMelee3",

			PostAttackDuration = 0,
			FireDuration = 0.25,
			AttackDistance = 580,

			MoveWithinRange = true,
			StopMoveWithinRange = true,
			PreAttackStop = true,

			FireAnimation = "Enemy_Guard_MeleeFireMulti",

			ChainedWeapon = "GuardHyperSpinA",
		},
	},

	GuardHyperSpinA =
	{
		InheritFrom = { "GuardHyperSpin" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GuardMelee3A",
			ChainedWeapon = "GuardHyperSpinB",
			PreAttackDuration = 0,
			MoveWithinRange = false,
		},
	},
	GuardHyperSpinB =
	{
		InheritFrom = { "GuardHyperSpinA" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GuardMelee3B",
			ChainedWeapon = "GuardHyperSpinC",
		},
	},
	GuardHyperSpinC =
	{
		InheritFrom = { "GuardHyperSpinA" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GuardMelee3C",
			ChainedWeapon = "GuardHyperSpinD",
		},
	},
	GuardHyperSpinD =
	{
		InheritFrom = { "GuardHyperSpinA" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GuardMelee3D",
			ChainedWeapon = "GuardHyperSpinE",
		},
	},
	GuardHyperSpinE =
	{
		InheritFrom = { "GuardHyperSpinA" },

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "GuardMelee3E",
			PostAttackDuration = 1.8,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil