OverwriteTableKeys( ProjectileData, {

	CorruptedShadeSCast =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	CorruptedShadeMRam =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	CorruptedShadeLVacuum =
	{
		BypassRetaliate = true,
	},
	CorruptedShadeLVacuumWeak =
	{
		InheritFrom = { "CorruptedShadeLVacuum" },
	},

	CorruptedShadeLNova =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	CorruptedShadeLNova_Elite =
	{
		InheritFrom = { "CorruptedShadeLNova" },
	},

	DespairElementalRam =
	{

	},

	BrokenHeartedSlam =
	{
		HitSimSlowCooldown = 0.2,
		HitScreenshake = { Distance = 5, Speed = 900, Duration = 0.14, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.08, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	FogEmitterSweepSmall =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.04, Fraction = 0.05, LerpTime = 0.0 },
			{ ScreenPreWait = 0.09, Fraction = 1.00, LerpTime = 0.04 },
		},
	},

	LovesickHeartLob =
	{

	},
	LovesickHeartLob_Elite =
	{
		InheritFrom = { "LovesickHeartLob" },
	},

	LovesickHeartMineBlast =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.3, LerpTime = 0 },
			{ ScreenPreWait = 0.03, Fraction = 1.0, LerpTime = 0.03 },
		},
	},
	LovesickHeartMineBlast_Elite =
	{
		InheritFrom = { "LovesickHeartMineBlast" },
	},

	LovesickHeartGround =
	{

	},

	LovesickHeartGround_Elite =
	{
		InheritFrom = { "LovesickHeartGround" },
	},

	LovesickHeartOverhand =
	{

	},

	LycanthropePounce =
	{
		HitScreenshake = { Distance = 12, Speed = 970, Duration = 0.17, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	LycanthropeLeapKnockback =
	{
		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.3, FalloffSpeed = 3000, Angle = 0 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.05 },
		},
	},

	LycanthropeLeapKnockbackFriends =
	{

	},

	LycanSummonHowl =
	{
		BypassRetaliate = true,
	
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	LycanSwarmerChomp =
	{

	},

	LycanSwarmer2Chomp =
	{

	},

	MournerRampage =
	{
		HitScreenshake = { Distance = 3, Speed = 700, Duration = 0.07, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.2, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	MournerCast =
	{

	},

	LamiaShockwave =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	LamiaShockwave_Miniboss =
	{
		InheritFrom = { "LamiaShockwave" },
	},

	LamiaSkyCast =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	LamiaSkyCast_Miniboss =
	{
		InheritFrom = { "LamiaSkyCast" },
	},

	LamiaMiasma =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	VampireCast =
	{

	},

	VampireSwipe =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},
	},

	VampireUppercut =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},
	},

	VampireSweep =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},
	},

	VampireComboSwing1 =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.03 },
		},
	},

	VampireComboSwing2 =
	{
		InheritFrom = { "VampireComboSwing1" },
	},

	ScreamerVacuum =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	ScreamerConeLarge =
	{

	},

	Treant2Ranged =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	TreantTail2Swipe =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.08, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.00, LerpTime = 0.06 },
		},
	},

	TreantTail2Unburrow =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.17, Fraction = 1.00, LerpTime = 0 },
		},
	},

	-- Cerberus
	CerberusSkyProjectile =
	{
		Fuse = 3.0,
		ReticleAnimation = "CerbAoEDecal_In",
		ReticleGroupName = "FX_Terrain",
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
		Fuse = 3.0,
		ReticleAnimation = "CerbAoEDecal_In_UnburrowTransition",
		CancelIfOwnerAIStageEnd = false,

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
		OrbitOwnerDetonateBuffer = 0.25,
		OrbitSpeed = 1.0,
	},
	CerberusUnburrowRadial =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
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
	CerberusLungeKnockback =
	{

	},
	InfestedCerberusRam =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 0.5, FalloffSpeed = 3000 },
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
	InfestedCerberusBackSwipeR =
	{
		HitScreenshake = { Distance = 12, Speed = 800, Duration = 1.2, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.05, Fraction = 0.04, LerpTime = 0 },
			{ ScreenPreWait = 0.25, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	InfestedCerberusBackSwipeL =
	{	
		InheritFrom = { "InfestedCerberusBackSwipeR" },
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
	InfestedCerberusPoundMagma =
	{
		InheritFrom = { "InfestedCerberusPound" },
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
	InfestedCerberusExplosiveFireball2 =
	{
		InheritFrom = { "InfestedCerberusExplosiveFireball" },
	},
	CerberusTurnSlam =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.07 },
		},
	},
	CerberusVacuum =
	{
		BypassRetaliate = true,
	},
	MiasmaLobEdge =
	{

	},
	MiasmaLobClose =
	{
		InheritFrom = { "MiasmaLobEdge" },
	},
	CerberusMagmaSplash =
	{
		HitScreenshake = { Distance = 7, Speed = 600, Duration = 0.6, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.03, Fraction = 0.35, LerpTime = 0 },
			{ ScreenPreWait = 0.06, Fraction = 1.00, LerpTime = 0.1 },
		},
	},
	CerberusMagmaSplashWithPuddle =
	{
		InheritFrom = { "CerberusMagmaSplash" },
	},
})