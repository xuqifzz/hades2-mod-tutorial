UnitSetData.SatyrRatCatcher =
{
	SatyrRatCatcher =
	{
		InheritFrom = { "BaseVulnerableEnemy" },

		MaxHealth = 1000,
		HealthBarOffsetY = -250,
		HealthBarType = "Large",
		ArmorSparkAnimation = "HitSparkArmor_Large",		

		ActivateAnimation = "Enemy_SatyrRatCatcher_Spawn",
		ActivateFx = "EnemyPreSpawnTerrainChronosLarge",
		ActivateFx2 = "EnemyPreSpawnStandingLargeChronos",
		ActivateFxPreSpawn = "EnemySpawnBurstLargeChronos",
		DeathAnimation = "Enemy_SatyrRatCatcher_Death",
		DeathFx = "EnemyDeathFxChronos",

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteHurt",
		Material = "Bone",

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveSuccessDistance = 125,

			MaintainSurroundDistance = true,
			SurroundDistance = 750,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 2,
		},
		
		StunAnimations = 
		{
			Default = "Enemy_SatyrRatCatcher_OnHit",
			Heavy = "Enemy_SatyrRatCatcher_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 780,
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"SatyrRatCatcherSummon", "SatyrRatCatcherCast", "SatyrRatCatcherMelee",
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"SatyrRatCatcherCast", "SatyrRatCatcherMelee",
			},
		},

		ActiveCapWeight = 2.5, -- to account for crawlers
		GeneratorData =
		{
			DifficultyRating = 110,
			BlockEnemyTypes = {"SatyrRatCatcher_Elite"}
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

				{ Cue = "/VO/MelinoeField_1639", Text = "Vierophants...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1640", Text = "Vierophants...!" },
				{ Cue = "/VO/MelinoeField_1641", Text = "More Vierophants." },
				{ Cue = "/VO/MelinoeField_1642", Text = "More Vierophants?" },
			},
			{ GlobalVoiceLines = "SatyrsSightedVoiceLines" },
		},

	},

	SatyrRatCatcher_Elite =
	{
		InheritFrom = { "Elite", "SatyrRatCatcher" },
		HealthBuffer = 850,
		IsAggroedSound = "/SFX/Enemy Sounds/SatyrRatcatcher/EmoteTaunting",
		
		EliteAttributeOptions = CombineTables(EnemySets.GenericEliteAttributes, { "Hex" }),

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrRatCatcherSummon_Elite", "SatyrRatCatcherCast_Elite", "SatyrRatCatcherMelee",
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			WeaponOptions =
			{
				"SatyrRatCatcherCast_Elite", "SatyrRatCatcherMelee",
			},
		},

		GeneratorData =
		{
			DifficultyRating = 280,
			BlockEnemyTypes = {"SatyrRatCatcher"},
		},
	},

	SatyrRatCatcher_Miniboss =
	{
		InheritFrom = { "Elite", "SatyrRatCatcher" },
		RunHistoryKilledByName = "SatyrRatCatcher_Miniboss",

		MaxHealth = 3200,
		HealthBuffer = 5000,
		HealthBarAttachToMarkerName = "head_fxMarker_00_M_JNT",
		HealthBarOffsetY = -100,
		HealthBarType = "Large",

		IsAggroedSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteTaunting",
		DeathSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteDying",
		HealthDamageSound = "/SFX/Enemy Sounds/SatyrRatcatcherMiniboss/EmoteHurt",

		BlockRespawnShrineUpgrade = true,

		ForcedNextWeapon = "SatyrRatCatcherSummon_Miniboss",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SatyrRatCatcherCast_Miniboss", "SatyrRatCatcherMelee_Miniboss",
			--"SatyrRatCatcherSpell",
		},
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			ForcedNextWeapon = "SatyrRatCatcherCast_Miniboss",
			
			WeaponOptions =
			{
				"SatyrRatCatcherCast_Miniboss", "SatyrRatCatcherMelee_Miniboss",
			},
		},

		GeneratorData =
		{
			DifficultyRating = 400,
			--BlockEnemyTypes = {"SatyrRatCatcher"}
		},
	},

	SatyrRatCatcher_SuperElite =
	{
		InheritFrom = { "SuperElite", "SatyrRatCatcher_Miniboss" },
		MaxHealth = 1000,
		HealthBuffer = 5000,
		BlockRaiseDead = false,
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.SatyrRatCatcher )