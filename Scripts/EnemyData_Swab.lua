UnitSetData.Swab =
{

	Swab =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

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
		--PostActivateDuration = 1.9,
		WakeUpDelay =  1.9,
		ActivateStartOffsetZ = 2000,
		PostActivateStop = true,
		--ActivateGravity = 9000,
		--ActivateFallForce = 2500,
		DeathSound = "/SFX/Enemy Sounds/DeadSeaSwab/EmoteDying",

		MaxHealth = 730,
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
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = GameData.BannedEnemySightedEncounters,
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
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
		HealthBuffer = 660,
		IsAggroedSound = "/SFX/Enemy Sounds/DeadSeaSwab/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SwabSwing_Elite",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		HeraclesCombatMoneyValue = 8,
		GeneratorData =
		{
			DifficultyRating = 155,
			BlockEnemyTypes = {"Swab"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Swab )