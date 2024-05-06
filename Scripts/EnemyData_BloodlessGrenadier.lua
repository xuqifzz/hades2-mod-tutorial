UnitSetData.BloodlessGrenadier =
{
	BloodlessGrenadier =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		Material = "Bone",

		PreferredSpawnPoint = "EnemyPointRanged",

		MaxHealth = 500,
		HealthBarType = "Large",
		HealthBarOffsetY = -220,
		AttachedAnimationOffsetZ = 0,

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless02/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/Bloodless02/EmoteDying",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		StunAnimations = 
		{
			Default = "Enemy_BloodlessGrenadier_OnHit",
			Heavy = "Enemy_BloodlessGrenadier_OnHit_Heavy",
		},

		OnDeathFireWeapons = { "BloodlessGrenadierDeathDrop" },
		DeathAnimation = "EnemyDeathFx_Medium",
		DeathFx = "EnemyDeathFx",
		DeathSound = "/SFX/Enemy Sounds/Bloodless02/EmoteDying",

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapChargeAnimation = "Enemy_BloodlessGrenadier_Leap",
			LeapLandingAnimation = "Enemy_BloodlessGrenadier_LeapLand",
			LeapSound = "/SFX/Enemy Sounds/Bloodless02/EmoteThrustAttacking",
			LeapLandingSound = "/SFX/Enemy Sounds/Bloodless02/EmoteHurt",
			LeapWhenTargetBeyondDistance = 500,
			LeapWhenTargetOutOfSight = true,
			LeapSpeed = 2000,
			LeapPrepareTime = 0.5,
			LeapRecoveryTime = 0.5,
			LeapOffsetRange = 1200,
			RetreatLeapDistance = 1500,
			RetreatLeapMinDistance = 600,
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "LeapIntoRangeAI",

		WeaponOptions = { "BloodlessGrenadierRanged", "BloodlessGrenadierCluster" },

		ActiveCapWeight = 1,

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"BloodlessGrenadier_Elite"}
		},
	},

	BloodlessGrenadier_Elite =
	{
		InheritFrom = { "Elite", "BloodlessGrenadier" },

		HealthBuffer = 700,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"BloodlessGrenadier"}
		},
	},

	BloodlessSelfDestruct =
	{
		InheritFrom = { "BloodlessGrenadier" },

		PreferredSpawnPoint = "EnemyPointMelee",

		MaxHealth = 500,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -160,

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteAlerted",

		WeaponOptions = { "BloodlessGrenadierDive", "BloodlessReposition" },

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapLandingSound = "/EmptyCue",

			RepositionLeap = true,
			LeapOffsetRange = 300,
			LeapRecoveryTime = 0.5,
			RetreatTimeout = 1.5,

			LeapWhenTargetBeyondDistance = 300,
		},

		GeneratorData =
		{
			DifficultyRating = 35,
			BlockEnemyTypes = {"BloodlessSelfDestruct_Elite"}
		},
	},

	BloodlessSelfDestruct_Elite =
	{
		InheritFrom = { "Elite", "BloodlessSelfDestruct" },

		HealthBuffer = 600,

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteTaunting",

		WeaponOptions = { "BloodlessGrenadierDive", "BloodlessReposition", "BloodlessReposition" },
		--ChanceToRepositionAsWeapon = 0.75,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 55,
			BlockEnemyTypes = {"BloodlessSelfDestruct"}
		},
	},

	BloodlessPitcher =
	{
		InheritFrom = { "BloodlessGrenadier" },

		MaxHealth = 350,
		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -200,

		WeaponOptions = { "BloodlessPitch", "BloodlessPitchCurve" },

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackSound = "/SFX/Enemy Sounds/Bloodless02/EmoteCharging",

			LeapWhenTargetBeyondDistance = 2000,
			LeapWhenTargetWithinDistance = 800,
			LeapWhenTargetOutOfSight = true,
			LeapOffsetRange = 750,
			RetreatLeapWhenHitChance = 0.8,
			RetreatLeapDistance = 1500,
			RetreatLeapMinDistance = 500,
		},

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"BloodlessPitcher_Elite"}
		},
	},

	BloodlessPitcher_Elite =
	{
		InheritFrom = { "Elite", "BloodlessPitcher" },
		
		HealthBuffer = 400,

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless02/EmoteTaunting",

		WeaponOptions = { "BloodlessPitch", "BloodlessPitchCurveVolley" },

		DefaultAIData =
		{
			DeepInheritance = true,
			PreAttackDurationMax = 1.0,
		},

		GeneratorData =
		{
			DifficultyRating = 95,
			BlockEnemyTypes = {"BloodlessPitcher"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.BloodlessGrenadier )