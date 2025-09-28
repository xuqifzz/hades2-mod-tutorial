UnitSetData.AutomatonEnforcer =
{

	AutomatonEnforcer =
	{
		InheritFrom = { "BasePEnemy", "BaseAutomaton", "BaseVulnerableEnemy", },
		
		IntroEncounterName = "OlympusIntro",

		MaxHealth = 1350,
		HealthBarOffsetY = -250,

		ActivateAnimation = "Enemy_Enforcer_Spawn",
		ActivateFadeIn = true,
		ActivateTint = false,
		ActivateFadeInDuration = 0,
		ActivateStartAlpha = 1,
		ActivateFadeInDelay = 0,
		
		ActivateFx = "OlympusEnemySpawnSigilDark_Medium",
		ActivateFx2 = "OlympusEnemySpawnSigil_Medium",
		ActivateFxPreSpawn = "OlympusEnemyActivationFx_Medium",

		DeathAnimation = "Enemy_Enforcer_Death",
		DeathFx = "EnemyEnforcerDeathFx",
		
		IsAggroedSound = "/SFX/Enemy Sounds/AutomatonEnforcer/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/AutomatonEnforcer/EmoteDying",

		Groups = { "FlyingEnemies", "Automatons" },
		Material = "Robot",
		MaterialAlt = "Stone",

		BlockNextBiomeEnemyShrineUpgrade = true,

		StunAnimations = 
		{
			Default = "Enemy_Enforcer_OnHit",
			Heavy = "Enemy_Enforcer_OnHit_Heavy",
		},

		--OnDamagedWeaponInterrupt = "AutomatonEnforcerBoost",
		--OnDamagedWeaponCooldown = 999.0,

		PreAttackFunctionName = "WeaponSetImmuneToStun",
		PostAttackFunctionName = "WeaponRevertStunImmunity",

		DefaultAIData =
		{
			DeepInheritance = true,

			DoNotRepeatOnAttackFail = true,
		},

		AIOptions =
		{
			"AggroAI",
		},

		WeaponOptions =
		{
			"AutomatonEnforcerSlash", "AutomatonEnforcerWhirlwind",
			"AutomatonEnforcerSlash_AmbientBattle",
		},

		BlockAttributes = { "Orbit", "Vacuum", },

		HeraclesCombatMoneyValue = 4,
		GeneratorData =
		{
			DifficultyRating = 150,
			BlockEnemyTypes = {"AutomatonEnforcer_Elite"}
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

				{ Cue = "/VO/MelinoeField_2698", Text = "Auto-Forcers..." },
				{ Cue = "/VO/MelinoeField_2699", Text = "Auto-Forcers...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2700", Text = "More Auto-Forcers." },
				{ Cue = "/VO/MelinoeField_2701", Text = "Auto-Forcers, blast..." },
			},
			{ GlobalVoiceLines = "AutomatonsSightedLines" },
		},
	},

	AutomatonEnforcer_Elite =
	{
		InheritFrom = { "Elite", "AutomatonEnforcer" },
		HealthBuffer = 995,
		IsAggroedSound = "/SFX/Enemy Sounds/AutomatonEnforcer/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Rifts" }),

		WeaponOptions =
		{
			"AutomatonEnforcerSlash_Elite", "AutomatonEnforcerWhirlwind_Elite",
			"AutomatonEnforcerSlash_AmbientBattle",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		HeraclesCombatMoneyValue = 7,
		GeneratorData =
		{
			DifficultyRating = 280,
			BlockEnemyTypes = {"AutomatonEnforcer"}
		},
	},

	AutomatonEnforcer_Fiend =
	{

		InheritFrom = { "AutomatonEnforcer_Elite" },
		GenusName = "AutomatonEnforcer",

		Health = 1500,
		HealthBuffer = 1500,

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		GeneratorData =
		{
			DifficultyRating = 300,
		},
	},

	AutomatonEnforcer_Shadow =
	{

		InheritFrom = { "Shadow", "AutomatonEnforcer" },
		GenusName = "AutomatonEnforcer",

		HealthBuffer = 995,
		StartAggroed = true,
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.AutomatonEnforcer )