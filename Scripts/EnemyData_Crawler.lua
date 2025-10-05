UnitSetData.Crawler =
{
	
	Crawler =
	{
		InheritFrom = { "BaseVulnerableEnemy", },
		GenusName = "Crawler",

		EffectVfxScale= 0.5,

		ActivateFx = "EnemyPreSpawnTerrainTiny",
		ActivateFx2 = "EnemyPreSpawnStandingTiny",
		SpawnFx = "CrawlerHighlight",
		StopAnimationsOnDeath = { "CrawlerHighlight", "CrawlerHighlightGlow", "CrawlerHighlight_Add" },

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		ArmorSparkAnimation = "HitSparkArmor_Small",

		SkipDamagedFx = true,
		SkipUnitHitFlash = true,

		StunAnimations = 
		{
			Default = "Enemy_SatyrRat_OnHit",
		},

		MaxHealth = 1,
		IgnoreSpeedShrine = true,
		
		SpellSummonDataOverrides =
		{
			DeepInheritance = true,
			
			OutgoingDamageModifiers =
			{
				{
					NonPlayerMultiplier = 25,
				},
			},
			MaxHealth = 150,
			HealthBarOffsetY = -200,
		},

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Crawler/EmoteAlerted",
		Material = "Organic",

		AggroDuration = 0.5,
		ActiveCapWeight = 0.4,

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIOptions =
		{
			"AttackerAI",
		},

		WeaponOptions = { "CrawlerRush", "CrawlerBurrow" },

		GeneratorData =
		{
			DifficultyRating = 5,
			BlockEnemyTypes = {"Crawler_Elite"}
		},
	},
	
	Crawler_Elite =
	{
		InheritFrom = { "Elite", "Crawler", },
		HealthBuffer = 1,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		GeneratorData =
		{
			DifficultyRating = 10,
			BlockEnemyTypes = {"Crawler"}
		},
	},
	
	CrawlerMiniboss =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy", },
		GenusName = "Crawler",
		IsBoss = false,
		BlockRaiseDead = true,
		BlockRespawnShrineUpgrade = true,
		BlockCharm = true,
		IgnoreSpeedShrine = true,
		IgnoreSprintPhasingStasisStun = true,
		EffectVfxScale= 0.5,
		PolymorphScaleOverride = 0.5,
		OnDeathFunctionName = "CrawlerMiniBossKillPresentation",
		OnDeathFunctionArgs =
		{
			Message = "CrawlerDefeatedMessage",
			AltMessage = "CrawlerDefeatedMessageAlt",
			StartPanTime = 1.0,
			EndPanTime = 2.0,
			EndAngle = 270,
			FlashRed = true,
			MessageDelay = 0.5,
			EndSecretMusicEarly = true,
			IgnoreEndMusic = true,
			SubtitleDelay = 0.0,
		},
		DeathAnimation = "Enemy_Crawler_Death",
		RunHistoryKilledByName = "CrawlerMinibossCodex",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		ArmorSparkAnimation = "HitSparkArmor_Small",
		
		AltHealthBarTextIds =
		{
			{ TextId = "CrawlerMiniboss_NickName",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusAboutVerminMiniboss01", "OdysseusAboutVerminMiniboss01_B" },
					}
				},
			},
		},
		AltDeathMessageTextIds =
		{
			{ TextId = "CrawlerDefeatedMessageAlt",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "OdysseusAboutVerminMiniboss01", "OdysseusAboutVerminMiniboss01_B" },
					}
				},
			},
		},

		UseActivatePresentation = false,

		MaxHealth = 4600,

		RequiredSpawnPoint = "EnemyPoint",
		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/Crawler/EmoteAlerted",
		Material = "Organic",

		--AIAggroRange = 725,
		AggroDuration = 0.5,
		ActiveCapWeight = 0.4,

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIOptions =
		{
			"AttackerAI",
		},

		WeaponOptions =
		{
			"CrawlerRush_Miniboss",
			"CrawlerMinibossSlam",
			"CrawlerMinibossSummon", 
			-- "CrawlerBurrow_Miniboss" -- removed for now
		},

		GeneratorData =
		{
			DifficultyRating = 100,
		},

		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				FriendMultiplier = 0.0,
				TrapDamageTakenMultiplier = 0.0,
			},
		},

		OnKillVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "BossVanquishedSpeech", Time = 60 },
			},
			{ GlobalVoiceLines = "BarelySurvivedBossFightVoiceLines" },
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 5.2,
				SuccessiveChanceToPlayAll = 0.66,
				ThreadName = "RoomThread",
				GameStateRequirements =
				{
				},

				{ Cue = "/VO/MelinoeField_0179", Text = "...Terrifying...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0180", Text = "Gods, what a monster..." },
				{ Cue = "/VO/MelinoeField_0181", Text = "Positively vicious...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0182", Text = "I win this time, O King.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutVerminMiniboss01" },
						}
					},
				},
				{ Cue = "/VO/MelinoeField_0183", Text = "Got you again, O King.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutVerminMiniboss01" },
						}
					},
				},
				{ Cue = "/VO/MelinoeField_0184", Text = "Not really dead, are you." },
			},
		},

	},

	Crawler_Shadow =
	{
		InheritFrom = { "Shadow", "BaseVulnerableEnemy", },
		GenusName = "Crawler",

		StartAggroed = true,

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		ArmorSparkAnimation = "HitSparkArmor_Small",
		
		MaxHealth = 1500,

		RequiredSpawnPoint = "EnemyPoint",
		Groups = { "GroundEnemies" },
		Material = "Organic",

		ActiveCapWeight = 0.4,

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		AIOptions =
		{
			"AttackerAI",
		},

		WeaponOptions =
		{
			"CrawlerRush_Shadow",
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Crawler )