RoomSetData.H =
{
	BaseH =
	{
		DebugOnly = true,
		RichPresence = "#RichPresence_H",
		Icon = "GUI\\Screens\\BountyBoard\\Biome_Fields",
		ResultText = "RunHistoryScreenResult_Fields",
		
		ValidateSecretData = true,
		HasHarvestPoint = true,
		HasShovelPoint = true,
		HasPickaxePoint = true,
		HasFishingPoint = true,
		HasExorcismPoint = true,
		SecretSpawnChance = 0.0,
		WellShopSpawnChance = 0.35,

		HarvestPointChances = { 0.30, },
		ShovelPointChance = 0.24,
		PickaxePointChance = 0.36,
		ExorcismPointChance = 0.24,
		FishingPointChance = 0.18,

		LocationAnimName = "InfoBannerFieldsIn",
		LocationAnimOutName = "InfoBannerFieldsOut",

		HarvestPointRequirements =
		{
			{
				SumPrevRooms = 1,
				Path = { "NumHarvestPoints" },
				Comparison = "<=",
				Value = 0,
			},
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantHMyrtle" },
						Comparison = "<",
						Value = 8,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},
		ShovelPointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantGCattailSeed" },
				Comparison = ">=",
				Value = 2,
			},
			{
				SumPrevRooms = 2,
				Path = { "NumShovelPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumPickaxePoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumExorcismPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumFishingPoints" },
				Comparison = "<=",
				Value = 0,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantHWheatSeed" },
						Comparison = "<",
						Value = 8,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
					{
						SumPrevRooms = 1,
						Path = { "NumPickaxePoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
		},
		PickaxePointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "OreGLime" },
				Comparison = ">=",
				Value = 6,
			},
			{
				SumPrevRooms = 2,
				Path = { "NumPickaxePoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumShovelPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumExorcismPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumFishingPoints" },
				Comparison = "<=",
				Value = 0,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreHGlassrock" },
						Comparison = "<",
						Value = 30,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
					{
						SumPrevRooms = 1,
						Path = { "NumShovelPoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
		},
		ExorcismPointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 2,
			},
			{
				Path = { "GameState", "ExorcisedNames", "ShadeOceanusSIdle" },
				Comparison = ">=",
				Value = 2,
			},
			{
				SumPrevRooms = 2,
				Path = { "NumExorcismPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumShovelPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumPickaxePoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumFishingPoints" },
				Comparison = "<=",
				Value = 0,
			},

			OrRequirements =
			{
				-- collection
				{
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "LifetimeResourcesGained", "MemPointsCommon" },
								Comparison = "<=",
								Value = 1500,
							},
						},
						{
							{
								Path = { "GameState", "ExorcisedNames", "ShadeFieldsGreyIdle" },
								Comparison = "<",
								Value = 2,
							},
						},
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
					{
						SumPrevRooms = 1,
						Path = { "NumFishingPoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
		},
		FishingPointRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
			},
			{
				SumPrevRooms = 2,
				Path = { "NumFishingPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumShovelPoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumPickaxePoints" },
				Comparison = "<=",
				Value = 0,
			},
			{
				SumPrevRooms = 1,
				Path = { "NumExorcismPoints" },
				Comparison = "<=",
				Value = 0,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", },
						NotHasAll = { "FishHCommon", "FishHRare", "FishHLegendary" },
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
					{
						SumPrevRooms = 1,
						Path = { "NumExorcismPoints" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
		},

		IntroSequenceDuration = 0.0,

		SuppressRewardSpawnSounds = true,

		ChallengeSpawnRequirements =
		{
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache", },
				Comparison = ">=",
				Value = 1,
			},
			{
				FunctionName = "RequiredMinRoomsSinceEvent",
				FunctionArgs = { Event = "ChallengeSwitch", Count = 3 },
			},
		},
		TimeChallengeEncounterOptions = { "TimeChallengeH" },
		PerfectClearEncounterOptions = { "PerfectClearChallengeH" },
		EliteChallengeEncounterOptions = { "EliteChallengeH" },
		ChallengeSwitchCannotUseText = "ChallengeSwitchBlockedByFieldsLoot",

		LegalEncounters = EncounterSets.HEncountersPassive,
		--DevotionEncounters = {"DevotionTestH"},
		IneligibleRewards = { "Devotion" },
		ZoomFraction = 0.75,
		SoftClamp = 0.75,
		TargetMetaRewardsRatio = 0.0,
		IndividualRewardStore = "RunProgress",

		MinDepthBeforeIntros = 0,

		-- LocationText = "BiomeH",
		SaveProfileLocationText = "BiomeH_Short",

		NarrativeContextArt = "DialogueBackground_Fields",
		NarrativeContextArtFlippable = false,

		NemesisRewardMoveDistance = 200,

		CloseTalentScreenGlobalVoiceLines = "FieldsRewardClaimedVoiceLines",

		EntranceFunctionName = "FieldsRoomEntrancePresentation",
		ExitFunctionName = "FieldsLeaveRoomPresentation",

		Ambience = "/Ambience/FieldsAmbienceOutdoor",
		ReverbValue = 1.1,

		-- ShopSecretMusic = "/Music/CharonShopTheme",
		StopSecretMusic = true,

		BlockHeroLight = true,

		ThreadedEvents =
		{
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					NamedRequirements = { "ShouldShowBountyInfoBanner" },
				},
			},
		},
		PostCombatReloadThreadedEvents =
		{
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					NamedRequirements = { "ShouldShowBountyInfoBanner" },
				},
			},
		},

		PostCombatReloadEvents =
		{
			{
				FunctionName = "H_ReloadHideGhostWalls"
			}
		},

		SwapSounds =
		{
			["/SFX/Player Sounds/FootstepsHardSurface"] = "/Leftovers/SFX/FootstepsWheat",
			["/SFX/Player Sounds/FootstepsHardSurfaceRun"] = "/Leftovers/SFX/FootstepsWheat2",
		},

		SwapAnimations =
		{
			["OlympusSnowExplosionDecal"] = "ExplosionScorchDecal",
		},

		EnterVoiceLines =
		{
			PlayOnce = true,
			PlayOnceFromTableThisRun = true,
			RandomRemaining = true,
			PreLineWait = 1.95,
			SuccessiveChanceToPlayAll = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsNone = { "H_Bridge01", "H_MiniBoss01", "H_MiniBoss02", "H_PreBoss01", "H_Combat15" },
				},
			},
			TriggerCooldowns = { "MelFieldsMusingVoiceLines", "MelinoeAnyQuipSpeech" },

			{ Cue = "/VO/MelinoeField_2116", Text = "Looking for several different points..." },
			{ Cue = "/VO/MelinoeField_2117", Text = "Few things to find..." },
			{ Cue = "/VO/MelinoeField_1075", Text = "It's all so vast...", PlayFirst = true },
		},
		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.33,
				PlayOnceFromTableThisRun = true,

				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Intro", "H_Bridge01", "H_Boss01", "H_Boss02", "H_MiniBoss01", "H_MiniBoss02" },
					},
					{
						PathEmpty = { "MapState", "AggroedUnits" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelExitVoiceLines", Time = 20 },
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/MelinoeField_0850", Text = "This way feels right...", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_0851", Text = "Out of my way." },
				{ Cue = "/VO/MelinoeField_0852", Text = "Let me past." },
				{ Cue = "/VO/MelinoeField_0853", Text = "I'm going, step aside." },
				{ Cue = "/VO/MelinoeField_0854", Text = "Clear the way." },
				{ Cue = "/VO/MelinoeField_0855", Text = "I have to go now." },
			},
		},

		BonusRewardStoreName = "FieldsOptionalRewards",
		OptionalRewardChances =
		{
		  0.95,
		  0.75,
		  0.50,
		  0.25,
		},
		UnoccupiedRewardCullCount = 8,

		MinDoorCageRewards = 2,
		MaxDoorCageRewards = 3,

		MaxAppearancesThisBiome = 1,

		-- experimental attempt dealing with door variance issues
		MaxDoorDepthChanceTable = 
		{ 
			[1] = { MaxDoorChance = 0.05 },
			[2] = { MaxDoorChance = 0.20 },
			[3] = { MaxDoorChance = 0.40 },
			[4] = { MaxDoorChance = 0.80, CeilingCheck = true }, -- story
			[5] = { MaxDoorChance = 0.10, CeilingCheck = true }, 
			[6] = { },
			[7] = { },
			[8] = { },
			[9] = { },
			[10] ={ },
		},
		MaxDoorCageCeiling = 2,

		Using = { Spawn = "FieldsRewardCage" }

		--BreakableValueOptions = { MaxHighValueBreakables = 6 },
	},

	H_Intro =
	{
		InheritFrom = { "BaseH", "BiomeStartRoom" },

		LegalEncounters = { "Empty" },
		ZoomFraction = 0.71,
		IntroSequenceDuration = 0.7,
		Starting = true,
		NoReward = true,
		NoReroll = true,
		SkipLastKillPresentation = true,
		HideRewardPreview = true,
		TimerBlock = "IntroRoom",
		RemoveTimerBlock = "InterBiome",
		EntranceFunctionName = "RoomEntrancePortalFields",
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		FlipHorizontalChance = 0.0,

		ForceAtBiomeDepthMin = 0,
		ForceAtBiomeDepthMax = 1,
		MaxAppearancesThisBiome = 1,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 900,

		HarvestPointChances = { 0.02, },
		ShovelPointChance = 0.02,
		PickaxePointChance = 0.02,
		--ExorcismPointChance = 0.02,
		FishingPointChance = 0.02,

		StartUnthreadedEvents =
		{
			{ FunctionName = "EndBiomeRecords", },
			{
				FunctionName = "SpawnErisForCurse",
				Args =
				{
					UnitName = "NPC_Eris_01",
					SpawnOnId = 621444,
					GoalAngle = 270,
					GiveRandomConsumables =
					{
						UpwardForceMin = 1000,
						UpwardForceMax = 1000,
						Range = 0,
						Force = 0,
						--NotRequiredPickup = true,
						LootOptions =
						{
							{
								Name = "MemPointsCommonDrop",
								Overrides =
								{
									CanDuplicate = false,
									MetaConversionEligible = false,
									NPCDrop = true,
									AddResources =
									{
										MemPointsCommon = 50,
									},
								},
							},
						}
					},
				},
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "ErisCurseHealthThreshold", },
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 4,
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "ErisCurseTrait" },
					},
				},
				BreakIfPlayed = true,
			},
			{
				FunctionName = "DistanceTrigger",
				Threaded = true,
				Args =
				{
					Id = 621444,
					WithinDistance = 400,
					PostTriggerEvents =
					{
						{
							FunctionName = "GenericPresentation",
							Args = 
							{
								VoiceLines = { GlobalVoiceLines = "ErisNotSightedVoiceLines" },
							},
						},
					},
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 7,
					},
					{
						Path = { "PrevRun", "TraitCache", },
						HasAny = { "ErisCurseTrait" },
					},
				},
			},
		},

		ThreadedEvents =
		{
			Threaded = true,
			{
				FunctionName = "DisplayInfoBanner",
				Args =
				{
					Text = "Location_BiomeH",
					AnimationName = "InfoBannerFieldsIn",
					AnimationOutName = "InfoBannerFieldsOut",
					Delay = 2.0,
				},
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "ShouldShowBountyInfoBanner" },
				},
			},
			{
				FunctionName = "DisplayInfoBanner",
				Args = RoomEventData.BountyInfoBannerArgs,
				GameStateRequirements =
				{
					NamedRequirements = { "ShouldShowBountyInfoBanner" },
				},
			},
			{
				FunctionName = "CheckObjectiveSetSource",
				Args =
				{
					ObjectiveSetName = "BountyAdvancedTooltip",
				},
			},
		},
		
		DistanceTriggers =
		{
			-- Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 300, FunctionName = "BiomeOverlook", Repeat = true, Args = { PanTargetId = 621965, ZoomFraction = 0.85 },
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "BiomeBackToRoom", Repeat = true,
			},
		},

		InspectPoints =
		{
			[565615] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Eris_01", }, Alive = false },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_Intro_01 =
					{
						{ Cue = "/VO/Storyteller_0056",
							Text = "{#Emph}A seeming endless sprawl grows on the outskirts of the Underworld, where forlorn Shades attempt to fade away, and doleful Spirits prey upon their sorrow." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

							{ Cue = "/VO/Melinoe_1115", Text = "Such a dreadful place..." },
						},
					},
				},
			},
			[686629] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Eris_01", }, Alive = false },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_Intro_02 =
					{
						{ Cue = "/VO/Storyteller_0170",
							Text = "{#Emph}Amid the overgrowth near to the lowest reaches of the Underworld lurk the innumerable souls who cling to shreds of love and hope that long since ceased to be." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

							{ Cue = "/VO/MelinoeField_0816", Text = "It's rather bleak down here..." },
						},
					},
				},
			},

		},

		-- Room Audio Below This Line
		MusicActiveStems = { "Guitar", "Bass", "Drums" },
		MusicStartDelay = 0.65,
		MusicMutedStems = { "Drums" },
		PlayBiomeMusic = true,
		MusicSection = 0,

		EnterVoiceLines =
		{
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
			{ GlobalVoiceLines = "StartPackagedBountyRunVoiceLines" },
			{ GlobalVoiceLines = "BiomeStateChangeStartVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 2.65,
				SuccessiveChanceToPlayAll = 0.25,
				TriggerCooldowns = { "MelinoeFieldsStartSpeech", "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_1055", Text = "Don't lose your way here, Mel...", PlayFirst = true, PlayOnce = true },
				{ Cue = "/VO/MelinoeField_1056", Text = "There's no clear path in sight..." },
				{ Cue = "/VO/Melinoe_0808", Text = "Where to from here..." },
				{ Cue = "/VO/Melinoe_0809", Text = "The Mourning Fields..." },
				{ Cue = "/VO/MelinoeField_0834", Text = "It's so... {#Emph}eugh..." },
				{ Cue = "/VO/MelinoeField_0835", Text = "Come on, Mel..." },
				{ Cue = "/VO/MelinoeField_0836", Text = "Don't give in..." },
				{ Cue = "/VO/MelinoeField_0837", Text = "Mustn't stay for long..." },
				{ Cue = "/VO/MelinoeField_0838", Text = "One step at a time..." },
				{ Cue = "/VO/MelinoeField_0839", Text = "Look for the markers..." },
				{ Cue = "/VO/MelinoeField_0840", Text = "It's drier here, at least..." },
				{ Cue = "/VO/MelinoeField_0841", Text = "...All this sorrow..." },
			},
		},
	},

	H_Bridge01 =
	{
		InheritFrom = { "BaseH" },
		EntranceDirection = "LeftRight",
		SecretMusic = "/Music/BlankMusicCue",
		ShopSecretMusic = "/Music/BlankMusicCue",
		FlipHorizontalChance = 0.0,
		SpawnRewardOnId = 624046,
		DisableRewardMagnetisim = true,
		NoReroll = true,
		TimerBlock = "StoryRoom",
		SkipNemesisSpawnPresentation = true,

		ForcedRewards =
		{
			{
				Name = "Story",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "Hero", "MutePermanent" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
			},
			{
				Name = "Shop"
			},
		},
		LegalEncounters =
		{
			"Story_Echo_01",
			"Story_Echo_01",
			"Story_Echo_01",
			"Story_Echo_01",

			"BridgeShop",
			"BridgeShop",

			"BridgeNemesisRandomEvent",
		},

		SlingshotRepulseTowardId = 410264,

		AlwaysForce = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomsEntered" },
				SumOf =
				{
					"H_Combat01", "H_Combat02", "H_Combat03", "H_Combat04", "H_Combat05", "H_Combat06", "H_Combat07", "H_Combat08",
					"H_Combat09", "H_Combat10", "H_Combat11", "H_Combat12", "H_Combat13", "H_Combat14", "H_Combat15",
					"H_MiniBoss01", "H_MiniBoss02",
				},
				Comparison = ">=",
				Value = 2,
			},
			{ -- Don't be the room before PreBoss
				Path = { "CurrentRun", "RoomsEntered" },
				SumOf =
				{
					"H_Combat01", "H_Combat02", "H_Combat03", "H_Combat04", "H_Combat05", "H_Combat06", "H_Combat07", "H_Combat08",
					"H_Combat09", "H_Combat10", "H_Combat11", "H_Combat12", "H_Combat13", "H_Combat14", "H_Combat15",
					"H_MiniBoss01", "H_MiniBoss02",
				},
				Comparison = "<",
				Value = 3,
			},
		},

		MaxCreationsThisRun = 1,
		MaxAppearancesThisBiome = 1,

		SecretSpawnChance = 0,

		HarvestPointChances = { 0.75 },
		ShovelPointChance = 0.5,
		PickaxePointChance = 0.5,
		ExorcismPointChance = 0.5,
		FishingPointChance = 0.5,

		HarvestPointRequirements =
		{
			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantHMyrtle" },
						Comparison = "<",
						Value = 8,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},
		ShovelPointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeToolsShop" },
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "PlantGCattailSeed" },
				Comparison = ">=",
				Value = 2,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantHWheatSeed" },
						Comparison = "<",
						Value = 6,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},
		PickaxePointRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "GameState", "LifetimeResourcesGained", "OreGLime" },
				Comparison = ">=",
				Value = 6,
			},

			OrRequirements =
			{
				-- collection
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "OreHGlassrock" },
						Comparison = "<",
						Value = 30,
					},
				},
				-- accumulation
				{
					ChanceToPlay = 0.5,
				},
			},
		},

		ZoomFraction = 0.7,

		MusicMutedStems = { "Drums" },

		StartThreadedEvents =
		{
			{
				FunctionName = "ActivateFamiliar",
				GameStateRequirements =
				{
					-- hecuba appearance requirements; requires HecateGrantsFamiliars01 to be recruited
					{
						PathFalse = { "GameState", "FamiliarsUnlocked", "HoundFamiliar" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Nemesis_01", }, Alive = false },
					},
					{
						-- PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarUpgradeSystem" }
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "FamiliarPoints" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					NamedRequirementsFalse = { "HecateFamiliarsInHub", "HecateMissing" },
					ChanceToPlay = 0.8,
				},
				Args =
				{
					Id = 722876,
					Name = "HoundFamiliar",
					SkipAISetup = true,
					OverwriteSelf =
					{
						OnUsedFunctionName = "nil",
						SpecialInteractFunctionName = "HoundFamiliarSpecialInteractLockedInRun",
						PreRecruit = true,
						DistanceTriggers =
						{
							{
								WithinDistance = 550,
								FunctionName = "GenericPresentation",
								Args =
								{
									PreWait = 0.0,
									AngleTowardHero = true,
									SetAnimation = "Familiar_Hound_Greet",
									Sound = "/SFX/Familiars/DogBarkDiscovery",
									VoiceLines = { GlobalVoiceLines = "HoundReactionVoiceLines" },
								},
							},
						}
					},
				},
			},

		},

		StartUnthreadedEvents =
		{
			{ FunctionName = "ActivateObjects", Args = { ObjectTypes = { "HealthFountainH" } } },
			{
				FunctionName = "SetupWorldShop",
				Args =
				{
					ActivateUnitsByType = { "NPC_Charon_01", },
					ActivateIdsByGroup = { "Shop", "Boat" },
				},
			},
			{
				FunctionName = "ActivatePrePlacedObstacles",
				Args = { Groups = { "RockFaces1" } },
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "EchoAboutNarcissus07" }
					},
				},
			},
			{
				FunctionName = "ActivatePrePlacedObstacles",
				Args = { Groups = { "RockFaces2", "EchoGhosts" } },
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus07" }
					},
				},
			},
		},

		InspectPoints =
		{
			[702518] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						--
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_Bridge_01 =
					{
						{ Cue = "/VO/Storyteller_0171",
							Text = "{#Emph}A deep ravine within the Fields of Mourning spreads forth like a gash across the Underworld's heart; and even hateful spirits know to stay away." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0817", Text = "Need to keep pushing forward, out of here..." },
						},
					},
				},
			},
		},

	},

	H_MiniBoss01 =
	{
		InheritFrom = { "BaseH", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",

		HasFishingPoint = false,
		
		SecretSpawnChance = 0.0,
		SuppressRewardSpawnSounds = false,
		ReverbValue = 0.8,

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "H_MiniBoss02" },
			},
		},

		SpawnRewardOnId = 621502,
		DisableRewardMagnetisim = true,

		LegalEncounters = { "MiniBossVampire" },
		FlipHorizontalChance = 0.0,

		ZoomFraction = 0.745,

		HarvestPointChances =
		{
			0.4,
		},
		ShovelPointChance = 0.5,
		PickaxePointChance = 0.45,
		ExorcismPointChance = 0.40,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		-- BoonRaritiesOverride = { Legendary = 0.1, Epic = 0.25, Rare = 0.90 },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.10, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 2,
		ForceAtBiomeDepthMax = 4,
		MaxAppearancesThisBiome = 1,

		EntranceDirection = "Left",

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		InspectPoints =
		{
			[722187] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						--
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_MiniBoss01_01 =
					{
						{ Cue = "/VO/Storyteller_0210",
							Text = "{#Emph}The dead are as innumerable as the sprigs of wheat within the Mourning Fields, but do not make for the most-satisfying sustenance for the unspeakable monstrosities therein." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_1215", Text = "The dead have suffered enough..." },
						},
					},
				},
			},
		},

		CombatResolvedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_MiniBoss02 =
	{
		InheritFrom = { "BaseH", },
		RewardPreviewIcon = "RoomRewardSubIcon_Miniboss",
		
		SecretSpawnChance = 0.0,

		RushMaxRangeOverride = 475,

		ReverbValue = 0.8,

		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "H_MiniBoss01" },
			},
		},

		SpawnRewardOnId = 621502,
		DisableRewardMagnetisim = true,

		LegalEncounters = { "MiniBossLamia" },
		FlipHorizontalChance = 0.0,

		ZoomFraction = 0.735,
		HarvestPointChances =
		{
			0.4,
		},
		ShovelPointChance = 0.5,
		PickaxePointChance = 0.45,
		ExorcismPointChance = 0.40,

		HoundFamiliarMovementRequiresLineOfSight = true,

		ForcedRewardStore = "RunProgress",
		EligibleRewards = { "Boon" },
		-- BoonRaritiesOverride = { Legendary = 0.1, Epic = 0.25, Rare = 0.90 },
		BoonRaritiesOverride = { Legendary = 0.05, Epic = 0.10, Rare = 0.90 },

		MaxCreationsThisRun = 1,
		ForceAtBiomeDepthMin = 2,
		ForceAtBiomeDepthMax = 4,
		MaxAppearancesThisBiome = 1,

		EntranceDirection = "Left",

		MusicSection = 2,
		MusicActiveStems = { "Guitar", "Bass", "Drums", },
		EndMusicOnCombatOver = 20,

		InspectPoints =
		{
			[722716] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						--
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_MiniBoss02_01 =
					{
						{ Cue = "/VO/Storyteller_0209",
							Text = "{#Emph}Within the vastly-sprawling Fields of Mourning reside countless sorrow-spreading Shades, as well as Daemons that insatiably feast upon their misery." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_1214", Text = "Giving snakes a bad name while they're at it..." },
						},
					},
				},
			},
		},

		CombatResolvedVoiceLines =
		{
			[1] = { GlobalVoiceLines = "MiniBossEncounterEndVoiceLines" },
		},
	},

	H_PreBoss01 =
	{
		InheritFrom = { "BaseH" },
	
		LinkedRooms = { "H_Boss01", "H_Boss02" },

		ZoomFraction = 0.7,

		AlwaysForce = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomsEntered" },
				SumOf =
				{
					"H_Combat01", "H_Combat02", "H_Combat03", "H_Combat04", "H_Combat05", "H_Combat06", "H_Combat07", "H_Combat08",
					"H_Combat09", "H_Combat10", "H_Combat11", "H_Combat12", "H_Combat13", "H_Combat14", "H_Combat15",
					"H_MiniBoss01", "H_MiniBoss02",
					"H_Bridge01",
				},
				Comparison = ">=",
				Value = 4,
			},
		},
		
		ZagContractRewardDestinationId = 776337,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,
		
		SecretSpawnChance = 0.0,

		SkipLastKillPresentation = true,
		LegalEncounters = { "Shop" },
		ForcedFirstReward = "Shop",
		StartUnthreadedEvents = EncounterSets.ShopRoomEvents,
		ForcedRewardStore = "RunProgress",
		IneligibleRewards = { "Devotion", "RoomMoneyDrop", },
		SpawnRewardOnId = 565384,

		DisableRewardMagnetisim = true,

		ResetBinksOnExit = true,

		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,

		IgnoreStemMixer = true,
		MusicMutedStems = { "Drums", "Bass", "Guitar", },

		HarvestPointChances = { 0.33 },
		ShovelPointChance = 0.33,
		PickaxePointChance = 0.33,
		ExorcismPointChance = 0.33,
		FishingPointChance = 0.33,

		InspectPoints =
		{
			[622357] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						--
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_PreBoss_01 =
					{
						{ Cue = "/VO/Storyteller_0172",
							Text = "{#Emph}The Underworld's pulsing, winding River Styx cuts through the edges of the sorrow-spreading Fields, connecting to the depths of Tartarus below." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0818", Text = "This truly is the Styx... then I'm so close...!" },
						},
					},
				},
			},
			[702523] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_PreBoss_02 =
					{
						{ Cue = "/VO/Storyteller_0173",
							Text = "{#Emph}Beyond awaits the monstrous Hound of Hell, no longer watchful of the Underworld's gates, but now grown desperate to return to his grim master, wherever he resides." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0819", Text = "Poor Cerberus..." },
						},
					},
				},
			},
		},

	},

	H_Boss01 =
	{
		InheritFrom = { "BaseH" },
		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = "<",
					Value = 3,
				},
			},
		},

		HasFishingPoint = false,

		BackupCauseOfDeath = "InfestedCerberus",

		RequiresLinked = true,
		LinkedRoom = "H_PostBoss01",
		ExitPreviewAnim = "ExitDownPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",
		ExitFunctionName = "LeaveRoomHBossPresentation",
		NoReroll = true,
		NarrativeContextArt = "nil",
		SuppressRewardSpawnSounds = false,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossInfestedCerberus01", },
		ForcedReward = "MixerHBossDrop",

		EntranceFunctionName = "RoomEntranceBossFields",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 619155 },
		IntroSequenceDuration = 0.95,
		BlockCameraReattach = true,
		ZoomFraction = 0.69,
		ThreadEnterVoiceLines = true,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 619155 },
					SetupBossIds = { 619155 },
					UnlockDelay = 3.0,
					DelayedStart = true,
				},
			},
		},

		PostCombatReloadEvents =
		{
			{
				FunctionName = "H_BossReloadCleanup"
			},
			{
				FunctionName = "H_ReloadHideGhostWalls"
			}
		},

		EntranceDirection = "Right",
		FlipHorizontalChance = 0.0,

		LeavePostPresentationEvents =
		{
			{
				FunctionName = "BiomeMapPresentation",
				Args =
				{
					HeroStartOffsetX = 40 + 670 - 60,
					HeroStartOffsetY = 880 + 210,

					FamiliarStartOffsetX = -75 + 670 + 155,
					FamiliarStartOffsetY = 880 + 210 - 40,

					HeroMoveOffsetX = -600,
					HeroMoveOffsetY = 440,
					HeroMoveDuration = 1.4,

					FamiliarMoveOffsetX = -600,
					FamiliarMoveOffsetY = 440,
					FamiliarMoveDuration = 1.4,

					MoveEaseIn = 0.5,
					MoveEaseOut = 1.0,

					CameraEndOffsetY = -160,

					BiomeStart = "BiomeH",
					BiomeEnd = "BiomeI",
					PreviousBiomes = { "BiomeF", "BiomeG" },

					ShrineBounty = "BossChronos01",
					
					CrossroadsStart = false,

					ExtraObjects =
					{
						{
							Name = "BlankObstacle3D",
							Model = "BannerMarker_Mesh",
							Animation = "BannerMarkerIdle",
							OffsetX = 10,
							OffsetY = 1520,
							Angle = 305,
						},
					},
					
				},
				GameStateRequirements =
				{
					-- None
				}
			},
		},

		InspectPoints =
		{
			[702524] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "InfestedCerberus" },
						Comparison = ">=",
						Value = 2,
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_Boss_02 =
					{
						{ Cue = "/VO/Storyteller_0175",
							Text = "{#Emph}Even the doleful residents of the Mourning Fields would rather languish longer there than plummet deeper into the abyss, where only the most wretched Shades reside." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							GameStateRequirements =
							{
								{
									PathFalse = { "GameState", "ReachedTrueEnding" }
								},
							},

							{ Cue = "/VO/MelinoeField_0821", Text = "Only the most wretched, serving Chronos..." },
						},
					},
				},
			},

			[702525] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_H_Boss_02" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_Boss_01 =
					{
						{ Cue = "/VO/Storyteller_0174",
							Text = "{#Emph}Having quelled the fury of the fearsome triple-headed monster Cerberus, the Princess of the Dead stands poised to delve into the pits of Tartarus, where waits her lifelong foe." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0820", Text = "We're now so close, aren't we...?" },
						},
					},
				},
			},

		},

		ExitVoiceLines =
		{
			PreLineWait = 0.45,
			RandomRemaining = true,
			BreakIfPlayed = true,
			SuccessiveChanceToPlay = 0.33,
			SuccessiveChanceToPlayAll = 0.1,
			GameStateRequirements =
			{
				{
				},
			},
			Cooldowns =
			{
				{ Name = "LeftBiomeSpeech", Time = 6 },
			},
			
			{ Cue = "/VO/MelinoeField_0946", Text = "Almost there..." },
			{ Cue = "/VO/MelinoeField_0947", Text = "Farewell, Fields..." },
			{ Cue = "/VO/MelinoeField_0948", Text = "Finally out of here...", PlayFirst = true },
		},

	},

	H_Boss02 =
	{
		InheritFrom = { "BaseH" },
		Ambience = "/Leftovers/Ambience/BurningAmbience",

		GameStateRequirements =
		{
			{
				FunctionName = "RequiredShrineLevel",
				FunctionArgs =
				{
					ShrineUpgradeName = "BossDifficultyShrineUpgrade",
					Comparison = ">=",
					Value = 3,
				},
			},
		},

		HasFishingPoint = false,
		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,

		BackupCauseOfDeath = "InfestedCerberus",

		RequiresLinked = true,
		LinkedRoom = "H_PostBoss01",
		ExitPreviewAnim = "ExitDownPreview",
		RewardPreviewIcon = "RoomRewardSubIcon_Boss",
		ExitFunctionName = "LeaveRoomHBossPresentation",
		NoReroll = true,
		NarrativeContextArt = "nil",
		SuppressRewardSpawnSounds = false,

		ResetBinksOnEnter = true,
		ResetBinksOnExit = true,
		LegalEncounters = { "BossInfestedCerberus02", },
		ForcedReward = "MixerHBossDrop",

		EntranceFunctionName = "RoomEntranceBossFields",
		EntranceFunctionArgs = { AngleTowardsIdOnEnd = 738212 },
		IntroSequenceDuration = 0.95,
		BlockCameraReattach = true,
		ZoomFraction = 0.69,
		ThreadEnterVoiceLines = true,

		UnthreadedEvents =
		{
			{
				FunctionName = "BossIntro",
				Args =
				{
					ProcessTextLinesIds = { 738212 },
					SetupBossIds = { 738212 },
					UnlockDelay = 3.0,
					DelayedStart = true,
				},
			},
		},

		LeavePostPresentationEvents =
		{
			{
				FunctionName = "BiomeMapPresentation",
				Args =
				{
					HeroStartOffsetX = 40 + 670 - 60,
					HeroStartOffsetY = 880 + 210,

					FamiliarStartOffsetX = -75 + 670 + 155,
					FamiliarStartOffsetY = 880 + 210 - 40,

					HeroMoveOffsetX = -600,
					HeroMoveOffsetY = 440,
					HeroMoveDuration = 1.4,

					FamiliarMoveOffsetX = -600,
					FamiliarMoveOffsetY = 440,
					FamiliarMoveDuration = 1.4,

					MoveEaseIn = 0.5,
					MoveEaseOut = 1.0,

					CameraEndOffsetY = -160,

					BiomeStart = "BiomeH",
					BiomeEnd = "BiomeI",
					PreviousBiomes = { "BiomeF", "BiomeG" },

					ShrineBounty = "BossChronos01",
					
					CrossroadsStart = false,

					ExtraObjects =
					{
						{
							Name = "BlankObstacle3D",
							Model = "BannerMarker_Mesh",
							Animation = "BannerMarkerIdle",
							OffsetX = 10,
							OffsetY = 1520,
							Angle = 305,
						},
					},
					
				},
				GameStateRequirements =
				{
					-- None
				}
			},
		},

		PostCombatReloadEvents =
		{
			{
				FunctionName = "H_BossReloadCleanup"
			},
			{
				FunctionName = "H_ReloadHideGhostWalls"
			}
		},

		EntranceDirection = "Right",
		FlipHorizontalChance = 0.0,

		InspectPoints =
		{
			[792151] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_Boss02_01 =
					{
						{ Cue = "/VO/Storyteller_0421",
							Text = "{#Emph}The fear-invoking greater daemons that took hold of Cerberus have scattered into dark recesses, terrified perhaps by the sheer might of our Princess." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3614", Text = "I don't even really mind the heat." },
						},
					},
				},
			},
			[793949] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_Boss02_02 =
					{
						{ Cue = "/VO/Storyteller_0456",
							Text = "{#Emph}Apocalyptic hellfire for which the triple-headed monster Cerberus is known engulfs this portion of the miserable Fields; the Fear yet hanging in the air providing fuel." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_3654", Text = "Heard Asphodel would overflow like this." },
						},
					},
				},
			},
		},
	},

	H_PostBoss01 =
	{
		InheritFrom = { "BaseH" },
		RichPresence = "#RichPresence_PostBossUnderworld",
		LegalEncounters = { "Empty" },
		HasFishingPoint = false,
		HasHarvestPoint = false,
		HasShovelPoint = false,
		HasPickaxePoint = false,
		HasExorcismPoint = false,
		Ambience = "/Ambience/ClockworkTartarusAmbience",
		ChallengeSwitchCannotUseText = "nil",
		SellShopSpawnChance = 1.0,
		SellShopRequirements =
		{
			-- None
		},

		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,

		GameStateRequirements =
		{
			-- None
		},

		EntranceFunctionName = "RoomEntrancePortal",

		RequiresLinked = true,
		NextRoomSet = { "I", },
		LinkedRoom = "I_Intro",
		ExitPreviewAnim = "ExitDownPreview",
		IgnoreMusic = true,
		BlockRunProgressUI = true,
		EntranceDirection = "Right",
		NoReward = true,
		NoReroll = true,
		ZoomFraction = 0.75,

		FlipHorizontalChance = 0.0,
		IntroSequenceDuration = 0.9,

		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,

		ExitPath = { 558947 },

		SkipLastKillPresentation = true,
		ChallengeSpawnChance = 0.0,
		WellShopSpawnChance = 1.0,
		 
		ForceWellShop = true,
		WellShopChallengeBaseId = 487438,
		SellTraitShrineUpgrade = true,

		WellShopRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradePostBossWellShops" },
			},
		},

		EnterVoiceLines =
		{
			{
				PreLineWait = 1.2,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.5,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_3507", Text = "That Pool of Purging is restored.", PlayFirst = true, PlayOnce = true,
					PreLineWait = 1.3,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeRestoreSellTraitShop" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1257", Text = "The old service hall..." },
				{ Cue = "/VO/MelinoeField_1258", Text = "Made it back here..." },
				{ Cue = "/VO/MelinoeField_1259", Text = "So much dust..." },
				{ Cue = "/VO/MelinoeField_1260", Text = "Out of the Fields at least..." },
				{ Cue = "/VO/MelinoeField_1261", Text = "Authorized personnel only...", PlayFirst = true },
			},
		},
		ExitVoiceLines =
		{
			-- intentionally blank, handled via PostBossHiddenExitUsedVoiceLines
		},

		ObstacleData =
		{
			[557482] =
			{
				Template = "HealthFountain",
				Activate = true,
				ActivateIds = { 557482, },
				InteractDistance = 200,
				InteractOffsetX = -20,
				InteractOffsetY = 30,
				SetupGameStateRequirements =
				{
					-- None
				},
			},
			[637430] =
			{
				Template = "GiftRack",
				Activate = true,
				ActivateIds = { 637431, 637432, 637433, 637434, 557141 },
				InteractDistance = 175,
				InteractOffsetX = 50,
				InteractOffsetY = -50,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossGiftRack" },
					},
				},
			},
			[487438] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				ActivateIds = { 486371 },
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradePostBossWellShops" },
					},
				},
			},
			[755008] =
			{
				Template = "ChallengeSwitchBase",
				Activate = true,
				SetupGameStateRequirements =
				{
					-- None
				},
				SetupEvents =
				{
					{
						FunctionName = "GenericPresentation",
						Args =
						{
							ActivateIds = { 755099 },
						},
						GameStateRequirements =
						{
							{
								Path = { "GameState", "WorldUpgrades" },
								HasAny = { "WorldUpgradeRestoreSellTraitShop", "WorldUpgradePostBossSellTraitShops" },
							},
						},
					},
				},
			},

			-- Asphodel Old Exit
			[566246] =
			{
				Name = "AsphodelOldExit",
				DistanceTriggers =
				{
					{
						Repeat = true,
						WithinDistance = 125,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							SuccessiveChanceToPlayAll = 0.25,

							{ Cue = "/VO/MelinoeField_1262", Text = "Completely sealed off...", PlayFirst = true },
							{ Cue = "/VO/MelinoeField_1263", Text = "No turning back." },
							{ Cue = "/VO/MelinoeField_1264", Text = "Not going there." },
							{ Cue = "/VO/MelinoeField_1265", Text = "The path to Asphodel..." },
						}
					},
				}
			},

			-- Tartarus Old Exit
			[566285] =
			{
				Name = "TartarusOldExit",
				DistanceTriggers =
				{
					{
						Repeat = true,
						WithinDistance = 250,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							SuccessiveChanceToPlayAll = 0.25,

							{ Cue = "/VO/MelinoeField_1266", Text = "Predictably sealed shut." },
							{ Cue = "/VO/MelinoeField_1267", Text = "Not this way..." },
							{ Cue = "/VO/MelinoeField_1268", Text = "Beyond lies Tartarus..." },
							{ Cue = "/VO/MelinoeField_1269", Text = "No getting out this way...", PlayFirst = true },
						}
					},
				}
			}

		},

		InspectPoints =
		{
			[557494] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						--
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_PostBoss_01 =
					{
						{ Cue = "/VO/Storyteller_0176",
							Text = "{#Emph}Legions loyal to the Titan of Time yet guard the Underworld's major passageways, but remain unaware of certain secret methods of descending deep into the realm." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/MelinoeField_0822", Text = "Secrets of the Unseen..." },
						},
					},
				},
			},

			[557493] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_H_PostBoss_01" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_PostBoss_02 =
					{
						{ Cue = "/VO/Storyteller_0212",
							Text = "{#Emph}After the calculating Titan of Time wrested control of the Underworld, he sealed shut the major artery from Tartarus; yet the Princess of the Dead knows of a hidden passageway within." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/MelinoeField_1428", Text = "Secrets of the Unseen..." },
						},
					},
				},
			},

			[566337] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "Inspect_H_PostBoss_02" },
					},
					NamedRequirements = { "NoRecentInspectPointUsed" },
				},
				InteractTextLineSets =
				{
					Inspect_H_PostBoss_03 =
					{
						{ Cue = "/VO/Storyteller_0213",
							Text = "{#Emph}The vengeful Princess once more finds herself within a groaning old official passageway to Tartarus; perhaps the very place her Titan foe used to escape his aeons of imprisonment." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

							{ Cue = "/VO/MelinoeField_1429", Text = "Crawled up from the lowest depths, did he...?" },
						},
					},
				},
			},

		},

	},

	H_CombatData =
	{
		InheritFrom = { "BaseH" },
		DebugOnly = true,

		NoReward = true,
		DisableRewardMagnetisim = true,
		IgnoreMainEncounterForInventory = true,
		IgnoreMainEncounterForFamiliar = true,

		--ForcedRewardStore = "FieldsCombatRewards",

		ZoomFraction = 0.7,

		StartUnthreadedEvents =
		{
			{ FunctionName = "SpawnRewardCages", GameStateRequirements = { ChanceToPlay = 1.0 }, Args = {} },
			{ FunctionName = "SpawnPassiveFieldsEnemies", GameStateRequirements = { ChanceToPlay = 1.0 }, Args = { } },
		},

		MaxCageRewards = 2,

		SkipNemesisSpawnPresentation = true,
		IgnoreStemMixer = true,
		MusicMutedStems = { "Drums", },
		CombatOverMusicEvents =
		{
			{
				-- Turn off Guitar/Bass after all encounters
				GameStateRequirements =
				{
					-- None
				},
				MusicMutedStems = { "Guitar", "Bass" },
			},
			{
				-- Turn off Drums after final encounter
				GameStateRequirements =
				{
					{
						Path = { "MapState", "RoomRequiredObjects", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
				},
				MusicMutedStems = { "Drums", },
			},
		},
	},

	H_Combat01 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "Left",

		MaxCageRewards = 5,

		RewardCageSpawnPoints =
		{
			[568806] = "SpawnPointsA",
			[568804] = "SpawnPointsB",
			[568803] = "SpawnPointsC",
			[40055] = "SpawnPointsD",
			[568805] = "SpawnPointsE",
		},
	},

	H_Combat02 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		LegalEncounters = EncounterSets.HEncountersPassiveSmall,

		MaxCageRewards = 3,

		RewardCageSpawnPoints =
		{
			[621502] = "SpawnPointsA",
			[622508] = "SpawnPointsB",
			[622860] = "SpawnPointsC",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 4,
			},
		},
	},

	H_Combat03 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "Left",

		MaxCageRewards = 3,

		RewardCageSpawnPoints =
		{
			[40055] = "SpawnPointsA",
			[568938] = "SpawnPointsB",
			[568943] = "SpawnPointsC",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},		
	},

	H_Combat04 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		MaxCageRewards = 4,

		RewardCageSpawnPoints =
		{
			[573089] = "SpawnPointsA",
			[573088] = "SpawnPointsB",
			[569103] = "SpawnPointsC",
			[573087] = "SpawnPointsD",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_Combat05 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",
		
		HasFishingPoint = false,

		MaxCageRewards = 5,

		RewardCageSpawnPoints =
		{
			[573087] = "SpawnPointsA",
			[622144] = "SpawnPointsB",
			[622143] = "SpawnPointsC",
			[621494] = "SpawnPointsD",
			[621539] = "SpawnPointsE",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_Combat06 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		MaxCageRewards = 5,

		RewardCageSpawnPoints =
		{
			[621502] = "SpawnPointsA",
			[573087] = "SpawnPointsB",
			[622316] = "SpawnPointsC",
			[622318] = "SpawnPointsD",
			[622317] = "SpawnPointsE",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_Combat07 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		MaxCageRewards = 3,

		UnoccupiedRewardCullCount = 11,

		RewardCageSpawnPoints =
		{
			[573087] = "SpawnPointsA",
			[621503] = "SpawnPointsB",
			[621494] = "SpawnPointsC",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_Combat08 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "Right",

		MaxCageRewards = 3,

		UnoccupiedRewardCullCount = 11,

		RewardCageSpawnPoints =
		{
			[621402] = "SpawnPointsA",
			[621428] = "SpawnPointsB",
			[573087] = "SpawnPointsC",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_Combat09 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "Left",

		LegalEncounters = EncounterSets.HEncountersPassiveSmall,

		HasFishingPoint = false,

		RewardCageSpawnPoints =
		{
			[621502] = "SpawnPointsA",
			[715375] = "SpawnPointsB",
			[715348] = "SpawnPointsC",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 4,
			},
		},
	},

	H_Combat10 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		MaxCageRewards = 5,

		RewardCageSpawnPoints =
		{
			[624513] = "SpawnPointsA",
			[624446] = "SpawnPointsB",
			[624455] = "SpawnPointsC",
			[624473] = "SpawnPointsD",
			[624464] = "SpawnPointsE",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_Combat11 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		MaxCageRewards = 5,

		UnoccupiedRewardCullCount = 15,

		RewardCageSpawnPoints =
		{
			[622748] = "SpawnPointsA",
			[621502] = "SpawnPointsB",
			[622768] = "SpawnPointsC",
			[622753] = "SpawnPointsD",
			[622758] = "SpawnPointsE",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_Combat12 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		MaxCageRewards = 3,

		UnoccupiedRewardCullCount = 11,

		RewardCageSpawnPoints =
		{
			[627112] = "SpawnPointsA",
			[627110] = "SpawnPointsB",
			[627077] = "SpawnPointsC",
		},

		ExitsUnlockedDistanceTriggers =
		{
			{
				TriggerObjectType = "FieldsExitDoor",
				WithinDistance = 600,
				GlobalVoiceLines = "ForkingPathVoiceLines",
			},
		},
	},

	H_Combat13 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		LegalEncounters = EncounterSets.HEncountersPassiveSmall,

		MaxCageRewards = 2,

		RewardCageSpawnPoints =
		{
			[736880] = "SpawnPointsA",
			[715356] = "SpawnPointsB",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 4,
			},
		},

		HasFishingPoint = false,
	},

	H_Combat14 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",

		LegalEncounters = EncounterSets.HEncountersPassiveSmall,

		MaxCageRewards = 2,

		RewardCageSpawnPoints =
		{
			[621502] = "SpawnPointsA",
			[736882] = "SpawnPointsB",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 4,
			},
		},
	},

	H_Combat15 =
	{
		InheritFrom = { "H_CombatData" },
		EntranceDirection = "LeftRight",
		FlipHorizontalChance = 0.0,

		LegalEncounters = EncounterSets.HEncountersPassiveSmall,

		MaxCageRewards = 3,

		RewardCageSpawnPoints =
		{
			[737530] = "SpawnPointsA",
			[737521] = "SpawnPointsB",
			[621502] = "SpawnPointsC",
		},

		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = "<",
				Value = 4,
			},
		},
	},
}
AddTableKeysCheckDupes( RoomData, RoomSetData.H )