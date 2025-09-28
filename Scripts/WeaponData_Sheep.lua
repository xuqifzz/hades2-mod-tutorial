WeaponSetData =
{
	SheepSkip =
	{
		AIData =
		{
			DeepInheritance = true,
			SkipCanAttack = true,

			FireSelfVelocity = 1100,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			FireTicksMin = 2,
			FireTicksMax = 5,
			FireInterval = 0.4,
			ResetTargetPerTick = true,

			AttackDistance = 9999,
			MoveWithinRange = false,
			NoProjectile = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,
			CreateOwnTargetFromOriginalTarget = true,
			UseTargetAngle = true,
			TargetOffsetDistance = 500,
			DeaggroAfterAttack = true,

			--PreAttackAnimation = "Enemy_Sheep_DashPreFire",
			FireAnimation = "Enemy_Sheep_DashPreFire",
			--PostAttackAnimation = "Enemy_Sheep_DashReturnToIdle",
		},
	},

	SheepRam =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SheepRam",

			FireSelfVelocity = 1000,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			AttackDistance = 300,

			PreAttackDuration = 0.7,
			PreAttackEndShake = true,
			PreAttackFlashSound = "/SFX/Enemy Sounds/CorruptedShadeMedium/ChargeShort",
			FireDuration = 0.3,
			PostAttackDuration = 1.0,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.03,
			StopBeforeFire = true,

			FireAnimation = "Enemy_Sheep_DashPreFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/SheepZombie/EmoteEvading" },
			},
		},
	},

	SheepExplode =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "SheepExplode",

			FireProjectileAtSelf = true,
			FireFromTarget = true,
			PreAttackStop = true,

			PreAttackEndShake = true,
			PreAttackEndDuration = 0.5,

			PreAttackLoopingSound = "/SFX/BombFusePreExplode",
			PreAttackSound = "/SFX/Enemy Sounds/MudmanEye/EmoteActivated",
			PreAttackDuration = 0.6,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = true,
			AttackDistance = 225,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Explosion1" },
				{ Name = "/SFX/Enemy Sounds/MudmanEye/MudmanEyeExplode" },
			},
		},
	},

	SheepSickSkip =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 900,

			FireSelfVelocity = 1100,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			AttackDistance = 9999,
			MoveWithinRange = false,

			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 2.0,

			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,
			CreateOwnTargetFromOriginalTarget = true,
			UseTargetAngle = true,
			TargetOffsetDistance = 500,

			--PreAttackAnimation = "Enemy_Sheep_DashPreFire",
			FireAnimation = "Enemy_Sheep_Sick_DashPreFire",
			--PostAttackAnimation = "Enemy_Sheep_DashReturnToIdle",
		},

		-- sounds on FireAnimation
	},

	SheepSickAura =
	{
		AIData =
		{
			DeepInheritance = true,

			DumbFireInterval = 9999.0,

			ProjectileName = "SheepSickAura",

			MoveWithinRange = false,
			AttackDistance = 9999,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil