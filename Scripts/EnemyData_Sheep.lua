UnitSetData.Sheep =
{
	Sheep =
	{
		InheritFrom = { "IsNeutral", "BaseVulnerableEnemy" },
		RequiredKill = false,

		MaxHealth = 99999,
		HideHealthBar = true,

		UseActivatePresentation = false,

		OnDeathThreadedFunctionName = "SpawnSheepGhost",

		OnDamagedFunctionName = "SheepHit",
		SheepHitVelocity = 1500,
		IsAggroedSound = "/SFX/Enemy Sounds/Sheep/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/Sheep/EmoteDying",
   		DeathAnimation = "Blank",
   		DeathFx = "SheepDisappearFx",
		Material = "Organic",

		CollisionReactions = {},

		StunAnimations = 
		{
			Default = "Enemy_Sheep_OnHit",
			Heavy = "Enemy_Sheep_OnHit_Heavy",
		},

		DefaultAIData = {
			DeepInheritance = true,

			LiveOffsetDistance = 100,

			PostMoveIdleDuration = 3.0,

			ExitMapAfterDuration = 10.0,
		},

		AIOptions =
		{
			"SheepAI",
		},

		--WeaponOptions = { "SheepSkip" },
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.33,
			ObjectType = "Polyphemus",
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 25 },
				{ Name = "CyclopsSpokeAboutSheepRecently", Time = 40 },
			},

			{ Cue = "/VO/Polyphemus_0202", Text = "My sheep...!" },
			{ Cue = "/VO/Polyphemus_0203", Text = "Stay out of this, sheep!" },
			{ Cue = "/VO/Polyphemus_0204", Text = "You scared my sheep..." },
			{ Cue = "/VO/Polyphemus_0205", Text = "I smell sheep..." },
			{ Cue = "/VO/Polyphemus_0206", Text = "Get out of here, sheep!" },
			{ Cue = "/VO/Polyphemus_0207", Text = "{#Emph}Augh{#Prev}, those sheep..." },
		},
	},

	Sheep_Zombie =
	{
		InheritFrom = { "Sheep" },
		IsAggroedSound = "/SFX/Enemy Sounds/SheepZombie/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/SheepZombie/EmoteDying",

		WeaponOptions = { "SheepRam" },

		AIOptions =
		{
			"AttackerAI",
		},

		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.33,
			ObjectType = "Polyphemus",
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 25 },
				{ Name = "CyclopsSpokeAboutSheepRecently", Time = 40 },
			},

			{ Cue = "/VO/Polyphemus_0291", Text = "Sounds like the sheep got into something, huh." },
			{ Cue = "/VO/Polyphemus_0294", Text = "The sheep smell worse than usual..." },
			{ Cue = "/VO/Polyphemus_0296", Text = "Those are some smelly sheep." },
			{ Cue = "/VO/Polyphemus_0297", Text = "What's with the sheep tonight?" },
		},
	},

	Sheep_Explosive =
	{
		InheritFrom = { "Sheep" },
		IsAggroedSound = "/SFX/Enemy Sounds/SheepExploding/EmoteAlerted",
		-- DeathSound = "/SFX/Enemy Sounds/SheepExploding/EmoteDying",

		WeaponOptions = { "SheepExplode" },

		AIOptions =
		{
			"AttackAndDie",
		},

		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.33,
			ObjectType = "Polyphemus",
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 25 },
				{ Name = "CyclopsSpokeAboutSheepRecently", Time = 40 },
			},

			{ Cue = "/VO/Polyphemus_0299", Text = "Sheep gonna have a real blast." },
			{ Cue = "/VO/Polyphemus_0300", Text = "Why don't ya pet the sheep?", PlayFirst = true },
			{ Cue = "/VO/Polyphemus_0301", Text = "Go get her, sheep!" },
			{ Cue = "/VO/Polyphemus_0302", Text = "The sheep don't like you on our turf..." },
		},
	},

	Sheep_Sick =
	{
		InheritFrom = { "Sheep" },
		IsAggroedSound = "/SFX/Enemy Sounds/SheepSick/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/SheepSick/EmoteDying",

		DumbFireWeapons =
		{
			"SheepSickAura"
		},

		WeaponOptions = { "SheepSickSkip" },

		AIOptions =
		{
			"AttackerAI",
		},

		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.65,
			SuccessiveChanceToPlay = 0.33,
			ObjectType = "Polyphemus",
			Cooldowns =
			{
				{ Name = "CyclopsSpokeRecently", Time = 25 },
				{ Name = "CyclopsSpokeAboutSheepRecently", Time = 40 },
			},

			{ Cue = "/VO/Polyphemus_0295", Text = "You made my sheep all sick." },
			{ Cue = "/VO/Polyphemus_0292", Text = "Sheep aren't feeling so hot." },
			{ Cue = "/VO/Polyphemus_0293", Text = "Poor sheep are sick again." },
			{ Cue = "/VO/Polyphemus_0298", Text = "The sheep got into something bad." },
		},
	},

	Sheep_Passive =
	{
		InheritFrom = { "Sheep" },
		AllowHarvestWhileAggored = true,
		AllowInteractWhileAggroed = true,

		WeaponOptions = { "SheepSkip" },

		AIAggroRange = 0,

		AIOptions =
		{
			"AggroAI",
		},
	},
	Pig_Passive =
	{
		InheritFrom = { "Sheep" },
		AllowHarvestWhileAggored = true,
		AllowInteractWhileAggroed = true,

		WeaponOptions = { "SheepSkip" },
		SheepHitVelocity = 750,
		IsAggroedSound = "/SFX/Object Ambiences/PigSFXOnHit",

		AIAggroRange = 0,

		AIOptions =
		{
			"AggroAI",
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Sheep )