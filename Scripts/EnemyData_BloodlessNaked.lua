UnitSetData.BloodlessNaked =
{
	BloodlessNaked =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		Material = "Bone",

		MaxHealth = 310,
		HealthBarType = "Medium",
		HealthBarOffsetY = -155,

		PreferredSpawnPoint = "EnemyPointMelee",

		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Bloodless01/EmoteDying",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedSkeleton",
			Rapid = "HitSparkEnemyDamagedSkeletonRapid",
		},
		StunAnimations = 
		{
			Default = "Enemy_BloodlessNaked_OnHit",
			Heavy = "Enemy_BloodlessNaked_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			LeapSound = "/SFX/Enemy Sounds/Bloodless01/EmoteThrustAttacking",
			LeapLandingSound = "/SFX/Enemy Sounds/Bloodless01/EmoteHurt",
			LeapSpeed = 2000,
			LeapPrepareTime = 0.32,
			LeapRecoveryTime = 0.5,
			LeapOffsetRange = 700,
			LeapWhenTargetBeyondDistance = 750,
			LeapWhenTargetOutOfSight = true,
			LeapChargeAnimation = "Enemy_BloodlessNaked_Leap",
			LeapLandingAnimation = "Enemy_BloodlessNaked_LeapLand",
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "LeapIntoRangeAI",

		WeaponOptions = { "BloodlessMelee" },

		GeneratorData =
		{
			DifficultyRating = 12,
			BlockEnemyTypes = {"BloodlessNaked_Elite"}
		},
	},

	BloodlessNaked_Elite =
	{
		InheritFrom = { "Elite", "BloodlessNaked" },
		HealthBuffer = 250,
		IsAggroedSound = "/SFX/Enemy Sounds/Bloodless01/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 25,
			BlockEnemyTypes = {"BloodlessNaked"}
		},
	},

	BloodlessBerserker =
	{
		InheritFrom = { "BloodlessNaked" },

		MaxHealth = 400,

		HealthBarOffsetY = -155,
		HealthBarType = "MediumLarge",

		CancelWeaponComboOnHitStun = true,

		IsAggroedSound = "/SFX/Enemy Sounds/BloodlessBerserker/EmoteAlerted",

		WeaponOptions =
		{
			"BloodlessMeleeBerserkerCombo1"
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			LeapWhenTargetBeyondDistance = 99999,
			LeapWhenTargetOutOfSight = false,
			LeapRecoveryTime = 1.0,
			RetreatLeapDistance = 800,
			RetreatLeapMinDistance = 50,

			DoNotRepeatOnAttackFail = true,
		},

		GeneratorData =
		{
			DifficultyRating = 30,
			BlockEnemyTypes = {"BloodlessBerserker_Elite"}
		},
	},

	BloodlessBerserker_Elite =
	{
		InheritFrom = { "Elite", "BloodlessBerserker" },
		IsAggroedSound = "/SFX/Enemy Sounds/BloodlessBerserker/EmoteTaunting",

		HealthBuffer = 325,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 80,
			BlockEnemyTypes = {"BloodlessBerserker"}
		},
	},

	BloodlessWaveFist =
	{
		InheritFrom = { "BloodlessNaked" },

		MaxHealth = 430,

		HealthBarOffsetY = -175,
		HealthBarType = "MediumLarge",

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapWhenTargetWithinDistance = 550,
			LeapWhenTargetOutOfSight = false,

			RetreatLeapDistance = 2000,
			RetreatLeapMinDistance = 1500,

			LeapChargeAnimation = "Enemy_BloodlessNaked_LeapLong",
			LeapLandingAnimation = "Enemy_BloodlessNaked_LeapLongLand",
		},

		WeaponOptions =
		{
			"BloodlessWaveFistWeapon",
		},

		GeneratorData =
		{
			DifficultyRating = 40,
			BlockEnemyTypes = {"BloodlessWaveFist_Elite"}
		},
	},

	BloodlessWaveFist_Elite =
	{
		InheritFrom = { "Elite", "BloodlessWaveFist" },
		
		HealthBuffer = 450,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"BloodlessWaveFistWeaponElite",
		},

		GeneratorData =
		{
			DifficultyRating = 75,
			BlockEnemyTypes = {"BloodlessWaveFist"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.BloodlessNaked )