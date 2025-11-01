UnitSetData.Captain =
{

	Captain =
	{
		InheritFrom = { "Elite", "BaseVulnerableEnemy" },
		RunHistoryKilledByName = "Captain",
		
		BlockRespawnShrineUpgrade = true,
		BlockRaiseDead = true,
		IsBoss = false,
		BlockCharm = true,
		IgnoreSpeedShrine = true,
		IgnoreSprintPhasingStasisStun = true,

		Groups = { "GroundEnemies" },

		MaxHealth = 1000,
		HealthBuffer = 8800,
		HealthBarType = "ExtraLarge",
		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -110,

		InvulnerableFx = "nil",
		SkipDamagedFx = true,
		SkipUnitHitFlash = true,
		ArmorSparkAnimation = "Blank",

		WakeUpDelay = 3.0,
		AIAggroRange = 9999,

		IsAggroedSound = "/SFX/Enemy Sounds/ZombieCaptain/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/ZombieCaptain/EmoteDying",
		DeathAnimation = "Enemy_Captain_Death",
		DeathFx = "EnemyDeathFxUndead",

		StunAnimations = 
		{
			Default = "Enemy_Captain_OnHit",
			Heavy = "Enemy_Captain_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"CaptainPistol", "CaptainSword", "CaptainReposition"
			--"CaptainReposition",
		},

		AIOptions =
		{
			"AggroAI",
		},

		MoneyDropOnDeath =
		{
			Chance = 0.25,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.2,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		GeneratorData =
		{
			DifficultyRating = 200,
			--BlockEnemyTypes = {"Carrion_Elite"}
		},
	},

	Captain_Shadow =
	{
		InheritFrom = { "Shadow", "Captain" },
		GenusName = "Captain",

		HealthBuffer = 3000,
		HealthBarAttachToMarkerName = "nil",
		HealthBarOffsetY = -230,
		HealthBarType = "MediumLarge",

		WeaponOptions =
		{
			"CaptainPistol_Shadow",
		},
	},

	Captain_SuperElite =
	{
		InheritFrom = { "SuperElite", "Captain" },
		GenusName = "Captain",
		BlockRaiseDead = false,

		UseActivatePresentation = false,
		WakeUpDelay = 0.0,
		CreateAnimations = { "EnemyPreSpawnTerrainChronosLarge" },

		MaxHealth = 3000,
		HealthBuffer = 6000,
		HealthBarAttachToMarkerName = "nil",
		HealthBarOffsetY = -230,
		HealthBarType = "MediumLarge",

		WeaponOptions =
		{
			"CaptainPistol_Shadow",
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Captain )

WeaponSetData =
{
	CaptainPistol =
	{
		Requirements =
		{
			MinPlayerDistance = 500,
			MaxConsecutiveUses = 0,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceFirst = true,

			ProjectileName = "CaptainPistolShot",
			BarrelLength = 200,

			NumProjectiles = 3,
			ProjectileInterval = 0.05,
			FireProjectileStartDelay = 0.0,
			Spread = 10,

			PreAttackDurationMin = 0.8,
			PreAttackDurationMax = 1.2,
			FireDuration = 0.6,
			PostAttackDuration = 0.6, -- anim is 0.53

			PreAttackAnimation = "Enemy_Captain_PistolPreFire",
			PreAttackSound = "/SFX/Enemy Sounds/ZombieCaptain/EmoteAiming",
			FireAnimation = "Enemy_Captain_PistolFire",
			PostAttackAnimation = "Enemy_Captain_PistolPostFire",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.01,
			StopBeforeFire = true,

			AttackDistance = 1550,
			AttackDistanceScaleY = 0.48,
			RequireProjectileLoS = true,
			LoSBuffer = 25,

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 800,
			RetreatTimeout = 1.5,

			ChainedWeapon = "CaptainReload",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/ZombieCaptain/EmoteFiring" }
			},
		},
	},

	CaptainPistol_Shadow =
	{
		InheritFrom = { "CaptainPistol" },
		Requirements = {},

		AIData =
		{
			DeepInheritance = true,

			PostAttackDuration = 0.9, -- anim is 0.53

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 1100,
			RetreatTimeout = 2.5,

			NumProjectiles = 1,
			ProjectileInterval = "nil",
			FireProjectileStartDelay = "nil",
			Spread = "nil",
		},
	},

	CaptainPistol_NoRetreat =
	{
		InheritFrom = { "CaptainPistol" },
		GenusName = "CaptainPistol",
		Requirements = {},

		AIData =
		{
			DeepInheritance = true,

			RetreatBeforeAttack = false,
		},
	},

	CaptainReload =
	{
		ChainChance = 0.2,
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 0.0,
			FireDuration = 2.1, -- anim is 2.08
			PostAttackDuration = 0.0,

			PreAttackAngleTowardTarget = false,
			PreAttackStop = true,

			FireAnimation = "Enemy_Captain_Reload",

			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunReloading" },
			},
		},
	},

	CaptainReposition =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "CaptainShrapnel",

			AttackSlots =
			{
				{ UseRandomAngle = true, AnchorAngleOffset = 0, OffsetScaleY = 0.5, },
				{ UseRandomAngle = true, AnchorAngleOffset = 250, OffsetScaleY = 0.5, },
			},

			TargetSelf = true,
			FireTicks = 2,
			FireInterval = 0.3,
			ResetTargetPerTick = true,
			CreateOwnTargetFromOriginalTarget = true,
			TargetOffsetDistanceMin = 0,
			TargetOffsetDistanceMax = 250,
			RandomTargetAngle = true,

			PostAttackEndTeleport = true,
			TeleportMinDistance = 500,
			TeleportMaxDistance = 3000,
			TeleportStartFx = "CaptainTeleportFx",
			TeleportEndFx = "CaptainTeleportFx",
			PostTeleportWait = 0.6,

			PreAttackDuration = 0.5,
			FireDuration = 0.0, -- 0.6 from FireTicks
			PostAttackDuration = 0.85,

			PreAttackAnimation = "Enemy_Captain_Reposition",

			AttackDistance = 9999,
			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,
			TrackTargetDuringCharge = false,

			ChainedWeaponOptions = { "CaptainPistol_NoRetreat", },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/ZombieCaptain/EmoteFiring" },
			},
		},
	},

	CaptainSword =
	{
		Requirements =
		{
			MaxPlayerDistance = 500,
			MaxConsecutiveUses = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "CaptainSwordSwing",
			FireProjectileStartDelay = 0.05,

			PreAttackDuration = 1.0,
			FireDuration = 0.48,
			PostAttackDuration = 0.48,

			PreAttackAnimation = "Enemy_Captain_SwordPreFire",
			PreAttackSound = "/SFX/Enemy Sounds/ZombieCaptain/EmoteCharging",
			FireAnimation = "Enemy_Captain_SwordFire",
			PostAttackAnimation = "Enemy_Captain_SwordPostFire",

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.02,
			StopBeforeFire = true,

			AttackDistance = 400,
			AttackDistanceScaleY = 0.48,
			RequireProjectileLoS = true,
			LoSBuffer = 25,

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 500,
			RetreatTimeout = 1.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/ZombieCaptain/EmoteAttacking" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil