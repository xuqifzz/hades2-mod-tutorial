-- Ephyra
OverwriteTableKeys( ObstacleData, {
	N_OpeningDoor =
	{
		InheritFrom = { "ExitDoor", },
		UnlockedAnimation = "DoorExitLightSoftNE_N_Opening",
		RewardPreviewOffsetZ = -50,

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

	SoulPylon =
	{
		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "N_Story01" },
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
				SuccessiveChanceToPlayAll = 0.2,

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
				{ Cue = "/VO/MelinoeField_0392", Text = "Another Pylon." },
			}
		},
	},

	EphyraExitDoor =
	{
		InheritFrom = { "ExitDoor", },

		RewardPreviewOffsetZ = 140,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = 0,
		ExitThroughCenter = true,

		LockWhenEphyraBossExitReady = true,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		ClosedForRunAnimation = "EphyraExitDoorLocked",
		UnlockedAnimation = "EphyraExitDoorOpened",
		UnavailableAnimation = "EphyraExitDoorUnavailable",

		SetupEvents =
		{
			Append = true,
			{
				FunctionName = "PreExitUnlockDoorSetup",
				Args =
				{
					RestoreUnlockedAnimation = "EphyraExitDoorOpened",
				},
			},
		},

		CloseOnReturnAnimation = "EphyraExitDoorCloseOnReturn",

		--ExitDoorOpenAnimation = "EphyraExitDoorOpen",
		ExitDoorCloseAnimation = "EphyraExitDoorClose",

		ExitFunctionName = "HubCombatRoomEntrance",
		NextRoomEntranceFunctionName = "FastEnterPresentation",

		-- OnUnlockThreadedFunctionName = "CreateScreenEdgeIndicator",

		ExitBlockedVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_0430", Text = "It's sealed." },
				{ Cue = "/VO/MelinoeField_0431", Text = "It's sealed shut." },
				{ Cue = "/VO/MelinoeField_0432", Text = "Can't go this way." },
				{ Cue = "/VO/MelinoeField_0433", Text = "Can't get through." },
			},
		},
	},

	EphyraExitDoorReturn =
	{
		InheritFrom = { "ExitDoor", },

		UnlockedAnimation = "DoorExitLightSoftSW_Ephyra",
		UnlockedUseSound = "/Leftovers/World Sounds/PostBossLeaveSFX",
		UnlockedSound = "/Leftovers/World Sounds/MapZoomInTight",

		AllowReroll = false,
		HideRewardPreview = true,
		ReturnToPreviousRoomName = "N_Hub",

		ExitFunctionName = "FastExitPresentation",
		NextRoomEntranceFunctionName = "FastEnterPresentation",
	},

	EphyraExitDoorReturnNE = 
	{
		InheritFrom = { "EphyraExitDoorReturn", },
		UnlockedAnimation = "DoorExitLightSoftNE_Ephyra",
	},

	EphyraExitBossDoor =
	{
		InheritFrom = { "ExitDoor", },

		RewardPreviewOffsetZ = 140,
		RewardPreviewOffsetY = 0,
		RewardPreviewOffsetX = 0,
		ExitThroughCenter = true,

		UnlockedUseTextCannotReroll = "UseLeaveRoom_CannotReroll",

		UnlockedAnimation = "EphyraBossExitDoorLinesUnlocked",
		--ExitDoorOpenAnimation = "EphyraExitDoorOpen",
		ExitDoorCloseAnimation = "Blank",

		--ExitFunctionName = "NHubBossDoorExitPresentation",

		--ExitFunctionName = "FastExitPresentation",
		NextRoomEntranceFunctionName = "FastEnterPresentation",

		AvailableRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = ">=",
				Value = 6,
			}
		},

		ForceRoomName = "N_PreBoss01",

		DistanceTrigger =
		{
			WithinDistance = 900,
			VoiceLines =
			{
				{
					Queue = "Always",
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.25,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = ">=",
							Value = 6,
						}
					},
					Cooldowns =
					{
						{ Name = "BarrierDownVoiceLines", Time = 12 },
					},
					TriggerCooldowns = { "MelinoeAnyQuipSpeech", "EphyraExitVoiceLines" },

					{ Cue = "/VO/MelinoeField_0420", Text = "The barrier's down...!", PlayFirst = true },
					{ Cue = "/VO/MelinoeField_0421", Text = "Barrier down." },
					{ Cue = "/VO/MelinoeField_0422", Text = "I can get out." },
					{ Cue = "/VO/MelinoeField_0423", Text = "Barrier destroyed." },
				},
			},
		},

		OnUsedPresentationFunctionName = "GenericPresentation",
		OnUsedPresentationFunctionArgs =
		{
			ThreadedVoiceLines =
			{
				UsePlayerSource = true,
				PreLineWait = 0.45,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlayAll = 0.66,
				ThreadName = "RoomThread",
				Cooldowns =
				{
					{ Name = "EphyraExitVoiceLines", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_0424", Text = "Farewell, Ephyra.", PlayFirst = true, },
				{ Cue = "/VO/MelinoeField_0425", Text = "At last." },
				{ Cue = "/VO/MelinoeField_0426", Text = "Enough of this place." },
				{ Cue = "/VO/MelinoeField_0427", Text = "Finally." },
				{ Cue = "/VO/MelinoeField_0428", Text = "Back to nature." },
				{ Cue = "/VO/MelinoeField_0429", Text = "Well, this was lovely..." },
			}
		},

	},

	EphyraHubExitBarrier =
	{
		OnUsedFunctionName = "LockedSurfaceRunPresentation",
		OnUsedFunctionArgs = { VoiceLines = HeroVoiceLines.LockedEphyraExitGateVoiceLines },
		UseText = "UseExitDoorWhileLocked",
		SetupGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
				Comparison = "<",
				Value = 6,
			},
		},
		DestroyIfNotSetup = true,

		DistanceTrigger =
		{
			WithinDistance = 1000,
			VoiceLines =
			{
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "SurfacePenalty" },
					},
				},
				-- barrier full strength
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.2,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = "<=",
							Value = 0,
						}
					},
					{ Cue = "/VO/MelinoeField_0370", Text = "Some sort of barrier...", PlayOnce = true, PlayFirst = true },
					{ Cue = "/VO/MelinoeField_0371", Text = "How to get through...", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0371" },
							}
						},
					},
					{ Cue = "/VO/MelinoeField_0372", Text = "That barrier's back up.",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_1373" },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0373", Text = "Fixed the barrier, did they?",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Melinoe_1373" },
							},
						},
					},
				},
				-- barrier reduced strength
				{
					PreLineWait = 1.0,
					PlayOnceFromTableThisRun = true,
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.33,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
							Comparison = ">=",
							Value = 1,
						},
						{
							Path = { "GameState", "EnemyKills", "SoulPylon" },
							Comparison = ">=",
							Value = 2,
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0619" }
						},
					},
					Cooldowns =
					{
						{ Name = "BarrierStatusVOPlayedRecently", Time = 180 },
					},

					{ Cue = "/VO/MelinoeField_0414", Text = "The barrier's lost some of its strength.", PlayFirst = true,
					},
					{ Cue = "/VO/MelinoeField_0415", Text = "The barrier's almost down.",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
								Comparison = ">=",
								Value = 4,
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0416", Text = "The barrier's weakening." },
					{ Cue = "/VO/MelinoeField_0419", Text = "Almost through...",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "SpawnRecord", "SoulPylon" },
								Comparison = ">=",
								Value = 4,
							},
						},
					},
				},
			},
		},

	},

	N_SubRoomDoor =
	{
		InheritFrom = { "ExitDoor", },

		UnlockedAnimation = "EphyraSubRoomDoorOpen",
		ClosedForRunAnimation = "EphyraSubRoomDoorLocked",
		UnavailableAnimation = "EphyraSubRoomDoorUnavailable",
		HideRewardPreview = true,
		AllowReroll = false,

		SetupEvents =
		{
			Prepend = true,
			{
				FunctionName = "CheckDoorUnavailable",
				Args =
				{
					UnavailableChance = 0.55,
				},
			},
		},

		--ExitDoorOpenAnimation = "EphyraSubRoomDoorOpen",
		ExitDoorCloseAnimation = "EphyraSubroomDoorClose",
		ExitFunctionName = "FastExitPresentation",
		NextRoomEntranceFunctionName = "FastEnterPresentation",

		CloseOnReturnAnimation = "EphyraSubRoomDoorClose",

		ChooseRoomArgs =
		{
			ForceNextRoomSet = "N_SubRooms",
		},

		OnUseEvents =
		{
			{ FunctionName = "HandleSubRoomData", },
			{ FunctionName = "AttemptUseDoor", },
		},
	},

	N_SubRoomDoorReturn =
	{
		InheritFrom = { "ExitDoor", },
		UseText = "UseLeaveRoom",
		UnlockedAnimation = "DoorExitLightSoftSW_Ephyra",
		UnlockedUseSound = "/Leftovers/World Sounds/PostBossLeaveSFX",

		ReturnToPreviousRoom = true,
		HideRewardPreview = true,
		AllowReroll = false,

		ExitFunctionName = "FastExitPresentation",
		NextRoomEntranceFunctionName = "FastEnterPresentation",
		

		OnUseEvents =
		{
			{ FunctionName = "HandleSubRoomReturnData", },
			{ FunctionName = "AttemptUseDoor", },
		},
	},

	Breakable_N =
	{
		InheritFrom = { "BaseBreakable" },

		DeathSound = "/SFX/CeramicPotSmash",
		DeathFx = "EphyraBreakableVase01Shatter",

		SetupEvents =
		{
			{
				FunctionName = "RandomizeObject",
				Args =
				{
					RandomizeSets =
					{
						{
							Animation = { "Breakable_N01" },
							OverwriteData =
							{
								DeathFx = "EphyraBreakableVase01Shatter",
							},
						},
						{
							Animation = { "Breakable_N02" },
							OverwriteData =
							{
								DeathFx = "EphyraBreakableVase01aShatter",
							},
						},
						{
							Animation = { "Breakable_N03" },
							OverwriteData =
							{
								DeathFx = "EphyraBreakableVase01bShatter",
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

		-- Shrine of Hermes
	SurfaceShop =
	{
		UseText = "UseWell_Locked",
		AvailableUseText = "UseWell_Unlocked",
		OnUsedFunctionName = "AttemptUseChallengeSwitch",
		ChallengeSwitchUseFunctionName = "ShowSurfaceShopScreen",
		UseSound = "/Leftovers/World Sounds/Caravan Interior/CabinetClose",
		UsePromptOffsetX = 65,
		UsePromptOffsetY = -50,
		CannotUseText = "WellShopBlockedByEncounter",
		CooldownNamePrefix = "SurfaceShop",
		BlockDuringChallenge = true,

		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfaceShops" },
				},
			},
			WithinDistance = 500,
			VoiceLines =
			{
				Queue = "Always",
				PlayOnce = true,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1535", Text = "A shrine to Lord Hermes..." },
			}
		},
	},

	EphyraZoomObject =
	{	
		OnUsedGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeEphyraZoomOut" },
			},
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "SurfacePenalty" },
			},
		},
		OnUsedFailedPresentation = "CannotUseZoomOutPresentation",
		OnUsedFunctionName = "EphyraZoomOut",
		UseText = "UseZoomOutObject",
		UseIneligibleText = "CannotUseObject",
		UseSound = "/SFX/BatFullScreenSFX",
		UnlockedUseText = "UseZoomOutObject",
		UsePromptOffsetX = 65,
		UsePromptOffsetY = -50,
		OnUsedVoiceLines =
		{
			[1] = GlobalVoiceLines.UsedTelescopeVoiceLines,
		},
		DistanceTrigger =
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeEphyraZoomOut" },
				},
			},
			Repeat = false,
			WithinDistance = 500,
			VoiceLines =
			{
				Queue = "Always",
				PlayOnce = true,
				PlayOnceContext = "ZoomOutUnlocked",
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/MelinoeField_1365" },
					},
					AreIdsNotAlive = { 566363 },
				},
				Cooldowns =
				{
					{ Name = "MelinoeBriefQuipSpeech", Time = 1 },
				},
				{ Cue = "/VO/MelinoeField_1365", Text = "The seeing-eye bats have returned...!" },
			},
		},

		MapAnimation = "GUI\\Screens\\EphyraHubMap",

		ScreenLocations =
		{
			-- Bat Cages
			[664259] = { X = 560, Y = 720 }, -- entrance
			[664261] = { X = 180, Y = 460 },
			[664258] = { X = 650, Y = 490 },
			[664262] = { X = 880, Y = 200 },
			[664263] = { X = 1120, Y = 880 },
			[664264] = { X = 1390, Y = 580 },
			[664265] = { X = 1410, Y = 700 },

			-- Rooms
			[560848] = { X = 1230, Y = 740 }, -- story

			[560725] = { X = 540, Y = 620 },

			[617138] = { X = 1210, Y = 860 },
			[560699] = { X = 1205, Y = 960 },
			[561395] = { X = 1085, Y = 990 },
			[561337] = { X = 905, Y = 960 },
			[560708] = { X = 840, Y = 760 },

			[561389] = { X = 1580, Y = 720 },
			[561368] = { X = 1700, Y = 710 },
			[617113] = { X = 1700, Y = 810 },
			[560889] = { X = 1570, Y = 810 },

			[561374] = { X = 1380, Y = 480 },
			[561354] = { X = 1610, Y = 580 },
			[560705] = { X = 1570, Y = 410 },
			[561380] = { X = 1480, Y = 360 },

			[617144] = { X = 360, Y = 660 },
			[561403] = { X = 340, Y = 720 },
			[617162] = { X = 160, Y = 690 },
			[561449] = { X = 125, Y = 570 }, 
			[560776] = { X = 130, Y = 490 }, 
			[560707] = { X = 240, Y = 410 }, 
			[560620] = { X = 430, Y = 445 }, 

			[617024] = { X = 395, Y = 310 }, 
			[617043] = { X = 530, Y = 270 }, 
			[617012] = { X = 650, Y = 270 },
			[560702] = { X = 760, Y = 380 }, 
			[561418] = { X = 830, Y = 220 },
			[561424] = { X = 930, Y = 100 },
			[616992] = { X = 1080, Y = 140 },
			[617151] = { X = 1090, Y = 210 },
			[560713] = { X = 1070, Y = 320 },
		},
	},

	EphyraCrate01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	EphyraBarricade01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	EphyraWheelBarrow01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",

	},

	EphyraBarrel01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	TartarusBarrel01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	EphyraShields01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	EphyraWeaponrack01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	EphyraCentaurChariot01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	HouseBarrel01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	EphyraFishBasket01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibersBasket",
	},

	EphyraVase01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
	},

	EphyraHaybale01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibers",
	},

	EphyraBrazier01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
	},

	EphyraCrateSet01 =
	{
		InheritFrom = { "BaseIndestructibleNoShakeHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	EphyraSacks01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibersBasket",
	},

	EphyraTable01 =
	{
		InheritFrom = { "BaseIndestructibleNoShakeHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	HouseBasketFish01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleFibersBasket",
	},

	EphyraLantern01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
	},

	EphyraChair01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
		HitFx = "EphyraIndestructibleWoodSplinters",
	},

	EphyraFishTraps01 =
	{
		InheritFrom = { "BaseIndestructibleHitFx" },
	},

	EphyraBarrelShelf01 =
	{
		InheritFrom = { "BaseDestructible" },

		MaxHealth = 0,
		HealthTicks = 2,
		CannotDieFromDamage = true,
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		SkipDestroy = true,
		DeathAnimation = "EphyraBarrelShelfDestructionFx",
		DamagedFxStyles =
		{
			Default = "EphyraDestructibleWoodSplinters",
			Rapid = "EphyraDestructibleWoodSplinters",
		},
	},

	EphyraVase02 =
	{
		InheritFrom = { "BaseDestructible" },

		MaxHealth = 0,
		HealthTicks = 2,
		CannotDieFromDamage = true,
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		SkipDestroy = true,
		DeathAnimation = "EphyraBreakableVase02Shatter",
	},

	HealthFountainN =
	{
		InheritFrom = { "HealthFountain" },
		HealingSpentAnimation = "HealthFountainN_Empty",
		BlockExitUntilUsed = false,
	},

	ShadeEphyraIdle01=
	{
		InheritFrom = { "BaseGhost", "SmallEmotes" },
	},

	EphyraBugs =
	{
		MovementReaction =
		{
			Animation = "EphyraBugsOut",
		},
	},

	PolyphemusBoulder =
	{
		InheritFrom = { "BaseDestructible" },
		
		DeathFx = "PolyphemusBoulderCrumble",
		DamagedFxStyles =
		{
			Default = "PolyphemusBoulderHitFx",
			Rapid = "PolyphemusBoulderHitFx",
		},
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 5,

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},
	},

	PolyphemusBoulderRubble =
	{
		InheritFrom = { "BaseDestructible" },
		
		DeathFx = "WallSlamCrumble",

		--FirstOnHitSound = "/Leftovers/SFX/CaravanDamage",
		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15, },

		CannotDieFromDamage = true,
		MaxHealth = 0,
		HealthTicks = 2,

		MoneyDropOnDeath =
		{
			Chance = 0,
			IgnoreRoomMoneyStore = true,
		},
	},

	SurfaceDestructiblePillar =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "BossPillarB",
			RequiredHitsForImpactReaction = 1,
			SpawnRandomObstacle = { "SurfaceRubble02b" },
			ForceSpawnToValidLocation = true,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 1000,
			FallForce = 1500,
			SwapData = "SurfaceDestructiblePillarA",
		},
	},

	SurfaceDestructiblePillarA =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "BossPillarC",
			RequiredHitsForImpactReaction = 2,
			SpawnRandomObstacle = { "SurfaceRubble02b" },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 5,
			SpawnTimeMin = 0.16,
			SpawnTimeMax = 0.32,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 2000,
			FallForce = 3000,
			SwapData = "SurfaceDestructiblePillarB",
			GlobalVoiceLines = "BreakingStuffVoiceLines",
		},
	},

	SurfaceDestructiblePillarB =
	{
		Material = "Stone",

		OnHitShake = { Distance = 3, Speed = 300, Duration = 0.15 },
		ImpactReaction =
		{
			Animation = "BossPillarD",
			RequiredHitsForImpactReaction = 3,
			SpawnRandomObstacle = { "SurfaceRubble02b" },
			ForceSpawnToValidLocation = true,
			SpawnAmount = 8,
			SpawnTimeMin = 0.16,
			SpawnTimeMax = 0.32,
			SpawnOffsetXMin = 150,
			SpawnOffsetXMax = 450,
			SpawnOffsetYMin = 150,
			SpawnOffsetYMax = 390,
			SpawnOffsetZ = 1000,
			FallForce = 3000,
			SwapData = "SurfaceDestructiblePillarC",
			CausesOcclusion = false,
		},
	},

	SurfaceDestructiblePillarC =
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

	SurfaceGravemarker01 =
	{
		InheritFrom = { "TartarusRubble02", },
		SpawnScale = 0.5,
	},

	SurfaceGravemarker02 =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	SurfaceGravemarker04 =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	SurfaceGravemarker06 =
	{
		InheritFrom = { "TartarusRubble02", },
	},

	SurfaceRubble02b =
	{
		InheritFrom = { "TartarusRubble02", },
		SpawnScale = 0.25,
	},
})