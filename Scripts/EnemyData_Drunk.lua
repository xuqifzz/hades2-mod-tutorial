UnitSetData.Drunk =
{

	Drunk =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		IntroEncounterName = "DrunkIntro",

		ActivateAnimation = "Enemy_Drunk_InBarrel",
		PostActivateAnimation = "Enemy_Drunk_Spawn",
		ActivateFx = "nil",
		ActivateFx2 = "nil",
		ActivateFxPreSpawn = "DustPuffBNoDecal",
		ActivateFxPreSpawnDelay = 0.5,
		ActivateTint = false,
		ActivateFadeIn = false,
		ActivateStartAlpha = 1.0, 
		ActivateDuration = 0.5,
		ActivateStartOffsetZ = 2000,
		--PostActivateDuration = 1.1,
		PostActivateStop = true,
		--ActivateGravity = 9000,
		--ActivateFallForce = 2500,
		DeathSound = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteDying",

		MaxHealth = 480,
		HealthBarOffsetY = -200,
		HealthBarType = "Medium",
		
		--AggroAnimation = "Enemy_Drunk_Spawn"
		--AggroDuration = 1.0,

		Groups = { "GroundEnemies" },
		Material = "Bone",
		IsAggroedSound = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteAlerted",

		StunAnimations = 
		{
			Default = "Enemy_Drunk_OnHit",
			Heavy = "Enemy_Drunk_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"DrunkStab", "DrunkSwingLeft", "DrunkSwingRight",
		},

		HeraclesCombatMoneyValue = 3,
		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"Drunk_Elite"}
		},

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_2172", Text = "Boozers!" },
		},
		EnemySightedVoiceLines =
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsNone = GameData.BannedEnemySightedEncounters,
				},
			},
			Cooldowns =
			{
				{ Name = "CombatBeginsLinesPlayedRecently", Time = 300 },
			},
			SuccessiveChanceToPlay = 0.1,

			{ Cue = "/VO/MelinoeField_2171", Text = "Boozers.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2172", Text = "Boozers!" },
			{ Cue = "/VO/MelinoeField_2173", Text = "More Boozers." },
			{ Cue = "/VO/MelinoeField_2174", Text = "More Boozers!" },
		},

	},

	Drunk_Elite =
	{
		InheritFrom = { "Elite", "Drunk" },
		HealthBuffer = 460,
		IsAggroedSound = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteTaunting",

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
			"DrunkStab_Elite", "DrunkSwingLeft_Elite", "DrunkSwingRight_Elite",
		},

		HeraclesCombatMoneyValue = 5,
		GeneratorData =
		{
			DifficultyRating = 105,
			BlockEnemyTypes = {"Drunk"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.Drunk )