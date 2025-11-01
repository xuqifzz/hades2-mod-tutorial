UnitSetData.TyphonTail =
{
	TyphonTail =
	{
		InheritFrom = { "BaseBossEnemy", "BaseVulnerableEnemy" },
		Material = "Organic",
		IsBoss = false,
		ImmuneToPolymorph = true,
		BlockCharm = true,
		BlockPostBossMetaUpgrades = true,
		BlockRaiseDead = true,
		Groups = { "FlyingEnemies" },
		RunHistoryPortrait = "Codex_Portrait_TyphonTail",
		DeathAnimation = "Enemy_TyphonTail_Death",
		OnDeathFunctionName = "GenericBossKillPresentation",
		DeathSound = "/SFX/Enemy Sounds/Typhon/TyphonTailDefeatedWithEmote",
		OnDeathFunctionArgs =
		{
			MusicMutedStems = { "Guitar", "Bass" },
			Message = "TyphonTailDefeatedMessage",
			--SetCameraClampIds = { 778962, 50061, 50062, 778961, },
			StartSound = "/Leftovers/Menu Sounds/EmoteShocked",
			FlashRed = true,
			EndMusicEarly = true,
			-- IgnoreEndMusic = true,
		},

		StopAnimationsOnDeath = { "EnemyBurrowExitHugeDrill" },

		MaxHealth = 25000,
		AISetupDelay = 0.5,
		HealthBarOffsetY = -300,
		EffectVfxOffsetZ = -50,
		
		KillEnemyEvents =
		{
			{
				FunctionName = "WipeSpawnsOnKill",
			},
		},

		DefaultAIData =
		{
			PreAttackEndMinWaitTime = 0.3,
		},
		WeaponOptions =
		{
			"TyphonFlyUp", "TyphonDrill", "TyphonImpale", "TyphonRampage", "TyphonCannon_Right", "TyphonCannon_Left"
			--"TyphonRampage"
		},

		SkipTransitionInvulnerability = true,
		AIEndHealthThreshold = 0.0,
		AIStages =
		{
			{
				RandomAIFunctionNames = { "AttackerAI" },
				AIData =
				{
					AIEndHealthThreshold = 0.0,
				},
			},
		},
		
		CauseOfDeathDisplayData = 
		{
			GameStateRequirements = 
			{
				{
					PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
				}
			},
			Name = "TyphonTail_Alt",
		},
		AltHealthBarTextIds =
		{
			{ TextId = "TyphonTail_Alt",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					}
				},
			},
		},

		MoneyDropOnDeath =
		{
			Chance = 0.0,
		},
	},

	TyphonTail_Incursion =
	{
		GenusName = "TyphonTail",
		Groups = { "EnemyTeam", "FlyingEnemies" },
		RunHistoryPortrait = "Codex_Portrait_TyphonTail",
		CannotDieFromDamage = true,
		IgnoreSprintPhasingStasisStun = true,
		IgnoreCastSummonDamage = true,
		MaxHealth = 1,

		AngleMin = 250,
		AngleMax = 360,
		
		ExitAnimation = "Enemy_TyphonTail_Retreat",

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			}
		},
		
		DefaultAIData =
		{
		},
	},

	TyphonTailMine =
	{
		InheritFrom = { "BaseTrap" },
		GenusName = "TyphonTail",
		RunHistoryPortrait = "Codex_Portrait_TyphonTail",
		MaxHealth = 1,

		ActivateFuseIfNoSpawner = true,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		TriggerGroups = { "HeroTeam" },
		StartCharmedDataOverrides =
		{
			TriggerGroups = { "EnemyTeam" },
		},

		OnDamagedFunctionNames = { "ActivateFuse" },
		OnDeathFireWeapons = { "TyphonTailMineBlast" },

		DissipateAnimation = "LovesickHeartMineDissipate",
		FlashOnFuse = true,
		TriggerDistance = 150,
		TriggerDistanceScaleY = 0.5,
		WakeUpDelay = 0.15,
		ExpirationDuration = 99.0,

		AIOptions =
		{
			"MineAI",
		},
		AttackDistance = 100,
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.TyphonTail )


