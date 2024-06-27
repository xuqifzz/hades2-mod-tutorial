UnitSetData.Traps =
{
	BaseTrap =
	{
		InheritFrom = { "IsNeutral" },
		NonHeroKillCombatText = "TrapKill",
		RequiredKill = false,
		AggroMinimumDistance = 500,
		StartAggroed = true,
		TriggersOnHitEffects = false,
		TriggersOnDeathWithKillEffects = true,
		CanBeFrozen = false,
		HideHealthBar = true,
		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 20.0,
			},
		},

		DefaultAIData =
		{
		}
	},

	-- Erebus Traps
	RootingTree =
	{
		InheritFrom = { "BaseTrap" },

		DefaultAIData = {
			DeepInheritance = true,
			
			TriggerGroups =  { "HeroTeam" },
			TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

			IdleAnimation = "RootingTreeIdle",
			DisabledAnimation = "RootingTreeDisabled",
		},

		WeaponOptions =
		{
			"RootsAoE",
		},

		AIOptions =
		{
			"GuardAI",
		},
		ToggleTrap = true,
	},

	SafeZone =
	{
		InheritFrom = { "BaseTrap" },

		ActivateGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeErebusSafeZones" },
			},
		},

		DefaultAIData = {
			DeepInheritance = true,
			
			--TriggerGroups =  { "HeroTeam" },
			--TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

			IdleAnimation = "SafeZoneIdle",
			DisabledAnimation = "SafeZoneDisabled",
		},

		WeaponOptions =
		{
			"SafeZone",
		},

		AIOptions =
		{
			"SafeZoneAI",
		},

		ToggleTrap = true,
	},

	CorruptedEgg =
	{
		InheritFrom = { "BaseVulnerableEnemy" },
		MaxHealth = 80,

		RequiredKill = false,
		UseActivatePresentation = false,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"CorruptedSpawns"
		},

		AIOptions =
		{
			"AttackAndDie",
		},

		MoneyDropOnDeath = {},

		CleanupAnimation = "Blank",
	},

	LovesickHeart =
	{
		InheritFrom = { "BaseTrap" },

		ActivateFuseIfNoSpawner = true,
		FuseWarningAnimation = "LovesickHeartMineDecalIn",

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
		OnDeathFireWeapons = { "LovesickHeartMineBlast" },

		DissipateAnimation = "LovesickHeartMineDissipate",
		FuseAnimation = "LovesickHeartMineActivated",
		FuseWarningProjectileName = "LovesickHeartMineBlast",
		FlashOnFuse = true,
		FuseDuration = 0.6,
		--TriggerDistance = 225,
		--WakeUpDelay = 1.5,
		TriggerDistance = 310,
		WakeUpDelay = 0.15,
		ExpirationDuration = 12.0,

		AIOptions =
		{
			"MineAI",
		},
		AttackDistance = 100,

		CleanupAnimation = "Blank",
		OutgoingDamageModifiers =
		{
			{
				Name = "FriendImmunity",
				FriendMultiplier = 0,
			},
		},
	},

	BloodMine =
	{
		InheritFrom = { "BaseTrap" },

		ActivateFuseIfNoSpawner = true,
		FuseWarningAnimation = "BlastWarningDecal",

		DefaultAIData =
		{
			DeepInheritance = true,
		},
		TriggerGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OnDamagedFunctionNames = { "ActivateFuse" },
		OnDeathFireWeapons = { "MineBlast" },

		DissipateAnimation = "BloodMineDeactivated",
		FuseAnimation = "BloodMineActivated",
		FuseWarningProjectileName = "MineBlast",
		FlashOnFuse = true,
		FuseDuration = 1.0,
		TriggerDistance = 225,
		WakeUpDelay = 1.5,
		ExpirationDuration = 15.0,

		AIOptions =
		{
			"MineAI",
		},
		AttackDistance = 100,

		CleanupAnimation = "Blank",
		OutgoingDamageModifiers =
		{
			{
				Name = "FriendImmunity",
				FriendMultiplier = 0,
			},
		},
	},

	BloodMinePreFused =
	{
		InheritFrom = { "BloodMine" },

		TriggerDistance = 999999,

		OnSpawnVoiceLines =
		{
			Queue = "Interrupt",
			BreakIfPlayed = true,
			RandomRemaining = true,
			SuccessiveChanceToPlay = 0.75,
			PreLineWait = 0.15,
			UsePlayerSource = true,
			Cooldowns =
			{
				{ Name = "MelFoundBombSpeech", Time = 30 },
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/Melinoe_0714", Text = "What the?" },
			{ Cue = "/VO/Melinoe_0715", Text = "Wha—?", PlayFirst = true, },
			{ Cue = "/VO/Melinoe_1924", Text = "How'd that get in there." },
			{ Cue = "/VO/Melinoe_1925", Text = "Uh-oh!" },
			{ Cue = "/VO/Melinoe_1926", Text = "{#Emph}Tsk..." },
			{ Cue = "/VO/Melinoe_1927", Text = "Damn." },
			{ Cue = "/VO/Melinoe_1928", Text = "Whoa!" },
			{ Cue = "/VO/Melinoe_1929", Text = "{#Emph}Urgh..." },
		},
	},

	-- Oceanus Traps
	FloodTrap =
	{
		InheritFrom = { "BaseTrap" },


		DefaultAIData =
		{
			DeepInheritance = true,

			IdleAnimation = "FloodTrapIdle",
			DisabledAnimation = "FloodTrapDisabled",
			PreAttackEndShake = true,
		},

		AIOptions =
		{
			"EmptyAI",
		},

		WeaponOptions =
		{
			"FloodTrapWeapon",
		},
		ToggleTrap = true,

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			},
		},
	},

	SteamTrap =
	{
		InheritFrom = { "BaseTrap" },

		DefaultAIData =
		{
			IdleAnimation = "SteamTrapIdle",
			DisabledAnimation = "SteamTrapDisabled",
			
			TargetGroups = { "GroundEnemies", "HeroTeam", "DestructibleGeo" },
		},

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"SteamTrapWeapon",
		},
		AIOptions =
		{
			"GuardAI",
		},
		ToggleTrap = true,

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},

		KillingEnemyVoiceLines =
		{
			[1] = GlobalVoiceLines.SteamTrapKillVoiceLines,
		},
	},

	SteamWallTrap =
	{
		InheritFrom = { "BaseTrap" },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 2,

		DamagedAnimation = "SteamWallTrapDamaged",
		DeathAnimation = "SteamWallTrapDestroyed",
		OnDeathFireWeapons = { "SteamWallBlast" },

		SpawnObstaclesOnDeath =
		{
			{ Name = "SteamWallTrapDestroyed", SyncOwnerAngle = true, RestoreOnLoad = true, },
		},

		OnDeathShakeScreenSpeed = 350,
		OnDeathShakeScreenDistance = 8,
		OnDeathShakeScreenDuration = 0.65,
		OnDeathShakeScreenFalloff = 1500,

		FirstOnHitSound = "/SFX/SteamPipeHit",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},

		KillingEnemyVoiceLines =
		{
			[1] = GlobalVoiceLines.SteamTrapKillVoiceLines,
		},		
	},

	SteamCubeFused =
	{
		InheritFrom = { "BaseTrap" },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 6,

		ActivateFuseOnDeath = true,
		FlashOnFuse = true,
		FuseDuration = 3.0,
		FuseAnimation = "SteamCubeDamaged03",
		FuseWarningAnimation = "BlastWarningDecal",
		FuseWarningProjectileName = "SteamCubeExplosion",
		FuseActivationSound = "/SFX/SteamTrapPreExplode",

		SpawnObstaclesOnDeath =
		{
			{ Name = "SteamCubeFusedDestroyed", SyncOwnerAngle = true, RestoreOnLoad = true, },
		},
		OnDeathFireWeapons = { "SteamCubeExplosion" },

		OnDeathShakeScreenSpeed = 350,
		OnDeathShakeScreenDistance = 8,
		OnDeathShakeScreenDuration = 0.65,
		OnDeathShakeScreenFalloff = 1500,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },


		HealthTickAnimations =
		{
			[9] = "SteamCubeDamaged01",
			[6] = "SteamCubeDamaged02",
			[3] = "SteamCubeDamaged03",
		},

		HealthTickDecrementSound = "/SFX/SteamBarrelHit",
		SilentImpact = true,
		OnHitShake = { Distance = 5, Speed = 300, Duration = 0.25 },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},

		KillingEnemyVoiceLines =
		{
			[1] = GlobalVoiceLines.SteamTrapKillVoiceLines,
		},		
	},

	-- Fields Traps
	MiasmaGeyser =
	{
		InheritFrom = { "BaseTrap" },

		ToggleTrap = false,

		SpawnObstaclesOnSpawn =
		{
			{ Name = "_Impassable_Miasma", SyncOwnerAngle = true, GroupName = "Impassable" },
		},

		DefaultAIData = {
			DeepInheritance = true,
			TriggerGroups =  { "HeroTeam" },

			IdleAnimation = "MiasmaGeyserIdleTransition",
		},

		WeaponOptions =
		{
			"MiasmaGeyser"
		},

		AIOptions =
		{
			"GuardAI",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},
	},

	BrambleTrap =
	{
		InheritFrom = { "BaseTrap" },

		AIOptions =
		{
			"EmptyAI",
		},

		CollisionReactions =
		{
			{
				Cooldown = 0.4,
				FireProjectileData =
				{
					ProjectileName = "BrambleTrap",
					FireProjectileAtSelf = true,
					--FireFromTarget = true,
				},
			}
		},

		DefaultAIData =
		{
			TriggerGroups =  { "HeroTeam" },
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 5.0,
			},
		},
	},

	BrambleTrapBush =
	{
		InheritFrom = { "BrambleTrap" },
	},

	-- Clockwork Traps
	SpikeTrapClockwork =
	{
		InheritFrom = { "BaseTrap" },

		DefaultAIData = {
			DeepInheritance = true,

			PostAttackCooldown = 2.0,
			
			AttackDistance = 100,
			AIResetDistance = 110,

			TargetGroups = { "GroundEnemies", "HeroTeam", "DestructibleGeo" },
			IdleAnimation = "SpikeTrapIdle",
			PreAttackAnimation = "SpikeTrapPreFire",
			PreAttackSound = "/SFX/SpikeTrapSetWithShake",
			PostAttackAnimation = "SpikeTrapPressed",
			ReloadingLoopSound = "/SFX/TrapSettingLoop",
			ReloadedSound = "/SFX/TrapSet",
			DisabledAnimation = "SpikeTrapDeactivated",
		},

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"SpikeTrapClockwork",
		},

		--ClockworkReaction = "DoAttackerAILoop",

		AIOptions =
		{
			"GuardAI",
		},
		ToggleTrap = true,
		IdleAnimation = "SpikeTrapIdle",

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 30,
			},
		},
	},

	BeamTrap =
	{
		InheritFrom = { "BaseTrap" },

		MaxHealth = 1000,
		HealthBarType = "Medium",
		HealthBarOffsetY = -375,

		SkipDamagePresentation = false,
		SkipDamageText = false,
		SkipUnitHitFlash = false,
		HideHealthBar = false,
		HideLevelDisplay = false,
		IgnoreAutoLock = false,

		DamagedAnimation = "BeamTrapDamaged",
		DeathAnimation = "BeamTrapDestroyed",
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedGlass",
			Rapid = "HitSparkEnemyDamagedGlass",
		},

		SpawnObstaclesOnDeath =
		{
			{ Name = "BeamTrapDestroyed", SyncOwnerAngle = true, RestoreOnLoad = true, },
		},

		Material = "Stone",

		DefaultAIData =
		{
			DeepInheritance = true,

			MoveWithinRange = false,
			IdleAnimation = "BeamTrapIdle",
			DisabledAnimation = "BeamTrapIdle",

		},

		WeaponOptions =
		{
			"BeamTrap",
		},

		WakeUpDelay = 3.0,
		AIOptions =
		{
			"PassiveAI",
		},
		ToggleTrap = true,
		DisableImmediately = true,

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 2,
			},
		},

		OnKillVoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlayAll = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "BeamTrapDestroyedVOPlayed", Time = 240 },
				},

				{ Cue = "/VO/MelinoeField_2372", Text = "Enough of that." },
				{ Cue = "/VO/MelinoeField_2373", Text = "Blasted buzzing..." },
			},
		},
	},

	DartTrapEmitterClockwork =
	{
		InheritFrom = { "BaseTrap" },

		Material = "MetalObstacle",
		DisabledAnimation = "ArcherTrapDeactivated",

		DefaultAIData =
		{
			DeepInheritance = true,

			PreAttackDuration = 0.5,
			FireDuration = 0.3,
			PostAttackDuration = 0.5,
			PostAttackCooldown = 3.0,

			ProjectileName = "DartTrapWeaponClockwork",
			FireTicksMin = 9,
			FireTicksMax = 9,
			FireInterval = 0.15,
			TrackTargetDuringCharge = false,

			PreAttackAnimation = "DartTrapEmitterFire",
			FireAnimation = "DartTrapEmitterFire",
			PostAttackAnimation = "DartTrapEmitterReturnToIdle",
			ReloadingLoopSound = "/SFX/TrapSettingLoop",
			ReloadedSound = "/SFX/ArcherTrapReloaded",
			PreAttackEndShake = true,

			MoveWithinRange = false,
			PreAttackAngleTowardTarget = false,

			TargetSelf = true,
			TargetOffsetForward = 100,
		},

		ClockworkReaction = "DoAttackerAILoop",

		WeaponOptions =
		{
			"ArcherTrapWeapon",
		},
		ToggleTrap = true,
		IdleAnimation = "BallistaIdle",

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 30,
			},
		},
	},

	-- Ephyra Traps
	PuddleSpawner =
	{
		InheritFrom = { "BaseTrap" },

		IgnoreDamage = true,
		IgnoreAutoLock = false,
		HideHealthBar = true,
		HideLevelDisplay = true,

		DefaultAIData = {
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"SlowPuddles",
		},
		AIOptions =
		{
			"DoAttackerAILoop",
		},
	},

	PuddleTile =
	{
		InheritFrom = { "BaseTrap" },
		TriggersOnHitEffects = false,
		PreAttackDuration = 0.0,
		PostAttackCooldown = 0.01,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
		DefaultAIData =
		{
			PointOnlyCollision = true,
		},

		WeaponOptions =
		{
			"PuddleTileWeapon"
		},
		AIOptions =
		{
			"DoAttackerAILoop",
		},
	},

	-- Thessaly Traps
	FireBarrel =
	{
		InheritFrom = { "BaseTrap" },

		MaxHealth = 9999,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		DestroyDelay = 2,
		DeathAnimation = "Blank",
		FlashOnFuse = true,
		FuseDuration = 1.5,
		FuseAnimation = "FireBarrelLit",
		FuseWarningAnimation = "BlastWarningDecal",
		FuseWarningProjectileName = "FireBarrelExplosion",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		OnDeathShakeScreenSpeed = 350,
		OnDeathShakeScreenDistance = 8,
		OnDeathShakeScreenDuration = 0.65,
		OnDeathShakeScreenFalloff = 1500,

		OnDamagedFunctionName = "ActivateFuse",

		OnDeathFireWeapons = { "FireBarrelExplosion", "FireBarrelFireSpread" },

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},
	},
	FireBarrelShips =
	{
		InheritFrom = { "FireBarrel" },

		FuseAnimation = "FireBarrelShipsLit",

		OnDeathFireWeapons = { "FireBarrelExplosion" },
	},

	OilPuddle =
	{
		InheritFrom = { "BaseTrap" },
		
		TriggersOnHitEffects = true,

		DefaultAIData = {
			DeepInheritance = true,
		},

		OnHitFunctionName = "OilPuddleOnHit",

		WeaponOptions =
		{
			"OilPuddleIgnite", "OilPuddleSlick",
		},

		AIOptions =
		{
			"DoAttackerAILoop",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 2,
			},
		},
	},
	OilPuddle02 =
	{
		InheritFrom = { "OilPuddle" },

		WeaponOptions =
		{
			"OilPuddleIgnite02", "OilPuddleSlick02",
		},
	},
	OilPuddle03 =
	{
		InheritFrom = { "OilPuddle" },

		WeaponOptions =
		{
			"OilPuddleIgnite03", "OilPuddleSlick03",
		},
	},
	OilPuddle04 =
	{
		InheritFrom = { "OilPuddle" },

		WeaponOptions =
		{
			"OilPuddleIgnite04", "OilPuddleSlick04",
		},
	},

	ChronosCover =
	{
		InheritFrom = { "BaseTrap" },
		MaxHealth = 500,
		HealthBarType = "Medium",
		HealthBarOffsetY = -375,

		SkipDamagePresentation = false,
		SkipDamageText = false,
		SkipUnitHitFlash = false,
		HideHealthBar = false,
		HideLevelDisplay = false,
		IgnoreAutoLock = false,

		SpawnFx = "HecateTeleportFxFront",

		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetal",
			Rapid = "HitSparkEnemyDamagedMetal",
		},

		DefaultAIData =
		{
		},

		Material = "MetalObstacle",

		AIOptions =
		{
			"EmptyAI",
		},
	},

	BattleStandard =
	{
		InheritFrom = { "BaseTrap" },
		MaxHealth = 320,
		HealthBarType = "Medium",
		HealthBarOffsetY = -375,

		SkipDamagePresentation = false,
		SkipDamageText = false,
		SkipUnitHitFlash = false,
		HideHealthBar = false,
		HideLevelDisplay = false,
		IgnoreAutoLock = false,

		SpawnAnimation = "BattleStandardSpawn",
		--DeathAnimation = "BattleStandardDeathFxSpawner",
		SpawnObstaclesOnDeath =
		{
			{ Name = "BattleStandardDestroyed", SyncOwnerAngle = true, RestoreOnLoad = true, },
		},
		
		DamagedFxStyles =
		{
			Default = "HitSparkEnemyDamagedMetal",
			Rapid = "HitSparkEnemyDamagedMetal",
		},

		WakeUpDelayMin = 3.0,
		WakeUpDelayMax = 5.0,

		DefaultAIData =
		{		
			PreAttackDuration = 0.2,
			FireDuration = 0,
			PostAttackDuration = 0.1,
			PostAttackCooldown = 0.0,

			AttackDistance = 9999,
			RetreatBufferDistance = 9999,
		},

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"BattleStandardAoE",
		},
		AIOptions =
		{
			"AttackerAI",
		},

		OnKillVoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlayAll = 0.33,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "I_Boss01" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "ChronosSignDestroyedSpeech", Time = 240 },
				},

				{ Cue = "/VO/MelinoeField_0441", Text = "Death to Chronos!" },
				{ Cue = "/VO/MelinoeField_0442", Text = "Death to Chronos...!" },
				{ Cue = "/VO/MelinoeField_0435", Text = "...I'll tear it apart.", PlayOnce = true, PlayOnceContext = "MelinoeField_0435_BannerDestroyed" },				
			},
		},
	},

	BattleStandardChronos =
	{
		InheritFrom = { "BattleStandard" },
		SpawnAnimation = "BattleStandardSpawn",
		DeathAnimation = "BattleStandardDeathFxSpawnerChronos",
		SpawnObstaclesOnDeath =
		{
		},
	},

	SoulPylon =
	{
		InheritFrom = { "BaseTrap" },
		MaxHealth = 260,

		HealthBarType = "Medium",
		HealthBarOffsetY = -280,

		RoomRequiredObject = true,
		OnDeathFunctionName = "UnitDeathCheckRoomExitsReady",

		--OnHitShake = { Distance = 3, Speed = 300 },
		OnHitFlash = { MaxFraction = 0.6, Duration = 0.1, Color = Color.White },
		ImpactSound = "/SFX/EphyraExitGateImpact",

		OnDeathThreadedFunctionName = "HandlePylonObjective",

		SkipDamagePresentation = false,
		SkipDamageText = false,
		SkipUnitHitFlash = false,
		HideHealthBar = false,
		HideLevelDisplay = false,
		IgnoreAutoLock = false,

		DamagedAnimation = "SoulPylonDamaged",
		DeathSound = "/SFX/Enemy Sounds/Hecate/HecateGroundBlastFire",
		SpawnObstaclesOnDeath =
		{
			{ Name = "SoulPylonDestroyed", SyncOwnerAngle = true, RestoreOnLoad = true, },
		},

		SpawnObstaclesOnSpawn =
		{
			{ Name = "SoulPylonBase", SyncOwnerAngle = true, GroupName = "FX_Terrain_Top" },
		},

		DefaultAIData =
		{
		},
		DamageType = "Ally",

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 20,
			},
			{
				PlayerMultiplier = 0.0,
			}
		},
		IncomingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			},
		},

		OnHitVoiceLines =
		{
			UsePlayerSource = true,
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.35,
			ChanceToPlay = 0.05,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "N_Story01", },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
					IsAny = { "HeraclesCombatN", "ArtemisCombatN" },
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "StruckPylonRecently", Time = 300 },
			},

			{ Cue = "/VO/MelinoeField_0404", Text = "Hold still in there, Shades.", PlayFirst = true, },
			{ Cue = "/VO/MelinoeField_0405", Text = "You Shades are getting out of there...!" },
			{ Cue = "/VO/MelinoeField_0406", Text = "You'll be out in no time, Shades." },
			{ Cue = "/VO/MelinoeField_0407", Text = "How many of these do they have?" },
			{ Cue = "/VO/MelinoeField_0408", Text = "Don't mind me, Lady Medea...!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Medea_01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "N_Story01", },
					},
				},
			},
			{ Cue = "/VO/MelinoeField_0409", Text = "Pardon the racket, Lord Charon...!",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "N_Shop01", },
					},
				},
			},
		},

		OnKillVoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.75,
				SuccessiveChanceToPlay = 0.33,
				GameStateRequirements = 
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Story01", "N_Shop01" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "SurfacePenalty" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeBarrierDestroyedSpeech", Time = 240 },
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_0393", Text = "Ghastly thing." },
				{ Cue = "/VO/MelinoeField_0394", Text = "Shades, you're free!", PreLineWait = 0.45, PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0395", Text = "Shades, I release you!", PreLineWait = 0.45 },
				{ Cue = "/VO/MelinoeField_0396", Text = "Pylon destroyed." },
				{ Cue = "/VO/MelinoeField_0397", Text = "Should put a dent into that barrier...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomCountCache", "N_Boss01" },
						},
						{
							PathFalse = { "CurrentRun", "CurrentRoom", "SpeechRecord", "/VO/MelinoeField_0388" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0398", Text = "One less Pylon.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomCountCache", "N_Boss01" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0399", Text = "Just a couple of these left.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomCountCache", "N_Boss01" },
						},
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = ">=",
							Value = 4,
						},
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = "<",
							Value = 6,
						},					
					},
				},
				{ Cue = "/VO/MelinoeField_0400", Text = "One Pylon left.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomCountCache", "N_Boss01" },
						},
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = ">=",
							Value = 5,
						},
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = "<",
							Value = 6,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0401", Text = "One down, one to go.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "RoomCountCache", "N_Boss01" },
						},
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = ">=",
							Value = 5,
						},
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = "<",
							Value = 6,
						},						
					},
				},
				{ Cue = "/VO/MelinoeField_0402", Text = "That should have done it.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = ">=",
							Value = 6,
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0403", Text = "That was the last of them.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = ">=",
							Value = 6,
						},
					},
				},
			},
			{
				RandomRemaining = true,
				ObjectType = "NPC_Medea_01",
				PreLineWait = 0.65,
				TriggerCooldowns = { "MedeaSpokeRecently" },
				
				{ Cue = "/VO/Medea_0095", Text = "You're all worked up." },
				{ Cue = "/VO/Medea_0096", Text = "Such violence...!", PlayFirst = true },
				{ Cue = "/VO/Medea_0154", Text = "...that should do it." },
				{ Cue = "/VO/Medea_0164", Text = "...So mote it be.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpeechRecord" },
							HasNone = { "/VO/Medea_0164", "/VO/Medea_0173" },
						},
					},
				},
				{ Cue = "/VO/Medea_0173", Text = "...So mote it be.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpeechRecord" },
							HasNone = { "/VO/Medea_0164", "/VO/Medea_0173" },
						},
					},
				},
			},
		},

		Material = "Shell",

		OnDeathFireWeapons = { "SoulPylonDeath" },
		AIOptions =
		{
			"EmptyAI",
		},
	},

	Ballista =
	{
		InheritFrom = { "BaseTrap" },

		UseText = "Use",
		
		OnUsedFunctionName = "OnUseBallista",

		DefaultAIData =
		{
			DeepInheritance = true,
			
			IdleAnimation = "BallistaIdle",
		},

		AIOptions =
		{
			"EmptyAI",
		},

		WeaponOptions =
		{
			"BallistaWeapon",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 30,
			},
		},
	},

	-- Olympus Traps
	AutomatonSentryTrap =
	{
		InheritFrom = { "BaseTrap" },

		DefaultAIData = {
			DeepInheritance = true,
			
			TriggerGroups =  { "HeroTeam" },
			TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
			FireProjectileTowardTarget = true,

			SentryTetherDistance = 900,
			SentryActivateDistance = 550,

			IdleAnimation = "AutomatonSentryTrapIdle",
			DisabledAnimation = "AutomatonSentryTrapIdle",
		},

		WeaponOptions =
		{
			"AutomatonSentrySeekAndDestroy",
		},

		AIOptions =
		{
			"SentryAI",
		},
		ToggleTrap = true,
	},

	-- Misc / Unsorted Traps
	UnstableCauldron =
	{
		InheritFrom = { "BaseTrap" },

		IgnoreDamage = true,
		IgnoreAutoLock = false,
		HideHealthBar = true,
		HideLevelDisplay = true,

		OnDamagedFunctionName = "RetaliateAttackerAILoop",

		DefaultAIData = {
			DeepInheritance = true,

			PreAttackDuration = 0.5,
			PostAttackCooldown = 5.0,
			FireAnimation = "UnstableCauldronDisabled",

			IdleAnimation = "UnstableCauldronIdle",
			DisabledAnimation = "UnstableCauldronDisabled",
		},

		WeaponOptions =
		{
			"UnstableCauldronDamage", "UnstableCauldronHeal", "UnstableCauldronSlow",
		},

		AIOptions =
		{
			"EmptyAI",
		},
		ToggleTrap = true,

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},
	},

	
	ShatterCrystal =
	{
		InheritFrom = { "BaseTrap" },

		IgnoreDamage = true,
		IgnoreAutoLock = false,
		HideHealthBar = true,
		HideLevelDisplay = true,

		OnDamagedFunctionName = "DirectionalShatterAI",

		DefaultAIData = {
			DeepInheritance = true,
		},

		WeaponOptions =
		{
			"ShatterCrystalCone",
		},

		AIOptions =
		{
			"EmptyAI",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},
	},

	DestructibleTree =
	{
		InheritFrom = { "BaseTrap" },

		CannotDieFromDamage = true,
		MaxHealth = 0,

		SkipDamagePresentation = false,
		SkipDamageText = true,
		SkipUnitHitFlash = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		IgnoreAutoLock = true,
		
		FirstOnHitSound = "/Leftovers/SFX/CaravanDamage",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		OnDamagedFunctionName = "DestructibleTreeHit",

		SkipModifiers = false,
		SetupEvents =
		{
			{
				FunctionName = "RandomizeObject",
				Args =
				{
					RandomizeSets =
					{
						{
							Animation = { "DestructibleTreeFullA" },
							OverwriteData =
							{
								SplinterAnimation = "DestructibleTreeDamagedA",
								DestroyedAnimation = "DestructibleTreeStumpA",
							},
							PropertyChanges =
							{
								{
									ThingProperty = "Graphic",
									ChangeValue = "DestructibleTreeFullA",
								},
							},
						},
						{
							Animation = { "DestructibleTreeFullB" },
							OverwriteData =
							{
								SplinterAnimation = "DestructibleTreeDamagedB",
								DestroyedAnimation = "DestructibleTreeStumpB",
							},
							PropertyChanges =
							{
								{
									ThingProperty = "Graphic",
									ChangeValue = "DestructibleTreeFullB",
								},
							},
						},
					},
				},
			},
		},
		
		SplinterAnimation = "DestructibleTreeDamagedA",
		DestroyedAnimation = "DestructibleTreeStumpA",

		DefaultAIData = {
			DeepInheritance = true,

			HitsToSplinter = 2,
		},

		WeaponOptions =
		{
			"DestructibleTreeSplinter",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 5,
			},
			{
				PlayerMultiplier = 0.0,
			}
		},

		KillingEnemyVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.45,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "Health" },
					Comparison = ">=",
					Value = 15,
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeTrapKillSpeech", Time = 80 },
			},
			TriggerCooldowns = { "MelinoeCombatQuipPlayed" },

			{ Cue = "/VO/Melinoe_1966", Text = "Shadows take you...!" },
			{ Cue = "/VO/Melinoe_1967", Text = "The woods answer my call..." },
			{ Cue = "/VO/Melinoe_1968", Text = "All back to dust...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1969", Text = "Return to dust." },
			{ Cue = "/VO/MelinoeField_0576", Text = "Splinter apart!" },
			{ Cue = "/VO/MelinoeField_0577", Text = "Splinter and fall." },
			{ Cue = "/VO/MelinoeField_0578", Text = "Splinter!" },
			{ Cue = "/VO/MelinoeField_0579", Text = "Woods take you!" },
		}
	},

	DestructibleMast =
	{
		InheritFrom = { "BaseTrap" },

		CannotDieFromDamage = true,
		MaxHealth = 0,

		SkipDamagePresentation = false,
		SkipDamageText = true,
		SkipUnitHitFlash = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		IgnoreAutoLock = true,
		DestroyedStopsProjectiles = true,
		
		FirstOnHitSound = "/Leftovers/SFX/CaravanDamage",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		OnDamagedFunctionName = "DestructibleTreeHit",

		SkipModifiers = false,
		
		SplinterAnimation = "DestructibleMastDamagedA",
		DestroyedAnimation = "DestructibleMastDestroyedA",

		DefaultAIData = {
			DeepInheritance = true,

			HitsToSplinter = 8,
		},

		WeaponOptions =
		{
			"DestructibleTreeSplinter",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 5,
			},
			{
				PlayerMultiplier = 0.0,
			}
		},

		KillingEnemyVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.45,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.1,
			GameStateRequirements =
			{
				RequiredMinHealthFraction = 0.2,
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeTrapKillSpeech", Time = 80 },
			},
			TriggerCooldowns = { "MelinoeCombatQuipPlayed" },

			{ Cue = "/VO/MelinoeField_1872", Text = "Avast!" },
			{ Cue = "/VO/MelinoeField_1873", Text = "Down with the ship!" },
			{ Cue = "/VO/MelinoeField_1874", Text = "This ship is mine...!" },
			{ Cue = "/VO/MelinoeField_1875", Text = "I'm taking this ship!" },
			{ Cue = "/VO/MelinoeField_1876", Text = "Back off!" },
			{ Cue = "/VO/MelinoeField_1877", Text = "Into the sea with you!", PlayFirst = true },
		}

	},

	ThornTree =
	{
		InheritFrom = { "BaseTrap" },

		CannotDieFromDamage = true,
		MaxHealth = 0,

		SkipDamagePresentation = false,
		SkipDamageText = true,
		SkipUnitHitFlash = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		IgnoreAutoLock = true,
		
		FirstOnHitSound = "/SFX/Enemy Sounds/Heartless/HeartProjectileLand",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		OnDamagedFunctionName = "ThornTreeHit",
		OnHitAnimation = "ThornTreeHitAnim",
		--SplinterAnimation = "ThornTreeDamaged",
		DestroyedAnimation = "ThornTreeDestroyed",

		SkipModifiers = false,

		DefaultAIData = {
			DeepInheritance = true,

			HitsToSplinter = 30,
		},

		WeaponOptions =
		{
			"ThornTreeWeapon",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 40,
			},
			{
				PlayerMultiplier = 1.0,
			}
		},

		KillingEnemyVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.45,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.1,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "Health" },
					Comparison = ">=",
					Value = 15,
				},
			},
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
				{ Name = "MelinoeTrapKillSpeech", Time = 80 },
			},
			TriggerCooldowns = { "MelinoeCombatQuipPlayed" },

			{ Cue = "/VO/MelinoeField_0882", Text = "Thorns hurt.", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_0883", Text = "The thorns answer to me." },
			{ Cue = "/VO/MelinoeField_0884", Text = "Stinging thorns..." },
			{ Cue = "/VO/MelinoeField_0885", Text = "Straight to the heart..." },
			{ Cue = "/VO/MelinoeField_1140", Text = "Eat thorns." },
			{ Cue = "/VO/MelinoeField_1143", Text = "Thorns always hurt." },
		}

	},

	GasTrapPassive =
	{
		InheritFrom = { "BaseTrap" },

		WakeUpDelayMin = 5.0,
		WakeUpDelayMax = 15.0,

		DefaultAIData =
		{
			IdleAnimation = "GasTrapActivated",
			PreAttackAnimation = "GasTrapActivated",
			DisabledAnimation = "TrapFissureDisabled",

			PreAttackDuration = 3.0,
			PostAttackCooldownMin = 15.0,
			PostAttackCooldownMax = 20.0,
			
			AttackDistance = 100,
			AIResetDistance = 110,
		},

		WeaponOptions =
		{
			"SmokeTrapWeapon",
		},
		AIOptions =
		{
			"PassiveAI",
		},
		TargetGroups = { "GroundEnemies", "HeroTeam" },
		ToggleTrap = true,
	},
	LavaSplash =
	{
		InheritFrom = { "BaseTrap" },
		PreAttackDuration = 4.0,
		PostAttackCooldown = 2.0,
		PreAttackColor = Color.Red,
		TrackTargetDuringCharge = true,

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },
		--PreAttackSound = "/SFX/TrapSet",
		--ReloadingLoopSound = "/SFX/TrapSettingLoop",
		ReloadedSound = "/Leftovers/Menu Sounds/TalismanMetalClankDown",

		NonHeroKillCombatText = "LavaKill",

		WeaponOptions =
		{
			"LavaSplash",
		},
		AIOptions =
		{
			"AttackAndDie",
		},
		DestroyOnTrapDisable = true,
	},
	LavaTile =
	{
		InheritFrom = { "BaseTrap" },
		TriggersOnHitEffects = false,

		DefaultAIData =
		{
			PreAttackDuration = 0.0,
			PostAttackCooldown = 0.01,
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			PointOnlyCollision = true,
		},

		NonHeroKillCombatText = "LavaKill",

		WeaponOptions =
		{
			"LavaTileWeapon",
		},
		AIOptions =
		{
			"FireAndQuit",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 5,
			},
		},
	},
	LavaTileTriangle01 =
	{
		InheritFrom = { "LavaTile" },
		WeaponOptions =
		{
			"LavaTileTriangle01Weapon",
		},
	},
	LavaTileTriangle02 =
	{
		InheritFrom = { "LavaTile" },
		WeaponOptions =
		{
			"LavaTileTriangle02Weapon",
		},
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.Traps )