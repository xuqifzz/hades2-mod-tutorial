WeaponSetData =
{
	DevotionZeus =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionZeus",
			
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.25,
			PostAttackCooldownMax = 3.25,

			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 230,
			TeleportToTargetId = true,

			FireTicksMin = 9,
			FireTicksMax = 12,
			FireInterval = 0.2,
			ResetTargetPerTick = true,
			CreateOwnTargetFromOriginalTarget = true,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionPoseidon =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionPoseidon",
			
			FireProjectileTowardTarget = true,
			PreAttackAngleTowardTarget = true,

			PreAttackDuration = 1.0,
			PreAttackFx = "DevotionPreAttackBase_Poseidon",
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 3.5,
			PostAttackCooldownMax = 4.5,

			TeleportToSpawnPoints = true,
			TeleportMinDistance = 300,
			TeleportMaxDistance = 1000,
			TeleportationInterval = 0,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionHestia =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionHestia",

			PreAttackDuration = 1.0,
			FireDuration = 0.5,
			PostAttackDuration = 0,
			PostAttackCooldownMin = 0,
			PostAttackCooldownMax = 0,
			FireProjectileAtTarget = true,
			PostAttackTeleportToTargetId = true,

			CreateOwnTargetFromOriginalTarget = true,

		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionApollo =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionApollo",
			
			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2,
			PostAttackCooldownMax = 4,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 200,
			TargetOffsetDistanceMax = 250,
			TeleportToTargetId = true,
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionHera =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionHera",
			
			FireProjectileTowardTarget = true,
			PreAttackAngleTowardTarget = true,

			PreAttackDuration = 1.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 1.5,
			PostAttackCooldownMax = 3.0,

			FireTicksMin = 1,
			FireTicksMax = 2,
			FireInterval = 0.35,

			TargetOffsetDistanceMin = 10,
			TargetOffsetDistanceMax = 10,
			TeleportToTargetId = true,

			Spread = 45,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionDemeter =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionDemeter",
			
			PreAttackDuration = 2.0,
			PreAttackFx = "DevotionPreAttackBase_Demeter",
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.25,
			PostAttackCooldownMax = 3.0,
			TeleportToTargetId = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsPlayerRadius = 900,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionAphrodite =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionAphrodite",
			
			PreAttackDuration = 0.0,
			PreFireAnimation = "DevotionPreAttackBase_Aphrodite",
			PreFireDuration = 2.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.0,
			PostAttackCooldownMax = 3.0,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 250,
			TargetOffsetDistanceMax = 350,
			TeleportToTargetId = true,

			FireTicks = 1,
			FireCooldown = 0.0,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.40, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionHephaestus =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionHephaestus",

			PreAttackDuration = 1.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 1.25,
			PostAttackCooldownMax = 3.75,
			TeleportToTargetId = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsPlayerRadius = 250,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil