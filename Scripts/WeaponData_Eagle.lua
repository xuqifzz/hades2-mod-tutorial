WeaponSetData =
{

	-- Eagle Dive in
	-- Eagle Swoop
	-- Eagle Sonic boom?


	-- Eagle Cast Combo
	EagleDive_P1 =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EagleSwoop",
			FireProjectileStartDelay = 0.25,

			PreAttackStop = true,
			MoveWithinRange = false,
			AttackDistance = 9999,

			TargetSpawnPoints = true,
			TargetSpawnPointsRadius = 400,
			PreAttackTeleport = true,
			TeleportToTarget = true,

			PreAttackFx = "PrometheusEagleDecal",

			PreAttackDurationMin = 0.5,
			PreAttackDurationMax = 2.5,
			FireDuration = 0.6,
			PostAttackDuration = 0.15,

			PreAttackSound = "/SFX/Enemy Sounds/EagleHurt",
			PreAttackAnimation = "Enemy_Eagle_Invisible",
			FireAnimation = "Enemy_Eagle_Descend",
			PostAttackAnimation = "Enemy_Eagle_DescendPostFire_Fast",
			FireSetZHeight = 40,
			FireSetZDuration = 0.25,

			ChainedWeaponOptions = { "EagleFlyUpWhirlwind" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EagleAttackScream" },
				{ Name = "/SFX/Enemy Sounds/Carrion/CarrionSpawnWhoosh" },
				{ Name = "/SFX/Player Sounds/MelinoeAxeSwingShort" },
			},
		},
	},

	EagleDive_P2 =
	{
		InheritFrom = { "EagleDive_P1", },
		AIData =
		{
			ChainedWeaponOptions = { "EagleCastCombo_P2" },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Carrion/CarrionSpawnWhoosh" },
			},
		},
	},

	EagleCastCombo_P2 =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"EagleRush",
			"EagleFlyUpWhirlwind",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},


	EagleDive_P3 =
	{
		InheritFrom = { "EagleDive_P1", },
		AIData =
		{
			ChainedWeaponOptions = { "EagleCastComboLeft_P3", "EagleCastComboRight_P3" },
		},
	},

	EagleDive_Solo =
	{
		InheritFrom = { "EagleDive_P1", },

		Requirements =
		{
			MaxUses = 1,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "MapState", "Flags", "PrometheusKnockedOut", },
			},
		},

		AIData =
		{
			ChainedWeaponOptions = { "EagleCastComboLeft_P3", "EagleCastComboRight_P3" },
		},
	},

	EagleCastComboLeft_P3 =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"EagleRollLeft",
			"EagleRush_Fast",
			"EagleFlyUpWhirlwind",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	EagleCastComboRight_P3 =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"EagleRollRight",
			"EagleRush_Fast",
			"EagleFlyUpWhirlwind",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},

	EagleRush =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EagleSweep",

  			FireSelfVelocity = 5000.0,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "AttackLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.225,
						Modifier = 0.6,
						HaltOnEnd = true,
					}
				},
			},

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.4,

			PreAttackDuration = 0.83,
			PreAttackStartMinWaitTime = 0.2772,
			PreAttackEndMinWaitTime = 0.42,
			FireDuration = 0.3,
			PostAttackDuration = 0.1,

			PreAttackAnimation = "Enemy_Eagle_SweepPreFire",
			FireAnimation = "Enemy_Eagle_SweepFire",
			PostAttackAnimation = "Enemy_Eagle_SweepPostFire_Fast",
			FireProjectileStartDelay = 0.03,

			AttackDistance = 9999,
			MoveWithinRange = false,

			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackSound = "/SFX/Enemy Sounds/EagleHurt",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Carrion/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/Carrion/CarrionAttackWhoosh" },
				{ Name = "/Leftovers/SFX/AuraThrowLarge" },
			},
		},
	},

	EagleRush_Fast =
	{
		InheritFrom = { "EagleRush", },
		AIData =
		{
			PreAttackDuration = 0.28,
			PreAttackStartMinWaitTime = "nil",
			PreAttackEndMinWaitTime = 0.28,
			PreAttackAnimation = "Enemy_Eagle_SweepPreFire_Fast",

			--PreAttackFx = "EagleAimLine",
			EndPreAttackFx = true,
		},
	},

	EagleRush_Olympus =
	{
		InheritFrom = { "EagleRush_Fast", },
		AIData =
		{
			ProjectileName = "EagleSweep_Olympus",

			PreAttackDuration = 0.415,
			PreAttackEndMinWaitTime = 0.415,
			PreAttackAnimation = "Enemy_Eagle_SweepPreFire_Olympus",
		},
	},

	EagleRush_Intro =
	{
		InheritFrom = { "EagleRush", },
		AIData =
		{
			PreAttackDuration = 0.0,
			PreAttackAngleTowardTarget = false,
			WaitForAngleTowardTarget = false,
			PreAttackAnimation = "nil",
		},
	},

	EagleRollLeft =
	{
		GenusName = "EagleRoll",
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EagleRollFireball",

			FireProjectileStartDelay = 0.05,

  			FireSelfVelocity = 1900.0,
  			FireSelfVelocityAngleOffset = 60,

			PreAttackDuration = 0.2,
			FireDuration = 1.22,
			PostAttackDuration = 0.0,

			--PreAttackFx = "EagleAimLine",
			--EndPreAttackFx = true,

			PreAttackAnimation = "Enemy_Eagle_RollLeftPreFire",
			FireAnimation = "Enemy_Eagle_RollLeftFire",

			MoveWithinRange = false,
			AttackDistance = 9999,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.5,
			TrackTargetDuringCharge = true,
			TrackTargetDuringFire = true,
			PostAttackStop = true,

			-- PreAttackSound = "/SFX/Enemy Sounds/EagleHurt",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Carrion/CarrionAttackWhoosh" },
			},
		},
	},

	EagleRollLeft_Olympus =
	{
		InheritFrom = { "EagleRollLeft", },
		AIData =
		{
			ProjectileName = "EagleRollFireball_Olympus",
		},
	},

	EagleRollLeft_Fast =
	{
		InheritFrom = { "EagleRollLeft", },
		AIData =
		{
			ProjectileName = "EagleRollFireball_Fast",
  			FireDuration = 0.61,
		},
	},

	EagleRollRight =
	{
		InheritFrom = { "EagleRollLeft", },
		AIData =
		{
			FireSelfVelocityAngleOffset = -60,
		},
	},

	EagleRollRight_Olympus =
	{
		InheritFrom = { "EagleRollRight", },
		AIData =
		{
			ProjectileName = "EagleRollFireball_Olympus",
		},
	},

	EagleRollRight_Fast =
	{
		InheritFrom = { "EagleRollRight", },
		AIData =
		{
			ProjectileName = "EagleRollFireball_Fast",
  			FireDuration = 0.61,
		},
	},

	EagleFlyUp =
	{
		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			PostAttackStop = true,
			MoveWithinRange = false,

			NoProjectile = true,

			TrackTargetDuringCharge = true,

			AttackDistance = 9999,

			PreAttackDuration = 0.75,
			FireDuration = 0.55,
			PostAttackDuration = 0.6,

			ClearAllEffects = true,

			ChainedWeaponOptions = { "EagleInAirWait" },

			PreAttackAnimation = "Enemy_Eagle_AscendPreFire",
			FireAnimation = "Enemy_Eagle_Ascend",
			PostAttackAnimation = "Enemy_Eagle_Invisible",
			FireSound = "/SFX/Enemy Sounds/EagleAlerted",

			FireSetZHeight = 2000,
			FireSetZDuration = 0.55,
		},
	},

	EagleFlyUpWhirlwind =
	{
		InheritFrom = { "EagleFlyUp" },
		AIData =
		{
			NoProjectile = "nil",
			ProjectileName = "EagleFlyUpWhirlwind",
			NumProjectiles = 8,
			ProjectileAngleEvenlySpaced = true,
			AttackSound = "/SFX/Enemy Sounds/Megaera/MegaeraRushAttack",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EagleAlerted" },
				{ Name = "/SFX/Enemy Sounds/HeavyRangedForked/CrystalBeamFireStart" },
				{ Name = "/SFX/GasBomb" },
			},
		},
	},

	EagleFlyUpWhirlwind_Olympus =
	{
		InheritFrom = { "EagleFlyUpWhirlwind" },
		AIData =
		{
			ProjectileName = "EagleFlyUpWhirlwind_Olympus",
		},
	},

	EagleSummon =
	{
		AIData =
		{
			NoProjectile = true,
			MoveWithinRange = false,
			FireFunctionName = "PrometheusEagleSummonPresentation",
			FireFunctionArgs =
			{
				ZHeight = 500,
				Scale = 5,
				TeleportToId = 751908,
				MoveToId = 751909,
				Speed = 5000,
			},

			PreAttackAngleTowardTarget = false,
			PreAttackDuration = 0,
			FireDuration = 0,
			PostAttackDuration = 0,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Carrion/CarrionAttackWhoosh" },
			},
		},
	},

	EagleInAirWait =
	{
		AIData =
		{
			DeepInheritance = true,
			NoProjectile = true,
			AttackDistance = 9999,

			FireDuration = 3.0,

			ChainedWeaponOptions = { "EagleDive_Solo",  "EagleInAirWait" },

			FireAnimation = "Enemy_Eagle_Invisible",
		},
	},

	EagleInAirLongWait =
	{
		InheritFrom = { "EagleInAirWait" },
		AIData =
		{
			FireDuration = 10.0,
		},
	},

	EagleDive_Olympus =
	{
		InheritFrom = { "EagleDive_P1" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "EagleSwoop_Olympus",

			TeleportToTarget = false,
			TeleportMaxDistance = 400,

			PreAttackDurationMin = 1.0,
			PreAttackDurationMax = 1.0,

			ChainedWeaponOptions = "nil",
		},
	},

	EagleCombo_Spiral =
	{
		AIData =
		{
			DeepInheritance = true,

			--ProjectileName = "PrometheusEagleStreakCombo",
			NoProjectile = true,

			PreMoveTeleport = true,
			StopBeforeTeleport = true,
			StopMoveWithinRange = true,
			TeleportToComboPartner = true,
			EndPartnerWaitOnMoveEnd = true,
			PreAttackSetZHeight = 60,
			PreAttackSetZDuration = 0.19,
			PostAttackSetZHeight = 2000,
			PostAttackSetZDuration = 0.0,

			CreateOwnTarget = true,
			TargetAngleOffset = -75,
			MoveSuccessDistance = 1,
			TargetOffsetDistance = 300,
			SkipIfTargetLocationBlocked = true,

			MoveWithinRange = true,
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
			PreAttackAngleTowardTarget = false,
			PostAttackStop = true,

  			FireSelfVelocity = 500.0,

			PreAttackDuration = 1.17,
			FireDuration = 0.95,
			PostAttackDuration = 5.5,

			AttackDistance = 9999,

			SoundManagerCap = 30,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGroundSlamCharge",
			PreAttackAnimation = "Enemy_Eagle_SpiralCatch",
			FireAnimation = "Enemy_Eagle_SpiralLaunchPreFire",
			PostAttackAnimation = "Enemy_Eagle_Invisible",

			ChainedWeaponOptions = { "EagleInAirWait", },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EagleAttackScream" },
				{ Name = "/SFX/Player Sounds/ApolloStaffFissureSFX" },
			},
		},
		
	},

	EagleIntro =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			MoveWithinRange = false,
			TrackTargetDuringCharge = false,
			AngleTowardsTargetWhileFiring = false,
			PreAttackAngleTowardTarget = false,
			PostAttackStop = true,

  			FireSelfVelocity = 500.0,

			PreAttackDuration = 0,
			FireDuration = 0.45,
			PostAttackDuration = 0.25,

			AttackDistance = 9999,

			SoundManagerCap = 30,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGroundSlamCharge",
			--PreAttackAnimation = "Enemy_Eagle_SpiralLaunchPreFireLoop",
			FireAnimation = "Enemy_Eagle_SpiralLaunchPreFire",
			PostAttackAnimation = "Enemy_Eagle_SpiralLaunchFire",

			ChainedWeaponOptions = { "EagleCombo_Intro", },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/EagleAttackScream" },
				{ Name = "/SFX/Player Sounds/ApolloStaffFissureSFX" },
			},
		},
		
	},

	EagleCombo_Intro =
	{
		WeaponComboOnly = true,
		WeaponCombo =
		{
			"EagleRush_Intro",
			"EagleRollLeft_Fast",
			"EagleRush_Fast",
			"EagleRollRight_Fast",
			"EagleRush_Fast",
			"EagleFlyUpWhirlwind",
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 9999,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil