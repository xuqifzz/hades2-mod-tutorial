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
		DamageTextStartColor = Color.TrapDamageLight,
		DamageTextColor = Color.TrapDamage,

		DefaultAIData =
		{
		}
	},

	-- Erebus Traps
	SafeZone =
	{
		InheritFrom = { "BaseTrap" },

		ActivateGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeErebusSafeZones" },
			},
		},

		DistanceTriggers =
		{
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeErebusSafeZones" },
					},
				},
				PreTriggerWait = 0.1,
				WithinDistance = 550,
				VoiceLines =
				{
					PlayOnce = true,
					PlayOnceFromTableThisRun = true,
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.3,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_0272", Text = "A Warding Circle..." },
					{ Cue = "/VO/MelinoeField_0273", Text = "Warding Circle there..." },
				}
			},
		},

		DefaultAIData =
		{
			DeepInheritance = true,
			
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

		ProjectilesCollideWithGroups =
		{
			"EnemyTeam",
		},

		ToggleTrap = true,
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
		
		DestroyDelay = 0.5,
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
				IsMultiplier = true,
				FriendMultiplier = 0,
			},
			{
				Name = "CharmedMultiplier",
				IsMultiplier = true,
				NonPlayerMultiplier = 10,
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

		SpawnObstaclesOnSpawn =
		{
			{ Name = "_Impassable_FloodTrap", SyncOwnerAngle = true, GroupName = "Impassable" },
		},

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
			[1] = { GlobalVoiceLines = "SteamTrapKillVoiceLines" },
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

		OnHitEvents =
		{
			{
				FunctionName = "FirstOnHitSound",
				Args =
				{
					Sound = "/SFX/SteamPipeHit",
				},
			},
		},

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 50,
			},
		},

		KillingEnemyVoiceLines =
		{
			[1] = { GlobalVoiceLines = "SteamTrapKillVoiceLines" },
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
			[1] = { GlobalVoiceLines = "SteamTrapKillVoiceLines" },
		},		
	},


	GunBombUnit =
	{
		InheritFrom = { "BaseTrap" },
		GenusName = "Eris",

		MaxHealth = 9999,
		FlashOnFuse = true,
		FuseDuration = 0.2,
		ImpactReaction =
		{
			--[[RequireAnyProjectileNames =
			{
				"ErisLaser", "ErisLaserDash",
			},]]
			RequireNotProjectileNames =
			{
				"ErisWindBuffet", "GunGrenadeTossLucifer", "OilPuddleFire", "OilPuddleFire02", "OilPuddleFire03", "OilPuddleFire04"
			},
			RequireAnyAttackerName =
			{
				"_PlayerUnit", "Eris"
			},
			FunctionName = "ActivateLuciferFuse"
		},
		FuseActivationSound = "/SFX/Player Sounds/ZagreusLuciferPreAttack",

		OnHitShake = { Distance = 3, Speed = 600, Duration = 0.15 },

		OnDeathShakeScreenSpeed = 150,
		OnDeathShakeScreenDistance = 4,
		OnDeathShakeScreenDuration = 0.25,
		OnDeathShakeScreenFalloff = 1500,

		AlwaysTraitor = true,
		OnDeathFireWeapons = { "GunBombWeapon" },

		DumbFireWeapons = { "GunBombImmolation" },

		IncomingDamageModifiers =
		{
			{
				Name = "ImmolationImmunity",
				ValidWeapons = { "GunBombImmolation" },
				ValidWeaponMultiplier = 0,
				Multiplicative = true,
			},
		},
		KeepNonPlayerMultipliers = true,
		OutgoingDamageModifiers =
		{
			{
				Name = "IgnoreEris",
				NonPlayerMultiplier = 0,
				Multiplicative = true,
			},
		},

		OnKillVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.25,
				ObjectType = "Eris",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
						Comparison = ">=",
						Value = 0.65,
					},
				},
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 12 },
					{ Name = "ErisBombedRecently", Time = 30 },
				},

				{ Cue = "/VO/ErisField_0418", Text = "See that?" },
				{ Cue = "/VO/ErisField_0419", Text = "Off they go!" },
				{ Cue = "/VO/ErisField_0420", Text = "Whoopsie!" },
				{ Cue = "/VO/ErisField_0421", Text = "Whoops!" },
				{ Cue = "/VO/ErisField_0422", Text = "Pop!" },
				{ Cue = "/VO/ErisField_0423", Text = "{#Emph}Pop!" },
			},
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

		DistanceTriggers =
		{
			{
				PreTriggerWait = 0.1,
				WithinDistance = 500,
				VoiceLines =
				{
					{
						PlayOnceFromTableThisRun = true,
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.05,
						GameStateRequirements =
						{
							{
								PathEmpty = { "RequiredKillEnemies" },
							},
						},
						Cooldowns =
						{
							{ Name = "MelinoeAnyQuipSpeech" },
						},
						{ Cue = "/VO/MelinoeField_0866", Text = "Miasma...", PlayFirst = true },
						{ Cue = "/VO/MelinoeField_0867", Text = "More Miasma..." },
					},
				},
			}
		},
	},

	BrambleTrap =
	{
		InheritFrom = { "BaseTrap" },
		IgnoreElapsedTimeMultiplier = true,

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
					SkipCanAttack = true,
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
				NonPlayerMultiplier = 0.0,
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
		DisableImmediately = true,

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
		Groups = {"RoomWeapon"},
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
			Rapid = "HitSparkEnemyDamagedGlassRapid",
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

	-- Ephyra Traps


    TyphonEgg =
    {
		InheritFrom = { "BaseTrap" },

		MaxHealth = 2000,
		SkipDamageText = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		DestroyDelay = 2,
		DeathAnimation = "Blank",
		FlashOnFuse = true,
		FuseDuration = 0.0,
		IgnoreElapsedTimeMultiplier = true,
		--FuseAnimation = "FireBarrelLit",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		OnDeathShakeScreenSpeed = 350,
		OnDeathShakeScreenDistance = 8,
		OnDeathShakeScreenDuration = 0.65,
		OnDeathShakeScreenFalloff = 1500,

		OnDamagedFunctionName = "ActivateFuse",

		OnDeathFireWeapons = { "TyphonEggDeathWeapon" },

		TargetGroups = { "GroundEnemies", "FlyingEnemies", "HeroTeam" },

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 30,
			}
		},

		IncomingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			},
		},
    },
    
    TyphonEggLarge =
    {
        InheritFrom = { "TyphonEgg" },

		MaxHealth = 100,
        OnDamagedFunctionName = "nil",
		OnDeathFireWeapons = {},
		FlashOnFuseColor = Color.White,
		FuseDuration = 2.0,

		DeathFx = "EnemyDeathFxTyphon",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnDeathShakeScreenSpeed = 0,

		IncomingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			},
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			}
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

		OnDeathFireWeapons = { "FireBarrelExplosion" },

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

		OnDeathFireWeapons = { "FireBarrelExplosionShips" },

		OnKillVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.5,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.4,
				ObjectType = "Eris",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
						Comparison = ">=",
						Value = 0.25,
					},
					ChanceToPlay = 0.25,
				},
				Cooldowns =
				{
					{ Name = "ErisSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/ErisField_0322", Text = "{#Emph}Ooh {#Prev}that's {#Emph}hot!" },
				{ Cue = "/VO/ErisField_0323", Text = "{#Emph}Yeah{#Prev}, burn it {#Emph}all {#Prev}down!" },
				{ Cue = "/VO/ErisField_0324", Text = "Things are heating {#Emph}up!" },
				{ Cue = "/VO/ErisField_0325", Text = "{#Emph}Spicy!" },
				{ Cue = "/VO/ErisField_0487", Text = "{#Emph}Whew, hot!" },
				{ Cue = "/VO/ErisField_0488", Text = "Some mood lighting!" },
				{ Cue = "/VO/ErisField_0489", Text = "We're on {#Emph}fire!" },
				{ Cue = "/VO/ErisField_0490", Text = "{#Emph}Everything's on fire!" },
				{ Cue = "/VO/ErisField_0491", Text = "Getting warmer!" },
				{ Cue = "/VO/ErisField_0492", Text = "Oh, it {#Emph}burns!" },
			},
		},
	},

	OilPuddle =
	{
		InheritFrom = { "BaseTrap" },
		SilentImpact = true,
		TriggersOnHitEffects = false,

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
		DeathAnimation = "BattleStandardDeathFxSpawner",
		SpawnObstaclesOnDeath =
		{
			{ Name = "BattleStandardDestroyed", SyncOwnerAngle = true, RestoreOnLoad = true, },
		},
		StopAnimationsOnDeath = { "BattleStandardFxEmitter" },
		
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
		StopAnimationsOnHitStun = true,

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
						IsNone = { "I_Boss01", "Q_Boss02" },
					},
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "ReachedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
							},
						},
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

		DistanceTriggers =
		{
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "I_Boss01", "Q_Boss02" },
					},
				},
				WithinDistance = 550,
				VoiceLines =
				{
					PlayOnceFromTableThisRun = true,
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.5,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,

					{ Cue = "/VO/MelinoeField_0434", Text = "A Time Sign..." },
					{ Cue = "/VO/MelinoeField_0436", Text = "A Sign of Chronos...", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_0437", Text = "One of those blasted Signs..." },
					{ Cue = "/VO/MelinoeField_0438", Text = "The Time Sign's back." },
					{ Cue = "/VO/MelinoeField_0439", Text = "Time Sign there..." },
					{ Cue = "/VO/MelinoeField_0440", Text = "Another Time Sign..." },
				}
			}
		},
	},

	BattleStandardChronos =
	{
		InheritFrom = { "BattleStandard" },
		DeathAnimation = "BattleStandardDeathFxSpawnerChronos",

		SpawnObstaclesOnDeath =
		{
		},

		IncomingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 0,
			}
		}
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
		BlockExitText = "ExitBlockedByPylon",
		TriggersOnDamageEffects = true,
		EffectBlocks = {"BurnEffect"},
		DamagedAnimation = "SoulPylonDamaged",
		DeathSound = "/SFX/Enemy Sounds/Hecate/HecateGroundBlastFire",
		SpawnObstaclesOnDeath =
		{
			{ Name = "SoulPylonDestroyed", SyncOwnerAngle = true, RestoreOnLoad = true, RestoreOnLoadName = "SoulPylonDestroyedFinished", },
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
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.5,
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
						IsNone = { "HeraclesCombatN", "ArtemisCombatN" },
					},
					ChanceToPlay = 0.15,
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
					{ Name = "StruckPylonRecently", Time = 360 },
				},

				{ Cue = "/VO/MelinoeField_0404", Text = "Hold still in there, Shades.", PlayFirst = true, },
				{ Cue = "/VO/MelinoeField_0405", Text = "You Shades are getting out of there...!" },
				{ Cue = "/VO/MelinoeField_0406", Text = "You'll be out in no time, Shades." },
				{ Cue = "/VO/MelinoeField_0407", Text = "How many of these do they have?" },
				{ Cue = "/VO/MelinoeField_4232", Text = "Excuse me a moment!",
					BreakIfPlayed = true,
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
				{ Cue = "/VO/MelinoeField_4233", Text = "Pardon, Lady Medea.",
					PlayFirst = true,
					BreakIfPlayed = true,
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
				{ Cue = "/VO/MelinoeField_0408", Text = "Don't mind me, Lady Medea...!",
					PlayFirst = true,
					BreakIfPlayed = true,
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
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "Name" },
							IsAny = { "N_Shop01", },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				ObjectType = "NPC_Medea_01",
				PreLineWait = 0.65,
				GameStateRequirements =
				{
					ChanceToPlay = 0.15,
				},
				Cooldowns =
				{
					{ Name = "MedeaSpokeRecently", Time = 6 },
				},				

				{ Cue = "/VO/Medea_0295", Text = "Oh, {#Emph}that.", PlayFirst = true },
				{ Cue = "/VO/Medea_0296", Text = "Oh, right." },
				{ Cue = "/VO/Medea_0297", Text = "Have at it." },
				{ Cue = "/VO/Medea_0298", Text = "I was saving that for you..." },
				{ Cue = "/VO/Medea_0299", Text = "All yours!" },
				{ Cue = "/VO/Medea_0300", Text = "That's it." },
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Heracles_01", "NPC_Medea_01", "NPC_Artemis_01" }, Alive = false },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech", Time = 5 },
					{ Name = "MelinoeBarrierDestroyedSpeech", Time = 240 },
				},

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
				{ Cue = "/VO/MelinoeField_0401", Text = "Five down, one to go.",
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
				ObjectType = "NPC_Heracles_01",
				PreLineWait = 0.65,
				SuccessiveChanceToPlay = 0.5,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "HeraclesAnyQuipSpeech", Time = 6 },
				},

				{ Cue = "/VO/Heracles_0507", Text = "Daughter of Hades...", PlayFirst = true },
				{ Cue = "/VO/Heracles_0508", Text = "The dead retaliate..." },
				{ Cue = "/VO/Heracles_0509", Text = "The dead scatter..." },
				{ Cue = "/VO/Heracles_0510", Text = "Shades of the dead..." },
				{ Cue = "/VO/Heracles_0511", Text = "Releasing the dead..." },
				{ Cue = "/VO/Heracles_0512", Text = "Commander of the dead..." },
				{ Cue = "/VO/Heracles_0513", Text = "They're on our side..." },
				{ Cue = "/VO/Heracles_0514", Text = "Off they go..." },
			},
			{
				RandomRemaining = true,
				ObjectType = "NPC_Medea_01",
				PreLineWait = 0.65,
				SuccessiveChanceToPlay = 0.5,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "MedeaSpokeRecently", Time = 6 },
				},

				{ Cue = "/VO/Medea_0284", Text = "Off they go...!" },
				{ Cue = "/VO/Medea_0285", Text = "Scattered like mice." },
				{ Cue = "/VO/Medea_0286", Text = "How kind of you." },
				{ Cue = "/VO/Medea_0287", Text = "Bothersome things..." },
				{ Cue = "/VO/Medea_0288", Text = "They're free..." },
				{ Cue = "/VO/Medea_0290", Text = "Farewell, spirits!" },
				{ Cue = "/VO/Medea_0291", Text = "Look at them flee..." },
				{ Cue = "/VO/Medea_0292", Text = "Others remain..." },
				{ Cue = "/VO/Medea_0293", Text = "Shattered..." },
				{ Cue = "/VO/Medea_0294", Text = "All to pieces..." },
				{ Cue = "/VO/Medea_0095", Text = "You're all worked up." },
				{ Cue = "/VO/Medea_0096", Text = "Such violence...!", PlayFirst = true },
				{ Cue = "/VO/Medea_0154", Text = "...that should do it." },
				{ Cue = "/VO/Medea_0289", Text = "They're free... for now.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Medea_0288" },
						},
					},
				},
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

		DistanceTriggers =
		{
			{
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "N_Story01", "N_MiniBoss01", "N_MiniBoss02" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "SurfacePenalty" },
					},
				},
				WithinDistance = 750,
				VoiceLines =
				{
					PlayOnce = true,
					PlayOnceFromTableThisRun = true,
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineWait = 0.3,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,

					{ Cue = "/VO/MelinoeField_0387", Text = "Shades are trapped within that Pylon there...!", PlayFirst = true, PlayOnce = true },
					{ Cue = "/VO/MelinoeField_0388", Text = "That Pylon's powering the barrier out there.", PlayFirst = true, PlayOnce = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0387" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0389", Text = "There's my target." },
					{ Cue = "/VO/MelinoeField_0390", Text = "Pylon sighted." },
					{ Cue = "/VO/MelinoeField_0391", Text = "Pylon there." },
					{ Cue = "/VO/MelinoeField_0392", Text = "Another Pylon.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
								Comparison = ">",
								Value = 1,
							},
						}
					},
				}
			},
		},

		Material = "Shell",

		OnDeathFireWeapons = { "SoulPylonDeath" },
		AIOptions =
		{
			"EmptyAI",
		},
	},

	-- Misc / Unsorted Traps
	ShovelPointTrap =
	{
		InheritFrom = { "PassiveRoomWeapon" },

		DamageTextStartColor = Color.TrapDamageLight,
		DamageTextColor = Color.TrapDamage,

		WakeUpDelay = 0.0,

		DefaultAIData =
		{
			DeepInheritance = true,
		},

		AIOptions =
		{
			"EmptyAI",
		},
	},

	DestructibleTree =
	{
		InheritFrom = { "BaseTrap" },

		CannotDieFromDamage = true,
		MaxHealth = 0,

		SkipDamagePresentation = false,
		SkipDamagePresentationFromNonPlayerUnits = true,
		SkipDamageText = true,
		SkipUnitHitFlash = true,
		HideHealthBar = true,
		HideLevelDisplay = true,
		IgnoreAutoLock = true,
		IgnoreInvisibility = true, -- Skip HadesInvisibility emote presentation
		OnHitEvents =
		{
			{
				FunctionName = "FirstOnHitSound",
				Args =
				{
					Sound = "/Leftovers/SFX/CaravanDamage",
				},
			},
		},
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
			SuccessiveChanceToPlayAll = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "Health" },
					Comparison = ">=",
					Value = 15,
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "F_Boss01", "F_Boss02" },
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
		IgnoreInvisibility = true, -- Skip HadesInvisibility emote presentation
		
		OnHitEvents =
		{
			{
				FunctionName = "FirstOnHitSound",
				Args =
				{
					Sound = "/Leftovers/SFX/CaravanDamage",
				},
			},
		},
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },

		OnDamagedFunctionName = "DestructibleTreeHit",

		SkipModifiers = false,
		
		SplinterAnimation = "DestructibleMastDamagedA",
		DestroyedAnimation = "DestructibleMastDestroyedA",
		DestroyedAnimationToRestore = "DestructibleMastDestroyedAFinished",

		DamagedFxStyles =
		{
			Default = "EphyraIndestructibleWoodSplinters",
			Rapid = "EphyraIndestructibleWoodSplinters",
		},
		
		DefaultAIData = {
			DeepInheritance = true,

			HitsToSplinter = 8,
		},

		WeaponOptions =
		{
			"DestructibleMastSplinter",
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 1,
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
					FunctionName = "RequiredHealthFraction",
					FunctionArgs = { Comparison = ">=", Value = 0.2, },
				},
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
		IgnoreInvisibility = true, -- Skip HadesInvisibility emote presentation
		
		OnHitEvents =
		{
			{
				FunctionName = "FirstOnHitSound",
				Args =
				{
					Sound = "/SFX/Enemy Sounds/Heartless/HeartProjectileLand",
				},
			},
		},
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

	TyphonMine =
	{
		InheritFrom = { "BaseTrap" },

		DefaultAIData = {
			DeepInheritance = true,
		},

		Material = "MetalObstacle",

		WeaponOptions =
		{
			"TyphonSpike",
		},

		AIOptions =
		{
			"TyphonMineAI",
		},
		ToggleTrap = false,

		SpawnObstaclesOnDeath =
		{
			{ Name = "TyphonMineDepleted", SyncFlip = true, RestoreOnLoad = true, GroupName = "Terrain_Gameplay" },
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 30,
			},
		},
	},

	EyeBomb =
	{
		Health = 1,
		CannotDieFromDamage = true,
		KillSelfAfterNumReactionProjectiles = 3,

		OnDeathFireWeapons = { "EyeBombExplosion" },

		Material = "Stone",
		OnHitFunctionName = "CheckUnitInvulnerableHit",
		InvulnerableHitFx = "TurtleInvincibubbleHit",
		InvulnerableHitImpactVelocity = 3000,
		InvulnerableHitSound = "/SFX/Enemy Sounds/Heartless/HeartBeatSquishy",
		InvulnerableHitFlash = true,
		InvulnerableBlockHint = true,

		CollisionReactions =
		{
			{
				Cooldown = 1.0,
				FireProjectileRequiredMinVelocity = 600,
				Sound = "/SFX/Enemy Sounds/HydraHead/HydraEggLandSplat",
				FireProjectileData =
				{
					ProjectileName = "EyeBombImpact",
					FireProjectileAtSelf = true,
					SkipCanAttack = true,
				},
			}
		},

		OutgoingDamageModifiers =
		{
			{
				NonPlayerMultiplier = 1,
			},
			{
				PlayerMultiplier = 0,
			},
		},

		DefaultAIData =
		{
		},

		AIOptions =
		{
			"EmptyAI",
		},
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
			DeepInheritance = true,
			PointOnlyCollision = true,
			PreAttackDuration = 0.0,
			PostAttackCooldown = 0.01,
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