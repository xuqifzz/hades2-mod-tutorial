OverwriteTableKeys( ProjectileData, {
	IcarusBombardment =
	{
		ReticleAnimation = "LobWarningDecalIris_Icarus",

		Fuse = 2.25,

		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
		--DeathScreenShake = { Distance = 12, Speed = 550, Duration = 1.0, FalloffSpeed = 3000, Angle = 90 },
		--DeathRadialBlur = { Distance = 0.85, Strength = 0.85, FXHoldTime = 0.8, FXInTime = 0.15, FXOutTime = 0.15 },
	},	
	IcarusBombardment_Small =
	{
		InheritFrom = { "IcarusBombardment" },
	},
	IcarusBombardment_Large =
	{
		InheritFrom = { "IcarusBombardment" },
	},
	IcarusHazardExplosion = 
	{
		SelfMultiplier = 0,
		SelfDamage = true,
		ReticleAnimation = "LobWarningDecalIris",
	},
})