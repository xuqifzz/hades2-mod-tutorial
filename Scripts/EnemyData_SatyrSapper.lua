UnitSetData.SatyrSapper =
{
	SatyrSapper =
	{
		InheritFrom = { "BasePEnemy", "BaseChronosForces", "BaseVulnerableEnemy", },
		
		--IntroEncounterName = "SapperIntro",

		ActivateAnimation = "Enemy_SatyrSapper_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "nil",
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0, 
		ActivateDuration = 0.55,
		WakeUpDelay = 1.3,
		ActivateStartOffsetZ = 2000,
		PostActivateStop = true,

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args = { CreateAnimation = "OlympusColdBreathEmitterLarge", },
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

		DeathAnimation = "Enemy_SatyrSapper_Death",
		-- DeathFx = "EnemyDeathFxUndeadLarge",

		MaxHealth = 1530,
		HealthBarOffsetY = -310,
		HealthBarType = "Large",

		Groups = { "ChronosForces", "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrSapper/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/SatyrSapper/EmoteDying",
		Material = "Bone",
		HitSparkScale = 1.5,

		DefaultAIData =
		{
			DeepInheritance = true,

			AmbientBattleTargetGroups = { "Automatons" },

			SurroundRetaliateDistance = 400,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 2,
		},
		OnDamagedWeaponInterrupt = "SatyrSapperBackDash",
		OnDamagedWeaponCooldown = 5.0,
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysicalOlympus",
			Rapid = "HitSparkEnemyDamagedPhysicalOlympusRapid",
		},
		StunAnimations = 
		{
			Default = "Enemy_SatyrSapper_OnHit",
			Heavy = "Enemy_SatyrSapper_OnHit_Heavy",
		},

		InvulnerableFx = "SatyrShielded",
		InvulnerableHitFx = "SatyrShieldBlock",

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 780,
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"SatyrSapperBackDash", "SatyrSapperMelee", "SatyrSapperRocket", "SatyrSapperLob"
		},

		HeraclesCombatMoneyValue = 2,
		ActiveCapWeight = 1,
		GeneratorData =
		{
			DifficultyRating = 105,
			BlockEnemyTypes = {"SatyrSapper_Elite"}
		},

		EnemySightedVoiceLines =
		{
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
				SuccessiveChanceToPlay = 0.1,

				{ Cue = "/VO/MelinoeField_2702", Text = "Sappers..." },
				{ Cue = "/VO/MelinoeField_2703", Text = "Sappers...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2704", Text = "More Sappers." },
				{ Cue = "/VO/MelinoeField_2705", Text = "More Sappers?" },
			},
			{ GlobalVoiceLines = "ChronosLegionsSightedVoiceLines" },
			{ GlobalVoiceLines = "SatyrsSightedVoiceLines" },
		},
	},

	SatyrSapper_Elite =
	{
		InheritFrom = { "Elite", "SatyrSapper" },
		HealthBuffer = 1130,
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrSapper/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrSapperBackDash", "SatyrSapperMelee", "SatyrSapperRocket_Elite", "SatyrSapperLob"
		},

		HeraclesCombatMoneyValue = 7,
		GeneratorData =
		{
			DifficultyRating = 280,
			BlockEnemyTypes = {"SatyrSapper"}
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SatyrSapper )