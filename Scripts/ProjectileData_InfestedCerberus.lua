OverwriteTableKeys( ProjectileData, {
	CerberusSkyProjectile =
	{
		Fuse = 5.0,
		ReticleAnimation = "CerbAoEDecal_In",
		CancelIfOwnerAIStageEnd = true,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	CerberusTransitionRadial =
	{
		Fuse = 5.0,
		ReticleAnimation = "CerbAoEDecal_In_UnburrowTransition",
		CancelIfOwnerAIStageEnd = true,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	CerberusSkyProjectileRotating =
	{
		InheritFrom = { "CerberusSkyProjectile" },
		OrbitOwner = true,
		OrbitOwnerDetonateBuffer = 1.0,
		OrbitSpeed = 0.5,
	},
	CerberusCircleSequenceProjectile =
	{
		InheritFrom = { "CerberusSkyProjectile" },
	},
	CerberusUnburrowRadialInverted =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.06, LerpTime = 0 },
			{ ScreenPreWait = 0.35, Fraction = 1.00, LerpTime = 0.1 },
		},
	},
	InfestedCerberusBreath =
	{
		ExpireOldestCap = 20,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	InfestedCerberusRam =
	{	
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.08, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.0, LerpTime = 0 },
		},
	},
	InfestedCerberusWave =
	{	
		ExpireOldestCap = 20,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.13, Fraction = 1.0, LerpTime = 0 },
		},
	},
	InfestedCerberusWaveLarge =
	{	
		InheritFrom = { "InfestedCerberusWave" },
	},
	InfestedCerberusSwipe =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	InfestedCerberusPound = 
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	InfestedCerberusExplosiveFireball =
	{
		HitScreenshake = { Distance = 7, Speed = 600, Duration = 0.6, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.35, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.00, LerpTime = 0.1 },
		},
	},
})