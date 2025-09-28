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
			PreMoveTeleport = true,
			TeleportToTarget = true,

			FireTicksMin = 9,
			FireTicksMax = 12,
			FireInterval = 0.2,
			ResetTargetPerTick = true,
			CreateOwnTargetFromOriginalTarget = true,
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

			PreMoveTeleport = true,
			TeleportMinDistance = 300,
			TeleportMaxDistance = 1000,
			TeleportationInterval = 0,
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
			PostAttackEndTeleport = true,
			TeleportToTarget = true,

			CreateOwnTargetFromOriginalTarget = true,

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
			PostAttackCooldownMin = 1,
			PostAttackCooldownMax = 2,
			CreateOwnTargetFromOriginalTarget = true,
			RandomTargetAngle = true,
			TargetOffsetDistanceMin = 100,
			TargetOffsetDistanceMax = 300,
			PreMoveTeleport = true,
			TeleportToTarget = true,
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

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 1.5,
			PostAttackCooldownMax = 3.0,

			FireTicksMin = 3,
			FireTicksMax = 4,
			FireInterval = 0.15,

			CreateOwnTargetFromOriginalTarget = true,
			TargetOffsetDistanceMin = 50,
			TargetOffsetDistanceMax = 200,
			PreMoveTeleport = true,
			TeleportToTarget = true,

			Spread = 360,
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
			PreMoveTeleport = true,
			TeleportToTarget = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 900,
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
			PreMoveTeleport = true,
			TeleportToTarget = true,

			FireTicks = 1,
			FireCooldown = 0.0,
		},
	},

	DevotionHephaestus =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionHephaestus",

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 2.0,
			PostAttackCooldownMax = 3.0,
			PreMoveTeleport = true,
			TeleportToTarget = true,

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 250,
		},
	},

	DevotionAres =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DevotionAres",

			AttackSlots =
			{
				{ AIDataOverrides = { BarrelLength = 0 }, PauseDuration = 0.1 },
				{ AIDataOverrides = { BarrelLength = 500 }, PauseDuration = 0.1 },
				{ AIDataOverrides = { BarrelLength = 1000 }, },
			},

			PreAttackDuration = 0.25,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldownMin = 1.25,
			PostAttackCooldownMax = 2.25,

			PreMoveTeleport = true,
			TeleportMaxDistance = 500,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil