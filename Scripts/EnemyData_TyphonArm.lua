UnitSetData.TyphonArm =
{

	TyphonArm =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy" },
		Material = "Organic",
		IsBoss = false,
		BlockPostBossMetaUpgrades = true,
		BlockCharm = true,
		BlockRaiseDead = true,

		Groups = { "FlyingEnemies" },
		RunHistoryPortrait = "Codex_Portrait_TyphonArm",
		DeathAnimation = "Enemy_TyphonArm_Death",
		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs =
		{
			Message = "PrometheusDefeatedMessage",
			CameraPanTime = 1.5,
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			BatsAfterDeath = false,
			FlashRed = true,
		},

		MaxHealth = 25000,
		AISetupDelay = 1.5,

		AngleMin = 250,
		AngleMax = 360,

		DefaultAIData =
		{
		},
		WeaponOptions =
		{
			"TyphonArmSlam", "TyphonArmCast", "TyphonArmFlick"
		},

		AIEndHealthThreshold = 0.0,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},
	},

	TyphonArm_Incursion =
	{
		GenusName = "TyphonArm",
		Groups = { "EnemyTeam", "FlyingEnemies" },
		RunHistoryPortrait = "Codex_Portrait_TyphonArm",
		CannotDieFromDamage = true,
		IgnoreSprintPhasingStasisStun = true,
		IgnoreCastSummonDamage = true,
		MaxHealth = 1,

		ExitAnimation = "Enemy_TyphonArm_Exit",

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			}
		},
		
		DefaultAIData =
		{
		},
	}
}

OverwriteTableKeys( EnemyData, UnitSetData.TyphonArm )


WeaponSetData =
{
	TyphonArmSlam =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonArmSlamNova",
			FireProjectileAtSelf = true,

			AttackDistance = 100,
			--PreMoveTrackTarget = true,
			MoveWithinRange = false,
			--StopMoveWithinRange = false,

			PreAttackSetZHeight = 3000,
			PreAttackSetZDuration = 1.35,
			FireSetZHeight = 0,
			FireSetZDuration = 0.3,
			PreFireTeleport = true,
			TeleportToTarget = true,
			PreFireDuration = 0.6,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh",
			PreAttackAnimation = "Enemy_TyphonArm_SlamPreFire",
			FireAnimation = "Enemy_TyphonArm_SlamFire",
			PostAttackAnimation = "Enemy_TyphonArm_SlamPostFire",

			PreAttackAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = false,

			PreAttackDuration = 1.35,
			FireDuration = 4.0,
			PostAttackDuration = 3.0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/CerberusGroundSlam" },
			},
		},
	},

	TyphonArmFlick =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonFlickWave",
			NumProjectiles = 5,
			ProjectileAngleInterval = 45,
			--ProjectileStartAngleOffset = -30,
			BarrelLength = 200,
			FireProjectileStartDelay = 0.1,

			PreAttackSetZHeight = 0,
			PreAttackSetZDuration = 0.3,
			PreMoveTeleport = true,
			TeleportToId = 779558,
			--PreFireDuration = 0.6,

			MoveWithinRange = false,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh",
			PreAttackAnimation = "Enemy_TyphonArm_FlickPreFire",
			FireAnimation = "Enemy_TyphonArm_FlickFire",
			PostAttackAnimation = "Enemy_TyphonArm_FlickPostFire",

			PreAttackAngleTowardTarget = true,
			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			AngleTowardsTargetWhileFiring = false,

			PreAttackDuration = 0.95,
			FireDuration = 0.5,
			PostAttackDuration = 3.0,

			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Menu Sounds/CWTrapDoorSlide" },
			},
		},
	},

	TyphonArmCast =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonEyeCast",
			NumProjectiles = 30,
			ProjectileInterval = 0.1,
			Spread = 360,

			PreAttackDuration = 1.5,
			FireDuration = 3.0,
			PostAttackDuration = 1.58,

			PreAttackAnimation = "Enemy_TyphonArm_CastPreFire",
			FireAnimation = "Enemy_TyphonArm_CastFire",
			PostAttackAnimation = "Enemy_TyphonArm_CastPostFire",

			AttackDistance = 9999,
			MoveWithinRange = false,
			PreAttackTeleport = true,
			TeleportToId = 779558,

			AngleTowardsTargetWhileFiring = false,
			TrackTargetDuringCharge = false,

		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/CorruptedCerberus/Cerberus_GroundPound" },
			},
		},
	}
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil