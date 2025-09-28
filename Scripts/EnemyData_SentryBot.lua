UnitSetData.SentryBot =
{

	SentryBot =
	{
		InheritFrom = { "BasePEnemy", "BaseAutomaton", "BaseVulnerableEnemy", },
		
		IntroEncounterName = "OlympusIntro",

		MaxHealth = 470,
		HealthBarOffsetY = -160,
		HealthBarType = "Medium",

		Groups = { "FlyingEnemies", "Automatons" },

		Material = "Robot",
		MaterialAlt = "Stone",
		OnHitFunctionName = "CheckUnitInvulnerableHit",
		InvulnerableHitFx = "InvincibleHitSpark",
		InvulnerableHitImpactVelocity = 1000,

		ActivateAnimation = "Enemy_SentryBot_Spawn",
		ActivateFadeIn = true,
		ActivateTint = false,
		ActivateFadeInDuration = 0,
		ActivateStartAlpha = 1,
		ActivateFadeInDelay = 0,
		
		ActivateFx = "OlympusEnemySpawnSigilDark_Small",
		ActivateFx2 = "OlympusEnemySpawnSigil_Small",
		ActivateFxPreSpawn = "OlympusEnemyActivationFx_Small",

		IsAggroedSound = "/SFX/Enemy Sounds/SentryBot/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/SentryBot/EmoteDying",

		DeathAnimation = "Enemy_SentryBot_Shutdown",

		BlockNextBiomeEnemyShrineUpgrade = true,

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetal",
			Rapid = "HitSparkEnemyDamagedMetalRapid",
		},
		StunAnimations = 
		{
			Default = "Enemy_SentryBot_OnHit",
			Heavy = "Enemy_SentryBot_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundDistance = 750,
			MaintainSurroundDistance = true,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 4,
		},

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"SentryBotBurst", "SentryBotVent",
			"SentryBotBurst_AmbientBattle",
		},

		HeraclesCombatMoneyValue = 1,
		ActiveCapWeight = 0.25,
		GeneratorData =
		{
			DifficultyRating = 55,
			BlockEnemyTypes = {"SentryBot_Elite"}
		},

		EnemySightedVoiceLines =
		{
			{
				RandomRemaining = true,
				UsePlayerSource = true,
				GameStateRequirements = 
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
						IsNone = { "OlympusIntro" },
					},
				},
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
					{ Name = "OlympusEnemiesSightedVO", Time = 12 },
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", },
				SuccessiveChanceToPlay = 0.1,

				{ Cue = "/VO/MelinoeField_2690", Text = "Auto-Seekers..." },
				{ Cue = "/VO/MelinoeField_2691", Text = "Auto-Seekers...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2692", Text = "More Auto-Seekers." },
				{ Cue = "/VO/MelinoeField_2693", Text = "Auto-Seekers again." },
			},
			{ GlobalVoiceLines = "AutomatonsSightedLines" },
		},

	},

	SentryBot_Elite =
	{
		InheritFrom = { "Elite","SentryBot" },

		HealthBuffer = 410,

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Homing" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SentryBotBurst_Elite", "SentryBotVent",
			"SentryBotBurst_AmbientBattle",
		},

		HeraclesCombatMoneyValue = 2,
		GeneratorData =
		{
			DifficultyRating = 95,
			BlockEnemyTypes = {"SentryBot"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.SentryBot )