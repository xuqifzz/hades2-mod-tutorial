OverwriteTableKeys( ProjectileData, {
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
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

})