-- Olympus
OverwriteTableKeys( ObstacleData, {
	OlympusIndoorExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		RewardPreviewOffsetZ = 250,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = -27.5,
		ExitThroughCenter = true,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "OlympusIndoorExitDoorUnlocked",
		ExitDoorOpenAnimation = "OlympusIndoorExitDoorOpen",
		ExitDoorCloseAnimation = "OlympusIndoorExitDoorClose",

		ChooseRoomArgs =
		{
			OutdoorRequiresIndoorTag = true,
		},
	},

	OlympusOutdoorExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		ExitFunctionName = "OlympusSkyExitPresentation",
		NextRoomEntranceFunctionName = "OlympusSkyEntrancePresentation",
		NextRoomEntranceFunctionArgs = { NotifyName = "SkyEntranceInput"},

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		IconSortMode = "Isometric",

		UnlockedSound = "/SFX/DartTrapEmitterActivateSlide",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/SFX/OlympusJumpUseOnly",

		ExitDoorOpenAnimation = "OlympusOutdoorExitDoorOpen",
		ExitDoorCloseAnimation = "OlympusOutdoorExitDoorOpen",
		UnlockedAnimation = "OlympusOutdoorExitDoorOpen",

		NemesisTeleport = true,

		ChooseRoomArgs =
		{
			RequireTags = { "Outdoor" },
		},
	},

	Breakable_P =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CeramicPotSmash",
		DeathFx = "OlympusBreakable01Shatter",

		SetupEvents =
		{
			{
				FunctionName = "RandomizeObject",
				Args =
				{
					RandomizeSets =
					{
						{
							Animation = { "Breakable_P01" },
							OverwriteData =
							{
								DeathFx = "OlympusBreakable01Shatter",
							},
						},
						{
							Animation = { "Breakable_P02" },
							OverwriteData =
							{
								DeathFx = "OlympusBreakable02Shatter",
							},
						},
						{
							Animation = { "Breakable_P03" },
							OverwriteData =
							{
								DeathFx = "OlympusBreakable03Shatter",
							},
						},
					},
				},
			},
		},

		ValueOptions =
        {
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 15, MaxValue = 15, IgnoreRoomMoneyStore = true, },
				Animation = "Breakable_N_HighValue",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
					DeathFx = "EphyraBreakableVaseGoldShatter",
					DeathSound = "/SFX/GoldObjectSmash",
				},
				GameStateRequirements =
				{
					
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 10, MaxValue = 10, IgnoreRoomMoneyStore = true, },
				Animation = "Breakable_N_HighValue",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
					DeathFx = "EphyraBreakableVaseGoldShatter",
					DeathSound = "/SFX/GoldObjectSmash",
				},
				GameStateRequirements =
				{
					
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 5, MaxValue = 5, IgnoreRoomMoneyStore = true, },
				Animation = "Breakable_N_HighValue",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
					DeathFx = "EphyraBreakableVaseGoldShatter",
					DeathSound = "/SFX/GoldObjectSmash",
				},
				GameStateRequirements =
				{
				},
            },
        },
	},


	HealthFountainP =
	{
		InheritFrom = { "HealthFountain" },
		HealingSpentAnimation = "HealthFountainP_Empty",
	},

	OlympusIcicle01 =
	{
		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 1,
		InheritFrom = { "BaseDestructible" },
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		ImpactReaction =
		{
			Cooldown = 1.0,
			RequiredHitsForImpactReaction = 1,
			Animation = "OlympusIcicleDestroyed",
			FireProjectileData =
			{
				ProjectileName = "IcicleSplinter",
				FireAsPlayerProjectile = true,
				FireProjectileAtSelf = true,
				FireFromTarget = true,
				SkipCanAttack = true,
			},
		},
	},

	OlympusIcicle01_Sky =
	{
		InheritFrom = { "OlympusIcicle01" },

		OnTouchdown =
		{
			Animation = "OlympusIcicleIdle",
		},
	},

	OlympusRubble01 =
	{
		MaxHealth = 25,
		InheritFrom = { "BaseDestructible" },
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		DeathFx = "RubbleFallImpactDebrisOlympus",
		OnTouchdown =
		{
			ProjectileName = "RubbleFallOlympus",
			--CrushTypes = { "TartarusCandles01", "TartarusCandles01b", },
		},
	},

	OlympusCorpseSentryBotA =
	{
		CannotDieFromDamage = true,
		InheritFrom = { "BaseDestructible" },
		MaxHealth = 0,
		HealthTicks = 2,
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		DeathSound = "/SFX/AnchorSlam",
		DeathFx = "OlympusAutomatonCorpseDeathFx",

		SetupEvents =
		{
			{
				FunctionName = "RandomizeObject",
				Args =
				{
					Flip = true,
					ScaleMin = 0.75,
					ScaleMax = 1.0,
				},
			},
		},
	},
	OlympusCorpseSentryBotB =
	{
		InheritFrom = { "OlympusCorpseSentryBotA" },
	},
	OlympusCorpseSentryBotC =
	{
		InheritFrom = { "OlympusCorpseSentryBotA" },
	},

	OlympusCorpseAutomatonBeamerA =
	{
		InheritFrom = { "OlympusCorpseSentryBotA" },
		HealthTicks = 5,
	},
	OlympusCorpseAutomatonBeamerB =
	{
		InheritFrom = { "OlympusCorpseAutomatonBeamerA" },
	},
	OlympusCorpseAutomatonBeamerC =
	{
		InheritFrom = { "OlympusCorpseAutomatonBeamerA" },
	},

	OlympusCorpseAutomatonEnforcerA =
	{
		InheritFrom = { "OlympusCorpseSentryBotA" },
		HealthTicks = 5,
	},
	OlympusCorpseAutomatonEnforcerB =
	{
		InheritFrom = { "OlympusCorpseAutomatonEnforcerA" },
	},
	OlympusCorpseAutomatonEnforcerC =
	{
		InheritFrom = { "OlympusCorpseAutomatonEnforcerA" },
	},

	OlympusDestructiblePillar =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "OlympusDestructiblePillarA",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "OlympusRubble01", "OlympusRubble01" },
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 125,
			SpawnOffsetXMax = 230,
			SpawnOffsetYMin = 100,
			SpawnOffsetYMax = 200,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 1.05,
			SpawnScaleMax = 0.95,
			SwapData = "OlympusDestructiblePillarA",
		},
	},

	OlympusDestructiblePillarA =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "OlympusDestructiblePillarB",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "OlympusRubble01", "OlympusRubble01" },
			ForceSpawnToValidLocation = true,
			SpawnAmountMin = 1,
			SpawnAmountMax = 3,
			SpawnOffsetXMin = 125,
			SpawnOffsetXMax = 350,
			SpawnOffsetYMin = 75,
			SpawnOffsetYMax = 330,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 1.05,
			SpawnScaleMax = 0.95,
			SwapData = "OlympusDestructiblePillarB",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	OlympusDestructiblePillarB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "OlympusDestructiblePillarC",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "OlympusRubble01", "OlympusRubble01" },
			ForceSpawnToValidLocation = true,
			SpawnAmountMin = 2,
			SpawnAmountMax = 4,
			SpawnOffsetXMin = 125,
			SpawnOffsetXMax = 350,
			SpawnOffsetYMin = 75,
			SpawnOffsetYMax = 330,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 1.05,
			SpawnScaleMax = 0.95,
			SwapData = "OlympusDestructiblePillarC",
			CausesOcclusion = false,
		},
	},

	OlympusDestructiblePillarC =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = true,
			},
		},
	},

	OlympusCharoncrow01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },

		InteractDistance = 160,
		InteractOffsetX = -30,
		SetupGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "Shop" },
			},
		},
		DestroyIfNotSetup = true,
		UseText = "UseExamineMisc",
		OnUsedFunctionName = "UseLockedSystemObjectPresentation",
		OnUsedFunctionArgs = { VoiceLines = "UsedCharonScarecrowVoiceLines" },

		DistanceTrigger =
		{
			PreTriggerWait = 0.1,
			WithinDistance = 650,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "P_PreBoss01" },
					Comparison = "<=",
					Value = 20,
				},
			},
			VoiceLines =
			{
				{
					UsePlayerSource = true,
					RandomRemaining = true,
					BreakIfPlayed = true,
					PlayOnceFromTableThisRun = true,
					SuccessiveChanceToPlay = 0.33,
					SuccessiveChanceToPlayAll = 0.05,
					SkipCooldownCheckIfNonePlayed = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_2488", Text = "You're not Lord Charon..." },
					{ Cue = "/VO/MelinoeField_2489", Text = "Lord Charon... sort of...", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_2490", Text = "Lord Charon's wares..." },
					{ Cue = "/VO/MelinoeField_2491", Text = "Did Hermes leave me this?" },
				},
			},
		},

	},

	-- Olympus Traps
	StatueTrap_Zeus =
	{
		--[[InheritFrom = { "BaseTrap" },
		
		WakeUpDelayMin = 10.0,
		WakeUpDelayMax = 15.0,

		DefaultAIData = {
			DeepInheritance = true,
			
			IdleAnimation = "ZeusStatueIdle",
			DisabledAnimation = "ZeusStatueIdle",
			
			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		WeaponOptions =
		{
			"ZeusStatueLightningStorm2"
		},

		AIOptions =
		{
			"EmptyAI",
		},
		ToggleTrap = true,]]

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnHitShakeRequireAttackerGroup = "ChronosForces",
	},

	StatueTrap_Hestia =
	{
		--[[InheritFrom = { "BaseTrap" },
		
		WakeUpDelayMin = 10.0,
		WakeUpDelayMax = 15.0,

		DefaultAIData = {
			DeepInheritance = true,
			
			IdleAnimation = "HestiaStatueIdle",
			DisabledAnimation = "HestiaStatueIdle",
			
			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		WeaponOptions =
		{
			"HestiaStatueFireBalls",
		},

		AIOptions =
		{
			"EmptyAI",
		},
		ToggleTrap = true,]]
		
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnHitShakeRequireAttackerGroup = "ChronosForces",
	},

	StatueTrap_Demeter =
	{
		--[[InheritFrom = { "BaseTrap" },
		
		WakeUpDelayMin = 10.0,
		WakeUpDelayMax = 15.0,

		DefaultAIData = {
			DeepInheritance = true,

			IdleAnimation = "DemeterStatueIdle",
			DisabledAnimation = "DemeterStatueIdle",
			
			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		WeaponOptions =
		{
			"DemeterStatueFrostStorm",
		},

		AIOptions =
		{
			"EmptyAI",
		},
		ToggleTrap = true,]]
		
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnHitShakeRequireAttackerGroup = "ChronosForces",
	},

	StatueTrap_Poseidon =
	{
		--[[InheritFrom = { "BaseTrap" },
		
		WakeUpDelayMin = 10.0,
		WakeUpDelayMax = 15.0,

		DefaultAIData = {
			DeepInheritance = true,

			IdleAnimation = "PoseidonStatueIdle",
			DisabledAnimation = "PoseidonStatueIdle",
			
			AttackDistance = 9999,
			MoveWithinRange = false,
		},

		WeaponOptions =
		{
			"PoseidonStatueWave",
		},

		AIOptions =
		{
			"EmptyAI",
		},
		ToggleTrap = true,]]
		
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnHitShakeRequireAttackerGroup = "ChronosForces",
	},

})