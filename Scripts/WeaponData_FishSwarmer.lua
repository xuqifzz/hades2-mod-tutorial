WeaponSetData =
{
	FishSwarmerBite =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FishSwarmerBite",
			Spread = 20,
			SetAngleTowardProjectileAngle = true,

      		FireSelfVelocity = 1200.0,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			PreAttackDuration = 0.55,
			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.8,
			FireDuration = 0.25,
			PostAttackDuration = 0.4,
			FireProjectileStartDelay = 0.01,
			AttackStaggerDelay = 0.05,

			AttackDistance = 380,
			RequireUnitLoS = true,
			LoSBuffer = 10,

			PreAttackStop = true,
			StopMoveWithinRange = false,

			SoundManagerCap = 38,
			PreAttackFlashSound = "/SFX/Enemy Sounds/Swarmer/SwarmerCharge",
			PreAttackAnimation = "Enemy_FishSwarmer_BitePreAttack",
			FireAnimation = "Enemy_FishSwarmer_BiteFire",
			PostAttackAnimation = "Enemy_FishSwarmer_BiteReturnToIdle",

			MinionWeapon = "FishSwarmerBite",
		},

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.05 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/FishSwarmer/EmoteAttacking" },
				{ Name = "/SFX/Player Sounds/MelDaggerKnifeSwipe" },
			},
		},
	},

	FishSwarmerBiteCombo_Elite =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"FishSwarmerBite_Elite",
			"FishSwarmerBiteFinal_Elite",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 380,
		},
	},

	FishSwarmerBite_Elite =
	{
		InheritFrom = {"FishSwarmerBite"},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "FishSwarmerBite_Elite",

			MoveWithinRange = false,
      		FireSelfVelocity = 1450.0,

			AttackStaggerDelay = 0.5,

			MinionWeapon = "FishSwarmerBite_Elite",
		},
	},

	FishSwarmerBiteFinal_Elite =
	{
		InheritFrom = {"FishSwarmerBite_Elite"},
		AIData =
		{
			DeepInheritance = true,
			
			MoveWithinRange = false,
			PostAttackDuration = 0.5,
      		FireSelfVelocity = 1450.0,
			  
			MinionWeapon = "FishSwarmerBiteFinal_Elite",
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil