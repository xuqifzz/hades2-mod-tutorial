UnitSetData.Turtle =
{
	
	Turtle =
	{
		InheritFrom = { "OceanusUnitData", "BaseVulnerableEnemy" },
		IntroEncounterName = "TurtleIntro",

		GameStateRequirements =
		{
			{
				Path = { "GameState", "RoomCountCache", "G_Intro" },
				Comparison = ">=",
				Value = 2,
			},
		},

		ActivateAnimation = "Enemy_Turtle_Spawn",

		MaxHealth = 240,

		Material = "Stone",
		OnHitFunctionName = "CheckUnitInvulnerableHit",
		InvulnerableHitFx = "TurtleInvincibubbleHit",
		InvulnerableHitImpactVelocity = 1000,
		InvulnerableHitFlash = true,
		InvulnerableBlockHint = true,

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
		PostAggroAI = "SurroundAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundRetaliateDistance = 370,
			MaxAttackers = 99, -- Let them claw when too many are lobbing
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
			"TurtleBounceLob", "TurtleHide", "TurtleClaw", "TurtleClawRush"
		},

		GeneratorData =
		{
			DifficultyRating = 55,
			BlockEnemyTypes = {"Turtle_Elite"}
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

			{ Cue = "/VO/MelinoeField_0544", Text = "Shellbacks." },
			{ Cue = "/VO/MelinoeField_0545", Text = "Shellbacks!", PlayFirst = true },
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

		WeaponOptions =
		{
			"TurtleBounceLobElite", "TurtleHide", "TurtleClaw", "TurtleClawRush"
		},

		GeneratorData =
		{
			DifficultyRating = 89,
			BlockEnemyTypes = {"Turtle"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Turtle )