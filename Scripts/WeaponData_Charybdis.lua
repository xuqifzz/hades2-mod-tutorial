WeaponSetData =
{
	CharybdisTentacleUnburrow =
	{
		GenusName = "TreantTailBurrow",

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TentacleShockwave",
			--FireProjectileStartDelay = 0.05,
			FireProjectileAtSelf = true,

			PreAttackAnimation = "Enemy_CharybdisTentacle_Hidden",
			PreAttackFx = "TentacleUnburrowRadialPreview_In",
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

			PreMoveTeleport = true,
			TeleportToTarget = true,

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
			PostAttackDurationMin = 0.0,
			PostAttackDurationMax = 0.0,
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
	},

	CharybdisTentacleSlap =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.1,

			ProjectileName = "TentacleSlamWave",
			AttackSlots =
			{
				{ AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:tail_06_M_JNT", FireProjectileAngleRelative = -90 }  },
				{ AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:tail_14_M_JNT", FireProjectileAngleRelative = -90 } },
				{ AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:tail_06_M_JNT", FireProjectileAngleRelative = 90 }, PauseDuration = 0.025,  },
				{ AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:tail_14_M_JNT", FireProjectileAngleRelative = 90 }, PauseDuration = 0.02 },
				{ AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:spike_01_M_JNT", FireProjectileAngleRelative = -90 }  },
				{ AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:spike_01_M_JNT", FireProjectileAngleRelative = 90 }  },
				{ AIDataOverrides = { SpawnFromMarker = "CharybdisTentacle_Rig:spike_01_M_JNT", FireProjectileAngleRelative = 0 }  },
			},

			WaitForAngleTowardTarget = true,
			StopBeforeFire = true,

			PreAttackEndShake = true,

			PreAttackDuration = 1.5,
			FireDuration = 0.3,
			PostAttackDurationMin = 2.05, -- animation is 1.5s
			PostAttackDurationMax = 3.15,

			PreAttackSound = "/SFX/Enemy Sounds/Charybdis/EmoteChargingRanged",
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
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh" },
			},
		},
	},

	CharybdisTentacleSlap2 =
	{
		InheritFrom = { "CharybdisTentacleSlap" },

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TentacleSlamWave2",

			PostAttackDuration = 1.5,
		},
	},

	CharybdisTentacleSpike =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TentacleSpike",
			PreAttackFx = "EnemyChargeFxIn_CharybdisTentacle",
			PreAttackStop = true,
			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.06,
			StopBeforeFire = true,

			FireProjectileStartDelay = 0.02,

			MoveWithinRange = false,

			PreAttackDuration = 1.1,
			FireDuration = 0.4,
			PostAttackDurationMin = 2.6, -- animation is 1.3
			PostAttackDurationMax = 3.6,

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
				{ Name = "/SFX/Enemy Sounds/HydraHead/HydraEggSpit" },
				{ Name = "/SFX/ArcherTrapProjectileFireShoot" },
				{ Name = "/SFX/Enemy Sounds/Charybdis/EmoteAttackingRange" },
			},
		},

		Requirements =
		{
			--MinPlayerDistance = 400,
		},

	},

	CharybdisTentacleSpike2 =
	{
		InheritFrom = { "CharybdisTentacleSpike" },

		Requirements =
		{
			MaxPlayerDistance = 1300,
			MaxPlayerDistanceScaleY = 0.6,
			MinPlayerDistance = 950,
			MinPlayerDistanceScaleY = 0.6,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "TentacleSpike" },
				UseLength = true,
				Comparison = "<",
				Value = 2,
			},
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackSetMapFlags =
			{
				{ FlagName = "TentacleSpike", Duration = 3.0 },
			},

			ProjectileName = "TentacleSpike2",

			PostAttackDurationMin = 1.35,
		},

	},

	CharybdisTentacleSpike2_Ally =
	{
		InheritFrom = { "CharybdisTentacleSpike2" },

		Requirements =
		{
		},

		GameStateRequirements =
		{
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TentacleSpike2",

			PostAttackDurationMin = 1.35,
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
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKick" },
			},
		},
	},

	CharybdisTentacleWhip2 =
	{
		InheritFrom = { "CharybdisTentacleWhip" },

		Requirements =
		{
			MaxPlayerDistance = 650,
			MaxPlayerDistanceScaleY = 0.6,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "Tentacle360Whip2",
			PreAttackAngleTowardTarget = false,
			WaitForAngleTowardTarget = false,
			PostAttackAnimation = "Enemy_CharybdisTentacle2_WhipPostFire",

			PreAttackDuration = 1.0,
			PreAttackAnimationSpeed = 1.5,
			PostAttackDurationMin = "nil",
			PostAttackDurationMax = "nil",
			PostAttackDuration = 1.7,
			PostAttackMinWaitTime = 1.53,
		},

	},

	CharybdisTentacleWait =
	{
		Requirements =
		{
			MinPlayerDistance = 650,
			MinPlayerDistanceScaleY = 0.6,
		},

		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,
			SkipFireWeapon = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldown = 1.0,
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
			
			FireProjectileTowardTarget = true,
			
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
				{ Name = "/SFX/Enemy Sounds/Charybdis/EmoteAttackingMelee" },
				{ Name = "/SFX/Enemy Sounds/HydraHead/HydraEggSpit" },
			},
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

			FireTicksMin = 1,
			FireTicksMax = 2,
			FireInterval = 0.5,

			FireDuration = 0.65,
			PostAttackDurationMin = 11.0,
			PostAttackDurationMax = 14.0,
		},
	},

	CharybdisSpitScyllaEasy_P1 =
	{
		InheritFrom = { "CharybdisSpit1" },

		Requirements =
		{
			MaxPlayerDistance = 3900,
			MaxPlayerDistanceScaleY = 0.65,
			GroupHealthPercentMax = 1.00,
			GroupHealthPercentMin = 0.75,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "CharybdisBoost" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "CharybdisRangedTransportSmallScylla",

			FireTicksMin = 1,
			FireTicksMax = 1,
			FireInterval = 0.5,

			FireDuration = 0.65,
			PostAttackDurationMin = 11.0,
			PostAttackDurationMax = 13.0,
		},
	},
	CharybdisSpitScyllaHard_P1 =
	{
		InheritFrom = { "CharybdisSpit1" },

		Requirements =
		{
			MaxPlayerDistance = 3900,
			MaxPlayerDistanceScaleY = 0.65,
			GroupHealthPercentMax = 0.75,
			GroupHealthPercentMin = 0.50,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "CharybdisBoost" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "CharybdisRangedTransportSmallScylla",

			FireTicksMin = 2,
			FireTicksMax = 2,
			FireInterval = 0.5,

			FireDuration = 0.65,
			PostAttackDurationMin = 7.0,
			PostAttackDurationMax = 9.0,
		},
	},

	CharybdisSpitScyllaEasy_P2 =
	{
		InheritFrom = { "CharybdisSpit1" },

		Requirements =
		{
			MaxPlayerDistance = 3900,
			MaxPlayerDistanceScaleY = 0.65,
			GroupHealthPercentMax = 0.50,
			GroupHealthPercentMin = 0.25,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "CharybdisBoost" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "CharybdisRangedTransportSmallScylla",

			FireTicksMin = 1,
			FireTicksMax = 1,
			FireInterval = 0.5,

			FireDuration = 0.65,
			PostAttackDurationMin = 11.0,
			PostAttackDurationMax = 13.0,
		},
	},
	CharybdisSpitScyllaHard_P2 =
	{
		InheritFrom = { "CharybdisSpit1" },

		Requirements =
		{
			MaxPlayerDistance = 3900,
			MaxPlayerDistanceScaleY = 0.65,
			GroupHealthPercentMax = 0.25,
			GroupHealthPercentMin = 0.0,
		},

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "CharybdisBoost" },
				UseLength = true,
				Comparison = "<",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "CharybdisRangedTransportSmallScylla",

			FireTicksMin = 2,
			FireTicksMax = 2,
			FireInterval = 0.5,

			FireDuration = 0.65,
			PostAttackDurationMin = 7.0,
			PostAttackDurationMax = 9.0,
			PostAttackMinWaitTime = 6.5,
		},
	},

	CharybdisSpitScyllaBoosted =
	{
		InheritFrom = { "CharybdisSpit1" },

		GameStateRequirements =
		{
			{
				Path = { "MapState", "Flags", "CharybdisBoost" },
				UseLength = true,
				Comparison = ">=",
				Value = 1,
			},
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "CharybdisRangedTransportScylla",

			FireTicksMin = 4,
			FireTicksMax = 4,
			FireInterval = 3,

			PreAttackDuration = 1.25,
			FireDuration = 0.65,
			PostAttackDuration = 8.0,
			PostAttackMinWaitTime = 7.5,


			PreAttackAnimation = "Enemy_Charybdis_SpitPreFire_Fast",
		},
	},

	CharybdisWait =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			SkipFireWeapon = true,

			PreAttackDuration = 0.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,
			PostAttackCooldown = 1.0,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil