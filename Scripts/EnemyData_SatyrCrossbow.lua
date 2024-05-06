UnitSetData.SatyrCrossbow =
{
	SatyrCrossbow =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 600,
		HealthBuffer = 2200,

		ActivateAnimation = "Enemy_SatyrCB_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronos",
		ActivateFx2 = "EnemyPreSpawnStandingMediumChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstMediumChronos",
		DeathFx = "EnemyDeathFxChronos",
		DeathAnimation = "Enemy_SatyrCB_Death",

		HealthBarOffsetY = -220,
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/SatyrCrossbow/EmoteDying",

		ProjectileBlockPresentationFunctionName = "UnitInvulnerableHitPresentation",
		InvulnerableFx = "SatyrShielded",
		InvulnerableHitFx = "SatyrShieldBlock",
		
		BlockRespawnShrineUpgrade = true,

		StunAnimations = 
		{
			Default = "Enemy_SatyrCB_OnHit",
			Heavy = "Enemy_SatyrCB_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},

		WeaponOptions =
		{
			"SatyrCrossbowShieldedBolt", "SatyrCrossbowShieldRush", "SatyrCrossbowFadeBolt",
		},

		GeneratorData =
		{
			DifficultyRating = 100,
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SatyrCrossbow )