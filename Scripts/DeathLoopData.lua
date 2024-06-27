GameData.HubMapName = "Hub_Main"
HubRoomData = HubRoomData or {}
OverwriteTableKeys( HubRoomData, {
	BaseHub =
	{
		-- NarrativeContextArt = "DialogueBackgroundBiome_Woods",
		ObjectiveStartX = 40,
		SaveProfileLocationText = "Location_Home"
	},

	-- Crossroads Main Hub
	Hub_Main =
	{
		InheritFrom = { "BaseHub", },
		FullscreenEffectGroup = "LoungeHider_01",
		RichPresence = "#RichPresence_House",
		EntranceFunctionName = "EnterHubRoomPresentation",
		NarrativeContextArt = "DialogueBackgroundBiome_Woods",
		NarrativeContextArtFlippable = true,
		FishBiome = "F",

		-- camera
		ZoomFraction = 1.23,
		ZoomLerpTime = 4.0,
		SoftClamp = 0.8,
		CameraZoomWeights =
		{
			--[576055] = 1.05, -- tent intro
			[576048] = 1.05, -- tent back
			[576047] = 0.690, -- leaving tent
			--[576056] = 0.500, -- cauldron 1
			--[576057] = 0.500, -- cauldron 2
			[576046] = 0.550, -- behind Hecate (target 0.68)
			--[576052] = 0.600, -- broker
			--[576053] = 0.71, -- cafeteria
			--[576054] = 0.71, -- Eris
			--[576051] = 0.72, -- Nemesis
			--[576050] = 1.10, -- Hypnos
			[576049] = 0.720, -- PreRun exit
		},

		IntroSequenceDuration = 0.6,
		RushMaxRangeOverride = 455,

		BlockCombatUI = true,

		IgnoreStemMixer = true,
		AmbientMusicParams =
		{
			LowPass = 0.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/RunstartIntroAmbience",
		ReverbValue = 0.4,
		RemoveDashFireFx = true,

		GhostCollisionEmote = "Disgruntled",

		FailedToFireFunctionName = "DeathAreaAttackFailPresentation",

		DistanceTriggers =
		{
			-- Tent Dim
			{
				TriggerGroup = "TentExit", WithinDistance = 200, FunctionName = "TentExitPresentation", Repeat = true,
			},
			{
				TriggerGroup = "TentEntrance", WithinDistance = 250, FunctionName = "TentEnterPresentation", Repeat = true,
			},

			-- Tent Exit
			{
				TriggerGroup = "TentExit",
				WithinDistance = 150,
				TriggerOnceThisRun = true,
				FunctionName = "DisplayInfoBanner",
				Args =
				{
					Text = "Location_Home",
					Color = Color.White,
					FadeColor = Color.Red,
					Delay = 0.2,
					Duration = 2.25,
				},
				VoiceLines =
				{
					{
						PlayOnce = true,
						PreLineWait = 0.75,
						Queue = "NeverQueue",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = "==",
								Value = 0,
							},
						},
						{ Cue = "/VO/Melinoe_1164", Text = "Stand tall and show no weakness...",
							GameStateRequirements =
							{
								{
									PathFalse = { "CurrentRun", "Cleared" },
								},
							},
						},
						{ Cue = "/VO/Melinoe_2950", Text = "{#Emph}Ah! {#Prev}Carry on, everyone. I'm OK.",
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "Cleared" },
								},
							},
						},
					},
				},
			},
			-- Cauldron Unlock
			{
				TriggerObjectType = "CriticalItemWorldObject01",
				WithinDistance = 400,
				VoiceLines =
				{
					PlayOnce = true,
					PlayOnceContext = "FatedListReveal",
					UsePlayerSource = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "CompletedRunsCache" },
							Comparison = "==",
							Value = 1,
						},
					},
					{ Cue = "/VO/Melinoe_2820", Text = "The cauldron's ready for me now..." },
				},
			},

			-- Fated List Reveal
			{
				TriggerObjectType = "CrossroadsFatedList",
				WithinDistance = 400,
				VoiceLines =
				{
					PlayOnce = true,
					PlayOnceContext = "FatedListReveal",
					UsePlayerSource = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "ScreensViewed", "QuestLog" },
						},
					},
					{ Cue = "/VO/Melinoe_1585", Text = "Is that...?" },
				},
			},

			-- Eris Trash
			{
				TriggerGroup = "ErisCorner",
				WithinDistance = 460,
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					{
						PlayOnce = true,
						PlayOnceContext = "ErisTrashIntroVO",
						GameStateRequirements =
						{
							{
								PathNotEmpty = { "GameState", "ActiveLitter" },
							},
						},
						{ Cue = "/VO/Melinoe_2439", Text = "What is all this...?" },
					},
				},
			},

		},

		StartUnthreadedEvents =
		{
			-- Taverna Unlock
			{
				FunctionName = "ClearMapBlockers",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				Args =
				{
					DeleteGroups = { "Taverna_Blocker", "TavernaDimmer_01" },
				},
			},

			-- Fishing Unlock / Docks Unlock
			{
				FunctionName = "ClearMapBlockers",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					}
				},
				Args =
				{
					DeleteGroups = { "Docks_Blocker", "DocksDimmer_01" },
				},
			},

			-- HotSprings Unlock / BathHouse Unlock
			{
				FunctionName = "ClearMapBlockers",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
				},
				Args =
				{
					DeleteGroups = { "Bath_Blocker", "BathDimmer_01" },
				},
			},

			-- iris npcs / critical conversations / priority conversations
			{
				FunctionName = "CheckPriorityConversations",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					IgnorePartnerExists = true,
					Conversations =
					{
						-- introductions
						"DoraFirstMeeting",
						"ArtemisHubFirstMeeting01",
						"OdysseusFirstMeeting",
						"NemesisFirstMeeting",
						"MorosFirstMeeting",
						"ErisFirstMeeting_B",
						"ErisFirstMeeting",

						-- Hecate key events
						"HecateAboutChronosBossW01",
						"HecateAboutChronosBossL01",
						"HecateAboutChronosAnomaly01",
						"HecateAboutChronos01",
						"HecateAboutHermes01",
						"HecateUnderworldRunCleared01",
						"HecateAboutQuestLog02",
						"HecateAboutSurface03",
						"HecateAboutFates01",
						-- "HecateAboutBackstory01",

						-- Odysseus key events
						"OdysseusAboutHermes01",
						"OdysseusAboutSurface01",
						"OdysseusAboutSurface02",
						"OdysseusAboutChronosAnomaly01",
						"OdysseusAboutMailbox01",

						-- Dora key events
						"DoraAboutTask01",

						-- Moros key events
						"MorosAboutFates02",
						"MorosAboutSurfacePenaltyCure01",
						"MorosAboutChronosBossW01",

						-- Nemesis key events
						"NemesisAboutFieldMeeting01",
						"NemesisAboutCombatFailure01",
						"NemesisAboutChronosNightmare01",

						-- Eris key events
						"ErisFoughtAgainstHer01",
						"ErisAboutCloseMatch01",

						-- Charon key events
						"CharonWithHecate01", -- Mailbox

						-- Selene key events
						"SeleneWithHecate01",
						"SeleneHome01",

						-- Medea key events
						"MedeaHubFirstMeeting01",
					},
				},
			},
			-- hypnos always present
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					--
				},
				Args =
				{
					Types =
					{
						"NPC_Hypnos_01",
					},
				},
			},
			-- frinos always present
			{
				FunctionName = "ActivateFamiliar",
				GameStateRequirements =
				{
					--
				},
				Args =
				{
					Id = 566831,
					Name = "FrogFamiliar",
					OverwriteSelf =
					{
						OnUsedFunctionName = "nil",
					},
				},
			},
			-- hecate always present until you talk to her or if you lost to her
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "UseRecord", "NPC_Hecate_01" },
					},
					{
						PathFalse = { "GameState", "RoomCountCache", "F_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "HecateHideAndSeek01" },
					},
				},
				Args =
				{
					Types =
					{
						"NPC_Hecate_01",
					},
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "HecateHideAndSeek01" },
					},
				},
				Args =
				{
					Types =
					{
						"NPC_Hecate_01",
					},
				},
			},
			-- Main NPC randomization
			{
				FunctionName = "ActivateRotatingNPCs",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					Types =
					{
						"NPC_Hecate_01",
						"NPC_Odysseus_01",
						"NPC_Nemesis_01",
						"NPC_Eris_01",
						"NPC_Moros_01",
						"NPC_Dora_01",
						-- "NPC_Hypnos_01",
					},
					LeaveOutMin = 1,
					LeaveOutMax = 1,
					ActivationsMin = 3,
					ActivationsMax = 9,
				},
			},
			-- dora always present after Cosmetics unlocked
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					NamedRequirements = { "CosmeticsShopUnlocked" },
				},
				Args =
				{
					Types =
					{
						"NPC_Dora_01",
					},
					OverwriteSelf =
					{
						DefaultCategoryIndex = 1,
					},
				},
			},
			{
				FunctionName = "TentExitPresentation",
				Args =
				{
					Override = true
				},
				GameStateRequirements =
				{
					{
						Path = { "PreviousDeathAreaRoom", "Name" },
						IsAny = { "Hub_PreRun" },
					},
				},
			},
			{
				FunctionName = "RestoreLitter",
				GameStateRequirements =
				{
					-- None
				},
			},
			-- charon present when deliveries arrive
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "AnyMailboxReady" },
					},
				},
				Args =
				{
					Types =
					{
						"NPC_Charon_01",
					},
				},
			},
			{
				FunctionName = "ActivateConditionalItems",
				Args =
				{
					CosmeticsShopCategoryIndex = 1,
					GhostAdminCategoryIndex = 1,
				},
			},
			{
				FunctionName = "ActivateConditionalItems",
				Args =
				{
					CosmeticsShopCategoryIndex = 2,
				},
			},

			-- Ghost Eavesdroppers
			-- first run (alt below)
			{
				FunctionName = "GhostEavesdroppers",
				Args =
				{
					RandomGroups =
					{
						{ 590510, 590509, 590508, },
					},
					InspectPoint =
					{
						Name = "GhostInspectPoint",
						UseTextSpecial = "UseGhostEavesdropper",
						SpecialInteractFunctionName = "UseGhostEavesdropper",
						RandomLines =
						{
							"Ghost_Recruit01",
							"Ghost_Recruit02",
							"Ghost_Recruit03",
							"Ghost_Recruit04",
							"Ghost_Recruit05",
							"Ghost_Recruit06",
							"Ghost_Recruit07",
							"Ghost_Recruit08",
							"Ghost_Recruit09",
							"Ghost_Recruit10",
							"Ghost_Recruit11",
							"Ghost_Recruit12",
						},
					}
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
			},
			-- subsequent runs (before taverna)
			{
				FunctionName = "GhostEavesdroppers",
				Args =
				{
					RandomGroups =
					{
						{ 590511, 590512, 590507, },
						{ 590513, 590514, 590515, },
						{ 590510, 590509, 590508, },
						{ 590880, 590882, 590879, },
					},
					InspectPoint =
					{
						Name = "GhostInspectPoint",
						UseTextSpecial = "UseGhostEavesdropper",
						SpecialInteractFunctionName = "UseGhostEavesdropper",
						RandomLines =
						{
							"Ghost_Recruit01",
							"Ghost_Recruit02",
							"Ghost_Recruit03",
							"Ghost_Recruit04",
							"Ghost_Recruit05",
							"Ghost_Recruit06",
							"Ghost_Recruit07",
							"Ghost_Recruit08",
							"Ghost_Recruit09",
							"Ghost_Recruit10",
							"Ghost_Recruit11",
							"Ghost_Recruit12",
						},
					}
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
					ChanceToPlay = 0.75,
				},
			},
			-- subsequent runs (after taverna)
			{
				FunctionName = "GhostEavesdroppers",
				Args =
				{
					RandomGroups =
					{
						{ 590511, 590512, 590507, },
						{ 590513, 590514, 590515, },
						{ 590510, 590509, 590508, },
						{ 590880, 590882, 590879, },
						{ 590891, 590893, 590890, },
					},
					InspectPoint =
					{
						Name = "GhostInspectPoint",
						UseTextSpecial = "UseGhostEavesdropper",
						SpecialInteractFunctionName = "UseGhostEavesdropper",
						RandomLines =
						{
							"Ghost_Recruit01",
							"Ghost_Recruit02",
							"Ghost_Recruit03",
							"Ghost_Recruit04",
							"Ghost_Recruit05",
							"Ghost_Recruit06",
							"Ghost_Recruit07",
							"Ghost_Recruit08",
							"Ghost_Recruit09",
							"Ghost_Recruit10",
							"Ghost_Recruit11",
							"Ghost_Recruit12",
						},
					}
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					ChanceToPlay = 0.8,
				},
			},
			-- Ghost Admirers / Ghost Groupies
			{
				FunctionName = "GhostFollowers",
				Args =
				{
					SpawnChance = 1,
					SpawnCountMin = 4,
					SpawnCountMax = 6,
					ScaleMin = 0.5,
					ScaleMax = 0.7,
					SpawnTypes = { "SmallGhost01", },
					SpawnPointIds = { 560622, 585574 },
					SpawnRadius = 150,
					FollowDistance = 85,
					BufferDistance = 20,
					AggroDistance = 425,
					LoseAggroDistance = 1200,
					LoseAggroMeetUpId = 585574,
					LoseAggroMeetUpRadis = 100,
					Speed = 275,
					CloseMoveDuration = 1.0,
					CloseMoveDistance = 200,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" },
					},
					},
				},

			-- Exorcism Ghosts
			{
				FunctionName = "GhostRecruitsMain",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SpawnChance = 0.25,
					MaxSpawns = 1,
					SpawnPointIds = { 585600, 585597, 585599, 585601, },
				},
			},

			-- Moros Accessories
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },
					},
				},
				Args =
				{
					Groups = { "MorosAccessories" },
				},
			},

			{
				FunctionName = "SetupPrePlacedUnits",
				Args =
				{
					TypeNames = { "NPC_LightRanged" },
				},
			},
			{
				FunctionName = "UnlockDeathAreaInteractables",
				Args = {},
			},
			{
				FunctionName = "CheckConversations",
				Args =
				{
					CheckNoConversationFunctions = true,
				},
			},
			{
				FunctionName = "DisableWeapons",
				Args = {},
			},
			{
				FunctionName = "CheckDashOverride",
				Args = {},
			},
			{
				FunctionName = "PreGenerateNextBiomeState",
				Args = {},
			},
		},

		ThreadedEvents =
		{
			-- Ghost Patrols / GhostPatrol
			{
				FunctionName = "PatrolPath",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SpawnTypes = { "ShadeHubGarlicIdle01" },
					MaxPatrols = 1,
					SendPatrolInterval = 4,
					SpeedMin = 40,
					SpeedMax = 60,
					ScaleMin = 0.8,
					ScaleMax = 0.9,
					FadeInDuration = 0.5,
					Loop = true,
					Path =
					{
						{ Id = 585636, OffsetRadius = 50, PostArriveWait = 5, AngleTowardIdOnStop = 583631 },
						{ Id = 585635, OffsetRadius = 50, PostArriveWait = 5, AngleTowardIdOnStop = 567390 },
					},
				},
			},
			{
				FunctionName = "PatrolPath",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SpawnTypes = { "ShadeHubWaterIdle01" },
					MaxPatrols = 2,
					SendPatrolInterval = 12,
					SpeedMin = 70,
					SpeedMax = 100,
					ScaleMin = 0.8,
					ScaleMax = 0.9,
					FadeInDuration = 0.5,
					Loop = true,
					Path =
					{
						{ Id = 585618, OffsetRadius = 50 },
						{
							Branch =
							{
								{
									-- Branch Option A
									{ Id = 585628, OffsetRadius = 50, PostArriveWait = 2.5, AngleTowardIdOnStop = 584996 },
									-- { Id = 585629, OffsetRadius = 50 },
								},
								{
									-- Branch Option B
									{ Id = 585633, OffsetRadius = 50 },
								},
							},
						},
						{ Id = 585619, OffsetRadius = 50 },
						{
							Branch =
							{
								{
									-- Branch Option A
									-- Nemesis Loop
									{ Id = 585620, OffsetRadius = 50, PostArriveWait = 1, EmoteOnEndChance = 0.3, EmoteOnEnd = "Fear", AngleTowardIdOnStop = 585215 },
									{ Id = 585621, OffsetRadius = 50, PostArriveWait = 3, AngleTowardIdOnStop = 561072 },
									{ Id = 585622, OffsetRadius = 50 },
								},
								{
									-- Branch Option B
									-- Familiars
									{ Id = 585627, OffsetRadius = 50, PostArriveWait = 3, EmoteOnEndChance = 0.3, EmoteOnEnd = "Smile", AngleTowardIdOnStop = 576298 },
									{ Id = 585622, OffsetRadius = 50 },
								},
							},
						},
						{ Id = 585623, OffsetRadius = 50 },
						{
							Branch =
							{
								{
									-- Branch Option A
									-- Cauldron
									{ Id = 585630, OffsetRadius = 50, PostArriveWait = 3, EmoteOnEndChance = 0.3, EmoteOnEnd = "Victory", AngleTowardIdOnStop = 567390 },
									{ Id = 585631, OffsetRadius = 50 },
								},
								{
									-- Branch Option B
									-- { Id = 585623, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Determined", AngleTowardIdOnStop = 567390 },
									{ Id = 585623, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, AngleTowardIdOnStop = 567390 },
									{ Id = 585624, OffsetRadius = 50 },
								},
							},
						},
						-- Mel's Tent
						{ Id = 585625, OffsetRadius = 50 },
						{
							Branch =
							{
								{
									-- Branch Option A
									{ Id = 585637, OffsetRadius = 50 },
								},
								{
									-- Branch Option B
									{ Id = 585618, OffsetRadius = 50 },
								},
							},
						},
					},
				},
			},

			--[[
			{
				FunctionName = "PatrolPath",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SpawnTypes = { "TartarusGhost01" },
					MaxPatrols = 2,
					SendPatrolInterval = 2.5,
					SpeedMin = 120,
					SpeedMax = 120,
					FadeInDuration = 0.5,
					Loop = true,
					Path =
					{
						-- Mel's Tent
						{ Id = 585590, OffsetRadius = 50 },
						{ Id = 585605, OffsetRadius = 50 },
						{ Id = 585609, OffsetRadius = 50 },
						{ Id = 585588, OffsetRadius = 50 },
						{ Id = 585606, OffsetRadius = 50 },
						{ Id = 585607, OffsetRadius = 50 },
						-- { Id = 585607, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, AngleTowardIdOnStop = 567390 },
						{ Id = 585608, OffsetRadius = 50 },
					},
				},
			},
			{
				FunctionName = "PatrolPath",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SpawnTypes = { "TartarusGhost01" },
					MaxPatrols = 4,
					SendPatrolInterval = 3.0,
					SpeedMin = 100,
					SpeedMax = 200,
					FadeInDuration = 1.0,
					Loop = true,
					Path =
					{
						{ Id = 585587, OffsetRadius = 50 },
						
						{
							Branch =
							{
								{
									-- Branch Option A
									-- Tree Loop
									{ Id = 585588, OffsetRadius = 50 },
									{ Id = 585589, OffsetRadius = 50 },
									{ Id = 585590, OffsetRadius = 50 },
									{ Id = 585602, OffsetRadius = 50 },
								},
								{
									-- Branch Option B
									{ Id = 585587, OffsetRadius = 50 },
								},
							},
						},

						{
							Branch =
							{
								-- Cauldron South
								{
									-- Branch Option A
									{ Id = 585578, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Determined", AngleTowardIdOnStop = 567390 },
								},
								{
									-- Branch Option B
									{ Id = 585603, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Determined", AngleTowardIdOnStop = 567390 },
								},
								{
									-- Branch Option C
									{ Id = 585604, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Determined", AngleTowardIdOnStop = 567390 },
								},
							},
						},

						{
							Branch =
							{
								{
									-- Branch Option A
									{ Id = 585579, OffsetRadius = 30, },
									-- Broker
									{ Id = 585580, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Smile", AngleTowardIdOnStop = 558012 },
									{ Id = 585581, OffsetRadius = 30, },
								},
								{
									-- Branch Option B
									{ Id = 585582, OffsetRadius = 50, },
								},
							},
						},

						{ Id = 585582, OffsetRadius = 50, },
						{ Id = 585576, OffsetRadius = 50, },

						{
							Branch =
							{
								{
									-- Branch Option A
									-- Nemesis
									{ Id = 585575, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Disgruntled", AngleTowardIdOnStop = 585215 },

									{ Id = 585613, OffsetRadius = 50, },
									{ Id = 585614, OffsetRadius = 50, },
									{ Id = 585595, OffsetRadius = 50, },
								},
								{
									-- Branch Option B
									{ Id = 585615, OffsetRadius = 50, },
								},
							},
						},

						{ Id = 585610, OffsetRadius = 50, },
						-- Odysseus
						{ Id = 585583, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "OhBoy", AngleTowardIdOnStop = 561464 },

						{
							Branch =
							{
								{
									-- Branch Option A
									{ Id = 585584, OffsetRadius = 50, },
									-- Hypnos
									{ Id = 585593, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Grief", AngleTowardIdOnStop = 575786 },
									{ Id = 585584, OffsetRadius = 50, },
									{ Id = 585583, OffsetRadius = 50, },
								},
								{
									-- Branch Option B
									{ Id = 585585, OffsetRadius = 50, },
								},
							},
						},

						{ Id = 585585, OffsetRadius = 50, },

						{
							Branch =
							{
								{
									-- Branch Option A
									-- Hecate Familiars
									{ Id = 585594, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Fear", AngleTowardIdOnStop = 575786 },
									{ Id = 585611, OffsetRadius = 50, },
								},
								{
									-- Branch Option B
									{ Id = 585611, OffsetRadius = 50, },
								},
							},
						},

						-- Cauldron East
						{ Id = 585586, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Determined", AngleTowardIdOnStop = 567390 },

						{ Id = 585596, OffsetRadius = 50, },
						{ Id = 585578, OffsetRadius = 50, },

						-- Cauldron West
						{ Id = 585577, OffsetRadius = 50, },

						{
							Branch =
							{
								{
									-- Branch Option A
									-- Mel's Tent
									{ Id = 585590, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Embarrassed", AngleTowardIdOnStop = 576011  },
									-- Fated List
									{ Id = 585589, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Fear", AngleTowardIdOnStop = 560662 },
									{ Id = 585588, OffsetRadius = 50 },
								},
								{
									-- Branch Option B
									{ Id = 585612, OffsetRadius = 50, },
								},
							},
						},

						--[[
						{ Id = 393497, OffsetRadius = 200 },
						{
							Branch =
							{
								{
									{ Id = 393491, OffsetRadius = 30, },
									{
										Branch =
										{
											{
												{ Id = 393499, OffsetRadius = 10 },
												{ Id = 393485, OffsetRadius = 10, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Smile", AngleTowardIdOnStop = 370010 },
												{ Id = 393499, OffsetRadius = 10 },
											},
											{
												{ Id = 393484, OffsetRadius = 100, },
												{ Id = 393483, OffsetRadius = 30, },
												{ Id = 424986, OffsetRadius = 30, },
												{ Id = 424987, OffsetRadius = 10, PostArriveWait = 4, EmoteOnEnd = "Smile" },
												{ Id = 424986, OffsetRadius = 30, },
												{ Id = 393483, OffsetRadius = 30, },
												{ Id = 393484, OffsetRadius = 30, },
											},
											{
												{ Id = 393499, OffsetRadius = 10 },
												{ Id = 393498, OffsetRadius = 10, PostArriveWait = 2, EmoteOnEndChance = 0.3, EmoteOnEnd = "Disgruntled" },
												{ Id = 393499, OffsetRadius = 30, },
											},
										},
									},
								},

								{
									{ Id = 393492, OffsetRadius = 10 },
									{
										Branch =
										{
											{
												{ Id = 393486, OffsetRadius = 50, },
												{
													Branch =
													{
														{
															{ Id = 393489, OffsetRadius = 10, PostArriveWait = 1.0 },
															{ Id = 393486, OffsetRadius = 10, PostArriveWait = 1.0 },

														},
														{
															{ Id = 393487, OffsetRadius = 10 },
															{ Id = 393488, OffsetRadius = 10, PostArriveWait = 3.0 },
															{ Id = 393487, OffsetRadius = 10 },
															{ Id = 393486, OffsetRadius = 10 },
														},
														{
															{ Id = 421074, OffsetRadius = 10 },
															{ Id = 393490, OffsetRadius = 10, PostArriveWait = 2.0 },
															{ Id = 421074, OffsetRadius = 10 },
															{ Id = 393486, OffsetRadius = 10 },
														},
														{
															{ Id = 421072, OffsetRadius = 10, PostArriveWait = 2.0, MinUseInterval = 2.0, EmoteOnEnd = "Smile" },
															{ Id = 393486, OffsetRadius = 10 },
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},]]--
		},

		UnthreadedEvents =
		{

		},

		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					{
						Path = { "PreviousDeathAreaRoom", "Name" },
						IsAny = { "Hub_PreRun" },
					},
				},

				{ Cue = "/VO/Melinoe_1900", Text = "Come on, Mel. Exit's back the other way..." },
			},
		},

		InspectPointPriority =
		{
			421076, -- Homer Reveal
			560663, -- Fated List
			576171, -- Moros
		},
		-- Hub_Main InspectPoints
		InspectPoints =
		{
			[421076] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InteractTextLineSets =
				{
					InspectCrossroads01 =
					{
						{ Cue = "/VO/Storyteller_0234",
							AngleHeroTowardTargetId = 575836,
							Text = "{#Emph}The Crossroads: that haven hidden 'twixt the surface and the Underworld conceals those still loyal to Lord Hades, rightful ruler of the dead." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 2,
								{ Cue = "/VO/Melinoe_2959", Text = "Together, we'll retake my father's realm." },
								-- { Cue = "/VO/Melinoe_0031", Text = "Not many of us left..." },
							},
						},
					},
				},
			},

			-- Inspect: Tent 1
			[566844] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01", },
					},
					-- Dora inactive
					AreIdsNotAlive = { 560708, },
					MinRunsSinceAnyTextLines = { TextLines = { "InspectHomerReveal01" }, Count = 1 },
				},
				InteractTextLineSets =
				{
					InspectTent01 =
					{
						{ Cue = "/VO/Storyteller_0078",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}The modestly appointed tent of fierce Princess Melinoë nonetheless is dutifully organized and immaculately clean." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_0032", Text = "I won't live in squalor." },
						},
					},
				},
			},

			-- Inspect: Frinos
			[576169] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "SpecialInteractRecord", "FrogFamiliar" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 4,
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
				},
				InteractTextLineSets =
				{
					InspectTent01 =
					{
						{ Cue = "/VO/Storyteller_0121",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}The dark Princess reveals her deepest fears only to a stoic old amphibian, which long ago hopped into her tent, and into her heart." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1684", Text = "Only the deepest fears for you, Frinos!", PostLineFunctionName = "FrogFamiliarReaction" },
						},
					},
				},
			},

			-- Inspect: Crossroads Shades
			-- disabled for now
			--[[
			[558338] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectHomerReveal01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "InspectHomerReveal01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Hecate_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsShades01 =
					{
						-- { Cue = "/VO/Storyteller_0016",
							Text = "{#Emph}The deeds of peerless witch Melinoë are fated to spread far and wide across the surface and below; yet, she lives humbly, quite unbefitting of a Princess of the Dead." },
						-- { Cue = "/VO/Melinoe_0400",
							UsePlayerSource = true, 
							PortraitExitAnimation = "Portrait_Mel_Default_01_Exit",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "I like it here, Homer. And you have to keep quiet about me, all right?" },
						EndVoiceLines =
						{
							PreLineWait = 0.6,
							StatusAnimation = "StatusIconStorytellerSpeaking",
							StatusAnimSourceIsHero = true,
							Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
							RequiredMinElapsedTime = 3,
							-- { Cue = "/VO/Storyteller_0034", Text = "{#Emph}All right..." },
						},
					},
				},
			},
			]]--

			-- Inspect: Hypnos thicket
			[558339] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFirstMeeting" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 3,
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsThicket01 =
					{
						{ Cue = "/VO/Storyteller_0015",
							Text = "{#Emph}The darkly splendorous Melinoë attends a certain thicket of the Crossroads whenever she requires time to think and plan." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_0402", Text = "Time is against us..." },
						},
					},
				},
			},

			-- Inspect: Eris passage / Eris gate
			[558340] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisFirstMeeting", "ErisFirstMeeting_B", "ErisFoughtAgainstHer01" },
					},
					AreIdsNotAlive = { 590880, 590879, 590882, },
				},
				InteractTextLineSets =
				{
					InspectCrossroadsPassage01 =
					{
						{ Cue = "/VO/Storyteller_0012",
							Text = "{#Emph}The Crossroads hide the plans and movements of the nightmare-bringing witch and her compatriots, but for how long?" },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_0403", Text = "For long enough." },
						},
					},
				},

			},

			-- Inspect: Fated List
			[560663] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },						
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesViewed", "WorldUpgradeQuestLog" },
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "QuestLog" },
					},
					AreIdsNotAlive = { 560612 },
				},
				InteractTextLineSets =
				{
					InspectFatedList01 =
					{
						{ Cue = "/VO/Storyteller_0080",
							Text = "{#Emph}The last will of the Three Fates, those reclusive determiners of all that is to come, is now under the Princess of the Underworld's care." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1682", Text = "With their aid, we may have a chance." },
						},
					},
				},
			},

			-- Inspect: Odysseus
			[576168] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					IsIdAlive = 557112,
				},
				InteractTextLineSets =
				{
					InspectOdysseus01 =
					{
						{ Cue = "/VO/Storyteller_0122",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}Not even the wiles and stratagems of that resourceful sacker of cities, Odysseus, may be sufficient to overcome the Titan of Time..." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_1685", Text = "They say never to underestimate that man..." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Odysseus_01",
								{ Cue = "/VO/Odysseus_0123", Text = "{#Emph}Hah{#Prev}, come on." },
							},
						},
					},
				},
			},
			-- Inspect: Nemesis
			[576170] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 6,
					},
					RequiredFalseQueuedTextLines = { "NemesisWithMoros01", "NemesisWithHypnos01", "NemesisWithHecate01" },
					IsIdAlive = 557113,
				},
				InteractTextLineSets =
				{
					InspectNemesis01 =
					{
						{ Cue = "/VO/Storyteller_0134",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}The unhappy goddess of comeuppance casts her judging gaze on all within the Crossroads, which she safeguards out of duty, and of spite." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_1687", Text = "Don't want to get on Nem's bad side..." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Nemesis_01",
								{ Cue = "/VO/Nemesis_0120", Text = "Whatever." },
							},
						},
					},
				},
			},
			-- Inspect: Moros
			[576171] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
					RequiredFalseQueuedTextLines = { "MorosWithOdysseus01", "MorosWithHypnos01" },
					IsIdAlive = 560612,
				},
				InteractTextLineSets =
				{
					InspectMoros01 =
					{
						{ Cue = "/VO/Storyteller_0135",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}The widely-hated, feared embodiment of Doom goes wherever the ever-weaving Fates decide, and none but they can anticipate his arrival." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_1688", Text = "He sure knows how to make an entrance..." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Moros_01",
								{ Cue = "/VO/Moros_0093", Text = "Princess?" },
							},
						},
					},
				},
			},
			-- Inspect: Dora
			[576172] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Dora_01" },
						Comparison = ">=",
						Value = 5,
					},
					RequiredFalseQueuedTextLines = { "DoraWithMoros01", "DoraWithMoros02" },
					IsIdAlive = 566832,
				},
				InteractTextLineSets =
				{
					InspectDora01 =
					{
						{ Cue = "/VO/Storyteller_0136",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}Some Spirits of the Dead forever wander aimlessly, whilst others, lacking even so much will, merely linger in a single place." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_1689", Text = "Dora does need to get out more often..." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Dora_01",
								{ Cue = "/VO/Dora_0118", Text = "Not happening." },
							},
						},
					},
				},
			},
			-- Inspect: Broker
			[576166] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
					},
					IsIdAlive = 558096,
				},
				InteractTextLineSets =
				{
					InspectBroker01 =
					{
						{ Cue = "/VO/Storyteller_0129",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}After ever-scheming Chronos claimed the House of Hades, Shades of the Dead residing there all scattered to the ends of the earth." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							{ Cue = "/VO/Melinoe_1679", Text = "You Shades are welcome here and safe.",
								PostLineFunctionName = "WretchedBrokerReaction" },
						},
					},
				},
			},

			-- Inspect: Learned Sage
			[589547] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectTaverna01" }
					},
					IsIdAlive = 589466,
				},
				InteractTextLineSets =
				{
					InspectLearnedSage01 =
					{
						{ Cue = "/VO/Storyteller_0238",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}Much is to be learned from history, if one but studies the lessons hidden in any purported accounts; a lifelong pursuit, in and of itself." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							{ Cue = "/VO/Melinoe_2961", Text = "Still no telling what the future holds...", PostLineFunctionName = "LearnedSageReaction" },
						},
					},
				},
			},

			-- Inspect: Record Keeper
			[589548] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectTaverna01" }
					},
					IsIdAlive = 589467,
				},
				InteractTextLineSets =
				{
					InspectBroker01 =
					{
						{ Cue = "/VO/Storyteller_0239",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}Once there was an administrative chamber in the Underworld, where Shades kept careful track of each detail; a trade a few such souls as yet pursue." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							{ Cue = "/VO/Melinoe_2962", Text = "Surely such efforts were rewarded handsomely.", PostLineFunctionName = "RecordKeeperReaction" },
						},
					},
				},
			},

			-- Inspect: Taverna
			[576167] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				InteractTextLineSets =
				{
					InspectTaverna01 =
					{
						{ Cue = "/VO/Storyteller_0130",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}Fleeting is the sense of hope or joy within the Crossroads, yet what little may emerge is often concentrated in the small taverna there." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/Melinoe_1680", Text = "No time to unwind..." },
						},
					},
				},
			},

			-- Inspect: Docks
			[589545] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsFishingPoint01 =
					{
						{ Cue = "/VO/Storyteller_0241",
							Text = "{#Emph}Liquid lamentation flows through the River Cocytus, yet even in such hopeless waters, certain creatures learn to live and thrive." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_2964", Text = "I {#Emph}do {#Prev}sense some of them want out..." },
						},
					},
				},
			},

			-- Inspect: HotSprings
			[589546] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsBathHouse01 =
					{
						{ Cue = "/VO/Storyteller_0240",
							Text = "{#Emph}A small spring draws its heat from deep within the earth, its waters so pristine and pure that they can cleanse the body and the soul." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_2963", Text = "If I get in, I might never want to get out..." },
						},
					},
				},
			},

		},

		ObstacleData =
		{
			-- Broker / Iris Market / Resource Shop / Wretched Broker /
			[558096] =
			{
				Name = "Market",
				AnimOffsetZ = 420,
				EmoteOffsetZ = 140,
				InteractDistance = 300,
				InteractOffsetX = 0,
				InteractOffsetY = 0,
				UseText = "UseMarket",
				UseTextTalkAndSpecial = "UseMarketAndSpecial",
				OnUsedFunctionName = "UseMarketObject",

				SetupEvents =
				{
					{
						FunctionName = "GenerateMarketItems",
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant" },
						GameStateRequirements =
						{
							{
								FunctionName = "HasUnviewedMarketItem",
							},
						},
					},
				},

				SpecialInteractFunctionName = "SpecialInteractSaluteBroker",
				SpecialInteractGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "MarketScreen" },
					},
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MetaCurrency" },
						Comparison = ">=",
						Value = 200,
					},					
				},
				SpecialInteractCooldown = 60,
				InteractVoiceLines =
				{
					[1] =
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						-- RandomRemaining = true,
						SuccessiveChanceToPlay = 0.2,
						Cooldowns =
						{
							{ Name = "MelinoeSaluteSpeech", Time = 4 },
						},

						{ Cue = "/VO/Melinoe_1710", Text = "Moonlight guide you, Broker." },
					},
					[2] = GlobalVoiceLines.SaluteVoiceLines,
				},

				NoSaleEmote = "StatusIconSmile",
				MadeSaleEmote = "StatusIconOhBoy",
				Activate = true,
				SkipDefaultSetup = true, -- Handled by WorldUpgrade
				DistanceTriggers =
				{
					{
						WithinDistance = 600,
						ChanceToPlay = 0.75,
						TriggerOnceThisRun = true,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							TargetId = 558096,
							AnimationName = "StatusIconEmbarrassed",
							OffsetZ = 150,
						},
					},
				}
			},

			-- GameStatsScreen / Statistician / Record Keeper
			[589467] =
			{
				Name = "GameStatsScreen",
				AnimOffsetZ = 150,
				Activate = true,
				SkipDefaultSetup = true, -- Handled by WorldUpgrade
				InteractDistance = 250,

				UseText = "GameStatsScreen_Use",
				OnUsedFunctionName = "UseGameStatsScreenObject",
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeGameStats", },
					},
				},
				SetupEvents =
				{
				},

				SaluteSound = "/SFX/GhostEmotes/DisgruntledTINY",
				SpecialInteractFunctionName = "SpecialInteractSaluteBroker",
				SpecialInteractGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "GameStats" },
					},
				},
				SpecialInteractCooldown = 60,
				InteractVoiceLines =
				{
					[1] =
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.33,
						Cooldowns =
						{
							{ Name = "MelinoeSaluteSpeech", Time = 4 },
						},

						{ Cue = "/VO/Melinoe_3009", Text = "Record-Keeper." },
						{ Cue = "/VO/Melinoe_3010", Text = "Hail, Keeper." },
						{ Cue = "/VO/Melinoe_3011", Text = "Greetings, Record-Keeper." },
					},
					[2] = GlobalVoiceLines.SaluteVoiceLines,
				},

				DistanceTriggers =
				{
					{
						WithinDistance = 600,
						ChanceToPlay = 0.5,
						TriggerOnceThisRun = true,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							AnimationName = "StatusIconSmile",
							OffsetZ = 50,
						},
					},
				}
			},

			-- RunHistoryScreen / Historian / Sage / Security Log
			[589466] =
			{
				Name = "RunHistoryScreen",
				AnimOffsetZ = 150,
				Activate = true,
				SkipDefaultSetup = true, -- Handled by WorldUpgrade
				InteractDistance = 250,

				UseText = "RunHistoryScreen_Use",
				OnUsedFunctionName = "UseRunHistoryScreenObject",
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeRunHistory" },
					},
				},

				SaluteSound = "/SFX/GhostEmotes/DisgruntledTINY",
				SpecialInteractFunctionName = "SpecialInteractSaluteBroker",
				SpecialInteractGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "RunHistory" },
					},
				},
				SpecialInteractCooldown = 60,
				InteractVoiceLines =
				{
					[1] =
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.33,
						Cooldowns =
						{
							{ Name = "MelinoeSaluteSpeech", Time = 4 },
						},

						{ Cue = "/VO/Melinoe_3006", Text = "Greetings, Sage." },
						{ Cue = "/VO/Melinoe_3007", Text = "Hail, O learned Sage." },
						{ Cue = "/VO/Melinoe_3008", Text = "Good evening, Sage." },
					},
					[2] = GlobalVoiceLines.SaluteVoiceLines,
				},

				SetupEvents =
				{
				},
				DistanceTriggers =
				{
					{
						WithinDistance = 600,
						ChanceToPlay = 0.5,
						TriggerOnceThisRun = true,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							AnimationName = "StatusIconEmbarrassed",
							OffsetZ = 50,
						},
					},
				}

			},

			-- Mailbox / Charon Shipments
			[583652] =
			{
				Name = "Mailbox",
				AnimOffsetZ = 180,
				EmoteOffsetZ = 180,
				InteractDistance = 200,
				InteractOffsetX = 0,
				InteractOffsetY = 0,
				UseText = "UseMailbox",
				OnUsedFunctionName = "UseMailboxObject",

				Activate = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "CharonPointsDrop" },
					},
					NamedRequirements = { "MailboxUnlocked" },
				},

				SetupEvents =
				{
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							{
								PathEmpty = { "GameState", "MailboxStatus" },
							},
							{
								Path = { "GameState", "Resources", "CharonPoints", },
								Comparison = ">=",
								Value = 1,
							},
						},
					},
					{
						FunctionName = "SetupMailboxStatus",
						Args =
						{
							
						},
						GameStateRequirements =
						{
							{
								Path = { "GameState", "MailboxStatus" },
								UseLength = true,
								Comparison = ">=",
								Value = 1,
							},
						},
					},
				},

				DistanceTriggers =
				{
					{
						WithinDistance = 750,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ScreensViewed", "MailboxScreen" },
							},
							{
								PathEmpty = { "GameState", "MailboxStatus" },
							},
						},

						VoiceLines =
						{
							PlayOnce = true,
							PlayOnceContext = "MailboxFirstAppearance",
							UsePlayerSource = true,
							TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

							{ Cue = "/VO/Melinoe_2600", Text = "There's something by the Broker...", PlayFirst = true,
								GameStateRequirements =
								{
									AreIdsAlive = { 558096 },
								},
							},
							{
								Cue = "/VO/Melinoe_0827", Text = "Something there.", PlayFirst = true,
								GameStateRequirements =
								{
									AreIdsNotAlive = { 558096 },
								},
							}
						},
					},
					{
						WithinDistance = 625,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "AnyMailboxReady" },
							},
						},

						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							SuccessiveChanceToPlayAll = 0.5,
							GameStateRequirements =
							{
								{
									PathFalse = { "CurrentRun", "UseRecord", "Mailbox" }
								},
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},

							{ Cue = "/VO/Melinoe_2280", Text = "A shipment's arrived." },
							{ Cue = "/VO/Melinoe_2281", Text = "New shipment there.", PlayFirst = true },
							{ Cue = "/VO/Melinoe_2282", Text = "Something for me?", PlayFirst = true },
							{ Cue = "/VO/Melinoe_2283", Text = "Lord Charon always delivers.", PlayFirst = true },
							{ Cue = "/VO/Melinoe_0156", Text = "Another shipment already..." },
						},
					},
				},


			},
			-- Cauldron / Critical Item Store / GhostAdmin
			[558175] =
			{
				Name = "GhostAdmin",
				InteractDistance = 275,
				InteractOffsetX = -28,
				InteractOffsetY = 90,
				AnimOffsetZ = 180,
				UseText = "UseGhostAdmin",
				OnUsedFunctionName = "UseGhostAdmin",
				SetupEvents =
				{
					{
						FunctionName = "SetupCauldronLocked",
						Args =
						{
							UseText = "UseGhostAdmin_Locked",
							UseSound = "/SFX/LavaBubbleBurst",
							OnUsedFunctionName = "UseLockedSystemObjectPresentation",
							OnUsedFunctionArgs = { VoiceLines = "LockedCauldronVoiceLines" },
						},
						GameStateRequirements =
						{
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = "<=",
								Value = 0,
							},
						},
					},
					{
						FunctionName = "SetupCauldronCookStatus",
						Args =
						{
							
						},
						GameStateRequirements =
						{
							{
								Path = { "GameState", "CookStatus", },
								UseLength = true,
								Comparison = ">=",
								Value = 1,
							},
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							NamedRequirements = { "AnyGhostAdminItemAffordable" },
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = ">=",
								Value = 1,
							},
							{
								Path = { "GameState", "CookStatus", },
								UseLength = true,
								Comparison = "<=",
								Value = 0,
							},
						},
					},
					{
						FunctionName = "SetupCauldronWitchcraftPresentation",
						Args =
						{
							LeadParticipantId = 556921,
							OtherParticipantIds = { 575866, 575867, 575859, 575860, },
							CenterPointId = 575850,
						},
						GameStateRequirements =
						{
							ChanceToPlay = 0.5,
							NamedRequirementsFalse = { "AnyGhostAdminItemAffordable" },
							{
								-- No status animation
								PathFromSource = true,
								PathFalse = { "StatusAnimation" },
							},
							{
								-- Not cooking anything
								Path = { "GameState", "CookStatus" },
								UseLength = true,
								Comparison = "<=",
								Value = 0,
							},
							{
								PathFalse = { "CurrentRun", "CauldronWitchcraftOccurred" },
							},
							{
								PathFalse = { "PrevRun", "CauldronWitchcraftOccurred" },
							},
						},
					},
				},
			},

			[558335] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGarden
			},

			[558337] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGarden
			},

			[583643] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGardenT2
			},

			[583642] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGardenT2
			},

			[583640] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGardenT3
			},

			[583641] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGardenT3
			},

			[583644] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGardenTent
			},

			[583645] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGardenTent
			},

			[583649] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGardenTaverna
			},

			[583648] =
			{
				Template = "HubGardenPlot",
				SkipDefaultSetup = true, -- Handled by WorldUpgradeGardenTaverna
			},

			-- DeathArea Cosmetics
			[589542] =
			{
				Name = "TavernaAmbienceGenerator",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				DestroyIfNotSetup = true,
			},

			-- Crossroads Pets (group: HecatePets) / Hound & Polecat / Hecuba & Gale
			[558710] =
			{
				Name = "CrossroadsPet01",
				InteractDistance = 200,
				UseText = "UsePet01",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "HecateFamiliarsInHub" },
				},
				DestroyIfNotSetup = true,
				-- ShakeSelf = true,
				-- OnUsedGlobalVoiceLines = "TakeANapVoiceLines",
				OnUsedFunctionName = "UseCrossroadsPet01",
			},
			[558691] =
			{
				SetupGameStateRequirements =
				{
					NamedRequirements = { "HecateFamiliarsInHub" },
				},
				DestroyIfNotSetup = true,
			},
			[590518] =
			{
				Name = "PetsOnMission",
				DistanceTriggers =
				{
					{
						WithinDistance = 350,
						VoiceLines =
						{
							PlayOnce = true,
							UsePlayerSource = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "UseRecord", "CrossroadsPet01" }
								},
								AreIdsNotAlive = { 558710 },
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},
							{ Cue = "/VO/Melinoe_3409", Text = "The hound and polecat must have gone to scout..." },
						},
					},
				},
			},

			-- QuestLog / Fated List
			[560662] =
			{
				Name = "QuestLog",
				AnimOffsetZ = 150,
				Activate = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog", },
					},
				},
				SetupEvents =
				{
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							InteractDistance = 200,
							UseText = "UseQuestLog",
							UseSound = "/Leftovers/World Sounds/CaravanCreak",
							OnUsedFunctionName = "UseQuestLog",
							Animation = "Crossroads_FatedList_On01",
						},
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeQuestLog", },
							},
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeQuestLog", },
							},
							{
								PathFalse = { "GameState", "ScreensViewed", "QuestLog" },
							},
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeQuestLog", },
							},
							AnyQuestWithStatus = "Complete",
						},
					},
				},
			},

			-- CosmeticsShop
			--[[
			[560614] =
			{
				Name = "CosmeticsShop",
				AnimOffsetZ = 180,
				DefaultCategoryIndex = 2,
				SkipDefaultSetup = true, -- Handled by WorldUpgrade
				InteractDistance = 200,
				UseText = "UseCosmeticsShop",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseCosmeticsShop",
			},
			]]

			-- Eris Passage / Eris Door / Docks Door
			[586746] =
			{
				Name = "DocksDoorInteract",
				ShakeSelf = true,
				InteractDistance = 250,
				-- InteractOffsetX = -10,
				-- InteractOffsetY = 80,
				-- AnimOffsetZ = 180,
				UseText = "CannotUseObject",
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseLockedSystemObjectPresentation",
				OnUsedFunctionArgs = { VoiceLines = "DocksDoorShutVoiceLines", },
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
				},
			},
			-- Eris Guards at Fishing Pier
			[590500] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					AreIdsNotAlive = { 585573 },
				},
			},
			[590499] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					AreIdsNotAlive = { 585573 },
				},
			},

			[589481] =
			{
				Name = "HotSpringsInteract",
				InteractDistance = 250,
				-- InteractOffsetX = -10,
				-- InteractOffsetY = 80,
				-- AnimOffsetZ = 180,
				UseText = "UseHotSprings",
				OnUsedFunctionName = "UseLockedSystemObjectPresentation",
				OnUsedFunctionArgs = { VoiceLines = "TriedToBatheVoiceLines", },
				Activate = true,
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
				},
				SetupEvents =
				{
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							Animation = "Blank",
						},
					}
				},
			},

			-- Hecate torches
			[576153] =
			{
				Name = "HecateTorch1",
				SetupGameStateRequirements =
				{
					AreIdsAlive = { 556921 },
				},
				DestroyIfNotSetup = true,
			},
			[576155] =
			{
				Name = "HecateTorch2",
				SetupGameStateRequirements =
				{
					AreIdsAlive = { 556921 },
				},
				DestroyIfNotSetup = true,
			},

			-- Selene Moonbeam 1 (@temp)
			[560658] =
			{
				Name = "SeleneMoonbeam",
				SetupGameStateRequirements =
				{
					RequiredAnyQueuedTextLines = {
						"SeleneHome01",
					},
				},
				DestroyIfNotSetup = true,
			},
			-- Selene Moonbeam 2 (@temp)
			[560659] =
			{
				Name = "SeleneMoonbeam2",
				SetupGameStateRequirements =
				{
					RequiredAnyQueuedTextLines = {
						"SeleneWithHecate01",
					},
				},
				DestroyIfNotSetup = true,
			},

			-- Exit to Hub_PreRun (from Hub_Main)
			[391697] =
			{
				Name = "PreRunExit",
				OnUsedGameStateRequirements =
				{
				},
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				-- OnUsedFunctionArgs = { Name = "DeathAreaBedroom", HeroStartPoint = 40009, HeroEndPoint = 40012, },
				OnUsedFunctionArgs = { Name = "Hub_PreRun", HeroStartPoint = 40009, HeroEndPoint = 40012, },

				InteractDistance = 320,
				InteractOffsetX = 45,
				InteractOffsetY = 135,
				AutoActivate = true,
			},

			[585709] =
			{
				Name = "MainDocks01",
				DistanceTriggers =
				{
					{
						WithinDistance = 180,
						VoiceLines =
						{
							BreakIfPlayed = true,
							UsePlayerSource = true,
							PreLineWait = 0.5,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "CompletedRunsCache" },
									Comparison = "<=",
									Value = 5,
								},
								{
									PathFalse = { "CurrentRun", "Cleared" },
								},
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},

							-- { Cue = "/VO/Melinoe_2951", Text = "It's calmed here since last night..." },
							{ Cue = "/VO/Melinoe_3566", Text = "{#Emph}<Sigh> {#Prev}OK...",
								PlayOnce = true,
								PlayOnceContext = "DocksSighVO",
								GameStateRequirements =
								{
									NamedRequirementsFalse = { "MailboxUnlocked" },
								},
							},
							{ Cue = "/VO/Melinoe_0028", Text = "I'm just procrastinating at this point.",
								PlayOnce = true,
								GameStateRequirements =
								{
									{
										Path = { "PreviousDeathAreaRoom", "Name" },
										IsAny = { "Hub_PreRun" },
									},
									{
										Path = { "CurrentRun", "UseRecord" },
										HasAll = { "NPC_Dora_01", "NPC_Hecate_01", "NPC_Odysseus_01", "NPC_Nemesis_01" },
									},
								},
							},
						},
					},
				},

			},

			-- Tree of Life
			[567567] =
			{
				Name = "TreeOfLife01",
				DistanceTriggers =
				{
					{
						WithinDistance = 1250,
						VoiceLines =
						{
							BreakIfPlayed = true,
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "TextLinesRecord", "HecateHideAndSeek03" },
								},
								AreIdsNotAlive = { 556921 },
							},

							{ Cue = "/VO/Melinoe_1727", Text = "Where are you, Headmistress..." },
						},
					},
				},
			},

			-- Ghosts / Shades
			-- bartender shade
			[590506] =
			{
				Name = "BartenderShade01",
				SetupGameStateRequirements =
				{
					--
				},
				DestroyIfNotSetup = true,
				-- UseSound = "/Leftovers/World Sounds/CaravanCreak",
				-- ShakeSelf = true,
				InteractDistance = 200,

				UseTextSpecial = "SpecialInteractShade",
				SaluteSound = "/SFX/GhostEmotes/EmbarrassedTINY",
				SpecialInteractFunctionName = "SpecialInteractSaluteBroker",
				SpecialInteractGameStateRequirements =
				{
					{
					},
				},
				SpecialInteractCooldown = 60,
				InteractVoiceLines =
				{
					[1] =
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.33,
						Cooldowns =
						{
							{ Name = "MelinoeSaluteSpeech", Time = 4 },
						},
						{ Cue = "/VO/Melinoe_3003", Text = "Hail, Spirit-Mixer.", PlayFirst = true },
						{ Cue = "/VO/Melinoe_3004", Text = "Cheers, Mixer." },
						{ Cue = "/VO/Melinoe_3005", Text = "Good evening, Mixer." },
					},
					[2] = GlobalVoiceLines.SaluteVoiceLines,
				},

				DistanceTriggers =
				{
					{
						WithinDistance = 500,
						ChanceToPlay = 0.75,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							TargetId = 561538,
							OffsetZ = 60,
							AnimationName = "StatusIconSmile",
						},

					},
				},
			},

			--[[ currently removed
			[561535] =
			{
				Name = "TavernaShade01",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				DestroyIfNotSetup = true,
				SpecialInteractFunctionName = "SpecialInteractShade",
				UseTextSpecial = "SpecialInteractShade",
				-- UseSound = "/Leftovers/World Sounds/CaravanCreak",
				-- ShakeSelf = true,
				InteractDistance = 150,

				DistanceTriggers =
				{
					{
						WithinDistance = 280,
						ChanceToPlay = 0.15,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							OffsetZ = 60,
							TargetId = 561535,
							AnimationName = "StatusIconSmile",
						},
					},
				},
			},

			[561526] =
			{
				Name = "TavernaShade07",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				DestroyIfNotSetup = true,
				SpecialInteractFunctionName = "SpecialInteractShade",
				UseTextSpecial = "SpecialInteractShade",
				-- UseSound = "/Leftovers/World Sounds/CaravanCreak",
				-- ShakeSelf = true,
				InteractDistance = 150,

				DistanceTriggers =
				{
					{
						WithinDistance = 280,
						ChanceToPlay = 0.15,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							OffsetZ = 60,
							TargetId = 561526,
							AnimationName = "StatusIconSmile",
						},
					},
				},
			},
			]]--

		},
	},

	-- Training Grounds
	Hub_PreRun =
	{
		InheritFrom = { "BaseHub", },
		SkipLastKillPresentation = true,
		CheckWeaponHistory = true,
		UseBiomeMap = true,
		BiomeMapArea = "Home",
		RichPresence = "#RichPresence_RoomPreRun",
		ZoomFraction = 0.95,
		EntranceFunctionName = "EnterHubRoomPresentation",
		NarrativeContextArt = "DialogueBackgroundBiome_Woods",
		NarrativeContextArtFlippable = true,
		IgnoreStemMixer = true,
		Ambience = "/Ambience/RunstartIntroAmbience",
		KeepsakeFreeSwap = true,
		ShowShrinePoints = true,
		AllowAssistFailedPresentation = true,
		IntroSequenceDuration = 0.80,
		AllowEnemyAIActive = true,
		ShadeMercAITarget = "NPC_Skelly_01",
		SpeakerName = "Skelly",
		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,
		CameraZoomWeights =
		{
			--[420907] = 1.0,
			[420907] = 0.75,
			[420906] = 0.75,
			[567330] = 1.1,
		},
		SoftClamp = 0.75,

		AllowWeapons = true,

		AmbientMusicParams =
		{
			LowPass = 1.0,
			Vocals = 0.0,
		},
		AmbientMusicVolume = 0.0,

		StartUnthreadedEvents =
		{
			{
				FunctionName = "AssignWeaponKits",
				Args =
				{
				},
			},
			{
				FunctionName = "AssignToolKits",
				Args =
				{
				},
			},
			{
				FunctionName = "AssignFamiliarKits",
				Args =
				{
					OverwriteSelf =
					{
						TargetSearchDistance = 3000,
					},
				},
			},
			{
				FunctionName = "UpdateShrineRunDoorArrow",
				Args =
				{
					SkipPresentation = true
				},
			},
			-- spawn skelly
			-- always present until multiple weapons are unlocked
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasNone = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob" },
					},
				},
				Args =
				{
					LegalTypes =
					{
						"NPC_Skelly_01",
					},
					SkipPresentation = true,
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob" },
					},
					ChanceToPlay = 0.75,
				},
				Args =
				{
					LegalTypes =
					{
						"NPC_Skelly_01",
					},
					SkipPresentation = true,
				},
			},
			{
				FunctionName = "CheckPriorityConversations",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SkipPresentation = true,
					-- Skelly key events
					Conversations =
					{
						"SkellyAboutTrophyQuest01",
						"TrophyQuestComplete01",
						"TrophyQuestComplete02",
						"TrophyQuestComplete03",
						"SkellyAboutTrophyQuest02",
						"SkellyFirstMeeting",
						"SkellyAboutSurface01",
						"SkellyAboutGodMode01",
						"SkellyAboutShrine01",
						"SkellyAboutCerberus01",
						"SkellyAboutChronosBossW01",
						"SkellyAboutAspects01",
						"SkellyAboutCharon01",
						"SkellyAboutGodMode01",
					},
				},
			},
			{
				FunctionName = "GhostRecruitsPreRun",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SpawnChance = 0.25,
					MaxSpawns = 2,
					SpawnPointIds = { 585601, 585600, 585599, 585598, 585602, 585603, },
					TargetId = 420928,
				},
			},
			-- dora always present [after Cosmetics unlocked]
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					NamedRequirements = { "CosmeticsShopUnlocked" },
				},
				Args =
				{
					Types =
					{
						"NPC_Dora_01",
					},
					OverwriteSelf =
					{
						DefaultCategoryIndex = 3,
					},
				},
			},
			{
				FunctionName = "ActivateConditionalItems",
				Args =
				{
					CosmeticsShopCategoryIndex = 3,
				},
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
			{
				FunctionName = "EquipLastAwardTrait",
				Args = {},
			},
			{
				FunctionName = "EquipLastAssistTrait",
				Args = {},
			},
			{
				FunctionName = "EquipLastWeaponUpgrade",
				Args =
				{
					SkipTraitHighlight = true,
				},
			},
			{
				FunctionName = "EquipPreRunMetaUpgrades",
				Args = {},
			},
			
			{
				FunctionName = "CheckWeaponRoomStartEvents",
			},
			{
				FunctionName = "PreGenerateNextBiomeState",
				Args = {},
			},
		},

		ThreadedEvents =
		{
			{
				FunctionName = "ShadeMercManager",
				GameStateRequirements =
				{
					ChanceToPlay = 1.0
				},
				Args =
				{
					StartingCountMin = 99,
					StartingCountMax = 99,
					ObjectNames = { "ShadeMerc" },
					MaxActive = 99,
					RequireForExit = false,
					RestoreObjectState = true,
				},
			},
			{
				FunctionName = "HandleWeaponAspectsRevealObjective",
			},
			{
				FunctionName = "TrophyQuestUnlockedFirstPresentation",
				Args = {},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/Skelly_0300" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					NamedRequirements = { "TrophyQuestUnlocked" },
				},
			},
			{
				FunctionName = "ShrineUnlockedFirstPresentation",
				Args = {},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/Melinoe_2855" },
					},
					{
						PathFalse = { "GameState", "ScreensViewed", "Shrine" },
					},
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = { "/VO/Skelly_0300" },
					},
					NamedRequirements = { "ShrineUnlocked" },
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
				},
			},
			{
				FunctionName = "AltRunDoorUnlockedFirstPresentation",
				Args = {},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/Melinoe_0852" },
					},
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = { "/VO/Melinoe_2855", "/VO/Skelly_0300" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "N_Opening01" },
					},
					NamedRequirementsFalse = { "ShrineUnlocked" },
				},
			},
			{
				FunctionName = "BountyBoardUnlockedFirstPresentation",
				Args = {},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/Skelly_0087" },
					},
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = { "/VO/Melinoe_2855", "/VO/Skelly_0300", "/VO/Melinoe_0852" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathFalse = { "GameState", "ScreensViewed", "BountyBoard" },
					},
				},
			},

		},

		ObstacleData =
		{
			-- Altar of Ashes / Card Table / MetaUpgradeWorldObject
			[589766] =
			{
				InteractDistance = 250,
				UseText = "UseMetaUpgradeWorldObject",
				UseSound = "/Leftovers/Menu Sounds/TitanToggleLong",
				OnUsedFunctionName = "OpenMetaUpgradeCardScreen",
				AnimOffsetZ = 120,
				SetupEvents =
				{
					{
						FunctionName = "GenericPresentation",
						Args =
						{
							FadeOutIds = { 588748, },
							Duration = 0,
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							AnyAffordableMetaUpgradeItems = true,
						},
					},
				},
			},

			-- Weapon Shop / Silver Pool
			[558210] =
			{

				Name = "WeaponShop",
				InteractDistance = 275,
				InteractOffsetX = 50,
				AnimOffsetZ = 150,
				AnimOffsetX = 50,
				UseText = "UseWeaponShop",
				OnUsedFunctionName = "UseWeaponShop",
				OnUsedGameStateRequirements =
				{
					--[[
					{
						Path = { "GameState", "UseRecord", "NPC_Hecate_01", },
						Comparison = ">=",
						Value = 1,
					},
					]]--
				},
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 0,
					},
				},
				DestroyIfNotSetup = true,
				SetupEvents =
				{
					-- Aspects System
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							Animation = "WeaponShopWorldObject02",
						},
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
							},
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							AnyAffordableItemInScreen = "WeaponShop",
							AnyAffordableItemDataStore = "WeaponShopItemData",
						},
					},
				},
				DistanceTriggers =
				{
					{
						WithinDistance = 500,
						VoiceLines =
						{
							-- Hint: Arcana Altar
							{
								UsePlayerSource = true,
								PlayOnceThisRun = true,
								SuccessiveChanceToPlay = 0.15,
								GameStateRequirements =
								{
									{
										PathFalse = { "CurrentRun", "ScreenViewRecord", "MetaUpgradeCardLayout" },
									},
									{
										Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
										HasNone = { "/VO/Melinoe_0538" },
									},
									{
										Path = { "GameState", "LifetimeResourcesSpent", "MetaCardPointsCommon" },
										Comparison = "<",
										Value = 80,
									},
									AnyAffordableMetaUpgradeItems = true,
								},
								{ Cue = "/VO/Melinoe_1610", Text = "Mustn't forget my Altar back there...",	},
							},
							-- Observation: Upgraded Silver Pool
							{
								PlayOnce = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
									},
								},
								{ Cue = "/VO/Melinoe_2540", Text = "The Silver Pool reacted to my spell..." },
							},
						},
					},
				},
			},

			-- Gift Rack / Keepsake Rack
			[421320] =
			{
				Template = "GiftRack",
				ActivateIds = { 421320, 421315, 421317, 421316, 421319 },
				InteractDistance = 205,
				InteractOffsetX = 30,
				InteractOffsetY = -65,
				AnimOffsetZ = 250,
				SetupGameStateRequirements =
				{
					-- GiftRack is always present, but initially locked
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 0,
					},
				},
				SetupEvents =
				{
					{
						FunctionName = "SetupLockedGiftRack",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "LifetimeResourcesGained", "GiftPoints" },
								Comparison = "<",
								Value = 1,
							},
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							{
								Path = { "GameState", "GiftPresentation", },
								UseLength = true,
								Comparison = ">=",
								Value = 1,
							},
							{
								PathFalse = { "GameState", "LastAwardTrait", },
							},
						},
					},
				},
			},

			-- BountyBoard / Bounty Board / Pitch-Black Stone
			[561146] =
			{
				Name = "BountyBoard",
				InteractDistance = 200,
				AnimOffsetZ = 200,
				
				SetupGameStateRequirements =
				{
					-- Always present, but initially locked
				},
				SetupEvents =
				{
					{
						FunctionName = "GenericPresentation",
						Args =
						{
							UseableOff = true,
						},
						GameStateRequirements =
						{
							{
								Path = { "GameState", "WorldUpgradesAdded", },
								HasNone = { "WorldUpgradeBountyBoard" },
							},
						},
					},
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							UseText = "UseBountyBoard",
							UseSound = "/Leftovers/World Sounds/Caravan Interior/FloatingRockInteract",
							OnUsedFunctionName = "UseBountyBoard",
							Animation = "Crossroads_BountyBoard_On01",
						},
						GameStateRequirements =
						{
							{
								Path = { "GameState", "WorldUpgradesAdded", },
								HasAll = { "WorldUpgradeBountyBoard" },
							},
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							{
								Path = { "GameState", "WorldUpgradesAdded", },
								HasAll = { "WorldUpgradeBountyBoard", },
							},
							{
								PathFalse = { "GameState", "ScreensViewed", "BountyBoard" },
							},
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ScreensViewed", "BountyBoard" },
							},
							{
								FunctionName = "HasUnviewedBounty",
							},
						},
					},
				},
			},
			-- BountyBoard moon beam
			[587430] =
			{
				Name = "BountyBoardMoonBeam",
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "WorldUpgradesAdded", },
						HasAll = { "WorldUpgradeBountyBoard" },
					},
				},
			},
			-- Shrine / Oath of the Unseen / Pact / Pact of Punishment (Note: Shadow decal below)
			[589694] =
			{
				Name = "Shrine",
				InteractDistance = 200,
				AnimOffsetZ = 200,
				UseText = "UseShrineObject",
				UseSound = "/SFX/HeatCollectionPickup",
				OnUsedFunctionName = "UseShrineObject",
				SetupGameStateRequirements =
				{
					NamedRequirements =  { "ShrineUnlocked" },
				},
				DestroyIfNotSetup = true,
				SetupEvents =
				{
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							NamedRequirements =  { "ShrineUnlocked" },
							{
								PathFalse = { "GameState", "ScreensViewed", "Shrine" },
							},
						},
					},
					{
						FunctionName = "ActivatePrePlacedObstacles",
						Args =
						{
							Groups = { "ShrineDecor", },
						},
					},
				},

			},

			-- benches
			[587351] =
			{
				InteractDistance = 110,
				UseText = "UseChair",
				ShakeSelf = true,
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseLockedSystemObjectPresentation",
				OnUsedFunctionArgs = { VoiceLines = "TriedToSitVoiceLines", SkipAnim = true, BlockAngleTowardTarget = true, LinkedIds = { 587424 } },
			},
			[587424] =
			{
				InteractDistance = 110,
				UseText = "UseChair",
				ShakeSelf = true,
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseLockedSystemObjectPresentation",
				OnUsedFunctionArgs = { VoiceLines = "TriedToSitVoiceLines", SkipAnim = true, BlockAngleTowardTarget = true, LinkedIds = { 587351 } },
			},

			-- SkellyStatue 1
			[589801] =
			{
				Activate = true,
				SetupGameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestUnlocked" }
				},
				SetupEvents =
				{
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							UseText = "UseLockedSkellyStatue",
							InteractDistance = 300,
							OnUsedFunctionName = "SkellyStatueAdmire",
						},
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
							},
						},
					},
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							UseText = "UseSkellyStatue",
							InteractDistance = 300,
							OnUsedFunctionName = "SkellyStatueAdmire",
						},
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" },
							},
						},
					},
					{
						Threaded = true,
						FunctionName = "GenericPresentation",
						Args =
						{
							SetAlpha = 0.0,
							Duration = 0.0,
							Id = 589805,
							PreWait = 0.02,
						},
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete01" }
							},
						},
					},
				},
				ExclusiveOnHitFunctionName = "StatueHitPresentation",
				ExclusiveOnHitFunctionArgs =
				{
					DrapeId = 589805,
				},
			},

			-- SkellyStatue 2
			[589804] =
			{
				Activate = true,
				SetupGameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestUnlocked" }
				},
				SetupEvents =
				{
					{
						Threaded = true,
						FunctionName = "GenericPresentation",
						Args =
						{
							SetAlpha = 0.0,
							Duration = 0.0,
							Id = 589806,
							PreWait = 0.02,
						},
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete02" }
							}
						},
					},
				},
				ExclusiveOnHitFunctionName = "StatueHitPresentation",
				ExclusiveOnHitFunctionArgs =
				{
					DrapeId = 589806,
				},
			},

			-- SkellyStatue 3
			[589803] =
			{
				Activate = true,
				SetupGameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestUnlocked" }
				},
				SetupEvents =
				{
					{
						Threaded = true,
						FunctionName = "GenericPresentation",
						Args =
						{
							SetAlpha = 0.0,
							Duration = 0.0,
							Id = 589807,
							PreWait = 0.02,
						},
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
							}
						},
					},
				},
				ExclusiveOnHitFunctionName = "StatueHitPresentation",
				ExclusiveOnHitFunctionArgs =
				{
					DrapeId = 589807,
				},
			},

			-- Supportive Shade -- Diehard Fan
			[555807] =
			{
				Name = "DieHardFanShade",
				EmoteOffsetZ = 10,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "DieHardFanShade" },
					},
				},
				DestroyIfNotSetup = true,

				SpecialInteractFunctionName = "SpecialInteractShade",
				UseTextSpecial = "SpecialInteractShade",

				-- UseSound = "/Leftovers/World Sounds/CaravanCreak",
				-- ShakeSelf = true,
				InteractDistance = 125,
				DistanceTriggers =
				{
					{
						WithinDistance = 1300,
						ChanceToPlay = 0.25,
						TriggerOnceThisRun = true,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							TargetId = 555807,
							AnimationName = "StatusIconGrief",
						},
					},
					--[[
					{
						WithinDistance = 100,
						ChanceToPlay = 0.25,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							PreLineThreadedFunctionName = "PlayEmoteSimple",
							PreLineThreadedFunctionArgs =
							{
								TargetId = 555807,
								Delay = 2.1,
								AnimationName = "StatusIconSmile",
							},

							-- { Cue = "/VO/Melinoe_0342", Text = "Shades of the Crossroads, greetings." },
							-- { Cue = "/VO/Melinoe_0344", Text = "Hail, Shades!" },
							-- { Cue = "/VO/Melinoe_0346", Text = "Stay strong, my friends.", PlayFirst = true },
						},
					},
					]]--
				},
			},

			-- Run Start Door / New Run Door / NewRunDoor
			-- Underworld Run
			[420947] =
			{
				UseText = "UseStartRunDoor1",
				InteractDistance = 350,
				InteractOffsetX = -100,
				InteractOffsetY = 170,
				OnUsedFunctionName = "UseEscapeDoor",
				OnUsedFunctionArgs = { StartingBiome = "F", DashTarget = 588632 },
				SetupEvents =
				{
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							UseText = "TechTestEscapeDoorClosed",
							OnUsedFunctionName = "TechTestEscapeDoorClosed",
							Animation = "DoorExitLightLocked",
						},
						GameStateRequirements =
						{
							{
								PathTrue = { "ConfigOptionCache", "DemoMode" },
							},
							{
								Path = { "GameState", "ClearedRunsCache" },
								Comparison = ">=",
								Value = 5,
							},
						},
					},
				},
			},
			-- Surface Run / Olympus Run / Olympus Route / Olympus Door
			-- locked
			[558268] =
			{
				DestroyIfNotSetup = true,
				UseText = "UseLockedSurfaceRunDoor",
				InteractDistance = 250,
				InteractOffsetX = -75,
				InteractOffsetY = 80,
				OnUsedFunctionName = "LockedSurfaceRunPresentation",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgrades", "WorldUpgradeAltRunDoor" },
					},
				},
			},
			-- unlocked
			[555784] =
			{
				UseText = "UseStartRunDoor2",
				OnUsedFunctionName = "UseEscapeDoor",
				OnUsedFunctionArgs = { StartingBiome = "N", MarkObjectiveComplete = "UseSurfaceDoor", DashTarget = 588633, GlobalVoiceLines = "StartSurfaceRunVoiceLines"  },
				DestroyIfNotSetup = true,
				ActivateIds = { 555787 },
				InteractDistance = 250,
				InteractOffsetX = -75,
				InteractOffsetY = 100,				
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeAltRunDoor" },
					},
				},

			},

			-- Exit to Hub_Main (from Hub_PreRun)
			[421119] =
			{
				SetupGameStateRequirements =
				{
					RequiredFalseConfigOptions = { "KioskMode" },
				},
				DestroyIfNotSetup = true,

				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs =
				{
					Name = "Hub_Main", HeroStartPoint = 390004, HeroEndPoint = 390002,
					PreLoadFunctionName = "UnequipMetaUpgrades",
				},

				InteractDistance = 420,
				InteractOffsetX = -205,
				InteractOffsetY = -165,
				AutoActivate = true,
				OnUsedVoiceLines =
				{
					--
				},
			},
		},


		EnterVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestStage1CheckA" }
				},
				{ Cue = "/VO/Melinoe_3293", Text = "Halfway to Night's Gift..." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestStage1CheckB" }
				},
				{ Cue = "/VO/Melinoe_3293", Text = "Halfway to Night's Gift..." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestStage2CheckA" }
				},
				{ Cue = "/VO/Melinoe_3294", Text = "I'm part of the way there." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestStage2CheckB" }
				},
				{ Cue = "/VO/Melinoe_3294", Text = "I'm part of the way there." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestStage3CheckA" }
				},
				{ Cue = "/VO/Melinoe_3295", Text = "Night's Gift awaits..." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.2,
				GameStateRequirements =
				{
					NamedRequirements = { "TrophyQuestStage3CheckB" }
				},
				{ Cue = "/VO/Melinoe_3295", Text = "Night's Gift awaits..." },
			},

		},

		OverlookData =
		{	
			StartDelay = 0,
			CameraClamps = { 566438, 566437, },
			HeroBeamPoint = 566434,
			CameraStartId = 566439,
			ReturnPositionId = 566434,
			SkipReturnSound = true,

			CameraSlideFromHeroPosition = true, -- determines if this is an 'offset' pan from the hero unit
			CameraSpeed = 1260, -- speed of camera pan
			CameraStartPanDuration = 4.0, -- only used if there is no speed defined
			CameraStartPanRelocateDuration = 1.34, -- approximate time before camera is out of the default isometric scene

			CameraEndStartDelay = 0,
			CameraRelocateStartId = 566439, -- bottom -> up
			CameraRelocateEndId = 566441, -- bottom -> up
			--CameraRelocateStartId = 567320, -- top -> down
			--CameraRelocateEndId = 567321, -- top -> down
			CameraRelocatePanDuration = 3.1,
			CameraRelocatePanOffsetY = -1990,
			CameraRelocateExtendedPanDuration = 18.0,
			CameraEndStartDelay = 0.9,
			
			ZoomFraction = 1.0,
			EndZoomFraction = 1.0,

			FlourishId = 566440,
			FlourishAnimation = "MelinoeCauldronIncantationComplete",

			FadeIdsOnEnd = { 561140, 567205, 566435, 588617 },
			-- FlourishSound = "/VO/Melinoe_0339",
			
			--[[ push pan test
			StartDelay = 0,
			CameraClamps = { 566438, 566437, },
			CameraStartId = 566439,
			ReturnPositionId = 566434,

			CameraStartPanId = 566436,
			
			CameraPushInitialDuration = 0.5,
			CameraPushDuration = 2.0,
			CameraPushTotalDuration = 1.28,
			CameraPushId = 567327,

			CameraPushStartAIds = { 567322 },
			CameraPushStartBIds = { 567323 },

			CameraPushRelocateStartId = 567328,
			CameraPushRelocateEndId = 567329,
			CameraPushRelocateStartZoomFraction = 0.45,
			CameraPushRelocateEndZoomFraction = 0.6,
			CameraPushRelocateDuration = 18,

			CameraPushHiderAIds = { 567325, 567332, 567331 },
			CameraPushHiderBIds = { 567326, 567333, 567334 },
			]]

		},

		DistanceTriggers =
		{
			--[[ Overlook
			{
				TriggerGroup = "OverlookOut", WithinDistance = 300, FunctionName = "PreRunOverlook", Repeat = true,
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "PreRunBackToRoom", Repeat = true,
			},
			{
				TriggerGroup = "OverlookIn", WithinDistance = 150, FunctionName = "EndOverlookAdvanced", Repeat = true,
			},]]
			{
				TriggerGroup = "OverlookOut", WithinDistance = 75, FunctionName = "OverlookAdvanced", Repeat = true,
			},
			{
				TriggerGroup = "AltarIn", WithinDistance = 150, FunctionName = "AltarEnterPresentation", Repeat = true,
			},
			{
				TriggerGroup = "AltarOut", WithinDistance = 150, FunctionName = "AltarExitPresentation", Repeat = true,
			},

			-- Altar of Ashes / Card Table
			{
				TriggerObjectType = "CrossroadsCardAltarTerrain01",
				WithinDistance = 350,
				VoiceLines =
				{
					Queue = "Always",
					{
						PlayOnce = true,
						PlayOnceContext = "SeenMetaUpgradeWorldObject",
						GameStateRequirements = 
						{
							{
								PathFalse = { "GameState", "ScreensViewed", "MetaUpgradeCardLayout" },
							},
						},

						{ Cue = "/VO/Melinoe_0538", Text = "My Altar..." },
					},
					{
						PlayOnce = true,
						GameStateRequirements = 
						{
							{
								PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeCardUpgradeSystem", },
							},
							{
								PathFalse = { "GameState", "ScreensViewed", "MetaUpgradeCardUpgradeLayout" },
							},
						},

						{ Cue = "/VO/Melinoe_2716", Text = "My Altar's all charged up..." },
					}
				},
			},

			-- NewRunDoor / Exit Door
			{
				-- @ Hacky objecttype to be replaced with a group
				TriggerObjectType = "ErebusWitchTotem01",
				WithinDistance = 650,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeAltRunDoor", },
					},
				},

				VoiceLines =
				{
					Queue = "Always",
					{
						PlayOnce = true,
						PlayOnceContext = "SurfaceDoorUnlocked",

						{ Cue = "/VO/Melinoe_0563", Text = "I can get through..." },
					},
				},
			},
			{
				TriggerObjectType = "NPC_Skelly_01", WithinDistance = 500,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "SkellyFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
				},
				FunctionName = "StartSkellyWeaponTutorial",
			},
			-- Skelly
			{
				TriggerObjectType = "NPC_Skelly_01", WithinDistance = 775,
				PostTriggerAnimation = "Skelly_Greeting",
				TriggerOnceThisRun = true,
				VoiceLines =
				{
					{
						-- PlayOnce = true,
						BreakIfPlayed = true,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines = {
								"SkellyAboutSurface01",
								"SkellyAboutCharon02",
								"SkellyAboutTrophyQuest01",
							},
						},
						Cooldowns =
						{
							{ Name = "SkellyWelcomeSpeech", Time = 10 },
						},

						{ Cue = "/VO/Skelly_0042", Text = "May we converse?" },
					},
					{
						BreakIfPlayed = true,
						PlayOnce = true,
						PreLineAnim = "Skelly_Babbling",
						ObjectType = "NPC_Skelly_01",
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "ScreensViewed", "Shrine" },
							},
							NamedRequirements =  { "ShrineUnlocked" },
						},
						{ Cue = "/VO/Skelly_0230", Text = "See anything that wasn't here before, young one?" },
					},
					{
						BreakIfPlayed = true,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Babbling",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = "==",
								Value = 0,
							},
						},
						{ Cue = "/VO/Skelly_0228", Text = "Disciples, atten{#Emph}tion! {#Prev}Allay your fears; she has {#Emph}returned!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.33 },
						},
					},
					-- Trophy Quest
					{
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines = {
								"TrophyQuestComplete03",
							},
						},
						{
							PlayOnce = true,
							PreLineAnim = "Skelly_Babbling",
							ObjectType = "NPC_Skelly_01",
							{ Cue = "/VO/Skelly_0318", Text = "Wait, what, she {#Emph}did?! {#Prev}But, how in the — OK, she's here, shut {#Emph}up!" },
						},
						{
							PlayOnce = true,
							UsePlayerSource = true,
							BreakIfPlayed = true,
							PreLineWait = 0.4,

							{ Cue = "/VO/Melinoe_3283", Text = "Am I officially Night's Champion...?" },
						},
					},
					{
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines = {
								"TrophyQuestComplete02",
							},
						},
						{
							PlayOnce = true,
							PreLineAnim = "Skelly_Explaining",
							ObjectType = "NPC_Skelly_01",

							{ Cue = "/VO/Skelly_0313", Text = "{#Emph}Huzzah! {#Prev}Another glorious victory, another well-earned Gift!" },
						},
						{
							PlayOnce = true,
							UsePlayerSource = true,
							BreakIfPlayed = true,
							PreLineWait = 0.4,

							{ Cue = "/VO/Melinoe_3278", Text = "Night's second Gift awaits..." },
						},
					},
					{
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines = {
								"TrophyQuestComplete01",
							},
						},
						{
							PlayOnce = true,
							ObjectType = "NPC_Skelly_01",
							PreLineAnim = "Skelly_Explaining",

							{ Cue = "/VO/Skelly_0308", Text = "Your prize awaits, and glory is yours! A third of it anyway." },
						},
					},
					{
						{
							PlayOnce = true,
							PlayOnceContext = "SkellyAboutTrophy2VO",
							ObjectType = "NPC_Skelly_01",
							PreLineAnim = "Skelly_Babbling",
							GameStateRequirements =
							{
								RequiredAnyQueuedTextLines = {
									"SkellyAboutTrophyQuest02",
								},
							},
							{ Cue = "/VO/Skelly_0301", Text = "The time to prove yourself has finally come!" },
						},
					},
					{
						{
							PlayOnce = true,
							PlayOnceContext = "SkellyAboutTrophy3VO",
							ObjectType = "NPC_Skelly_01",
							PreLineAnim = "Skelly_Explaining",
							GameStateRequirements =
							{
								RequiredAnyQueuedTextLines = {
									"SkellyAboutTrophyQuest03",
								},
							},
							{ Cue = "/VO/Skelly_0302", Text = "If you would honor me with a quick chat?" },
						},
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.25,
						ObjectType = "NPC_Skelly_01",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "ExorcismSuccesses" },
								Comparison = ">=",
								Value = 1,
							},
							{
								Path = { "CurrentRun", "ExorcisedNames" },
								HasAny = { "ExorcismPointGhost" },
							},
						},

						{ Cue = "/VO/Skelly_0223", Text = "I see we got some new faces today, fresh out of Erebus!",
							PlayFirst = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "BiomesReaced", "F" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0224", Text = "To all of you just joining up, welcome!" },
						{ Cue = "/VO/Skelly_0225", Text = "The Tablet of Peace showed you how to get here; but I shall show you the way.",
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "ExorcismSuccessesManual" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0292", Text = "Our numbers grow, and thusly does our strength!" },
						{ Cue = "/VO/Skelly_0293", Text = "We bid you welcome to the vanguard of the Underworld!" },
						{ Cue = "/VO/Skelly_0294", Text = "Somebody fresh from Oceanus joins our ranks!",
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "BiomesReaced", "G" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0295", Text = "No use crying in the Mourning Fields when you can join us here!",
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "BiomesReaced", "H" },
								},
							},
						},
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.65,
						PreLineAnim = "Skelly_Babbling",
						ObjectType = "NPC_Skelly_01",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0087" },
							},
						},

						{ Cue = "/VO/Skelly_0024", Text = "...and that, my disciples, is the true meaning of life. Remember it well!" ,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
									Comparison = ">=",
									Value = 4,
								},
							}
						 },
						{ Cue = "/VO/Skelly_0025", Text = "...and then I say... h-hold up, somebody's here." ,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
									Comparison = ">=",
									Value = 6,
								},
							}
						 },
						{ Cue = "/VO/Skelly_0037", Text = "...She's here, come on you slackers, straighten up!" },
						{ Cue = "/VO/Skelly_0038", Text = "...Ah, there she is again at last.", PlayFirst = true },
						{ Cue = "/VO/Skelly_0039", Text = "...and that concludes our lesson for today. At ease." },
						{ Cue = "/VO/Skelly_0040", Text = "...and another thing... {#Emph}um{#Prev}, stand up straight!" },
						{ Cue = "/VO/Skelly_0041", Text = "Everybody at attention!" },
						{ Cue = "/VO/Skelly_0104", Text = "...and what are we to do? Merely stand by, and let the Titan have his way?!" },
						{ Cue = "/VO/Skelly_0105", Text = "...but that, disciples, is a tale for another circumstance." },
						{ Cue = "/VO/Skelly_0107", Text = "We bid you welcome to our training grounds!" },
						{ Cue = "/VO/Skelly_0108", Text = "Another step on the path to perfection!" },
						{ Cue = "/VO/Skelly_0165", Text = "She's here, now watch and learn!", PlayFirst = true },
						{ Cue = "/VO/Skelly_0296", Text = "Always she returns, as dusk gives way to night!" },
						{ Cue = "/VO/Skelly_0297", Text = "Atten{#Emph}tion! {#Prev}Got a Silver Sister on deck!" },
						{ Cue = "/VO/Skelly_0298", Text = "Hold, everybody, Silver Sister on deck!" },
						{ Cue = "/VO/Skelly_0299", Text = "...Keep practicing, as though you still had lives that depended on it!" },
						{ Cue = "/VO/Skelly_0005", Text = "Ah, I know the sound of that gait. Come here where these old eyes can see ya." },
						{ Cue = "/VO/Skelly_0228", Text = "Disciples, atten{#Emph}tion! {#Prev}Allay your fears; she has {#Emph}returned!",
							GameStateRequirements =
							{
								{
									Path = { "GameState", "CompletedRunsCache" },
									Comparison = ">=",
									Value = 20,
								},
							},
						},
					},
					{
						PreLineWait = 0.6,
						UsePlayerSource = true,
						SuccessiveChanceToPlay = 0.25,
						PlayOnceFromTableThisRun = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentHubRoom", "Name" },
								IsAny = { "Hub_PreRun"},
							},
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = ">=",
								Value = 1,
							},
							{
								Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
								HasNone = { "/VO/Skelly_0042", "/VO/Skelly_0087", "/VO/Skelly_0082" },
							},
						},
						Cooldowns =
						{
							{ Name = "MelinoeMiscHouseSpeech", Time = 10 },
						},

						{ Cue = "/VO/Melinoe_0071", Text = "Commander." },
					},
					{
						PreLineWait = 0.4,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.75,
						ObjectType = "NPC_Skelly_01",
						GameStateRequirements =
						{
							{
								Path = { "LastLinePlayed" },
								IsAny = { "/VO/Melinoe_0071" },
							},
						},

						{ Cue = "/VO/Skelly_0109", Text = "Young one." },
						{ Cue = "/VO/Skelly_0111", Text = "Disciple." },
						{ Cue = "/VO/Skelly_0110", Text = "Kiddo.",
							GameStateRequirements =
							{
								{
									Path = { "GameState", "SpeechRecord" },
									HasAll = { "/VO/Skelly_0109", "/VO/Skelly_0111" },
								},
							},
						},
					},
				},
			},

			-- Frinos (Familiar)
			{
				TriggerObjectType = "FrogFamiliar",
				WithinDistance = 500,
				TriggerOnceThisRun = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun"},
					},
				},
				VoiceLines =
				{
					{
						PlayOnce = true,
						PlayOnceContext = "FrinosInPreRunVO",
						BreakIfPlayed = true,
						RandomRemaining = true,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "FrogFamiliar" },
							},
						},
						Cooldowns =
						{
							{ Name = "SaidFrinosRecently", Time = 20 },
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

						{ Cue = "/VO/Melinoe_2769", Text = "Frinos!" },
						{ Cue = "/VO/Melinoe_2770", Text = "Frinos, you're here!", PlayFirst = true },
					},
				},
			},

			-- Toula (Familiar)
			{
				TriggerObjectType = "CatFamiliar",
				WithinDistance = 500,
				TriggerOnceThisRun = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Hub_PreRun"},
					},
				},
				VoiceLines =
				{
					{
						PlayOnce = true,
						PlayOnceContext = "ToulaInPreRunVO",
						BreakIfPlayed = true,
						RandomRemaining = true,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "CatFamiliar" },
							},
						},
						Cooldowns =
						{
							{ Name = "SaidToulaRecently", Time = 20 },
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

						{ Cue = "/VO/Melinoe_3244", Text = "Toula, you made it!" },
					},
				},
			},

		},

		ReverbValue = 1.5,

		InspectPointPriority =
		{
			--
		},
		InspectPoints =
		{
			-- Inspect: Skelly
			[390005] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Skelly_01", },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
				},
				InteractTextLineSets =
				{
					InspectPreRun01 =
					{
						{ Cue = "/VO/Storyteller_0008",
							Text = "{#Emph}The Crossroads training grounds are watched over by fearless seafarer, Schelemeus, famed in death as he was famed in life." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								{ Cue = "/VO/Melinoe_0033", Text = "We cannot fail with such a genius on our side." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Skelly_01",
								{ Cue = "/VO/Skelly_0011", Text = "Nope!" },
							},
						},
					},
				},
			},
			-- Inspect: Training Shades
			[558209] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "InspectHomerReveal01", "InspectPreRun01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "InspectHomerReveal01" }, Count = 4 },
				},
				InteractTextLineSets =
				{
					InspectHomerReveal02 =
					{
						{ Cue = "/VO/Storyteller_0013", IsNarration = true,
							Text = "{#Emph}Within the haunted Crossroads reside Shades and Spirits of all sorts, some resembling their mortal selves, and others, rendered down to purest essences." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								{ Cue = "/VO/Melinoe_1132", Text = "You all right, Homer?" },
							},
							{
								PreLineWait = 0.4,
								RequiredMinElapsedTime = 3,
								StatusAnimation = "StatusIconStorytellerSpeaking",
								StatusAnimSourceIsHero = true,
								Source = { LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice },
								{ Cue = "/VO/Storyteller_0033", Text = "{#Emph}Nay..." },
							},
						},
					},
				},
			},
			-- Inspect: BountyBoard
			[561152]  =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard", },
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "BountyBoard" },
					},
				},
				InteractTextLineSets =
				{
					InspectBountyBoard01 =
					{
						{ Cue = "/VO/Storyteller_0063", IsNarration = true,
							Text = "{#Emph}So ancient is the Pitch-Black Stone, it predates Time itself. Its surface ever seems to drain what light and color dare linger nearby." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_1117", Text = "I can see beneath that surface now..." },
						},
					},
				},
			},
			-- Inspect: Oath -- Inspect: Shrine
			[566416]  =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
					},
				},
				InteractTextLineSets =
				{
					InspectPact01 =
					{
						{ Cue = "/VO/Storyteller_0233", IsNarration = true,
							Text = "{#Emph}A secret monument to Night, etched with her will and testament, looms tall within the training grounds, revealing its nature only to the worthy." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 2,
							{ Cue = "/VO/Melinoe_2960", Text = "I'm in the Inner Circle now..." },
						},
					},
				},
			},

		},
	},

	-- Flashback01 Hub / Hecate Flashback
	Flashback_Hub_Main =
	{
		HeroUnitName = "PlayerMelFlashback",
		HeroOverwrites =
		{
			AttachedAnimationName = "LaurelCindersSpawner_Young",
			Portrait = "Portrait_Mel_Child_01",
		},

		OnDeathLoadRequirements =
		{
			{
				NamedRequirements =  { "Flashback01Unlocked" },
			},
		},
		ZoomFraction = 1.0,
		SoftClamp = 0.75,
		SkipStartRoomPresentation = true,
		-- CameraWalls = true,

		ReverbValue = 0.4,

		IgnoreStemMixer = true,
		IntroSequenceDuration = 2.0,
		DebugOnly = true,
		NoAutoEquip = true,
		FullscreenEffectGroup = "Foreground_01",
		RichPresence = "#RichPresence_Hub",

		LegalEncounters = { "Empty", },

		AmbientMusicParams =
		{
			LowPass = 0.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/RunstartIntroAmbience",
		ReverbValue = 0.4,
		RemoveDashFireFx = true,

		StartUnthreadedEvents =
		{
			{
				FunctionName = "SetupPrePlacedUnits",
				Args =
				{
					TypeNames = { "NPC_LightRanged" },
				},
			},
			{
				FunctionName = "CheckPriorityConversations",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					Conversations =
					{
						"HypnosHideAndSeek01",
					},
				},
			},
			{
				FunctionName = "SetupFlashback01",
				Args =
				{
					Ids = { 583639 },
					NightmareMessage = "FlashbackMessage01",
					TextLineSet =
					{
						HecateHideAndSeekIntro01 =
						{
							{ Cue = "/VO/Storyteller_0235", IsNarration = true, SkipPortrait = true, PreLineWait = 0.9,
								PostLineThreadedFunctionName = "CheckPriorityConversations", PostLineFunctionArgs = { Conversations =
									{
										"HecateHideAndSeek01",
										"HecateHideAndSeek02",
										"HecateHideAndSeek03",
										"HecateFlashback01",
									},
								},								
								Text = "{#Emph}It is the dead of night within a haunted, barely moonlit thicket at the Underworld's edge. There, a young forsaken Princess hunts her prey..." },
							EndVoiceLines =
							{
								{
									UsePlayerSource = true,
									{ Cue = "/VO/Melinoe_2106", Text = "...Ready or not, hence I go...!", PreLineWait = 0.5 },
								},
							},
						},
					},
				},
			},
		},

		ThreadedEvents =
		{

		},

		UnthreadedEvents =
		{

		},
		ObstacleData =
		{
			-- Ghosts / Shades
			[561454] =
			{
				Name = "FlashbackShade01",
				SetupGameStateRequirements =
				{
					--
				},

				DistanceTriggers =
				{
					{
						WithinDistance = 500,
						ChanceToPlay = 1,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							TargetId = 561454,
							OffsetZ = 60,
							AnimationName = "StatusIconSmile",
						},
						GameStateRequirements =
						{
							{
								-- PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
							},
						},

						VoiceLines =
						{
							PlayOnce = true,
							BreakIfPlayed = true,
							UsePlayerSource = true,
							PreLineWait = 0.4,
							PostLineThreadedFunctionName = "PlayEmoteSimple",
							PostLineFunctionArgs =
							{
								TargetId = 561454,
								AnimationName = "StatusIconFear",
							},

							{ Cue = "/VO/Melinoe_2114", Text = "Hi Shades, is Hecate about...? Not seen her, huh?" },
						},
					},
					{
						WithinDistance = 500,
						ChanceToPlay = 1,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							TargetId = 561454,
							OffsetZ = 60,
							AnimationName = "StatusIconFear",
							Delay = 3
						},
					},
				},
			},

		},
		EnterVoiceLines =
		{
		},

		InspectPoints =
		{
			-- Inspect: Homer reveal
			[583651] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				InspectMoveIds =
				{
					[561501] = 583653,
					[561499] = 583654,
					[561498] = 583655,
					[567076] = 583656,
				},
				InteractTextLineSets =
				{
					InspectHomerReveal01 =
					{
						{ Cue = "/VO/Storyteller_0140",
							AngleHeroTowardTargetId = 575836,
							Text = "{#Emph}The keen-eyed Princess finds a set of tracks, suggesting that her foe trod through this dusty ground not very long before..." },
							{ Cue = "/VO/Melinoe_2105",
								AngleTowardTargetId = 576016,
								UsePlayerSource = true,
								SecretMusic = "/EmptyCue",
								StartSound = "/SFX/Menu Sounds/RecordScratch",
								PortraitExitAnimation = "Portrait_Mel_Child_01_Exit",
								PreLineAnim = "Melinoe_Young_Brooding_Start", PreLineAnimTarget = "Hero",
								PostLineAnim = "Melinoe_Young_Brooding_End", PostLineAnimTarget = "Hero",
								Speaker = "PlayerUnit_Flashback",
								Emote = "PortraitEmoteFiredUp",
								Text = "{#Emph}Shush{#Prev}, Homer! How shall I ever catch her if you're going to describe my every move?" },
							{ Cue = "/VO/Storyteller_0149", SkipPortrait = true, IsNarration = true,
								Emote = "PortraitEmoteSurprise",
								PostLineFunctionName = "UpdateHubMainFlashback",
								PostLineThreadedFunctionName = "CheckPriorityConversations", PostLineFunctionArgs = 
									{ Conversations =
										{
											"OdysseusHideAndSeek01",
										},
									},
								Text = "{#Emph}Uhhh erm-erm-erm, I, I, I've no idea to whom you refer... to whom the Princess of the Dead refers! As she continues on her fateful search." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_2269", Text = "Quit teasing me and help me look!" },
							},
						},

					},
				},
			},
		},

	},

})

GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.DeathVoiceLines =
{
	Queue = "Interrupt",
	RandomRemaining = true,
	-- BreakIfPlayed = true,
	-- PreLineWait = 0.25,
	SkipAnim = true,

	{ Cue = "/VO/Melinoe_0123", Text = "Wha—?" },
	{ Cue = "/VO/Melinoe_0124", Text = "{#Emph}Ungh{#Prev}, no!" },
	{ Cue = "/VO/Melinoe_0125", Text = "{#Emph}Augh!" },
	{ Cue = "/VO/Melinoe_0126", Text = "{#Emph}Gaah!" },
	{ Cue = "/VO/MelinoeField_1384", Text = "{#Emph}Ungh!" },
	{ Cue = "/VO/MelinoeField_1387", Text = "How—?" },
	{ Cue = "/VO/MelinoeField_1389", Text = "No!" },
	{ Cue = "/VO/MelinoeField_1390", Text = "{#Emph}Ngh{#Prev}, no...!" },
	{ Cue = "/VO/MelinoeField_1388", Text = "You!!" },
	-- { Cue = "/VO/MelinoeField_1386", Text = "Damn...!" },
	-- { Cue = "/VO/MelinoeField_1385", Text = "{#Emph}Augh{#Prev}, I..." },
	-- { Cue = "/VO/MelinoeField_1391", Text = "{#Emph}Guh{#Prev}, can't...!" },	
}

