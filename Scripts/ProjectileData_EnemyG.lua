OverwriteTableKeys( ProjectileData, {
	
	FishmanImpale =
	{
		HitScreenshake = { Distance = 8, Speed = 1000, Duration = 0.17, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.13, Fraction = 1.0, LerpTime = 0.07 },
		},
		StunOnBlocked = true,
	},

	Fishman2Impale =
	{
		InheritFrom = { "FishmanImpale" },
	},

	FishmanDrag =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
		StunOnBlocked = true,
	},

	Fishman2Drag =
	{
		InheritFrom = { "FishmanImpale" },
	},

	FishmanMeleeSlam =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	FishmanRanged =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	FishmanRanged_Elite =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	FishmanRangedSelfDestruct =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	FishSwarmerBite =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.05 },
		},
	},

	FishSwarmerBite_Elite =
	{
		InheritFrom = { "FishSwarmerBite", },
	},

	TurtleBounce =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.20, LerpTime = 0.0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	TurtleBounceElite = 
	{
		InheritFrom = { "TurtleBounce" },
	},

	TurtleClaw =
	{
		HitScreenshake = { Distance = 2, Speed = 600, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0.03 },
		},	
	},

	WaterUnitSpit =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},
	},

	WaterUnitLob =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},
	},

	WaterUnitSwipe =
	{
		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.06, Fraction = 1.00, LerpTime = 0.08 },
		},
	},

	RadiatorMelee360Slow =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	GuardMelee2 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.00, LerpTime = 0.04 },
		},
	},
	WaterUnitSpitSplit =
	{
		HitScreenshake = { Distance = 10, Speed = 800, Duration = 0.5, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0 },
		},
	},
	WaterUnitSpitSplit1 =
	{
		InheritFrom = { "WaterUnitSpitSplit" },
	},
	WaterUnitSpitSplit2 =
	{
		InheritFrom = { "WaterUnitSpitSplit" },
	},

	WaterUnitLobMiniboss =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.00, LerpTime = 0 },
		},
	},

	WaterUnitSwipeMiniboss =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.03, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.00, LerpTime = 0.08 },
		},
	},

	CrawlerMinibossRush =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.19, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.03, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 0.13, LerpTime = 0.08 },
			{ ScreenPreWait = 0.14, Fraction = 1.00, LerpTime = 0.08 },
		},
	},

	CrawlerShadowRush =
	{
		InheritFrom = { "CrawlerMinibossRush" },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.03, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.00, LerpTime = 0.08 },
		},
	},

	CrawlerMinibossSlam =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.11, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	OctofishSpin =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.00, LerpTime = 0.04 },
		},
	},
	OctofishInkRanged =
	{

	},

	JellyfishStingRing =
	{
		HitScreenshake = { Distance = 10, Speed = 500, Duration = 0.3, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.01, LerpTime = 0.0 },
			{ ScreenPreWait = 0.15, Fraction = 1.00, LerpTime = 0.04 },
		},
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.0, Fraction = 0.2, Duration = 0.6 },
		},
	},

	-- Scylla and Sirens
	KeytaristBounceBall = 
	{
		InheritFrom = { "TurtleBounce" },
	},

	KeytaristBounceBallBoosted = 
	{
		InheritFrom = { "TurtleBounce" },
	},

	SirenDrummerCircle =
	{

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
	SirenDrummerCircleInvertedBoosted =
	{
		InheritFrom = { "SirenDrummerCircleInverted" },
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
	SirenDrummerBeatBoosted =
	{
		InheritFrom = { "SirenDrummerBeat" },
	},
	SirenKeytaristSonic =
	{
		HealthTickDamage = 0,

		TriggersPlayerOnHitPresentation = true,
		PresentationOnlyOnPlayerHit = true,
		DamagedFx = "PlayerHitSpark_NoBlood",
		
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
		DamagedFx = "PlayerHitSpark_NoBlood",
		
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
	SirenKeytaristPowerslideWave =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.03, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0 },
		},
	},
	SirenKeytaristPowerslideWaveBoosted =
	{
		InheritFrom = { "SirenKeytaristPowerslideWave" },
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
	ScyllaWhipBoosted =
	{
		InheritFrom = { "ScyllaWhip" },
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
	ScyllaBeltBoltBoosted =
	{
		InheritFrom = { "ScyllaBeltBolt" },
	},

	ScyllaNotes =
	{

	},
	ScyllaNotesFinale =
	{
		InheritFrom = { "ScyllaNotes" },
	},

	ScyllaClamRush =
	{
		HitScreenshake = { Distance = 8, Speed = 1000, Duration = 0.17, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.13, Fraction = 1.0, LerpTime = 0.07 },
		},
	}
})