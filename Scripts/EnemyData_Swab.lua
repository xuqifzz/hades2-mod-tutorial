UnitSetData.Swab =
{

	Swab =
	{
		InheritFrom = { "BaseOEnemy", "BaseVulnerableEnemy" },

		ActivateAnimation = "Enemy_Swab_CannonFly",
		PostActivateAnimation = "Enemy_Swab_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "DustPuffBNoDecal",
		ActivateFxPreSpawnDelay = 0.5,
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0, 
		ActivateDuration = 0.45,
		WakeUpDelay =  1.9,
		ActivateStartOffsetZ = 2000,
		PostActivateStop = true,
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 400 },
		--ActivateGravity = 9000,
		--ActivateFallForce = 2500,
		DeathAnimation = "Enemy_Swab_Death",
		DeathFx = "EnemyDeathFxUndead",
		DeathSound = "/SFX/Enemy Sounds/DeadSeaSwab/EmoteDying",

		MaxHealth = 1030,
		HealthBarOffsetY = -220,

		Groups = { "GroundEnemies" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/DeadSeaSwab/EmoteAlerted",

		StopAnimationsOnDeath = { "SwabShockwaveRingWarning", "SwabShockwaveWarning_Elite" },

		StunAnimations = 
		{
			Default = "Enemy_Swab_OnHit",
			Heavy = "Enemy_Swab_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIAggroRange = 1150,
		EndAIThreadWaitOnFreezeEnd = true,
		InterruptWeaponOnFreeze = true,

		WeaponOptions =
		{
			"SwabSwing",
		},

		HeraclesCombatMoneyValue = 3,
		ActiveCapWeight = 1,
		GeneratorData =
		{
			DifficultyRating = 65,
			BlockEnemyTypes = {"Swab_Elite"}
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

			{ Cue = "/VO/MelinoeField_2175", Text = "Anchors..." },
			{ Cue = "/VO/MelinoeField_2176", Text = "Anchors!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2177", Text = "More Anchors." },
			{ Cue = "/VO/MelinoeField_2178", Text = "More Anchors!" },
		},

	},

	Swab_Elite =
	{
		InheritFrom = { "Elite", "Swab" },
		HealthBuffer = 730,
		IsAggroedSound = "/SFX/Enemy Sounds/DeadSeaSwab/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex", "Metallic" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SwabSwing_Elite",
		},

		HeraclesCombatMoneyValue = 8,
		GeneratorData =
		{
			DifficultyRating = 155,
			BlockEnemyTypes = {"Swab"}
		},
	},

	Swab_Shadow =
	{
		InheritFrom = { "Shadow", "Swab" },
		GenusName = "Swab",

		HealthBuffer = 730,
		StartAggroed = true,
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Swab )