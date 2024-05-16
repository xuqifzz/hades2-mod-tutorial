ObstacleData =
{
	BaseDestructible =
	{
		HideHealthBar = true,
		SkipDamageText = true,
		SkipDamagePresentation = true,
		SkipModifiers = true,
		BlockWrathGain = true,
		BlockLifeSteal = true,
	},
	BaseIndestructibleNoShakeHitFx =
	{
		HideHealthBar = true,
		ExclusiveOnHitFunctionName = "IndestructibleObstacleHitPresentation",
	},
	BaseIndestructibleHitFx =
	{
		InheritFrom = { "BaseIndestructibleNoShakeHitFx", },
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
	},
	ExitDoor =
	{
		UseText = "UseExitDoorWhileLocked",
		UnlockedAnimation = "DoorExitLightSoftSW",
		UnlockedUseText = "UseLeaveRoom",
		UnlockedUseTextReroll = "UseLeaveRoom_Reroll",
		UnlockedUseTextCannotReroll = "UseLeaveSpecialRoom_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		LockedUseSound = "/Leftovers/World Sounds/Caravan Interior/ChestClose",
		UnlockedUseSound = "/Leftovers/World Sounds/PostBossLeaveSFX",
		DoorShakeSelf = true,

		SetupEvents =
		{
			{
				FunctionName = "SetupDefaultDoor",
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					AddToGroup = "ExitDoors",
				},
			}
		},

		ExitBlockedVoiceLines =
		{
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				PlayOnceFromTableThisRun = true,
				ObjectType = "NPC_Artemis_Field_01",
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},

				{ Cue = "/VO/Artemis_0136", Text = "Over here!" },
				{ Cue = "/VO/Artemis_0137", Text = "{#Emph}Erm{#Prev}, hey?" },
				{ Cue = "/VO/Artemis_0138", Text = "Let me help you." },
				{ Cue = "/VO/Artemis_0139", Text = "Don't go just yet." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "CurrentRoom", "TextLinesRecord", "CharonGrantsMailbox01" },
					},
				},

				{ Cue = "/VO/MelinoeField_0727", Text = "Something I should get here first..." },
				{ Cue = "/VO/MelinoeField_0728", Text = "Shouldn't go just yet..." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlay = 0.5,

				{ Cue = "/VO/Melinoe_0221", Text = "Locked.",
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0222", Text = "Can't.",
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0223", Text = "Not an option.",
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0224", Text = "Won't open.",
					GameStateRequirements =
					{
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
					},
				},

				{ Cue = "/VO/Melinoe_0225", Text = "It's locked!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0226", Text = "I can't!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "RequiredKillEnemies" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0227", Text = "Won't open!",
					GameStateRequirements =
					{
						{
							PathNotEmpty = { "RequiredKillEnemies" },
						},
					},
				},
			},
		},

		OnUseEvents =
		{
			{ FunctionName = "AttemptUseDoor", },
		},
	},

	AnomalyAutoExitDoor =
	{
		InheritFrom = { "ExitDoor", },
		HideRewardPreview = true,

		OnUnlockThreadedFunctionName = "AttemptUseDoor",
	},

	ErebusExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		RewardPreviewOffsetZ = 140,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = 0,
		ExitThroughCenter = true,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "ErebusExitDoorUnlocked",
		ExitDoorOpenAnimation = "ErebusExitDoorOpen",
		ExitDoorCloseAnimation = "ErebusExitDoorClose",

	},

	ErebusExitDoor_FBoss = 
	{
		InheritFrom = { "ErebusExitDoor", },
		UnlockedAnimation = "DoorExitLightSoftNE_Transition",
		ExitDoorOpenAnimation = "DoorExitLightSoftNE",
		ExitDoorCloseAnimation = "DoorExitLightSoftNE_Transition_Reverse",
	},


	PostBossDoor =
	{
		InheritFrom = { "ExitDoor", },

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		--ExitThroughCenter = true,

		UseText = "UseExitDoorWhileLocked",
		UnlockedUseText = "UseLeaveRoom",
		UnlockedUseTextReroll = "UseLeaveRoom_Reroll",
		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedSound = "/SFX/HeatCollectionPickup",
		UnlockedUseSound = "/Leftovers/World Sounds/MapZoomInShortHigh",
		ExitPortalSound = "/SFX/HeatCollectionPickup",

		-- EntranceVfx = "SecretDoorDiveFx_Shrine",
		EntranceColorGrade = "SmokeTrap",
	},

	TartarusDoor03b =
	{
		InheritFrom = { "ExitDoor", },

		UsePromptOffsetX = 20,
		UsePromptOffsetY = -30,
		ExitThroughCenter = true,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "DoorUnlocked",
		ExitDoorOpenAnimation = "DoorOpen",
		ExitDoorCloseAnimation = "DoorClose",

		-- intentionally blank, on the anim
		UnlockedUseSound = "",
	},

	AsphodelBoat01b =
	{
		InheritFrom = { "ExitDoor", },

		UnlockedUseText = "UseLeaveRoomAsphodel",
		UnlockedUseTextReroll = "UseLeaveRoomAsphodel_Reroll",
		UnlockedUseTextCannotReroll = "UseLeaveRoomAsphodel_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		UnlockedAnimation = "AsphodelBoatSunkUnlocked",
		ExitDoorOpenAnimation = "AsphodelBoatSunk",
		AllowReroll = true,

		RewardPreviewOffsetZ = 410,

		LockedUseSound = "/Leftovers/SFX/OutOfAmmo",
		UnlockedUseSound = "/SFX/WeaponUnlock",

		ExitFunctionName = "AsphodelLeaveRoomPresentation",
	},

	ElysiumExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		ExitThroughCenter = true,
		RewardPreviewOffsetZ = 0,
		RewardPreviewOffsetY = -360,
		RewardPreviewOffsetX = 0,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "ElysiumDoorUnlocked",
		ExitDoorOpenAnimation = "ElysiumDoorOpen",
		ExitDoorCloseAnimation = "ElysiumDoorClose",

		-- intentionally blank, on the anim
		UnlockedUseSound = "",
	},

	TartarusCubeBrick03 =
	{
		Material = "StoneObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TartarusCubeBrick03a",
			RequiredHitsForImpactReaction = 3,
			DisableOnHitShake = true
		},
	},

	TartarusCubeBrick05 =
	{
		Material = "StoneObstacle",
	},

	TartarusPillarBase09 =
	{
		Material = "StoneObstacle",
	},

	TartarusFencePicket02 =
	{
		Material = "StoneObstacle",
	},

	TartarusWallBrick13 =
	{
		Material = "StoneObstacle",
	},
	TartarusWallBrick10 =
	{
		Material = "StoneObstacle",
	},

	HousePillar01 =
	{
		Material = "StoneObstacle",
	},

	ElysiumBush01 =
	{
		Material = "BushObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15 },
	},

	ElysiumBush02 =
	{
		Material = "BushObstacle",
		OnHitShake = { Distance = 3, Speed = 100, Duration = 0.15 },
	},

	ElysiumPlanter01 =
	{
		Material = "StoneObstacle",
	},

	ElysiumPlanter02 =
	{
		Material = "StoneObstacle",
	},


	ArachneCocoon =
	{
		InheritFrom = { "BaseDestructible" },

		DeathSound = "/SFX/CocoonDestroy",
		DeathFx = "SpiderCocoonDisintegrate",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		OnHitFunctionName = "CocoonHitPresentation",

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 1,

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					CreateAnimation = "CocoonSparkles",
				},
			},
		},

		DefaultAIData =
		{

		},

		--SkipActivatePresentationOnSpawns = true,
		
		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},

		ValueOptions =
        {
        	{
                Chance = 0.05,
				DataOverrides =
				{
					SpawnUnitOnDeath = "BloodMinePreFused",
				},
        	},
        	{
                Chance = 0.33,
				DataOverrides =
				{
					SpawnUnitFromBiomeEnemySet = "CocoonSpawnsEasy",
					OnDeathFireWeapons = { "CocoonSpawnBlast", },
					SpawnedUnitDataOverrides =
					{ 
						ActivateFx = "nil",
						ActivateFx2 = "nil",
						ActivateFxPreSpawn = "nil",
						ActivateFxPreSpawnDelay = 0.1,
						ActivateFadeIn = true,
						ActivateFadeInDelay = 0.0,
						ActivateFadeInDuration = 0.35,
						ActivateTint = true,
						ActivateTintDelay = 0.0,
						ActivateTintDuration = 0.2,
						ActivateStartAlpha = 0, 
						ActivateDuration = 0.35,
					},
					OnKillVoiceLines = GlobalVoiceLines.ArachneCocoonNegativeReactionLines,
				},
        	},
			{
                Chance = 0.25,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 3, MaxValue = 5, IgnoreRoomMoneyStore = true, },
				DataOverrides =
				{
					OnKillVoiceLines = GlobalVoiceLines.ArachneCocoonPositiveReactionLines,
				},
            },

        },
	},

	ArachneCocoonMedium =
	{
		InheritFrom = { "ArachneCocoon" },
		
		HealthTicks = 2,
		DeathFx = "SpiderCocoonDisintegrateLarge",

		ValueOptions =
        {
        	{
                Chance = 0.05,
				DataOverrides =
				{
					SpawnUnitOnDeath = "BloodMinePreFused",
				},
        	},
        	{
                Chance = 0.6,
				DataOverrides =
				{
					SpawnUnitFromBiomeEnemySet = "CocoonSpawnsMedium",
					OnDeathFireWeapons = { "CocoonSpawnBlast", },
					SpawnedUnitDataOverrides =
					{ 
						ActivateFx = "nil",
						ActivateFx2 = "nil",
						ActivateFxPreSpawn = "nil",
						ActivateFxPreSpawnDelay = 0.1,
						ActivateFadeIn = true,
						ActivateFadeInDelay = 0.0,
						ActivateFadeInDuration = 0.35,
						ActivateTint = true,
						ActivateTintDelay = 0.0,
						ActivateTintDuration = 0.2,
						ActivateStartAlpha = 0, 
						ActivateDuration = 0.35,
					},
					OnKillVoiceLines = GlobalVoiceLines.ArachneCocoonNegativeReactionLines,
				},
        	},
			{
                Chance = 0.25,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 6, MaxValue = 10, IgnoreRoomMoneyStore = true, },
				DataOverrides =
				{
					OnKillVoiceLines = GlobalVoiceLines.ArachneCocoonPositiveReactionLines,
				},
            },
        },
	},

	ArachneCocoonLarge =
	{
		InheritFrom = { "ArachneCocoon" },
		
		HealthTicks = 3,
		DeathFx = "SpiderCocoonDisintegrateLarge",

		ValueOptions =
        {
        	{
                Chance = 0.05,
				DataOverrides =
				{
					SpawnUnitOnDeath = "BloodMinePreFused",
				},
        	},
        	{
                Chance = 0.7,
				DataOverrides =
				{
					SpawnUnitFromBiomeEnemySet = "CocoonSpawnsHard",
					OnDeathFireWeapons = { "CocoonSpawnBlast", },
					SpawnedUnitDataOverrides =
					{ 
						ActivateFx = "nil",
						ActivateFx2 = "nil",
						ActivateFxPreSpawn = "nil",
						ActivateFxPreSpawnDelay = 0.1,
						ActivateFadeIn = true,
						ActivateFadeInDelay = 0.0,
						ActivateFadeInDuration = 0.35,
						ActivateTint = true,
						ActivateTintDelay = 0.0,
						ActivateTintDuration = 0.2,
						ActivateStartAlpha = 0, 
						ActivateDuration = 0.35,
					},
					OnKillVoiceLines = GlobalVoiceLines.ArachneCocoonNegativeReactionLines,
				},
        	},
			{
                Chance = 0.25,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 14, MaxValue = 20, IgnoreRoomMoneyStore = true, },
				DataOverrides =
				{
					OnKillVoiceLines = GlobalVoiceLines.ArachneCocoonPositiveReactionLines,
				},
            },
        },
	},

	ArachneCocoon_G =
	{
		InheritFrom = { "ArachneCocoon" },
		DeathFx = "OceanusKelpCocoonDead",
	},

	ArachneCocoonMedium_G =
	{
		InheritFrom = { "ArachneCocoonMedium" },
		DeathFx = "OceanusKelpCocoonDead",
	},

	ArachneCocoonLarge_G =
	{
		InheritFrom = { "ArachneCocoonLarge" },
		DeathFx = "OceanusKelpCocoonDead",
	},

	RespawnEgg =
	{
		DeathFx = "SpiderCocoonDisintegrate",
		BlockRespawnShrineUpgrade = true,
		BlocksLootInteraction = true,

		OnUsedFunctionName = "RespawnEggPickedUp",
		--OnUsedFunctionArgs = {},

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					CreateAnimation = "CocoonSparkles",
				},
			},
			{
				Threaded = true,
				FunctionName = "RespawnEggCountdown",
				Args =
				{
					Ticks = 5,
					Interval = 1.0,
				},
			},
		},
	},

	ErebusWebs01 =
	{
		InheritFrom = { "BaseDestructible" },
		MaxHealth = 1,
		DeathFx = "Erebus_Webs_01_Death",
		DeathSound = "/Leftovers/World Sounds/LeavesRustle",
		-- OnKillGlobalVoiceLines = "WebDestroyedVoiceLines",
		KillsRequiredForVoiceLines = 1,
		OnDeathFunctionName = "WebSlowedPresentation",
		CollisionReactions =
		{
			{
				ApplyEffects = { EffectData.WebSlow },
				KillSelf = true,
			}
		},
	},
	ErebusWebs02 =
	{
		InheritFrom = { "ErebusWebs01" },
		DeathFx = "Erebus_Webs_02_Death",
	},
	ErebusWebs03 =
	{
		InheritFrom = { "ErebusWebs01" },
		DeathFx = "Erebus_Webs_03_Death",
	},
	ErebusWebs04 =
	{
		InheritFrom = { "ErebusWebs01" },
		DeathFx = "Erebus_Webs_04_Death",
	},
	ErebusWebs05 =
	{
		InheritFrom = { "ErebusWebs01" },
		DeathFx = "Erebus_Webs_05_Death",
	},
	ErebusWebs06 =
	{
		InheritFrom = { "ErebusWebs01" },
		DeathFx = "Erebus_Webs_06_Death",
	},

	AsphodelStalagmite05 =
	{
		InheritFrom = { "BaseDestructible" },
        --DeathFx = "AsphodelStalagtite05Disintegrate",
        DeathSound = "/Leftovers/World Sounds/Caravan Interior/SteamAcidForage",
		CollisionReactions =
		{
			{
				MinVelocity = 1000,
				KillSelf = true,
			}
		},
	},

	BaseBreakable =
	{
		InheritFrom = { "BaseDestructible" },
		GenusName = "Breakable",
		MaxHealth = 1,
		OnKillGlobalVoiceLines = "BreakableDestroyedVoiceLines",
		KillsRequiredForVoiceLines = 2,
		MeterMultiplier = 0,
		MaxHitShields = 0,
		DeathAnimation = "Blank",
		DeathSoundManagerCap = 36,

		CollisionReactions =
		{
			{
				MinVelocity = 1000,
				KillSelf = true,
			}
		},

		ValueOptions =
        {
			SetupEvents =
			{
				{
					FunctionName = "DistanceTrigger",
					Threaded = true,
					Args =
					{
						WithinDistance = 400,
						PostTriggerEvents =
						{
							{
								FunctionName = "GenericPresentation",
								Args = 
								{
									VoiceLines =
									{
										PlayOnce = true,
										UsePlayerSource = true,
										GameStateRequirements =
										{
											{
												PathEmpty = { "RequiredKillEnemies" },
											},
										},
										{ Cue = "/VO/MelinoeField_2035", Text = "One of those Golden Urns that I revealed..." },
									}
								},
							},
						},
					},
				},
			},
			{
                Chance = 0.02,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 15, MaxValue = 15, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableHighValueChronosPot",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
					DeathFx = "BreakableHighValueChronosPotShatter",
					DeathSound = "/SFX/GoldObjectSmash",
				},
				GameStateRequirements =
				{
					
				},
            },
			{
                Chance = 0.03,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 10, MaxValue = 10, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableHighValueChronosPot",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
					DeathFx = "BreakableHighValueChronosPotShatter",
					DeathSound = "/SFX/GoldObjectSmash",
				},
				GameStateRequirements =
				{
					
				},
            },
			{
                Chance = 0.05,
                MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 5, MaxValue = 5, IgnoreRoomMoneyStore = true, },
				Animation = "BreakableHighValueChronosPot",
				DataOverrides =
				{
					OnKillGlobalVoiceLines = "BreakableHighValueDestroyedVoiceLines",
					DeathFx = "BreakableHighValueChronosPotShatter",
					DeathSound = "/SFX/GoldObjectSmash",
				},
				GameStateRequirements =
				{
				},
            },
        },
	},

	Breakable_B =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CeramicPotSmash",
		DeathFx = "BreakableDeathAnim",

		--FirstOnHitSound = "/Leftovers/SFX/CaravanDamage",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 1,

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},
	},

	Breakable_F =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CocoonDestroy",
		DeathFx = "SpiderCocoonDisintegrate",

		--FirstOnHitSound = "/Leftovers/SFX/CaravanDamage",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 1,

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},
	},

	Breakable_Chaos =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CeramicPotSmash",
		DeathFx = "BreakableDeathAnim",

		--FirstOnHitSound = "/Leftovers/SFX/CaravanDamage",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 1,

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},
	},


	WeaponShop =
	{
		UseText = "UseStore",
		OnUsedFunctionName = "StartUpStore",

		OverheadTextFontSize = 20,
		OverheadTextOffset = -110,
		OverheadTextColor = Color.Gold,

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeUnusedWeaponBonus" },
				},
			},
			WithinDistance = 500,
			VoiceLines =
			{
				{
					Queue = "Always",
					PlayOnce = true,
					PlayOnceContext = "PostBossGiftRackIntro",
					UsePlayerSource = true,
					BreakIfPlayed = true,

					{ Cue = "/VO/Melinoe_2407", Text = "There's the Grave Thirst aura by the Silver Pool..." },
				},
			},
		},
	},

	GiftRack =
	{
		UseText = "UseAwardMenu",
		OnUsedFunctionName = "UseKeepsakeRack",
		-- UseSound = "/Leftovers/World Sounds/Caravan Interior/CabinetClose",
		UsePromptOffsetX = 65,
		UsePromptOffsetY = -50,
		SetupEvents =
		{
			{
				FunctionName = "UpdateGiftRackShineStatus",
				Args =
				{
				},
			}
		},
		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossGiftRack" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_PostBoss01", "G_PostBoss01", "H_PostBoss01", "N_PostBoss01", "O_PostBoss01", "P_PostBoss01" },
				},
			},
			WithinDistance = 1020,
			VoiceLines =
			{
				{
					Queue = "Always",
					PlayOnce = true,
					PlayOnceContext = "PostBossGiftRackIntro",
					UsePlayerSource = true,
					BreakIfPlayed = true,
					GameStateRequirements =
					{
						RequiredUnitsNotAlive = { "NPC_Chronos_01" },
					},

					{ Cue = "/VO/MelinoeField_0279", Text = "My Keepsakes manifest..." },
				},
				{
					UsePlayerSource = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.25,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							Path = { "CurrentRun", "ExpiredKeepsakes" },
							HasAny = GameData.AllExpiringKeepsakes,
						},
						RequiredUnitsNotAlive = { "NPC_Chronos_01" },
					},

					{ Cue = "/VO/MelinoeField_0486", Text = "I'd best switch Keepsakes there." },
					{ Cue = "/VO/MelinoeField_0487", Text = "Time for another Keepsake..." },
					{ Cue = "/VO/MelinoeField_0488", Text = "Could switch my Keepsake..." },
					{ Cue = "/VO/MelinoeField_0489", Text = "My Keepsake isn't doing any good." },
					{ Cue = "/VO/MelinoeField_0490", Text = "Should switch Keepsakes..." },
					{ Cue = "/VO/MelinoeField_0491", Text = "How about another Keepsake..." },
				},
			},
		},

	},

	HubGardenPlot =
	{
		Activate = true,
		SkipDefaultSetup = true, -- Handled by WorldUpgradeGarden
		InteractDistance = 200,
		AnimOffsetZ = 50,
		OnUsedFunctionName = "UseGardenPlot",
		UseText = "UseGardenPlotPlant",
		UseTextSpecial = "GardenPlotSpecial",
		UseTextGift = "GardenPlotGift",
		UseTextTalkAndGift = "GardenPlotHarvestAndGift",
		UseTextTalkAndSpecial = "GardenPlotHarvestAndSpecial",
		UseTextGiftAndSpecial = "GardenPlotGiftAndSpecial",
		UseTextTalkGiftAndSpecial = "GardenPlotHarvestGiftAndSpecial",
		CanReceiveGift = true,
		GiftCategoryIndex = 3,
		UnlimitedGifts =
		{
			PlantGrowthAccelerant = true,
		},
		GiftFunctionName = "GiftGardenPlot",
		GiftFunctionArgs =
		{
			Ticks = 4,
		},
		GiftGameStateRequirements =
		{
			{
				PathFromSource = true,
				PathTrue = { "SeedName" },
			},
			{
				PathFromSource = true,
				Path = { "GrowTimeRemaining" },
				Comparison = ">=",
				Value = 1,
			},
		},
		SpecialInteractFunctionName = "PlantAdmirePresentation",
		SpecialInteractGameStateRequirements =
		{
			{
				PathFromSource = true,
				PathTrue = { "SeedName" },
			},
		},
		SpecialInteractCooldown = 10,
		SetupEvents =
		{
			{
				FunctionName = "SetupGardenPlot",
				Args = {},
			},
		},
	},

	CrossroadsBasket01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibersBasket",
	},
	CrossroadsBasket02 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
	},

	CrossroadsBasket03 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
	},

	CrossroadsChair01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		--[[ deactivated for now - gk 3-7-24
		InteractDistance = 110,
		UseText = "UseChair",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
		OnUsedFunctionName = "UseLockedSystemObjectPresentation",
		OnUsedFunctionArgs = { VoiceLines = "TriedToSitVoiceLines", SkipAnim = true, BlockAngleTowardTarget = true },
		]]--
	},

	HouseBasket01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
	},


	HouseFiles02 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
	},

	CrossroadsTrainingDummy01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibers",

		OnHitVoiceLines =
		{
			ObjectType = "NPC_Skelly_01",
			Cooldowns =
			{
				{ Name = "SkellyOnHitSpeech", Time = 8 },
			},
			{
				BreakIfPlayed = true,
				ChanceToPlay = 0.15,
				RandomRemaining = true,
				PreLineWait = 0.85,
				GameStateRequirements =
				{
					{
						PathFromArgs = true,
						Path = { "SourceProjectile", },
						IsNone = {

							"ProjectileCast",
							"ProjectileCastSlow",

							"ProjectileStaffDash",
							"ProjectileStaffSwing1",
							"ProjectileStaffSwing2",
							"ProjectileStaffSwing3",
							"ProjectileSwing5Magic",
							"ProjectileStaffBallCharged",

							"ProjectileAxe",
							"ProjectileAxe2",
							"ProjectileAxe3",
							"ProjectileAxeOverhead",
							"ProjectileAxeSpin",
							"ProjectileAxeBlock2",
							
							"ProjectileTorchBall",
							"ProjectileTorchBallLarge",
							"ProjectileTorchExplosion",
							"ProjectileTorchSpiral",
							"ProjectileTorchOrbit",
							
							"ProjectileLob",
							"ProjectileLobCharged",
							"ProjectileLobChargedPulse",
							"ProjectileThrow",
							"ProjectileThrowBlink",
							"ProjectileThrowCharged",

							"FrogFamiliarLand",
							"CatFamiliarPounce",
							"RavenFamiliarMelee",
						},
					},
				},

				{ Cue = "/VO/Skelly_0272", Text = "{#Emph}Uhh{#Prev}, over here?", PlayFirst = true },
				{ Cue = "/VO/Skelly_0273", Text = "How about some {#Emph}real {#Prev}target practice?" },
				{ Cue = "/VO/Skelly_0274", Text = "Don't waste your strength on those!" },
				{ Cue = "/VO/Skelly_0275", Text = "Save some for {#Emph}me{#Prev}, will ya?" },
				{ Cue = "/VO/Skelly_0276", Text = "We have got to get rid of those..." },
				{ Cue = "/VO/Skelly_0277", Text = "Pick on someone my own size!" },
				{ Cue = "/VO/Skelly_0278", Text = "Conserve your might for {#Emph}me!" },
				{ Cue = "/VO/Skelly_0279", Text = "Let's see you try that {#Emph}here!" },
			},
		},
	},


	HouseVase01 =
	{
		InheritFrom = { "BaseDestructible" },

		MaxHealth = 0,
		HealthTicks = 1,
		CannotDieFromDamage = true,
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		SkipDestroy = true,
		DeathAnimation = "HouseVase01Shatter",
	},
	HouseVase02 =
	{
		InheritFrom = {"HouseVase01"},
		DeathAnimation = "HouseVase02_Destroyed",
	},
	HouseVase04 =
	{
		InheritFrom = {"HouseVase01"},
		DeathAnimation = "HouseVase04Shatter",
	},
	HouseVase05 =
	{
		InheritFrom = {"HouseVase01"},
		DeathAnimation = "HouseVase05Shatter",
	},
	HouseVase06 =
	{
		InheritFrom = {"HouseVase01"},
		DeathAnimation = "HouseVase06Shatter",
	},


	MetaUpgradeScreen =
	{
		UseText = "UseMetaUpgradeScreen",
	},

	HealthFountain =
	{
		UseText = "UseFountainHeal",
		OnUsedFunctionName = "UseHealthFountain",
		UseSound = "/Leftovers/Menu Sounds/AscensionConfirm",
		BlockExitUntilUsed = true,
		BlockExitText = "ExitBlockedByReprieve",
		HealingSpentAnimation = "HealthFountainEmpty",
		HealFraction = 0.20,
		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				-- this represents the added +10%
				DisplayValue = 10,
				Args =
				{
					HealFraction = 0.30,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFountainUpgrade1" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFountainUpgrade2" },
					},					
				},
			},
			{
				FunctionName = "OverwriteSelf",
				-- this represents the added +10%
				DisplayValue = 10,
				Args =
				{
					HealFraction = 0.40,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFountainUpgrade2" },
					},
				},
			},
		},
		RefreshExtractValuesOnApproach = true,
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealthFountain",
			},
		},
		OnUsedVoiceLines =
		{
			[1] = GlobalVoiceLines.UsedFountainVoiceLines,
		},
	},
	
	HealthFountainF =
	{
		InheritFrom = { "HealthFountain" },
		HealingSpentAnimation = "HealthFountainF_Empty",
	},
	
	HealthFountainH =
	{
		InheritFrom = { "HealthFountain" },
		HealingSpentAnimation = "HealthFountainH_Empty",
	},

	
	HealthFountainAsphodel =
	{
		UseText = "UseFountainHeal",
		OnUsedFunctionName = "UseHealthFountain",
		UseSound = "/Leftovers/Menu Sounds/AscensionConfirm",
		BlockExitUntilUsed = true,
		BlockExitText = "ExitBlockedByReprieve",
		HealingSpentAnimation = "HealthFountainEmptyAsphodel",
		RefreshExtractValuesOnApproach = true,
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealthFountain",
			},
		},
		OnUsedVoiceLines =
		{
			[1] = GlobalVoiceLines.UsedFountainVoiceLines,
		},
	},

	HealthFountainElysium =
	{
		UseText = "UseFountainHeal",
		OnUsedFunctionName = "UseHealthFountain",
		UseSound = "/Leftovers/Menu Sounds/AscensionConfirm",
		BlockExitUntilUsed = true,
		BlockExitText = "ExitBlockedByReprieve",
		HealingSpentAnimation = "HealthFountainEmptyElysium",
		RefreshExtractValuesOnApproach = true,
		ExtractValues =
		{
			{
				Key = "HealFraction",
				ExtractAs = "TooltipHeal",
				Format = "PercentPlayerHealthFountain",
			},
		},
		OnUsedVoiceLines =
		{
			[1] = GlobalVoiceLines.UsedFountainVoiceLines,
		},
	},
	
	ManaFountain =
	{
		UseText = "UseManaFountain",
		UseSound = "/Leftovers/SFX/StaminaRefilled",
		CooldownNamePrefix = "ManaFountain",
		CooldownDuration = 5.0,
		OnCooldownAnimation = "ManaFountainEmpty",
		IdleAnimation = "ManaFountainFullStart",
		OnUsedFunctionName = "UseManaFountain",
		ManaFraction = 1.0,
		OnUsedVoiceLines =
		{
		},
	},

	BaseEmotes =
	{
		Emotes =
		{
			Smile =
			{
				AnimationName = "StatusIconSmile",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			Fear =
			{
				AnimationName = "StatusIconFear",
				SoundName = "/SFX/GhostEmotes/Fear"
			},
			Disgruntled =
			{
				AnimationName = "StatusIconDisgruntled",
				SoundName = "/SFX/GhostEmotes/Disgruntled"
			},
			Embarrassed =
			{
				AnimationName = "StatusIconEmbarrassed",
				SoundName = "/SFX/GhostEmotes/Embarrassed"
			},
			Grief =
			{
				AnimationName = "StatusIconGrief",
				SoundName = "/SFX/GhostEmotes/Grief"
			},
			OhBoy =
			{
				AnimationName = "StatusIconOhBoy",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			Determined =
			{
				AnimationName = "StatusIconDetermined",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			FiredUp =
			{
				AnimationName = "StatusIconFiredUp",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			Victory =
			{
				AnimationName = "StatusIconVictory",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
		},
	},

	TinyEmotes =
	{
		Emotes =
		{
			Smile =
			{
				AnimationName = "StatusIconSmile",
				SoundName = "/SFX/GhostEmotes/SmileTINY"
			},
			Fear =
			{
				AnimationName = "StatusIconFear",
				SoundName = "/SFX/GhostEmotes/FearTINY"
			},
			Disgruntled =
			{
				AnimationName = "StatusIconDisgruntled",
				SoundName = "/SFX/GhostEmotes/DisgruntledTINY"
			},
			Embarrassed =
			{
				AnimationName = "StatusIconEmbarrassed",
				SoundName = "/SFX/GhostEmotes/EmbarrassedTINY"
			},
			Grief =
			{
				AnimationName = "StatusIconGrief",
				SoundName = "/SFX/GhostEmotes/GriefTINY"
			},
			OhBoy =
			{
				AnimationName = "StatusIconOhBoy",
				SoundName = "/SFX/GhostEmotes/SmileTINY"
			},
			Determined =
			{
				AnimationName = "StatusIconDetermined",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			FiredUp =
			{
				AnimationName = "StatusIconFiredUp",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			Victory =
			{
				AnimationName = "StatusIconVictory",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
		},
	},

	SmallEmotes =
	{
		Emotes =
		{
			Smile =
			{
				AnimationName = "StatusIconSmile",
				SoundName = "/SFX/GhostEmotes/SmileSMALL"
			},
			Fear =
			{
				AnimationName = "StatusIconFear",
				SoundName = "/SFX/GhostEmotes/FearSMALL"
			},
			Disgruntled =
			{
				AnimationName = "StatusIconDisgruntled",
				SoundName = "/SFX/GhostEmotes/DisgruntledSMALL"
			},
			Embarrassed =
			{
				AnimationName = "StatusIconEmbarrassed",
				SoundName = "/SFX/GhostEmotes/EmbarrassedSMALL"
			},
			Grief =
			{
				AnimationName = "StatusIconGrief",
				SoundName = "/SFX/GhostEmotes/GriefSMALL"
			},
			OhBoy =
			{
				AnimationName = "StatusIconOhBoy",
				SoundName = "/SFX/GhostEmotes/SmileSMALL"
			},
			Determined =
			{
				AnimationName = "StatusIconDetermined",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			FiredUp =
			{
				AnimationName = "StatusIconFiredUp",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			Victory =
			{
				AnimationName = "StatusIconVictory",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
		},
	},

	LargeEmotes =
	{
		Emotes =
		{
			Smile =
			{
				AnimationName = "StatusIconSmile",
				SoundName = "/SFX/GhostEmotes/SmileLARGE"
			},
			Fear =
			{
				AnimationName = "StatusIconFear",
				SoundName = "/SFX/GhostEmotes/FearLARGE"
			},
			Disgruntled =
			{
				AnimationName = "StatusIconDisgruntled",
				SoundName = "/SFX/GhostEmotes/DisgruntledLARGE"
			},
			Embarrassed =
			{
				AnimationName = "StatusIconEmbarrassed",
				SoundName = "/SFX/GhostEmotes/EmbarrassedLARGE"
			},
			Grief =
			{
				AnimationName = "StatusIconGrief",
				SoundName = "/SFX/GhostEmotes/GriefLARGE"
			},
			OhBoy =
			{
				AnimationName = "StatusIconOhBoy",
				SoundName = "/SFX/GhostEmotes/SmileLARGE"
			},
			Determined =
			{
				AnimationName = "StatusIconDetermined",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			FiredUp =
			{
				AnimationName = "StatusIconFiredUp",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
			Victory =
			{
				AnimationName = "StatusIconVictory",
				SoundName = "/SFX/GhostEmotes/Smile"
			},
		},
	},

	BaseGhost =
	{
		InheritFrom = { "BaseDestructible", "BaseEmotes" },
		OnKillGlobalVoiceLines = "ShadeKilledVoiceLines",
		KillsRequiredForVoiceLines = 10,
		EmoteReactionOnCollide = true,
	},

	TartarusGhost01 =
	{
		InheritFrom = { "BaseGhost" },

		MaxHealth = 1,

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					ScaleMin = 0.7,
					ScaleMax = 1.0,

					AlphaMin = 0.5,
					AlphaMax = 1.0,
				},
			}
		},
	},

	BigGhost01 =
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					Alpha = 0.0,
				},
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					AlphaMin = 0.5,
					AlphaMax = 1.0,
					Duration = 0.3,
				},
			},
		},
	},

	MediumGhost01 =
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					Alpha = 0.0,
				},
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					AlphaMin = 0.5,
					AlphaMax = 1.0,
					Duration = 0.3,
				},
			}
		},
	},

	BartenderGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	BrokerGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	BadgeSellerGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	ChefGhost01 =
	{
		InheritFrom = { "BaseGhost" },
		InteractDistance = 220,
		InteractOffsetX = -30,
		InteractOffsetY = -90,
	},

	SmallGhost01 =
	{
		InheritFrom = { "BaseGhost", "TinyEmotes" },
		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					Alpha = 0.0,
				},
			},
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					AlphaMin = 0.5,
					AlphaMax = 1.0,
					Duration = 0.3,
				},
			}
		},
	},

	TallGhost01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					AlphaMin = 0.5,
					AlphaMax = 1.0,
				},
			}
		},
		EmoteOffsetZ = 90,
	},

	ShadeHubGuardIdle01 =
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
		EmoteOffsetZ = 250,
	},

	ShadeHubMIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	
	ShadeHubSIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubLIdle01=
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
	},

	ShadeHubLNecklaceIdle01=
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
	},

	ShadeHubTIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubTBowtieIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubTChefIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubBerriesIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubBroomIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubGarlicIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubHatIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubTowelIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubWaterIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeAsphodelIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeElysiumIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},
	ShadeErebusIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	AdminGhost01 =
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 120,
	},

	AsphodelGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	ElysiumGhost01 =
	{
		InheritFrom = { "BaseGhost" },
	},

	GhostInspectPoint =
	{
		UseText = "UseGhostInspectPoint",
		SpecialInteractFunctionName = "UseGhostInspectPoint",
	},

	InspectPoint =
	{
		OnUsedFunctionName = "UseInspectPoint",
		TextLinesUseWeaponIdle = true,
		LineHistoryName = "Speaker_Anonymous",
		SubtitleColor = Color.NarratorVoice,
		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					LineHistoryName = "Speaker_Homer",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
					},
				},
			},
		},
	},

	OverlookPoint =
	{
		OnUsedFunctionName = "OverlookAdvanced",
	},

	TartarusPillarBase04 =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TartarusPillarBase04A-Fx",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusPillarBase04A",
		},
	},

	TartarusPillarBase04A =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TartarusPillarBase04B-Fx",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusPillarBase04B",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	TartarusPillarBase04B =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TartarusPillarBase04C-Fx",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 4,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusPillarBase04C",
			CausesOcclusion = false,
		},
	},

	TartarusPillarBase04C =
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

	TimeTrap =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "TimeTrapDamaged",
			RequiredHitsForImpactReaction = 3,
			SwapData = "TimeTrapA",
		},
	},

	TimeTrapA =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			ReactionShake = true,
			ReactionShakeDuration = 1.1,
			Sound = "/SFX/Enemy Sounds/Hades/HadesLaserBlastChargeUp",
			Animation = "TimeTrapDestroyed",
			RequiredHitsForImpactReaction = 4,
			SwapData = "TimeTrapB",
			-- GlobalVoiceLines = "BreakingStuffVoiceLines",

			FireProjectileData =
			{
				ProjectileName = "TimeTrapStasis",
				FireAsPlayerProjectile = true,
				FireProjectileAtSelf = true,
				FireFromTarget = true,
			},
		},
	},

	TimeTrapB =
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

	TartarusHalfPillarBase04 =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "Tilesets\\Tartarus\\Tartarus_HalfPillarBase_04A",
			RequiredHitsForImpactReaction = 3,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusHalfPillarBase04A",
		},
	},

	TartarusHalfPillarBase04A =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "Tilesets\\Tartarus\\Tartarus_HalfPillarBase_04B",
			RequiredHitsForImpactReaction = 5,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusHalfPillarBase04B",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	TartarusHalfPillarBase04B =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "Tilesets\\Tartarus\\Tartarus_HalfPillarBase_04C",
			RequiredHitsForImpactReaction = 7,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 4,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "TartarusHalfPillarBase04C",
		},
	},

	TartarusHalfPillarBase04C =
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

	ElysiumRubble04 =
	{
		MaxHealth = 1,
		InheritFrom = { "BaseDestructible" },

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnTouchdown =
		{
			Weapon = "RubbleFallElysium",
			DestroyOnDelay = 0.02,
		},
	},

	TartarusRubble02 =
	{
		MaxHealth = 1,
		InheritFrom = { "BaseDestructible" },
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		OnTouchdown =
		{
			Weapon = "RubbleFall",
			CrushTypes = { "TartarusCandles01", "TartarusCandles01b", },
		},

		AmmoDropOnDeath =
		{
			Chance = 0.20,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
	},

	TartarusRubble02b =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	TartarusRubble02c =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	TartarusRubble05 =
	{
		MaxHealth = 10,
		InheritFrom = { "BaseDestructible" },
	},

	TartarusRubble06 =
	{
		MaxHealth = 10,
		InheritFrom = { "BaseDestructible" },
	},

	RespawningCover =
	{
		InheritFrom = { "BaseDestructible" },
		SkipModifiers = false,
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		CannotDieFromDamage = true,
		SilentImpact = true,

		SetupEvents =
		{
			{
				FunctionName = "RandomizeObject",
				Args =
				{
					RandomizeSets =
					{
						{
							Graphic = { "RespawningCover01_Static" },
							Flip = true,
							OverwriteData =
							{
								RespawnAnimation = "RespawningCover01_Respawn",
							}
						},
						{
							Graphic = { "RespawningCover02_Static" },
							Flip = true,
							OverwriteData =
							{
								RespawnAnimation = "RespawningCover02_Respawn",
							}
						},
						{
							Graphic = { "RespawningCover03_Static" },
							Flip = true,
							OverwriteData =
							{
								RespawnAnimation = "RespawningCover03_Respawn",
							}
						},
					},
				},
			},
		},

		ImpactReaction =
		{
			Animation = "ErebusMushroomSplat",
			RequiredHitsForImpactReaction = 1,
			SwapData = "RespawningCover",

			FunctionName = "RespawningCoverDeath",

			PropertyChanges =
			{
				{
					ThingProperty = "StopsProjectiles",
					ChangeValue = false,
				},
				{
					ThingProperty = "StopsUnits",
					ChangeValue = false,
				},
				{
					ThingProperty = "DrawVfxOnTop",
					ChangeValue = true,
				},
				{
					ThingProperty = "StopsLight",
					ChangeValue = false,
				},
			},
		},
		CollisionReactions =
		{
			{
				Animation = "ErebusMushroomSplat",
				SwapData = "RespawningCover",

				FunctionName = "RespawningCoverDeath",

				PropertyChanges =
				{
					{
						ThingProperty = "StopsProjectiles",
						ChangeValue = false,
					},
					{
						ThingProperty = "StopsUnits",
						ChangeValue = false,
					},
					{
						ThingProperty = "DrawVfxOnTop",
						ChangeValue = true,
					},
					{
						ThingProperty = "StopsLight",
						ChangeValue = false,
					},
				},
			}
		},
		RespawnReaction =
		{
			PropertyChanges =
			{
				{
					ThingProperty = "StopsProjectiles",
					ChangeValue = true,
				},
				{
					ThingProperty = "StopsUnits",
					ChangeValue = true,
				},
				{
					ThingProperty = "DrawVfxOnTop",
					ChangeValue = false,
				},
				{
					ThingProperty = "StopsLight",
					ChangeValue = true,
				},
			},
		},
	},

	TartarusRubble03 =
	{
	},

	AsphodelRock02 =
	{
		MaxHealth = 75,
		InheritFrom = { "BaseDestructible" },
	},

	AsphodelBoulder01 =
	{
		MaxHealth = 150,
		InheritFrom = { "BaseDestructible" },
	},

	AsphodelPillar06 =
	{
		Material = "Stone",

		OnTouchdown =
		{
			Weapon = "RubbleFall",
		},

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "AsphodelPillar06A",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelPillar06A",
		},
	},

	AsphodelPillar06A =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "AsphodelPillar06B",
			RequiredHitsForImpactReaction = 4,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelPillar06B",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
			CausesOcclusion = false,
		},
	},

	AsphodelPillar06B =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "AsphodelPillar06C",
			RequiredHitsForImpactReaction = 5,
			SpawnObstacle = "AsphodelSkull",
			ForceSpawnToValidLocation = true,
			SpawnAmount = 1,
			SpawnOffsetXMin = 0,
			SpawnOffsetXMax = 0,
			SpawnOffsetYMin = -100,
			SpawnOffsetYMax = -100,
			SpawnOffsetZ = 2000,
			ShakeScreenSpeed = 100,
			ShakeScreenDistance = 5,
			ShakeScreenFalloffSpeed = 1000,
			ShakeScreenDuration = 0.5,
			FallForce = 8000,
			SpawnScaleMin = 1.0,
			SpawnScaleMax = 1.0,
			SwapData = "AsphodelPillar06C",
			CausesOcclusion = false,
		},
	},

	AsphodelPillar06C =
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

	AsphodelBricksquare02 =
	{
		Material = "StoneObstacle",
	},

	AsphodelPillar08 =
	{
		Material = "StoneObstacle",
	},

	AsphodelWallRock05 =
	{
		Material = "StoneObstacle",
	},

	AsphodelWallRock04 =
	{
		Material = "StoneObstacle",
	},

	AsphodelWallRock12 =
	{
		Material = "StoneObstacle",
	},

	AsphodelBricksquare02 =
	{
		Material = "StoneObstacle",
	},

	AsphodelTombstone01 =
	{
		Material = "StoneObstacle",
	},

	AsphodelTombstone01b =
	{
		Material = "StoneObstacle",
	},

	AsphodelBrazier01 =
	{
		Material = "Bone",
	},

	AsphodelBrazier02 =
	{
		Material = "Bone",
	},

	AsphodelBrazier03 =
	{
		Material = "Bone",
	},

	ElysiumPillar06 =
	{
		OnHitShake = { Distance = 6, Speed = 300, Duration = 0.15, },
		CollisionReactions =
		{
			{
				MinVelocity = 1200,
				Animation = "ElysiumPillar06B",
				SwapData = "ElysiumPillar06B",
				CausesOcclusion = false,
			}
		}
	},

	ElysiumPillar06B =
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

	ElysiumPillar05 =
	{
		Material = "Stone",
	},

	ElysiumDestructiblePillar =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "ElysiumPillarB",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "ElysiumRubble04", },
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "ElysiumDestructiblePillarB",
		},
	},

	ElysiumDestructiblePillarB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "ElysiumPillarC",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "ElysiumRubble04", },
			SpawnAmount = 3,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 150,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 130,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "ElysiumDestructiblePillarC",
			CausesOcclusion = false,
		},
	},

	ElysiumDestructiblePillarC =
	{
		Material = "Stone",

		OnSpawnFireFunctionName = "RegenerateElysiumPillar",
		RegenerateStartDelay = 1.0,
		RegenerateDuration = 5.0,
		RegenerateAs = "ElysiumDestructiblePillar",
		RegenerateAnimation = "ElysiumPillarRegenerate-Fx",

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

		RegenPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = true,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = false,
			},
		},
	},

	--[[DestructibleTree =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "DestructibleTreeStump",
			RequiredHitsForImpactReaction = 4,
			SwapData = "DestructibleTreeStump",

			FireWeaponData =
			{
				ProjectileName = "DestructibleTreeSplinter",
				BarrelLength = 30,
				FireTicksMin = 2,
				FireTicksMax = 4,
				FireInterval = 0.2,
				FireAsPlayerProjectile = true,
				FireProjectileAtSelf = true,
				FireFromTarget = true,
			},
		},
	},

	DestructibleTreeStump =
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

		RegenPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = true,
			},
			{
				ThingProperty = "DrawVfxOnTop",
				ChangeValue = false,
			},
		},
	},]]

	StyxDestructiblePillar =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "StyxPillarB",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "StyxDestructiblePillarA",
		},
	},

	StyxDestructiblePillarA =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "StyxPillarC",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 4,
			SpawnTimeMin = 0.12,
			SpawnTimeMax = 0.24,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "StyxDestructiblePillarB",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	StyxDestructiblePillarB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "StyxPillarD",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "TartarusRubble02", "TartarusRubble02b", "TartarusRubble02c", },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 8,
			SpawnTimeMin = 0.12,
			SpawnTimeMax = 0.24,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SpawnScaleMin = 0.2,
			SpawnScaleMax = 0.4,
			SwapData = "StyxDestructiblePillarC",
			CausesOcclusion = false,
		},
	},

	StyxDestructiblePillarC =
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


	AsphodelDestructibleStalagmite =
	{
		InheritFrom = { "BaseDestructible", },
		Material = "Stone",

		CollisionReactions =
		{
			{
				MinVelocity = 1000,
				KillSelf = true,
			}
		},

		OnTouchdown =
		{
			Weapon = "RubbleFall",
		},

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "AsphodelDestructibleStalagmiteA",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 200,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelDestructibleStalagmiteA",
		},
	},

	AsphodelDestructibleStalagmiteA =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "AsphodelDestructibleStalagmiteB",
			RequiredHitsForImpactReaction = 4,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 200,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelDestructibleStalagmiteB",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
			CausesOcclusion = false,
		},
	},

	AsphodelDestructibleStalagmiteB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		ImpactReaction =
		{
			Animation = "AsphodelDestructibleStalagmiteC",
			RequiredHitsForImpactReaction = 4,
			SpawnRandomObstacle = {"AsphodelTerrainRock01", "AsphodelTerrainRock02", "AsphodelTerrainRock03"},
			ForceSpawnToValidLocation = true,
			SpawnAmount = 2,
			SpawnOffsetXMin = 50,
			SpawnOffsetXMax = 200,
			SpawnOffsetYMin = 50,
			SpawnOffsetYMax = 150,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SpawnScaleMin = 0.10,
			SpawnScaleMax = 0.15,
			SwapData = "AsphodelDestructibleStalagmiteC",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
			CausesOcclusion = false,
		},
	},

	AsphodelDestructibleStalagmiteC =
	{
		Material = "Stone",

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = false,
			},
		},
	},

	AsphodelBoulder01 =
	{
		OnTouchdown =
		{
			Weapon = "RubbleFallLarge",
		},

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
	},

	AsphodelTerrainRock01 =
	{
		InheritFrom = { "BaseDestructible" },
		MaxHealth = 1,


		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		OnTouchdown =
		{
			Weapon = "RubbleFall",
		},

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
	},

	AsphodelTerrainRock02 =
	{
		InheritFrom = {"AsphodelTerrainRock01"},
	},

	AsphodelTerrainRock03 =
	{
		InheritFrom = {"AsphodelTerrainRock01"},
	},

	AsphodelSkull =
	{
		MaxHealth = 100,
		InheritFrom = { "BaseDestructible" },

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },
		OnTouchdown =
		{
			Weapon = "RubbleFallLarge",
		},

		AmmoDropOnDeath =
		{
			Chance = 1.0,
			MinAmmo = 1,
			MaxAmmo = 1,
		},
	},

	AsphodelLavaJelly01 =
	{
		InheritFrom = { "BaseDestructible" },
		MaxHealth = 1,
	},

	CharonTogglePillar =
	{
		ToggleOnAnimation = "CharonTogglePillarToggleOn",
		ToggleOffAnimation = "CharonTogglePillarToggleOff",
		ToggledOn = true,
	},

	CapturePointSwitch =
	{
		UseText = "UseCapturePointSwitch",
		OnUsedFunctionName = "StartCapturePointEncounter",
	},

	ChallengeSwitchBase =
	{
		UsingSpawn = "ChallengeSwitch",
	},

	ChallengeSwitch =
	{
		UseText = "UseChallengeSwitch_Locked",
		ChallengeText = "ChallengeSwitch_Value",
		OverheadTextFont = "P22UndergroundSCMedium",
		-- OverheadTextSymbolScale = 0.65,
		--ChallengeAvailableUseText = "UseChallengeSwitch_Unlocked",
		--ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		OnUsedFunctionName = "AttemptUseChallengeSwitch",
		ChallengeSwitchUseFunctionName = "UseChallengeSwitch",
		CannotUseText = "ChallengeSwitchBlockedByEncounter",
		CannotAffordText = "ChallengeSwitchCannotAfford",
		LockedAnimationName = "ChallengeSwitchLocked",
		ReadyToOpenAnimationName = "ChallengeSwitchReadyToOpen",
		UnlockedAnimationName = "ChallengeSwitchUnlocked",
		BlockDuringChallenge = true,
		UsePromptOffsetX = 40,
		RewardType = "Money",
		CooldownNamePrefix = "ChallengeSwitch",
		CooldownDuration = 1.5,
		UseLootDecay = true,

		LockKeyTextOffsetY = -75,
		LockKeyTextOffsetX = 0,
		TextAnchorIdOffsetX = -40,
		TextAnchorIdOffsetY = -50,

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeChallengeSwitches1" },
				},
			},
			WithinDistance = 500,
			VoiceLines =
			{
				Queue = "Always",
				PlayOnce = true,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0278", Text = "One of the family Troves..." },
			}
		},

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "Tallness",
				ChangeValue = 225,
			},
			{
				ThingProperty = "StopsProjectiles",
				ChangeValue = true,
			},
		},
	},

	CapturePointChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },
		UseLootDecay = false,

		LockedAnimationName = "ChallengeSwitchLocked",
		ReadyToOpenAnimationName = "ChallengeSwitchReadyToOpen",
		UnlockedAnimationName = "ChallengeSwitchUnlocked",
		FailedAnimationName = "ChallengeSwitchFailed",


		ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		ChallengeFailedUseText = "UseChallengeSwitch_Failed",
	},

	CapturePointChallengeSwitch_MetaCardPoints =
	{
		InheritFrom = { "CapturePointChallengeSwitch" },

		ChallengeText = "ChallengeSwitch_MetaCardPointsValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_MetaCardPoints_Unlocked",
		RewardType = "MetaCardPointsCommonDrop",
		Requirements =
		{
		},
	},
	CapturePointChallengeSwitch_MemPoints =
	{
		InheritFrom = { "CapturePointChallengeSwitch" },

		ChallengeText = "ChallengeSwitch_MemPointsValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_MemPoints_Unlocked",
		RewardType = "MemPointsCommonDrop",
		Requirements =
		{
		},
	},
	CapturePointChallengeSwitch_MaxMana =
	{
		InheritFrom = { "CapturePointChallengeSwitch" },

		ChallengeText = "ChallengeSwitch_MaxManaValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_MaxMana_Unlocked",
		RewardType = "MaxManaDrop",
		Requirements =
		{
		},
		ExtractValues =
		{
			{
				External = true,
				BaseType = "ConsumableData",
				BaseName = "MaxManaDrop",
				BaseProperty = "AddMaxMana",
				ExtractAs = "TooltipMaxMana",
				SkipAutoExtract = true,
			},
		},
	},

	PerfectClearChallengeSwitch_Pom =
	{
		InheritFrom = { "ChallengeSwitch" },
		UseLootDecay = false,

		ChallengeText = "ChallengeSwitch_PomValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_Pom_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		RewardType = "StackUpgrade",
		Requirements =
		{
		},
	},
	PerfectClearChallengeSwitch_MaxHealth =
	{
		InheritFrom = { "ChallengeSwitch" },
		UseLootDecay = false,

		ChallengeText = "ChallengeSwitch_MaxHealthValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_MaxHealth_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		RewardType = "MaxHealthDrop",
		Requirements =
		{
		},
	},

	-- StartingValue in EncounterData is the base value
	MoneyTimeChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },
		ChallengeAvailableUseText = "UseChallengeSwitch_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_MoneyRewardAvailable",
		RewardMultiplier = 1.0,
		IntervalMultiplier = 0.3,
		Requirements =
		{
			--RequiredCosmetics = { "ChallengeSwitches1" },
			--RequiredFalseCosmetics = { "ChallengeSwitches2" },
		},
	},

	MoneyTimeChallengeSwitch2 =
	{
		InheritFrom = { "MoneyTimeChallengeSwitch" },
		RewardMultiplier = 1.25,
		IntervalMultiplier = 0.2,
		DifficultyMultiplier = 1.3,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches2" },
			RequiredFalseCosmetics = { "ChallengeSwitches3" },
		},
	},

	MoneyTimeChallengeSwitch3 =
	{
		InheritFrom = { "MoneyTimeChallengeSwitch" },
		RewardMultiplier = 1.5,
		IntervalMultiplier = 0.2,
		DifficultyMultiplier = 1.6,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches3" },
		},
	},

	HealthTimeChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },
		ChallengeText = "ChallengeSwitch_HealthValue",
		ChallengeAvailableUseText = "UseHealthChallengeSwitch_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_HealthRewardAvailable",
		RewardType = "Health",
		RewardMultiplier = 0.5,
		IntervalMultiplier = 0.2,
		DifficultyMultiplier = 0.7,
		Requirements =
		{
			--RequiredCosmetics = { "ChallengeSwitches1" },
			--RequiredFalseCosmetics = { "ChallengeSwitches2" },
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "TimeChallenge" },
			},
		},

	},

	HealthTimeChallengeSwitch2 =
	{
		InheritFrom = { "HealthTimeChallengeSwitch" },
		RewardMultiplier = 1.25,
		DifficultyMultiplier = 1.2,
		IntervalMultiplier = 0.2,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches2" },
			RequiredFalseCosmetics = { "ChallengeSwitches3" },
		},
	},

	HealthTimeChallengeSwitch3 =
	{
		InheritFrom = { "HealthTimeChallengeSwitch" },
		RewardMultiplier = 1.50,
		DifficultyMultiplier = 1.4,
		IntervalMultiplier = 0.2,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches3" },
		},
	},

	MetaCurrencyTimeChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },
		UseText = "UseChallengeSwitch_Locked",
		ChallengeText = "ChallengeSwitch_MetaCurrencyValue",
		ChallengeAvailableUseText = "UseMetaCurrencyChallengeSwitch_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_MetaCurrencyRewardAvailable",
		RewardMultiplier = 1.5,
		RewardType = "MetaCurrency",
		IntervalMultiplier = 0.2,
		DifficultyMultiplier = 0.7,
		Requirements =
		{
			--RequiredCosmetics = { "ChallengeSwitches1" },
			--RequiredFalseCosmetics = { "ChallengeSwitches2" },
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "TimeChallenge" },
			},
		},
	},

	MetaCurrencyTimeChallengeSwitch2 =
	{
		InheritFrom = { "MetaCurrencyTimeChallengeSwitch" },
		RewardMultiplier = 1.0,
		IntervalMultiplier = 0.2,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches2" },
			RequiredFalseCosmetics = { "ChallengeSwitches3" },
		},
	},

	MetaCurrencyTimeChallengeSwitch3 =
	{
		InheritFrom = { "MetaCurrencyTimeChallengeSwitch" },
		RewardMultiplier = 1.5,
		IntervalMultiplier = 0.2,
		Requirements =
		{
			RequiredCosmetics = { "ChallengeSwitches3" },
		},
	},

	-- Well of Charon
	WellShop =
	{
		UseText = "UseWell_Locked",
		AvailableUseText = "UseWell_Unlocked",
		OnUsedFunctionName = "AttemptUseChallengeSwitch",
		ChallengeSwitchUseFunctionName = "UseWellShop",
		CannotUseText = "WellShopBlockedByEncounter",
		BlockDuringChallenge = true,

		UsePromptOffsetX = 40,

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "Tallness",
				ChangeValue = 225,
			},
		},

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWellShops" },
				},
			},
			WithinDistance = 500,
			VoiceLines =
			{
				Queue = "Always",
				PlayOnce = true,
				BreakIfPlayed = true,
				RandomRemaining = true,
				UsePlayerSource = true,
				PlayOnceFromTableThisRun = true,

				{ Cue = "/VO/MelinoeField_1440", Text = "One of Lord Charon's Wells..." },
				{ Cue = "/VO/MelinoeField_1534", Text = "That's one of Lord Charon's Wells...", PlayFirst = true },
			}
		},

	},

	-- Chaos Gate
	SecretDoor =
	{
		InheritFrom = { "ExitDoor", },
		HideRewardPreview = true,
		AllowReroll = false,

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		UseText = "UseSecretDoor_Locked_PreReward",
		LockedUseText = "UseSecretDoor_Locked_PostReward",
		UnlockedUseText = "UseSecretDoor_Unlocked",
		UnlockedUseTextCannotReroll = "UseSecretDoor_Unlocked",

		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",

		ExitFunctionName = "LeaveRoomSecretDoorPresentation",
		HideDoorHealPresentation = true,

		ExitDoorOpenAnimation = "SecretDoor_Revealed",
		ExitDoorCloseAnimation = "SecretDoor_Closed",
		UnlockedAnimation = "SecretDoor_Revealed",
		UnlockedSound = "/SFX/Menu Sounds/ChaosBoonChange",
		UnlockedGlobalVoiceLines = "ChaosSecretUnlockedVoiceLines",
		SpeakerName = "Chaos",

		NemesisTeleport = true,

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "Chaos_01", "Chaos_02", "Chaos_03", "Chaos_04", "Chaos_05", "Chaos_06" },
				},
			},
			WithinDistance = 480,
			VoiceLines =
			{
				Queue = "Always",
				PlayOnce = true,
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0773", Text = "Some sort of gateway on the ground...!" },
			}
		},

	},

	SecretExitDoor =
	{
		InheritFrom = { "SecretDoor", },
		HideRewardPreview = false,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		IconSortMode = "Isometric",

		UnlockedUseText = "UseExitSecretRoom",
		ExitFunctionName = "LeaveRoomSecretExitDoorPresentation",

		UnlockedUseTextReroll = "UseExitSecretRoom_Reroll",
		UnlockedUseTextCannotReroll = "UseExitSecretRoom_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		ExitPortalSound = "/SFX/Menu Sounds/SecretDoorExitShimmer",
	},

	TrialUpgrade =
	{
		DistanceTrigger =
		{
			GameStateRequirements =
			{
			},
			WithinDistance = 450,
			VoiceLines =
			{
				Queue = "Always",
				PlayOnce = true,
				PreLineWait = 0.3,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "TestAllThings" },
					},
					{
						PathFalse = { "GameState", "UseRecord", "TrialUpgrade" },
					},
				},

				{ Cue = "/VO/MelinoeField_0777", Text = "{#Emph}Who {#Prev}in the...?" },
			}
		},

	},

	ShrinePointDoor =
	{
		CostBase = 2,
		CostPerDepth = 2,

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 1,
		IconSortMode = "Isometric",

		OverheadTextFontSize = 14,
		OverheadTextOffset = -150,
		OverheadTextColor = Color.DarkOrange,

		UseText = "UseShrinePointDoor_Locked_PreReward",
		LockedUseText = "UseShrinePointDoor_Locked_PostReward",
		UnlockedUseText = "UseShrinePointDoor_Unlocked",
		UnlockedUseTextReroll = "UseShrinePointDoor_Unlocked_Reroll",
		UnlockedUseTextCannotReroll = "UseShrinePointDoor_Unlocked_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",
		ExitPortalSound = "/SFX/HeatCollectionPickup",

		OnUsedPresentationFunctionName = "ShrinePointDoorUsedPresentation",

		--ExitFunctionName = "ExitSecretRoomPresentation",
		EntranceVfx = "SecretDoorDiveFx_Shrine",
		EntranceColorGrade = "SmokeTrap",

		ExitDoorOpenAnimation = "ShrinePointDoor_Revealed",
		ExitDoorCloseAnimation = "ShrinePointDoor_Revealed",
		UnlockedAnimation = "ShrinePointDoor_Revealed",
		UnlockedSound = "/SFX/HeatCollectionPickup",

		ExitBlockedByShrinePointsVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.25,
			CooldownTime = 9,

			-- TKTK
		},
	},

	ShrinePointExitDoor =
	{
		SetupEvents =
		{
			{
				FunctionName = "SetupDefaultDoor",
			},
		},

		UsePromptOffsetY = -5,
		UsePromptOffsetX = 60,

		RewardPreviewOffsetZ = 120,
		RewardPreviewOffsetY = 0,
		IconSortMode = "Isometric",

		UseText = "UseSecretDoor_Locked_PreReward",
		LockedUseText = "UseSecretDoor_Locked_PostReward",
		UnlockedUseText = "UseExitSecretRoom",
		UnlockedUseTextReroll = "UseExitSecretRoom_Reroll",
		UnlockedUseTextCannotReroll = "UseExitSecretRoom_CannotReroll",
		RerollFunctionName = "AttemptRerollDoor",
		AllowReroll = true,

		-- UseSound = "/Leftovers/SFX/NomadSprint",
		LockedUseSound = "/Leftovers/SFX/OutOfAmmo2",
		UnlockedUseSound = "/Leftovers/SFX/NomadSprint",
		ExitPortalSound = "/SFX/HeatCollectionPickup",

		ExitDoorOpenAnimation = "ShrinePointDoor_Revealed",
		ExitDoorCloseAnimation = "ShrinePointDoor_Revealed",
		UnlockedAnimation = "ShrinePointDoor_Revealed"
	},

	FishingPoint =
	{
		UseText = "UseFishingPoint",
		NoToolUseText = "UseFishingPointLocked",
		ExitsLockedUseText = "UseFishingPointLocked",
		AggroedUnitsUseText = "UseFishingPointLocked",
		OnUsedFunctionName = "UseFishingPoint",
		ExitsUnlockedFunctionName = "FishingPointAvailablePresentation",
		FamiliarUseText = "UseFishingPointFamiliar",
		LinkedToolName = "ToolFishingRod",
		DistanceTrigger =
		{
			GameStateRequirements =
			{
				-- RequiredCosmetics = { "FishingUnlockItem", },
			},
			WithinDistance = 500,
			VoiceLines =
			{
				TriggerCooldowns = { "MelStartedFishingSpeech", },
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.25,
					UsePlayerSource = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" },
						},
						{
							PathEmpty = { "RequiredKillEnemies" },
						},
						{
							PathTrue = { "CurrentRun", "CurrentRoom", "ExitsUnlocked" },
						},
						RequiresNotFishing = true,
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
						{ Name = "MelinoeFishingPointSpeech", Time = 600 },
					},

					{ Cue = "/VO/Melinoe_0751", Text = "A fishing point." },
					{ Cue = "/VO/Melinoe_0752", Text = "Fishing point there." },
					{ Cue = "/VO/MelinoeField_1340", Text = "A fish is near..." },
					{ Cue = "/VO/MelinoeField_1341", Text = "I sense a fish..." },
				},
			}
		},
	},

	FamiliarKit =
	{
		UseText = "UseFamiliarUnequip",
	},

	HarvestPoint =
	{
		UseText = "UseHarvestPoint",
		SetupEvents =
		{
			{
				FunctionName = "ActivateHarvestPointBase",
				Args =
				{
				},
			}
		},
		OnUsedFunctionName = "UseHarvestPoint",
		ExitsUnlockedFunctionName = "HarvestPointAvailablePresentation",
	},

	PickaxePoint =
	{
		UseText = "UsePickaxePoint",
		NoToolUseText = "UsePickaxePointNoTool",
		FamiliarUseText = "UsePickaxePointFamiliar",
		LinkedToolName = "ToolPickaxe",
		SetupEvents =
		{
			{
				FunctionName = "ActivateHarvestPointBase",
				Args =
				{
				},
			}
		},
		OnUsedFunctionName = "UsePickaxePoint",
		ExitsUnlockedFunctionName = "HarvestPointAvailablePresentation",

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WeaponsUnlocked", "ToolPickaxe" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F", },
				},
				{
					Path = { "GameState", "LifetimeResourcesGained", "OreFSilver" },
					Comparison = "<=",
					Value = 12,
				},
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
			},
			WithinDistance = 450,
			VoiceLines =
			{
				Queue = "Always",
				PlayOnce = true,
				PreLineWait = 0.3,
				UsePlayerSource = true,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/Melinoe_1914", Text = "There's some raw silver I can use..." },
			}
		},
	},

	SafeZone =
	{
		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeErebusSafeZones" },
				},
			},
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

	ShovelPoint =
	{
		UseText = "UseShovelPoint",
		LinkedToolName = "ToolShovel",
		SetupEvents =
		{
			{
				FunctionName = "ActivateHarvestPointBase",
				Args =
				{
				},
			}
		},
		OnUsedFunctionName = "UseShovelPoint",
		UnavailableAnimation = "ShovelPointUnavailable",
		ExitsUnlockedFunctionName = "HarvestPointAvailablePresentation",
	},

	ExorcismPoint =
	{
		InheritFrom = { "BaseEmotes" },
		EmoteOffsetZ = 0,
		UseText = "UseExorcismPoint",
		NoToolUseText = "UseExorcismPointNoTool",
		GetUseTextFunctionName = "ExorcismPointGetUseText",
		LinkedToolName = "ToolExorcismBook",
		FamiliarUseText = "UseExorcismPointFamiliar",
		OnUsedFunctionName = "UseExorcismPoint",
		ExitsUnlockedFunctionName = "HarvestPointAvailablePresentation",
	},

	GhostRecruit =
	{
		InheritFrom = { "BaseEmotes" },
		EmoteOffsetZ = 0,
		UseText = "UseGhostRecruit",
		SpecialInteractFunctionName = "GhostRecruitSpecialInteractPresentation",
		RecruitedAnimation = "ExorcismPointGhostUnavailable",

		SetupEvents =
		{
			{
				Threaded = true,
				FunctionName = "CheckDistanceTriggerThread",
				Args =
				{
					WithinDistance = 100,
					ScaleY = 0.6,
					PostTriggerFunctionName = "GenericPresentation",
					PostTriggerFunctionArgs =
					{
						SetAlpha = 0.0,
						Duration = 0.3,
						AddInteractBlock = "GhostRecruitDisappear",
					},
					Repeat = true,
					RepeatBufferDistance = 50,
					OnRepeatFunctionName = "GenericPresentation",
					OnRepeatFunctionArgs =
					{
						SetAlpha = 1.0,
						Duration = 0.5,
						RemoveInteractBlock = "GhostRecruitDisappear",
					},
				},
			},
		},
	},

	BoatGate =
	{
		UseText = "UseEnterBoat",
		UseSound = "/Leftovers/SFX/NomadSprint",
		ExitDoorOpenAnimation = "HealthGate_Revealed",
		ExitDoorCloseAnimation = "HealthGate_Revealed",
	},

	GlowPulseBSlow =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	CandleWisp =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	CandleFlame =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
			ReactionSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
		},
		ReappearSound =	"/Leftovers/World Sounds/Caravan Interior/CandleBlow",
	},
	LightEllipse02Anim =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	TartarusFlame =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
			ReactionSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
		},
		ReappearSound =	"/Leftovers/World Sounds/Caravan Interior/CandleBlow",
	},
	TorchFlame =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
			ReactionSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
		},
		ReappearSound =	"/Leftovers/World Sounds/Caravan Interior/CandleBlow",
	},
	AtmosphereGlow01 =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	LightAngularCircle01 =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	LightEllipse02 =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	TartarusFireGlow =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	SmokeRising =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	SmokeRisingHardBright =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
		},
	},
	-- Family Portrait
	CrossroadsFamilyPortrait02 =
	{
		UseText = "UseFamilyPortrait",
		InteractDistance = 150,
		InteractOffsetY = 30,
		SetupGameStateRequirements =
		{
			-- RequiredTextLines = { "Ending01" },
		},
		DestroyIfNotSetup = true,
		OnUsedFunctionName = "ViewPortraitPresentation",
		OnUsedFunctionArgs = { PortraitAnimationName = "TentFamilyPortrait" },
	},

	-- Enemy Equipment Obstacles


	EnemyShield =
	{
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
		BeginPickupAnimation = "EnemyShieldPickupContainer",
		PickupFailedAnimation = "EnemyShieldIdleContainer",
	},

	EnemyBow =
	{
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
		BeginPickupAnimation = "EnemyBowPickupContainer",
		PickupFailedAnimation = "EnemyBowIdleContainer",
	},
	
	EnemySpear =
	{
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
		BeginPickupAnimation = "EnemySpearPickupContainer",
		PickupFailedAnimation = "EnemySpearIdleContainer",
	},

	EnemySword =
	{
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
		BeginPickupAnimation = "EnemySwordPickupContainer",
		PickupFailedAnimation = "EnemySwordIdleContainer",
	},

	EnemyDagger =
	{
		IsEnemyWeapon = true,
		UseText = "UseEnemyWeapon",
	},

	-- hades bed (pre-ending)
	HouseBed02 =
	{
		SetupGameStateRequirements =
		{
			RequiredFalseTextLines = { "PersephoneReturnsHome01" },
		},
		DestroyIfNotSetup = true,
	},
	HouseBed02a =
	{
		SetupGameStateRequirements =
		{
			RequiredTextLines = { "PersephoneReturnsHome01" },
		},
		DestroyIfNotSetup = true,
	},

	PortalSpawner =
	{
		ProximitySpawnTriggerEndAnimation = "PortalSpawnerOut",
		--CreateAnimationBetween = "FistVacuumFx",
		SpawnDelay = 0.3,
	},

	-- Walls
	_Impassable_Tile64IsoUnitsOnly_Tall =
	{
		HitText = "PitSlamHit",
	},
	_Impassable_Tile64IsoUnitsOnly_Short =
	{
		HitText = "PitSlamHit",
	},
	ClampWall_Left =
	{
		HitText = "PitSlamHit",
	},
	ClampWall_Right =
	{
		HitText = "PitSlamHit",
	},
	ClampWall_Top =
	{
		HitText = "PitSlamHit",
	},
	ClampWall_Bottom =
	{
		HitText = "PitSlamHit",
	},


	-- Skelly Statues
	CrossroadsMelStatue01 =
	{
		
	},
	CrossroadsMelStatue02 =
	{
		InheritFrom = { "CrossroadsMelStatue01" },
	},
	CrossroadsMelStatue03 =
	{
		InheritFrom = { "CrossroadsMelStatue01" },
	},

}

MaterialDefaults =
{
	ErebusTree = "BrickObstacle",
	ErebusWhiteTree0 = "BrickObstacle",
	ErebusShrub = "BushObstacle",
	ErebusStone = "StoneObstacle",
	ErebusOld = "StoneObstacle",
	ErebusRock = "StoneObstacle",
	F_Round = "StoneObstacle",

	-- Old from Minos
	Chains = "MetalObstacle",
	Sword = "MetalObstacle",
	Brick = "BrickObstacle",
	Pedestal = "StoneObstacle",
	Fence = "StoneObstacle",
	Door = "StoneObstacle",
	Gable = "StoneObstacle",
	Brick = "StoneObstacle",
	Pillar = "StoneObstacle",
	Rubble = "StoneObstacle",
	Brazier = "StoneObstacle",
	Statue = "StoneObstacle",
	Planter = "StoneObstacle",
	Bush = "BushObstacle",
	Urn = "PorcelainObstacle",
	Vase = "MetalObstacle",
	Wall = "StoneObstacle",
	Planter = "StoneObstacle",
	Tile = "StoneObstacle",
	Impassable = "StoneObstacle",
}