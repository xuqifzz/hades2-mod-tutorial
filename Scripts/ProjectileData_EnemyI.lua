OverwriteTableKeys( ProjectileData, {

	GoldElementalBeam =
	{
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	GoldElementalBeam_Elite =
	{
		InheritFrom = { "GoldElementalBeam" },
	},
	GoldElementalBeam_MiniBoss =
	{
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
		HitScreenshake = { Distance = 4, Speed = 400, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	GoldElementalSky =
	{

	},

	GoldElementalGround =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.06, LerpTime = 0 },
			{ ScreenPreWait = 0.18, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TimeElementalOrbit =
	{
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TimeElementalDeathRadial =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.03, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	TimeElementalHealBeam =
	{
		ProjectileFireSound = "/SFX/Enemy Sounds/Hades/HadesHealingTick",
		BypassRetaliate = true,
	},
	TimeElementalHealBeam_EM =
	{
		InheritFrom = { "TimeElementalHealBeam", },
	},
	TimeElementalHealBeam_Typhon =
	{
		InheritFrom = { "TimeElementalHealBeam", },
	},
	TimeElementalHealBeam_Ally =
	{
		InheritFrom = { "TimeElementalHealBeam", },
	},

	TimeElementalDeath =
	{

	},

	SwarmerClockworkMelee =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	ThugShove =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	ThugSwipe =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.13, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	ThugSlamWave =
	{
		ProjectileFireSound = "/Leftovers/SFX/AuraThrowLarge",
	},
	ThugSlam =
	{

	},
	ThugSlamNova =
	{

	},

	SatyrLancerThrow = 
	{
		HealthTickDamage = 0,
	},

	SatyrLancerThrow_Elite = 
	{
		HealthTickDamage = 0,
	},

	SatyrLancerThrust = 
	{
		HealthTickDamage = 0,
	},

	SatyrCast = 
	{
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SatyrFire = 
	{
		InheritFrom = { "BaseFireZone", },
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SatyrRatCatcherMelee =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	SatyrCultistMelee =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	SatyrCultistMeleeRadial =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	CultistShockwave =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	CultistThrow =
	{
		ProjectileFireSound = "/SFX/Enemy Sounds/WretchedShadeAssassin/AssassinKnifeThrow",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	SatyrCultistMelee_Elite =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	SatyrCultistMeleeRadial_Elite =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	SatyrCultistCast =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SatyrRatCatcherMelee_Miniboss =
	{
		InheritFrom = { "SatyrRatCatcherMelee" },
	},

	SatyrRatCatcherSpellKnockback =
	{

	},

	SatyrRatCatcherSpellBuff =
	{

	},

	CrawlerRush =
	{

	},

	-- Chronos
	ChronosRush =
	{
		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 0.0,
			},
		},
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosRipple =
	{
		Fuse = 1.2,
		ReticleAnimation = "ChronosRiftInteriorIn",
		ReticleUseProjectileAngle = true,
		ReticleGroupName = "FX_Standing_Top",
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ChronosRushRipple =
	{
		Fuse = 1.2,
		ReticleAnimation = "ChronosRiftStraightInteriorIn",
		ReticleUseProjectileAngle = true,
		ReticleGroupName = "FX_Standing_Top",
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ChronosRushRippleFast =
	{
		InheritFrom = { "ChronosRushRipple", },
		Fuse = 0.5,
	},
	ChronosRushKnockback =
	{

	},
	ChronosDashStasis =
	{

	},
	ChronosStasisExtended =
	{

	},
	ChronosDashRadial =
	{
		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.03, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ChronosBoltDefense =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ChronosBoltDefenseEM =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ChronosSwingRight =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosSwingLeft =
	{
		InheritFrom = { "ChronosSwingRight", },
	},
	ChronosTelescopeSwingRight =
	{
		InheritFrom = { "ChronosSwingRight", },
	},
	ChronosRift =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosRiftSpin =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosClockArmBolt =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosClockArm30 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosClockArm =
	{
		InheritFrom = { "ChronosClockArm30", },
		ProjectileFireSound = "/SFX/Enemy Sounds/Chronos/ChronosClockHand",
	},
	ChronosClockArmShort =
	{
		InheritFrom = { "ChronosClockArm30", },
	},
	ChronosClockArm30Short =
	{
		InheritFrom = { "ChronosClockArm30", },
	},
	ChronosClockArm360 =
	{
		InheritFrom = { "ChronosClockArm30", },
	},
	ChronosClockArm360Slow =
	{
		InheritFrom = { "ChronosClockArm30", },
	},
	ChronosRadialIn =
	{
		ProjectileFireSound = "/Leftovers/Menu Sounds/TextReveal3Distance",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},

		ExpireOnDelay = 4.1,
	},
	ChronosRadialOut =
	{
		InheritFrom = { "ChronosClockArm30", },
		Fuse = 1.0,
		ReticleAnimation = "ChronosClockRadialOutPreview",
	},
	ChronosScytheThrow =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosScytheThrowReverse =
	{
		InheritFrom = { "ChronosScytheThrow", },
	},
	ChronosScytheThrowLarge =
	{
		InheritFrom = { "ChronosScytheThrow", },
	},
	ChronosScytheThrowClose =
	{
		InheritFrom = { "ChronosScytheThrow", },
	},
	ChronosScytheThrowMid =
	{
		InheritFrom = { "ChronosScytheThrow", },
	},
	ChronosScytheThrowFar =
	{
		InheritFrom = { "ChronosScytheThrow", },
	},
	ChronosGrindWall =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ChronosGrindWallReverse =
	{
		InheritFrom = { "ChronosGrindWall", },
	},

	ChronosGrindWallForward =
	{
		ProjectileFireSound = "/SFX/Enemy Sounds/Charon/CharonGroundBlastFire",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosGrindVacuum =
	{
		BypassRetaliate = true,
	},
	ChronosGrindVacuumWeak =
	{
		InheritFrom = { "ChronosGrindVacuum", },
	},
	ChronosGrindVacuumStrong =
	{
		InheritFrom = { "ChronosGrindVacuum", },
	},
	ChronosGrindVacuumReverse =
	{
		InheritFrom = { "ChronosGrindVacuum", },
	},
	ChronosGrindVacuumReverseWeak =
	{
		InheritFrom = { "ChronosGrindVacuum", },
	},
	ChronosRadial =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosRadialSmall =
	{
		InheritFrom = { "ChronosRadial", },
	},
	ChronosRadialExtended =
	{
		InheritFrom = { "ChronosRadial", },
	},
	ChronosCircle =
	{
		CancelIfOwnerAIStageEnd = true,
		BypassDamagingRetaliate = true,
		HitScreenshake = { Distance = 9, Speed = 1500, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.26, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosCircleInverted =
	{
		InheritFrom = { "ChronosCircle", },
	},
	ChronosCircleInvertedSmall =
	{
		InheritFrom = { "ChronosCircle", },
	},
	SatyrCultistRitualBlast =
	{
		InheritFrom = { "ChronosCircle", },
	},
	ChronosScytheSlam =
	{
		HitScreenshake = { Distance = 9, Speed = 1500, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.26, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosScytheSlamLarge =
	{
		InheritFrom = { "ChronosScytheSlam", },
	},

	ChronosScytheDrag = 
	{
		HitScreenshake = { Distance = 3, Speed = 500, Duration = 0.08, FalloffSpeed = 1000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ChronosBoltOrbit1 = 
	{
		HitScreenshake = { Distance = 3, Speed = 500, Duration = 0.08, FalloffSpeed = 1000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ChronosBoltOrbit2 = 
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit3 = 
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit1_Fast = 
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit2_Fast = 
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit3_Fast = 
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit1_Curse =
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit1Reverse_Curse =
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit2_Curse = 
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit2Reverse_Curse =
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit3_Curse = 
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},
	ChronosBoltOrbit3Reverse_Curse =
	{
		InheritFrom = { "ChronosBoltOrbit1", },
	},

	WringerGrab = 
	{
		HitScreenshake = { Distance = 3, Speed = 500, Duration = 0.08, FalloffSpeed = 1000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},
})