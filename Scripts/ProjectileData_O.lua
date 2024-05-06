OverwriteTableKeys( ProjectileData, {
	OilPuddleFire =
	{
		InheritFrom = { "BaseFireZone" },
		
		CanIgnite = true,
	},
	OilPuddleFire02 =
	{
		InheritFrom = { "BaseFireZone" },
		
		CanIgnite = true,
	},
	OilPuddleFire03 =
	{
		InheritFrom = { "BaseFireZone" },
		
		CanIgnite = true,
	},
	OilPuddleFire04 =
	{
		InheritFrom = { "BaseFireZone" },
		
		CanIgnite = true,
	},

	CharybdisSpit =
	{
		ReticleAnimation = "LobWarningDecalIris",

		Fuse = 3.0,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
		--DeathScreenShake = { Distance = 12, Speed = 550, Duration = 1.0, FalloffSpeed = 3000, Angle = 90 },
		--DeathRadialBlur = { Distance = 0.85, Strength = 0.85, FXHoldTime = 0.8, FXInTime = 0.15, FXOutTime = 0.15 },
	},

	ShipsBombardment =
	{
		ReticleAnimation = "BlastWarningDecal",

		Fuse = 3.0,
		WanderToOwner = true,
		WanderOwnerDetonateBuffer = 0.35,
		WanderSpeed = 80.0,
		WanderRadius = 200,
		WanderTickMin = 0.75,
		WanderTickMax = 1.25,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},	
	
	HarpySlice =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SwabShockwave =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	SwabShockwave_Elite =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.05, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},
})