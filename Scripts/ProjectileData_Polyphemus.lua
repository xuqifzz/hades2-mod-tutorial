OverwriteTableKeys( ProjectileData, {
	PolyphemusLeapKnockback =
	{
		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 0.0,
			},
			}
	},
	PolyphemusBoulderSky =
	{
		OnDeathFunctionName = "SpawnObstacleOnProjectileDeath",
		SpawnObstaclesOnDeath = "PolyphemusBoulder",

		DeathScreenShake = { Distance = 12, Speed = 550, Duration = 1.0, FalloffSpeed = 3000, Angle = 90 },
		DeathRadialBlur = { Distance = 0.85, Strength = 0.85, FXHoldTime = 0.8, FXInTime = 0.15, FXOutTime = 0.15 },
		HitSimSlowCooldown = 1.0,
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.01, Fraction = 0.07, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.05 },
		},
		HitRumbleParameters =
		{
			{ ScreenPreWait = 0.01, Fraciton = 0.35, Duration = 1.0 },
		},

		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 5,
			}
		}
	},
	PolyphemusMarchRubbleFall =
	{
		Fuse = 1.0,
		ReticleAnimation = "BlastWarningDecal",
	},
	PolyphemusMarchRadial =
	{
		--Fuse = 1.0,
		--ReticleAnimation = "BlastWarningDecal",

		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.30, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	PolyphemusBoulder =
	{
		ChargeScreenshake = { Distance = 16, Speed = 600, Duration = 0.30, FalloffSpeed = 3000, Angle = 90, ScreenPreWait = 0.25 },
		FireScreenshake = { Distance = 16, Speed = 600, Duration = 0.82, FalloffSpeed = 3000, Angle = 90, ScreenPreWait = 0.8 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0 },
		},
	},
})