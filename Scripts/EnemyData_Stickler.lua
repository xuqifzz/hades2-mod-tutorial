UnitSetData.Stickler =
{

	Stickler =
	{
		InheritFrom = { "BaseOEnemy", "BaseVulnerableEnemy" },

		MaxHealth = 480,
		HealthBarOffsetY = -200,
		HealthBarType = "Medium",

		ActivateAnimation = "Enemy_Stickler_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "DustPuffBNoDecal",
		ActivateFxPreSpawnDelay = 0.5,
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0,
		ActivateDuration = 0.45,
		ActivateStartOffsetZ = 2000,
		PostActivateScreenshake = { Distance = 3, Speed = 200, FalloffSpeed = 0, Duration = 0.18, Angle = 90, DistanceThreshold = 200 },
		DeathSound = "/SFX/Enemy Sounds/DeadSeaStickler/EmoteDying",
		DeathAnimation = "Enemy_Stickler_Death",
		-- DeathFx = "EnemyDeathFxUndead",

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/DeadSeaStickler/EmoteAlerted",
		Material = "Bone",

		StunAnimations = 
		{
			Default = "Enemy_Stickler_OnHit",
			Heavy = "Enemy_Stickler_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,
		PostAggroAI = "SurroundAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			LeapSound = "/SFX/Enemy Sounds/DeadSeaStickler/EmoteLeaping",
			LeapLandingSound = "/SFX/Enemy Sounds/DeadSeaStickler/EmoteLanding",
			--LeapWhenTargetBeyondDistance = 1400,
			--LeapWhenTargetOutOfSight = true,
			LeapSpeed = 1750,
			LeapPrepareTime = 0.26,
			LeapRecoveryTime = 0.0,
			LeapDistanceMax = 1200,
			LeapDistanceMin = 500,
			LeapChargeAnimation = "Enemy_Stickler_LeapPreFire",
			LeapLandingAnimation = "Enemy_Stickler_LeapLand",

			MaxAttackers = 99,
			SurroundDistance = 9999,
			SurroundRefreshInterval = 0.5,
			SurroundMinTrackTime = 0.5,
		},

		WeaponOptions =
		{
			"SticklerThrow", "SticklerLeap",
		},

		HeraclesCombatMoneyValue = 3,
		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"Stickler_Elite"}
		},

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				-- None
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_2167", Text = "Sticklers." },
			{ Cue = "/VO/MelinoeField_2168", Text = "Sticklers!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2169", Text = "More Sticklers." },
			{ Cue = "/VO/MelinoeField_2170", Text = "Come on, Sticklers!" },
		},

	},

	Stickler_Elite =
	{
		InheritFrom = { "Elite", "Stickler" },
		HealthBuffer = 380,
		IsAggroedSound = "/SFX/Enemy Sounds/DeadSeaStickler/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SticklerThrow_Elite", "SticklerLeapCombo",
		},

		HeraclesCombatMoneyValue = 6,
		GeneratorData =
		{
			DifficultyRating = 135,
			BlockEnemyTypes = {"Stickler"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Stickler )