-- NOTE(andrew): BuildText expects GlobalVoiceLines.XXX to properly determine
-- the event. So do a little bit of swapping to put it in the expected format. 
local temp = GlobalVoiceLines.DeathReturnVoiceLines or {}
GlobalVoiceLines.DeathReturnVoiceLines =
{
	[1] =
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Hecate_01", SubtitleColor = Color.HecateVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Hecate_0010", Text = "You're clearly unprepared as yet.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "RoomCountCache", "G_Intro" },
				},
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">",
					Value = 0.33,
				},
			},
		 },
		{ Cue = "/VO/Hecate_0132", Text = "I know that you are stronger than this.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.4,
				},
			},
		},
		{ Cue = "/VO/Hecate_0133", Text = "I know you could have done better than that.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.4,
				},
			},
		},
		{ Cue = "/VO/Hecate_0134", Text = "You must be stronger than this, Melinoë.", },
		{ Cue = "/VO/Hecate_0135", Text = "A lesson learned, I trust?", },
		{ Cue = "/VO/Hecate_0136", Text = "The Moon was witness to our clash this night.", },
		{ Cue = "/VO/Hecate_0137", Text = "Return and rest, and try again, Melinoë.", },
		{ Cue = "/VO/Hecate_0138", Text = "I take no joy in this, I hope you know.", },
		{ Cue = "/VO/Hecate_0139", Text = "Consider the mistakes you made, Melinoë.", },
		{ Cue = "/VO/HecateField_0074", Text = "Collapsed under the pressure of it all...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.25,
				},
			},
		},
		{ Cue = "/VO/HecateField_0075", Text = "You almost had me! Not quite.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.25,
				},
			},
		},
		{ Cue = "/VO/HecateField_0076", Text = "So very close, and yet not strong enough.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.25,
				},
			},
		},
		{ Cue = "/VO/HecateField_0077", Text = "Fought more fiercely than last time at least.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = "<",
					Value = 0.5,
				},
				{
					Path = { "PrevRun", "BossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.5,
				},
				ConsecutiveDeathsInRoom = { Name = "F_Boss01", Count = 1 },
			},
		},
		{ Cue = "/VO/HecateField_0078", Text = "Do not be disappointed; you fought well.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.33,
				},
			},
		},
		{ Cue = "/VO/HecateField_0079", Text = "You barely got to me at all that time.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.66,
				},
			},
		},
	},
	[2] = {},
	[3] = {},
	[4] = {},
	[5] = {},
	[6] =
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Arachne_01", SubtitleColor = Color.ArachneVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Story01" },
			},
		},	

		{ Cue = "/VO/Arachne_0275", Text = "Oh no, my friend, where did you go? Come back!", PlayFirst = true },
		{ Cue = "/VO/Arachne_0276", Text = "Wait, no, what happened? Wait!" },
		{ Cue = "/VO/Arachne_0277", Text = "So much for a good shopping experience..." },
		{ Cue = "/VO/Arachne_0278", Text = "Do come back soon? {#Emph}Haha, hah..." },
	},
	-- first run
	[7] =
	{
		Queue = "Always",
		BreakIfPlayed = true,
		PlayOnce = true,
		PlayOnceContext = "FirstDeathVO",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = "==",
				Value = 0,
			},
			{
				PathFalse = { "CurrentRun", "Cleared" },
			},
		},

		{ Cue = "/VO/MelinoeField_1392", Text = "Return to shadow, now...!" },
	},
	[8] =
	{
		Queue = "Always",
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				--
			},
		},

		{ Cue = "/VO/Melinoe_1693", Text = "Return to shadow, now!" },
		{ Cue = "/VO/Melinoe_1694", Text = "Return to shadow, now.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Cleared" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_1695", Text = "Return to shadow, now...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1696", Text = "Return to shadow, now..." },
		{ Cue = "/VO/MelinoeField_1392", Text = "Return to shadow, now...!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "H_Boss01", "I_Boss01", "P_Boss01", "Q_Boss01" },
				},
				{
					Path = { "CurrentRun", "BossHealthBarRecord" },
					MaxOf = "All",
					Comparison = "<",
					Value = 0.4,
				},
				{
					Path = { "CurrentRun" },
					HasNone = { "Cleared", "BountyCleared" }
				},
			}
		},
		{ Cue = "/VO/MelinoeField_1393", Text = "Return to shadow, now...!" },
	},
}
OverwriteTableKeys( temp, GlobalVoiceLines.DeathReturnVoiceLines )
GlobalVoiceLines.DeathReturnVoiceLines = temp

