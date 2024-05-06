OverwriteTableKeys( ProjectileData, {

	KeytaristBounceBall = 
	{
		InheritFrom = { "TurtleBounce" },
	},

	KeytaristBounceBallBoosted = 
	{
		InheritFrom = { "TurtleBounce" },
	},

	SirenDrummerCircleInverted =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 8, Speed = 1000, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	SirenDrummerCircleBoosted =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 8, Speed = 1000, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	SirenDrummerBeat =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.3, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	SirenDrummerLob =
	{
		HealthTickDamage = 0,
		ExpireOldestCap = 30,

		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.2, FalloffSpeed = 3000},
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 0.3, LerpTime = 0.07 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	SirenDrummerLobBoosted =
	{
		InheritFrom = { "SirenDrummerLob" },
	},
	SirenKeytaristSonic =
	{
		HealthTickDamage = 0,

		TriggersPlayerOnHitPresentation = true,
		PresentationOnlyOnPlayerHit = true,
		
		HitScreenshake = { Distance = 10, Speed = 800, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.5, LerpTime = 0 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SirenKeytaristSonicBoosted =
	{
		HealthTickDamage = 0,

		TriggersPlayerOnHitPresentation = true,
		PresentationOnlyOnPlayerHit = true,
		
		HitScreenshake = { Distance = 10, Speed = 800, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.5, LerpTime = 0 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0 },
		},
	},
	SirenKeytaristPowerslideMelee =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 5, Speed = 800, Duration = 0.15, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},
			
	ScyllaCone =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.2, FalloffSpeed = 3000},
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ScyllaConeBoosted =
	{
		InheritFrom = { "ScyllaCone" },
	},
	ScyllaWhip =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.2, FalloffSpeed = 3000},
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 0.1, LerpTime = 0.05 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ScyllaSpin =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.2, FalloffSpeed = 3000},
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 0.1, LerpTime = 0.05 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	ScyllaSpin2 =
	{
		InheritFrom = { "ScyllaSpin" },
	},
	ScyllaSpin3 =
	{
		InheritFrom = { "ScyllaSpin" },
	},
	ScyllaSpin4 =
	{
		InheritFrom = { "ScyllaSpin" },
	},

	ScyllaBeltBolt =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 10, Speed = 1000, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 0.1, LerpTime = 0.05 },
			{ ScreenPreWait = 0.15, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	SirenKeytaristProjectile =
	{
		HealthTickDamage = 0,

		HitScreenshake = { Distance = 5, Speed = 1000, Duration = 0.2, FalloffSpeed = 3000},
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.13, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
})