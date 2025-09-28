UnitSetData.Stalker =
{
	Stalker =
	{
		InheritFrom = { "BaseQEnemy", "BaseVulnerableEnemy", "LowPolyEnemy" },
		--IntroEncounterName = "StalkerIntro",

		ActivateAnimation = "Enemy_Stalker_Spawn",
		ActivateFx = "TyphonStalkerSpawnFx",
		ActivateFx2 = "null",
		ActivateFxPreSpawn = "nil",
		ActivateFadeIn = false,
		ActivateTint = false,
		ActivateStartAlpha = 1,
		ActivateDuration = 0.5,
		WakeUpDelay = 0.55,
		PostActivateScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.24, Angle = 90, DistanceThreshold = 200 },

		MaxHealth = 1780,
		HealthBarOffsetY = -190,
		HealthBarType = "Medium",
		DeathFx = "EnemyDeathFxTyphonSmall",
		DeathAnimation = "Enemy_Stalker_Death",
		DeathSound = "/SFX/Enemy Sounds/TyphonStalker/EmoteDying",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedPhysical",
			Rapid = "HitSparkEnemyDamagedPhysicalRapid",
		},

		Groups = { "GroundEnemies" },
		IsAggroedSound = "/SFX/Enemy Sounds/TyphonStalker/EmoteAlerted",
		Material = "Organic",

		StunAnimations = 
		{
			Default = "Enemy_Stalker_OnHit",
			Heavy = "Enemy_Stalker_OnHit_Heavy",
		},

		AIOptions =
		{
			"AggroAI",
		},
		AIAggroRange = 1150,

		DefaultAIData =
		{
			DeepInheritance = true,

			SurroundRetaliateDistance = 350,
			SurroundRefreshInterval = 0.5,
			MaxAttackers = 2,
			SurroundMinTrackTime = 0,
		},
		PostAggroAI = "SurroundAI",

		WeaponOptions =
		{
			"StalkerEviscerate", "StalkerBurrow"
		},

		ActiveCapWeight = 0.25,
		GeneratorData =
		{
			DifficultyRating = 145,
			BlockEnemyTypes = {"Stalker_Elite"}
		},

		EnemySightedVoiceLines =
		{
			{ GlobalVoiceLines = "MonstersSightedVoiceLines" },
		},		
	},

	Stalker_Elite =
	{
		InheritFrom = { "Elite", "Stalker" },
		HealthBuffer = 1580,
		IsAggroedSound = "/SFX/Enemy Sounds/TyphonStalker/EmoteTaunting",

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"StalkerEviscerate_Elite", "StalkerBurrow_Elite"
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeEncounterDepth" },
				Comparison = ">=",
				Value = 3
			},
		},

		GeneratorData =
		{
			DifficultyRating = 245,
			BlockEnemyTypes = {"Stalker"}
		},
	},

	Stalker_Miniboss =
	{
		InheritFrom = { "BaseBossEnemy", "Stalker" },
		WakeUpDelayMin = 0,
		WakeUpDelayMax = 1.0,
		MaxHealth = 9050,
		DeathFx = "EnemyDeathFxTyphon",
		
		GrannyTexture = "GR2/TyphonSupportMiniboss_Color",
		
		IsBoss = false,
		BlockPostBossMetaUpgrades = true,
		BlockRaiseDead = true,
		BlockCharm = true,
		ImmuneToPolymorph = true,
		IgnoreSprintPhasingStasisStun = true,

		SpawnAngleTowardId = 50059,

		DeathAnimation = "Enemy_Stalker_Miniboss_Death",
		DeathAnimationIfNotAllBossesDead = "Enemy_Stalker_Death",
		DeathAngle = 220,
		DeathPanOffsetY = -150,
		OnDeathFunctionName = "GenericBossKillPresentation",
		OnDeathFunctionArgs =
		{
			MusicMutedStems = { "Guitar", "Bass" },
			Message = "StalkerMinibossDefeatedMessage",
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			FlashRed = true,
			IgnoreEndMusic = true,
		},

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
			"StalkerEviscerate_Miniboss",
			"StalkerBurrow_Miniboss",
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},

		GeneratorData =
		{
			DifficultyRating = 220,
			BlockEnemyTypes = {"Stalker"}
		},
		
		CauseOfDeathDisplayData = 
		{
			GameStateRequirements = 
			{
				{
					PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
				}
			},
			Name = "MiniBossStalker_Alt",
		},
		AltHealthBarTextIds =
		{
			{ TextId = "MiniBossStalker_Alt",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					}
				},
			},
		},

		OnKillVoiceLines =
		{
			PlayOnceFromTableThisRun = true,
			PlayOnceContext = "StalkerMinibossKillVO",
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlayAll = 0.25,
			PreLineWait = 1.0,
			RecheckRequirementsPostWait = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					Path = { "CurrentRun", "EnemyKills", "Stalker_Miniboss" },
					Comparison = "<=",
					Value = 1,
				},
			},
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_0595", Text = "Now for the last one..." },
			{ Cue = "/VO/MelinoeField_0596", Text = "One left..." },
			{ Cue = "/VO/MelinoeField_0597", Text = "One remains..." },
			{ Cue = "/VO/MelinoeField_0599", Text = "And now for you...", PlayFirst = true },
		},

	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Stalker )

