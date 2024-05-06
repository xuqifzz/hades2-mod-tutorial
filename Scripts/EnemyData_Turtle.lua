UnitSetData.Turtle =
{
	
	Turtle =
	{
		InheritFrom = { "OceanusUnitData", "BaseVulnerableEnemy" },
		IntroEncounterName = "TurtleIntro",

		ActivateAnimation = "Enemy_Turtle_Spawn",

		MaxHealth = 240,

		Material = "Stone",
		OnHitFunctionName = "CheckUnitInvulnerableHit",
		InvulnerableHitFx = "TurtleInvincibubbleHit",
		InvulnerableHitImpactVelocity = 1000,

		IsAggroedSound = "/SFX/Enemy Sounds/Turtle/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Turtle/EmoteDying",
		DeathAnimation = "EnemyDeathFx_Medium",
		DeathFx = "EnemyDeathFxFish",

		StunAnimations = 
		{
			Default = "Enemy_Turtle_HitStun",
			Heavy = "Enemy_Turtle_HitStun_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1300,
		PostAggroAI = "AttackerAI",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		MoneyDropOnDeath =
		{
			Chance = 0.7,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.2,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		WeaponOptions =
		{
			"TurtleBounceLob", "TurtleHide", "TurtleClaw",
		},

		GeneratorData =
		{
			DifficultyRating = 55,
			BlockEnemyTypes = {"Turtle_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0545", Text = "Shellbacks!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = { "ArachneCombatG" },
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_0544", Text = "Shellbacks.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0545", Text = "Shellbacks!" },
			{ Cue = "/VO/MelinoeField_0546", Text = "More Shellbacks." },
			{ Cue = "/VO/MelinoeField_0547", Text = "Shellbacks again." },
		},
	},

	Turtle_Elite =
	{
		InheritFrom = { "Elite", "Turtle" },
		HealthBuffer = 230,

		IsAggroedSound = "/SFX/Enemy Sounds/Turtle/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		WeaponOptions =
		{
			"TurtleBounceLobElite", "TurtleHide", "TurtleClaw",
		},

		GeneratorData =
		{
			DifficultyRating = 89,
			BlockEnemyTypes = {"Turtle"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Turtle )