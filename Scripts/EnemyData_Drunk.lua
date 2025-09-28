UnitSetData.Drunk =
{

	Drunk =
	{
		InheritFrom = { "BaseOEnemy", "BaseVulnerableEnemy" },
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
		PostActivateStop = true,
		--ActivateGravity = 9000,
		--ActivateFallForce = 2500,
		PostActivateScreenshake = { Distance = 3, Speed = 200, FalloffSpeed = 0, Duration = 0.18, Angle = 90, DistanceThreshold = 200 },
		DeathSound = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteDying",
		DeathAnimation = "Enemy_Drunk_Death",
		DeathFx = "EnemyDeathFxUndead",

		MaxHealth = 490,
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
		PostAggroAI = "SurroundAI",

		DefaultAIData =
		{
			DeepInheritance = true,

			MaintainSurroundDistance = false,
			SurroundDistance = 550,
			SurroundRefreshInterval = 0.2,
			MaxAttackers = 4,
		},

		WeaponOptions =
		{
			"DrunkStab", 
			"DrunkSwingLeft", "DrunkSwingRight", 
			"DrunkSwingLeft", "DrunkSwingRight", 
			"DrunkBarrel",
		},

		HeraclesCombatMoneyValue = 3,
		GeneratorData =
		{
			DifficultyRating = 50,
			BlockEnemyTypes = {"Drunk_Elite"}
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

			{ Cue = "/VO/MelinoeField_2171", Text = "Boozers." },
			{ Cue = "/VO/MelinoeField_2172", Text = "Boozers!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_2173", Text = "More Boozers." },
			{ Cue = "/VO/MelinoeField_2174", Text = "More Boozers!" },
		},

	},

	Drunk_Elite =
	{
		InheritFrom = { "Elite", "Drunk" },
		HealthBuffer = 490,
		IsAggroedSound = "/SFX/Enemy Sounds/DeadSeaDrunk/EmoteTaunting",

		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Rifts" }),

		DefaultAIData =
		{
			DeepInheritance = true,
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