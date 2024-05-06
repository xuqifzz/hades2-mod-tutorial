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
			AngleTowardsTargetWhileFiring = true,
			CreateOwnTargetFromOriginalTarget = true,
			UseTargetAngle = true,
			TargetOffsetDistance = 500,

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

			FireSelfVelocity = 1100,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			FireTicksMin = 2,
			FireTicksMax = 5,
			FireInterval = 0.4,
			ResetTargetPerTick = true,

			AttackDistance = 400,

			PreAttackDuration = 0.0,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = true,

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

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.1 },
		},		
	},

	SheepSickSkip =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsPlayerRadius = 900,

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
			AngleTowardsTargetWhileFiring = true,
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

		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.3, FalloffSpeed = 3000, Angle = 0 },
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil