WeaponSetData =
{
	LycanthropePounce =
	{
		AIData =
		{
			DeepInheritance = true,

			DumbFireWeapons = { "LycanthropeLeapKnockback", "LycanthropeLeapKnockbackFriends" },

			ProjectileName = "LycanthropePounce",
			FireSelfVelocity = 2300,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			FireProjectileStartDelay = 0.42,
			PreAttackDuration = 0.6,
			PreAttackAnimationSpeed = 1.5,
			FireDuration = 0.5,
			PostAttackDuration = 1.1,

			PreAttackEndShake = true,

			WaitForAngleTowardTarget = true,
			StopBeforeFire = false,
			PostAttackStop = true,

			AttackDistance = 730,
			AttackDistanceScaleY = 0.8,
			LoSBuffer = 85,
			RequireUnitLoS = true,

			PreAttackSound = "/SFX/Enemy Sounds/Werewolf/EmoteCharging",
			PreAttackAnimation = "Enemy_Lycanthrope_PouncePreFire",
			FireAnimation = "Enemy_Lycanthrope_PounceFire",
			PostAttackAnimation = "Enemy_Lycanthrope_PouncePostFire",

			RetreatBufferDistance = 1200,
			RetreatAfterAttack = true,
			RetreatTimeoutMin = 4.0,
			RetreatTimeoutMax = 5.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteAttacking" },
			},
		},

		HitScreenshake = { Distance = 12, Speed = 970, Duration = 0.17, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	LycanthropeLeapKnockback =
	{
		AIData =
		{
			DeepInheritance = true,

			DashIfOverDistance = 99999,

			FireProjectileStartDelay = 0.0,
			ProjectileName = "LycanthropeLeapKnockback",

			MoveWithinRange = false,
			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/Leftovers/SFX/CaravanDamage" },
				--{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},

		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.3, FalloffSpeed = 3000, Angle = 0 },
		
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.05 },
		},
	},

	LycanthropeLeapKnockbackFriends =
	{
		InheritFrom = { "LycanthropeLeapKnockback" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "LycanthropeLeapKnockbackFriends",
		},
	},

	LycanthropePounce_Elite =
	{
		InheritFrom = { "LycanthropePounce" },

		AIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 0.7,

			RetreatBufferDistance = 1600,
			RetreatAfterAttackChance = 0.3,

			AttackDistance = 890,
			AttackDistanceScaleY = 0.7,
			LoSBuffer = 85,
			FireSelfVelocity = 2600,
		},
	},

	LycanthropeHowlSummons =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 6,
			MaxActiveSpawns = 3,
			RequiresNotCharmed = true,
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			DoNotRepeatOnAttackFail = true,

			AttackDistance = 99999,
			MoveWithinRange = false,

			PreAttackAnimation = "Enemy_Lycanthrope_Howl",

			PreAttackDuration = 0.5,
			PostAttackDuration = 1.25,

			ProjectileName = "LycanSummonHowl",

			SpawnBurstOnFire = true,
			SpawnBurstDelay = 1.0,
			SpawnRate = 0.25,
			SpawnOnSpawnPoints = true,
			SpawnRadius = 300,
			--SpawnRadiusMin = 100,
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 3,
			MaxActiveSpawns = 3,
			SpawnerOptions = { "LycanSwarmer" },
			SpawnAggroed = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteHowling" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	LycanthropeHowlSummons_Elite =
	{
		InheritFrom = { "LycanthropeHowlSummons" },

		AIData =
		{
			DeepInheritance = true,

			SpawnerOptions = { "LycanSwarmer_Elite" },
		},
	},

	LycanSwarmerChomp =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LycanSwarmerChomp",

			FireSelfVelocity = 1600,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackHighGrip,
			},

			FireProjectileStartDelay = 0.03,

			--PreAttackDuration = 0.45/2,
			--PreAttackAnimationSpeed = 1.5,
			PreAttackDuration = 0.45,
			FireDuration = 0.15,
			PostAttackDuration = 0.5, -- animation is 0.45

			PreAttackSound = "/SFX/Enemy Sounds/LycanSwarmer/EmoteCharging",
			PreAttackAnimation = "Enemy_LycanSwarmer_ChompPreFire",
			FireAnimation = "Enemy_LycanSwarmer_ChompFire",
			PostAttackAnimation = "Enemy_LycanSwarmer_ChompPostFire",

			PreAttackEndShake = true,

			FireFx = "LycanSwarmerStreaks",

			AttackDistance = 250,

			RetreatAfterAttack = true,
			RetreatAfterAttackChance = 0.5,
			RetreatBufferDistance = 590,
			RetreatTimeoutMin = 2.2,
			RetreatTimeoutMax = 2.8,

			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,
		},
		
		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/LycanSwarmer/EmoteAttacking" },
			},
		},
	},

	LycanSwarmerChomp_Elite =
	{
		InheritFrom = { "LycanSwarmerChomp" },

		AIData =
		{
			DeepInheritance = true,
			PreAttackStop = true,
			FireTicks = 3,
			FireInterval = 0.5,
			FireDuration = 0,
			PostAttackDuration = 0.3,
			--AngleTowardsTargetWhileFiring = true,
			TrackTargetDuringFire = true,
			FireRotationDampening = 0.05,
			PostAttackStop = true,
		},
	},

	LycanSwarmerBlink =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			FireSelfVelocity = 2000,
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			WaitForAngleTowardTarget = true,

			--PreAttackAnimation = "",
			FireAnimation = "Enemy_LycanSwarmer_Blink",
			PostAttackAnimation = "Enemy_LycanSwarmer_BlinkPostFire",

			FireFx = "LycanSwarmerStreaks",

			PreAttackDuration = 0.0,
			FireDuration = 0.25,
			PostAttackDuration = 0.3, -- animation is 0.23

			CreateOwnTargetFromOriginalTarget = true,
			UseAngleBetweenTarget = true,
			TargetOffsetDistance = -800,

			AttackDistance = 800,
			RequireUnitLoS = true,
			LoSBuffer = 80,
			LoSEndBuffer = 32,
		},

		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/LycanSwarmer/EmoteEvading" },
				{ Name = "/Leftovers/SFX/HarpDash" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil