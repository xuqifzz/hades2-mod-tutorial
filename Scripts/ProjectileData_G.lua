OverwriteTableKeys( ProjectileData, {
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
	SteamTrap =
	{
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	SteamTrapFast =
	{
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	SteamWallBlast =
	{
		DamagedFx = "PlayerBurnDamage",
		
		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 10,
			}
		},

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	SteamCubeExplosion =
	{
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.02, Fraction = 0.08, LerpTime = 0.0 },
			{ ScreenPreWait = 0.12, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	FloodTrapWeapon = 
	{	

		ExpireOldestCap = 20,

		TriggersPlayerOnHitPresentation = true,
		PresentationOnlyOnPlayerHit = true,
		HitScreenshake = { Distance = 5, Speed = 500, Duration = 0.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.02, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0.1 },
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
})