WeaponSetData =
{
	StalkerEviscerate =
	{
		AIData =
		{
			DeepInheritance = true,

			AttackSlots =
			{
				{ ProjectileName = "StalkerGroundWave", UseAttackerAngle = true, OffsetAngle = -10, OffsetDistance = 500, OffsetFromAttacker = true, },
				{ ProjectileName = "StalkerGroundWave", UseAttackerAngle = true, OffsetAngle = 10, OffsetDistance = 500, OffsetFromAttacker = true, }
			},
			BarrelLength = 50,
			FireProjectileStartDelay = 0.08,
			FireProjectileTowardTarget = true,

			AttackDistance = 550,
			MoveWithinRangeTimeout = 3.0,

			FireSelfVelocity = 1060,

			PreAttackSound = "/SFX/Enemy Sounds/TyphonStalker/EmoteCharging",
			PreAttackAnimation = "Enemy_Stalker_EvisceratePreFire",
			PreAttackFx = "EnemyChargeFxIn_Stalker",
			FireAnimation = "Enemy_Stalker_EviscerateFire",
			PostAttackAnimation = "Enemy_Stalker_EvisceratePostFire",

			PreAttackDuration = 0.63,
			FireDuration = 0.28,
			PostAttackDuration = 1.0, -- anim is 0.88

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,
			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.07,
			StopBeforeFire = true,

			SurroundAIKey = "StalkerEviscerate",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/TyphonStalker/EmoteAttacking" },
			},
		},

	},

	StalkerEviscerate_Elite =
	{
		InheritFrom = { "StalkerEviscerate" },

		AIData =
		{
			DeepInheritance = true,
			
			AttackSlots =
			{
				{ ProjectileName = "StalkerGroundWave_Elite", UseAttackerAngle = true, OffsetAngle = -15, OffsetDistance = 500, OffsetFromAttacker = true, },
				{ ProjectileName = "StalkerGroundWave_Elite", UseAttackerAngle = true, OffsetAngle = 0, OffsetDistance = 500, OffsetFromAttacker = true, },
				{ ProjectileName = "StalkerGroundWave_Elite", UseAttackerAngle = true, OffsetAngle = 15, OffsetDistance = 500, OffsetFromAttacker = true, },
			},
			AttackDistance = 700,
		},
	},

	StalkerEviscerate_Miniboss =
	{
		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.05,
			FireProjectileAtSelf = true,

			AttackSlots =
			{
				{ ProjectileName = "StalkerLeap_Miniboss", PauseDuration = 0.05, },
				{ ProjectileName = "StalkerGroundWave_Miniboss", },
			},

			ApplyEffectsOnWeaponFire =
			{
				{
					EffectName = "StalkerLeapGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.2,
						Modifier = 0.1,
						HaltOnEnd = true,
					}
				},
			},
			ClearPreAttackStartEffectsOnFireEnd = true,

			WaitForAngleTowardTarget = true,
			WaitForAngleTowardTargetTimeOut = 1.0,

			PreAttackStop = true,
			TrackTargetDuringCharge = true,
			PreAttackRotationDampening = 0.09,
			StopBeforeFire = true,

			ChargeSelfVelocity = 1500,


			PreAttackAnimation = "Enemy_Stalker_Leap_Start",
			PreFireAnimation = "Enemy_Stalker_Leap_PreFire",
			FireAnimation = "Enemy_Stalker_Leap_Fire",
			PostAttackAnimation = "Enemy_Stalker_Leap_End",

			PreAttackEndShake = true,
			PreAttackDuration = 0.8,
			PreFireDuration = 0.2,
			FireDuration = 0.5,
			PostAttackDurationMin = 0.65,
			PostAttackDurationMax = 0.75,

			AttackDistance = 800,
			AttackDistanceScaleY = 0.65,
			WithinRangeWander = true,
			WithinRangeWanderDistance = 200,
			WithinRangeWanderDuration = 0.5,
			MoveSuccessDistance = 50,

			RetreatAfterAttack = true,
			RetreatBufferDistance = 1400,
			RetreatTimeoutMin = 1.75,
			RetreatTimeoutMax = 2.75,

			SurroundAIKey = "StalkerEviscerate",
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Werewolf/EmoteAttacking" },
				{ Name = "/SFX/Enemy Sounds/TyphonStalker/EmoteAttacking" },
			},
		},
	},

	StalkerBurrow =
	{
		GenusName = "StalkerBurrow",

		Requirements =
		{
			MinPlayerDistance = 650,
			MaxAttackers = 1,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			NoProjectile = true,

			PreAttackDuration = 0.0,
			PreAttackSound = "/SFX/Enemy Sounds/TyphonStalker/StalkerSubmerge",
			FireAnimation = "Enemy_Stalker_Burrow",
			FireDuration = 0.5,
			PostAttackDuration = 0.0,

			AttackDistance = 9999,

			ChainedWeapon = "StalkerUnburrow",

			DoNotRepeatOnAttackFail = true,
		},
	},

	StalkerBurrow_Elite =
	{
		InheritFrom = { "StalkerBurrow" },

		AIData =
		{
			DeepInheritance = true,

			ChainedWeapon = "StalkerUnburrow_Elite",
		},
	},

	StalkerBurrow_Miniboss =
	{
		InheritFrom = { "StalkerBurrow" },
		Requirements =
		{
			MaxAttackers = 1,
			MinAttacksBetweenUse = 3,
		},

		AIData =
		{
			DeepInheritance = true,

			ChainedWeapon = "StalkerUnburrow_Miniboss",
		},
	},

	StalkerUnburrow =
	{
		GenusName = "StalkerBurrow",

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "StalkerUnburrow",
			FireProjectileStartDelay = 0.05,

			ApplyEffectsOnMove =
			{
				WeaponEffectData.StalkerBurrowSpeedBoost,
			},
			ApplyEffectsOnWeaponFire =
			{
				WeaponEffectData.AttackLowGrip,
			},

			PreAttackSound = "/SFX/Enemy Sounds/TyphonStalker/StalkerEmergePreRumble",
			PreAttackFx = "TyphonStalkerBurrowPreAttackFx",
			EndPreAttackFx = true,
			PreAttackDuration = 0.45,
			PreAttackEndShake = true,
			FireAnimation = "Enemy_Stalker_BurrowOut",
			FireDuration = 0.65,
			PostAttackDurationMin = 0.45,
			PostAttackDurationMax = 0.55,

			AttackDistance = 200,
			AttackDistanceScaleY = 0.65,
			WithinRangeWander = true,
			WithinRangeWanderDistance = 200,
			WithinRangeWanderDuration = 0.5,
			MoveSuccessDistance = 50,

			DoNotRepeatOnAttackFail = true,
			PreAttackCreateHealthBar = true,
		},

		Sounds =
		{
			FireSounds =
			{
				-- "/SFX/Enemy Sounds/Charon/CharonBigSwipe2"
			},
		},
	},

	StalkerUnburrow_Elite =
	{
		InheritFrom = { "StalkerUnburrow" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "StalkerUnburrow_Elite",
		},
	},

	StalkerUnburrow_Miniboss =
	{
		InheritFrom = { "StalkerUnburrow" },
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "StalkerUnburrow_Miniboss",

			--[[EndSpawnerThreadOnFireEnd = true,
			SpawnBurstOnMove = true,
			SpawnBurstDelay = 0.1,
			SpawnRate = 1.5,
			SpawnOnSpawnPoints = true,
			SpawnRadius = 9999,
			SpawnsPerBurstMin = 2,
			SpawnsPerBurstMax = 2,
			MaxActiveSpawns = 3,
			SpawnerOptions = { "EarthElemental" },
			SpawnAggroed = true,
			RequiredSpawnPointType = "EnemyPointRanged",]]
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil