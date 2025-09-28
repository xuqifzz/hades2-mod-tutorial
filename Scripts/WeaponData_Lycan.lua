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
			PreAttackDuration = 0.7,
			PreAttackAnimationSpeed = 1.5,
			FireDuration = 0.5,
			PostAttackDuration = 1.1,

			PreAttackEndShake = true,

			WaitForAngleTowardTarget = true,
			StopBeforeFire = false,
			PostAttackStop = true,

			AttackDistance = 600,
			AttackDistanceScaleY = 0.7,
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
	},

	LycanthropeLeapKnockback =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.0,
			ProjectileName = "LycanthropeLeapKnockback",

			MoveWithinRange = false,
			AttackDistance = 9999,

			-- Rifts ban
			DumbFireWeapons = {},
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/Leftovers/SFX/CaravanDamage" },
				--{ Name = "/SFX/Enemy Sounds/Polyphemus/EmotePowerAttacking" },
			},
		},
	},

	LycanthropeLeapKnockbackFriends =
	{
		InheritFrom = { "LycanthropeLeapKnockback" },
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "LycanthropeLeapKnockbackFriends",

			-- Rifts ban
			DumbFireWeapons = {},
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

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.04,
			StopBeforeFire = true,

			AttackDistance = 730,
			AttackDistanceScaleY = 0.65,
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
			MaxUses = 1,
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

			-- Rifts ban
			DumbFireWeapons = {},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteHowling" },
			},
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

			PreAttackDuration = 0.45,
			FireDuration = 0.15,
			PostAttackDuration = 0.5, -- animation is 0.45

			PreAttackSound = "/SFX/Enemy Sounds/LycanSwarmer/EmoteCharging",
			PreAttackAnimation = "Enemy_LycanSwarmer_ChompPreFire",
			FireAnimation = "Enemy_LycanSwarmer_ChompFire",
			PostAttackAnimation = "Enemy_LycanSwarmer_ChompPostFire",

			PreAttackEndShake = true,
			PreAttackEndFlashFraction = 0.85,

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

	LycanSwarmer2Chomp =
	{
		InheritFrom = { "LycanSwarmerChomp" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "LycanSwarmer2Chomp",

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

	LycanSwarmer2Chomp_Ally =
	{
		InheritFrom = { "LycanSwarmer2Chomp" },

		AIData =
		{
			DeepInheritance = true,

			AttackDistance = 600,
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
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil