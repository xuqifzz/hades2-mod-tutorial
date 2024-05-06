OverwriteTableKeys( ProjectileData, {
	-- Chronos
	ChronosRush =
	{
		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 0.0,
			},
		}
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

	SwarmerRushRipple =
	{
		InheritFrom = { "ChronosRushRipple" },
	},

	ChronosBoltDefense =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ChronosBoltOrbit =
	{
		InheritFrom = { "ChronosBoltDefense", },
	},
	ChronosBoltOrbit1 =
	{
		InheritFrom = { "ChronosBoltDefense", },
	},
	ChronosBoltOrbit2 =
	{
		InheritFrom = { "ChronosBoltDefense", },
	},
	ChronosBoltOrbit3 =
	{
		InheritFrom = { "ChronosBoltDefense", },
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
	ChronosRift =
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
		ProjectileFireSound = "/SFX/Enemy Sounds/Chronos/ChronosClockHand",
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosClockArm30 =
	{
		ProjectileFireSound = "/EmptyCue",
		InheritFrom = { "ChronosClockArm", },
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
	},
	ChronosGrindWall =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
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
	ChronosRadial =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ChronosCircle =
	{
		CancelIfOwnerAIStageEnd = true,
		BypassRetaliate = true,
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

	SummonDeathWeapon = 
	{

	},

	ChronosBoltOrbit = 
	{
		HitScreenshake = { Distance = 3, Speed = 500, Duration = 0.08, FalloffSpeed = 1000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ChronosBoltOrbit2 = 
	{
		InheritFrom = { "ChronosBoltOrbit", },
	},

	ChronosBoltOrbit3 = 
	{
		InheritFrom = { "ChronosBoltOrbit", },
	},
})