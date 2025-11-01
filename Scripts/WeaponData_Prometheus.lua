WeaponSetData =
{
	-- MELEES

	-- Slam
	-- Base
	PrometheusSlam_Light =
	{
		Requirements =
		{
			MapAggressor = "Prometheus",
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PrometheusGroundPound",
			BarrelLength = 50,
			FireProjectileNoDestination = true,
			FireProjectileStartDelay = 0.075,

			PreAttackSetUnitProperties =
			{
				Speed = 700,
			},
			PostAttackResetUnitProperties = true,
			PreAttackMoveTowardTarget = true,
			PreAttackMoveTowardTargetLiveOffsetDistance = 200,
			PreAttackMoveTowardTargetLiveOffsetAngle = 10,
			StopBeforeFire = true,
			PreAttackRotationDampening = 0.17,
			TrackTargetDuringCharge = true,
			PostAttackStop = true,

			PreAttackStartMinWaitTime = 0.235,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackDuration = 0.783,
			FireDuration = 0.275,
			PostAttackDuration = 0.6,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 800,
			AttackDistanceScaleY = 0.6,
			MoveSuccessDistance = 10,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedShadeLarge/Charge",

			PreAttackAnimation = "Enemy_Prometheus_GroundPoundPreFire",
			FireAnimation = "Enemy_Prometheus_GroundPoundFire_Fast",
			PostAttackAnimation = "Enemy_Prometheus_GroundPoundPostFire_Fast",

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusAttackLines" },
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
	PrometheusSlam_Heavy =
	{
		Requirements =
		{
			MapAggressor = "Prometheus",
		},

		AIData =
		{			
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "PrometheusGroundPound", PauseDuration = 0.45 },
				{ ProjectileName = "PrometheusGroundPoundNova", },
			},

			BarrelLength = 50,
			FireProjectileNoDestination = true,
			FireProjectileStartDelay = 0.075,

			PreAttackFx = "PrometheusChargingFx",
			EndPreAttackFx = true,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			PreAttackDuration = 1.08,
			FireDuration = 0.1,
			PostAttackDuration = 2.775,
			PostAttackMinWaitTime = 2.5,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 350,

			PreAttackSound = "/SFX/Enemy Sounds/CorruptedShadeLarge/Charge",

			PreAttackAnimation = "Enemy_Prometheus_GroundPoundPreFire_Charged",
			FireAnimation = "Enemy_Prometheus_GroundPoundFire",
			PostAttackAnimation = "Enemy_Prometheus_GroundPoundPostFire",

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusPreAttackLines" },
			},
			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusAttackLines" },
			},
		},

		--Sounds =
		--{
			--FireSounds =
			--{
				--{ Name = "/SFX/Enemy Sounds/Polyphemus/PolyphemusGroundSlam" },
			--},
		--},
	},

	-- Phase
	PrometheusSlam_P1 =
	{
		InheritFrom = { "PrometheusSlam_Heavy", },
		Requirements =
		{
			MapAggressor = "Prometheus",
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},
	PrometheusSlam_P2_Starter =
	{
		InheritFrom = { "PrometheusSlam_Light", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
			MapAggressor = "Prometheus",
		},
		AIData =
		{
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusKick_P2_Filler", "PrometheusFlurry_P2_Filler", "PrometheusUppercut_P2_Filler",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusKick_P2_Filler", "PrometheusUppercut_P2_Filler",
			},
		},
	},
	PrometheusSlam_P2_Filler =
	{
		InheritFrom = { "PrometheusSlam_Light", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.2,
			MoveWithinRangeTimeoutMax = 0.2,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusKick_P2_Ender", "PrometheusFlurry_P2_Ender", "PrometheusUppercut_P2_Ender",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusKick_P2_Ender", "PrometheusUppercut_P2_Ender",
			},
		},
	},
	PrometheusSlam_P2_Ender =
	{
		InheritFrom = { "PrometheusSlam_Heavy", },

		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.25,
			MoveWithinRangeTimeoutMax = 0.25,

			PostAttackDuration = 2.1,
			PostAttackMinWaitTime = 1.89,

			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},
	PrometheusSlam_P3_Starter =
	{
		InheritFrom = { "PrometheusSlam_Light", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
			MapAggressor = "Prometheus",
		},
		AIData =
		{
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusKick_P3_Filler", "PrometheusFlurry_P3_Filler", "PrometheusUppercut_P3_Filler",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusKick_P3_Filler", "PrometheusUppercut_P3_Filler",
			},
		},
	},
	PrometheusSlam_P3_Filler =
	{
		InheritFrom = { "PrometheusSlam_Light", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.2,
			MoveWithinRangeTimeoutMax = 0.2,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusKick_P3_Ender", "PrometheusFlurry_P3_Ender", "PrometheusUppercut_P3_Ender",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusKick_P3_Ender", "PrometheusUppercut_P3_Ender",
			},
		},
	},
	PrometheusSlam_P3_Ender =
	{
		InheritFrom = { "PrometheusSlam_Heavy", },
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.25,
			MoveWithinRangeTimeoutMax = 0.25,

			PostAttackDuration = 1.8,
			PostAttackMinWaitTime = 1.62,

			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},

	-- Kick
	-- Base
	PrometheusKick_Light =
	{
		Requirements =
		{
			MapAggressor = "Prometheus",
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PrometheusKick",
			FireProjectileStartDelay = 0.04,

			PreAttackSetUnitProperties =
			{
				Speed = 700,
			},
			PostAttackResetUnitProperties = true,
			PreAttackMoveTowardTarget = true,
			PreAttackMoveTowardTargetLiveOffsetDistance = 200,
			PreAttackMoveTowardTargetLiveOffsetAngle = 10,
			StopBeforeFire = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.17,
			PostAttackStop = true,

			PreAttackStartMinWaitTime = 0.042,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackDuration = 0.55,
			FireDuration = 0.39,
			PostAttackDuration = 0.6,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 600,
			AttackDistanceScaleY = 0.67,
			MoveSuccessDistance = 10,

			PreAttackAnimation = "Enemy_Prometheus_KickPreFire",
			FireAnimation = "Enemy_Prometheus_KickFire",
			PostAttackAnimation = "Enemy_Prometheus_KickPostFire_Fast",

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusAttackLines" },
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
	PrometheusKick_Heavy =
	{
		Requirements =
		{
			MapAggressor = "Prometheus",
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "PrometheusKick", PauseDuration = 0.25 },
				{ ProjectileName = "PrometheusKickFireWave", AIDataOverrides = { BarrelLength = 300 }, },
			},

			FireProjectileStartDelay = 0.04,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.15,
			StopBeforeFire = true,

			PreAttackDuration = 1.0,
			FireDuration = 0.14,
			PostAttackDuration = 2.4,
			PostAttackMinWaitTime = 2.16,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 280,

			PreAttackAnimation = "Enemy_Prometheus_KickPreFire_Charged",
			FireAnimation = "Enemy_Prometheus_KickFire",
			PostAttackAnimation = "Enemy_Prometheus_KickPostFire",

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusPreAttackLines" },
			},
			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusAttackLines" },
			},
		},
	},
	PrometheusKick_Heavy_Passive =
	{
		InheritFrom = { "PrometheusKick_Heavy" },
		Requirements =
		{
			MapAggressor = "Heracles",
		},
		AIData =
		{
			DeepInheritance = true,

			MoveWithinRange = true,
			AttackDistance = 1000,
			AttackDistanceScaleY = 0.5,
			StopMoveWithinRange = true,
			PreAttackStop = true,
			WaitForAngleTowardTarget = true,

			RetreatBeforeAttack = true,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 500,
			RetreatBufferDistance = 1500,
			RetreatTimeout = 1.75,
		},

	},

	-- Phase
	PrometheusKick_P1 =
	{
		InheritFrom = { "PrometheusKick_Heavy", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
			MapAggressor = "Prometheus",
		},
		AIData =
		{
			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},
	PrometheusKick_P2_Starter =
	{
		InheritFrom = { "PrometheusKick_Light", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
			MapAggressor = "Prometheus",
		},
		AIData =
		{
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusSlam_P2_Filler", "PrometheusFlurry_P2_Filler", "PrometheusUppercut_P2_Filler",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Filler", "PrometheusUppercut_P2_Filler",
			},
		},
	},
	PrometheusKick_P2_Filler =
	{
		InheritFrom = { "PrometheusKick_Light", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.2,
			MoveWithinRangeTimeoutMax = 0.2,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusSlam_P2_Ender", "PrometheusFlurry_P2_Ender", "PrometheusUppercut_P2_Ender",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Ender", "PrometheusUppercut_P2_Ender",
			},
		},
	},
	PrometheusKick_P2_Ender =
	{
		InheritFrom = { "PrometheusKick_Heavy", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			PreAttackRotationDampening = 0.5,

			MoveWithinRangeTimeoutMin = 0.25,
			MoveWithinRangeTimeoutMax = 0.25,

			PostAttackDuration = 2.1,
			PostAttackMinWaitTime = 1.89,

			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},
	PrometheusKick_P3_Starter =
	{
		InheritFrom = { "PrometheusKick_Light", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
			MapAggressor = "Prometheus",
		},
		AIData =
		{
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusSlam_P3_Filler", "PrometheusFlurry_P3_Filler", "PrometheusUppercut_P3_Filler",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler", "PrometheusUppercut_P3_Filler",
			},
		},
	},
	PrometheusKick_P3_Filler =
	{
		InheritFrom = { "PrometheusKick_Light", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.2,
			MoveWithinRangeTimeoutMax = 0.2,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusSlam_P3_Ender", "PrometheusFlurry_P3_Ender", "PrometheusUppercut_P3_Ender",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Ender", "PrometheusFlurry_P3_Ender", "PrometheusUppercut_P3_Ender",
			},
		},
	},
	PrometheusKick_P3_Ender =
	{
		InheritFrom = { "PrometheusKick_Heavy", },
		AIData =
		{
			PreAttackRotationDampening = 0.5,

			MoveWithinRangeTimeoutMin = 0.25,
			MoveWithinRangeTimeoutMax = 0.25,

			PostAttackDuration = 1.8,
			PostAttackMinWaitTime = 1.62,			

			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},

	-- Flurry
	-- Base
	PrometheusFlurry_Light =
	{
		Requirements =
		{
			MapAggressor = "Prometheus",
		},

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

			PreAttackStartMinWaitTime = 0.20,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackDuration = 0.75,
			FireTicks = 5,
			FireInterval = 0.05,
			FireDuration = 0.0,
			PostAttackDuration = 0.6,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 200,

			PreAttackAnimation = "Enemy_Prometheus_FlurryPreFire",
			FireAnimation = "Enemy_Prometheus_FlurryFire",
			PostAttackAnimation = "Enemy_Prometheus_FlurryPostFire_Fast",
			AttackSound = "/SFX/Player Sounds/MelTorchFireBasic",

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusAttackLines" },
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
	PrometheusFlurry_Heavy =
	{
		Requirements =
		{
			MapAggressor = "Prometheus",
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "PrometheusPunch", AIDataOverrides = { Spread = 5 }, PauseDuration = 0.08 },
				{ ProjectileName = "PrometheusFlurry", AIDataOverrides = { Spread = 60 }, },
			},

			PreAttackStop = true,
			PreAttackRotationDampening = 0.35,
			TrackTargetDuringCharge = true,
			StopBeforeFire = true,


			PreAttackDuration = 1.0,

			FireTicks = 5,
			FireInterval = 0.05,
			FireDuration = 0.0,

			PostAttackDuration = 2.6,
			PostAttackMinWaitTime = 2.34,

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 200,

			PreAttackAnimation = "Enemy_Prometheus_FlurryPreFire_Charged",
			FireAnimation = "Enemy_Prometheus_FlurryFire",
			PostAttackAnimation = "Enemy_Prometheus_FlurryPostFire",
			AttackSound = "/SFX/Player Sounds/MelTorchFireBasic",

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusPreAttackLines" },
			},

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusAttackLines" },
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
	PrometheusFlurry_HeraclesCombo =
	{
		InheritFrom = { "PrometheusFlurry_Heavy" },

		AIData =
		{
			DeepInheritance = true,
		},
	},

	-- Phase
	PrometheusFlurry_P1 =
	{
		InheritFrom = { "PrometheusFlurry_Heavy", },
		Requirements =
		{
			MapAggressor = "Prometheus",
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},
	PrometheusFlurry_P2_Starter =
	{
		InheritFrom = { "PrometheusFlurry_Light", },
		Requirements =
		{
			MapAggressor = "Prometheus",
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Filler", "PrometheusKick_P2_Filler", "PrometheusUppercut_P2_Filler",
			},
		},
	},
	PrometheusFlurry_P2_Filler =
	{
		InheritFrom = { "PrometheusFlurry_Light", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.2,
			MoveWithinRangeTimeoutMax = 0.2,

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Ender", "PrometheusKick_P2_Ender", "PrometheusUppercut_P2_Ender",
			},
		},
	},
	PrometheusFlurry_P2_Ender =
	{
		InheritFrom = { "PrometheusFlurry_Heavy", },

		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},

		AIData =
		{
			PostAttackDuration = 2.1,
			PostAttackMinWaitTime = 1.89,

			MoveWithinRangeTimeoutMin = 0.25,
			MoveWithinRangeTimeoutMax = 0.25,

			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},
	PrometheusFlurry_P3_Starter =
	{
		InheritFrom = { "PrometheusFlurry_Light", },
		Requirements =
		{
			MapAggressor = "Prometheus",
			MinAttacksBetweenUse = 7,
		},
		AIData =
		{
			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler", "PrometheusKick_P3_Filler", "PrometheusUppercut_P3_Filler",
			},
		},
	},
	PrometheusFlurry_P3_Filler =
	{
		InheritFrom = { "PrometheusFlurry_Light", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.2,
			MoveWithinRangeTimeoutMax = 0.2,

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Ender", "PrometheusKick_P3_Ender", "PrometheusUppercut_P3_Ender",
			},
		},
	},
	PrometheusFlurry_P3_Ender =
	{
		InheritFrom = { "PrometheusFlurry_Heavy", },
		AIData =
		{
			PostAttackDuration = 1.8,
			PostAttackMinWaitTime = 1.62,

			MoveWithinRangeTimeoutMin = 0.25,
			MoveWithinRangeTimeoutMax = 0.25,

			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},

	-- Uppercut
	-- Base
	PrometheusUppercut_Light =
	{
		Requirements =
		{
			MapAggressor = "Heracles",
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "PrometheusUppercut",

			FireProjectileStartDelay = 0.09,

			PreAttackStartMinWaitTime = 0.16,
			PreAttackEndMinWaitTime = 0.42,
			PreAttackDuration = 0.69,
			FireDuration = 0.365,
			PostAttackDuration = 0.6,

			PreAttackAnimation = "Enemy_Prometheus_UppercutPreFire",
			FireAnimation = "Enemy_Prometheus_UppercutFire",
			PostAttackAnimation = "Enemy_Prometheus_UppercutPostFire_Fast",

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 300,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.1,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.2,
			StopBeforeFire = true,

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 1500,
			RetreatTimeout = 1.75,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 500,

			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusAttackLines" },
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
	PrometheusUppercut_Heavy =
	{
		Requirements =
		{
			MapAggressor = "Heracles",
		},

		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "PrometheusUppercut", PauseDuration = 0.1 },
				{ ProjectileName = "PrometheusUppercutWhirlwind", AIDataOverrides = { BarrelLength = 500, }, },
			},

			FireProjectileStartDelay = 0.09,

			PreAttackDuration = 1.1,
			FireDuration = 0.265,
			PostAttackDuration = 2.5,
			PostAttackMinWaitTime = 2.25,

			PreAttackAnimation = "Enemy_Prometheus_UppercutPreFire_Charged",
			FireAnimation = "Enemy_Prometheus_UppercutFire",
			PostAttackAnimation = "Enemy_Prometheus_UppercutPostFire",

			MoveWithinRange = true,
			MoveWithinRangeTimeoutMin = 2.0,
			MoveWithinRangeTimeoutMax = 3.0,
			AttackDistance = 300,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 0.1,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.2,
			StopBeforeFire = true,

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 1500,
			RetreatTimeout = 1.75,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 500,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusPreAttackLines" },
			},
			AttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusAttackLines" },
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

	-- Phases
	PrometheusUppercut_P1 =
	{
		InheritFrom = { "PrometheusUppercut_Heavy", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
			MapAggressor = "Prometheus",
		},
		AIData =
		{
			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},
	PrometheusUppercut_P2_Starter =
	{
		InheritFrom = { "PrometheusUppercut_Light", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
			MapAggressor = "Prometheus",
		},
		AIData =
		{
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusSlam_P2_Filler", "PrometheusKick_P2_Filler", "PrometheusFlurry_P2_Filler",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Filler", "PrometheusKick_P2_Filler",
			},
		},
	},
	PrometheusUppercut_P2_Filler =
	{
		InheritFrom = { "PrometheusUppercut_Light", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.2,
			MoveWithinRangeTimeoutMax = 0.2,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusSlam_P2_Ender", "PrometheusKick_P2_Ender", "PrometheusFlurry_P2_Ender",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P2_Ender", "PrometheusKick_P2_Ender",
			},
		},
	},
	PrometheusUppercut_P2_Ender =
	{
		InheritFrom = { "PrometheusUppercut_Heavy", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			PostAttackDuration = 2.1,
			PostAttackMinWaitTime = 1.89,

			MoveWithinRangeTimeoutMin = 0.25,
			MoveWithinRangeTimeoutMax = 0.25,

			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
		},
	},
	PrometheusUppercut_P3_Starter =
	{
		InheritFrom = { "PrometheusUppercut_Light", },
		Requirements =
		{
			MinAttacksBetweenUse = 7,
			MapAggressor = "Prometheus",
		},
		AIData =
		{
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusSlam_P3_Filler", "PrometheusKick_P3_Filler", "PrometheusFlurry_P3_Filler",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Filler", "PrometheusKick_P3_Filler",
			},
		},
	},
	PrometheusUppercut_P3_Filler =
	{
		InheritFrom = { "PrometheusUppercut_Light", },
		Requirements =
		{
			-- null
		},
		AIData =
		{
			MoveWithinRangeTimeoutMin = 0.2,
			MoveWithinRangeTimeoutMax = 0.2,

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusSlam_P3_Ender", "PrometheusKick_P3_Ender", "PrometheusFlurry_P3_Ender",
						},
					},
				},
			},

			ChainedWeaponOptions =
			{
				"PrometheusSlam_P3_Ender", "PrometheusKick_P3_Ender",
			},
		},
	},
	PrometheusUppercut_P3_Ender =
	{
		InheritFrom = { "PrometheusUppercut_Heavy", },
		Requirements =
		{
			MinAttacksBetweenUse = 2,
		},
		AIData =
		{
			PostAttackDuration = 1.8,
			PostAttackMinWaitTime = 1.62,

			MoveWithinRangeTimeoutMin = 0.25,
			MoveWithinRangeTimeoutMax = 0.25,

			PostAttackThreadedFunctionName = "PrometheusPostAttackForesight",
			PostAttackEndFunctionName = "PrometheusCancelPostAttackForesight",
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

	PrometheusDashForsight =
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
			PreAttackAnimation = "Enemy_Prometheus_DashForward_Start_NoStreak",
			FireAnimation = "Enemy_Prometheus_DashForward_Fire_NoStreak",
			PostAttackAnimation = "Enemy_Prometheus_DashForward_End",

			TrackTargetDuringCharge = true,
			StopBeforeFire = true,

			CreateOwnTargetFromOriginalTarget = true,
			UseTargetAngle = true,
			TargetAngleOffsetMin = 120,
			TargetAngleOffsetMax = 240,
			TargetOffsetDistance = 300,

			RemoveUnitCollisionDuringAttack = true,

			PreAttackThreadedFunctionName = "PrometheusForesightPresentation",

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
			MapAggressor = "Heracles",
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
			MapAggressor = "Heracles",
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
			PostAttackDuration = 1.5,

			AttackDistance = 1100,

			PreAttackSelfVelocity = 400,

			PreAttackSound = "/SFX/Enemy Sounds/Prometheus/PrometheusChargeUp",

			PreAttackAnimation = "Enemy_Prometheus_Point_Fast",
			FireAnimation = "Enemy_Prometheus_Cast_Start",
			PostAttackAnimation = "Enemy_Prometheus_Cast_Fire",

			RetreatBeforeAttack = true,
			RetreatBufferDistance = 1500,
			RetreatTimeout = 1.75,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 500,

			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusBurnLines" },
			},
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
			ImmuneToProjectileSlow = true,
			SkipFireProjectileIfInTransition = true,
			SkipFireProjectileIfInterrupted = true,

			BarrelLength = 0,

			TrackTargetDuringFire = true,
			TrackTargetDuringCharge = true,
			PostAttackStop = true,

			PreAttackDuration = 0.95,
			FireFx = "PrometheusCastLineAimLine",
			StopAnimationsOnHitStun = { "PrometheusCastLineAimLine", },
			FireDuration = 1.6,
			PostAttackDuration = 1.5,

			AttackDistance = 1100,

			PreAttackSelfVelocity = 400,

			RetreatBeforeAttack = true,
			RetreatTimeout = 1.75,
			RetreatBufferDistance = 1500,
			RetreatToSpawnPoints = true,
			RetreatToSpawnPointRadius = 500,

			PreAttackAnimation = "Enemy_Prometheus_Point_Fast",
			FireAnimation = "Enemy_Prometheus_Cast_Start",
			PostAttackAnimation = "Enemy_Prometheus_Cast_Fire",
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
			MapAggressor = "Heracles",
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
		},
	},

	PrometheusCastCircle_P2 =
	{
		InheritFrom = { "PrometheusCastCircle_P1", },
		GenusName = "PrometheusCast_P2",
	},
	PrometheusCastLine_P2 =
	{
		InheritFrom = { "PrometheusCastLine_P1", },
		GenusName = "PrometheusCast_P2",
	},

	PrometheusCastSelector_P3 =
	{
		GenusName = "PrometheusCast_P3",
		Requirements =
		{
			MapAggressor = "Heracles",
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
		},
	},

	PrometheusCastCircle_P3 =
	{
		InheritFrom = { "PrometheusCastCircle_P1", },
		GenusName = "PrometheusCast_P3",
		AIData =
		{
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = "<",
								Value = 3,
							},
						}
					},
					Data =
					{
						PartnerForceWeaponInterrupt = "EagleDive_P3",
					},
				},
			},
		},
	},
	PrometheusCastLine_P3 =
	{
		InheritFrom = { "PrometheusCastLine_P1", },
		GenusName = "PrometheusCast_P3",
		AIData =
		{
			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = "<",
								Value = 3,
							},
						}
					},
					Data =
					{
						PartnerForceWeaponInterrupt = "EagleDive_P3",
					},
				},
			},
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
			
			PreMoveFunctionName = "PrometheusCancelPostAttackForesight",

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
			ClearAllEffects = true,

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
			ImmuneToProjectileSlow = true,

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
			ImmuneToProjectileSlow = true,

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
				{ GlobalVoiceLines = "PrometheusBurnLines" },
			},

			PreAttackAngleTowardTarget = false,

			FireFunctionName = "PrometheusMemoryOutroPresentation",
			FireFunctionArgs =
			{
				LandingIds = { 751891, 745036, 745049, 745025, 745030, 745033, 745029 },
			},

			AttackDistance = 9999,

			PreAttackStop = true,
			StopMoveWithinRange = true,

			-- PreAttackSound = "/SFX/Enemy Sounds/Carrion/EmoteCharging",

			ConditionalData =
			{
				{
					GameStateRequirements =
					{
						{
							FunctionName = "RequiredShrineLevel",
							FunctionArgs =
							{
								ShrineUpgradeName = "BossDifficultyShrineUpgrade",
								Comparison = ">=",
								Value = 3,
							},
						}
					},
					Data =
					{
						ChainedWeaponOptions =
						{
							"PrometheusKick_P2_Filler",
						},
					},
				},
			},
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
				--"PrometheusSummon_Harpy",
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
				--"PrometheusSummon_Dragon",
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
			PreAttackSound = "/SFX/Enemy Sounds/EagleAlerted",
			PreAttackVoiceLines =
			{
				{ GlobalVoiceLines = "PrometheusSpawnWaveLines" },
			},
			FireDuration = 0.45,
			PostAttackDuration = 0.0,

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
	},

	PrometheusSummon_Sapper =
	{
		InheritFrom = { "PrometheusSummonBase" },

		AIData =
		{
			DeepInheritance = true,

			SpawnsPerBurstMin = 3,
			SpawnsPerBurstMax = 3,
			SpawnRate = 0.4,
			MaxActiveSpawns = 6,
			SpawnOnIds = { 751888, 745048, 745034, },
			SpawnerOptions = { "SatyrSapper_Prometheus" },
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
			SpawnRate = 0.4,
			MaxActiveSpawns = 6,
			SpawnOnIds = { 751888, 745048, 745034, },
			SpawnerOptions = { "SatyrLancer_Prometheus" },
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
				{ GlobalVoiceLines = "PrometheusEagleComboLines" },
			},
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