temp = GlobalVoiceLines.EnteredDeathAreaVoiceLines or {}
GlobalVoiceLines.EnteredDeathAreaVoiceLines =
{
	Queue = "Always",
	-- respawn lines
	-- first hub visit
	[1] = 
	{
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = "==",
				Value = 0,
			},
		},

		{ Cue = "/VO/Melinoe_0008_V3", Text = "{#Emph}<Gasp> Ohh...", PreLineWait = 0.5, PostLineWait = 1.8 },
		{ Cue = "/VO/Melinoe_0009", Text = "...Back already.", PostLineWait = 2.4 },
		{ Cue = "/VO/Melinoe_2992", Text = "Damn it...",
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Cleared" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2994", Text = "All right.",
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Cleared" },
				},
			},
		},
	},

	-- post-moros sighting 1
	[2] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosGrantsQuestLog" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,

		{ Cue = "/VO/Melinoe_1584", Text = "{#Emph}Ungh... {#Prev}he's gone..." },
	},
	-- post-moros sighting 2
	[3] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosSecondAppearance" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 2.2,

		{ Cue = "/VO/Melinoe_1871", Text = "{#Emph}Ungh... {#Prev}where did he go?" },
	},
	-- post-flashback01
	[4] =
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "HecateHideAndSeek01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,

		-- { Cue = "/VO/Melinoe_2129", Text = "{#Emph}<Sigh> {#Prev}How long has it been..." },
		{ Cue = "/VO/Melinoe_2130", Text = "{#Emph}Ungh... {#Prev}Death to Chronos..." },
	},

	[5] = {},

	-- cleared the run / run cleared lines / after a clear
	[6] = 
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.2,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Boss01", "Q_Boss01" },
			},
			{
				Path = { "CurrentRun" },
				HasAny = { "Cleared" }
			},
		},

		{ Cue = "/VO/Melinoe_1872", Text = "{#Emph}Eugh... {#Prev}what just happened?", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1873", Text = "{#Emph}Augh... {#Prev}so that's the way it is." },
		{ Cue = "/VO/Melinoe_2567", Text = "{#Emph}Mmph... {#Prev}adequate." },
		{ Cue = "/VO/Melinoe_2568", Text = "{#Emph}Whew. {#Prev}Not a bad night, I guess." },
		{ Cue = "/VO/Melinoe_2569", Text = "...The Fates were on my side.", PreLineWait = 2.0 },
		{ Cue = "/VO/Melinoe_2570", Text = "...I did all right that time...", PreLineWait = 2.0 },
		{ Cue = "/VO/Melinoe_2399", Text = "{#Emph}Mph{#Prev}... well {#Emph}that {#Prev}was productive." },
	},
	[7] = {},
	[8] = {},

	-- minibosses
	-- lost to Erebus minibosses
	[9] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_MiniBoss01", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_1671", Text = "{#Emph}Hrngh{#Prev}, I'll get that Root-Stalker...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1672", Text = "{#Emph}Ungh{#Prev}, I hate Root-Stalkers..." },
	},
	[10] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_MiniBoss02", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_1673", Text = "{#Emph}Mrm{#Prev}, that Shadow-Spiller's tough...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1674", Text = "{#Emph}Augh{#Prev}, blasted shadows..." },
	},
	[11] = {},
	[12] = {},
	[13] = {},
	[14] = {},
	[15] = {},
	[16] = {},
	[17] = {},
	[18] = {},

	-- bosses
	-- lost to hecate
	[19] = 
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Boss01", },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_1874", Text = "{#Emph}Rngh{#Prev}, so blasted close!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.20,
				},
			},
		},
		{ Cue = "/VO/Melinoe_1875", Text = "{#Emph}Nrgh{#Prev}, I almost had her there...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.20,
				},
			},
		},
		{ Cue = "/VO/Melinoe_0369", Text = "{#Emph}Ungh{#Prev}, Headmistress..." },
		{ Cue = "/VO/Melinoe_0370", Text = "{#Emph}Augh{#Prev}, she's... strong." },
	},

	[20] = {},
	[21] = {},
	[22] = {},
	[23] = {},
	[24] = {},

	-- almost beat boss
	[25] =
	{
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Boss01", "G_Boss01", "H_Boss01", "I_Boss01", "N_Boss01", "O_Boss01", "P_Boss01", "Q_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord" },
				MaxOf = "All",
				Comparison = "<",
				Value = 0.15,
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord" },
				MaxOf = "All",
				Comparison = ">",
				Value = 0,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			{
				PathFalse = { "CurrentRun", "Cleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,

		{ Cue = "/VO/Melinoe_0105", Text = "Almost...", PreLineWait = 1.9 },
		{ Cue = "/VO/Melinoe_2636", Text = "{#Emph}Hah... {#Prev}I was so close..." },
		{ Cue = "/VO/Melinoe_2637", Text = "{#Emph}Rngh... {#Prev}nearly had it..." },
		{ Cue = "/VO/Melinoe_2638", Text = "{#Emph}Ungh... {#Prev}almost had him...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "H_Boss01", "I_Boss01", "N_Boss01", "P_Boss01", "Q_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2639", Text = "{#Emph}Khh... {#Prev}almost had her...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_Boss01", "F_Boss02", "F_Boss03", "G_Boss01", "O_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2640", Text = "{#Emph}Ngh... {#Prev}just when I thought..." },
		{ Cue = "/VO/Melinoe_2641", Text = "{#Emph}Eugh... {#Prev}thought I had that..." },
	},

	[26] = {},

	-- other encounters
	-- lost in artemis encounter
	[27] =
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "ArtemisCombatIntro", "ArtemisCombatF", "ArtemisCombatG" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_1877", Text = "...Not even Artemis could help me out of that." },
	},

	[28] = {},
	[29] = {},
	[30] = {},
	[31] = {},
	[32] = {},
	[33] = {},
	[34] = {},
	[35] = {},
	[36] = {},
	[37] = {},

	-- lost in misc. ways
	[38] =
	{
		GameStateRequirements =
		{
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = ">=",
				Value = 1,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,

		{ Cue = "/VO/Melinoe_3556", Text = "{#Emph}Ungh... {#Prev}Frinos, you there...?", PostLineFunctionName = "FrogFamiliarReaction", PlayFirst = true, AreIdsAlive = { 566831 } },
		{ Cue = "/VO/Melinoe_0099", Text = "{#Emph}<Gasp> Ungh...", PreLineWait = 0.5 },
		{ Cue = "/VO/Melinoe_0008_V3", Text = "{#Emph}<Gasp> Augh...", PreLineWait = 0.5, RequiredMinCompletedRuns = 10 },
		{ Cue = "/VO/Melinoe_0100", Text = "{#Emph}...Augh!" },
		{ Cue = "/VO/Melinoe_0101", Text = "Returned...", PreLineWait = 1.8 },
		{ Cue = "/VO/Melinoe_0102", Text = "Home...", PreLineWait = 1.8 },
		{ Cue = "/VO/Melinoe_0103", Text = "No...", PreLineWait = 1.8 },
		{ Cue = "/VO/Melinoe_0104", Text = "{#Emph}Augh..." },
		{ Cue = "/VO/Melinoe_0106", Text = "How long was I out...?", PreLineWait = 1.6 },
		{ Cue = "/VO/Melinoe_0361", Text = "{#Emph}Eugh, augh..." },
		{ Cue = "/VO/Melinoe_0362", Text = "{#Emph}Mmph... {#Prev}back again..." },
		{ Cue = "/VO/Melinoe_0363", Text = "{#Emph}Urgh... {#Prev}damn it." },
		{ Cue = "/VO/Melinoe_0364", Text = "{#Emph}Mmph{#Prev}, blood and..." },
		{ Cue = "/VO/Melinoe_0365", Text = "{#Emph}Ungh... {#Prev}get up, Mel." },
		{ Cue = "/VO/Melinoe_0366", Text = "{#Emph}Mm{#Prev}, not good enough." },
		{ Cue = "/VO/Melinoe_0367", Text = "{#Emph}Eugh{#Prev}, I won't be making {#Emph}that {#Prev}mistake again." },
		{ Cue = "/VO/Melinoe_0368", Text = "{#Emph}Augh{#Prev}, my training clearly isn't yet complete." },
		{ Cue = "/VO/Melinoe_0374", Text = "{#Emph}<Gasp> ...T'heh..." },
		{ Cue = "/VO/Melinoe_2397", Text = "{#Emph}Ngh{#Prev}... rise and shine..." },
		{ Cue = "/VO/Melinoe_2398", Text = "{#Emph}Eugh{#Prev}... what a night." },
		{ Cue = "/VO/Melinoe_2400", Text = "{#Emph}Ah{#Prev}... hm." },
		{ Cue = "/VO/Melinoe_2401", Text = "{#Emph}<Gasp> <Sigh>" },
		{ Cue = "/VO/Melinoe_2402", Text = "{#Emph}<Gasp> Heh heh..." },
		{ Cue = "/VO/Melinoe_2710", Text = "{#Emph}Nngh... {#Prev}back already." },
		{ Cue = "/VO/Melinoe_2711", Text = "{#Emph}Augh... {#Prev}another night." },		
	},
}
OverwriteTableKeys( temp, GlobalVoiceLines.EnteredDeathAreaVoiceLines )
GlobalVoiceLines.EnteredDeathAreaVoiceLines = temp