WeaponSetData =
{
	TyphonTailMineBlast =
	{
		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonTailMine",

			FireProjectileAtSelf = true,
			FireFromTarget = true,

			PreAttackAnimation = "TyphonTailMineActivated",
			PreAttackDuration = 0.4,
			FireDuration = 0.0,
			PostAttackDuration = 0.0,

			MoveWithinRange = false,
			AttackDistance = 9999999,
		},
	},

	TyphonFlyUp =
	{
		Requirements =
		{
			MinPlayerDistance = 1000,
		},

		AIData =
		{
			DeepInheritance = true,

			PreAttackStop = true,
			MoveWithinRange = false,
			NoProjectile = true,
			AttackDistance = 9999,

			PreAttackDuration = 0.75,
			FireDuration = 0.75,
			PostAttackDuration = 0.1,

			ClearAllEffects = true,

			PreFireTeleport = true,
			TeleportToTarget = true,

			PreAttackAnimation = "Enemy_TyphonTail_FlyUp",
			FireAnimation = "Enemy_TyphonTail_FlyDown",

			--FireSetZHeight = 800,
			--FireSetZDuration = 0.55,
		},
	},

	TyphonDrill =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 4,
			MaxPlayerDistance = 1000,
		},

		AIData =
		{
			DeepInheritance = true,

			ProjectileName = "TyphonTailDrill",
			FireTicks = 10,
			FireInterval = 0.3,
			FireProjectileAtSelf = true,

			SpawnBurstOnFire = true,
			SpawnerOptions = { "TyphonTailMine" },
			SpawnsPerBurstMin = 20,
			SpawnsPerBurstMax = 20,
			SpawnRadius = 3000,
			SpawnRadiusMin = 400, -- From Tail
			RequireMinPlayerDistance = 300, -- From Player
			MaxActiveSpawns = 20,
			SpawnRateMin = 0.1,
			SpawnRateMax = 0.2,
			SpawnOnSpawnPoints = true,
			EndSpawnerThreadOnFireEnd = true,

			PreAttackAnimation = "Enemy_TyphonTail_DrillPreFire",
			FireAnimation = "Enemy_TyphonTail_DrillFireLoop",
			FireFx = "EnemyBurrowExitHugeDrill",	
			PostAttackAnimation = "Enemy_TyphonTail_DrillPostFire",

			PreAttackDuration = 1.87,
			FireDuration = 0.0,
			PostAttackDuration = 1.6,

			AttackDistance = 500,
			MoveSuccessDistance = 50,
		},
	},

	TyphonImpale =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
			MaxPlayerDistance = 1000,
		},

		AIData =
		{
			DeepInheritance = true,

			FireProjectileStartDelay = 0.2,
			FireProjectileAtSelf = true,
			AttackSlots =
			{
				{ ProjectileName = "TyphonTailShockwave", },
				{ ProjectileName = "TyphonTailShockwaveReverse" },
				{ ProjectileName = "TyphonTailImpale", PauseDuration = 0.55 },
				{ ProjectileName = "TyphonTailImpale", },
			},

			PreAttackAnimation = "Enemy_TyphonTail_ImpalePreFire",
			FireAnimation = "Enemy_TyphonTail_ImpaleFireA",
			FireFx = "EnemyBurrowExitHuge",
			PostAttackAnimation = "Enemy_TyphonTail_ImpalePostFire",

			PreAttackDuration = 1.0,
			FireDuration = 6.5,
			PostAttackDuration = 0.9,

			TrackTargetDuringCharge = true,

			MoveSuccessDistance = 55,
			PreAttackStop = false,
			StopMoveWithinRange = false,
			PreAttackEndStop = true,
			MoveWithinRangeTimeout = 2.0,

			AttackDistance = 200,
		},
	},

	TyphonRampage =
	{
		Requirements =
		{
			MinAttacksBetweenUse = 1,
			MaxPlayerDistance = 1000,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceFirst = true,

			ApplyEffectsOnWeaponTick =
			{
				{
					EffectName = "AttackLowGrip",
					DataProperties = 
					{
						Type = "GRIP",
						Duration = 0.6,
						Modifier = 0.8,
						HaltOnEnd = true,
					}
				},
			},

			ProjectileName = "TyphonTailRampageRam",

			TrackTargetDuringCharge = true,
			PreAttackEndStop = true,
			AngleTowardsTargetWhileFiring = true,
			StopBeforeFire = true,

			PreAttackAnimation = "Enemy_TyphonTail_RampagePreFire",
			FireAnimation = "Enemy_TyphonTail_RampageFire",
			PostAttackAnimation = "Enemy_TyphonTail_RampagePostFire",

			FireProjectileStartDelay = 0.12,
			FireTicks = 5,
			FireInterval = 0.65,
			FireSelfVelocity = 2500,

			PreAttackDuration = 1.5,
			FireDuration = 0.0,
			PostAttackDuration = 1.3,

			AttackDistance = 500,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TailPincerAttack" },
			},
		},
	},

	TyphonCannon_Right =
	{
		GenusName = "TyphonCannon",
		Requirements =
		{
			MinAttacksBetweenUse = 8,
		},

		AIData =
		{
			DeepInheritance = true,
			ForceUseIfReady = true,

			ProjectileName = "TyphonTailCannon",
			PreFireFx = "TyphonTailCannonChargeFx",
			PreAttackSound = "/SFX/Enemy Sounds/AutomatonBeamer/BeamerFireCharge",
			BarrelLength = 650,

			TrackTargetDuringCharge = true,
			PreAttackEndStop = true,
			AngleTowardsTargetWhileFiring = true,

			PreAttackAnimation = "Enemy_TyphonTail_CannonPreFire",
			FireAnimation = "Enemy_TyphonTail_CannonFire",
			PostAttackAnimation = "Enemy_TyphonTail_CannonPostFire",

			PreAttackDuration = 1.3,
			PreFireDuration = 3.0,
			FireDuration = 0.5,
			PostAttackDuration = 1.3,

			MoveToId = 779827,
			UseTargetId = 779866,

			AttackDistance = 125,
			MoveSuccessDistance = 50,
		},

		Sounds =
		{
			FireSounds =
			{
				{ Name = "/SFX/Enemy Sounds/Typhon/TailProjectileFire" },
			},
		},
	},
	TyphonCannon_Left =
	{
		InheritFrom = { "TyphonCannon_Right" },
		GenusName = "TyphonCannon",

		AIData =
		{
			DeepInheritance = true,
			MoveToId = 779866,
			UseTargetId = 779827,
		},
	},
}

OverwriteTableKeys( WeaponData, WeaponSetData )
OverwriteTableKeys( WeaponDataEnemies, WeaponSetData )
WeaponSetData = nil