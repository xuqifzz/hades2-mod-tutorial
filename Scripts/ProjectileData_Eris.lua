OverwriteTableKeys( ProjectileData, {
	GunWeapon =
	{

		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SniperGunWeapon =
	{

		--FireScreenshake = { Distance = 8, Speed = 600, FalloffSpeed = 1000, Duration = 0.32, Angle = 90, DistanceThreshold = 400 },

		HitScreenshake = { Distance = 6, Speed = 400, Duration = 0.25, FalloffSpeed = 1000 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.06, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.22, Fraction = 0.15, LerpTime = 0.06 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0.06 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.65 },
		},
	},

	GunGrenadeToss =
	{

		HitScreenshake = { Distance = 6, Speed = 400, Duration = 0.65, FalloffSpeed = 1000, Angle = 90 },

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.15, LerpTime = 0.06 },
			{ ScreenPreWait = 0.22, Fraction = 1.0, LerpTime = 0.06 },
		},

		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.65 },
		},
	},

	ErisBombardment =
	{
		ReticleAnimation = "LobWarningDecalIris",

		Fuse = 1.5,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
		--DeathScreenShake = { Distance = 12, Speed = 550, Duration = 1.0, FalloffSpeed = 3000, Angle = 90 },
		--DeathRadialBlur = { Distance = 0.85, Strength = 0.85, FXHoldTime = 0.8, FXInTime = 0.15, FXOutTime = 0.15 },
	},	
})