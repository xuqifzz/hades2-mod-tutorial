UnitSetData.Dragon =
{

	Dragon =
	{
		InheritFrom = { "BasePEnemy", "BaseChronosForces", "BaseVulnerableEnemy", },
		
		IntroEncounterName = "DragonIntro",

		ActivateAnimation = "Enemy_Dragon_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0,
		ActivateDuration = 0.55,
		WakeUpDelay = 0.8,
		ActivateStartOffsetZ = 2000,
		PostActivateStop = true,

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args = { CreateAnimation = "OlympusColdBreathEmitter", },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "P_Boss01" },
					},
				},
			},
		},

		DeathAnimation = "Enemy_Dragon_Death",
		DeathSound = "/SFX/Enemy Sounds/Dragon/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/Dragon/EmoteHurt",

		MaxHealth = 1450,
		HealthBarOffsetY = -380,

		Groups = { "FlyingEnemies", "ChronosForces" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/Dragon/EmoteAlerted",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysicalOlympus",
			Rapid = "HitSparkEnemyDamagedPhysicalOlympusRapid",
		},

		StunAnimations = 
		{
			Default = "Enemy_Dragon_OnHit",
			Heavy = "Enemy_Dragon_OnHit_Heavy",
		},

		UniqueIconAttachments = 
		{
			Burn = "Dragon_Rig:root_00_M_JNT",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 1,
		},

		WeaponOptions =
		{
			"DragonTailWhip", "DragonGlide"
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "AttackerAI",

		BlockAttributes = { "Orbit", "Vacuum", },

		HeraclesCombatMoneyValue = 6,
		GeneratorData =
		{
			DifficultyRating = 250,
			BlockEnemyTypes = {"Dragon_Elite"}
		},

		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
				{ Name = "OlympusEnemiesSightedVO", Time = 12 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_2710", Text = "Sky-Dracons..." },
			{ Cue = "/VO/MelinoeField_2711", Text = "Sky-Dracons...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2712", Text = "More Sky-Dracons." },
			{ Cue = "/VO/MelinoeField_2713", Text = "Sky-Dracons again..." },
		},
	},

	Dragon_Elite =
	{
		InheritFrom = { "Elite", "Dragon" },
		HealthBuffer = 930,
		IsAggroedSound = "/SFX/Enemy Sounds/Dragon/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex", "Metallic" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DragonTailWhip", "DragonGlide"
		},

		HeraclesCombatMoneyValue = 12,
		GeneratorData =
		{
			DifficultyRating = 480,
			BlockEnemyTypes = {"Dragon"}
		},
	},

	Dragon_MiniBoss =
	{
		InheritFrom = { "Elite", "Dragon" },
		RunHistoryKilledByName = "Dragon_MiniBoss",
		MaxHealth = 3850,
		HealthBuffer = 10150,
		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -150,
		HealthBarType = "ExtraLarge",
		BlockRaiseDead = true,
		BlockCharm = true,

		StartAggroed = true,

		GrannyTexture = "GR2/DragonMiniboss_Color",
		
		BlockRespawnShrineUpgrade = true,
		IsAggroedSound = "/SFX/Enemy Sounds/DragonMiniboss/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/DragonMiniboss/EmoteHurt",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIAggroRange = 1000,
		WakeUpDelay = 1.0,

		WeaponOptions =
		{
			"DragonBreath_MiniBoss", "DragonTailWhip_Miniboss", "DragonGlide_Miniboss", "DragonWhirlLeft", "DragonWhirlRight"
		},

		GeneratorData =
		{
			DifficultyRating = 1000,
			BlockEnemyTypes = {"Dragon"}
		},
	},

	Dragon_Shadow =
	{
		InheritFrom = { "Shadow", "Dragon" },
		GenusName = "Dragon",
		MaxHealth = 2000,
		HealthBuffer = 4000,
		HealthBarOffsetY = -400,
		HealthBarType = "ExtraLarge",
		BlockCharm = true,

		StartAggroed = true,

		GrannyTexture = "GR2/DragonMiniboss_Color",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DragonBreath_MiniBoss", "DragonTailWhip", "DragonGlide", "DragonWhirlLeft", "DragonWhirlRight"
		},
	},

	Dragon_SuperElite =
	{
		InheritFrom = { "SuperElite", "Dragon" },
		GenusName = "Dragon",
		MaxHealth = 3000,
		HealthBuffer = 6000,
		HealthBarOffsetY = -400,
		HealthBarType = "ExtraLarge",
		BlockCharm = true,

		StartAggroed = true,

		UseActivatePresentation = false,
		WakeUpDelay = 0.0,
		CreateAnimations = { "EnemyPreSpawnTerrainChronosLarge" },

		GrannyTexture = "GR2/DragonMiniboss_Color",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		SpellSummonDataOverrides =
		{
			WeaponOptions =
			{
				"DragonBreath_MiniBoss_Ally"
			},
		},

		WeaponOptions =
		{
			"DragonBreath_MiniBoss", "DragonTailWhip", "DragonGlide", "DragonWhirlLeft", "DragonWhirlRight"
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Dragon )