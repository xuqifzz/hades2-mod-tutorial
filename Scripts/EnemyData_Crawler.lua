UnitSetData.Crawler =
{
	
	Crawler =
	{
		InheritFrom = { "BaseVulnerableEnemy", },
		GenusName = "Crawler",

		EffectVfxScale= 0.5,

		ActivateFx = "EnemyPreSpawnTerrainSmall",
		ActivateFx2 = "EnemyPreSpawnStandingSmall",
		SpawnFx = "CrawlerHighlight",
		StopAnimationsOnDeath = { "CrawlerHighlight", "CrawlerHighlightGlow", "CrawlerHighlight_Add" },

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		ArmorSparkAnimation = "HitSparkArmor_Small",

		StunAnimations = 
		{
			Default = "Enemy_SatyrRat_OnHit",
		},

		MaxHealth = 1,
		IgnoreSpeedShrine = true,

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

		GameStateRequirements =
		{
			RequiredMinBiomeDepth = 3,
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
		EffectVfxScale= 0.5,
		OnDeathFunctionName = "CrawlerMiniBossKillPresentation",
		OnDeathFunctionArgs = { Message = "CrawlerDefeatedMessage", StartPanTime = 1.0, EndPanTime = 2.0, EndAngle = 270, FlashRed = true, MessageDelay = 0.5, IgnoreEndMusic = true, },
		DeathAnimation = "Enemy_Crawler_Death",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},
		ArmorSparkAnimation = "HitSparkArmor_Small",
		
		AltHealthBarTextIds =
		{
			{ TextId = "CrawlerMiniboss_NickName", Requirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusAboutVerminMiniboss01" },
					}
				}
			},
		},

		UseActivatePresentation = false,

		MaxHealth = 4200,

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

		WeaponOptions = { "CrawlerRush_Miniboss", "CrawlerMinibossSlam",
							"CrawlerMinibossSummon", 
						-- "CrawlerBurrow_Miniboss" -- removed for now
					},
		--WeaponOptions = { "CrawlerRush", "CrawlerBurrow_Miniboss" },

		GeneratorData =
		{
			DifficultyRating = 100,
		},

		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				NonPlayerMultiplier = 0.0,
			}
		},

		OnKillVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "BossVanquishedSpeech", Time = 60 },
			},
			[1] = GlobalVoiceLines.BarelySurvivedBossFightVoiceLines,
			[2] =
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
}

OverwriteTableKeys( EnemyData, UnitSetData.Crawler )