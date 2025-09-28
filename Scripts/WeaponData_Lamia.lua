WeaponSetData =
{
	LamiaShockwave =
	{
		Requirements = 
		{
			MaxPlayerDistance = 400,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LamiaShockwave",
			PreAttackFx = "LamiaStaffShockwaveChargeFx",
			FireProjectileStartDelay = 0.08,
			FireProjectileAtSelf = true,

			BarrelLength = 150,

			PreAttackStop = true,

			PreAttackAnimationSpeed = 0.2,
			PreAttackDuration = 0.60,
			PreAttackEndShake = true,
			FireDuration = 0.22,
			PostAttackDuration = 0.8,
			
			PreAttackSound = "/SFX/Enemy Sounds/Lamia/EmoteCharging",
			PreAttackAnimation = "Enemy_Lamia_DownCastPreFire",
			FireAnimation = "Enemy_Lamia_DownCastFire",
			--PostAttackAnimation = "Enemy_Lamia_DownCastPostFire",

			AttackDistance = 500,

			SkipSurroundAICount = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Lamia/LamiaBlast" },
				{ Name = "/SFX/PlayerHammerExplosionsTight" },
			},
		},
	},

	LamiaShockwave_Miniboss =
	{
		InheritFrom = { "LamiaShockwave", },
		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = ">",
				Value = 1,
			},
		},
		Requirements = 
		{
			MaxPlayerDistance = 600,
		},

		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "LamiaShockwave_Miniboss",

			MoveWithinRange = false,
			AttackDistance = 9999,
			ForceUseIfReady = true,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 1600,
			RetreatTimeout = 1.65,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Lamia/LamiaBlast" },
				{ Name = "/SFX/PlayerHammerExplosionsTight" },
			},
		},
	},

	LamiaSkyCast =
	{
		Requirements = 
		{
			MinPlayerDistance = 400,
			MaxAttackers = 4,
		},
		
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LamiaSkyCast",
			BarrelLength = 150,
			FireProjectileStartDelay = 0.01,

			ExpireProjectilesOnHitStun = true,
			ExpireProjectilesOnFreeze = true,

			RequireUnitLoS = true,

			PreAttackDuration = 1.0,
			FireDuration = 7.2,
			PostAttackDuration = 0.9,

			PreAttackEndShake = true,
			PreAttackFxAtProjectileStartLocation = "EnemyChargeFxIn",
			
			PreAttackSound = "/SFX/Enemy Sounds/Lamia/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Lamia_SkyCastPreFire",
			FireAnimation = "Enemy_Lamia_SkyCastFireLoop",
			PostAttackAnimation = "Enemy_Lamia_SkyCastPostFire",

			AttackDistance = 1200,
			AttackDistanceScaleY = 0.45,
			DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/Enemy Sounds/FreezeShotWeaponFire" },
			},
		},
	},

	LamiaSkyCast_Elite =
	{
		InheritFrom = { "LamiaSkyCast" },
		AIData =
		{
			DeepInheritance = true,

			FireDuration = 3.25,
		},
	},

	LamiaSkyCast_Miniboss =
	{
		InheritFrom = { "LamiaSkyCast" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "LamiaSkyCast_Miniboss",

			MoveWithinRange = false,
			AttackDistance = 9999,

			FireDuration = 5.5,
			NumProjectiles = 3,
			ProjectileInterval = 0.08,
			Spread = 80,

			PostAttackDurationMin = 2.5,
			PostAttackDurationMax = 4.5,

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 610,
			RetreatTimeout = 1.3,
		},
	},

	LamiaSkyCast_Support =
	{
		InheritFrom = { "LamiaSkyCast" },
		AIData =
		{
			DeepInheritance = true,

			ExpireProjectilesOnHitStun = false,
			FireDuration = 5.5,
			PostAttackDurationMin = 1.0,
			PostAttackDurationMax = 4.0,
			AttackDistance = 9999,
			RequireUnitLoS = false,
		},
	},

	LamiaMiasma =
	{
		Requirements = 
		{
			MinAttacksBetweenUse = 3,
		},
		
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LamiaMiasma",
			BarrelLength = 160,
			FireProjectileStartDelay = 0.25,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			ExpireProjectilesOnHitStun = true,

			PreAttackDuration = 1.5,
			FireDuration = 0.32,
			PostAttackDurationMin = 2.0,
			PostAttackDurationMax = 3.0,

			PreAttackSound = "/SFX/Enemy Sounds/Lamia/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_Lamia_ForwardCastPreFire",
			FireAnimation = "Enemy_Lamia_ForwardCastFire",
			--PostAttackAnimation = "Enemy_Lamia_ForwardCastPostFire",

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Lamia/EmoteAttackingRanged" },
				{ Name = "/SFX/ArcherTrapProjectileFireShoot" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil