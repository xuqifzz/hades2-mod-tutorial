OverwriteTableKeys( ProjectileData, {
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
	FireBarrelExplosion =
	{
		CanIgnite = true,
		DamagedFx = "PlayerBurnDamage",

		HitSimSlowCooldown = 0.2,
		HitSimSlowParameters =
		{	
			{ ScreenPreWait = 0.02, Fraction = 0.07, LerpTime = 0.0 },
			{ ScreenPreWait = 0.02, Fraction = 1.0, LerpTime = 0.07 },
		},
	},

	BattleStandardAoE =
	{
		OnHitFunctionNames = { "AddEnemyHitShield",  },
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

	ZombieSpawnerLob =
	{
		CarriesSpawns = true,
	},

	ZombieSpawnerLob_Elite =
	{
		InheritFrom = { "ZombieSpawnerLob" },
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
})