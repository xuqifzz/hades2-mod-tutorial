OverwriteTableKeys( ProjectileData, {

	ZombieOlympusMelee =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ZombieOlympusMelee_Elite =
	{
		InheritFrom = { "ZombieOlympusMelee" },
	},

	AutomatonBeamBolt =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	AutomatonScan =
	{

	},

	AutomatonOrbit =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	AutomatonMeleeArcLeft =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0 },
		},
	},

	AutomatonMeleeArcRight =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0 },
		},
	},

	AutomatonWhirlwind =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	AutomatonWhirlwind_Elite =
	{
		InheritFrom = { "AutomatonWhirlwind" },
	},

	SatyrRocket =
	{
		HitScreenshake = { Distance = 9, Speed = 1000, Duration = 0.22, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0 },
		},
	},
	SatyrRocket_Prometheus =
	{
		InheritFrom = { "SatyrRocket" },
	},

	SatyrSapperLob =
	{
		HitScreenshake = { Distance = 9, Speed = 1000, Duration = 0.22, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrSapperMelee =
	{
		HitScreenshake = { Distance = 9, Speed = 1000, Duration = 0.22, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrCrossbow2Bolt =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SatyrCrossbow2ShieldRush =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SatyrLancer2Thrust =
	{

	},

	SatyrLancer2Throw =
	{

	},

	SentryBotBolt =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.09, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SentryBotVent =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonBreathGround =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonBreathGround_Miniboss =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonBreath =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonBreath_MiniBoss =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonTailWhip =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonGlideGround =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.13, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.14, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonGlideGround_Miniboss =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DragonTailWhip_Miniboss =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HarpyFlapFast =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TalosShieldThrowLeft =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosShieldThrowRight =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosShieldThrowStraight =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosShieldThrowStraightL = {
		InheritFrom = { "TalosShieldThrowStraight" },
	},

	TalosSpin =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosMagnet =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.25, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.13, LerpTime = 0 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TalosPunch =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.2, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.08, LerpTime = 0 },
			{ ScreenPreWait = 0.30, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TalosFireLob =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosFire =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.015, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.035, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TalosSprintKnockback =
	{
		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.3, FalloffSpeed = 3000, Angle = 0 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.05 },
		},
	},

	-- Eagle
	EagleSwoop =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.3, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	EagleSwoop_Olympus =
	{
		InheritFrom = { "EagleSwoop", },
	},
	EagleSweep =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.3, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	EagleSweep_Olympus =
	{
		InheritFrom = { "EagleSweep", },
	},
	EagleFlyUpWhirlwind =
	{
		DamagedFx = "PlayerHitSpark_NoBlood",
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.3, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	EagleFlyUpWhirlwind_Olympus =
	{
		InheritFrom = { "EagleFlyUpWhirlwind", },
	},

	EagleRollFireball =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	EagleRollFireball_Olympus =
	{
		InheritFrom = { "EagleRollFireball", },
	},
	EagleRollFireball_Fast =
	{
		InheritFrom = { "EagleRollFireball", },
	},

	-- Prometheus
	PrometheusGroundPound =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.32, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusGroundPoundNova =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.35, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusKick =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.33, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.46, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusKickFireWave =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusPunch =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.21, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusFlurry =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.03, LerpTime = 0 },
			{ ScreenPreWait = 0.14, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	PrometheusUppercut =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusUppercutWhirlwind =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusFireCircle =
	{
		InheritFrom = { "BaseFireZone", },
		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusFireCircleLarge =
	{
		InheritFrom = { "PrometheusFireCircle", },
	},
	PrometheusSkyCast =
	{
		Fuse = 3.2,
		ReticleAnimation = "PrometheusSkyCastPreview_In",
		ReticleGroupName = "FX_Terrain",
		AttachToTarget = true,
		CancelIfOwnerAIStageEnd = true,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	PrometheusFirePillarForward =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PrometheusMemory_P2 =
	{
		Fuse = 4.2,
		ReticleAnimation = "PrometheusMemoryReticle",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.35, Fraction = 1.0, LerpTime = 0.1 },
		},
		
		OnHitFunctionNames = { "PrometheusMemoryOnHit" },
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.5,
			-- SuccessiveChanceToPlay = 0.25,
			ObjectType = "Prometheus",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
					Comparison = ">=",
					Value = 0.15,
				},
			},
			Cooldowns =
			{
				{ Name = "PrometheusSpokeRecently", Time = 12 },
			},

			{ Cue = "/VO/Prometheus_0428", Text = "Poor choice." },
			{ Cue = "/VO/Prometheus_0429", Text = "Caught you." },
			{ Cue = "/VO/Prometheus_0430", Text = "Caught out." },
			{ Cue = "/VO/Prometheus_0431", Text = "You lack focus." },
			{ Cue = "/VO/Prometheus_0432", Text = "You're scattered." },
			{ Cue = "/VO/Prometheus_0433", Text = "Wrong." },
			{ Cue = "/VO/Prometheus_0434", Text = "Come on." },
			{ Cue = "/VO/Prometheus_0435", Text = "How quickly they forget." },
			{ Cue = "/VO/Prometheus_0436", Text = "Wake up." },
			{ Cue = "/VO/Prometheus_0437", Text = "Try again." },
			{ Cue = "/VO/Prometheus_0438", Text = "Uh-uh." },
			{ Cue = "/VO/Prometheus_0439", Text = "You merely guess." },
		},
	},
	PrometheusMemory_P3 =
	{
		Fuse = 7,
		ReticleAnimation = "PrometheusMemoryReticle",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.35, Fraction = 1.0, LerpTime = 0.1 },
		},
		
		OnHitFunctionNames = { "PrometheusMemoryOnHit" },
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.5,
			-- SuccessiveChanceToPlay = 0.25,
			ObjectType = "Prometheus",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
					Comparison = ">=",
					Value = 0.15,
				},
			},
			Cooldowns =
			{
				{ Name = "PrometheusSpokeRecently", Time = 12 },
			},

			{ Cue = "/VO/Prometheus_0428", Text = "Poor choice." },
			{ Cue = "/VO/Prometheus_0429", Text = "Caught you." },
			{ Cue = "/VO/Prometheus_0430", Text = "Caught out." },
			{ Cue = "/VO/Prometheus_0431", Text = "You lack focus." },
			{ Cue = "/VO/Prometheus_0432", Text = "You're scattered." },
			{ Cue = "/VO/Prometheus_0433", Text = "Wrong." },
			{ Cue = "/VO/Prometheus_0434", Text = "Come on." },
			{ Cue = "/VO/Prometheus_0435", Text = "How quickly they forget." },
			{ Cue = "/VO/Prometheus_0436", Text = "Wake up." },
			{ Cue = "/VO/Prometheus_0437", Text = "Try again." },
			{ Cue = "/VO/Prometheus_0438", Text = "Uh-uh." },
			{ Cue = "/VO/Prometheus_0439", Text = "You merely guess." },
		},
	},
	HeraclesEMSpin =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},
	HeraclesEMSpinEnraged =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HeraclesEMLeap =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HeraclesEMLeapSlam =
	{
		ReticleAnimation = "LobWarningDecalIris_Typhon",
		Fuse = 1.25,
		ReticleGroupName = "FX_Terrain",
		CancelIfOwnerAIStageEnd = true,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	HeraclesEMArcRight =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	HeraclesEMWave =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},
})