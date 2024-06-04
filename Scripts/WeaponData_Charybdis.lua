WeaponSetData =
{
	CharybdisTentacleUnburrow =
	{
		GenusName = "TreantTailBurrow",

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TentacleShockwave",
			FireProjectileStartDelay = 0.05,
			FireProjectileAtSelf = true,

			PreAttackAnimation = "Enemy_CharybdisTentacle_Hidden",
			PreAttackFx = "CyclopsStompPreviewRing",
			EndPreAttackFx = true,
			FireAnimation = "Enemy_CharybdisTentacle_Surface",
			PostAttackAnimation = "Enemy_CharybdisTentacle_Idle",

			PreAttackAlpha = 0,
			PreAttackDuration = 0.7,
			FireAlpha = 1,
			FireDuration = 1.0,
			PostAttackDurationMin = 0.55,
			PostAttackDurationMax = 0.65,

			PreMoveFunctionName = "SelectTentacleBurrowPoints",

			SetTargetable = true,

			AttackDistance = 75,
			MoveSuccessDistance = 32,

			DoNotRepeatOnAttackFail = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charybdis/EmoteAttackingMelee" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	CharybdisTentacleBurrow =
	{
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.98,
			PostAttackAlpha = 0,
			PostAttackDurationMin = 4.0,
			PostAttackDurationMax = 6.0,
			FireAnimation = "Enemy_CharybdisTentacle_Burrow",
			PostAttackAnimation = "Enemy_CharybdisTentacle_Hidden",

			AttackDistance = 9999,

			ChainedWeapon = "CharybdisTentacleUnburrow",

			ClearAllEffects = true,
			SetUntargetable = true,

			PostAttackRemoveEnemyUI = true,
		},

		Requirements =
		{
			MaxConsecutiveUses = 1,
			MinPlayerDistance = 800,
		},

		Sounds =
		{
			FireSounds =
			{
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	CharybdisTentacleSlap =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.1,

			AttackSlots =
			{
				{ ProjectileName = "TentacleSlamWave", AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:tail_06_M_JNT", FireProjectileAngleRelative = -90 }  },
				{ ProjectileName = "TentacleSlamWave", AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:tail_06_M_JNT", FireProjectileAngleRelative = 90 }, PauseDuration = 0.025,  },
				{ ProjectileName = "TentacleSlamWave", AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:tail_14_M_JNT", FireProjectileAngleRelative = -90 } },
				{ ProjectileName = "TentacleSlamWave", AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:tail_14_M_JNT", FireProjectileAngleRelative = 90 }, PauseDuration = 0.02 },
				{ ProjectileName = "TentacleSlamWave", AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:spike_01_M_JNT", FireProjectileAngleRelative = -90 }  },
				{ ProjectileName = "TentacleSlamWave", AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:spike_01_M_JNT", FireProjectileAngleRelative = 90 }  },
				{ ProjectileName = "TentacleSlamWave", AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:spike_01_M_JNT", FireProjectileAngleRelative = 0 }  },
			},

			WaitForAngleTowardTarget = true,
			StopBeforeFire = true,

			PreAttackEndShake = true,

			PreAttackDuration = 1.5,
			FireDuration = 0.3,
			PostAttackDurationMin = 1.55, -- animation is 1.5s
			PostAttackDurationMax = 3.0,

			PreAttackSound = "/SFX/Enemy Sounds/Charybdis/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_CharybdisTentacle_SlapPreFire",
			FireAnimation = "Enemy_CharybdisTentacle_SlapFire",
			PostAttackAnimation = "Enemy_CharybdisTentacle_SlapPostFire",

			AttackDistance = 9999,
		},

		Requirements =
		{
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charybdis/EmoteAttackingMelee" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.00, LerpTime = 0.06 },
		},
	},

	CharybdisTentacleSpike =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TentacleSpike",

			WaitForAngleTowardTarget = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.06,
			StopBeforeFire = true,

			FireProjectileStartDelay = 0.02,

			MoveWithinRange = false,

			PreAttackDuration = 1.1,
			FireDuration = 0.4,
			PostAttackDurationMin = 1.35, -- animation is 1.3
			PostAttackDurationMax = 1.97,

			PreAttackSound = "/SFX/Enemy Sounds/Charybdis/EmoteChargingRanged",
			PreAttackAnimation = "Enemy_CharybdisTentacle_SpikePreFire",
			FireAnimation = "Enemy_CharybdisTentacle_SpikeFire",
			PostAttackAnimation = "Enemy_CharybdisTentacle_SpikePostFire",

			AttackDistance = 9999,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/ArcherTrapProjectileFireShoot" },
				{ Name = "/SFX/Enemy Sounds/Charybdis/EmoteAttackingMelee" },
			},
		},

		Requirements =
		{
			--MinPlayerDistance = 400,
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},

	CharybdisTentacleWhip =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "Tentacle360Whip",

			WaitForAngleTowardTarget = true,

			PreAttackEndShake = true,

			PreAttackDuration = 1.5,
			FireDuration = 0.48,
			PostAttackDurationMin = 1.7, -- animation is 1.65
			PostAttackDurationMax = 2.5,

			PreAttackSound = "/SFX/Enemy Sounds/Charybdis/EmoteChargingMelee",
			PreAttackAnimation = "Enemy_CharybdisTentacle_WhipPreFire",
			FireAnimation = "Enemy_CharybdisTentacle_WhipFire",
			PostAttackAnimation = "Enemy_CharybdisTentacle_WhipPostFire",

			AttackDistance = 9999,

			ForceUseIfReady = true,
		},

		Requirements =
		{
			MaxPlayerDistance = 750
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Charybdis/EmoteAttackingMelee" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.00, LerpTime = 0.06 },
		},
	},

	CharybdisSpit1 =
	{
		AIData =
		{
			DeepInheritance = true,
			ImmuneToProjectileSlow = true,

			ProjectileName = "CharybdisRangedTransport",
			SpawnFromMarker = "Charybdis_Rig:mawTooth_01_M_JNT",

			FireProjectileStartDelay = 0.1,
			FireTicks = 3,
			FireInterval = 0.65,
			FireFx = "CharybdisSpitFireFx",

			Spread = 45,
			
			FireProjectileAtTarget = true,
			
			AttackDistance = 99999,

			PreAttackDuration = 2.5,
			FireDuration = 0.0,
			PostAttackDuration = 0.01,

			PreAttackSound = "/SFX/Enemy Sounds/Exalted/EmoteRespawning",
			PreAttackAnimation = "Enemy_Charybdis_SpitPreFire",
			FireAnimation = "Enemy_Charybdis_SpitFireLoop",
			PostAttackAnimation = "Enemy_Charybdis_SpitPostFire",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusGunGrenadeLaunchFire" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	CharybdisSpit2 =
	{
		InheritFrom = { "CharybdisSpit1" },
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 5,

			FireDuration = 0.0,
		},
	},

	CharybdisSpit3 =
	{
		InheritFrom = { "CharybdisSpit1" },
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 8,

			FireDuration = 0.0,
		},
	},

	CharybdisSpitSmall =
	{
		InheritFrom = { "CharybdisSpit1" },
		AIData =
		{
			DeepInheritance = true,

			FireTicks = 1,
			FireInterval = 0.0,

			FireDuration = 0.65,
			PostAttackDurationMin = 5.0,
			PostAttackDurationMax = 10.0,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil