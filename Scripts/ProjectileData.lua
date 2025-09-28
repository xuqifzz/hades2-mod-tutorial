ProjectileData = ProjectileData or {}
OverwriteTableKeys( ProjectileData, {
	NoShakeProjectile =
	{
		CancelCameraShake = true,
	},
	NoSlowFrameProjectile =
	{
		CancelSlowFrames = true,
	},

	RangedWeapon =
	{
		AmmoDropKillForceMin = 900,
		AmmoDropKillForceMax = 950,
		AmmoDropKillUpwardForceMin = 300,
		AmmoDropKillUpwardForceMax = 300,
	},

	ProjectileSwing5 = 
	{
		ExcludeSameWaveHits = true,
	},

	BaseFireZone =
	{
		OnHitFunctionNames = { "CheckLavaPresentation", },
		IgnoreOnHitEffects = true,
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.01, Fraction = 0.1, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	LavaSplash =
	{

	},

	EnemyBombs =
	{

	},

	DevotionAphrodite =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.40, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionApollo =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.04, Fraction = 1.0, LerpTime = 0 },
		},
		OnCreationEvents = 
		{
			{ FunctionName = "StartApolloDevotionSound", Args = { Cue = "/SFX/Player Sounds/ApolloCastLoop" } }
		},
		OnDeathEvents = 
		{
			{ FunctionName = "EndApolloDevotionSound" }
		}
	},

	DevotionAres =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionDemeter =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionHephaestus =
	{
		--OnHitFunctionNames = { "AddEnemyHitShield", },
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionHera =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionHestia =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},
	DevotionHestiaFire =
	{

	},

	DevotionPoseidon =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	DevotionZeus =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.08, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0 },
		},
	},

	WispFuse =
	{

	},

})