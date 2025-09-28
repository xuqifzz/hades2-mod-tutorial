OverwriteTableKeys( ProjectileData, {

	CarrionSweep =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	GreekFire =
	{
		InheritFrom = { "BaseFireZone" },
		CanIgnite = true,

		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 0.0,
			},
		},
	},

	ZombieHeavyRangedToss =
	{

	},

	ZombieHeavyRangedTossPoison =
	{

	},

	ZombieHRFire =
	{
		InheritFrom = { "BaseFireZone" },
		
		IgnoreOnHitEffects = true,
		
		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 0.0,
			},
		}
	},

	ZombieHeavyRangedShove =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	ZombieHeavyRangedShove_Elite =
	{
		InheritFrom = { "ZombieHeavyRangedShove" },
	},

	ZombieHeavyRangedShove_Elite2 =
	{
		InheritFrom = { "ZombieHeavyRangedShove" },
	},

	ZombieSpawnerLob =
	{
		CarriesSpawns = true,
	},

	ZombieSpawnerLob_Elite =
	{
		InheritFrom = { "ZombieSpawnerLob" },
	},

	ZombieAssassinStab =
	{
		HitScreenshake = { Distance = 3, Speed = 700, Duration = 0.07, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0 },
		},
	},
	ZombieAssassinStab_Miniboss =
	{
		HitScreenshake = { Distance = 3, Speed = 700, Duration = 0.07, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.1, LerpTime = 0 },
			{ ScreenPreWait = 0.07, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ZombieMelee =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ZombieMelee_Elite =
	{
		InheritFrom = { "ZombieMelee" },
	},

	MedeaCurse = 
	{
		-- Don't put anything else here other than color! Edit the DoSpawnCurseDamage function
		DamageTextStartColor = Color.AphroditeDamageLight,
		DamageTextColor = Color.AphroditeDamage,
	},


	MudmanEyeThrow =
	{
		OnDeathFunctionName = "ProjectileSpawnUnitOnDeath",
		SpawnName = "MudmanEye",
		SpawnBounceOffVictim = true,
		SpawnBounceOffVictimVelocity = 650,
		SpawnBounceOffVictimUpwardVelocity = 2200,
		SpawnsSkipActivatePresentation = true,

		CarriesSpawns = true,

		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.08, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	MudmanEyeThrow_Elite =
	{
		InheritFrom = { "MudmanEyeThrow" },
		SpawnName = "MudmanEye_Elite",
	},
	MudmanEyeThrow_Shadow =
	{
		InheritFrom = { "MudmanEyeThrow" },
		SpawnName = "MudmanEye_Elite",
	},
	Mudman2EyeThrow =
	{
		InheritFrom = { "MudmanEyeThrow" },
		SpawnName = "MudmanEye2",
	},
	Mudman2EyeThrow_NoSpawn =
	{
		InheritFrom = { "MudmanEyeThrow" },
		OnDeathFunctionName = "nil",
		SpawnName = "nil",
	},

	MudmanShove =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.09, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	Mudman2Shove =
	{
		InheritFrom = { "MudmanShove" },
	},

	MudmanEyeExplode =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SatyrCrossbowHomingBolt =
	{

	},
	SatyrShieldRush =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	SatyrCrossbowBolt =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0.1 },
		},
	},

	SheepExplode =
	{
		HitScreenshake = { Distance = 3, Speed = 300, Duration = 0.06, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.25, LerpTime = 0 },
			{ ScreenPreWait = 0.05, Fraction = 1.0, LerpTime = 0.1 },
		},
	},
	SheepSickAura =
	{
		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.3, FalloffSpeed = 3000, Angle = 0 },
	},

	-- Polyphemus
	PolyphemusLeapKnockback =
	{
		OutgoingDamageModifiers = 
		{
			{
				NonPlayerMultiplier = 0.0,
			},
		},
		HitScreenshake = { Distance = 4, Speed = 600, Duration = 0.3, FalloffSpeed = 3000, Angle = 0 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.10, LerpTime = 0 },
			{ ScreenPreWait = 0.10, Fraction = 1.0, LerpTime = 0.05 },
		},
	},
	PolyphemusLeapTouchdown =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PolyphemusLeapTouchdown_Poison =
	{
		InheritFrom = { "PolyphemusLeapTouchdown", },
	},
	PolyphemusMegaLeapTouchdown =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PolyphemusFistSlam =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PolyphemusFistSlam_Poison =
	{
		InheritFrom = { "PolyphemusFistSlam", },
	},

	PolyphemusSwipeL =
	{
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},

	PolyphemusSwipeR =
	{
		InheritFrom = { "PolyphemusSwipeL", },
	},
	PolyphemusSwipeL_Poison =
	{
		InheritFrom = { "PolyphemusSwipeL", },
	},
	PolyphemusSwipeR_Poison =
	{
		InheritFrom = { "PolyphemusSwipeL", },
	},

	PolyphemusKick =
	{
		HitScreenshake = { Distance = 3, Speed = 1000, Duration = 0.12, FalloffSpeed = 3000 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.01, LerpTime = 0 },
			{ ScreenPreWait = 0.16, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PolyphemusKick_Poison =
	{
		InheritFrom = { "PolyphemusKick", },
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
	PolyphemusMarchRadial_Poison =
	{
		InheritFrom = { "PolyphemusMarchRadial", },
	},
	PolyphemusBoulderShockwave =
	{
	},
	PolyphemusBoulderShockwave_Poison =
	{
		InheritFrom = { "PolyphemusBoulderShockwave", },
	},
	PolyphemusBoulder =
	{
		ChargeScreenshake = { Distance = 16, Speed = 600, Duration = 0.30, FalloffSpeed = 3000, Angle = 90, ScreenPreWait = 0.25 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.15, LerpTime = 0 },
			{ ScreenPreWait = 0.20, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PolyphemusBoulder_Poison =
	{
		InheritFrom = { "PolyphemusBoulder", },
	},

	PolyphemusStompSmall =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},
	PolyphemusStompSmall_Poison =
	{
		InheritFrom = { "PolyphemusStompSmall", },
	},

	BoarGroundPound =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BoarGroundPound_Shadow =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BoarGroundPound_Summon =
	{
		InheritFrom = { "BoarGroundPound", },
	},

	BoarWallSlam =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BoarRushMelee =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BoarRushRadial =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BoarRushRadial_Shadow =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BoarRushRam =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BoarBackKick =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	BoarBackKick_Shadow =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	MedeaRanged =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	MedeaDaggerMelee =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	ZombieCorpseExplode =
	{
		HitScreenshake = { Distance = 16, Speed = 600, Duration = 0.23, FalloffSpeed = 3000, Angle = 90 },
		HitSimSlowParameters =
		{
			{ ScreenPreWait = 0.02, Fraction = 0.12, LerpTime = 0 },
			{ ScreenPreWait = 0.19, Fraction = 1.0, LerpTime = 0 },
		},
	},

	SheepRam =
	{

	},
})