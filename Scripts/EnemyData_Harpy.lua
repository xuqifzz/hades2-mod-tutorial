UnitSetData.Harpy =
{

	HarpyCutter =
	{
		InheritFrom = { "BaseOEnemy", "BaseVulnerableEnemy" },
		IntroEncounterName = "HarpyCutterIntro",

		Groups = { "FlyingEnemies", "ChronosForces" },
		Material = "Organic",
		IsAggroedSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteAlerted",

		ActivateAnimation = "Enemy_HarpyCutter_Swoop",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0, 
		ActivateDuration = 0.6,
		WakeUpDelay = 0.9,
		ActivateStartOffsetZ = 2000,
		PostActivateStop = true,
		ActivateFallForce = -2000,
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 200 },
		DeathSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteDying",
		DeathAnimation = "Enemy_HarpyCutter_Death",
		DeathFx = "EnemyDeathFxUndeadLarge",

		UniqueIconAttachments = 
		{
			Burn = "HarpyTalonCutter_Rig:root_00_M_JNT",
		},

		MaxHealth = 875,
		HealthBarOffsetY = -280,
		HealthBarType = "Medium",

		StunAnimations = 
		{
			Default = "Enemy_HarpyCutter_OnHit",
			Heavy = "Enemy_HarpyCutter_OnHit_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundRetaliateDistance = 450,
			SurroundRefreshInterval = 0.1,
			MaxAttackers = 999,
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,
		PostAggroAI = "SurroundAI",

		WeaponOptions = { "HarpySlice", "HarpyDashRight", "HarpyDashLeft" },

		HeraclesCombatMoneyValue = 4,
		ActiveCapWeight = 0.67,
		GeneratorData =
		{
			DifficultyRating = 75,
			BlockEnemyTypes = {"HarpyCutter_Elite"}
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

			{ Cue = "/VO/MelinoeField_2179", Text = "Talons." },
			{ Cue = "/VO/MelinoeField_2180", Text = "Talons!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2181", Text = "Talons, incoming!" },
			{ Cue = "/VO/MelinoeField_2182", Text = "More Talons!" },
		},

	},

	HarpyCutter_Elite =
	{
		InheritFrom = { "Elite", "HarpyCutter" },
		HealthBuffer = 615,
		IsAggroedSound = "/SFX/Enemy Sounds/HarpyCutter/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Rifts" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions = { "HarpySlice", "HarpyDashRight", "HarpyDashLeft" },

		HeraclesCombatMoneyValue = 8,
		GeneratorData =
		{
			DifficultyRating = 165,
			BlockEnemyTypes = {"HarpyCutter"}
		},
	},

	HarpyDropper =
	{
		InheritFrom = { "BasePEnemy", "BaseChronosForces", "HarpyCutter" },
		IntroEncounterName = "OlympusIntro",
		IneligibleIfUncompletedIntroEncounter = true,

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

		HealthBarType = "MediumLarge",
		HealthBarOffsetY = -325,

		MaxHealth = 890,

		IsAggroedSound = "/SFX/Enemy Sounds/HarpyDropper/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/HarpyDropper/EmoteDying",

		StunAnimations = 
		{
			Default = "Enemy_HarpyDropper_OnHit",
			Heavy = "Enemy_HarpyDropper_OnHit_Heavy",
		},
		DefaultAIData =
		{
			DeepInheritance = true,
			SurroundRefreshInterval = 0.5,
		},
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysicalOlympus",
			Rapid = "HitSparkEnemyDamagedPhysicalOlympusRapid",
		},
		WeaponOptions = { "HarpySlice2", "HarpyFlapFast", "HarpyDashRight", "HarpyDashLeft", },

		HeraclesCombatMoneyValue = 2,
		GeneratorData =
		{
			DifficultyRating = 90,
			BlockEnemyTypes = {"HarpyDropper_Elite"}
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
				{ Name = "OlympusEnemiesSightedVO", Time = 12 },
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_2706", Text = "Raptors..." },
			{ Cue = "/VO/MelinoeField_2707", Text = "Raptors there...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2708", Text = "More Raptors..." },
			{ Cue = "/VO/MelinoeField_2709", Text = "Blasted Raptors..." },
		},
		{ GlobalVoiceLines = "ChronosLegionsSightedVoiceLines" },
	},

	HarpyDropper_Elite =
	{
		InheritFrom = { "Elite", "HarpyDropper" },
		HealthBuffer = 750,
		IsAggroedSound = "/SFX/Enemy Sounds/HarpyDropper/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Rifts" }),

		HealthBarOffsetY = -350,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions = { "HarpySlice2", "HarpyFlapFast_Elite", "HarpyDashRight", "HarpyDashLeft", },

		HeraclesCombatMoneyValue = 5,
		GeneratorData =
		{
			DifficultyRating = 190,
			BlockEnemyTypes = {"HarpyDropper"}
		},
	},

	HarpyDropper_MiniBoss =
	{
		InheritFrom = { "Elite", "HarpyDropper" },
		HealthBuffer = 1000,
		IsAggroedSound = "/SFX/Enemy Sounds/HarpyDropper/EmoteTaunting",

		HealthBarOffsetY = -350,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions = { "HarpySlice2", "HarpyFlap_Elite", "HarpyDashRight", "HarpyDashLeft",
							 "HarpyWind_Elite",  "HarpyWind_Elite" },

		HeraclesCombatMoneyValue = 8,
		GeneratorData =
		{
			DifficultyRating = 225,
			BlockEnemyTypes = {"HarpyDropper"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Harpy )