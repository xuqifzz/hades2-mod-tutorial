UnitSetData.FishSwarmer =
{

	FishSwarmer =
	{
		InheritFrom = { "OceanusUnitData", "BaseVulnerableEnemy","LowPolyEnemy"  },
		ActivateFx = "WaterUnitSurfaceSmall",
		Groups = { "FlyingEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Swarmer/EmoteAlerted",
		Material = "Organic",
		
		ActivateAnimation = "Enemy_FishSwarmer_Spawn",
		IsAggroedSound = "/SFX/Enemy Sounds/FishSwarmer/EmoteAlerted",
		DeathSound = "/SFX/Enemy Sounds/FishSwarmer/EmoteDying",

		DeathAnimation = "Enemy_FishSwarmer_Death",
		DeathFx = "EnemyDeathFxIris_Small",

		MaxHealth = 50,
		HealthBarOffsetY = -100,

		AggroReactionTimeMin = 1.0,
		AggroReactionTimeMax = 1.5,
		PreSpawnAggroReactionTimeMin = 1.0,
		PreSpawnAggroReactionTimeMax = 1.5,
		
		StunAnimations = 
		{
			Default = "Enemy_FishSwarmer_HitStun",
			Heavy = "Enemy_FishSwarmer_HitStun_Heavy",
		},

		AIAggroRange = 900,
		DefaultAIData =
		{
			DeepInheritance = true,
			
			FollowDistance = 40,
			FollowSuccessDistance = 20,

			SoundManagerCap = 38,
			PreAttackSound = "/SFX/Enemy Sounds/FishSwarmer/EmoteCharging",
		},

		MoneyDropOnDeath =
		{
			Chance = 0.25,
			MinParcels = 1,
			MaxParcels = 1,
			MinValue = 1,
			MaxValue = 1,
			ValuePerDifficulty = 0.33,
			ValuePerDifficultyMaxValueVariance = 1.3,
		},

		WeaponOptions =
		{
			"FishSwarmerBite",
		},

		GeneratorData =
		{
			DifficultyRating = 5,
			BlockEnemyTypes = {"FishSwarmer_Elite"}
		},

		-- He is spawned as a Squad
		GameStateRequirements =
		{
			-- RequiredMinBiomeDepth = 999,
		},

		ActiveCapWeight = 0.25,

		AIOptions =
		{
			"AggroAI",
		},
		LeaderDeadAI = "AttackerAI",

		EnemyFirstEncounterVoiceLines =
		{
			UsePlayerSource = true,
			TriggerCooldowns =
			{
				"CombatBeginsLinesPlayedRecently",
			},
			{ Cue = "/VO/MelinoeField_0095", Text = "Pinheads!" },
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

			{ Cue = "/VO/MelinoeField_0094", Text = "Pinheads.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0095", Text = "Pinheads!" },
			{ Cue = "/VO/MelinoeField_0096", Text = "More Pinheads." },
			{ Cue = "/VO/MelinoeField_0097", Text = "Pinheads there." },
		},		
	},

	FishSwarmer_Elite =
	{
		InheritFrom = { "Elite", "FishSwarmer" },
		MaxHealth = 100,
		HealthBuffer = 170,
		HealthBarOffsetY = -250,
		HealthBarType = "Medium",

		IsAggroedSound = "/SFX/Enemy Sounds/FishSwarmer/EmoteAlerted",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"FishSwarmerBiteCombo_Elite",
		},

		-- He is spawned as a Squad
		GameStateRequirements =
		{
			-- RequiredMinBiomeDepth = 999,
		},

		GeneratorData =
		{
			DifficultyRating = 10,
			BlockEnemyTypes = {"FishSwarmer"}
		},
	},

	FishSwarmerSquad =
	{
		IntroEncounterName = "FishSwarmerIntro",
		IsUnitGroup = true,

		SpawnOffset = 50,
		RequiredSpawnPoint = "EnemyPointMelee",

		UnitGroup =
		{
			"FishSwarmer",
			"FishSwarmer",
			"FishSwarmer",
			"FishSwarmer",
			"FishSwarmer",
		},

		GroupAI = "GroupAI",
		--LeaderFx = "SquadLeaderFx",
		DisableLeaderUnitCollision = true,

		GeneratorData =
		{
			DifficultyRating = 16,
			BlockEnemyTypes = {"FishSwarmerSquad_Elite"}
		},
	},

	FishSwarmerSquad_Elite =
	{
		InheritFrom = { "Elite", "FishSwarmerSquad" },

		UnitGroup =
		{
			"FishSwarmer_Elite",
			"FishSwarmer_Elite",
			--"FishSwarmer_Elite",
			--"FishSwarmer_Elite",
			--"FishSwarmer_Elite",
		},

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
		},

		GeneratorData =
		{
			DifficultyRating = 33,
			BlockEnemyTypes = {"FishSwarmerSquad"}
		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.FishSwarmer )