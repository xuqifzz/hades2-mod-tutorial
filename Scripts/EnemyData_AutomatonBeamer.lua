UnitSetData.AutomatonBeamer =
{

	AutomatonBeamer =
	{
		InheritFrom = { "BasePEnemy", "BaseAutomaton", "BaseVulnerableEnemy", },
		
		IntroEncounterName = "OlympusIntro",

		MaxHealth = 1250,
		HealthBarOffsetY = -225,

		Groups = { "FlyingEnemies", "Automatons" },

		Material = "Stone",
		OnHitFunctionName = "CheckUnitInvulnerableHit",
		InvulnerableHitFx = "InvincibleHitSpark",
		InvulnerableHitImpactVelocity = 1000,

		ActivateAnimation = "Enemy_Beamer_Spawn",
		ActivateFadeIn = true,
		ActivateTint = false,
		ActivateFadeInDuration = 0,
		ActivateStartAlpha = 1,
		ActivateFadeInDelay = 0,
		ActivateFadeInDuration = 0,
		
		ActivateFx = "OlympusEnemySpawnSigilDark",
		ActivateFx2 = "OlympusEnemySpawnSigil",
		ActivateFxPreSpawn = "OlympusEnemyActivationFx",
		DeathAnimation = "Enemy_Beamer_Death",
		DeathFx = "EnemyBeamerDeathFx",

		IsAggroedSound = "/SFX/Enemy Sounds/AutomatonBeamer/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/AutomatonBeamer/EmoteDying",

		StopAnimationsOnDeath = { "AutomatonBeamerDefenseShieldFxIn", "AutomatonBeamerDefenseShieldFx", "AutomatonBeamerDefenseShieldBacking", "AutomatonBeamerDefenseShieldFxDisplacement" },
		StopAnimationsOnPolymorph =
		{
			"Enemy_Beamer_DefenseLoop ", "AutomatonBeamerScanCharge", "AutomatonBeamerScanChargeStreaks",
		 	"AutomatonBeamerDefenseShieldFxIn", "AutomatonBeamerDefenseShieldFx", "AutomatonBeamerDefenseShieldFxDisplacement", "AutomatonBeamerDefenseShieldFxDisplacementOut", "AutomatonBeamerDefenseShieldBacking", "AutomatonBeamerDefenseShieldBackingOut", "AutomatonBeamerDefenseShieldFxOut"
		},

		StunAnimations = 
		{
			Default = "Enemy_Beamer_OnHit",
			Heavy = "Enemy_Beamer_OnHit_Heavy",
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			
			AmbientBattleTargetGroups = { "ChronosForces" },

			SurroundDistance = 800,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 99,
		},

		WeaponOptions =
		{
			"AutomatonBeamForward", "AutomatonBeamForward", "AutomatonBeamForward", "AutomatonBeamerScan", 
		},
		OnDamagedWeaponInterrupt = "AutomatonBeamerDefense",
		OnDamagedWeaponCooldown = 10.0,

		AIOptions =
		{
			"AggroAI",
		},
		PostAggroAI = "SurroundAI",

		HeraclesCombatMoneyValue = 3,
		GeneratorData =
		{
			DifficultyRating = 130,
			BlockEnemyTypes = {"AutomatonBeamer_Elite"}
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
				},
				SuccessiveChanceToPlay = 0.1,

				{ Cue = "/VO/MelinoeField_2694", Text = "Auto-Watchers..." },
				{ Cue = "/VO/MelinoeField_2695", Text = "Auto-Watchers...!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2696", Text = "More Auto-Watchers." },
				{ Cue = "/VO/MelinoeField_2697", Text = "More Auto-Watchers?" },
			},
			[2] = { GlobalVoiceLines = "AutomatonsSightedLines" },
		},
	},

	AutomatonBeamer_Elite =
	{
		InheritFrom = { "Elite", "AutomatonBeamer" },
		HealthBuffer = 1250,

		IsAggroedSound = "/SFX/Enemy Sounds/AutomatonBeamer/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"AutomatonBeamForward_Elite", "AutomatonBeamerScan",
		},

		HeraclesCombatMoneyValue = 7,
		GeneratorData =
		{
			DifficultyRating = 255,
			BlockEnemyTypes = {"AutomatonBeamer"}
		},
	},

	AutomatonBeamer_Shadow =
	{

		InheritFrom = { "Shadow", "AutomatonBeamer" },
		GenusName = "AutomatonBeamer",

		HealthBuffer = 1650,
		StartAggroed = true,
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.AutomatonBeamer )