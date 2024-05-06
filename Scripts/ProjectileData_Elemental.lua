OverwriteTableKeys( ProjectileData, {
	GoldElementalBeam =
	{
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
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
	TimeElementalOrbit =
	{
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
	},
	TimeElementalOrbit_Elite =
	{
		HealthTickDamage = 0,
		ImpactReactionHitsOverride = 0,
	},
})