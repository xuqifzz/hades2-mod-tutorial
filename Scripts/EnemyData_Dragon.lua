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

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 1,
		},

		WeaponOptions =
		{
			"DragonBreath", "DragonTailWhip", "DragonGlide"
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "AttackerAI",

		HeraclesCombatMoneyValue = 6,
		GeneratorData =
		{
			DifficultyRating = 230,
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
			},
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

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DragonBreath", "DragonTailWhip", "DragonGlide"
		},

		HeraclesCombatMoneyValue = 12,
		GeneratorData =
		{
			DifficultyRating = 440,
			BlockEnemyTypes = {"Dragon"}
		},
	},

	Dragon_MiniBoss =
	{
		InheritFrom = { "Elite", "Dragon" },
		MaxHealth = 4200,
		HealthBuffer = 10650,
		HealthBarOffsetY = -400,
		HealthBarType = "ExtraLarge",
		BlockRaiseDead = true,
		BlockCharm = true,
		ImmuneToPolymorph = true,

		GrannyTexture = "GR2/DragonMiniboss_Color",
		
		BlockRespawnShrineUpgrade = true,
		IsAggroedSound = "/SFX/Enemy Sounds/DragonMiniboss/EmoteDying",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIAggroRange = 1000,
		WakeUpDelay = 1.5,

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
		ImmuneToPolymorph = true,
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
}

OverwriteTableKeys( EnemyData, UnitSetData.Dragon )