WeaponSetData =
{
	-- MELEES
	PrometheusSlam_Base =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PrometheusGroundPound",
			BarrelLength = 50,
			FireProjectileNoDestination = true,
			FireProjectileStartDelay = 0.075,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			--TrackTargetDuringFire = true,
			--PostAttackStop = true,

			PreAttackDuration = 0.465,
			FireDuration = 0.275,
			PostAttackDuration = 0.12,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 350,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedShadeLarge/Charge",
			PreAttackAnimation = "Enemy_Prometheus_GroundPoundPreFire",
			FireAnimation = "Enemy_Prometheus_GroundPoundFire",
			PostAttackAnimation = "Enemy_Prometheus_GroundPoundPostFire_Fast",

			AttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusAttackLines" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGroundSlam" },
			},
		},
	},

	PrometheusKick_Base =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PrometheusKick",

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.15,
			StopBeforeFire = true,
			--TrackTargetDuringFire = true,
			--PostAttackStop = true,

			PreAttackDuration = 0.5 * 1.1,
			PreAttackAnimationSpeed = 0.9,
			FireDuration = 0.39,
			PostAttackDuration = 0.05,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 280,

			--PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKickCharge",

			PreAttackAnimation = "Enemy_Prometheus_KickPreFire",
			FireAnimation = "Enemy_Prometheus_KickFire",
			PostAttackAnimation = "Enemy_Prometheus_KickPostFire_Fast",

			AttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusAttackLines" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKick" },
			},
		},
	},

	PrometheusFlurry_Base =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PrometheusPunch",
			BarrelLength = 0,

			Spread = 5,

			PreAttackStop = true,
			PreAttackRotationDampening = 0.35,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			--TrackTargetDuringFire = true,
			--PostAttackStop = true,

			PreAttackDuration = 0.46 * 1.25,
			PreAttackAnimationSpeed = 0.75,
			FireTicks = 5,
			FireInterval = 0.05,
			FireDuration = 0.0,
			PostAttackDuration = 0.15,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 200,

			--PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKickCharge",

			PreAttackAnimation = "Enemy_Prometheus_FlurryPreFire",
			FireAnimation = "Enemy_Prometheus_FlurryFire",
			PostAttackAnimation = "Enemy_Prometheus_FlurryPostFire_Fast",
			AttackSound = "/SFX/Player Sounds/MelTorchFireBasic",

			AttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusAttackLines" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				--{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKick" },
			},
		},
	},

	PrometheusUppercut_Base =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PrometheusUppercut",

			FireProjectileStartDelay = 0.09,

			PreAttackDuration = 0.465 * 1.3,
			PreAttackAnimationSpeed = 0.7,
			FireDuration = 0.365,
			PostAttackDuration = 0.1,

			PreAttackAnimation = "Enemy_Prometheus_UppercutPreFire",
			FireAnimation = "Enemy_Prometheus_UppercutFire",
			PostAttackAnimation = "Enemy_Prometheus_UppercutPostFire_Fast",

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 300,

			--PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKickCharge",

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,
			--TrackTargetDuringFire = true,
			--PostAttackStop = true,

			PreAttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusPreAttackLines" },
			},

			AttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusAttackLines" },
			},
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Player Sounds/ZagreusFistBigWhoosh" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKick" },
			},
		},
	},

	-- PHASE 1
	PrometheusSlam_P1 =
	{
		InheritFrom = { "PrometheusSlam_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			AttackSlots =
			{
				{ ProjectileName = "PrometheusGroundPound", PauseDuration = 0.45 },
				{ ProjectileName = "PrometheusGroundPoundNova", },
			},

			PreAttackFx = "PrometheusChargingFx",
			EndPreAttackFx = true,

			PreAttackDuration = 0.86,
			FireDuration = 0.275,
			PostAttackDuration = 2.6,

			PreAttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusPreAttackLines" },
			},

			PreAttackAnimation = "Enemy_Prometheus_GroundPoundPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_GroundPoundPostFire",
		},
	},

	PrometheusKick_P1 =
	{
		InheritFrom = { "PrometheusKick_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			AttackSlots =
			{
				{ ProjectileName = "PrometheusKick", PauseDuration = 0.25 },
				{ ProjectileName = "PrometheusKickFireWave", },
			},

			--PreAttackFx = "PrometheusChargingFx_Foot",
			--EndPreAttackFx = true,

			PreAttackRotationDampening = 0.15,
			PreAttackDuration = 1.0,
			FireDuration = 0.39,
			PostAttackDuration = 2.4,

			PreAttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusPreAttackLines" },
			},

			PreAttackAnimation = "Enemy_Prometheus_KickPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_KickPostFire",
		},
	},

	PrometheusFlurry_P1 =
	{
		InheritFrom = { "PrometheusFlurry_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			AttackSlots =
			{
				{ ProjectileName = "PrometheusPunch", PauseDuration = 0.08 },
				{ ProjectileName = "PrometheusFlurry", AIDataOverrides = { Spread = 60 }, },
			},

			--PreAttackFx = "PrometheusChargingFx",
			--EndPreAttackFx = true,

			PreAttackDuration = 1.0,
			FireDuration = 0.0,
			PostAttackDuration = 2.6,

			PreAttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusPreAttackLines" },
			},

			PreAttackAnimation = "Enemy_Prometheus_FlurryPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_FlurryPostFire",
		},
	},

	PrometheusUppercut_P1 =
	{
		InheritFrom = { "PrometheusUppercut_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			AttackSlots =
			{
				{ ProjectileName = "PrometheusUppercut", PauseDuration = 0.1 },
				{ ProjectileName = "PrometheusUppercutWhirlwind", AIDataOverrides = { BarrelLength = 500, }, },
				{ ProjectileName = "PrometheusUppercutWhirlwindVacuum", OffsetDistance = 500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
			},

			--PreAttackFx = "PrometheusChargingFx",
			--EndPreAttackFx = true,

			PreAttackDuration = 0.93,
			FireDuration = 0.365,
			PostAttackDuration = 2.5,

			PreAttackAnimation = "Enemy_Prometheus_UppercutPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_UppercutPostFire",
		},
	},

	-- PHASE 2
	-- Starters
	PrometheusSlam_P2_Starter =
	{
		InheritFrom = { "PrometheusSlam_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",
			ChainedWeaponOptions =
			{
				"PrometheusKick_P2_Filler", "PrometheusFlurry_P2_Filler", "PrometheusUppercut_P2_Filler",
			},
		},
	},

	PrometheusKick_P2_Starter =
	{
		InheritFrom = { "PrometheusKick_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Filler", "PrometheusFlurry_P2_Filler", "PrometheusUppercut_P2_Filler",
			},
		},
	},

	PrometheusFlurry_P2_Starter =
	{
		InheritFrom = { "PrometheusFlurry_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Filler", "PrometheusKick_P2_Filler", "PrometheusUppercut_P2_Filler",
			},
		},
	},

	PrometheusUppercut_P2_Starter =
	{
		InheritFrom = { "PrometheusUppercut_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Filler", "PrometheusKick_P2_Filler", "PrometheusFlurry_P2_Filler",
			},
		},
	},

	-- Fillers
	PrometheusSlam_P2_Filler =
	{
		InheritFrom = { "PrometheusSlam_Base", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			--PreAttackDuration = 0.232,
			--PreAttackAnimation = "Enemy_Prometheus_GroundPoundPreFire_Fast",

			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusKick_P2_Ender", "PrometheusFlurry_P2_Ender", "PrometheusUppercut_P2_Ender",
			},
		},
	},

	PrometheusKick_P2_Filler =
	{
		InheritFrom = { "PrometheusKick_Base", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			--PreAttackDuration = 0.25,
			--PreAttackAnimation = "Enemy_Prometheus_KickPreFire_Fast",

			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Ender", "PrometheusFlurry_P2_Ender", "PrometheusUppercut_P2_Ender",
			},
		},
	},

	PrometheusFlurry_P2_Filler =
	{
		InheritFrom = { "PrometheusFlurry_Base", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			--PreAttackDuration = 0.23,
			--PreAttackAnimation = "Enemy_Prometheus_FlurryPreFire_Fast",

			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Ender", "PrometheusKick_P2_Ender", "PrometheusUppercut_P2_Ender",
			},
		},
	},

	PrometheusUppercut_P2_Filler =
	{
		InheritFrom = { "PrometheusUppercut_Base", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			--PreAttackDuration = 0.2325,
			--PreAttackAnimation = "Enemy_Prometheus_UppercutPreFire_Fast",

			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Ender", "PrometheusKick_P2_Ender", "PrometheusFlurry_P2_Ender",
			},
		},
	},

	-- Enders
	PrometheusSlam_P2_Ender =
	{
		InheritFrom = { "PrometheusSlam_P1", },

		AIData =
		{
			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			PostAttackDuration = 1.6,
		},
	},

	PrometheusKick_P2_Ender =
	{
		InheritFrom = { "PrometheusKick_P1", },

		AIData =
		{
			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			PostAttackDuration = 1.4,

			PreAttackAnimation = "Enemy_Prometheus_KickPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_KickPostFire",
		},
	},

	PrometheusFlurry_P2_Ender =
	{
		InheritFrom = { "PrometheusFlurry_P1", },

		AIData =
		{
			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",
		
			PostAttackDuration = 1.6,
		},
	},

	PrometheusUppercut_P2_Ender =
	{
		InheritFrom = { "PrometheusUppercut_P1", },

		AIData =
		{
			--DashIfOverDistance = 600,
			--DashWeapon = "PrometheusDashForward",

			PostAttackDuration = 1.5,
		},
	},

	-- PHASE 3
	-- Starters
	PrometheusSlam_P3_Starter =
	{
		InheritFrom = { "PrometheusSlam_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			AttackSlots =
			{
				{ ProjectileName = "PrometheusGroundPound", PauseDuration = 0.45 },
				{ ProjectileName = "PrometheusGroundPoundNova", },
			},

			PreAttackFx = "PrometheusChargingFx",
			EndPreAttackFx = true,

			PreAttackDuration = 0.86,
			FireDuration = 0.275,
			PostAttackDuration = 0.12,

			PreAttackAnimation = "Enemy_Prometheus_GroundPoundPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_GroundPoundPostFire_Fast",

			ChainedWeaponOptions =
			{
				"PrometheusKick_P3_Filler1", "PrometheusFlurry_P3_Filler1", "PrometheusUppercut_P3_Filler1",
				"PrometheusDashBackward",
			},
		},
	},

	PrometheusKick_P3_Starter =
	{
		InheritFrom = { "PrometheusKick_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			AttackSlots =
			{
				{ ProjectileName = "PrometheusKick", PauseDuration = 0.25 },
				{ ProjectileName = "PrometheusKickFireWave", },
			},

			--PreAttackFx = "PrometheusChargingFx",
			--EndPreAttackFx = true,

			PreAttackDuration = 1.0,
			FireDuration = 0.39,
			PostAttackDuration = 0.05,

			PreAttackAnimation = "Enemy_Prometheus_KickPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_KickPostFire_Fast",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler1", "PrometheusFlurry_P3_Filler1", "PrometheusUppercut_P3_Filler1",
				"PrometheusDashBackward",
			},
		},
	},

	PrometheusFlurry_P3_Starter =
	{
		InheritFrom = { "PrometheusFlurry_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			AttackSlots =
			{
				{ ProjectileName = "PrometheusPunch", PauseDuration = 0.08, },
				{ ProjectileName = "PrometheusFlurry", AIDataOverrides = { Spread = 60 }, },
			},

			--PreAttackFx = "PrometheusChargingFx",
			--EndPreAttackFx = true,

			PreAttackDuration = 1.0,
			FireDuration = 0.0,
			PostAttackDuration = 0.15,

			PreAttackAnimation = "Enemy_Prometheus_FlurryPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_FlurryPostFire_Fast",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler1", "PrometheusKick_P3_Filler1", "PrometheusUppercut_P3_Filler1",
				"PrometheusDashBackward",
			},
		},
	},

	PrometheusUppercut_P3_Starter =
	{
		InheritFrom = { "PrometheusUppercut_Base", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			AttackSlots =
			{
				{ ProjectileName = "PrometheusUppercut", PauseDuration = 0.1 },
				{ ProjectileName = "PrometheusUppercutWhirlwind", AIDataOverrides = { BarrelLength = 500, }, },
				{ ProjectileName = "PrometheusUppercutWhirlwindVacuum", OffsetDistance = 500, OffsetScaleY = 0.5, UseAttackerAngle = true, OffsetFromAttacker = true, },
			},

			--PreAttackFx = "PrometheusChargingFx",
			--EndPreAttackFx = true,

			PreAttackDuration = 0.93,
			FireDuration = 0.365,
			PostAttackDuration = 0.1,

			PreAttackAnimation = "Enemy_Prometheus_UppercutPreFire_Charged",
			PostAttackAnimation = "Enemy_Prometheus_UppercutPostFire_Fast",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler1", "PrometheusKick_P3_Filler1", "PrometheusFlurry_P3_Filler1",
				"PrometheusDashBackward", 
			},
		},
	},

	-- Fillers
	PrometheusSlam_P3_Filler1 =
	{
		GenusName = "PrometheusSlam_P3_Filler",
		InheritFrom = { "PrometheusSlam_Base", },
		AIData =
		{
			--PreAttackDuration = 0.232,
			--PreAttackAnimation = "Enemy_Prometheus_GroundPoundPreFire_Fast",

			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusKick_P3_Filler2", "PrometheusFlurry_P3_Filler2", "PrometheusUppercut_P3_Filler2",
			},
		},
	},

	PrometheusKick_P3_Filler1 =
	{
		GenusName = "PrometheusKick_P3_Filler",
		InheritFrom = { "PrometheusKick_Base", },
		AIData =
		{
			--PreAttackDuration = 0.25,
			--PreAttackAnimation = "Enemy_Prometheus_KickPreFire_Fast",

			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler2", "PrometheusFlurry_P3_Filler2", "PrometheusUppercut_P3_Filler2",
			},
		},
	},

	PrometheusFlurry_P3_Filler1 =
	{
		GenusName = "PrometheusFlurry_P3_Filler",
		InheritFrom = { "PrometheusFlurry_Base", },
		AIData =
		{
			--PreAttackDuration = 0.23,
			--PreAttackAnimation = "Enemy_Prometheus_FlurryPreFire_Fast",

			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler2", "PrometheusKick_P3_Filler2", "PrometheusUppercut_P3_Filler2",
			},
		},
	},

	PrometheusUppercut_P3_Filler1 =
	{
		GenusName = "PrometheusUppercut_P3_Filler",
		InheritFrom = { "PrometheusUppercut_Base", },
		AIData =
		{
			--PreAttackDuration = 0.2325,
			--PreAttackAnimation = "Enemy_Prometheus_UppercutPreFire_Fast",

			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler2", "PrometheusKick_P3_Filler2", "PrometheusFlurry_P3_Filler2",
			},
		},
	},

	PrometheusSlam_P3_Filler2 =
	{
		GenusName = "PrometheusSlam_P3_Filler",
		InheritFrom = { "PrometheusSlam_Base", },
		AIData =
		{
			--PreAttackDuration = 0.232,
			--PreAttackAnimation = "Enemy_Prometheus_GroundPoundPreFire_Fast",

			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusKick_P3_Ender", "PrometheusFlurry_P3_Ender", "PrometheusUppercut_P3_Ender",
			},
		},
	},

	PrometheusKick_P3_Filler2 =
	{
		GenusName = "PrometheusKick_P3_Filler",
		InheritFrom = { "PrometheusKick_Base", },
		AIData =
		{
			--PreAttackDuration = 0.25,
			--PreAttackAnimation = "Enemy_Prometheus_KickPreFire_Fast",

			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Ender", "PrometheusFlurry_P3_Ender", "PrometheusUppercut_P3_Ender",
			},
		},
	},

	PrometheusFlurry_P3_Filler2 =
	{
		GenusName = "PrometheusFlurry_P3_Filler",
		InheritFrom = { "PrometheusFlurry_Base", },
		AIData =
		{
			--PreAttackDuration = 0.23,
			--PreAttackAnimation = "Enemy_Prometheus_FlurryPreFire_Fast",

			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Ender", "PrometheusKick_P3_Ender", "PrometheusUppercut_P3_Ender",
			},
		},
	},

	PrometheusUppercut_P3_Filler2 =
	{
		GenusName = "PrometheusUppercut_P3_Filler",
		InheritFrom = { "PrometheusUppercut_Base", },
		AIData =
		{
			--PreAttackDuration = 0.2325,
			--PreAttackAnimation = "Enemy_Prometheus_UppercutPreFire_Fast",

			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Ender", "PrometheusKick_P3_Ender", "PrometheusFlurry_P3_Ender",
			},
		},
	},

	-- Enders
	PrometheusSlam_P3_Ender =
	{
		InheritFrom = { "PrometheusSlam_P1", },
		AIData =
		{
			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			PostAttackDuration = 1.6,
		},
	},

	PrometheusKick_P3_Ender =
	{
		InheritFrom = { "PrometheusKick_P1", },
		AIData =
		{
			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			PostAttackDuration = 1.4,
		},
	},

	PrometheusFlurry_P3_Ender =
	{
		InheritFrom = { "PrometheusFlurry_P1", },
		AIData =
		{
			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			PostAttackDuration = 1.6,
		},
	},

	PrometheusUppercut_P3_Ender =
	{
		InheritFrom = { "PrometheusUppercut_P1", },
		AIData =
		{
			DashIfOverDistance = 600,
			DashWeapon = "PrometheusDashForward",

			PostAttackDuration = 1.5,
		},
	},

	-- Movement
	PrometheusDashForward =
	{
		AIData =
		{
			DeepInheritance = true,

			FireSelfVelocity = 7000,
			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "LeapGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.1,
						Modifier = 0.0000001,
						HaltOnEnd = true,
					}
				},
			},

			NoProjectile = true,

			AttackDistance = 9999,

			PreAttackSound = "/SFX/Enemy Sounds/Prometheus/EmoteChuckle",
			PreAttackAnimation = "Enemy_Prometheus_DashForward_Start",
			FireAnimation = "Enemy_Prometheus_DashForward_Fire",
			PostAttackAnimation = "Enemy_Prometheus_DashForward_End",

			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			--PreAttackAlpha = 0,
			--PreAttackAlphaDuration = 0.2,
			--PostAttackAlpha = 1,
			--PostAttackAlphaDuration = 0.1,
			PreAttackDuration = 0.2,
			FireDuration = 0.1,
			PostAttackDuration = 0.285,
		},
	},

	PrometheusDashBackward =
	{
		InheritFrom = { "PrometheusDashForward", },
		Requirements =
		{
			MaxConsecutiveUses = 1,
		},
		AIData =
		{
			FireSelfVelocity = 2500,

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "LeapGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.15,
						Modifier = 0.0000001,
						HaltOnEnd = true,
					}
				},
			},

			PreAttackSelfVelocityAngleOffset = 180,
			FireSelfVelocityAngleOffset = 180,

			PreAttackDuration = 0.2,
			FireDuration = 0.15,
			PostAttackDuration = 0.9,

			PreAttackAnimation = "Enemy_Prometheus_DashBack_Start",
			FireAnimation = "Enemy_Prometheus_DashBack_Fire",
			PostAttackAnimation = "Enemy_Prometheus_DashBack_End",
		},
	},

	-- Fire Casts
	PrometheusCastSelector_P1 =
	{
		GenusName = "PrometheusCast_P1",
		Requirements =
		{
			RequireTotalAttacks = 3,
			MinAttacksBetweenUse = 5,
		},
		WeaponSelectorOnly = true,
		AIData =
		{
			ForceUseIfReady = true,
		},
		SelectorOptions =
		{
			"PrometheusCastCircle_P1",
			"PrometheusCastLine_P1",
		},
	},

	PrometheusCastCircle_P1 =
	{
		GenusName = "PrometheusCast_P1",
		AIData =
		{
			DeepInheritance = true,

			--PartnerForceWeaponInterrupt = "EagleDive_P1",

			ProjectileName = "PrometheusSkyCast",
			BarrelLength = 0,
			FireFromTarget = true,

			TrackTargetDuringFire = true,
			TrackTargetDuringCharge = true,
			PostAttackStop = true,

			PreAttackDuration = 0.95,
			FireDuration = 1.6,
			PostAttackDuration = 1.0,

			AttackDistance = 1100,

			PreAttackSelfVelocity = 400,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKickCharge",

			PreAttackAnimation = "Enemy_Prometheus_Point_Fast",
			FireAnimation = "Enemy_Prometheus_Cast_Start",
			PostAttackAnimation = "Enemy_Prometheus_Cast_Fire",
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			WeaponFireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Prometheus/EmoteFirePlume" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKick" },
			},
		},
	},

	PrometheusCastLine_P1 =
	{
		GenusName = "PrometheusCast_P1",
		AIData =
		{
			DeepInheritance = true,

			--PartnerForceWeaponInterrupt = "EagleDive_P1",

			ProjectileName = "PrometheusFirePillarForward",
			FireProjectileStartDelay = 1.6,

			BarrelLength = 0,

			TrackTargetDuringFire = true,
			TrackTargetDuringCharge = true,
			PostAttackStop = true,

			PreAttackDuration = 0.95,
			FireFx = "PrometheusCastLineAimLine",
			StopAnimationsOnHitStun = { "PrometheusCastLineAimLine", },
			FireDuration = 1.6,
			PostAttackDuration = 1.0,

			AttackDistance = 1100,

			PreAttackSelfVelocity = 400,

			PreAttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKickCharge",

			PreAttackAnimation = "Enemy_Prometheus_Point_Fast",
			FireAnimation = "Enemy_Prometheus_Cast_Start",
			PostAttackAnimation = "Enemy_Prometheus_Cast_Fire",
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Prometheus/EmotePowerAttacking" },
				{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusKick" },
			},
		},
	},

	PrometheusCastSelector_P2 =
	{
		GenusName = "PrometheusCast_P2",
		Requirements =
		{
			MinAttacksBetweenUse = 12,
		},
		WeaponSelectorOnly = true,
		AIData =
		{
			ForceUseIfReady = true,
			AttackSound = "/SFX/Enemy Sounds/Polyphemus/PolyphemusFistWindmillWhoosh",
		},
		SelectorOptions =
		{
			"PrometheusCastCircle_P2",
			"PrometheusCastLine_P2",
			"PrometheusCastCircle_wEagle_P2",
			"PrometheusCastLine_wEagle_P2",
		},
	},

	PrometheusCastCircle_P2 =
	{
		InheritFrom = { "PrometheusCastCircle_P1", },
		GenusName = "PrometheusCast_P2",
	},
	PrometheusCastCircle_wEagle_P2 =
	{
		InheritFrom = { "PrometheusCastCircle_P1", },
		GenusName = "PrometheusCast_P2",
		AIData =
		{
			PartnerForceWeaponInterrupt = "EagleDive_P2",
		},
	},
	PrometheusCastLine_P2 =
	{
		InheritFrom = { "PrometheusCastLine_P1", },
		GenusName = "PrometheusCast_P2",
	},
	PrometheusCastLine_wEagle_P2 =
	{
		InheritFrom = { "PrometheusCastLine_P1", },
		GenusName = "PrometheusCast_P2",
		AIData =
		{
			PartnerForceWeaponInterrupt = "EagleDive_P2",
		},
	},

	PrometheusCastSelector_P3 =
	{
		GenusName = "PrometheusCast_P3",
		Requirements =
		{
			MinAttacksBetweenUse = 10,
		},
		WeaponSelectorOnly = true,
		AIData =
		{
			ForceUseIfReady = true,
		},
		SelectorOptions =
		{
			"PrometheusCastCircle_P3",
			"PrometheusCastLine_P3",
			"PrometheusCastCircle_wEagle_P3",
			"PrometheusCastLine_wEagle_P3",
		},
	},

	PrometheusCastCircle_P3 =
	{
		InheritFrom = { "PrometheusCastCircle_P1", },
		GenusName = "PrometheusCast_P3",
	},
	PrometheusCastCircle_wEagle_P3 =
	{
		InheritFrom = { "PrometheusCastCircle_P1", },
		GenusName = "PrometheusCast_P3",
		AIData =
		{
			PartnerForceWeaponInterrupt = "EagleDive_P3",
		},
	},
	PrometheusCastLine_P3 =
	{
		InheritFrom = { "PrometheusCastLine_P1", },
		GenusName = "PrometheusCast_P3",
	},
	PrometheusCastLine_wEagle_P3 =
	{
		InheritFrom = { "PrometheusCastLine_P1", },
		GenusName = "PrometheusCast_P3",
		AIData =
		{
			PartnerForceWeaponInterrupt = "EagleDive_P3",
		},
	},

	-- Memory Game

	PrometheusMemory_P2_Intro =
	{
		GenusName = "PrometheusMemory",
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			ExpireProjectilesOnPreAttackStart = { "PrometheusFireCircle", "PrometheusFireCircleSmall", "PrometheusFireCircleLarge" },

			PartnerForceWeaponInterrupt = "EagleFlyUp",

			PreAttackDuration = 0.0,
			FireDuration = 0.5,
			PostAttackDuration = 0,

			FireAnimation = "Enemy_Prometheus_Memory_Start",
			--FireAnimation = "Enemy_Prometheus_StreakPreFire",

			PreAttackFunctionName = "PrometheusMemoryIntroPresentation",
			PreAttackFunctionArgs =
			{
				LandingId = 751907,
				CameraTargetId = 751910,
			},

			AttackDistance = 9999,

			PreAttackStop = true,
			StopMoveWithinRange = true,

			-- PreAttackSound = "/SFX/Enemy Sounds/Carrion/EmoteCharging",

			ChainedWeaponOptions = { "PrometheusMemory_P2_Single_C", "PrometheusMemory_P2_Single_L", "PrometheusMemory_P2_Single_R", },
		},
	},

	PrometheusMemory_P2_Single_C =
	{
		GenusName = "PrometheusMemory",
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "PrometheusMemory_P2",

			TargetId = 751892,
			FireFromTarget = true,
			FireProjectileAngle = 210,

			PreAttackAngleTowardTarget = false,

			PreAttackDuration = 0,
			FireDuration = 1.4,
			PostAttackDuration = 0,
			AttackDistance = 9999,
			ChainedWeaponOptions = { "PrometheusMemory_P2_Double1_LC", "PrometheusMemory_P2_Double1_CR", "PrometheusMemory_P2_Double1_LR", },
		},
	},
	PrometheusMemory_P2_Single_L =
	{
		InheritFrom = { "PrometheusMemory_P2_Single_C", },
		AIData =
		{
			TargetId = 751893,
			ChainedWeaponOptions = { "PrometheusMemory_P2_Double1_LC", "PrometheusMemory_P2_Double1_CR", "PrometheusMemory_P2_Double1_LR", },
		},
	},
	PrometheusMemory_P2_Single_R =
	{
		InheritFrom = { "PrometheusMemory_P2_Single_C", },
		AIData =
		{
			TargetId = 751894,
			ChainedWeaponOptions = { "PrometheusMemory_P2_Double1_LC", "PrometheusMemory_P2_Double1_CR", "PrometheusMemory_P2_Double1_LR", },
		},
	},
	PrometheusMemory_P2_Double1_LC =
	{
		GenusName = "PrometheusMemory",
		AIData =
		{
			DeepInheritance = true,
			ProjectileName = "PrometheusMemory_P2",

			AttackSlots =
			{
				{ AIDataOverrides = { TargetId = 751893, }, },
				{ AIDataOverrides = { TargetId = 751892, }, },
			},

			FireFromTarget = true,
			FireProjectileAngle = 210,
			PreAttackAngleTowardTarget = false,

			PreAttackDuration = 0,
			FireDuration = 1.4,
			PostAttackDuration = 0,
			AttackDistance = 9999,
			ChainedWeaponOptions = { "PrometheusMemory_P2_Double2_CR", "PrometheusMemory_P2_Double2_LR" },
		},
	},
	PrometheusMemory_P2_Double1_CR =
	{
		InheritFrom = { "PrometheusMemory_P2_Double1_LC", },
		AIData =
		{
			AttackSlots =
			{
				--{ AIDataOverrides = { TargetId = 751893, }, },
				{ AIDataOverrides = { TargetId = 751892, }, },
				{ AIDataOverrides = { TargetId = 751894, }, },
			},
			ChainedWeaponOptions = { "PrometheusMemory_P2_Double2_LC", "PrometheusMemory_P2_Double2_LR" },
		},
	},
	PrometheusMemory_P2_Double1_LR =
	{
		InheritFrom = { "PrometheusMemory_P2_Double1_LC", },
		AIData =
		{
			AttackSlots =
			{
				{ AIDataOverrides = { TargetId = 751893, }, },
				--{ AIDataOverrides = { TargetId = 751892, }, },
				{ AIDataOverrides = { TargetId = 751894, }, },
			},
			ChainedWeaponOptions = { "PrometheusMemory_P2_Double2_LC", "PrometheusMemory_P2_Double2_CR" },
		},
	},
	PrometheusMemory_P2_Double2_LC =
	{
		InheritFrom = { "PrometheusMemory_P2_Double1_LC", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P2_Outro", },
		},
	},
	PrometheusMemory_P2_Double2_CR =
	{
		InheritFrom = { "PrometheusMemory_P2_Double1_CR", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P2_Outro", },
		},
	},
	PrometheusMemory_P2_Double2_LR =
	{
		InheritFrom = { "PrometheusMemory_P2_Double1_LR", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P2_Outro", },
		},
	},

	-- Phase 3
	PrometheusMemory_P3_Intro =
	{
		InheritFrom = { "PrometheusMemory_P2_Intro", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Double1_LC", "PrometheusMemory_P3_Double1_CR", "PrometheusMemory_P3_Double1_LR", },
		},
	},
	PrometheusMemory_P3_Double1_LC =
	{
		InheritFrom = { "PrometheusMemory_P2_Double1_LC", },
		AIData =
		{
			ProjectileName = "PrometheusMemory_P3",
			ChainedWeaponOptions = { "PrometheusMemory_P3_Single1_R", },
		},
	},
	PrometheusMemory_P3_Double1_CR =
	{
		InheritFrom = { "PrometheusMemory_P2_Double1_CR", },
		AIData =
		{
			ProjectileName = "PrometheusMemory_P3",
			ChainedWeaponOptions = { "PrometheusMemory_P3_Single1_L", },
		},
	},
	PrometheusMemory_P3_Double1_LR =
	{
		InheritFrom = { "PrometheusMemory_P2_Double1_LR", },
		AIData =
		{
			ProjectileName = "PrometheusMemory_P3",
			ChainedWeaponOptions = { "PrometheusMemory_P3_Single1_C" },
		},
	},

	PrometheusMemory_P3_Single1_C =
	{
		InheritFrom = { "PrometheusMemory_P2_Single_C", },
		AIData =
		{
			ProjectileName = "PrometheusMemory_P3",
			ChainedWeaponOptions = { "PrometheusMemory_P3_Double2_LC", "PrometheusMemory_P3_Double2_CR", "PrometheusMemory_P3_Double2_LR" },
		},
	},
	PrometheusMemory_P3_Single1_L =
	{
		InheritFrom = { "PrometheusMemory_P2_Single_L", },
		AIData =
		{
			ProjectileName = "PrometheusMemory_P3",
			ChainedWeaponOptions = { "PrometheusMemory_P3_Double2_LC", "PrometheusMemory_P3_Double2_CR", "PrometheusMemory_P3_Double2_LR" },
		},
	},
	PrometheusMemory_P3_Single1_R =
	{
		InheritFrom = { "PrometheusMemory_P2_Single_R", },
		AIData =
		{
			ProjectileName = "PrometheusMemory_P3",
			ChainedWeaponOptions = { "PrometheusMemory_P3_Double2_LC", "PrometheusMemory_P3_Double2_CR", "PrometheusMemory_P3_Double2_LR" },
		},
	},

	PrometheusMemory_P3_Double2_LC =
	{
		InheritFrom = { "PrometheusMemory_P3_Double1_LC", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Double3_CR", "PrometheusMemory_P3_Double3_LR" },
		},
	},
	PrometheusMemory_P3_Double2_CR =
	{
		InheritFrom = { "PrometheusMemory_P3_Double1_CR", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Double3_LC", "PrometheusMemory_P3_Double3_LR" },
		},
	},
	PrometheusMemory_P3_Double2_LR =
	{
		InheritFrom = { "PrometheusMemory_P3_Double1_LR", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Double3_LC", "PrometheusMemory_P3_Double3_CR", },
		},
	},

	PrometheusMemory_P3_Double3_LC =
	{
		InheritFrom = { "PrometheusMemory_P3_Double1_LC", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Single2_R" },
		},
	},
	PrometheusMemory_P3_Double3_CR =
	{
		InheritFrom = { "PrometheusMemory_P3_Double1_CR", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Single2_L" },
		},
	},
	PrometheusMemory_P3_Double3_LR =
	{
		InheritFrom = { "PrometheusMemory_P3_Double1_LR", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Single2_C" },
		},
	},

	PrometheusMemory_P3_Single2_C =
	{
		InheritFrom = { "PrometheusMemory_P3_Single1_C", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Outro" },
		},
	},
	PrometheusMemory_P3_Single2_L =
	{
		InheritFrom = { "PrometheusMemory_P3_Single1_L", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Outro" },
		},
	},
	PrometheusMemory_P3_Single2_R =
	{
		InheritFrom = { "PrometheusMemory_P3_Single1_R", },
		AIData =
		{
			ChainedWeaponOptions = { "PrometheusMemory_P3_Outro" },
		},
	},

	PrometheusMemory_P2_Outro =
	{
		GenusName = "PrometheusMemory",
		AIData =
		{
			DeepInheritance = true,

			NoProjectile = true,

			PreAttackDuration = 3.0,
			FireDuration = 0,
			PostAttackDuration = 1.0,

			PreAttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusBurnLines" },
			},

			PreAttackAngleTowardTarget = false,

			FireFunctionName = "PrometheusMemoryOutroPresentation",
			FireFunctionArgs =
			{
				LandingId = 751891,
			},

			AttackDistance = 9999,

			PreAttackStop = true,
			StopMoveWithinRange = true,

			-- PreAttackSound = "/SFX/Enemy Sounds/Carrion/EmoteCharging",
		},
	},

	PrometheusMemory_P3_Outro =
	{
		InheritFrom = { "PrometheusMemory_P2_Outro", },
		AIData =
		{
			PreAttackDuration = 6.5,
		},
	},

	-- Summons
	PrometheusSummonSelector_P2 =
	{
		Requirements =
		{
			MaxUses = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = "<=",
				Value = 2,
			},
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,
			PreAttackAngleTowardTarget = false,

			ChainedWeaponOptions =
			{
				"PrometheusSummon_Sapper",
				"PrometheusSummon_Harpy",
			},
		},
	},

	PrometheusSummonSelector_P3 =
	{
		Requirements =
		{
			MaxUses = 1,
		},

		GameStateRequirements =
		{
			{
				Path = { "RequiredKillEnemies" },
				UseLength = true,
				Comparison = "<=",
				Value = 2,
			},
		},

		AIData =
		{
			SkipFireWeapon = true,
			AttackDistance = 99999,
			PreAttackAngleTowardTarget = false,

			ChainedWeaponOptions =
			{
				"PrometheusSummon_Dragon",
				"PrometheusSummon_Lancer",
			},
		},
	},

	PrometheusSummonBase =
	{
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			DashIfOverDistance = 99999,
			NoProjectile = true,

			PreAttackAnimation = "Enemy_Prometheus_Point_Fast",
			--FireAnimation = "Enemy_Prometheus_PointPostFire_Fast",

			--[[
			PreAttackFunctionName = "PrometheusSummonPresentation",
			PreAttackFunctionArgs =
			{
				ZHeight = 200,
				Scale = 4,
				SpawnName = "HarpyDropper",
				HarpyStartId = 751908,
				HarpyEndId = 751909,
				Speed = 7500,
			},
			]]

			PreAttackDuration = 0.5,
			FireDuration = 0.45,
			PostAttackDuration = 0.0,
			PreAttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusSpawnWaveLines" },
			},

			SpawnBurstOnFire = true,
			SpawnRate = 0.125,
			SpawnOnSpawnPoints = true,
			SpawnRadius = 99999,
			SpawnBurstDelay = 1.45,
			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 5,
			MaxActiveSpawns = 6,
			SpawnerOptions = { "SatyrSapper", "SatyrLancer2", "Dragon", "HarpyDropper" },
			SpawnOverrides =
			{
				AIAggroRange = 320,
				AIWanderDistance = 0.0,
				TrackPlayerBeforeAggro = true,
			},
			SkipLocationBlockedCheck = true,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/TimerFlareSFX" },
			},
		},

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	PrometheusSummon_Sapper =
	{
		InheritFrom = { "PrometheusSummonBase" },

		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 4,
			SpawnsPerBurstMax = 4,
			MaxActiveSpawns = 6,
			SpawnOnIds = { 751888, 751887, 745026, 745034, },
			SpawnerOptions = { "SatyrSapper" },
		},
	},

	PrometheusSummon_Lancer =
	{
		InheritFrom = { "PrometheusSummonBase" },
		
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 3,
			MaxActiveSpawns = 6,
			SpawnOnIds = { 751888, 745048, 745034, },
			SpawnerOptions = { "SatyrLancer2" },
		},
	},

	PrometheusSummon_Harpy =
	{
		InheritFrom = { "PrometheusSummonBase" },
		
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 3,
			MaxActiveSpawns = 6,
			SpawnOnIds = { 751888, 745048, 745034, },
			SpawnerOptions = { "HarpyDropper" },
		},
	},

	PrometheusSummon_Dragon =
	{
		InheritFrom = { "PrometheusSummonBase" },
		
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnOnIds = { 751879, 751881, },
			SpawnerOptions = { "Dragon" },
		},
	},

	PrometheusSummon_Crossbow =
	{
		InheritFrom = { "PrometheusSummonBase" },
		
		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 6,
			SpawnOnIds = { 751879, 751881, },
			SpawnerOptions = { "SatyrCrossbow" },
		},
	},

	PrometheusCombo_Spiral =
	{
		GenusName = "PrometheusEagleCombo",

		Requirements =
		{
			RequireComboPartner = true,
			--MaxDistanceFromComboPartner = 325,
			MinAttacksBetweenUse = 8,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady	= true,

			PartnerForceWeaponInterrupt = "EagleCombo_Spiral",

			WaitDurationForComboPartnerMove = 4,
			WaitForComboPartnerMoveAnimation = "Enemy_Prometheus_CallIntro",

			ProjectileName = "EagleSpiral",

			PreAttackDuration = 1.17,
			FireDuration = 0.95,
			PostAttackDuration = 2.1,

			PreAttackAnimation = "Enemy_Prometheus_Catch",
			FireAnimation = "Enemy_Prometheus_LaunchPreFire",
			PostAttackAnimation = "Enemy_Prometheus_LaunchPostFire",
			FireProjectileStartDelay = 0.65,

			AttackDistance = 100,
			MoveToId = 745025,
			MoveSuccessDistance = 40,

			PreAttackStop = true,
			StopMoveWithinRange = false,
			AngleTowardsTargetWhileFiring = false,

			PreAttackSound = "/SFX/Enemy Sounds/EagleAlerted",

			-- VO in WeaponData_Eagle
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0.1 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Prometheus/EmotePhoenixFlame" },
				{ Name = "/SFX/Enemy Sounds/EagleAttackScream" },
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Player Sounds/MelTorchSpecialTail" },
			},
		},
	},

	PrometheusIntro =
	{
		GenusName = "PrometheusEagleCombo",

		Requirements =
		{
			RequireComboPartner = true,
			--MaxDistanceFromComboPartner = 325,
			MinAttacksBetweenUse = 8,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady	= true,

			NoProjectile = true,

			PreAttackDuration = 0,
			FireDuration = 0.95,
			PostAttackDuration = 0.5,

			--PreAttackAnimation = "Enemy_Prometheus_LaunchReadyLoop",
			FireAnimation = "Enemy_Prometheus_LaunchPreFire",
			PostAttackAnimation = "Enemy_Prometheus_LaunchPostFire",

			AttackDistance = 9999,

			PreAttackStop = true,
			MoveWithinRange = false,
			StopMoveWithinRange = false,
			AngleTowardsTargetWhileFiring = false,

			--PreAttackSound = "/SFX/Enemy Sounds/EagleAlerted",
			PreAttackVoiceLines =
			{
				[1] = { GlobalVoiceLines = "PrometheusEagleComboLines" },
			},
		},

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0.1 },
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Prometheus/EmotePhoenixFlame" },
				{ Name = "/SFX/Enemy Sounds/EagleAttackScream" },
				{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
				{ Name = "/SFX/Player Sounds/MelTorchSpecialTail" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil