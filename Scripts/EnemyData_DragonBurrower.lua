UnitSetData.DragonBurrower =
{

	DragonBurrower =
	{
		InheritFrom = { "BaseQEnemy", "BaseVulnerableEnemy", },
		
		ActivateAnimation = "Enemy_DragonBurrower_Spawn",
		ActivateFx = "DragonBurrowerBurrowFxActivate",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0,
		ActivateDuration = 0.2,
		WakeUpDelay = 0.35,
		PostActivateStop = true,
		PostActivateScreenshake = { Distance = 4, Speed = 250, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 200 },

		--DeathAnimation = "Enemy_DragonBurrower_Death",
		--DeathSound = "/SFX/Enemy Sounds/DragonBurrower/EmoteDying",

		GrannyTexture = "GR2/DraconTyphon_Color",

		MaxHealth = 600,
		HealthBarOffsetY = -150,
		HealthBarType = "Medium",

		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/RangedBurrower/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/RangedBurrower/EmoteDying",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetalRapid",
			Rapid = "HitSparkEnemyDamagedMetalRapid",
		},

		StunAnimations = 
		{
			Default = "Enemy_DragonBurrower_OnHit",
			Heavy = "Enemy_DragonBurrower_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 1,
		},

		WeaponOptions =
		{
			"DragonBurrowerRanged",
			"DragonBurrowerBurrow",
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "AttackerAI",

		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"DragonBurrower_Elite"}
		},
		
		EnemySightedVoiceLines =
		{
			-- { GlobalVoiceLines = "MonstersSightedVoiceLines" },
		},
	},

	DragonBurrower_Elite =
	{
		InheritFrom = { "Elite", "DragonBurrower" },
		HealthBuffer = 600,
		IsAggroedSound = "/SFX/Enemy Sounds/RangedBurrower/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DragonBurrowerRanged_Elite",
			"DragonBurrowerBurrow",
		},

		HeraclesCombatMoneyValue = 2,
		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"DragonBurrower"}
		},
	},

	DragonBurrower_Shadow =
	{
		InheritFrom = { "Shadow", "DragonBurrower",},
		GenusName = "DragonBurrower",
		HealthBuffer = 600,

		WeaponOptions =
		{
			"DragonBurrowerRanged_Elite",
			"DragonBurrowerBurrow",
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.DragonBurrower )

WeaponSetData =
{
	DragonBurrowerRanged =
	{
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "DragonBurrowerRanged",

			PreAttackDuration = 0.33,
			FireDuration = 0.15,
			PostAttackDuration = 1.25,

			BarrelLength = 85,

			PreAttackAnimation = "Enemy_DragonBurrower_RangedPreFire",
			FireAnimation = "Enemy_DragonBurrower_RangedFire_Single",
			PostAttackAnimation = "Enemy_DragonBurrower_RangedPostFire",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.07,
			StopBeforeFire = true,

			AttackDistance = 1800,
			MoveWithinRange = false,

			--ForceFirst = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/RangedBurrower/EmoteAttacking" },
			},
		},
	},

	DragonBurrowerRanged_Elite =
	{
		InheritFrom = { "DragonBurrowerRanged" },
		AIData =
		{
			DeepInheritance = true,

			FireDuration = 0.77,
			PostAttackDuration = 0.75,

			FireAnimation = "Enemy_DragonBurrower_RangedFire_Triple",

			NumProjectiles = 3,
			ProjectileInterval = 0.25,
		},
	},

	DragonBurrowerBurrow =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 2,
			MinRequiredKillEnemies = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.34,
			PostAttackAlpha = 0,
			PostAttackDuration = 0.0,

			PreAttackStopAnimations = { "DragonBurrowerBurrowFxPersistent"},
			PreAttackFx = "DragonBurrowerBurrowFxOut",
			FireAnimation = "Enemy_DragonBurrower_Burrow",
			PostAttackAnimation = "Enemy_DragonBurrower_Hidden",

			PostAttackEndTeleport = true,
			TeleportMinDistance = 400,
			TeleportMaxDistance = 99999,

			AttackDistance = 9999,
			MoveWithinRange = false,

			ChainedWeapon = "DragonBurrowerUnburrow",

			PreAttackRemoveEnemyUI = true,
			SkipSurroundAICount = true,
		},
	},
	DragonBurrowerUnburrow =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,
			MoveWithinRange = false,
			TargetSelf = true,

			PreAttackAlpha = 0,
			PreAttackDurationMin = 0.8,
			PreAttackDurationMax = 1.8,
			FireAlpha = 1,
			FireDuration = 0.42,
			PostAttackDurationMin = 0.55,
			PostAttackDurationMax = 0.65,

			PreAttackAnimation = "Enemy_DragonBurrower_Hidden",
			FireAnimation = "Enemy_DragonBurrower_Unburrow",
			PostAttackAnimation = "Enemy_DragonBurrower_Idle",

			DoNotRepeatOnAttackFail = true,
			FireCreateHealthBar = true,

			SkipSurroundAICount = true,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil