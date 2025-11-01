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
		UnlockedAnimation = "DoorExitLightSoftSW_Unlock_Transition",
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
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				PlayOnceFromTableThisRun = true,
				ObjectType = "NPC_Artemis_Field_01",
				SkipCooldownCheckIfNonePlayed = true,
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
				PlayOnceFromTableThisRun = true,
				ObjectType = "NPC_Icarus_01",
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
				},

				{ Cue = "/VO/Icarus_0298", Text = "Wait up...!" },
				{ Cue = "/VO/Icarus_0299", Text = "Hang on...", PlayFirst = true },
				{ Cue = "/VO/Icarus_0300", Text = "Talk to me, Meli...!" },
				{ Cue = "/VO/Icarus_0301", Text = "That's cold...!" },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				PlayOnceFromTableThisRun = true,
				ObjectType = "NPC_Dionysus_01",
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements = 
				{
					{
					},
				},
				Cooldowns =
				{
					{ Name = "DionysusSpokeRecently", Time = 3 },
				},

				{ Cue = "/VO/Dionysus_0117", Text = "{#Emph}Erm{#Prev}, hello?" },
				{ Cue = "/VO/Dionysus_0118", Text = "You just got here!" },
				{ Cue = "/VO/Dionysus_0119", Text = "Come on now." },
				{ Cue = "/VO/Dionysus_0120", Text = "Say hey to the host!" },
				{ Cue = "/VO/Dionysus_0121", Text = "Over here!" },
				{ Cue = "/VO/Dionysus_0122", Text = "One drink minimum." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				PreLineWait = 0.25,
				PlayOnceFromTableThisRun = true,
				ObjectType = "NPC_Athena_01",
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements = 
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H", },
					},
				},
				Cooldowns =
				{
					{ Name = "AthenaSpokeRecently", Time = 3 },
				},

				{ Cue = "/VO/Athena_0119", Text = "A word before you go." },
				{ Cue = "/VO/Athena_0120", Text = "Wait, Cousin." },
				{ Cue = "/VO/Athena_0121", Text = "First let us speak.", PlayFirst = true },
				{ Cue = "/VO/Athena_0122", Text = "I don't have all night..." },
				{ Cue = "/VO/Athena_0123", Text = "I'm not to be ignored." },
				{ Cue = "/VO/Athena_0124", Text = "Over here." },
			},
			{ GlobalVoiceLines = "ErisAttemptedExitVoiceLines" },
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
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_0727", Text = "Something I should get here first..." },
				{ Cue = "/VO/MelinoeField_0728", Text = "Shouldn't go just yet..." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlay = 0.5,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

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
		--[[InheritFrom = { "ExitDoor", },

		ExitThroughCenter = true,
		RewardPreviewOffsetZ = 0,
		RewardPreviewOffsetY = -360,
		RewardPreviewOffsetX = 0,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "ElysiumDoorUnlocked",
		ExitDoorOpenAnimation = "ElysiumDoorOpen",
		ExitDoorCloseAnimation = "ElysiumDoorClose",

		-- intentionally blank, on the anim
		UnlockedUseSound = "",]]
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
						ActivateFxPreSpawn = "TeleportDisappear",
						ActivateFxPreSpawnDelay = 0.2,
						ActivateFadeIn = true,
						ActivateFadeInDelay = 0.0,
						ActivateFadeInDuration = 0.0,
						ActivateTint = true,
						ActivateTintDelay = 0.0,
						ActivateTintDuration = 0.0,
						ActivateStartAlpha = 0, 
						ActivateDuration = 0.2,
					},
					OnKillVoiceLines = { GlobalVoiceLines = "ArachneCocoonNegativeReactionLines" },
				},
			},
			{
				Chance = 0.25,
				MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 3, MaxValue = 5, IgnoreRoomMoneyStore = true, },
				DataOverrides =
				{
					OnKillVoiceLines = { GlobalVoiceLines = "ArachneCocoonPositiveReactionLines" },
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
						ActivateFxPreSpawn = "TeleportDisappear",
						ActivateFxPreSpawnDelay = 0.2,
						ActivateFadeIn = true,
						ActivateFadeInDelay = 0.0,
						ActivateFadeInDuration = 0.0,
						ActivateTint = true,
						ActivateTintDelay = 0.0,
						ActivateTintDuration = 0.0,
						ActivateStartAlpha = 0, 
						ActivateDuration = 0.2,
					},
					OnKillVoiceLines = { GlobalVoiceLines = "ArachneCocoonNegativeReactionLines" },
				},
			},
			{
				Chance = 0.25,
				MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 6, MaxValue = 10, IgnoreRoomMoneyStore = true, },
				DataOverrides =
				{
					OnKillVoiceLines = { GlobalVoiceLines = "ArachneCocoonPositiveReactionLines" },
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
						ActivateFxPreSpawn = "TeleportDisappear",
						ActivateFxPreSpawnDelay = 0.2,
						ActivateFadeIn = true,
						ActivateFadeInDelay = 0.0,
						ActivateFadeInDuration = 0.0,
						ActivateTint = true,
						ActivateTintDelay = 0.0,
						ActivateTintDuration = 0.0,
						ActivateStartAlpha = 0, 
						ActivateDuration = 0.2,
					},
					OnKillVoiceLines = { GlobalVoiceLines = "ArachneCocoonNegativeReactionLines" },
				},
			},
			{
				Chance = 0.25,
				MoneyDropOnDeath = { Chance = 1.0, MinParcels = 1, MaxParcels = 1, MinValue = 14, MaxValue = 20, IgnoreRoomMoneyStore = true, },
				DataOverrides =
				{
					OnKillVoiceLines = { GlobalVoiceLines = "ArachneCocoonPositiveReactionLines" },
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
				MinVelocity = 780,
				KillSelf = true,
			}
		},
	},

	BaseBreakable =
	{
		InheritFrom = { "BaseDestructible" },
		GenusName = "Breakable",
		OnKillGlobalVoiceLines = "BreakableDestroyedVoiceLines",
		KillsRequiredForVoiceLines = 2,
		MeterMultiplier = 0,
		MaxHitShields = 0,
		DeathAnimation = "Blank",
		DeathSoundManagerCap = 36,

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 1,

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},

		CollisionReactions =
		{
			{
				MinVelocity = 780,
				KillSelf = true,
			}
		},

		BreakableValueOptions =
		{
			SetupEvents =
			{
				{
					FunctionName = "DistanceTrigger",
					Threaded = true,
					Args =
					{
						PreTriggerWait = 0.1,
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
				Chance = 0.01,
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
				Chance = 0.02,
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
				Chance = 0.02,
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
	},

	Breakable_F =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CocoonDestroy",
		DeathFx = "SpiderCocoonDisintegrate",
	},

	Breakable_Chaos =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CeramicPotSmash",
		DeathFx = "BreakableDeathAnim",
	},

	GiftRack =
	{
		UseText = "UseAwardMenu",
		OnUsedFunctionName = "UseKeepsakeRack",
		-- UseSound = "/Leftovers/World Sounds/Caravan Interior/CabinetClose",
		UsePromptOffsetX = 65,
		UsePromptOffsetY = -50,
		SpeakerName =
		{ 
			"AphroditeKeepsake", "ApolloKeepsake", "ArachneKeepsake", "AresKeepsake",
			"ArtemisKeepsake", "AthenaKeepsake", "ChaosKeepsake", "CharonKeepsake",
			"ChronosKeepsake", "CirceKeepsake", "DemeterKeepsake", "DionysusKeepsake",
			"DoraKeepsake", "EchoKeepsake", "ErisKeepsake", "HadesKeepsake", "HecateKeepsake",
			"HephaestusKeepsake", "HeraclesKeepsake", "HeraKeepsake", "HermesKeepsake", "HestiaKeepsake",
			"IcarusKeepsake", "MedeaKeepsake", "MorosKeepsake", "NarcissusKeepsake", "NemesisKeepsake",
			"OdysseusKeepsake", "PersephoneKeepsake", "PoseidonKeepsake", "SeleneKeepsake", "SkellyKeepsake",
			"ZagreusKeepsake", "ZeusKeepsake",
		},
		SetupEvents =
		{
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentHubRoom" },
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.AllRandomPackagedBounties,
					},
				},
				FunctionName = "GiftRackEquipRandomKeepsake",
			},
			{
				FunctionName = "UpdateGiftRackShineStatus",
				Args =
				{
				},
			},
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
			WithinDistance = 820,
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
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Chronos_01", }, Alive = false },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_0279", Text = "My Keepsakes manifest..." },
				},
				{
					UsePlayerSource = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					PlayOnceFromTableThisRun = true,
					SuccessiveChanceToPlay = 0.5,
					SuccessiveChanceToPlayAll = 0.25,
					SkipCooldownCheckIfNonePlayed = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							Path = { "CurrentRun", "ExpiredKeepsakes" },
							HasAny = GameData.AllExpiringKeepsakes,
						},
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Units = { "NPC_Chronos_01", "NPC_Chronos_02" }, Alive = false },
						},
						{
							FunctionName = "RequiredHealthFraction",
							FunctionArgs = { Comparison = ">=", Value = 0.2, },
						},
						{
							Path = { "CurrentRun", "ActiveBounty" },
							IsNone = GameData.AllRandomPackagedBounties,
						},
					},

					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
						{ Name = "MelSwitchKeepsakeHintVO", Time = 20 },
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
		AnimOffsetZ = 25,
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
		SpecialInteractCooldown = 60,
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

	CrossroadsAmbientFrogA =
	{
		InheritFrom = { "BaseIndestructibleNoShakeHitFx" },
		AllowResetup = true,
		GrannyTexture = "GR2/CritterFrogBrown_Color",
	},
	CrossroadsAmbientFrogB =
	{
		InheritFrom = { "CrossroadsAmbientFrogA" },
		GrannyTexture = "GR2/CritterFrogGreen_Color",
	},
	CrossroadsAmbientFrogC =
	{
		InheritFrom = { "CrossroadsAmbientFrogA" },
		GrannyTexture = "GR2/CritterFrogGrey_Color",
	},
	CrossroadsAmbientFrogD =
	{
		InheritFrom = { "CrossroadsAmbientFrogA" },
		GrannyTexture = "GR2/CritterFrogYellow_Color",
	},

	CrossroadsAmbientCatA =
	{
		AllowResetup = true,
		GrannyTexture = "GR2/CritterCatBicolor_Color",
		AmbientAnimations =
		{
			"Familiar_Cat_Sleep_Loop_Alt1",
			"Familiar_Cat_Sleep_Loop_Alt2",
			"Familiar_Cat_Sleep_Loop_Alt3",
			"Familiar_Cat_Sleep_Loop_Alt4",
		},
	},
	CrossroadsAmbientCatB =
	{
		InheritFrom = { "CrossroadsAmbientCatA" },
		GrannyTexture = "GR2/CritterCatBlack_Color",
	},
	CrossroadsAmbientCatC =
	{
		InheritFrom = { "CrossroadsAmbientCatA" },
		GrannyTexture = "GR2/CritterCatSpotted_Color",
	},
	CrossroadsAmbientCatD =
	{
		InheritFrom = { "CrossroadsAmbientCatA" },
		GrannyTexture = "GR2/CritterCatTabby_Color",
	},
	CrossroadsAmbientCatE =
	{
		InheritFrom = { "CrossroadsAmbientCatA" },
		GrannyTexture = "GR2/CritterCatTuxedo_Color",
	},
	CrossroadsAmbientCatF =
	{
		InheritFrom = { "CrossroadsAmbientCatA" },
		GrannyTexture = "GR2/CritterCatWhite_Color",
	},

	CrossroadsAmbientRatA =
	{
		AllowResetup = true,
		GrannyTexture = "GR2/CritterRatBeige_Color",
	},
	CrossroadsAmbientRatB =
	{
		InheritFrom = { "CrossroadsAmbientRatA" },
		GrannyTexture = "GR2/CritterRatBrown_Color",
	},
	CrossroadsAmbientRatC =
	{
		InheritFrom = { "CrossroadsAmbientRatA" },
		GrannyTexture = "GR2/CritterRatGrey_Color",
	},

	-- Nemesis Raven is the only 3D bird
	CrossroadsAmbientBirdC =
	{
		AllowResetup = true,
		GrannyTexture = "GR2/CritterRavenBlack_Color",
	},

	CrossroadsAmbientDogA =
	{
		AllowResetup = true,
		GrannyTexture = "GR2/CritterDogBeige_Color",
		AmbientAnimations =
		{
			"Familiar_Hound_HubHangout_1",
			"Familiar_Hound_HubHangout_5",
		},
		CosmeticAnimations =
		{
			"Familiar_Hound_HubHangout_1",
			"Familiar_Hound_HubHangout_2",
			"Familiar_Hound_HubHangout_3",
			"Familiar_Hound_HubHangout_4",
			"Familiar_Hound_HubHangout_5",
		},
	},
	CrossroadsAmbientDogB =
	{
		InheritFrom = { "CrossroadsAmbientDogA" },
		GrannyTexture = "GR2/CritterDogOrange_Color",
	},
	CrossroadsAmbientDogC =
	{
		InheritFrom = { "CrossroadsAmbientDogA" },
		GrannyTexture = "GR2/CritterDogTan_Color",
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
				RandomRemaining = true,
				PreLineWait = 0.85,
				GameStateRequirements =
				{
					ChanceToPlay = 0.15,
					{
						PathFalse = { "CurrentRun", "Hero", "TraitDictionary", "StaffRaiseDeadAspect" },
					},
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
							"ProjectileSwing5",
							"ProjectileSwing5Magic",
							"ProjectileStaffBallCharged",

							"ProjectileAxe",
							"ProjectileAxe2",
							"ProjectileAxe3",
							"ProjectileAxeSpecial",
							"ProjectileAxeOverhead",
							"ProjectileAxeSpin",
							"ProjectileAxeBlock2",
							
							"ProjectileTorchBall",
							"ProjectileTorchBallEos",
							"ProjectileTorchGhost",
							"ProjectileTorchGhostLarge",
							"ProjectileTorchGhostExplosion",
							"ProjectileTorchGhostLargeExplosion",
							"ProjectileTorchSpiral",
							"ProjectileTorchOrbit",
							"ProjectileTorchSupayBallEx",
							
							"ProjectileLob",
							"ProjectileLobCharged",
							"ProjectileLobChargedPulse",
							"ProjectileThrowBlink",
							"ProjectileThrowCharged",

							"ProjectileSuitCharged",
							"ProjectileSuitSplit",
							"ProjectileSuitSplit2",
							"ProjectileSuitRangedGuided",
							"ProjectileSuitRangedUnguided",
							"ProjectileSuitRangedCharged",
							"ProjectileSuitRangedChargedUnguided",
							"ProjectileSuitRangedGuidedSplit",
							"ProjectileSuitRangedChargedSplit",
							"NyxSprintBlast",

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

	CrossroadsCatScratcher01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibers",
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
			[1] = { GlobalVoiceLines = "UsedFountainVoiceLines" },
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
			[1] = { GlobalVoiceLines = "UsedFountainVoiceLines" },
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
			[1] = { GlobalVoiceLines = "UsedFountainVoiceLines" },
		},
	},
	
	ManaFountain =
	{
		UseText = "UseManaFountain",
		UseSound = "/SFX/MagicRefillSFX",
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
		EmoteOffsetZ = -50,
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
		EmoteOffsetZ = 50,
	},
	
	ShadeHubSIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		SpinOnCollide = true,
		EmoteReactionOnCollide = false,
		EmoteOffsetZ = 20,
	},

	ShadeHubLIdle01=
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
		EmoteOffsetZ = 20,
	},

	ShadeHubLNecklaceIdle01=
	{
		InheritFrom = { "BaseGhost", "LargeEmotes" },
	},

	ShadeHubTIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 90,
	},

	ShadeHubTBowtieIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubTChefIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubTChefIdle02=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 50,
	},

	ShadeHubBerriesIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 50,
	},

	ShadeHubBroomIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 50,
	},

	ShadeHubGarlicIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 50,
	},

	ShadeHubHatIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 50,
	},

	ShadeHubTowelIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	ShadeHubWaterIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
		EmoteOffsetZ = 30,
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

	ErebusRiverGhost_Interactive =
	{
		DistanceTrigger =
		{
			PreTriggerWait = 0.1,
			WithinDistance = 400,
			FunctionName = "RiverGhostPresentation",
			Args =
			{
				Animation = "ErebusRiverGhost_Reveal",
				PostWait = 1.0,
			},
			Repeat = true,
			OnRepeatFunctionName = "RiverGhostPresentation",
			OnRepeatFunctionArgs =
			{
				Animation = "ErebusRiverGhost_Hide",
				PostWait = 0.5,
			},
		},
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
				SkipCanAttack = true,
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
				MinVelocity = 780,
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

	AsphodelTerrainRock01 =
	{
		InheritFrom = { "BaseDestructible" },
		MaxHealth = 1,

		DeathFx = "AsphodelTerrainRockCollapse",

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

		DeathFx = "AsphodelSkullDeathFx",

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
		OpenAnimationName = "ChallengeSwitchOpen",
		UnlockedAnimationName = "ChallengeSwitchUnlocked",
		InProgressAnimationName = "ChallengeSwitchInProgress",

		BlockDuringChallenge = true,
		UsePromptOffsetX = 40,
		RewardType = "Money",
		CooldownNamePrefix = "ChallengeSwitch",
		CooldownDuration = 1.5,
		UseLootDecay = true,

		LockKeyTextOffsetY = -75,
		LockKeyTextOffsetX = 0,
		TextAnchorIdOffsetX = 0,
		TextAnchorIdOffsetY = 0,

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

	TimeChallengeSwitch_Money =
	{
		InheritFrom = { "ChallengeSwitch" },
		ChallengeAvailableUseText = "UseChallengeSwitch_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_MoneyRewardAvailable",
		-- StartingValue in EncounterData is the base value
		RewardMultiplier = 1.0,
		IntervalMultiplier = 0.3,
		Requirements =
		{
		},

		EncounterOptionsName = "TimeChallengeEncounterOptions",
	},

	PerfectClearSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },

		LockedAnimationName = "PerfectClearSwitchLocked",
		ReadyToOpenAnimationName = "PerfectClearSwitchReadyToOpen",
		UnlockedAnimationName = "PerfectClearSwitchUnlocked",
		UnlockedFxAnimationName = "PerfectClearSwitchFx_Unlocked",
		OpenAnimationName = "PerfectClearSwitchOpen",
		InProgressAnimationName = "PerfectClearSwitchInProgress",
		InProgressFxAnimationName = "PerfectClearSwitchFx_InProgress",
		CannotUseText = "ChallengeSwitchBlockedByEncounter_Alt",

		UseLootDecay = false,

		ValueTextAnchorOffsetY = -200,
		ValueTextAnchorOffsetX = -40,

		EncounterOptionsName = "PerfectClearEncounterOptions",

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeChallengeSwitchesExtra1" },
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_2768", Text = "An Unseen Sigil over there..." },
			}
		},  
	},

	PerfectClearChallengeSwitch_Pom =
	{
		InheritFrom = { "PerfectClearSwitch" },

		ChallengeText = "ChallengeSwitch_PomValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_Pom_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		RewardType = "StackUpgrade",
		Requirements =
		{
			Append = true,
			NamedRequirements = { "StackUpgradeLegal" },
		},
	},
	PerfectClearChallengeSwitch_MaxHealth =
	{
		InheritFrom = { "PerfectClearSwitch" },

		ChallengeText = "ChallengeSwitch_MaxHealthValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_MaxHealth_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		RewardType = "MaxHealthDrop",
		Requirements =
		{
		},
	},

	EliteChallengeSwitch =
	{
		InheritFrom = { "ChallengeSwitch" },

		LockedAnimationName = "EliteChallengeSwitchLocked",
		ReadyToOpenAnimationName = "EliteChallengeSwitchReadyToOpen",
		UnlockedAnimationName = "EliteChallengeSwitchUnlocked",
		UnlockedFxAnimationName = "EliteChallengeSwitchFx_Unlocked",
		OpenAnimationName = "EliteChallengeSwitchOpen",
		InProgressAnimationName = "EliteChallengeSwitchInProgress",
		InProgressFxAnimationName = "EliteChallengeSwitchFx_InProgress",
		CannotUseText = "ChallengeSwitchBlockedByEncounter_Alt",

		UseLootDecay = false,
		ValueTextAnchorOffsetY = -200,
		ValueTextAnchorOffsetX = 0,
		
		EncounterOptionsName = "EliteChallengeEncounterOptions",

		Requirements =
		{
			Append = true,
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 3,
			},
		},

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeChallengeSwitchesExtra1" },
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_2755", Text = "Moon Monument right over there..." },
			}
		},
	},

	EliteChallengeSwitch_Talent =
	{
		InheritFrom = { "EliteChallengeSwitch" },

		ChallengeText = "ChallengeSwitch_TalentDropValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_TalentDrop_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		RewardType = "TalentDrop",
		Requirements =
		{
			Append = true,
			NamedRequirements = { "TalentLegal", },
		},
	},
	EliteChallengeSwitch_MaxMana =
	{
		InheritFrom = { "EliteChallengeSwitch" },

		ChallengeText = "ChallengeSwitch_MaxManaValue",
		ChallengeAvailableUseText = "UseChallengeSwitch_MaxMana_Unlocked",
		ChallengeResolvedUseText = "UseChallengeSwitch_RewardAvailable",
		RewardType = "MaxManaDrop",
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_1440", Text = "One of Lord Charon's Wells..." },
				{ Cue = "/VO/MelinoeField_1534", Text = "That's one of Lord Charon's Wells...", PlayFirst = true },
			}
		},
	},

	-- Sell Shop
	SellTraitShop =
	{
		UseText = "UseTraitShop_Locked",
		AvailableUseText = "UseTraitShop_Unlocked",
		OnUsedFunctionName = "AttemptUseChallengeSwitch",
		ChallengeSwitchUseFunctionName = "OpenSellTraitMenu",
		CannotUseText = "SellTraitShopBlockedByEncounter",
		Animation = "SellTraitShopLocked",
		BlockDuringChallenge = true,
		UsePromptOffsetX = 40,

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "Tallness",
				ChangeValue = 225,
			},
		},

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					BlockedByRequirements = true,
					OnUsedFunctionName = "UseLockedSystemObjectPresentation",
					OnUsedFunctionArgs = { VoiceLines = "LockedSellTraitShopVoiceLines", CannotUseText = "UseBlockedByWorldUpgrade" },
					Animation = "SellTraitShopUnusable",
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgradesAdded" },
						HasNone = { "WorldUpgradeRestoreSellTraitShop", "WorldUpgradePostBossSellTraitShops" }
					},
					{
						PathFalse = { "GameState", "ScreensViewed", "SellTraits" },
					},
				},
			},
		},

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossSellTraitShops" },
				},
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "H_PostBoss01" },
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_2615", Text = "Another Pool of Purging, just as planned..." },
			}
		},

	},

	MetaRewardStand =
	{
		UseText = "UseMetaRewardStand_Locked",
		AvailableUseText = "UseMetaRewardStand_Unlocked",
		OnUsedFunctionName = "AttemptUseChallengeSwitch",
		ChallengeSwitchUseFunctionName = "UseMetaRewardStand",
		CannotUseText = "MetaRewardStandBlockedByEncounter",
		LockedUseSound = "/SFX/Player Sounds/ElectricZapSmall",
		ExitsUnlockedFunctionName = "HarvestPointAvailablePresentation",
		ExitsUnlockedFunctionArgs = { SkipVoiceLines = true },
		RewardIconScale = 1.0,

		RequiredShrinePoints = 12,

		SpawnPropertyChanges =
		{
			{
				ThingProperty = "Tallness",
				ChangeValue = 121,
			},
		},

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMetaRewardStands" },
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
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_3567", Text = "A Bounty of the Infinite Abyss..." },
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
				UsePlayerSource = true,
				SkipCooldownCheckIfNonePlayed = true,
				GameStateRequirements =
				{
					{
						PathEmpty = { "RequiredKillEnemies" },
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = "<",
						Value = 12,
					},
				},

				{ Cue = "/VO/MelinoeField_3665", Text = "Only Fear can break this free..." },
				{ Cue = "/VO/MelinoeField_3666", Text = "Too little Fear this night.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_3667", Text = "I swore an Oath..." },
				{ Cue = "/VO/MelinoeField_3668", Text = "Not frightening enough..." },
				{ Cue = "/VO/Melinoe_3519", Text = "I won't betray my vows." },
				{ Cue = "/VO/Melinoe_3520", Text = "I've not yet earned the right." },
			},
		},

	},
	
	ZagContract =
	{
		InheritFrom = { "ExitDoor", },
		
		HideRewardPreview = true,
		PercentOffText = 100, -- used for text

		UnlockedUseText = "UseForbiddenContract",
		SpawnSound = "/SFX/CharonMembershipCardDrop",
		ConsumeSound = "/SFX/CharonMembershipCardPickup",

		ExitDoorOpenAnimation = "ZagContractAccept",
		ExitDoorCloseAnimation = "ZagContract",
		UnlockedAnimation = "ZagContract",
		
		ExitFunctionName = "ContractExitPresentation",

		DistanceTrigger =
		{
			PreTriggerWait = 0.1,
			WithinDistance = 480,
			VoiceLines =
			{
				Queue = "Always",
				PlayOnce = true,
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_4281", Text = "What is that, some sort of parchmentwork...?" },
			},
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
		RewardFinderAnimation = "FieldsChaosExitRewardFinder",
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
				{ Cue = "/VO/MelinoeField_2868", Text = "A Chaos Gate, up here?",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "BiomesReached", "N" },
						}
					},
				},
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

	FamiliarKit =
	{
		UseText = "UseFamiliarUnequip",
	},

	HarvestPoint =
	{
		UseText = "UseHarvestPoint",
		FamiliarUseText = "UseHarvestPointFamiliar",
		LinkedToolName = "ToolHarvest",
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
		OnUsedOnExitFunctionName = "UseHarvestPointOnExit",
		SpeakerName = "Selene",
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
		OnUsedOnExitFunctionName = "UsePickaxePointOnExit",
		SpeakerName = "Selene",

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

				{ Cue = "/VO/Melinoe_1914", Text = "There's some raw Silver I can use..." },
			}
		},
	},

	ShovelPoint =
	{
		UseText = "UseShovelPoint",
		NoToolUseText = "UseShovelPointLocked",
		LinkedToolName = "ToolShovel",
		FamiliarUseText = "UseShovelPointFamiliar",
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
		OnUsedOnExitFunctionName = "UseShovelPointOnExit",
		SpeakerName = "Selene",
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
		OnUsedOnExitFunctionName = "UseExorcismPointOnExit",
	},

	FishingPoint =
	{
		UseText = "UseFishingPoint",
		NoToolUseText = "UseFishingPointLocked",
		GetUseTextFunctionName = "FishingPointGetUseText",
		OnUsedFunctionName = "UseFishingPoint",
		ExitsUnlockedFunctionName = "HarvestPointAvailablePresentation",
		ExitsUnlockedFunctionArgs = { PingSound = "/Leftovers/SFX/AnnouncementPing7" },
		OnUsedOnExitFunctionName = "UseFishingPointOnExit",
		FamiliarUseText = "UseFishingPointFamiliar",
		LinkedToolName = "ToolFishingRod",
	},

	GhostRecruit =
	{
		InheritFrom = { "BaseEmotes" },
		EmoteOffsetZ = 0,
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

	CrossroadsShadeSign01 =
	{
		SetupEvents =
		{
			{
				FunctionName = "DistanceTrigger",
				Threaded = true,
				Args =
				{
					PreTriggerEvents =
					{
						{
							FunctionName = "GenericPresentation",
							Args = 
							{
								PreWait = 0.1,
							},
						},
					},
					WithinDistance = 60,
					PostTriggerEvents =
					{
						{
							FunctionName = "ShadeSignSway",
							Args =
							{							   
							},
						},
					},
					Repeat = true,
				},
			}
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
		ReappearSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
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
		ReappearSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
	},
	TorchFlame =
	{
		MovementReaction =
		{
			DisappearDuration = 2.0,
			ReactionSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
		},
		ReappearSound = "/Leftovers/World Sounds/Caravan Interior/CandleBlow",
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

	AmmoPack =
	{
		PickUpSound = "/SFX/BloodstoneAmmoPickup",
		SetupEvents =
		{
			{
				FunctionName = "AmmoPackPickupTrigger",
				Args =
				{
					WithinDistance = 300,
					TriggerObjectType = "Zagreus",
					Timeout = 20.0,
				}
			},
		},
	},

	-- Family Portrait
	CrossroadsFamilyPortrait02 =
	{
		UseText = "UseFamilyPortrait",
		InteractDistance = 150,
		InteractOffsetY = 30,
		OnUsedFunctionName = "ViewPortraitPresentation",
		OnUsedFunctionArgs =
		{
			StartScale = 0.93,
			EndScale = 0.73,
			PanDuration = 9.8,
		},
		PortraitAnimation = "TentFamilyPortrait",
		HiddenAnimation = "Tilesets/Crossroads/Crossroads_FamilyPortrait_02a",
		Using = { AdditionalAnimation = "TrueEndingBannerFx", Animation = "TentFamilyPortraitFinished",  },

		SetupEvents =
		{
			{
				Threaded = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_3988" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				FunctionName = "UpdateFamilyPortraitVisibility",
				Args =
				{
					PreWait = 0.02,
					Silent = true,

					-- NOTE: If Mel covered the portrait on the current run, it will be force-hidden in UpdateFamilyPortraitVisibility, ignoring these requirements.
					StartHiddenGameStateRequirements =
					{
						-- don't cover it up if it was uncovered on the last run
						{
							PathTrue = { "PrevRun", "FamilyPortraitHidden" },
						},
						-- never cover when returning from the first Chronos clear
						{
							PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
						},
						OrRequirements =
						{
							-- normally it gets covered if you use it repeatedly
							{
								{
									SumPrevRuns = 3,
									Path = { "UseRecord", "CrossroadsFamilyPortrait02" },
									Comparison = ">=",
									Value = 1,
								},
							},
							-- also sometimes covered under these conditions
							{
								{
									FunctionName = "RequiredQueuedTextLine",
									FunctionArgs = { IsAny = { "ArtemisHubSinging01", }, },
								},
							},
							{
								{
									Path = { "CurrentRun", "TextLinesRecord" },
									HasAny = { "ArtemisHubSinging01" },
								},
							},
						},
					},
				},
			},
			{
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				FunctionName = "OverwriteSelf",
				Args =
				{
					Animation = "Tilesets\\Crossroads\\Crossroads_FamilyPortrait_finished_02",
					PortraitAnimation = "TentFamilyPortraitFinished",
					UseText = "UseFinishedFamilyPortrait",
				},
			},
		},

		DistanceTriggers =
		{
			{
				PreTriggerWait = 0.1,
				WithinDistance = 410,
				LockToCharacter = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
				},
				VoiceLines =
				{
					BreakIfPlayed = true,
					UsePlayerSource = true,
					PreLineWait = 0.5,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
					},

					{ Cue = "/VO/Melinoe_3613", Text = "{#Emph}Our {#Prev}family...",
						PlayOnce = true,
						PlayOnceContext = "PortraitAfterChronosVO",
					},
				}
			}
		},

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

	},
	_Impassable_Tile64IsoUnitsOnly_Short =
	{

	},
	ClampWall_Left =
	{

	},
	ClampWall_Right =
	{

	},
	ClampWall_Top =
	{

	},
	ClampWall_Bottom =
	{

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

	-- hades flashback
	HousePaintingPersephone01 =
	{
		DistanceTrigger =
		{
			PreTriggerWait = 0.1,
			WithinDistance = 300,
			VoiceLines =
			{
				{
					PlayOnce = true,
					PlayOnceContext = "HadesFlashbackQuipVO",
					UsePlayerSource = true,
					BreakIfPlayed = true,
					SkipCooldownCheckIfNonePlayed = true,

					{ Cue = "/VO/Hades_0351", Text = "Fates be merciful..." },
				},
			},
		},
	},

	HouseStyx01 =
	{
		DistanceTrigger =
		{
			PreTriggerWait = 0.1,
			WithinDistance = 1000,
			VoiceLines =
			{
				{
					PlayOnce = true,
					PlayOnceContext = "HadesFlashbackQuipVO",
					UsePlayerSource = true,
					BreakIfPlayed = true,
					SkipCooldownCheckIfNonePlayed = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "SessionState", "InFlashback" },
						},
						{
							PathFalse = { "GameState", "SpeechRecord", "/VO/Chronos_0055" },
						},
					},

					{ Cue = "/VO/Hades_0350", Text = "Nothing here. What of the throne...?" },
				},
			},
		},
		SpeakerName = "Hades",
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
	Pillar = "StoneObstacle",
	Rubble = "StoneObstacle",
	Brazier = "StoneObstacle",
	Statue = "StoneObstacle",
	Planter = "StoneObstacle",
	Bush = "BushObstacle",
	Urn = "PorcelainObstacle",
	Vase = "MetalObstacle",
	Wall = "StoneObstacle",
	Tile = "StoneObstacle",
	Impassable = "StoneObstacle",
}