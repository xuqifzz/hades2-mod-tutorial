UnitSetData.Wisp =
{
	Wisp =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 90,

		ActivateFx = "WaterUnitSurface",
		ActivateFx2 = "nil",
		ActivateVerticalForce = 2300,
		ActivateFxPreSpawn = "nil",
		ActivateFxPreSpawnDelay = 0.80,
		ActivateFadeIn = true,
		ActivateFadeInDelay = 0.00,
		ActivateFadeInDuration = 0.6,
		ActivateTint = false,
		ActivateStartAlpha = 0, 
		ActivateDuration = 0.95,
		
		PreferredSpawnPoint = "EnemyPointRanged",
		Material = "Organic",
		HealthBarOffsetY = -160,
		HealthBarType = "Small",

		IsAggroedSound = "/SFX/Enemy Sounds/Wisp/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/Wisp/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/Wisp/EmoteHurt",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 300,
		
		StunAnimations = 
		{
			Default = "Enemy_Wisp_HitStun",
			Heavy = "Enemy_Wisp_HitStun_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			AttackDistanceMin = 230,
			RetreatBufferDistance = 250,
			RetreatTimeout = 20.0,
		},

		StopAnimationsOnDeath = { "WispFuseBurn" },

		WeaponOptions =
		{
			"WispFuse",
		},
		
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "I_PostBoss01" },
			},
		},

		GeneratorData =
		{
			DifficultyRating = 9,
		},

		OnKillVoiceLines =
		{
			PlayOnce = true,
			UsePlayerSource = true,
			PreLineWait = 0.35,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_MiniBoss03" },
				},
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_3697", Text = "You even brought some wisps!" },
		},
	},

	Wisp_Elite =
	{
		InheritFrom = { "Elite", "Wisp" },
		HealthBuffer = 100,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "I_PostBoss01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 3,
			},
		},

		WeaponOptions =
		{
			"WispFuse",
		},

		GeneratorData =
		{
			DifficultyRating = 20,
			BlockEnemyTypes = {"Wisp"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Wisp )

WeaponSetData =
{
	WispFuse =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "WispFuse",

			PreAttackDuration = 0.53,
			FireDuration = 0.00,
			PreAttackEndShake = true,
			PreAttackEndFlashColor = { 255, 127, 164, 255 },

			AttackDistance = 200,
			MoveWithinRange = true,
			MoveWithinRangeTimeout = 6,

			FireFunctionName = "SelfDestruct",

			PreMoveAnimation = "Enemy_Wisp_Fuse_Start",
			PreMoveFx = "WispFuseBurn",
			PreAttackAnimation = "Enemy_Wisp_Fuse_Fire",	
			PreAttackFx = "WispRadialPreview",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/HeavyRangedSplitterMiniboss/CrystalBeamFireStartBIG" },
			},
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil