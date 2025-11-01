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
		RichPresence = "#RichPresence_Hub",
		FullscreenEffectGroup = "LoungeHider_01",
		EntranceFunctionName = "EnterHubRoomPresentation",
		NarrativeContextArt = "DialogueBackgroundBiome_Woods",
		NarrativeContextArtFlippable = true,
		FishBiome = "F",
		GlobalEcho = 0.0,
		LoadPackages = { "Moros", },

		OnLoadEvents =
		{
			{
				-- @ ending
				FunctionName = "StartDeathLoop",
				Args =
				{
					PresentationFunctionName = "HubPostCreditsStartPresentation",
					PresentationFunctionArgs =
					{
						PortraitArgs =
						{
							StartScale = 0.93,
							EndScale = 0.63,
							PanDuration = 9.8,
							UnthreadedVoiceLines = true,
						},
						PostPortraitTextLines =
						{
							TrueEndingFinaleResponse01 =
							{
								PlayOnce = true,
								SkipContextArt = true,

								{ Cue = "/VO/Melinoe_5736",
									UsePlayerSource = true,
									Portrait = "Portrait_Mel_Proud_01",
									PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Empathetic_01", WaitTime = 2.4 },
									PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
									PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

									Text = "May it all turn out that way in time, Homer. Though, we're not there yet, especially not with the Fates still missing. We achieved something important, but more is to be done." },

								EndFunctionName = "DisplayTrueEndingInfoBanner",
								EndFunctionArgs = { Title = "TrueEndingReached", PreWait = 0.1, PostCreditsMusicFadeOutDuration = 0.3, Stinger = "/Music/IrisVictoryStingerLARGE", EndFunctionName = "RestoreMusicianMusic" },

								EndVoiceLines =
								{
									{
										PreLineWait = 3.4,
										UsePlayerSource = true,
										{ Cue = "/VO/Melinoe_5737", Text = "...I said we're not finished!" },
									},
								},

							},
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_DeathAreaRestored" },
					},
					{
						PathFalse = { "CurrentRun", "UsedStoryReset" },
					},
					{
						PathFalse = { "CurrentHubRoom", },
					},
				},
				BreakIfPlayed = true,
			},
			{
				FunctionName = "StartDeathLoop",
				Args =
				{
					PresentationFunctionName = "HubPostStoryResetStartPresentation",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UsedStoryReset" },
					},
					{
						PathFalse = { "CurrentHubRoom" },
					},
				},
				BreakIfPlayed = true,
			},
			{
				FunctionName = "StartDeathLoop",
				Args =
				{
					PresentationFunctionName = "StartDeathLoopPresentation",
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentHubRoom" }
					},
				},
				BreakIfPlayed = true,
			},
			{
				FunctionName = "DeathAreaRoomTransition",
			},
		},

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

		BlockCombat = true,
		UnloadWeapons = false,

		IgnoreStemMixer = true,
		AmbientMusicSourceId = 561502,
		AmbientMusicParams =
		{
			LowPass = 0.0,
			Vocals = 1.0,
			Vocals2 = 0.0,
		},
		AmbientMusicParamsInTent =
		{
			LowPass = 0.6,
			Vocals = 0.6,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/RunstartIntroAmbience",
		ReverbValue = 0.4,

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
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				FunctionName = "OncePerRunTentExitPresentation",
				Args =
				{
					CheckCodexDelay = 0.5,
					DisplayInfoBannerArgs =
					{
						Text = "Location_Home",
						Color = Color.White,
						FadeColor = Color.Red,
						AnimationName = "LocationBackingIrisDeathIn",
						AnimationOutName = "LocationBackingIrisDeathOut",
						Delay = 0.2,
						Duration = 2.25,
					},
				},
				VoiceLines =
				{
					{
						PlayOnce = true,
						PreLineWait = 0.75,
						Queue = "Never",
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
					-- for Ghost Groupies
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						PreLineWait = 0.65,
						PlayOnceFromTableThisRun = true,
						SuccessiveChanceToPlayAll = 0.33,
						GameStateRequirements = 
						{
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = ">",
								Value = 0,
							},
							{
								PathTrue = { "CurrentRun", "Cleared" },
							},
						},
						Cooldowns =
						{
							{ Name = "MelinoeAnyQuipSpeech" },
							{ Name = "MorosBeingPolite", Time = 2 },
						},

						{ Cue = "/VO/Melinoe_2425", Text = "Oh, hello...!", PlayFirst = true },
						{ Cue = "/VO/Melinoe_2426", Text = "I'm fine, really!" },
						{ Cue = "/VO/Melinoe_2427", Text = "No need to be concerned!" },
						{ Cue = "/VO/Melinoe_2428", Text = "Begging your pardon, Shades." },
						{ Cue = "/VO/Melinoe_2429", Text = "Good evening everyone...!" },
						{ Cue = "/VO/Melinoe_2430", Text = "Thank you for waiting..." },
						{ Cue = "/VO/Melinoe_2431", Text = "Come along then...!" },
						{ Cue = "/VO/Melinoe_2432", Text = "Let's have a look around." },
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
					-- Moros after Supay
					{
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "WorldUpgradesRevealed", "TorchAutofireAspect" } 
							},
							{
								FunctionName = "RequiredAlive",
								FunctionArgs = { Units = { "NPC_Moros_01" }, Alive = false },
							},
						},
						{ Cue = "/VO/Melinoe_4693", Text = "Lord Moros was just here..." },
					},
				},
			},

			-- Eris Trash / Eris Rubbish
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

			-- East/West Entrances (for Dora)
			{
				TriggerGroup = "WestSideEntrance", WithinDistance = 175, FunctionName = "HubWestSideEnterPresentation", Repeat = true,
			},
			{
				TriggerGroup = "EastSideEntrance", WithinDistance = 175, FunctionName = "HubEastSideEnterPresentation", Repeat = true, 
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

			-- iris npcs / critical conversations / critical events / key events / priority conversations / priority events
			{
				FunctionName = "CheckPriorityConversations",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					Variants = 
					{
						NPC_Icarus_01 = "IcarusHome",
					},
					IgnorePartnerExists = true,
					Conversations =
					{
						-- introductions
						"DoraFirstMeeting",
						"OdysseusFirstMeeting",
						"NemesisFirstMeeting",
						"MorosFirstMeeting",
						"ErisFirstMeeting_B",
						"ErisFirstMeeting",

						-- Nyx key events
						"NyxWithHecate01",
						"NyxWithNemesis01",

						-- Icarus key events
						-- "IcarusHubAboutCrossroads02",
						"IcarusHomePostEpilogue01",
						"IcarusHomeAboutTyphonDeath01",

						-- Hecate key events
						"HecateBathHouseEpilogue01",
						"HecatePostTrueEnding01",
						"HecatePostTrueEnding02",
						"HecatePostTrueEnding04",
						"HecatePostTrueEnding03",

						"HecateAboutTyphonDeath01",
						"HecateAboutStormStop01",
						"HecateAboutTyphonFight03",
						"HecateAboutTyphonFight03_B",
						"HecateAboutTyphonFight01_B",
						"HecateAboutTyphonFight01",
						"HecateAboutTyphonFight02_B",
						"HecateAboutChronosBossW04",
						"HecateAboutChronosBossW04_A",
						"HecateAboutChronosBossW04_B",

						"HecateAboutChronosBossW03",
						"HecateAboutChronosBossW02",
						"HecateAboutChronosBossW01",
						"HecateAboutChronosBossW01Cont1",
						"HecateAboutTimeStop01",
						"HecateAboutStormStop01_B",
						"HecateAboutUltimateProgress03_A",
						"HecateAboutUltimateProgress03",
						"HecateAboutUltimateProgress04",
						"HecateAboutUltimateProgress02",
						"HecateAboutUltimateProgress01",
						"HecateAboutStormStopNotCast01",

						"HecateAboutPalace01",
						"HecateUnderworldRunCleared01",

						"HecateAboutChronosBossL01",
						"HecateAboutChronosBossEarlyL01",
						"HecateAboutChronosAnomaly01",
						"HecateAboutChronos01",
						"HecateGrantsWeaponUpgradeSystem01",
						"HecateGrantsFamiliars01",
						"HecateGrantsShrineUpgrade01",
						"HecateAboutHermes01",
						"HecateAboutQuestLog02",
						"HecateAboutSurface03",
						"HecateAboutTyphonAltFightW01",

						-- Odysseus key events
						-- note: all of these should have NamedRequirementsFalse = { "OdysseusWandering" },
						"OdysseusAboutReturn01",
						"OdysseusPostTrueEnding01",
						"OdysseusPostEpilogue01",
						"OdysseusAboutHecateKidnapped01",
						"OdysseusAboutTyphonDeath01",
						"OdysseusAboutPrometheusAltFight01",
						"OdysseusAboutSurface02",
						"OdysseusAboutChronosAnomaly01",
						"OdysseusAboutHermes01",
						"OdysseusAboutTyphonL01",
						"OdysseusAboutTyphonW01",
						"OdysseusAboutChronosBossW01",
						"OdysseusAboutUltimateProgress01",
						"OdysseusAboutChronosBossTactics01",
						"OdysseusAboutChronosBossL01",
						"OdysseusAboutErisBossTactics01",
						"OdysseusAboutScyllaTactics01",
						"OdysseusGrantsPlantFMoly01_B",
						"OdysseusGrantsMemPointsCommon01_B",
						"OdysseusGrantsMetaFabric01_B",
						"OdysseusAboutTyphon01",

						-- Dora key events
						"DoraPostTrueEnding01",
						"DoraPostEpilogue01",
						"DoraAboutChronosBossW01",
						"DoraAboutTask01",
						"DoraGrantsCosmeticsShop01",
						"DoraAboutMemories01",
						"DoraAboutNightmares01",

						-- Moros key events
						"MorosAboutRelationship03",
						"MorosAboutRelationship03_B",
						"MorosAboutEpilogueProgress01",
						"MorosPostEpilogue01",
						"MorosPostTrueEnding01",
						"MorosPostTrueEnding02",
						"MorosAboutHecateKidnapped01",
						"MorosAboutTyphonDeath01",

						"MorosAboutFates02",
						"MorosAboutSurfacePenaltyCure01",
						"MorosAboutChronosBossW01",
						"MorosAboutTyphon01",

						-- Nemesis key events
						"NemesisPostTrueEnding01",
						"NemesisPostEpilogue01",
						"NemesisPostTrueEndingTimeStopped01",
						"NemesisAboutHecateKidnapped01",
						"NemesisAboutTyphonDeath01",
						"NemesisAboutRelationship01",
						"NemesisAboutRelationship01_B",
						"NemesisAboutFieldMeeting01",
						"NemesisAboutChronosBossL02",
						"NemesisAboutCombatFailure01",
						"NemesisAboutTyphon01",
						"NemesisAboutChronosNightmare01",

						-- Eris key events
						"ErisPostTrueEnding01",
						"ErisAboutUltimateProgress01",
						"ErisAboutChronos01",
						"ErisAboutTyphon01",
						"ErisFoughtAgainstHer01",
						"ErisAboutCloseMatch01",

						-- Charon key events
						"CharonWithHecate01", -- Mailbox

						-- Artemis key events
						"ArtemisHubFirstMeeting01",
						"ArtemisHubAboutChronosBoss01",
						"ArtemisHubSinging01",

						-- Selene key events
						"SeleneWithHecate01",
						"SeleneHome01",

						-- Arachne key events
						"ArachneHubFirstMeeting01",
						"ArachneWithHecateInHub01",
						"ArachneWithHecateInHub02",

						-- Medea key events
						"MedeaHubFirstMeeting01",
					},
				},
			},
			-- hypnos always present (until he makes his dramatic exit)
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
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
			-- hecate always present until flashback or if you lost to her
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
							},
						},
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsAny = { "F_Boss01", "F_Boss02" },
							},
						},
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "HecateHideAndSeek01" },
					},
					-- @ ending
					NamedRequirementsFalse = { "HecateMissing" },
				},
				Args =
				{
					Types =
					{
						"NPC_Hecate_01",
					},
				},
			},
			-- odysseus always present till after 1st Chronos clear
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" }
					},
				},
				Args =
				{
					Types =
					{
						"NPC_Odysseus_01",
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
						"NPC_Icarus_01",
						-- "NPC_Hypnos_01",
					},
					LeaveOutMin = 1,
					LeaveOutMax = 1,
					ActivationsMin = 3,
					ActivationsMax = 9,
					Variants = 
					{
						NPC_Icarus_01 = "IcarusHome",
					},
				},
			},
			-- dora always present after Cosmetics unlocked
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					NamedRequirements = { "CosmeticsShopUnlocked" },
					{
						PathFalse = { "CurrentRun", "BlockDoraSpawn" },
					},
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
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "FatesEpilogue01" }
					},
					NamedRequirementsFalse = { "JustBeforeOrAfterTrueEnding" },
				},
				Args =
				{
					Types =
					{
						"NPC_Charon_01",
					},
				},
			},
			-- artemis singing / present after her singing intro
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ArtemisHubSong" }, -- handled below
					},
					{
						PathFalse = { "PreviousDeathAreaRoom" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" }
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Artemis_01" },
						Comparison = "<=",
						Value = 0,
					},
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.1,
					},
					NamedRequirementsFalse = { "ArtemisSingingBlockedByEvents" },
					ChanceToPlay = 0.85,
				},
				Args =
				{
					Types =
					{
						"NPC_Artemis_01",
					},
				},
			},
			-- artemis should spawn again when re-entering from Hub_PreRun
			{
				FunctionName = "RespawnArtemisForSinging",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ArtemisHubSong" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Artemis_01" }, Alive = false },
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
			{
				FunctionName = "ActivateConditionalItems",
				Args =
				{
					CosmeticsShopCategoryIndex = 3,
				},
			},
			-- selene present on new moons
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
					{
						SumPrevRuns = 8,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Selene_01" },
						Comparison = "<=",
						Value = 0,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "SeleneHome01" }
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "FatesEpilogue01" },
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
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								FunctionName = "RequireRunsSinceTextLines",
								FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 4 },
							},
						},
					},
					NamedRequirementsFalse = { "JustBeforeOrAfterTrueEnding" },
				},
				Args =
				{
					Types =
					{
						"NPC_Selene_01",
					},
				},
			},

			-- Ghost Eavesdroppers
			-- first run (alts below)
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
							{
								Name = "Ghost_Agent05",
								PlayFirst = true,
								GameStateRequirements =
								{
									-- None
								},
							},
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
					ChanceToPlay = 1.0,
				},
			},
			-- artemis singing
			{
				FunctionName = "GhostEavesdroppers",
				Args =
				{
					RandomGroups =
					{
						{ 743524, 743523, 743522, },
						{ 743528, 743530, 743529, },
					},
					InspectPoint =
					{
						Name = "GhostInspectPoint",
						UseTextSpecial = "UseGhostEavesdropper",
						SpecialInteractFunctionName = "UseGhostEavesdropper",
						AgeOfDeath = 24,
						RandomLines =
						{

							{ Name = "Ghost_Scout10" },
							{ Name = "Ghost_Scout10a" },
							{ Name = "Ghost_Agent16" },
							{ Name = "Ghost_Agent19" },
						},
					}
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" },
					},
					{
						Path = { "AudioState", "AmbientTrackName" },
						IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
					},
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.1,
					},
					ChanceToPlay = 0.85,
				},
			},
			-- subsequent runs (after taverna)
			{
				FunctionName = "GhostEavesdroppers",
				Args =
				{
					RandomGroups =
					{
						{ 590510, 590509, 590508, },
						{ 590511, 590512, 590507, },
						{ 590513, 590514, 590515, },
						{ 590880, 590882, 590879, },
						{ 590891, 590893, 590890, },
						{ 743521, 743520, 743519, },
						{ 743517, 743516, 743518, },
					},
					InspectPoint =
					{
						Name = "GhostInspectPoint",
						UseTextSpecial = "UseGhostEavesdropper",
						SpecialInteractFunctionName = "UseGhostEavesdropper",
						AgeOfDeath = 24,
						RandomLines =
						{
							{ Name = "Ghost_Agent01", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent02", },
							{ Name = "Ghost_Agent03", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent04", },
							{ Name = "Ghost_Agent05", },
							{ Name = "Ghost_Agent06", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent07", },
							{ Name = "Ghost_Agent08", },
							{ Name = "Ghost_Agent09", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent10", },
							{ Name = "Ghost_Agent11", },
							{ Name = "Ghost_Agent12", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent13", },
							{ Name = "Ghost_Agent14", },
							{ Name = "Ghost_Agent15", },
							{ Name = "Ghost_Agent16", },
							{ Name = "Ghost_Agent17", },
							{ Name = "Ghost_Agent18", },
							{ Name = "Ghost_Agent19", },
							{ Name = "Ghost_Agent20", },
							{ Name = "Ghost_Agent21", },
							{ Name = "Ghost_Agent22", },
							{ Name = "Ghost_Agent23", },
							{ Name = "Ghost_Agent24", },

							{ Name = "Ghost_Scout01",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "AudioState", "AmbientTrackName" },
										IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
									},
								},
							},
							{ Name = "Ghost_Scout02",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "AudioState", "AmbientTrackName" },
										IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
									},
								},
							},
							{ Name = "Ghost_Scout03",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Units = { "NPC_Eris_01", } },
									},
								},
							},
							{ Name = "Ghost_Scout04",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
									},
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
									{
										Path = { "GameState", "TextLinesRecord" },
										HasNone = { "NeoChronosAboutTartarus02", "NeoChronosAboutOlympus02" },
									},
								},
							},
							{ Name = "Ghost_Scout04a",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
									},
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
								},
							},
							{ Name = "Ghost_Scout05",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "RoomsEntered" },
										HasAny = { "Q_Boss01", "Q_Boss02" },
									},
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
								},
							},
							{ Name = "Ghost_Scout05a",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "RoomsEntered" },
										HasAny = { "Q_Boss01", "Q_Boss02" },
									},
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
									{
										PathFalse = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
									},
								},
							},
							{ Name = "Ghost_Scout06",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "CurrentRoom", "Name" },
										IsAny = { "P_Boss01" },
									},
								},
							},
							{ Name = "Ghost_Scout07",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Units = { "NPC_Moros_01", "NPC_Eris_01" }, },
									},
								},
							},
							{ Name = "Ghost_Scout08",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
									},
								},
							},
							{ Name = "Ghost_Scout09",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "GameState", "NextBiomeStateName" },
										IsAny = { "Rain" },
									},
								},
							},
							{ Name = "Ghost_Scout11",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "AudioState", "AmbientTrackName" },
										IsAny =
										{
											"/Music/MusicPlayer/Iris/IrisMusicScylla1MusicPlayer",
											"/Music/MusicPlayer/Iris/IrisMusicScylla1bMusicPlayer",
											"/Music/MusicPlayer/Iris/IrisMusicScylla2MusicPlayer",
											"/Music/MusicPlayer/Iris/IrisMusicScylla2bMusicPlayer",
										},
									},
									{
										Path = { "ConfigOptionCache", "MusicVolume" },
										Comparison = ">",
										Value = 0.1,
									},
								},
							},
							{ Name = "Ghost_Scout11a",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "AudioState", "AmbientTrackName" },
										IsAny =
										{
											"/Music/MusicPlayer/Iris/IrisMusicScylla1MusicPlayer",
											"/Music/MusicPlayer/Iris/IrisMusicScylla1bMusicPlayer",
											"/Music/MusicPlayer/Iris/IrisMusicScylla2MusicPlayer",
											"/Music/MusicPlayer/Iris/IrisMusicScylla2bMusicPlayer",
										},
									},
									{
										Path = { "ConfigOptionCache", "MusicVolume" },
										Comparison = ">",
										Value = 0.1,
									},
								},
							},
							{ Name = "Ghost_Agent25",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "RoomsEntered" },
										HasAny = { "Q_Boss01", "Q_Boss02" },
									},
								},
							},
							{ Name = "Ghost_Agent26",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "GameState", "RoomsEntered" },
										HasAll = { "I_Boss01", "Q_Boss01" },
									},
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent27",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Units = { "NPC_Icarus_01", } },
									},
								},
							},
							{ Name = "Ghost_Agent28",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "GameState", "CosmeticsPurchasedCountCache", "Total" },
										Comparison = ">=",
										Value = 18,
									},
								},
							},
							{ Name = "Ghost_Agent29",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Units = { "NPC_Eris_01", } },
									},
								},
							},
							{ Name = "Ghost_Agent30",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "CurrentRun", "EnemyKills", "TyphonHead" },
									},
								},
							},

							{ Name = "Ghost_Ranger01",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "ReachedTrueEnding" },
									},
									{
										Path = { "CurrentRun", "RoomsEntered" },
										HasAny = { "I_DeathAreaRestored", "I_Story01" }
									},
								},
							},
							{ Name = "Ghost_Ranger02",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "ReachedTrueEnding" },
									},
									{
										Path = { "GameState", "TextLinesRecord" },
										HasAny = { "NeoChronosAboutTartarus02", "NeoChronosAboutOlympus02" }
									},
								},
							},
							{ Name = "Ghost_Ranger03",
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Ranger04",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "GameState", "NextBiomeStateName" },
										IsAny = { "Rain" },
									},
									{
										PathTrue = { "GameState", "TextLinesRecord", "DemeterGift03" },
									},
								},
							},
							{ Name = "Ghost_Ranger05",
								PlayFirst = true,
								GameStateRequirements =
								{
									NamedRequirements = { "ReachedEpilogue" },
								},
							},
							{ Name = "Ghost_Ranger06",
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Ranger07",
								GameStateRequirements =
								{
									NamedRequirements = { "ReachedEpilogue" },
								},
							},
							{ Name = "Ghost_Ranger08",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Units = { "NPC_Selene_01", } },
									},
								},
							},
							{ Name = "Ghost_Ranger09",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "CurrentRun", "EnemyKills", "Zagreus" },
									},
								},
							},
							{ Name = "Ghost_Ranger10",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "CurrentRun", "RoomsEntered", "C_Boss01" },
									},
								},
							},
						},
					}
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "CurrentRun", "NumGhostGroupsActive" },
						Comparison = "<=",
						Value = 0,
					},
					ChanceToPlay = 0.85,
				},
			},
			-- subsequent runs (before taverna)
			{
				FunctionName = "GhostEavesdroppers",
				Args =
				{
					RandomGroups =
					{
						{ 590510, 590509, 590508, },
						{ 590511, 590512, 590507, },
						{ 590513, 590514, 590515, },
						{ 590880, 590882, 590879, },
						{ 743517, 743516, 743518, }
					},
					InspectPoint =
					{
						Name = "GhostInspectPoint",
						UseTextSpecial = "UseGhostEavesdropper",
						SpecialInteractFunctionName = "UseGhostEavesdropper",
						AgeOfDeath = 24,
						RandomLines =
						{
							{ Name = "Ghost_Agent01", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent02", },
							{ Name = "Ghost_Agent03", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent04", },
							{ Name = "Ghost_Agent05", },
							{ Name = "Ghost_Agent06", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent07", },
							{ Name = "Ghost_Agent08", },
							{ Name = "Ghost_Agent09", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent10", },
							{ Name = "Ghost_Agent11", },
							{ Name = "Ghost_Agent12", 
								GameStateRequirements =
								{
									{
										PathFalse = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
							{ Name = "Ghost_Agent13", },
							{ Name = "Ghost_Agent14", },
							{ Name = "Ghost_Agent15", },
							{ Name = "Ghost_Agent16", },
							{ Name = "Ghost_Agent17", },
							-- { Name = "Ghost_Agent18", },
							-- { Name = "Ghost_Agent19", },
							{ Name = "Ghost_Agent20", },
							{ Name = "Ghost_Agent21", },
							{ Name = "Ghost_Agent22", },
							{ Name = "Ghost_Agent23", },
							{ Name = "Ghost_Agent24", },

							{ Name = "Ghost_Scout03",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Units = { "NPC_Eris_01", } },
									},
								},
							},
							{ Name = "Ghost_Scout04",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
									},
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
								},
							},
							{ Name = "Ghost_Scout04a",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
									},
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
								},
							},
							{ Name = "Ghost_Scout05",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "RoomsEntered" },
										HasAny = { "Q_Boss01", "Q_Boss02" },
									},
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
								},
							},
							{ Name = "Ghost_Scout05a",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "RoomsEntered" },
										HasAny = { "Q_Boss01", "Q_Boss02" },
									},
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
									{
										PathFalse = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
									},
								},
							},
							{ Name = "Ghost_Scout06",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "CurrentRoom", "Name" },
										IsAny = { "P_Boss01" },
									},
								},
							},
							{ Name = "Ghost_Scout07",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Units = { "NPC_Moros_01", "NPC_Eris_01" }, },
									},
								},
							},
							{ Name = "Ghost_Scout08",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
									},
								},
							},
							{ Name = "Ghost_Scout09",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "GameState", "NextBiomeStateName" },
										IsAny = { "Rain" },
									},
								},
							},

						},
					}
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "NumGhostGroupsActive" },
						Comparison = "<=",
						Value = 0,
					},
					ChanceToPlay = 0.8,
				},

			},
			-- deep underworld shades
			{
				FunctionName = "GhostEavesdroppers",
				Args =
				{
					RandomGroups =
					{
						{ 590511, 590512, 743554, },
						{ 743547, 743549, 743548, },
						{ 743553, 743550, 743551, },
						{ 590880, 590882, 743555, },
					},
					InspectPoint =
					{
						Name = "GhostInspectPoint",
						UseTextSpecial = "UseGhostEavesdropper",
						SpecialInteractFunctionName = "UseGhostEavesdropper",
						RandomLines =
						{
							{ Name = "Ghost_Recruit01" },
							{ Name = "Ghost_Recruit02" },
							{ Name = "Ghost_Recruit03" },
							{ Name = "Ghost_Recruit04" },
							{ Name = "Ghost_Recruit05" },
							{ Name = "Ghost_Recruit06" },
							{ Name = "Ghost_Agent30" },
							{ Name = "Ghost_Ranger06",
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "ReachedTrueEnding" },
									},
								},
							},
						},
					}
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ExorcisedNames", "ShadeFieldsGreyIdle" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "ExorcisedNames", "ShadeClockworkIdle" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "NumGhostGroupsActive" },
						Comparison = "<=",
						Value = 0,
					},
					ChanceToPlay = 0.5,
					--[[
					{
						Path = { "CurrentRun", "ExorcisedNames", },
						HasAny =
						{
							"ShadeErebusIdle",
							"ShadeEphyraIdle",
							"ShadeOceanusSIdle",
							"ShadeFieldsGreyIdle",
							"ShadeClockworkIdle",
							"ShadeShipsOneIdle",
							"ShadeTyphonIdle",
						},
					},
					]]--
				},
			},

			-- Ghost Admirers / Ghost Groupies
			{
				FunctionName = "GhostFollowers",
				Args =
				{
					-- if this changes, need to adjust VO under 'for Ghost Groupies'
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

			-- Eris Graffiti
			{
				FunctionName = "GenericPresentation",
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "ErisUnlocked" },
				},
				Args =
				{
					SetAlpha = 0.0,
					Ids = { 800360, 800379, 800359, 800380, }, -- ErisGraffiti group
				},
			},
			-- Eris Bullets
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Eris_01" } },
					},
				},
				Args =
				{
					Groups = { "ErisBullets" },
				},
			},

			-- Hypnos Plushes
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				Args =
				{
					Ids = { 800616, 800612, 800648, 800647, },
				},
			},

			{
				FunctionName = "HideAmbientCritters",
			},

			-- Ambient Critters (Main Hub)
			-- first run
			{
				FunctionName = "ActivateAmbientCritters",
				Args =
				{
					MinGroupsToActivate = 7,
					MaxGroupsToActivate = 7,
					Groups =
					{
						-- Eris/Moros Area
						"Frogs_ArtemisLilies",
						"Birds_DeerStatue",
						-- "Birds_ArtemisAreaGround",
						-- "Birds_ErisRock",
						-- "Birds_NorthBroker",

						-- Hecate Cauldron Area
						"Birds_HecateTrees",
						"Birds_NorthCauldrons",
						-- "Birds_SouthCauldrons",

						-- Broker Area
						-- "Cats_Broker",
						-- "Frogs_DockNorth",
						"Frogs_DockSouth",
						-- "Dogs_NemesisTent",
						"Birds_CharonDock",

						-- Farm Area
						-- "Birds_NearHypnos",
						"Birds_HadesFountain",
						-- "Cats_NearHypnos",
						-- "Birds_FarmBench",
						-- "Birds_NearOdysseus",
						-- "Cats_NearPrerunDoor",
					},
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
					-- ChanceToPlay = 1.0,
				},
			},
			-- before toula
			{
				FunctionName = "ActivateAmbientCritters",
				Args =
				{
					MinGroupsToActivate = 6,
					MaxGroupsToActivate = 8,
					Groups =
					{
						-- Eris/Moros Area
						"Frogs_ArtemisLilies",
						"Birds_DeerStatue",
						"Birds_ArtemisAreaGround",
						"Birds_ErisRock",
						"Birds_NorthBroker",

						-- Hecate Cauldron Area
						"Birds_HecateTrees",
						"Birds_NorthCauldrons",
						"Birds_SouthCauldrons",

						-- Broker Area
						-- "Cats_Broker",
						"Frogs_DockNorth",
						"Frogs_DockSouth",
						-- "Dogs_NemesisTent",
						"Birds_CharonDock",

						-- Farm Area
						"Birds_NearHypnos",
						"Birds_HadesFountain",
						-- "Cats_NearHypnos",
						"Birds_FarmBench",
						"Birds_NearOdysseus",
						-- "Cats_NearPrerunDoor",
					},
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
					},
					-- ChanceToPlay = 1.0,
				},
			},
			-- after toula, no clear
			{
				FunctionName = "ActivateAmbientCritters",
				Args =
				{
					MinGroupsToActivate = 7,
					MaxGroupsToActivate = 9,
					Groups =
					{
						-- Eris/Moros Area
						"Frogs_ArtemisLilies",
						"Birds_DeerStatue",
						"Birds_ArtemisAreaGround",
						"Birds_ErisRock",
						"Birds_NorthBroker",

						-- Hecate Cauldron Area
						"Birds_HecateTrees",
						"Birds_NorthCauldrons",
						"Birds_SouthCauldrons",

						-- Broker Area
						"Cats_Broker",
						"Frogs_DockNorth",
						"Frogs_DockSouth",
						"Dogs_NemesisTent",
						"Birds_CharonDock",

						-- Farm Area
						"Birds_NearHypnos",
						"Birds_HadesFountain",
						"Cats_NearHypnos",
						"Birds_FarmBench",
						"Birds_NearOdysseus",
						"Cats_NearPrerunDoor",
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
					},
					-- ChanceToPlay = 1.0,
				},
			},
			-- Ambient Critters (Spawn Area)
			{
				FunctionName = "ActivateAmbientCritters",
				Args =
				{
					MinGroupsToActivate = 1,
					MaxGroupsToActivate = 2,
					Groups =
					{
						"Birds_MelSpawnEast",
						"Birds_MelSpawnWest",
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Cleared" },
					},
					ChanceToPlay = 0.75,
				},
			},
			-- Ambient Critters (Taverna)
			{
				FunctionName = "ActivateAmbientCritters",
				Args =
				{
					MinGroupsToActivate = 1,
					MaxGroupsToActivate = 2,
					Groups =
					{
						"Cats_Taverna",
						"Birds_TavernaSouthEast",
						"Birds_WestTaverna",
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					ChanceToPlay = 0.75,
				},
			},
			-- Ambient Critters (Fishing)
			{
				FunctionName = "ActivateAmbientCritters",
				Args =
				{
					MinGroupsToActivate = 1,
					MaxGroupsToActivate = 3,
					Groups =
					{
						"Frogs_FishingPier",
						"Cats_FishingPier",
						"Birds_FishingPierCrates",
						"Birds_FishingPierBarrels",
						"Birds_FishingPierGate",
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					ChanceToPlay = 0.5,
				},
			},
			-- Ambient Critters (Bathhouse)
			{
				FunctionName = "ActivateAmbientCritters",
				Args =
				{
					MinGroupsToActivate = 1,
					MaxGroupsToActivate = 1,
					Groups =
					{
						"Birds_Bathhouse",
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					ChanceToPlay = 0.33,
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
				FunctionName = "RestoreMusicianMusic",
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathFalse = { "CurrentRun", "PlayedTrueEnding" },
							},
						},
						{
							{
								PathTrue = { "PreviousDeathAreaRoom" },
							},
						},
					},
				},
			},
			{
				FunctionName = "CheckConversations",
				Args =
				{
					CheckNoConversationFunctions = true,
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				FailedFunctionName = "CheckConversations",
				FailedFunctionArgs =
				{
					CheckNoConversationFunctions = true,
					PlayOnceFlag = "AllowPostBounty",
				},
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
						{ Id = 585633, OffsetRadius = 50 },
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
									{ Id = 800764, OffsetRadius = 50 },
									{ Id = 800765, OffsetRadius = 50 },
									{ Id = 800766, OffsetRadius = 50 },
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
									{ Id = 585623, OffsetRadius = 50,  },
									{ Id = 585624, OffsetRadius = 50, PostArriveWait = 2, EmoteOnEndChance = 0.3, },
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
									{ Id = 800767, OffsetRadius = 50 },
									{ Id = 585637, OffsetRadius = 50 },
								},
								{
									-- Branch Option B
									{ Id = 800769, OffsetRadius = 50 },
								},
							},
						},
					},
				},
			},
			--[[ fountain of the dead patrol path
			{
				FunctionName = "PatrolPath",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					SpawnTypes = { "ShadeHubMIdle01" },
					MaxPatrols = 1,
					SendPatrolInterval = 4,
					SpeedMin = 45,
					SpeedMax = 60,
					ScaleMin = 0.8,
					ScaleMax = 0.9,
					FadeInDuration = 0.5,
					Loop = true,
					Path =
					{
						{ Id = 743562, OffsetRadius = 50, PostArriveWait = 8, AngleTowardIdOnStop = 567390 },
						{ Id = 743559, OffsetRadius = 50 },
						{ Id = 743558, OffsetRadius = 50 },
						{ Id = 743557, OffsetRadius = 50 },
						{ Id = 743556, OffsetRadius = 50 },
						{ Id = 743563, OffsetRadius = 50, PostArriveWait = 8, EmoteOnEndChance = 0.3, AngleTowardIdOnStop = 743214, EmoteOnEnd = "Fear" },
						{ Id = 743564, OffsetRadius = 50 },
						{ Id = 743557, OffsetRadius = 50 },
						{ Id = 743558, OffsetRadius = 50 },
						{ Id = 743559, OffsetRadius = 50 },
					},
				},
			},
			]]--
			--[[ taverna patrol path
			{
				FunctionName = "PatrolPath",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
				},
				Args =
				{
					SpawnTypes = { "ShadeHubSIdle01", "ShadeHubSIdle01", "ShadeHubHatIdle01" },
					MaxPatrols = 3,
					SendPatrolInterval = 8,
					SpeedMin = 45,
					SpeedMax = 60,
					ScaleMin = 0.7,
					ScaleMax = 0.8,
					FadeInDuration = 1.0,
					Loop = true,
					Path =
					{
						{ Id = 743570, OffsetRadius = 50 },
						{ Id = 743571, OffsetRadius = 50 },
						{ Id = 743572, OffsetRadius = 50 },
						{ Id = 743565, OffsetRadius = 50 },
						{ Id = 743566, OffsetRadius = 50 },
						{ Id = 743567, OffsetRadius = 50 },
						{ Id = 743568, OffsetRadius = 50 },
						{ Id = 743569, OffsetRadius = 50 },
					},
				},
			},
			]]--
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
			743477, -- Artemis Singing
			743473, -- Hecate Absent
			743472, -- Eris
			743475, -- Hades Fountain
		},
		-- Hub_Main InspectPoints / Inspect Points
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
							PreLineAngleHeroTowardTargetId = 575836,
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 560708, }, Alive = false },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "InspectHomerReveal01" }, Min = 1 },
					},
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
					{
						PathFalse = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsHypnos01 =
					{
						{ Cue = "/VO/Storyteller_0340",
							Text = "{#Emph}The embodiment of Sleep dozes interminably in a private little grove, visited on occasion by the Princess of the Underworld whenever she requires time to think and plan." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,

							{ Cue = "/VO/Melinoe_4070", Text = "Or just to check on him." },
						},
					},
				},
			},

			-- Inspect: Hypnos Gift
			[800722] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				InteractTextLineSets =
				{
					InspectHypnosGift01 =
					{
						{ Cue = "/VO/Storyteller_0502",
							Text = "{#Emph}Having vacated the Crossroads in all haste, the until-recently-long-dormant incarnate of Sleep delivered certain articles in show of gratitude, and... perhaps more..." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,

							{ Cue = "/VO/Melinoe_5435", Text = "I ended his dreams, and in a way, he ended mine." },
						},
					},
				},
			},

			-- Inspect: Hades Fountain / Fountain of the Dead
			[743475] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				InteractTextLineSets =
				{
					InspectHadesFountain01 =
					{
						{ Cue = "/VO/Storyteller_0341",
							PreLineAngleHeroTowardTargetId = 743214,
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}A finely-chiseled countenance of the Underworld's unseated king instills a sense of quiet contemplation and resolve in whosoever dares to meet those stone unseeing eyes." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							Cooldowns =
							{
								{ Name = "MelinoeSaluteSpeech", Time = 5 },
							},
							{ Cue = "/VO/Melinoe_4071", Text = "Watch over me, Father..." },
						},
					},
				},
			},

			-- Inspect: Hades Fountain / Fountain of the Dead (StoryReset)
			[800770] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStoryReset" },
					},
				},
				InteractTextLineSets =
				{
					InspectHadesFountain02 =
					{
						{ Cue = "/VO/Storyteller_0526",
							PreLineAngleHeroTowardTargetId = 743214,
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
							PostLineFunctionName = "SetupStoryResetObject",
							Text = "{#Emph}There are no second chances in this world. The Titan Chronos once intoned that there is no undoing past mistakes... mere fleeting possibilities, lost to Time." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_5764", Text = "Possibilities that could have been..." },
							-- { Cue = "/VO/Melinoe_5762", Text = "My task..." },
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 590880, 590879, 590882, }, Alive = false },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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

			-- Inspect: Eris herself
			[743472] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						Path = { "GameState", "RoomsEntered", "O_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "ErisFoughtAgainstHer01", "ErisWithHecate01" }, },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 585573, }, },
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsEris01 =
					{
						{ Cue = "/VO/Storyteller_0345",
							PreLineAngleHeroTowardTargetId = 590215,
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}On black wings does the uncontrollable embodiment of Strife go wheresoever she may please, and lately, that is often in the Princess of the Underworld's way." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								{ Cue = "/VO/Melinoe_4075", Text = "Cheers, Eris..." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Eris_01",
								{ Cue = "/VO/Eris_0133", Text = "{#Emph}Huh?" },
							},
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 560612 }, Alive = false },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 557112, }, },
					},
					{
						PathFalse = { "SessionMapState", "OdysseusAtTaverna" }
					},
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
								RequiredSourceValueFalse = "InPartnerConversation",
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
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "NemesisWithMoros01", "NemesisWithMoros02", "NemesisWithMoros03", "NemesisWithHypnos01", "NemesisWithHecate01", "NemesisWithHecate02", "NemesisWithEris01", "NemesisWithEris02" }, },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 557113, }, },
					},
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
								RequiredSourceValueFalse = "InPartnerConversation",

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
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "MorosWithOdysseus01", "MorosWithHypnos01" }, },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 560612, }, },
					},
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
								RequiredSourceValueFalse = "InPartnerConversation",

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
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "DoraWithMoros01", "DoraWithMoros02" }, },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 566832, }, },
					},
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
								{ Cue = "/VO/Melinoe_1689", Text = "Dora does need to get out more often..." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Dora_01",
								RequiredSourceValueFalse = "InPartnerConversation",

								{ Cue = "/VO/Dora_0118", Text = "Not happening." },
							},
						},
					},
				},
			},

			-- Inspect: Hecate Corner
			[743473] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HecateHideAndSeek01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 }, Alive = false },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
				InteractTextLineSets =
				{
					InspectCrossroadsHecate01 =
					{
						{ Cue = "/VO/Storyteller_0344",
							Text = "{#Emph}Numerous are the responsibilities of Hecate, Witch of the Crossroads, unseen watcher between realms, and keeper of the key to pathways hidden even to immortal eyes." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4074", Text = "And our Headmistress." },
							},
						},
					},
				},
			},

			-- Inspect: Crossroads Beasts
			[743479] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_AmbientDogs" },
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsBeasts01 =
					{
						{ Cue = "/VO/Storyteller_0346",
							Text = "{#Emph}The faithful animal attendants of the Witch of the Crossroads oft inspire other beasts to seek the shelter and the solace of this refuge between realms." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4076", Text = "We've much to learn from beasts." },
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
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 558096, }, },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				InteractTextLineSets =
				{
					InspectBroker01 =
					{
						{ Cue = "/VO/Storyteller_0129",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}After ever-scheming Chronos claimed the House of Hades, Shades of the dead residing there all scattered to the ends of the earth." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							Cooldowns =
							{
								{ Name = "SaidWelcomeHereRecently", Time = 180 },
							},
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 589466, }, },
					},
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
							RequiredMinElapsedTime = 3,
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 589467, }, },
					},
				},
				InteractTextLineSets =
				{
					InspectRecordKeeper01 =
					{
						{ Cue = "/VO/Storyteller_0239",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}Once there was an administrative chamber in the Underworld, where Shades kept careful track of each detail; a trade a few such souls as yet pursue." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_2962", Text = "Surely such efforts were rewarded handsomely.", PostLineFunctionName = "RecordKeeperReaction" },
						},
					},
				},
			},

			-- Inspect: Music Player
			[738760] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectTaverna01" }
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 738510, }, },
					},
				},
				InteractTextLineSets =
				{
					InspectMusicMaker01 =
					{
						{ Cue = "/VO/Storyteller_0301",
							PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelinoeIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}The gift of music, bestowed to mortals by shining Apollo himself, has the capacity to stir the soul like nothing else; regardless if the soul is of the living or the dead." },
						EndVoiceLines =
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							RequiredMinElapsedTime = 3,
							{ Cue = "/VO/Melinoe_3750", Text = "Well then let's stir some souls!", PostLineFunctionName = "MusicMakerReaction"
							},
						},
					},
				},
			},

			-- Inspect: Singing Grove
			[743474] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 561502 }, Alive = false },
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsClearing01 =
					{
						{ Cue = "/VO/Storyteller_0342",
							Text = "{#Emph}The Moon oft shines particularly bright in one fair corner of the Crossroads, where the Princess of the Underworld may always clear her thoughts and have a moment's peace." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4072", Text = "And listen to the frogs." },
							},
						},
					},
				},
			},
			-- Inspect: Artemis
			[743477] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArtemisHubSinging01" },
					},
					{
						Path = { "AudioState", "AmbientTrackName" },
						IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
					},
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.1,
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 561502 }, },
					},
				},
				InteractTextLineSets =
				{
					InspectCrossroadsArtemis01 =
					{
						{ Cue = "/VO/Storyteller_0343",
							PreLineAngleHeroTowardTargetId = 742272,
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}The sonorous voice of the goddess of the hunt fills the clearing like a ray of moonlight, stirring the eternal souls of Shades that there reside." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4073", Text = "She's not bad, is she?" },
							},
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
							Text = "{#Emph}A small spring draws its heat from deep within the Earth, its waters so pristine and pure that they can cleanse the body and the soul." },
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

			-- Olympus SunMoonTimeSculpture
			[800667] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Icarus_01" }, Alive = false },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				InteractTextLineSets =
				{
					InspectSunMoonTimeSculpture01 =
					{
						{ Cue = "/VO/Storyteller_0497",
							PreLineAngleHeroTowardTargetId = 575836,
							PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
							PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
							Text = "{#Emph}The sun and moon: two sides forming a whole, a newfound symbol of the union 'twixt Olympus and the Underworld, and a gift to the Crossroads from the gods themselves." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 2,
								{ Cue = "/VO/Melinoe_5168", Text = "Lord Hephaestus must have crafted this himself." },
							},
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
				AnimOffsetZ = 280,
				EmoteOffsetZ = 85, -- keep in sync with DistanceTriggers below
				InteractDistance = 250,
				InteractOffsetX = 40,
				InteractOffsetY = -35,
				UseText = "UseMarket",
				UseTextTalkAndSpecial = "UseMarketAndSpecial",
				OnUsedFunctionName = "UseMarketObject",

				SetupEvents =
				{
					{
						FunctionName = "GenerateMarketItems",
						Args = { RefreshOncePerRun = true },
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
					{ GlobalVoiceLines = "SaluteVoiceLines" },
				},

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
							AnimationName = "StatusIconEmbarrassed",
							Group = "Combat_UI_Backing",
							OffsetZ = 85, -- keep in sync with EmoteOffsetZ above
							BlockIfSourceHasStatusAnimation = true,
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
				UseTextTalkAndSpecial = "GameStatsScreen_UseAndSpecial",
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
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.33,
						Cooldowns =
						{
							{ Name = "MelinoeSaluteSpeech", Time = 4 },
						},

						{ Cue = "/VO/Melinoe_3009", Text = "Record Keeper." },
						{ Cue = "/VO/Melinoe_3010", Text = "Hail, Keeper." },
						{ Cue = "/VO/Melinoe_3011", Text = "Greetings, Record Keeper." },
					},
					{ GlobalVoiceLines = "SaluteVoiceLines" },
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
						},
					},
				}
			},

			-- RunHistoryScreen / Historian / Sage / Security Log
			[589466] =
			{
				Name = "RunHistoryScreen",
				AnimOffsetZ = 150,
				EmoteOffsetZ = 80,
				Activate = true,
				SkipDefaultSetup = true, -- Handled by WorldUpgrade
				InteractDistance = 250,

				UseText = "RunHistoryScreen_Use",
				UseTextTalkAndSpecial = "RunHistoryScreen_UseAndSpecial",
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
					{ GlobalVoiceLines = "SaluteVoiceLines" },
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
							OffsetZ = 80,
						},
					},
				}

			},

			-- MusicPlayer / Bard Shade
			[738510] =
			{
				Name = "MusicPlayerScreen",
				AnimOffsetZ = 270,
				EmoteOffsetZ = 50,
				Activate = true,
				SkipDefaultSetup = true, -- Handled by WorldUpgrade
				InteractDistance = 250,

				UseText = "MusicPlayerScreen_Use",
				UseTextTalkAndSpecial = "MusicPlayerScreen_UseAndSpecial",
				OnUsedFunctionName = "UseMusicPlayerScreenObject",
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMusicPlayer" },
					},
				},

				SetupEvents =
				{
					{
						FunctionName = "MusicPlayerPlaySongPresentation",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "MusicPlayerSongName" },
							},
							{
								Path = { "CurrentRun", "SuppressAmbientMusic" },
								Comparison = "!=",
								Value = "MusicPlayer",
							},
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant" },
						GameStateRequirements =
						{
							{
								FunctionName = "HasUnviewedMusicPlayerSong",
							},
						},
					},
				},

				SaluteSound = "/SFX/GhostEmotes/DisgruntledTINY",
				SpecialInteractFunctionName = "SpecialInteractSaluteBroker",
				SpecialInteractGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "MusicPlayer" },
					},
				},
				SpecialInteractCooldown = 60,
				InteractVoiceLines =
				{
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.25,
						Cooldowns =
						{
							{ Name = "MelinoeSaluteSpeech", Time = 4 },
							{ Name = "MelinoeMusicMakerSaluteSpeech", Time = 5 }
						},

						{ Cue = "/VO/Melinoe_3845", Text = "Apollo would be proud!" },
						{ Cue = "/VO/Melinoe_3846", Text = "Salutations, Music Maker.", PlayFirst = true },
						{ Cue = "/VO/Melinoe_3677", Text = "Play on, Music Maker." },
					},
					{ GlobalVoiceLines = "SaluteVoiceLines" },
				},
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
								FunctionName = "ShouldShowMailboxWantsToTalkIndicator",
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
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Ids = { 558096 }, },
									},
								},
							},
							{
								Cue = "/VO/Melinoe_0827", Text = "Something there.", PlayFirst = true,
								GameStateRequirements =
								{
									{
										FunctionName = "RequiredAlive",
										FunctionArgs = { Ids = { 558096 }, Alive = false },
									},
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
							SuccessiveChanceToPlay = 0.5,
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
								-- Artemis not present for singing
								PathFalse = { "CurrentRun", "ArtemisHubSong" },
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
				Using =
				{
					Animations = {
						"CrossroadsCauldronLid01",
						"Tilesets\\Crossroads\\Crossroads_Cauldron_Lid_01a",
						"Tilesets\\Crossroads\\Crossroads_Cauldron_Lid_01b",
					}
				}
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
			-- Hecuba
			[558710] =
			{
				Name = "CrossroadsPet01",
				InteractDistance = 200,
				UseText = "UsePet01",
				SetupGameStateRequirements =
				{
					NamedRequirements = { "HecateFamiliarsInHub" },
				},
				Activate = true,
				-- DestroyIfNotSetup = true,
				-- ShakeSelf = true,
				-- OnUsedGlobalVoiceLines = "TakeANapVoiceLines",
				OnUsedFunctionName = "UseCrossroadsPet01",
			},
			-- Gale
			[558691] =
			{
				SetupGameStateRequirements =
				{
					NamedRequirements = { "HecateFamiliarsInHub" },
				},
				Activate = true,
				-- DestroyIfNotSetup = true,
				SetupEvents =
				{
					{
						FunctionName = "GenericPresentation",
						Args = { UseableOff = true },
					},
				},
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
								{
									FunctionName = "RequiredAlive",
									FunctionArgs = { Ids = { 558710 }, Alive = false },
								},
								{
									Path = { "GameState", "FamiliarsUnlocked" },
									HasNone = { "HoundFamiliar", "PolecatFamiliar" },
								},
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
				AnimOffsetX = 60,
				AnimOffsetZ = 310,
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
							{
								PathFalse = { "ActiveScreens", "QuestLog" },
							},
							{
								FunctionName = "RequireQuestWithStatus",
								FunctionArgs = { Status = "Complete", },
							},
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

			-- Nemesis Bird / Raven
			[741471] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 557113, }, },
					},
				},
			},

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
			-- Hecate Witches near Cauldron
			[575859] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 } },
					},
				},
			},
			[575867] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 } },
					},
				},
			},
			[575860] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 } },
					},
				},
			},
			[575866] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 } },
					},
				},
			},
			-- Eris Guards at Fishing Pier
			[590500] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 585573 }, Alive = false },
					},
				},
			},
			[590499] =
			{
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 585573 }, Alive = false },
					},
				},
			},

			-- Hotsprings / Hot Springs
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 }, },
					},
				},
				DestroyIfNotSetup = true,
			},
			[576155] =
			{
				Name = "HecateTorch2",
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 556921 }, },
					},
				},
				DestroyIfNotSetup = true,
			},

			[800612] =
			{
				Name = "HypnosGiftTrigger01",
				DistanceTriggers =
				{
					{
						WithinDistance = 650,
						VoiceLines =
						{
							PlayOnce = true,
							UsePlayerSource = true,
							PreLineWait = 0.5,
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
								},
								{
									PathFalse = { "CurrentRun", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
								},
								{
									PathFalse = { "GameState", "TextLinesRecord", "InspectHypnosGift01" },
								},
							},
							SkipCooldownCheckIfNonePlayed = true,
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},

							{ Cue = "/VO/Melinoe_5434", Text = "Something where Hypnos used to be..." },
						},
					},
				},
			},

			-- Exit to Hub_PreRun (from Hub_Main)
			[391697] =
			{
				Name = "PreRunExit",
				OnUsedGameStateRequirements =
				{
					{
						PathFromSource = true,
						PathFalse = { "BlockedByNarrative" },
					},
				},
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "Hub_PreRun", HeroStartPoint = 40009, HeroEndPoint = 40012, },

				SetupEvents =
				{
					{
						GameStateRequirements =
						{
							OrRequirements =
							{
								-- block the exit for key Hecate events
								{
									{
										FunctionName = "RequiredQueuedTextLine",
										FunctionArgs = { IsAny = GameData.BlockPreRunExitDoorEvents },
									},
								},
								-- block the exit if the TimeStop incantation is affordable and not yet purchased
								{
									{
										FunctionName = "RequireAffordableGhostAdminItems",
										FunctionArgs =
										{
											CategoryIndex = 1,
											HasAny = { "WorldUpgradeTimeStop" },
										},
									},
								},
							},
						},
						FunctionName = "BlockHubExitForNarrative",
						Args =
						{
							DistanceTrigger =
							{
								NotifyName = "BlockHubExitForNarrativeTrigger",
								WithinDistance = 250,
								Repeat = true,
								VoiceLines =
								{
									UsePlayerSource = true,
									RandomRemaining = true,
									Cooldowns =
									{
										{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
										{ Name = "MelinoeAttemptLeaveSpeech", Time = 8 },
									},
									TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

									{ Cue = "/VO/Melinoe_4746", Text = "I have an incantation to complete...",
										GameStateRequirements =
										{
											{
												FunctionName = "RequireAffordableGhostAdminItems",
												FunctionArgs =
												{
													CategoryIndex = 1,
													HasAny = { "WorldUpgradeTimeStop" },
												},
											},
										}
									},
									{ Cue = "/VO/Melinoe_4747", Text = "The Cauldron first.",
										GameStateRequirements =
										{
											{
												FunctionName = "RequireAffordableGhostAdminItems",
												FunctionArgs =
												{
													CategoryIndex = 1,
													HasAny = { "WorldUpgradeTimeStop" },
												},
											},
										}
									},
									{ Cue = "/VO/Melinoe_4743", Text = "Should speak with Headmistress before I go...", PlayFirst = true,
										GameStateRequirements =
										{
											{
												FunctionName = "RequiredQueuedTextLine",
												FunctionArgs = { IsAny = GameData.BlockPreRunExitDoorEvents },
											},
										},
									},
									{ Cue = "/VO/Melinoe_4744", Text = "Should talk to Headmistress...",
										GameStateRequirements =
										{
											{
												FunctionName = "RequiredQueuedTextLine",
												FunctionArgs = { IsAny = GameData.BlockPreRunExitDoorEvents },
											},
										},
									},
									{ Cue = "/VO/Melinoe_4745", Text = "Need to speak with Headmistress.",
										GameStateRequirements =
										{
											{
												FunctionName = "RequiredQueuedTextLine",
												FunctionArgs = { IsAny = GameData.BlockPreRunExitDoorEvents },
											},
										},
									},
								},
							},
						},
					}
				},

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
				Using = { Sound = { "/Leftovers/SFX/BigFishSplash", }, },
			},
			-- deer clearing
			[742272] =
			{
				Name = "DeerStatue01",
				DistanceTriggers =
				{
					{
						WithinDistance = 300,
						VoiceLines =
						{
							BreakIfPlayed = true,
							RandomRemaining = true,
							UsePlayerSource = true,
							PreLineWait = 0.3,
							SuccessiveChanceToPlay = 0.25,
							SuccessiveChanceToPlayAll = 0.25,
							GameStateRequirements =
							{
								{
									FunctionName = "RequiredAlive",
									FunctionArgs = { Ids = { 561502 }, Alive = false },
								},
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},

							{ Cue = "/VO/Melinoe_0569", Text = "{#Emph}<Inhale>", PlayFirst = true },
							{ Cue = "/VO/Melinoe_4035", Text = "{#Emph}<Humming>",
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" }
									},
								},
							},
							{ Cue = "/VO/Melinoe_4036", Text = "{#Emph}<Humming>",
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" }
									},
								},
							},
							{ Cue = "/VO/Melinoe_4037", Text = "{#Emph}...Moonlight guide us home tonight...",
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" }
									},
								},
							},
							{ Cue = "/VO/Melinoe_4038", Text = "{#Emph}...In shadow all are one...",
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "ArtemisHubSinging01" }
									},
								},
							},
						},
					},
					-- artemis singing
					{
						WithinDistance = 900,
						VoiceLines =
						{
							RandomRemaining = true,
							UsePlayerSource = true,
							PreLineWait = 0.5,
							SuccessiveChanceToPlayAll = 0.33,
							SkipCooldownCheckIfNonePlayed = true,
							GameStateRequirements =
							{
								{
									Path = { "AudioState", "AmbientTrackName" },
									IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
								},
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},

							{ Cue = "/VO/Melinoe_4026", Text = "Artemis...", PlayFirst = true },
							{ Cue = "/VO/Melinoe_4027", Text = "Hey..." },
							{ Cue = "/VO/Melinoe_5178", Text = "The song from our flight...",
								PlayFirst = true,
								GameStateRequirements =
								{
									{
										Path = { "AudioState", "AmbientTrackName" },
										IsAny = { "/Music/IrisEndThemeCrossroads_MC" },
									},
								},
							},
						},
					},
				},
			},
			-- Hades Fountain / Fountain of the Dead
			[742624] =
			{
				Name = "CrossroadsFountainWall01",
				UseTextSpecial = "NPCUseTextSpecial",
				UseTextTalkAndSpecial = "UseStoryResetAndSpecial",
				UseText = "UseStoryReset",
				SpecialInteractFunctionName = "UseHadesFountain",
				SpecialInteractCooldown = 30,
				InteractDistance = 200,
				InteractOffsetX = -50,
				InteractOffsetY = -50,
				Activate = true,
				DistanceTriggers =
				{
					{
						WithinDistance = 450,
						ScaleY = 0.75,
						VoiceLines =
						{
							PlayOnce = true,
							PlayOnceContext = "HadesFountainVO",
							UsePlayerSource = true,
							PreLineWait = 0.5,
							GameStateRequirements =
							{
								{
									FunctionName = "RequiredAlive",
									FunctionArgs = { Units = { "NPC_Icarus_01" }, Alive = false },
								},
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},

							{ Cue = "/VO/Melinoe_2938_B", Text = "Father..." },
						},
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
					},
					{
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeStoryReset" },
							},
						},
						FunctionName = "SetupStoryResetObject",
					},
				},
			},
			-- fountain bench
			[741514] =
			{
				InteractDistance = 110,
				InteractOffsetY = -50,
				UseText = "UseChair",
				ShakeSelf = true,
				UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseLockedSystemObjectPresentation",
				OnUsedFunctionArgs = { VoiceLines = "TriedToSitVoiceLines", LinkedIds = { 741514 } },
			},
			-- aquarium
			[738444] =
			{
				Name = "Aquarium",
				UseText = "UseAquarium",
				InteractDistance = 150,
				InteractOffsetY = -20,
				-- UseSound = "/Leftovers/World Sounds/CaravanCreak",
				OnUsedFunctionName = "UseAquariumPresentation",
			},
			-- True Ending Cosmetic / SunMoonTimeSculpture
			[800527] =
			{
				Name = "CrossroadsSunMoonSculpture01",
				UseText = "UseSkellyStatue",
				OnUsedFunctionName = "UseSunMoonTimeSculpture",
				InteractDistance = 150,
				InteractOffsetX = -200,
				InteractOffsetY = -100,
				DistanceTriggers =
				{
					{
						WithinDistance = 850,
						ScaleY = 0.75,
						VoiceLines =
						{
							PlayOnce = true,
							PlayOnceContext = "OlympusStatueVO",
							UsePlayerSource = true,
							PreLineWait = 0.3,
							GameStateRequirements =
							{
								{
									FunctionName = "RequiredAlive",
									FunctionArgs = { Units = { "NPC_Icarus_01" }, Alive = false },
								},
								{
									PathTrue = { "GameState", "ReachedTrueEnding" },
								},
							},
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 3 },
							},

							{ Cue = "/VO/Melinoe_5167", Text = "Our gift from Olympus looks good by Father's fountain..." },
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
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "TextLinesRecord" },
									HasAny = { "HecateHideAndSeek03", "FatesEpilogue01" },
								},
								{
									FunctionName = "RequiredAlive",
									FunctionArgs = { Ids = { 556921 }, Alive = false },
								},
							},

							{ Cue = "/VO/Melinoe_1727", Text = "Where are you, Headmistress..." },
						},
					},
				},
			},

			-- Dora Point
			[800388] =
			{
				Name = "DoraPoint01",
				DistanceTriggers =
				{
					{
						Repeat = true,
						WithinDistance = 400,
						VoiceLines =
						{
							UsePlayerSource = true,
							PlayOnce = true,
							PreLineWait = 0.3,
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeDoraMemory" },
								},
							},
							{ Cue = "/VO/Melinoe_5723", Text = "Dora's gone... just needs a little time." },
						},
					},
				},
			},

			-- Hypnos Point
			[800742] =
			{
				Name = "HypnosPoint01",
				DistanceTriggers =
				{
					{
						WithinDistance = 500,
						VoiceLines =
						{
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "TextLinesRecord", "TrueEndingFinale01" },
								},
							},
							{ Cue = "/VO/Melinoe_5681", Text = "Still asleep..." },
						},
					},
				},
			},

			-- Icarus Bridge
			[743162] =
			{
				Name = "IcarusBridge01",
				DistanceTriggers =
				{
					{
						WithinDistance = 1050,
						VoiceLines =
						{
							UsePlayerSource = true,
							PlayOnceFromTableThisRun = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "TextLinesRecord", "TrueEndingFinale01" },
								},
								{
									PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
								},
								{
									FunctionName = "RequiredAlive",
									FunctionArgs = { Units = { "NPC_Icarus_01" }, Alive = false },
								},
							},
							{ Cue = "/VO/Melinoe_5163", Text = "{#Emph}Oh{#Prev}, where's Icarus...?" },
						},
					},
				},
			},

			-- Ghosts / Shades
			-- bartender shade / Badge Seller / BadgeSeller
			[590506] =
			{
				Name = "BartenderShade01",
				SetupGameStateRequirements =
				{
					--
				},
				DestroyIfNotSetup = true,
				InteractDistance = 200,
				AnimOffsetZ = 355,
				EmoteOffsetZ = 150,

				Using = { AdditionalAnimation = "GodHoodRays", Sounds = { "/SFX/Menu Sounds/WeaponUnlockBoom", "/SFX/ScyllaCrowdApplause2" }, },

				SetupEvents =
				{
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant" },
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding", },
							},
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBadgeSeller" },
							},
							{
								PathFalse = { "GameState", "BadgeRank", },
							}
						},
					},
				},

				ShowUseButtonEvents =
				{
					{
						FunctionName = "BadgeSellerSetupUseText",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding", },
							},
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBadgeSeller" },
							}
						},
					},
				},

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
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.33,
						Cooldowns =
						{
							{ Name = "MelinoeSaluteSpeech", Time = 4 },
						},
						{ Cue = "/VO/Melinoe_3003", Text = "Hail, Spirit Mixer.", PlayFirst = true },
						{ Cue = "/VO/Melinoe_3004", Text = "Cheers, Mixer." },
						{ Cue = "/VO/Melinoe_3005", Text = "Good evening, Mixer." },
						{ Cue = "/VO/Melinoe_5336", Text = "Salutations to the Unseen!",
							PlayFirst = true,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "BadgeRank" },
									Comparison = ">=",
									Value = 1,
								},
							},
						},
						{ Cue = "/VO/Melinoe_5337", Text = "To the restoration of the Underworld!",
							PlayFirst = true,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "BadgeRank" },
									Comparison = ">=",
									Value = 10,
								},
							},
						},
						{ Cue = "/VO/Melinoe_5339", Text = "By my father's name!",
							PlayFirst = true,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "BadgeRank" },
									Comparison = ">=",
									Value = 20,
								},
							},
						},
						{ Cue = "/VO/Melinoe_5338", Text = "May Night's will be done!",
							PlayFirst = true,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "BadgeRank" },
									Comparison = ">=",
									Value = 30,
								},
							},
						},
					},
					{ GlobalVoiceLines = "SaluteVoiceLines" },
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

			-- Taverna Celebration
			[800741] =
			{
				Name = "TavernaCelebration",
				DistanceTriggers =
				{
					{
						TriggerOnceThisRun = true,
						WithinDistance = 800,
						FunctionName = "TavernaClearedRunPresentation",
						GameStateRequirements =
						{
							OrRequirements =
							{
								{
									{
										PathTrue = { "CurrentRun", "Cleared" },
									},
								},
								{
									{
										PathTrue = { "CurrentRun", "TextLinesRecord", "FatesEpilogue01" },
									},
								},
							},
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

			-- Dream Hypnos
			[741118] =
			{
				Name = "DreamHadesTheme",
				DistanceTriggers =
				{
					{
						WithinDistance = 600,
						PostTriggerFunctionName = "PlayHadesTheme",
					}
				}
			},
			[738827] =
			{
				Name = "DreamHypnos01",
				DistanceTriggers =
				{
					{
						WithinDistance = 1100,
						LockToCharacter = true,
						VoiceLines =
						{
							{
								PlayOnce = true,
								BreakIfPlayed = true,
								UsePlayerSource = true,
								PreLineWait = 0.35,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp01" }
									},
								},

								{ Cue = "/VO/Melinoe_3683", Text = "Still fast asleep... even here?" },
							},
							{
								{
									PlayOnce = true,
									BreakIfPlayed = true,
									UsePlayerSource = true,
									PreLineWait = 0.35,
									GameStateRequirements =
									{
										{
											PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp01" }
										},
									},

									{ Cue = "/VO/Melinoe_4640", Text = "Not moved at all. Let's see if this works..." },
								},
								{
									PlayOnce = true,
									PlayOnceContext = "HypnosDream2VO",
									BreakIfPlayed = true,
									ObjectType = "NPC_Hypnos_02",
									PreLineWait = 1.0,
									GameStateRequirements =
									{
										{
											PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp01" }
										},
									},

									{ Cue = "/VO/Hypnos_0021", Text = "{#Emph}<Sigh>" },
								},

							},
							{
								{
									PlayOnce = true,
									UsePlayerSource = true,
									PreLineWait = 0.35,
									GameStateRequirements =
									{
										{
											PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp03" }
										},
									},

									{ Cue = "/VO/Melinoe_4709", Text = "And there he is..." },
								},
								{
									PlayOnce = true,
									BreakIfPlayed = true,
									ObjectType = "NPC_Hypnos_02",
									PreLineWait = 0.35,
									GameStateRequirements =
									{
										{
											PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp03" }
										},
									},

									{ Cue = "/VO/Hypnos_0032", Text = "{#Emph}Zzz... welcome tooo..." },
								},
							},

						}
					}
				}
			},

			[799541] =
			{
				Name = "DreamBattie01",
				DistanceTriggers =
				{
					{
						WithinDistance = 600,
						VoiceLines =
						{
							{
								PlayOnce = true,
								BreakIfPlayed = true,
								UsePlayerSource = true,
								PreLineWait = 0.35,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp02" }
									},
								},

								{ Cue = "/VO/Melinoe_4644", Text = "What are all these things...?" },
							},
						},
					}
				}
			},

			[780928] =
			{
				Name = "DreamHypnos02",
				DistanceTriggers =
				{
					{
						WithinDistance = 910,
						LockToCharacter = true,
						VoiceLines =
						{
							{
								PlayOnce = true,
								UsePlayerSource = true,
								PreLineWait = 0.35,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp03" }
									},
								},

								{ Cue = "/VO/Melinoe_4713", Text = "At least he seems to be quite comfortable." },
							},
							{
								PlayOnce = true,
								PlayOnceContext = "HypnosDream3VO",
								BreakIfPlayed = true,
								ObjectType = "NPC_Hypnos_03",
								PreLineWait = 1.3,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp03" }
									},
								},

								{ Cue = "/VO/Hypnos_0035", Text = "{#Emph}Zzz... wide away... away... zzz..." },
								{ Cue = "/VO/Hypnos_0036", Text = "{#Emph}...mmmaking positive.... zzz...", PreLineWait = 1.85, BreakIfPlayed = true, },
							},
							{
								PlayOnce = true,
								UsePlayerSource = true,
								PreLineWait = 0.35,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "TextLinesRecord", "HypnosWakeUp02" }
									},
								},

								{ Cue = "/VO/Melinoe_4645", Text = "Wait, there he is..." },
								{ Cue = "/VO/Melinoe_4646", Text = "Oh no, he's still asleep...", PreLineWait = 0.8, BreakIfPlayed = true },
							},
						}
					}
				}
			},

			-- Cosmetic Critters
			[743399] =
			{
				Name = "CosmeticDogs",
				Activate = true,
				SkipDefaultSetup = true, -- Handled by WorldUpgrade

				DistanceTriggers =
				{
					{
						Repeat = true,
						WithinDistance = 250,
						FunctionName = "CosmeticDogsApproachPresentation",
						Args =
						{
							Cooldown = 5.0,
							MinDelayBetweenDogs = 0.2,
							MaxDelayBetweenDogs = 0.8,
						},
						VoiceLines =
						{
							{ GlobalVoiceLines = "CritterGreetingVoiceLines" },
						},
					},
				},
			},
			[800610] =
			{
				Name = "CosmeticCats",
				Activate = true,
				SkipDefaultSetup = true, -- Handled by WorldUpgrade

				DistanceTriggers =
				{
					{
						Repeat = true,
						WithinDistance = 250,
						VoiceLines =
						{
							{ GlobalVoiceLines = "CatGreetingVoiceLines" },
						},
					},
				},
			},

		},
		
		Using =
		{
			"CrossroadsAquarium01_Fx",
			"Portrait_Dora_Bath_Sweat1a",
			"Portrait_HecateUnmasked_Bath_Sweat1a",
			"Portrait_Hecate_Bath_Sweat1a",
			"Portrait_Hecate_Bath_Sweat2e",
			"Portrait_MelShock_Bath_Sweat1a",
			"Portrait_Mel_Bath_Sweat1a",
			"Portrait_MelTears_Bath_Sweat1a",
			"Portrait_Moros_Bath_Sweat1a",
			"Portrait_Nemesis_Bath_Sweat1a",
			"Portrait_Odysseus_Bath_Sweat1a",
			"Portrait_Eris_Bath_Sweat1a",
			"Portrait_Icarus_Bath_Sweat1a",
		},
	},

	-- Training Grounds
	Hub_PreRun =
	{
		InheritFrom = { "BaseHub", },
		RichPresence = "#RichPresence_PreRun",
		ActiveEncounters = {},
		Kills = {},
		SkipLastKillPresentation = true,
		CheckWeaponHistory = true,
		UseBiomeMap = true,
		BiomeMapArea = "Home",
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
		SpeakerName = { "Skelly", "Selene", },
		FamiliarsPreferSpawnPointMovement = true,
		FrogFamiliarMaxLeapDistance = 800,
		PolecatFamiliarShouldNotFollow = true,
		CameraZoomWeights =
		{
			--[420907] = 1.0,
			[420907] = 0.75,
			[420906] = 0.75,
			[567330] = 1.1,
		},
		SoftClamp = 0.75,

		AmbientMusicSourceId = 40009,
		AmbientMusicParams =
		{
			LowPass = 1.0,
			Vocals = 0.7,
			Vocals2 = 0.0,
		},
		AmbientMusicVolume = 0.5,

		OnDeathLoadRequirements =
		{
			{
				{
					PathTrue = { "CurrentRun", "ActiveBounty", },
				},
			},
		},
		OnLoadEvents =
		{
			{
				FunctionName = "HubPostBountyLoad",
				Args =
				{
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "ActiveBounty", },
					},
					{
						PathFalse = { "CurrentHubRoom", },
					},
				},
				BreakIfPlayed = true,
			},
			{
				FunctionName = "DeathAreaRoomTransition",
			},
		},

		OutOfManaEvents =
		{
			{
				Threaded = true,
				FunctionName = "ManaFountainHintPresentation",
				Args =
				{
					FountainId = 566327,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "ManaFountain" },
						Comparison = "<",
						Value = 3,
					},
				},
			},
		},

		StartUnthreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Skelly", "Nyx", },
					LoadPackages = { "Skelly", },
				},
			},
			{
				FunctionName = "AssignWeaponKits",
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
			-- always present until multiple weapons are unlocked or if any exorcism ghosts have spawned
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "WeaponsUnlocked" },
								HasNone = { "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
							},
						},
						{
							{
								PathNotEmpty = { "CurrentRun", "ExorcisedNames", },
							},
						},
						{
							ChanceToPlay = 0.75,
						},
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
				FailedFunctionName = "SetupMissingDistanceTrigger",
				FailedFunctionArgs =
				{
					Id = 420928,
					UnitName = "NPC_Skelly_01",
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
						"SkellyPostTrueEnding01",
						"SkellyAboutTrophyQuest01",
						"TrophyQuestComplete01",
						"TrophyQuestComplete02",
						"TrophyQuestComplete03",
						"SkellyAboutTrophyQuest02",
						"SkellyAboutTyphon01",
						"SkellyAboutTyphon03",
						"SkellyAboutHealthQuest01",
						"SkellyAboutHealthQuest03",
						"SkellyAboutHealthQuest04",
						"SkellyAboutPast03",
						"SkellyFirstMeeting",
						"SkellyAboutSurface01",
						"SkellyAboutGodMode01",
						"SkellyAboutShrine01",
						"SkellyAboutCerberus01",
						"SkellyAboutChronosBossW01",
						"SkellyAboutAspects01",
						"SkellyAboutCharon01",
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
					SpawnPointIds = { 585601, 585600, 585599, 585598, 585602, 585603, },
					TargetId = 587209,
					IgnoreForInspectPointUnlessOnlyOption = "ShadeErebusIdle",
					InspectPoint =
					{
						Name = "GhostInspectPoint",
						ObjectId = 589872,
						UseTextSpecial = "UseExorcisedGhostsPreRun",
						SpecialInteractFunctionName = "UseExorcisedGhostsPreRun",
					},
					AnimationSwapMap =
					{
						ShadeShipsOneIdle = "ShadeShipsOneSwayHubIdle",
					},
				},
			},
			-- dora always present [after Cosmetics unlocked]
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					NamedRequirements = { "CosmeticsShopUnlocked" },
					{
						PathFalse = { "CurrentRun", "BlockDoraSpawn" },
					},
				},
				Args =
				{
					Types =
					{
						"NPC_Dora_01",
					},
					OverwriteSelf =
					{
						DefaultCategoryIndex = 4,
					},
				},
			},
			{
				FunctionName = "ActivateConditionalItems",
				Args =
				{
					CosmeticsShopCategoryIndex = 4,
				},
			},
			-- Frinos Accessories
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "FrogFamiliar" },
					},
				},
				Args =
				{
					Ids = { 780633, 780602, 780610, 780631, 780626, 780634, 780649 },
				},
			},
			-- Raki Accessories
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "RavenFamiliar" },
					},
				},
				Args =
				{
					Ids = { 780597, 780612, 780613, 780635, },
				},
			},
			-- Toula Accessories
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "CatFamiliar" },
					},
				},
				Args =
				{
					Ids = { 780596, 780625, 780604, 780614, },
				},
			},
			-- Hecuba Accessories
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "HoundFamiliar" },
					},
				},
				Args =
				{
					Ids = { 780595, 780594, 780601, 780598, 780636, 780641, },
				},
			},
			-- Gale Accessories
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "FamiliarsUnlocked", "PolecatFamiliar" },
					},
				},
				Args =
				{
					Ids = { 780648, 780646, 780609, 780605, 780593, 780622, 780624, 780623, },
				},
			},
			{
				FunctionName = "RestoreMusicianMusic",
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				FailedFunctionName = "CheckConversations",
				FailedFunctionArgs =
				{
					PlayOnceFlag = "AllowPostBounty",
				},
			},
			{
				FunctionName = "EquipLastAwardTrait",
				Args = {},
			},
			{
				FunctionName = "EquipLastWeaponUpgrade",
				Args =
				{
					SkipTraitHighlight = true,
					SkipUIUpdate = true,
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
				FunctionName = "CheckObjectiveSetSource",
				Args =
				{
					ObjectiveSetName = "KillTyphon",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_5159" },
					},
				},
			},
			{
				FunctionName = "CheckObjectiveSetSource",
				Args =
				{
					ObjectiveSetName = "KillChronos",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_5160" },
					},
				},
			},

			-- below are mutually exclusive, in order of priority

			{
				BreakIfPlayed = true,
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
					NamedRequirementsFalse = { "JustBeforeOrAfterTrueEnding" },
				},
			},

			{
				-- NextStopTyphonFirstPresentation
				BreakIfPlayed = true,
				FunctionName = "PreRunCameraPresentation",
				Args =
				{
					PanTargetId = 585605,
					PanVoiceLines = HeroVoiceLines.NextStopTyphonVoiceLines,
					PanDuration = 1.8,
					HoldDuration = 3,
					ObjectiveSet = "KillTyphon",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeStormStop" }
					},
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/Melinoe_5159" },
					},
				},
			},

			{
				-- NextStopChronosFirstPresentation
				BreakIfPlayed = true,
				FunctionName = "PreRunCameraPresentation",
				Args =
				{
					PanTargetId = 780650,
					PanVoiceLines = HeroVoiceLines.NextStopChronosVoiceLines,
					PanDuration = 1.8,
					HoldDuration = 3,
					ObjectiveSet = "KillChronos",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeTimeStop" }
					},
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/Melinoe_5160" },
					},
				},
			},

			{
				-- First visit post-credits
				BreakIfPlayed = true,
				FunctionName = "PreRunCameraPresentation",
				Args =
				{
					PanTargetId = 589694,
					PanVoiceLines = HeroVoiceLines.NextStopPostTrueEndingVoiceLines,
					PanDuration = 1.8,
					HoldDuration = 3,
					ObjectiveSet = "PostCreditsStartNewRun",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "TrueEndingFinale01" },
					},
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/Melinoe_5740" },
					},
				},
			},

			{
				BreakIfPlayed = true,
				FunctionName = "BountyBoardUnlockedFirstPresentation",
				Args = {},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/Skelly_0087" },
					},
					{
						Path = { "CurrentRun", "SpeechRecord" },
						HasNone = { "/VO/Melinoe_2855", "/VO/Skelly_0300", "/VO/Melinoe_0852", "/VO/Melinoe_5159", "/VO/Melinoe_5160" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathFalse = { "GameState", "ScreensViewed", "BountyBoard" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
				},
			},

			{
				BreakIfPlayed = true,
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
				-- AltRunDoorUnlockedFirstPresentation
				BreakIfPlayed = true,
				FunctionName = "PreRunCameraPresentation",
				Args =
				{
					PanTargetId = 585605,
					PanVoiceLines = HeroVoiceLines.AltRunDoorUnlockedVoiceLines,
					PanDuration = 2.8,
					HoldDuration = 4.2,
					ObjectiveSet = "SurfaceDoorPrompt",
				},
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
					-- replacement for the ShrineUnlocked condition below
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosBossOutro01" },
					},
					NamedRequirementsFalse = { "TrophyQuestUnlocked" },
					-- NamedRequirementsFalse = { "ShrineUnlocked" },
				},
			},

			-- skelly quest progress
			{
				BreakIfPlayed = true,
				FunctionName = "GenericPresentation",
				Args =
				{
					VoiceLines =
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
							{
								FunctionName = "RequireAffordableMetaUpgrade",
							},
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
							{
								FunctionName = "ShouldShowWeaponShopWantsToTalkIndicator",
							},
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
									{
										FunctionName = "RequireAffordableMetaUpgrade",
									},
								},
								{ Cue = "/VO/Melinoe_1610", Text = "Mustn't forget my Altar back there...", },
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
							-- Observation: Grave Thirst Active
							{
								PlayOnce = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeUnusedWeaponBonus" },
									},
									{
										SumPrevRuns = 4,
										Path = { "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonus" },
										CountPathTrue = true,
										Comparison = ">=",
										Value = 1,
									},
								},
								{ Cue = "/VO/Melinoe_2407", Text = "There's the Grave Thirst aura by the Silver Pool..." },
							},
							-- Observation: Grave Thirst Active
							{
								PlayOnce = true,
								GameStateRequirements =
								{
									{
										PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeUnusedWeaponBonusT2" },
									},
									{
										SumPrevRuns = 4,
										Path = { "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonusT2" },
										CountPathTrue = true,
										Comparison = ">=",
										Value = 1,
									},
									{
										PathFalse = { "CurrentRun", "ActiveBounty" },
									},
								},
								Cooldowns =
								{
									{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
								},
								
								{ Cue = "/VO/Melinoe_5477", Text = "The Grave Thirst aura's even stronger now." },
							},
						},
					},
					{
						WithinDistance = 800,
						VoiceLines =
						{
							-- Hint: Hidden Aspect Unlocks
							{
								PlayOnceFromTableThisRun = true,
								RandomRemaining = true,
								GameStateRequirements =
								{
									{
										Path = { "CurrentRun", "TextLinesRecord" },
										HasAny = { "CirceGrantsHiddenAspect01", "ArtemisGrantsHiddenAspect01", "MorosGrantsHiddenAspect01", "CharonGrantsHiddenAspect01", "MedeaGrantsHiddenAspect01", "SeleneGrantsHiddenAspect01" },
									},
									NamedRequirementsFalse =  { "HasAllHiddenAspectsRevealed" },
								},

								{ Cue = "/VO/Melinoe_4397", Text = "Now for the Silver Pool.", PlayFirst = true },
								{ Cue = "/VO/Melinoe_4398", Text = "Should try the Silver Pool.", PlayFirst = true },
								{ Cue = "/VO/Melinoe_4399", Text = "Should try the Pool." },
								{ Cue = "/VO/Melinoe_4400", Text = "The Pool should have something for me..." },
								{ Cue = "/VO/Melinoe_4401", Text = "Now for my waking-phrase..." },
								{ Cue = "/VO/Melinoe_4402", Text = "Should try the waking-phrase..." },
							},
						},
					},

				},
				
				Using = { Sound = "/SFX/Menu Sounds/SilverPoolOpen", },
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
				AnimOffsetX = 10,
				AnimOffsetZ = 470,
				SpeakerName = "Chaos",

				SetupGameStateRequirements =
				{
					-- Always present, but initially locked
				},
				SetupEvents =
				{
					{
						FunctionName = "OverwriteSelf",
						Args =
						{
							UseText = "UseBountyBoard",
							UseSound = "/SFX/Menu Sounds/ChaosTrialMenuOpen",
							OnUsedFunctionName = "UseBountyBoard",
							Animation = "Crossroads_BountyBoard_On01",
						},
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
							},
							NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
						},
						FailedFunctionName = "GenericPresentation",
						FailedFunctionArgs =
						{
							UseableOff = true,
						},
					},
					{
						FunctionName = "PlayStatusAnimation",
						Args = { Animation = "StatusIconWantsToTalkImportant", },
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
							},
							OrRequirements =
							{
								{
									{
										PathFalse = { "GameState", "ScreensViewed", "BountyBoard" },
									},
								},
								{
									{
										FunctionName = "HasUnviewedBounty",
									},
								},
							},
							NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
						},
					},
				},

				DistanceTriggers =
				{
					{
						GameStateRequirements =
						{
							NamedRequirements = { "SurfaceRouteLockedByTyphonKill" },
						},
						WithinDistance = 250,
						VoiceLines =
						{
							UsePlayerSource = true,
							Cooldowns =
							{
								{ Name = "MelinoeAnyQuipSpeech", Time = 6 },
							},

							{ Cue = "/VO/Melinoe_0387", Text = "Not now." },
						},
					},
				},

				Using = { "/SFX/Menu Sounds/KeepsakeHighlightShimmerSFX" },
			},
			-- BountyBoard moon beam
			[587430] =
			{
				Name = "BountyBoardMoonBeam",
				DestroyIfNotSetup = true,
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						FunctionName = "HasUnclearedBounty",
					},
					NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
				},
			},
			-- Shrine / Oath of the Unseen / Pact / Pact of Punishment (Note: Shadow decal below)
			[589694] =
			{
				Name = "Shrine",
				InteractDistance = 200,
				AnimOffsetZ = 510,
				UseText = "UseShrineObject",
				UseSound = "/SFX/HeatCollectionPickup",
				OnUsedFunctionName = "UseShrineObject",
				UseTextTalkAndSpecial = "UseOrSpecialShrineObject",
				SpecialInteractFunctionName = "SpecialInteractChangeNextRunRNG",
				SpecialInteractCooldown = 6,
				SpecialInteractGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeChangeNextRunRNG" },
					},
				},
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

				Using =
				{
					"Crossroads_Shrine_On01_Active",
					"Crossroads_Shrine_On01",
				},
			},

			-- Supportive Shade / -- DieHardFan
			[555807] =
			{
				Name = "DieHardFanShade",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ExorcisedNames", "DieHardFanShade" },
					},
				},
				DestroyIfNotSetup = true,

				SpecialInteractFunctionName = "SpecialInteractDieHardFanShade",
				UseTextSpecial = "SpecialInteractShade",

				-- UseSound = "/Leftovers/World Sounds/CaravanCreak",
				-- ShakeSelf = true,
				InteractDistance = 200,
				DistanceTriggers =
				{
					{
						WithinDistance = 1300,
						ChanceToPlay = 0.25,
						TriggerOnceThisRun = true,
						FunctionName = "PlayEmoteSimple",
						Args =
						{
							TargetId = 723340,
							AnimationName = "StatusIconSmileRed",
							OffsetZ = 30,
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

			-- Run Start Door / New Run Door / NewRunDoor
			-- Underworld Run
			[420947] =
			{
				UseText = "UseStartRunDoor1",
				InteractDistance = 350,
				InteractOffsetX = -100,
				InteractOffsetY = 170,
				OnUsedFunctionName = "UseEscapeDoor",
				OnUsedFunctionArgs = { StartingBiome = "F", DashTarget = 588632, AltarId = 589766, },
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
					{
						FunctionName = "UpdateEscapeDoorForLimitGraspShrineUpgrade",
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
					OrRequirements =
					{
						-- lock until you remove the curse
						{
							{
								PathFalse = { "GameState", "WorldUpgrades", "WorldUpgradeAltRunDoor" },
							},
						},
						-- lock again after defeating Typhon for real, until you've seen the true ending
						{
							NamedRequirements = { "SurfaceRouteLockedByTyphonKill" },
						},
					},
				},
			},
			-- unlocked
			[555784] =
			{
				UseText = "UseStartRunDoor2",
				OnUsedFunctionName = "UseEscapeDoor",
				OnUsedFunctionArgs = { StartingBiome = "N", RandomOffset = 1, MarkObjectiveComplete = "UseSurfaceDoor", DashTarget = 588633, GlobalVoiceLines = "StartSurfaceRunVoiceLines", AltarId = 589766, },
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
					NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
				},
				SetupEvents =
				{
					{
						FunctionName = "UpdateEscapeDoorForLimitGraspShrineUpgrade",
					},
				}
			},

			-- Exit to Hub_Main (from Hub_PreRun)
			[421119] =
			{
				SetupGameStateRequirements =
				{
					{
						FunctionName = "RequiredConfigOptions",
						FunctionArgs = { ConfigOptions = { "KioskMode" }, HasOptions = false },
					},
				},
				DestroyIfNotSetup = true,

				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs =
				{
					Name = "Hub_Main", HeroStartPoint = 390004, HeroEndPoint = 390002,
					PreLoadFunctionName = "ClearPreRunUpgrades",
				},

				InteractDistance = 420,
				InteractOffsetX = -205,
				InteractOffsetY = -165,
				AutoActivate = true,
				OnUsedVoiceLines =
				{
					--
				},

				SetupEvents =
				{
					{
						FunctionName = "DistanceTrigger",
						Threaded = true,
						Args =
						{
							WithinDistance = 400,
							Repeat = true,
							TriggerName = "PreRunBacktrackHintTrigger",
							PostTriggerEvents =
							{
								{
									FunctionName = "PreRunBacktrackHintPresentation",
									Args =
									{
										NewRunDoorId = 420947,
									},
									GameStateRequirements =
									{
										{
											PathTrue = { "SessionMapState", "AltarEnterPresentation", },
										},
										--[[
										{
											PathTrue = { "CurrentRun", "CurrentRoom", "UseRecord", "NPC_Skelly_01" },
										},
										]]
										{
											PathTrue = { "CurrentRun", "ScreenViewRecord", "WeaponShop" },
										},
										{
											PathTrue = { "CurrentRun", "ScreenViewRecord", "MetaUpgradeCardLayout" },
										},
									},
								},
							},
						},
						GameStateRequirements =
						{
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = "<=",
								Value = 0,
							},
							{
								PathFalse = { "SessionState", "PreRunBacktrackHintTrigger", },
							},
						},
					},
				},
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
			CameraSpeed = 1260 * 1.25, -- speed of camera pan
			CameraStartPanDuration = 4.0, -- only used if there is no speed defined
			CameraStartPanRelocateDuration = 1.34, -- approximate time before camera is out of the default isometric scene

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
				Cooldowns =
				{
					{ Name = "SkellyWelcomeSpeech", Time = 6 },
				},
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
				VoiceLines =
				{
					{
						PlayOnce = true,
						PlayOnceContext = "SkellyTrueEndingAchievedVO",
						BreakIfPlayed = true,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Salute",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},

						{ Cue = "/VO/Skelly_0643", Text = "All hail our victorious Princess of the Underworld!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 0.6, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.4, }, },
					},
					{
						-- PlayOnce = true,
						BreakIfPlayed = true,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Salute",
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "SkellyAboutSurface01" }, },
							},
						},

						{ Cue = "/VO/Skelly_0493", Text = "Get over here, young one, {#Emph}right {#Prev}now!" },
					},
					{
						-- PlayOnce = true,
						BreakIfPlayed = true,
						ObjectType = "NPC_Skelly_01",
						PreLineAnim = "Skelly_Explaining",
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs =
								{
									IsAny = {
										"SkellyAboutCharon02",
										"SkellyAboutTrophyQuest01",
										"SkellyAboutPast03",
										"SkellyAboutTyphon01",
										"SkellyAboutTyphon02",
										"SkellyAboutTyphonW01",
									},
								},
							},
						},

						{ Cue = "/VO/Skelly_0042", Text = "May we converse?", PlayFirst = true },
						{ Cue = "/VO/Skelly_0405", Text = "Come forth, would ya?" },
						{ Cue = "/VO/Skelly_0406", Text = "I've something to discuss." },
						{ Cue = "/VO/Skelly_0514", Text = "Hey might I have a word?" },
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
						PreLineAnim = "Skelly_Salute",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "CompletedRunsCache" },
								Comparison = "==",
								Value = 0,
							},
						},
						{ Cue = "/VO/Skelly_0228_B", Text = "Disciples, atten{#Emph}tion!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.25 },
						},
					},
					-- Health Quest
					{
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "ObjectivesCompleted", "KillSkelly" },
							},
							{
								PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutHealthQuest03" },
							},
						},
						{
							PlayOnce = true,
							PlayOnceContext = "SkellyHealthQuestVO",
							ObjectType = "NPC_Skelly_01",
							PreLineAnim = "Skelly_Babbling",
							{ Cue = "/VO/Skelly_0594", Text = "{#Emph}Heheheheh{#Prev}, all that was a mere jest. Carry on!" },
						},
						{
							PlayOnce = true,
							PlayOnceContext = "SkellyHealthQuestVO",
							UsePlayerSource = true,
							PreLineWait = 0.6,

							{ Cue = "/VO/Melinoe_4958", Text = "{#Emph}Commander!" },
						},
						{
							PlayOnce = true,
							PlayOnceContext = "SkellyHealthQuestVO",
							ObjectType = "NPC_Skelly_01",
							PreLineAnim = "Skelly_Greeting",
							{ Cue = "/VO/Skelly_0595", Text = "Oh, {#Emph}um, hey!", BreakIfPlayed = true, },
						},
					},
					{
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSkellyHealth" },
							},
						},
						{
							PlayOnce = true,
							PlayOnceContext = "SkellyHealthQuestVO",
							ObjectType = "NPC_Skelly_01",
							PreLineAnim = "Skelly_Babbling",
							{ Cue = "/VO/Skelly_0588", Text = "{#Emph}Oh, hohoho. Ah, hahaha!! {#Prev}My strength {#Emph}returns!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 0.66, AnimationNames = { "StatusIconFear", "StatusIconEmbarrassed", "StatusIconGrief" }, ReactionChance = 0.35, }, },
						},
						{
							PlayOnce = true,
							PlayOnceContext = "SkellyHealthQuestVO",
							UsePlayerSource = true,
							BreakIfPlayed = true,
							PreLineWait = 0.6,

							{ Cue = "/VO/Melinoe_4954", Text = "Commander...?" },
						},
					},
					-- Trophy Quest
					{
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "TrophyQuestComplete03", }, },
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
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "TrophyQuestComplete02", }, },
							},
						},
						{
							PlayOnce = true,
							PreLineAnim = "Skelly_Explaining",
							ObjectType = "NPC_Skelly_01",

							{ Cue = "/VO/Skelly_0313", Text = "{#Emph}Huzzah! {#Prev}Another glorious victory, another well-earned Gift!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.3, }, },
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
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "TrophyQuestComplete01", }, },
							},
						},
						{
							PlayOnce = true,
							ObjectType = "NPC_Skelly_01",
							PreLineAnim = "Skelly_Explaining",

							{ Cue = "/VO/Skelly_0308", Text = "Your prize awaits, and glory is yours! A third of it anyway.",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 0.75, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.3, }, },
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
								{
									FunctionName = "RequiredQueuedTextLine",
									FunctionArgs = { IsAny = { "SkellyAboutTrophyQuest02", }, },
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
								{
									FunctionName = "RequiredQueuedTextLine",
									FunctionArgs = { IsAny = { "SkellyAboutTrophyQuest03", }, },
								},
							},
							{ Cue = "/VO/Skelly_0302", Text = "If you would honor me with a quick chat?" },
						},
					},
					-- Luckier Tooth
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.5,
						SuccessiveChanceToPlayAll = 0.05,
						ObjectType = "NPC_Skelly_01",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ReincarnationKeepsake" },
							},
							{
								PathFalse = { "CurrentRun", "ActiveBounty" },
							},
						},

						{ Cue = "/VO/Skelly_0431", Text = "You bear my trusty Tooth!", PlayFirst = true },
						{ Cue = "/VO/Skelly_0432", Text = "May my Tooth bring you fortune and fame." },
					},
					-- Cleared Runs
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.65,
						ObjectType = "NPC_Skelly_01",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Cleared" },
							},
							{
								PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0087" },
							},
							{
								PathFalse = { "CurrentRun", "ActiveBounty" },
							},
						},

						{ Cue = "/VO/Skelly_0515", Text = "...There's no way she could have — oh, {#Emph}hey!", PlayFirst = true },
						{ Cue = "/VO/Skelly_0518", Text = "I, for one, was {#Emph}certain {#Prev}she'd prevail!" },
						{ Cue = "/VO/Skelly_0643", Text = "All hail our victorious Princess of the Underworld!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.35, },
							GameStateRequirements =
							{
								{
									SumPrevRuns = 9,
									Path = { "SpeechRecord" },
									TableValuesToCount = { "/VO/Skelly_0643" },
									Comparison = "<=",
									Value = 0,
								},
							},
						},
						{ Cue = "/VO/Skelly_0516", Text = "The Slayer of Titans returns!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.35, },
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
								},
								{
									Path = { "GameState", "EnemyKills", "Chronos" },
									Comparison = ">=",
									Value = 3,
								},
								{
									Path = { "GameState", "TextLinesRecord" },
									HasAny = { "SkellyAboutChronosBossW01", "SkellyAboutChronosBossW02" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0517", Text = "Way to stick it to that Chronos guy!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.35, },
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
								},
								{
									Path = { "GameState", "EnemyKills", "Chronos" },
									Comparison = ">=",
									Value = 3,
								},
								{
									Path = { "GameState", "TextLinesRecord" },
									HasAny = { "SkellyAboutChronosBossW01", "SkellyAboutChronosBossW02" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0519", Text = "The vanquisher of Typhon has arrived!",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.35, },
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RoomsEntered" },
									HasAny = { "Q_Boss01", "Q_Boss02" },
								},
								{
									Path = { "GameState", "EnemyKills", "TyphonHead" },
									Comparison = ">=",
									Value = 4,
								},
								{
									PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTyphon01" }
								},
							},
						},
						{ Cue = "/VO/Skelly_0520", Text = "You really showed that Typhon huh?",
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.35, },
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RoomsEntered" },
									HasAny = { "Q_Boss01", "Q_Boss02" },
								},
								{
									Path = { "GameState", "EnemyKills", "TyphonHead" },
									Comparison = ">=",
									Value = 5,
								},
								{
									PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTyphon01" }
								},
							},
						},
						{ Cue = "/VO/Skelly_0521", Text = "{#Emph}Huzzah {#Prev}for the savior of Olympus!",
							PlayFirst = true,
							PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconVictory" }, ReactionChance = 0.35, },
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RoomsEntered" },
									HasAny = { "Q_Boss01", "Q_Boss02" },
								},
								{
									Path = { "GameState", "EnemyKills", "TyphonHead" },
									Comparison = ">=",
									Value = 3,
								},
								{
									PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTyphon01" }
								},
								{
									PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0522", Text = "You're tellin' me she beat Typhon {#Emph}again?",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "RoomsEntered" },
									HasAny = { "Q_Boss01", "Q_Boss02" },
								},
								{
									Path = { "GameState", "EnemyKills", "TyphonHead" },
									Comparison = ">=",
									Value = 8,
								},
								{
									PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTyphon01" }
								},
							},
						},
					},
					-- Recruited Shades
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
						},

						{ Cue = "/VO/Skelly_0223", Text = "I see we got some new faces today, fresh out of Erebus!",
							PlayFirst = true,
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "ExorcisedNames", },
									HasAny = { "ShadesErebusIdle" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0224", Text = "To all of you just joining up, welcome!" },
						{ Cue = "/VO/Skelly_0523", Text = "Some of you made it from the surface {#Emph}eh?",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "ExorcisedNames", },
									HasAny = { "ShadeEphyraIdle" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0524", Text = "We got a Shade come all the way from Mount Olympus here!",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "ExorcisedNames", },
									HasAny = { "ShadeTyphonIdle" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0525", Text = "You Shades are new around these parts so you answer to {#Emph}me!" },
						{ Cue = "/VO/Skelly_0526", Text = "A Shade come all the way from Tartarus is here with us!",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "ExorcisedNames", },
									HasAny = { "ShadeClockworkIdle" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0527", Text = "...And that concludes our little orientation. Any questions, shoot!" },
						{ Cue = "/VO/Skelly_0528", Text = "...So basically, I'm gonna need you all to stand around, all right?" },
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
									Path = { "CurrentRun", "ExorcisedNames", },
									HasAny = { "ShadeOceanusSIdle" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0295", Text = "No use crying in the Mourning Fields when you can join us here!",
							GameStateRequirements =
							{
								{
									Path = { "CurrentRun", "ExorcisedNames", },
									HasAny = { "ShadeFieldsGreyIdle" },
								},
							},
						},
					},
					-- Other Cases
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.65,
						ObjectType = "NPC_Skelly_01",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Skelly_0087" },
							},
							{
								PathFalse = { "CurrentRun", "ActiveBounty" },
							},
						},
						{ Cue = "/VO/Skelly_0507", Text = "Hey everybody look who's back!" },
						{ Cue = "/VO/Skelly_0508", Text = "All right act normal everyone, she's back!" },
						{ Cue = "/VO/Skelly_0509", Text = "{#Emph}You {#Prev}there, get back in formation or {#Emph}else!" },
						{ Cue = "/VO/Skelly_0510", Text = "So anybody got a tale to tell or what?" },
						{ Cue = "/VO/Skelly_0513", Text = "I know the sound of that gait well!" },
						{ Cue = "/VO/Skelly_0037", Text = "...She's here, come on you slackers, straighten up!",
							PreLineAnim = "Skelly_Babbling" },
						{ Cue = "/VO/Skelly_0038", Text = "...Ah, there she is again at last.", PlayFirst = true },
						{ Cue = "/VO/Skelly_0039", Text = "...and that concludes our lesson for today. At ease." },
						{ Cue = "/VO/Skelly_0040", Text = "...and another thing... {#Emph}um{#Prev}, stand up straight!" },
						{ Cue = "/VO/Skelly_0041", Text = "Everybody at attention!" },
						{ Cue = "/VO/Skelly_0104", Text = "...and what are we to do? Merely stand by, and let the Titan have his way?!",
							PlayFirst = true,
							GameStateRequirements =
							{
								{
									Path = { "GameState", "EnemyKills", "Chronos" },
									Comparison = ">=",
									Value = 1,
								},
								{
									PathTrue = { "CurrentRun", "BiomesReached", "F" },
								},
								{
									PathFalse = { "CurrentRun", "Cleared" },
								},
								{
									PathFalse = { "GameState", "ReachedTrueEnding" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0105", Text = "...but that, disciples, is a tale for another circumstance." },
						{ Cue = "/VO/Skelly_0107", Text = "We bid you welcome to our training grounds!" },
						{ Cue = "/VO/Skelly_0108", Text = "Another step on the path to perfection!" },
						{ Cue = "/VO/Skelly_0165", Text = "She's here, now watch and learn!", PlayFirst = true },
						{ Cue = "/VO/Skelly_0296", Text = "Always she returns, as dusk gives way to night!" },
						{ Cue = "/VO/Skelly_0297", Text = "Atten{#Emph}tion! {#Prev}Got a Silver Sister on deck!" },
						{ Cue = "/VO/Skelly_0228_C", Text = "She has {#Emph}returned!" },
						{ Cue = "/VO/Skelly_0298", Text = "Hold, everybody, Silver Sister on deck!" },
						{ Cue = "/VO/Skelly_0299", Text = "...Keep practicing, as though you still had lives that depended on it!" },
						{ Cue = "/VO/Skelly_0005", Text = "Ah, I know the sound of that gait. Come here where these old eyes can see ya." },
						{ Cue = "/VO/Skelly_0511", Text = "Behold Night's Champion everybody!",
							PlayFirst = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" }
								},
							},
						},
						{ Cue = "/VO/Skelly_0512", Text = "Done with that Silver Puddle over there?",
							GameStateRequirements =
							{
								{
									PathTrue = { "CurrentRun", "UseRecord", "WeaponShop" },
								},
							},
						},
						{ Cue = "/VO/Skelly_0024", Text = "...and that, my disciples, is the true meaning of life. Remember it well!",
							PreLineAnim = "Skelly_Babbling",
							GameStateRequirements =
							{
								{
									Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
									Comparison = ">=",
									Value = 4,
								},
							}
						},
						{ Cue = "/VO/Skelly_0025", Text = "...and then I say... h-hold up, somebody's here.",
							PreLineAnim = "Skelly_Babbling",
							GameStateRequirements =
							{
								{
									Path = { "GameState", "UseRecord", "NPC_Skelly_01", },
									Comparison = ">=",
									Value = 6,
								},
							}
						},
						{ Cue = "/VO/Skelly_0228_B", Text = "Disciples, atten{#Emph}tion!",
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
						RandomRemaining = true,
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
						{ Cue = "/VO/Melinoe_2919", Text = "Commander Schelemeus, {#Emph}sir!" },
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
						UsePlayerSource = true,
						PostLineFunctionName = "FrogFamiliarReaction",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "FrogFamiliar" },
							},
							{
								PathFalse = { "GameState", "SpeechRecord", "/VO/Melinoe_2770" }
							},
						},
						Cooldowns =
						{
							{ Name = "SaidFrinosRecently", Time = 20 },
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

						{ Cue = "/VO/Melinoe_2770", Text = "Frinos, you're here!", PlayFirst = true },
					},
					{
						PlayOnce = true,
						BreakIfPlayed = true,
						UsePlayerSource = true,
						PostLineFunctionName = "FrogFamiliarReaction",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarCostumeSystem" },
							},
							{
								PathFalse = { "GameState", "SpeechRecord", "/VO/Melinoe_5478" }
							},
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

						{ Cue = "/VO/Melinoe_5478", Text = "Hi gang. Any of you interested in a new look?" },
					},
				},
			},

			-- Toula (Familiar)
			{
				TriggerObjectType = "CatFamiliar",
				WithinDistance = 500,
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
						PostLineFunctionName = "CatFamiliarReaction",
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

			-- Raki (Familiar)
			{
				TriggerObjectType = "RavenFamiliar",
				WithinDistance = 500,
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
						PlayOnceContext = "RakiInPreRunVO",
						BreakIfPlayed = true,
						RandomRemaining = true,
						UsePlayerSource = true,
						PostLineFunctionName = "RavenFamiliarReaction",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "RavenFamiliar" },
							},
						},
						Cooldowns =
						{
							{ Name = "SaidRakiRecently", Time = 20 },
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

						{ Cue = "/VO/Melinoe_3591", Text = "Raki, welcome!" },
					},
				},
			},

			-- Hecuba (Familiar)
			{
				TriggerObjectType = "HoundFamiliar",
				WithinDistance = 500,
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
						PlayOnceContext = "HecubaInPreRunVO",
						BreakIfPlayed = true,
						RandomRemaining = true,
						UsePlayerSource = true,
						PostLineFunctionName = "HoundFamiliarReaction",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "HoundFamiliar" },
							},
						},
						Cooldowns =
						{
							{ Name = "SaidHecubaRecently", Time = 20 },
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

						{ Cue = "/VO/Melinoe_3775", Text = "Hecuba returns!" },
					},
				},
			},

			-- Gale (Familiar)
			{
				TriggerObjectType = "PolecatFamiliar",
				WithinDistance = 500,
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
						PlayOnceContext = "GaleInPreRunVO",
						BreakIfPlayed = true,
						RandomRemaining = true,
						UsePlayerSource = true,
						PostLineFunctionName = "PolecatFamiliarReaction",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsNone = { "PolecatFamiliar" },
							},
						},
						Cooldowns =
						{
							{ Name = "SaidGaleRecently", Time = 20 },
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

						{ Cue = "/VO/Melinoe_3960", Text = "Gale, welcome back!" },
					},
				},
			},

		},

		ReverbValue = 1.5,

		InspectPointPriority =
		{
			999999, -- hypnos gift
			589885, -- statues unlocked
			589884, -- statues locked
			589890, -- alt run door
			589887, -- aspects unlocked
			589892, -- familiars
			589893, -- grave thirst
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
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Skelly_01" }, },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "InspectHadesFountain01", "InspectBroker01" },
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "InspectHomerReveal01" }, Min = 4 },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "InspectHomerReveal01" }, Max = 6 },
					},
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
								Source = { LineHistoryName = "Speaker_Homer", SubtitleColor = Color.NarratorVoice },
								{ Cue = "/VO/Storyteller_0033", Text = "{#Emph}Nay..." },
							},
						},
					},
				},
			},

			-- Inspect: Recruited Shades
			[589894] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "ExorcismSuccesses" },
						Comparison = ">=",
						Value = 10,
					},
				},
				InteractTextLineSets =
				{
					InspectRecruitedShades01 =
					{
						{ Cue = "/VO/Storyteller_0355", IsNarration = true,
							Text = "{#Emph}The rank and file of the Crossroads swell with Shades who once were lost but now have joined in our Princess Melinoë's most-righteous cause." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4085", Text = "Welcome to the ranks of the Unseen!",
									PreLineThreadedFunctionName = "CrowdReactionPresentationEventSource", PreLineThreadedFunctionArgs = { Delay = 1.25, AnimationNames = { "StatusIconSmile", "StatusIconOhBoy", "StatusIconEmbarrassed" }, ReactionChance = 0.25 }, },
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

			-- Inspect: Upgraded Altar
			[589888] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeCardUpgradeSystem" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgrades", "WorldUpgradeCardUpgradeSystem" },
					},
					{
						Path = { "GameState", "MetaUpgradeMaxLevelCountCache" },
						Comparison = ">=",
						Value = 2,
					},
				},
				InteractTextLineSets =
				{
					InspectUpgradedAltar01 =
					{
						{ Cue = "/VO/Storyteller_0356", IsNarration = true,
							Text = "{#Emph}At the threshold to the world beyond the Crossroads, the Altar of Ashes thrums with ancient power, boundless as that of the gods and heroes depicted in the myriad Arcana." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4086", Text = "A power within us all..." },
							},
						},
					},
				},
			},

			-- Inspect: Grave Thirst
			[589893] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonus" },
					},
					{
						PathFalse = { "CurrentRun", "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonus" }
					},
					{
						Path = { "GameState", "TraitsTaken" },
						HasAny = { "UnusedWeaponBonusTrait", "UnusedWeaponBonusTrait2" },
					},
					{
						SumPrevRuns = 6,
						Path = { "WorldUpgradesAdded", "WorldUpgradeUnusedWeaponBonus" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				InteractTextLineSets =
				{
					InspectGraveThirst01 =
					{
						{ Cue = "/VO/Storyteller_0351", IsNarration = true,
							Text = "{#Emph}A deathlike pallor emanates now from the Arms of Night, or one of them at least; their Fate-wrought thirst to separate immortal souls laid bare." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4081", Text = "{#Emph}The Gathering of Ancient Bones..." },
							},
						},
					},
				},
			},

			-- Inspect: Aspects Unlocked
			[589887] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWeaponUpgradeSystem" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllWeaponAspects,
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllWeaponAspects,
						Comparison = "<=",
						Value = 8,
					},
				},
				InteractTextLineSets =
				{
					InspectAspectsUnlocked01 =
					{
						{ Cue = "/VO/Storyteller_0352", IsNarration = true,
							Text = "{#Emph}Within the Silver Pool now swim dark apparitions of the Arms of Night, in forms unlike the Princess of the Underworld has previously seen." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4082", Text = "So many different forms..." },
							},
						},
					},
				},
			},

			-- Inspect: All Weapons
			[589886] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
					},
					{
						Path = { "CurrentRun", "WeaponsUnlocked" },
						HasNone = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
					},
				},
				InteractTextLineSets =
				{
					InspectAllWeaponsUnlocked01 =
					{
						{ Cue = "/VO/Storyteller_0357", IsNarration = true,
							Text = "{#Emph}Each of the ancient Fate-wrought Arms of Night is now rejoined under the Princess of the Underworld's care, all equally prepared to rid the realm of any of its foes." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4087", Text = "As am I." },
							},
						},
					},
				},
			},

			-- Inspect: Alt Run Door
			[589889] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeAltRunDoor" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Intro" },
					},
				},
				InteractTextLineSets =
				{
					InspectAltRunDoor01 =
					{
						{ Cue = "/VO/Storyteller_0349", IsNarration = true,
							Text = "{#Emph}The Princess of the Underworld now holds the key to the once-warded gateway leading all the way up to the surface of this world; but how is she to fare in that forbidden realm?" },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4079", Text = "We'll find out!" },
							},
						},
					},
				},
			},

			-- Inspect: Familiars
			[589892] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "FamiliarsUnlocked" },
						CountOf =
						{
							"FrogFamiliar",
							"RavenFamiliar",
							"CatFamiliar",
							"HoundFamiliar",
							"PolecatFamiliar",
						},
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "FamiliarsUnlocked" },
						CountOf =
						{
							"FrogFamiliar",
							"RavenFamiliar",
							"CatFamiliar",
							"HoundFamiliar",
							"PolecatFamiliar",
						},
						Comparison = "<",
						Value = 5,
					},
				},
				InteractTextLineSets =
				{
					InspectPreRunFamiliars01 =
					{
						{ Cue = "/VO/Storyteller_0350", IsNarration = true,
							Text = "{#Emph}A growing pack of ever-faithful Animal Familiars now stand ready to follow the Princess of the Dead into the depths, or wheresoever her fateful task shall take her next." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4080", Text = "My little protectors!" },
							},
						},
					},
				},
			},

			-- Inspect: Overlook Full Moon
			[589890] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectPreRun01" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
				},
				InteractTextLineSets =
				{
					InspectPreRunFullMoon01 =
					{
						{ Cue = "/VO/Storyteller_0347", IsNarration = true,
							Text = "{#Emph}Above, a full Moon flares, bestowing all her grace and power from beyond an earthly canopy of trees and soaring precipices which provide a pristine vantage point." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4077", Text = "The crossroads between realms..." },
							},
						},
					},
				},
			},
			-- Inspect: Overlook New Moon
			[589891] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "InspectPreRun01" },
					},
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 5,
					},
				},
				InteractTextLineSets =
				{
					InspectPreRunNewMoon01 =
					{
						{ Cue = "/VO/Storyteller_0348", IsNarration = true,
							Text = "{#Emph}The Moon this eve is nowhere to be seen, her light but temporarily extinguished, so that soon it may shine bright once more with newfound strength and possibility." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4078", Text = "Our cycle begins anew..." },
							},
						},
					},
				},
			},

			-- Inspect: Keepsakes
			[780560] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						Path = { "GameState", "GiftPresentation", },
						UseLength = true,
						Comparison = ">=",
						Value = 22,
					},
				},
				InteractTextLineSets =
				{
					InspectManyKeepsakes01 =
					{
						{ Cue = "/VO/Storyteller_0412", IsNarration = true,
							Text = "{#Emph}That well-worn storage case by now contains tokens of gratitude from many gods and more; a perpetual reminder that the Princess of the Dead shall never fight alone." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4271", Text = "You're always with me..." },
							},
						},
					},
				},
			},

			-- Inspect: Statues / Skelly Statues Locked
			[589885] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "SkellyAboutTrophyQuest01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
					},
				},
				InteractTextLineSets =
				{
					InspectSkellyStatuesLocked01 =
					{
						{ Cue = "/VO/Storyteller_0353", IsNarration = true,
							Text = "{#Emph}The three Gifts of the Veil, to be bestowed to one deserving of the title of Night's Champion, beckon the fierce Princess of the Dead to prove her unequaled prowess to all." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4083", Text = "Oh, I don't know..." },
							},
							{
								PreLineWait = 0.25,
								ObjectType = "NPC_Skelly_01",

								{ Cue = "/VO/Skelly_0580", Text = "Oh, I {#Emph}do {#Prev}know!" },
							},
						},
					},
				},
			},
			-- Inspect: Statues / Skelly Statues Unlocked
			[589884] =
			{
				PlayOnce = true,
				UseText = "UseExamineMisc",
				SetupGameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "TrophyQuestComplete03" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "TrophyQuestComplete03" }, Min = 3 },
					},
				},
				InteractTextLineSets =
				{
					InspectSkellyStatues01 =
					{
						{ Cue = "/VO/Storyteller_0354",
							SkipPortrait = true, IsNarration = true,
							Emote = "PortraitEmoteSurprise",
							Text = "{#Emph}Oh, erm, eh, erm-erm-erm... So majestic in their poise are the three sculptures of our Princess of the Dead that they demand the reverence of any soul in their vicinity." },
						EndVoiceLines =
						{
							{
								PreLineWait = 0.4,
								UsePlayerSource = true,
								RequiredMinElapsedTime = 3,
								{ Cue = "/VO/Melinoe_4084", Text = "{#Emph}Reverence{#Prev}, huh...?" },
							},
							{
								PreLineWait = 0.35,
								ObjectType = "NPC_Skelly_01",

								{ Cue = "/VO/Skelly_0581", Text = "{#Emph}Yeah{#Prev}, just look at 'em!" },
							},
						},
					},
				},
			},

		},
	},

	-- Flashback01 Hub / Hecate Flashback
	Flashback_Hub_Main =
	{
		RichPresence = "#RichPresence_Dream",
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

		SpeakerName = { "Hecate", "Odysseus", "Hypnos", },
		LoadPackages = { "Hecate", "Odysseus", "Hypnos", },

		IgnoreStemMixer = true,
		IntroSequenceDuration = 2.0,
		DebugOnly = true,
		NoAutoEquip = true,
		FullscreenEffectGroup = "Foreground_01",

		BlockCombat = true,

		LegalEncounters = { "Empty", },

		AmbientMusicParams =
		{
			LowPass = 0.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/RunstartIntroAmbience",
		ReverbValue = 0.4,

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
					IgnorePackages = true,
				},
			},
			{
				FunctionName = "SetupFlashback01",
				Args =
				{
					Ids = { 583639 },
					NightmareMessage = "FlashbackMessage01",
					IgnorePackages = true,
					TextLineSet =
					{
						HecateHideAndSeekIntro01 =
						{
							{ Cue = "/VO/Storyteller_0235", IsNarration = true, SkipPortrait = true, LineHistoryName = "Speaker_Anonymous", SubtitleColor = Color.NarratorVoice, PreLineWait = 0.9,
								PostLineThreadedFunctionName = "CheckPriorityConversations",
								PostLineFunctionArgs =
								{
									Conversations =
									{
										"HecateHideAndSeek01",
										"HecateHideAndSeek02",
										"HecateHideAndSeek03",
										"HecateFlashback01",
									},
									IgnorePackages = true,
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
			-- Kitties
			[783240] =
			{
				Name = "FlashbackKitties01",

				DistanceTriggers =
				{
					{
						WithinDistance = 450,
						VoiceLines =
						{
							PlayOnce = true,
							BreakIfPlayed = true,
							UsePlayerSource = true,
							PreLineWait = 0.4,

							{ Cue = "/VO/Melinoe_4841", Text = "Hi, kitties!" },
						},
					},
				},
			},
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
						WithinDistance = 450,
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
						WithinDistance = 450,
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
							PreLineAngleHeroTowardTargetId = 575836,
							PreLineAnim = "Melinoe_Young_Brooding_Start", PreLineAnimTarget = "Hero",
							Text = "{#Emph}The keen-eyed Princess finds a set of tracks, suggesting that her foe trod through this dusty ground not very long before..." },
							{ Cue = "/VO/Melinoe_2105",
								AngleTowardTargetId = 576016,
								UsePlayerSource = true,
								SecretMusic = "/EmptyCue",
								StartSound = "/SFX/Menu Sounds/RecordScratch",
								PortraitExitAnimation = "Portrait_Mel_Child_01_Exit",
								PostLineAnim = "Melinoe_Young_Brooding_End", PostLineAnimTarget = "Hero",
								Speaker = "PlayerUnit_Flashback",
								Emote = "PortraitEmoteFiredUp",
								Text = "{#Emph}Shush{#Prev}, Homer! How shall I ever catch her if you're going to describe my every move?" },
							{ Cue = "/VO/Storyteller_0149", SkipPortrait = true, IsNarration = true,
								Emote = "PortraitEmoteSurprise",
								PostLineFunctionName = "UpdateHubMainFlashback",
								PostLineFunctionArgs = { InspectPoint = true },
								PostLineThreadedFunctionName = "CheckPriorityConversations",
								PostLineThreadedFunctionArgs = 
								{
									Conversations =
									{
										"OdysseusHideAndSeek01",
									},
									IgnorePackages = true,
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

	-- Flashback02 / Hades Flashback
	Flashback_DeathAreaBedroomHades =
	{
		RichPresence = "#RichPresence_Dream",
		HeroUnitName = "PlayerHadesFlashback",
		HeroOverwrites =
		{
			AttachedAnimationName = "nil",
			LineHistoryName = "NPC_Hades_01",
			SubtitleColor = Color.HadesVoice,
		},

		OnDeathLoadRequirements =
		{
			{
				NamedRequirements =  { "Flashback02Unlocked" },
			},
		},
		ZoomFraction = 1.0,
		SoftClamp = 0.75,
		EntranceFunctionName = "EnterHubRoomPresentation",

		-- NextRoomEntranceFunctionName = "LeavingBedroomHadesPresentation",

		LoadPackages = { "Hades", "Nyx", },
		
		IgnoreStemMixer = true,
		IntroSequenceDuration = 0.2,
		DebugOnly = true,
		NoAutoEquip = true,
		FullscreenEffectGroup = "Foreground_01",

		BlockCombat = true,

		LegalEncounters = { "Empty", },

		CheckObjectives = { "MetaPrompt", "BedPrompt" },

		StartUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					
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
				FunctionName = "SetupFlashback02",
				Args = { NightmareMessage = "NightmareMessage", NightmareMessageSubtitle = "NightmareMessage_Subtitle", SecretMusic = "/Music/MusicHadesReset2_MC" },
			},
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosNightmare01", },
					},
				},
				Args =
				{
					Ids = { 560340 },
				},
			},
			{
				FunctionName = "SurpriseNPCPresentation",
				Args =
				{
					SourceId = 560340,
					SkipPan = true,
					VoiceLines =
					{
						Queue = "Interrupt",
						{
							{
								PreLineWait = 2.75,
								ObjectType = "NPC_Hecate_01",

								{ Cue = "/VO/Hecate_0207", Text = "...But, Lord Hades, I..." },
							},
						},
					},
					TextLineSet =
					{
						HadesWithHecate01 =
						{
							{ Cue = "/VO/Hades_0048", Speaker = "NPC_LordHades_01", LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice, 
								Portrait = "Portrait_Hades_Past_01",
								PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
								Text = "...You have your orders. Now return to shadow. And, take care of her. For all of us." },
							{ Cue = "/VO/Hecate_0208", Speaker = "NPC_Hecate_01", 
								Portrait = "Portrait_Hec_Baby_01",
								PortraitExitAnimation = "Portrait_Hec_Baby_01_Exit",
								PostLineThreadedFunctionName = "HecateFlashback02Exit",
								Text = "No harm shall come to young Melinoë, my lord. In this, at least, I shall not fail you." },
							EndVoiceLines = 
							{
								{
									PreLineWait = 0.8,
									ObjectType = "NPC_Hecate_01",

									{ Cue = "/VO/Hecate_0209", Text = "Farewell..." },
								},
								{
									PreLineWait = 0.4,
									UsePlayerSource = true,

									{ Cue = "/VO/Hades_0017", Text = "Goodbye, Daughter..." },
								},
							},
						},
					}
				},
			},

		},

		ThreadedEvents =
		{
			{
				FunctionName = "Flashback02Objective",
				Args = { Delay = 11.0 },
			},
		},

		UnthreadedEvents =
		{

		},
		ObstacleData =
		{
			-- room exit
			[488298] =
			{
				OnUsedGameStateRequirements =
				{
					--
				},
				OnUsedFunctionName = "DeathAreaSwitchRoom",
				OnUsedFunctionArgs = { Name = "Flashback_DeathArea", HeroStartPoint = 555684, HeroEndPoint = 555685 },
				InteractDistance = 140,
				AutoActivate = true,
			},
		},

		EnterVoiceLines =
		{
			--
		},

		InspectPoints =
		{
			--
		},
	},

	-- Flashback02 -- Hub
	Flashback_DeathArea =
	{
		RichPresence = "#RichPresence_Dream",
		HeroUnitName = "PlayerHadesFlashback",

		ZoomFraction = 0.9,
		ZoomLerpTime = 2.0,
		CameraZoomWeights =
		{
			[40001] = 1.0,
			[210380] = 1.2,
			[50002] = 1.3,
			[555424] = 1.0,
		},
		SoftClamp = 0.75,
		CameraClamps = { 422043, 422045, 422046, 555683 },
		-- CameraClamps = { 422050, 422043, 422045, 422046, 422047 },
		FullscreenEffectGroup = "LoungeHider_01",

		BlockCombat = true,

		EntranceFunctionName = "EnterHubRoomPresentation",

		ReverbValue = 2.0,
		GlobalEcho = 0.1,

		IgnoreStemMixer = true,
		AmbientMusicParams =
		{
			LowPass = 0.0,
			Vocals = 1.0,
		},
		AmbientMusicVolume = 1.0,
		Ambience = "/Ambience/MusicExploration4Ambience",

		StartUnthreadedEvents =
		{

		},

		ThreadedEvents =
		{
			{
				FunctionName = "SetupFlashback02_DeathArea",
				Args = { NightmareMessage = "NightmareMessage", SecretMusic = "/Music/MusicHadesReset2_MC" },
				GameStateRequirements =
				{
				}
			},

		},

		UnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					Types =
					{
						"NPC_Nyx_01",
						"NPC_Chronos_Story_01",
					},
				},
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
		},

		RushMaxRangeOverride = 200,

		InspectPoints =
		{

		},

		ObstacleData =
		{

		},
	},

})

GlobalVoiceLines = GlobalVoiceLines or {}
GlobalVoiceLines.DeathVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "I_PostBoss01" },
		},
	},
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		-- PreLineWait = 0.25,
		SkipAnim = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Cleared" },
			},
		},

		{ Cue = "/VO/MelinoeField_3305", Text = "{#Emph}Ow...!" },
		{ Cue = "/VO/MelinoeField_3306", Text = "{#Emph}Ow!" },
		{ Cue = "/VO/MelinoeField_3307", Text = "{#Emph}What?!" },
		{ Cue = "/VO/MelinoeField_3308", Text = "{#Emph}Hey!" },
		{ Cue = "/VO/MelinoeField_3309", Text = "{#Emph}Gah!" },
		{ Cue = "/VO/MelinoeField_3310", Text = "{#Emph}Ouch!" },
	},
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		-- BreakIfPlayed = true,
		-- PreLineWait = 0.25,
		SkipAnim = true,

		{ Cue = "/VO/Melinoe_0123", Text = "Wha—?",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BountyCleared" }
				}
			}
		},
		{ Cue = "/VO/Melinoe_0125", Text = "{#Emph}Augh!" },
		{ Cue = "/VO/Melinoe_0126", Text = "{#Emph}Gaah!" },
		{ Cue = "/VO/MelinoeField_1384", Text = "{#Emph}Ungh!" },
		{ Cue = "/VO/Melinoe_0124", Text = "{#Emph}Ungh{#Prev}, no!",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BountyCleared" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1387", Text = "How—?",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BountyCleared" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1389", Text = "No!",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BountyCleared" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1390", Text = "{#Emph}Ngh{#Prev}, no...!",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BountyCleared" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_1388", Text = "You!!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "SurfacePenalty" },
				},
				{
					PathNotEmpty = { "RequiredKillEnemies" },
				},
				{
					PathFalse = { "CurrentRun", "BountyCleared" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3309", Text = "{#Emph}Gah!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "BountyCleared" }
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3305", Text = "{#Emph}Ow...!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "BountyCleared" }
				},
				{
					Path = { "GameState", "PackagedBountyClears" },
					UseLength = true,
					Comparison = ">=",
					Value = 4,
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3306", Text = "{#Emph}Ow!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "BountyCleared" }
				},
				{
					Path = { "GameState", "PackagedBountyClears" },
					UseLength = true,
					Comparison = ">=",
					Value = 4,
				},
			},
		},
		{ Cue = "/VO/MelinoeField_3310", Text = "{#Emph}Ouch!",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "BountyCleared" }
				},
				{
					Path = { "GameState", "PackagedBountyClears" },
					UseLength = true,
					Comparison = ">=",
					Value = 4,
				},
			},
		},
	},
}

-- death sequence voice lines (mel & other cases)
GlobalVoiceLines.DeathReturnVoiceLines =
{
	-- ???
	{
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 0.85,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Unnamed_01", SubtitleColor = Color.FatesVoice },
		GameStateRequirements = 
		{
			NamedRequirements = { "FatesDiscoveredTooSoon" }
		},

		{ Cue = "/VO/Moros_1020", Text = "Nothin' to see here! {#Emph}Bye!" },
		{ Cue = "/VO/Moros_1021", Text = "Hey! Go on. {#Emph}Get outta here!" },
		{ Cue = "/VO/Moros_1022", Text = "Could you mind your own business?" },
		{ Cue = "/VO/Moros_1023", Text = "You're early, go away!" },
	},
	-- hecate lines
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
				IsAny = { "F_Boss01", "F_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Hecate_0134", Text = "You must be stronger than this, Melinoë." },
		{ Cue = "/VO/Hecate_0137", Text = "Return and rest, and try again, Melinoë.", },
		{ Cue = "/VO/Hecate_0139", Text = "Consider the mistakes you made, Melinoë.", },
		{ Cue = "/VO/Hecate_0010", Text = "You're clearly unprepared as yet.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "RoomCountCache", "G_Intro" },
				},
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.33,
				},
			},
		 },
		{ Cue = "/VO/Hecate_0132", Text = "I know that you are stronger than this.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.25,
				},
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.25,
				},
			},
		},
		{ Cue = "/VO/Hecate_0133", Text = "I know you could have done better than that.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.4,
				},
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.25,
				},
			},
		},
		{ Cue = "/VO/Hecate_0135", Text = "A lesson learned, I trust?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 3,
				},
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">",
					Value = 0,
				},
			},
		},
		{ Cue = "/VO/Hecate_0136", Text = "The Moon was witness to our clash this night.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
				},
			},
		},
		{ Cue = "/VO/Hecate_0138", Text = "I take no joy in this, I hope you know.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.4,
				},
			},
		},
		{ Cue = "/VO/HecateField_0074", Text = "Collapsed under the pressure of it all...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.3,
				},
			},
		},
		{ Cue = "/VO/HecateField_0075", Text = "You almost had me! Not quite.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.25,
				},
			},
		},
		{ Cue = "/VO/HecateField_0076", Text = "So very close, and yet not strong enough.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
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
					Value = 0.33,
				},
				{
					Path = { "PrevRun", "BossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.5,
				},
				--[[
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "F_Boss01", Count = 1 },
				},
				]]--
			},
		},
		{ Cue = "/VO/HecateField_0078", Text = "Do not be disappointed; you fought well.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = "<=",
					Value = 0.33,
				},
			},
		},
		{ Cue = "/VO/HecateField_0079", Text = "You barely got to me at all that time.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Hecate" },
					Comparison = ">=",
					Value = 0.66,
				},
				{
					Path = { "GameState", "CompletedRunsCache" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
	},
	-- scylla lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Scylla_01", SubtitleColor = Color.ScyllaVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_Boss01", "G_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Scylla" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Scylla_0134", Text = "We're {#Emph}Scylla and the Sirens{#Prev}, everybody!!" },
		{ Cue = "/VO/Scylla_0135", Text = "Thank you, everybody! Good night!" },
		{ Cue = "/VO/Scylla_0136", Text = "{#Emph}Thank you, Oceanus!!", PlayFirst = true },
		{ Cue = "/VO/Scylla_0137", Text = "Hey, {#Emph}thanks {#Prev}for coming to our show!" },
		{ Cue = "/VO/Scylla_0264", Text = "Hey wait, don't go! We're just getting started!" },
		{ Cue = "/VO/Scylla_0265", Text = "Oh it's OK! Our latest jam isn't for everyone." },
		{ Cue = "/VO/Scylla_0266", Text = "No wait! We've still got more material to share!" },
		{ Cue = "/VO/Scylla_0267", Text = "Go on, {#Emph}run {#Prev}away! And tell {#Emph}everybody {#Prev}about us!" },
		{ Cue = "/VO/Scylla_0268", Text = "{#Emph}Heeheeheehee! {#Prev}Told you gals she couldn't handle {#Emph}us!" },
		{ Cue = "/VO/Scylla_0269", Text = "Do come on back, we're playing every night!" },
	},
	-- chronos lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Chronos_0197", Text = "An inevitable outcome, nothing more.", PlayFirst = true },
		{ Cue = "/VO/Chronos_0198", Text = "We must do this again some other time." },
		{ Cue = "/VO/Chronos_0199", Text = "No good shall come to those who swear allegiance to the gods." },
		{ Cue = "/VO/Chronos_0200", Text = "I had expected somewhat more from my own kin." },
		{ Cue = "/VO/Chronos_0201", Text = "What did you hope you would accomplish here?" },
		{ Cue = "/VO/Chronos_0202", Text = "Time may heal all wounds, or may inflict them just as readily." },
		{ Cue = "/VO/Chronos_0468", Text = "I alone shall not forget your meaningless efforts." },
		{ Cue = "/VO/Chronos_0469", Text = "As you can see, I am quite spry despite my age." },
		{ Cue = "/VO/Chronos_0470", Text = "Attack me all you like; I have all the time in the world." },
		{ Cue = "/VO/Chronos_0471", Text = "The youth of this age grow soft in body and in mind." },

		{ Cue = "/VO/Chronos_0257", Text = "The same predictable result, yet you persist.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0258", Text = "What did you expect would change this time?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0259", Text = "Once more you slip through my grasp, but I shall catch you yet.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0260", Text = "Again you have risked everything, only to fail ignobly.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0467", Text = "Thus history repeats as it is wont to do.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0472", Text = "You ought not have anticipated any other outcome.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0261", Text = "That is what you get for all the inconvenience you caused!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0262", Text = "Our previous engagement likewise ought have ended thus!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0263", Text = "Did you truly think you would prevail against me once more?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Chronos_0264", Text = "Ah, a bitter defeat! Now, that is more like it.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Name = "I_Boss01", Count = 1 },
				},
			},
		},
	},
	-- zagreus lines
	{
		Queue = "Always",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting02" },
			},
		},

		{ Cue = "/VO/MelinoeField_3435", Text = "From mists of memory, return to shadow, now...!", UsePlayerSource = true, },
		{ Cue = "/VO/Zagreus_0025", Text = "She's gone... it's only me again... hey when do I wake up...?",
			Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
			PreLineWait = 1.0,
			BreakIfPlayed = true,
		},
	},
	{
		Queue = "Always",
		BreakIfPlayed = true,
		PreLineWait = 0.4,
		Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "ZagreusPastMeeting04_2" },
			},
		},

		{ Cue = "/VO/Zagreus_0450", Text = "I'd settle for the latter bit..." },
	},
	{
		Queue = "Always",
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting03" },
			},
		},

		{ Cue = "/VO/Zagreus_0033", Text = "Sure thing! I think of weapons all the time!" },
	},
	{
		Queue = "Always",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting04" },
			},
		},

		{ Cue = "/VO/MelinoeField_3434", Text = "From mists of memory, return to shadow, now...", PlayFirst = true },
		{ Cue = "/VO/Zagreus_0041", Text = "Be safe out there!",
			Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
			PreLineWait = 0.5,
			BreakIfPlayed = true
		},
	},
	{
		Queue = "Always",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting05" },
			},
		},

		{ Cue = "/VO/MelinoeField_3436", Text = "From mists of memory, return to shadow, now.", UsePlayerSource = true },
		{ Cue = "/VO/Zagreus_0049", Text = "...She's gone again. {#Emph}Big brother... me...?",
			Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
			PreLineWait = 0.5,
			BreakIfPlayed = true,
		},
	},
	-- 06 intentionally missing (True Ending)
	{
		Queue = "Always",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting07" },
			},
		},

		{ Cue = "/VO/MelinoeField_3435", Text = "From mists of memory, return to shadow, now...!" },
		{ Cue = "/VO/Zagreus_0061", Text = "Wait was that her? What's going on. {#Emph}Melinoë...?",
			Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
			PreLineWait = 0.5,
			BreakIfPlayed = true,
		},
	},
	{
		Queue = "Always",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting08" },
			},
		},

		{ Cue = "/VO/MelinoeField_3434", Text = "From mists of memory, return to shadow, now..." },
		{ Cue = "/VO/Zagreus_0066", Text = "Wait are you there? Sister, are you there? {#Emph}Augh...",
			Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
			PreLineWait = 0.5,
			BreakIfPlayed = true,
		},
	},
	-- zagreus boss lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.35,
		Source = { LineHistoryName = "NPC_Zagreus_01", SubtitleColor = Color.ZagreusVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "C_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Zagreus" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Zagreus_0104", Text = "Good news! The terms of your Infernal Contract are fulfilled!", PlayFirst = true },
		{ Cue = "/VO/Zagreus_0105", Text = "I just beat up my little sister, everyone, thank you!" },
		{ Cue = "/VO/Zagreus_0310", Text = "Hey how'd you do that disappearing trick...?" },
		{ Cue = "/VO/Zagreus_0311", Text = "Did all you Shades enjoy our little show?" },
		{ Cue = "/VO/Zagreus_0312", Text = "Any other would-be challengers out there? No...?" },
		{ Cue = "/VO/Zagreus_0313", Text = "Been doing this since before you were born, Sister!" },
		{ Cue = "/VO/Zagreus_0317", Text = "They didn't make me Security Specialist for nothing!" },
		{ Cue = "/VO/Zagreus_0318", Text = "You're strong, Melinoë, but as it turns out I am also strong." },
	},
	-- medea lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		SuccessiveChanceToPlay = 0.66,
		SuccessiveChanceToPlayAll = 0.66,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Medea_01", SubtitleColor = Color.MedeaVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Medea_0368", Text = "A feast of freshly fallen blood for me..." },
		{ Cue = "/VO/Medea_0369", Text = "Well, Cyclops! We make a decent partnership." },
		{ Cue = "/VO/Medea_0371", Text = "See you some other night then, sorceress!" },
		{ Cue = "/VO/Medea_0372", Text = "And thus once more, the will of Night is done." },
		{ Cue = "/VO/Medea_0570", Text = "You spent all of the blood you had to spare..." },
		{ Cue = "/VO/Medea_0571", Text = "Do not lament this outcome. Draw from it!" },
		{ Cue = "/VO/Medea_0572", Text = "Your mind was clouded tonight, sorceress." },
		{ Cue = "/VO/Medea_0573", Text = "Great Hecate, this victory is mine...!", PlayFirst = true },
		{ Cue = "/VO/Medea_0574", Text = "I may lack your divinity, but I make do." },
	},
	-- polyphemus lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.6,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Cyclops_01", SubtitleColor = Color.PolyphemusVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_Boss01", "N_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
				Comparison = ">",
				Value = 0,
			},
		},

		{ Cue = "/VO/Polyphemus_0089", Text = "Get your hindquarters out of my town." },
		{ Cue = "/VO/Polyphemus_0090", Text = "That ought to teach you." },
		{ Cue = "/VO/Polyphemus_0091", Text = "You mess with my sheep, I mess with {#Emph}you." },
		{ Cue = "/VO/Polyphemus_0092", Text = "Chow time... wait, where'd you go?", PlayFirst = true },
		{ Cue = "/VO/Polyphemus_0093", Text = "{#Emph}Urgh {#Prev}where'd she go that time?" },
		{ Cue = "/VO/Polyphemus_0094", Text = "Worked up a real appetite back there." },
		{ Cue = "/VO/Polyphemus_0095", Text = "Nobody messes with my sheep." },
		{ Cue = "/VO/Polyphemus_0096", Text = "So much for my meal ticket huh." },
		{ Cue = "/VO/Polyphemus_0097", Text = "Get back here, you little..." },
		{ Cue = "/VO/Polyphemus_0098", Text = "Sounds like we're done here, huh." },
	},
	-- eris lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Eris_01", SubtitleColor = Color.ErisVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01", "O_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
				Comparison = ">",
				Value = 0,
			},
		},
		{ Cue = "/VO/ErisField_0122", Text = "{#Emph}Return to shadow, now!" },
		{ Cue = "/VO/ErisField_0123", Text = "{#Emph}Return to shadow, now...!" },
		{ Cue = "/VO/ErisField_0124", Text = "That's right, Miss Perfect, go on home and {#Emph}cry." },
		{ Cue = "/VO/ErisField_0125", Text = "{#Emph}Aha, haha! {#Prev}Got so far, only to trip and fall!", PlayFirst = true },
		{ Cue = "/VO/ErisField_0126", Text = "Sorry, babe, but that's the way it goes!" },
		{ Cue = "/VO/ErisField_0127", Text = "Same time, same place tomorrow night, Trouble?" },
		{ Cue = "/VO/ErisField_0128", Text = "Don't hate me, babe! I'm just being {#Emph}me!" },
		{ Cue = "/VO/ErisField_0129", Text = "We have {#Emph}got {#Prev}to do this again sometime, OK?" },
	},
	-- heracles lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Heracles_01", SubtitleColor = Color.HeraclesVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_Boss01" },
			},
			{
				Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
				Comparison = ">=",
				Value = 3,
			},
			{
				PathFalse = { "CurrentRun", "EnemyKills", "Heracles" }
			},
		},

		{ Cue = "/VO/Heracles_0403", Text = "Be grateful that I didn't crush your every bone." },
		{ Cue = "/VO/Heracles_0401", Text = "Got her, Flame Thief. Only took the both of us.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "EnemyKills", "Prometheus" }
				},
			},
		},
		{ Cue = "/VO/Heracles_0404", Text = "You may have taken Flame Thief there, but not me.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "EnemyKills", "Prometheus" }
				},
			},
		},
		{ Cue = "/VO/Heracles_0405", Text = "Looks like she's gone, Prometheus. Now what...?",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "EnemyKills", "Prometheus" }
				},
			},
		},
		{ Cue = "/VO/Heracles_0406", Text = "You said that we'd lose, Prometheus. To... make us {#Emph}win?",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "EnemyKills", "Prometheus" }
				},
			},
		},
	},
	-- prometheus lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.55,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "NPC_Prometheus_01", SubtitleColor = Color.PrometheusVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
				Comparison = ">",
				Value = 0,
			},
		},
		{ Cue = "/VO/Prometheus_0111", Text = "There was no dignity in this at all.", PlayFirst = true },
		{ Cue = "/VO/Prometheus_0112", Text = "I had no other means to drive you back." },
		{ Cue = "/VO/Prometheus_0113", Text = "She's gone for now, Aetos, but she'll return..." },
		{ Cue = "/VO/Prometheus_0163", Text = "I'll tear the gods apart with my bare hands..." },
		{ Cue = "/VO/Prometheus_0164", Text = "There wasn't anything you could have done." },
		{ Cue = "/VO/Prometheus_0165", Text = "Your boundless pride won't save you anymore." },
		{ Cue = "/VO/Prometheus_0474", Text = "This needed to be done... I know you'll understand." },
		{ Cue = "/VO/Prometheus_0475", Text = "I'll never serve the gods; only the future." },
		{ Cue = "/VO/Prometheus_0477", Text = "Well done, Aetos... we played our part for now." },
		{ Cue = "/VO/Prometheus_0476", Text = "We got her there, big man... good mercenary work.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 3,
				},
				{
					PathFalse = { "CurrentRun", "EnemyKills", "Heracles" }
				},
			},
		},
		{ Cue = "/VO/Prometheus_0166", Text = "I know your every move; whilst you know nothing.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "P_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Prometheus_0167", Text = "Another night, the same exact outcome.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "P_Boss01", Count = 2 },
				},
			},
		},
		{ Cue = "/VO/Prometheus_0168", Text = "My master shall be very pleased with this result.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "P_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Prometheus_0291", Text = "{#Emph}Hah, hahaha...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveDeathsInRoom",
					FunctionArgs = { Name = "P_Boss01", Count = 3 },
				},
			},
		},
		{ Cue = "/VO/Prometheus_0169", Text = "I knew eventually I would prevail again.",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Name = "P_Boss01", Count = 2 },
				},
			},
		},
		{ Cue = "/VO/Prometheus_0170", Text = "You grew too comfortable with all your victories.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Prometheus" },
					Comparison = ">=",
					Value = 5,
				},
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Name = "P_Boss01", Count = 1 },
				},
			},
		},
		{ Cue = "/VO/Prometheus_0171", Text = "Complacency leads to a downfall soon enough.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredConsecutiveClearsOfRoom",
					FunctionArgs = { Name = "P_Boss01", Count = 2 },
				},
			},
		},
	},
	-- typhon lines
	{
		Queue = "Interrupt",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		NoTarget = true,
		SkipAnim = true,
		Source = { LineHistoryName = "TyphonHead", SubtitleColor = Color.TyphonVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_Boss01", "Q_Boss02" },
			},
			{
				PathFalse = { "CurrentRun", "EnemyKills", "TyphonHead" }
			},
		},

		{ Cue = "/VO/Typhon_0031", Text = "{#TyphonFormat}HAAAAAH..." },
		{ Cue = "/VO/Typhon_0032", Text = "{#TyphonFormat}HEHHHHH..." },
		{ Cue = "/VO/Typhon_0033", Text = "{#TyphonFormat}SSSOOOOON..." },
		{ Cue = "/VO/Typhon_0034", Text = "{#TyphonFormat}MOOOOORE..." },
		{ Cue = "/VO/Typhon_0035", Text = "{#TyphonFormat}PAAAAAIN..." },
		{ Cue = "/VO/Typhon_0036", Text = "{#TyphonFormat}RAAAAAGE...!" },
		{ Cue = "/VO/Typhon_0037", Text = "{#TyphonFormat}KILLLLL...!" },
		{ Cue = "/VO/Typhon_0038", Text = "{#TyphonFormat}HAAAAATE...!" },
		{ Cue = "/VO/Typhon_0039", Text = "{#TyphonFormat}DIIIIIE...!", PlayFirst = true },
	},
	-- arachne lines
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
	-- @ ending
	{
		Queue = "Always",
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Cleared" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_PostBoss01" },
			},
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
		},

		{ Cue = "/VO/MelinoeField_3434", Text = "From mists of memory, return to shadow, now...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_3435", Text = "From mists of memory, return to shadow, now...!" },
		{ Cue = "/VO/MelinoeField_3436", Text = "From mists of memory, return to shadow, now." },
	},
	{
		Queue = "Always",
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Cleared" },
			},
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_Story01" },
			},			
		},

		{ Cue = "/VO/MelinoeField_3836", Text = "Return to shadow, now." },
		{ Cue = "/VO/MelinoeField_3837", Text = "Return to shadow, now." },
		{ Cue = "/VO/MelinoeField_3838", Text = "Return to shadow, now." },
		{ Cue = "/VO/MelinoeField_3839", Text = "Return to shadow, now." },
	},
	-- mel lines, after a clear, post-true-ending
	{
		Queue = "Always",
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Cleared" },
			},
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasAny = { "/VO/Storyteller_0321", "/VO/Storyteller_0486" },
			},
		},
		{ Cue = "/VO/MelinoeField_4315", Text = "{#Emph}<Yawn> {#Prev}Return to shadow, now..." },
	},
	{
		Queue = "Always",
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Cleared" },
			},
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},
		{ Cue = "/VO/MelinoeField_3311", Text = "Return to shadow... now." },
		{ Cue = "/VO/MelinoeField_3312", Text = "Return to shadow, now..." },
		{ Cue = "/VO/MelinoeField_3313", Text = "Return to shadow, now?" },
		{ Cue = "/VO/MelinoeField_3314", Text = "Return to shadow, now!" },
		{ Cue = "/VO/MelinoeField_3836", Text = "Return to shadow, now." },
		{ Cue = "/VO/MelinoeField_3837", Text = "Return to shadow, now." },
		{ Cue = "/VO/MelinoeField_3838", Text = "Return to shadow, now." },
		{ Cue = "/VO/MelinoeField_3839", Text = "Return to shadow, now." },
		{ Cue = "/VO/Melinoe_1694", Text = "Return to shadow, now.",
			PlayFirst = true, },
	},
	-- mel lines, first run
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
	-- surface penalty
	{
		Queue = "Always",
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.33,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
			},
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
		},

		{ Cue = "/VO/MelinoeField_4316", Text = "{#Emph}<Gasp> {#Prev}Return to shadow, now...!" },
	},
	-- mel lines
	{
		Queue = "Always",
		BreakIfPlayed = true,
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				--
			},
		},

		{ Cue = "/VO/Melinoe_1695", Text = "Return to shadow, now...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_1693", Text = "Return to shadow, now!" },
		{ Cue = "/VO/Melinoe_1696", Text = "Return to shadow, now..." },
		{ Cue = "/VO/MelinoeField_1393", Text = "Return to shadow, now...!" },
		{ Cue = "/VO/MelinoeField_1392", Text = "Return to shadow, now...!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "H_Boss01", "H_Boss02", "I_Boss01", "P_Boss01", "Q_MiniBoss01", "Q_MiniBoss02", "Q_MiniBoss03", "Q_MiniBoss04", "Q_MiniBoss05", "Q_Boss01", "Q_Boss02" },
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
	},
}

-- respawn lines / respawn voice lines
GlobalVoiceLines.EnteredDeathAreaVoiceLines =
{
	Queue = "Always",
	-- respawn lines
	-- first hub visit
	TriggerCooldowns = { "DoraAnyQuipSpeech" },
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech", Time = 4 },
	},
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
			PostLineFunctionName = "FrogFamiliarReaction",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "Cleared" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2994", Text = "All right.",
			BreakIfPlayed = true,
			PostLineFunctionName = "FrogFamiliarReaction",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "Cleared" },
				},
			},
		},
	},
	-- epilogue
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "FatesEpilogue01" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 1.0,

		{ Cue = "/VO/Melinoe_4882", Text = "{#Emph}Mmm{#Prev}, I'll have to keep working on that. On both counts." },
	},
	-- post-moros sighting 1
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosGrantsQuestLog" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 1.0,

		{ Cue = "/VO/Melinoe_1584", Text = "{#Emph}Ungh... {#Prev}he's gone..." },
	},
	-- post-moros sighting 2
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosSecondAppearance" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 2.2,

		{ Cue = "/VO/Melinoe_1871", Text = "{#Emph}Ungh... {#Prev}where did he go?" },
	},
	-- true ending path - underworld - cleared the run
	{
		PlayOnce = true,
		PlayOnceContext = "SurfaceClearCriticalPathVO",
		BreakIfPlayed = true,
		PreLineWait = 1.2,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "I_PostBoss01" },
			},
			{
				Path = { "CurrentRun" },
				HasAny = { "Cleared" }
			},
		},

		-- pastfirstmeeting
		{ Cue = "/VO/Melinoe_4831", Text = "{#Emph}<Gasp> {#Prev}...Brother... I found him...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "RoomsEntered", "I_PostBoss01" },
				},
			},
		},
		-- pastmeeting02
		{ Cue = "/VO/Melinoe_5707", Text = "{#Emph}<Gasp> {#Prev}Zagreus... I'm counting on you...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting02" },
				},
			},
		},
		-- pastmeeting02_2
		{ Cue = "/VO/Melinoe_5769", Text = "{#Emph}<Gasp> {#Prev}...To hell and back... the heavens next?",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting02_2" },
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasNone = {
						"ZeusPalaceFirstMeeting",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_5766", Text = "{#Emph}<Gasp> {#Prev}...Work with me, Brother...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting02_2" },
				},
			},
		},
		-- pastmeeting03
		{ Cue = "/VO/Melinoe_5765", Text = "{#Emph}<Gasp> {#Prev}...I'm getting through to him... I think.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting03" }
				},
			},
		},

		-- pastmeeting04
		{ Cue = "/VO/Melinoe_5767", Text = "{#Emph}<Gasp> {#Prev}...Perhaps a visit to Olympus next...?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting04" }
				},
				{
					Path = { "GameState", "TextLinesRecord" },
					HasNone = {
						"ZeusPalaceMeeting02",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_4833", Text = "{#Emph}<Gasp> {#Prev}...Zagreus... be careful.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting04" }
				},
			},
		},

		-- pastmeeting04_2
		{ Cue = "/VO/Melinoe_5725", Text = "{#Emph}<Gasp> {#Prev}...Brother... we shouldn't be fighting...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting04_2" }
				},
			},
		},

		-- pastmeeting04_3
		{ Cue = "/VO/Melinoe_5727", Text = "{#Emph}<Gasp> {#Prev}...That's a bit more like it.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting04_3" }
				},
			},
		},

		-- pastmeeting05
		{ Cue = "/VO/Melinoe_4839", Text = "{#Emph}<Gasp> {#Prev}...Should have what I need now.",
			PostLineFunctionName = "FrogFamiliarReaction",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "TextLinesRecord", "ZagreusPastMeeting05" },
				},
				{
					PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeStormStop" },
				},
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Ids = { 566831 } },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5768", Text = "{#Emph}<Gasp> {#Prev}...I felt... I'm needed on the surface now.",
			PostLineFunctionName = "FrogFamiliarReaction",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Ids = { 566831 } },
				},
				OrRequirements =
				{
					{
						{
							Path = { "CurrentRun", "TextLinesRecord" },
							HasAny = {
								"ZagreusPastMeeting05"
							},
						},
						{
							PathFalse = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeStormStop" },
						},
					},
					{
						{
							PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
						},
						{
							Path = { "CurrentRun", "TextLinesRecord" },
							HasAny = {
								"ZagreusPastMeeting05",
								"ZagreusPastMeeting07",
								"ZagreusPastMeeting08",
								"ZagreusPastMeetingRepeatable01",
								"ZagreusPastMeetingRepeatable02",
								"ZagreusPastMeetingRepeatable03",
								"ZagreusPastMeetingRepeatable04",
								"ZagreusPastMeetingRepeatable05",
							},
						},
					},
				},
			},
		},

		-- pastmeeting07 + & optional
		{ Cue = "/VO/Melinoe_4836", Text = "{#Emph}<Gasp> {#Prev}...I should come back to him. Olympus first.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting07" },
				},
				{
					PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4832", Text = "{#Emph}<Gasp> {#Prev}...From out of the abyss...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasAny = {
						"ZagreusPastMeeting07",
						"ZagreusPastMeeting08",
						"ZagreusPastMeetingRepeatable01",
						"ZagreusPastMeetingRepeatable02",
						"ZagreusPastMeetingRepeatable03",
						"ZagreusPastMeetingRepeatable04",
						"ZagreusPastMeetingRepeatable05",
					},
				},
			},
		},
		{ Cue = "/VO/Melinoe_4835", Text = "{#Emph}<Gasp> {#Prev}...We're counting on you, Brother...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasAny = {
						"ZagreusPastMeeting07",
						"ZagreusPastMeeting08",
						"ZagreusPastMeetingRepeatable01",
						"ZagreusPastMeetingRepeatable02",
						"ZagreusPastMeetingRepeatable03",
						"ZagreusPastMeetingRepeatable04",
						"ZagreusPastMeetingRepeatable05",
					},
				},
			},
		},

	},
	-- true ending path - surface - cleared the run
	{
		PlayOnce = true,
		PlayOnceContext = "SurfaceClearCriticalPathVO",
		BreakIfPlayed = true,
		PreLineWait = 1.2,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "Q_Story01" },
			},
			{
				Path = { "CurrentRun" },
				HasAny = { "Cleared" }
			},
		},

		{ Cue = "/VO/Melinoe_4837", Text = "{#Emph}<Gasp> {#Prev}...Should check with Headmistress.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "RoomsEntered", "Q_Story01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4838", Text = "{#Emph}Mm... {#Prev}back from the Palace...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "RoomsEntered", "Q_Story01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5770", Text = "{#Emph}Mm... {#Prev}closer to the incantations we require.",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "RoomsEntered", "Q_Story01" },
				},
				{
					Path = { "GameState", "WorldUpgradesRevealed" },
					HasAll = { "WorldUpgradeTimeStop", "WorldUpgradeStormStop" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4834", Text = "{#Emph}<Gasp> {#Prev}...We're getting somewhere...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "RoomsEntered", "Q_Story01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5708", Text = "{#Emph}<Gasp> {#Prev}Keep holding on, everyone...",
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "RoomsEntered", "Q_Story01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4839", Text = "{#Emph}<Gasp> {#Prev}...Should have what I need now.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "LifetimeResourcesGained", "MixerMythic" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},


	},
	-- post-moros relationship
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "MorosBecomingCloser01" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 2.2,

		{ Cue = "/VO/Melinoe_4748", Text = "{#Emph}<Gasp> {#Prev}Oh...! {#Emph}Hm...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesChoiceRecord", "MorosBecomingCloser01", },
					IsAny = { "Choice_MorosAccept" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2401", Text = "{#Emph}<Gasp> <Sigh>",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesChoiceRecord", "MorosBecomingCloser01", },
					IsAny = { "Choice_MorosDecline" },
				},
			},
		},
	},
	-- post-flashback01
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

		{ Cue = "/VO/Melinoe_2130", Text = "{#Emph}Ungh... {#Prev}Death to Chronos..." },
	},
	-- post-flashback02
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "TextLinesRecord", "ChronosNightmare01" },
			},
		},
		PlayOnce = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
	
		{ Cue = "/VO/Melinoe_0373", Text = "{#Emph}<Gasp> {#Prev}...Father..." },
	},
	-- artemis singing
	{
		PlayOnce = true,
		PlayOnceContext = "ArtemisSingingIntro",
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.3,
		GameStateRequirements =
		{
			{
				Path = { "AudioState", "AmbientTrackName" },
				IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
			},
		},

		{ Cue = "/VO/Melinoe_4023", Text = "{#Emph}Ungh... {#Prev}is that... singing...?", PlayFirst = true },
		{ Cue = "/VO/Melinoe_4024", Text = "{#Emph}Augh... {#Prev}hey... Artemis..." },
	},
	{
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		RandomRemaining = true,
		SuccessiveChanceToPlayAll = 0.33,
		ObjectType = "NPC_Dora_01",
		RequiredSourceValueFalse = "InPartnerConversation",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAll = { "DoraGift04" },
			},
			{
				FunctionName = "RequiredQueuedTextLine",
				FunctionArgs = { IsNone = { "DoraAboutPrometheus02", "DoraAboutReturning03", "DoraAboutShades04", "DoraAboutShades04_B" } },
			},
			{
				SumPrevRuns = 4,
				Path = { "SpeechRecord" },
				TableValuesToCount = { "/VO/Dora_0281", "/VO/Dora_0282", "/VO/Dora_0283", "/VO/Dora_0284", "/VO/Dora_0285", "/VO/Dora_0286" },
				Comparison = "<=",
				Value = 0,
			},
			NamedRequirementsFalse = { "DoraMemoryQuestResolutionInProgress" },
			ChanceToPlay = 0.33,
		},
	
		{ Cue = "/VO/Dora_0281", Text = "{#Emph}Wakey, wakey..." },
		{ Cue = "/VO/Dora_0282", Text = "{#Emph}Wakey, wakey...!" },
		{ Cue = "/VO/Dora_0283", Text = "Mel... wake up." },
		{ Cue = "/VO/Dora_0284", Text = "Mel, wake up!" },
		{ Cue = "/VO/Dora_0285", Text = "{#Emph}Awaken!",
			PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
		{ Cue = "/VO/Dora_0286", Text = "{#Emph}Arise!",
			PreLineFunctionName = "GenericPresentation", PreLineFunctionArgs = PresetAudioArgs.DoraScaryAppearArgs, },
	},
	-- cleared the run / run cleared lines / after a clear
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 1.2,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "RoomsEntered" },
				HasAny = { "I_Boss01", "Q_Boss01", "Q_Boss02" },
			},
			{
				Path = { "CurrentRun" },
				HasAny = { "Cleared" }
			},
		},

		{ Cue = "/VO/Melinoe_1872", Text = "{#Emph}Eugh... {#Prev}what just happened?" },
		{ Cue = "/VO/Melinoe_1873", Text = "{#Emph}Augh... {#Prev}so that's the way it is."	},
		{ Cue = "/VO/Melinoe_2567", Text = "{#Emph}Mmph... {#Prev}adequate.",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_2568", Text = "{#Emph}Whew. {#Prev}Not a bad night, I guess." },
		{ Cue = "/VO/Melinoe_2399", Text = "{#Emph}Mmph... {#Prev}well {#Emph}that {#Prev}was productive." },
		{ Cue = "/VO/Melinoe_3646", Text = "{#Emph}<Sigh> {#Prev}As it should be.",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_3647", Text = "{#Emph}<Sigh> {#Prev}A night well spent.", PlayFirst = true,
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_3648", Text = "{#Emph}<Sigh> {#Prev}A good night's rest!",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_3649", Text = "{#Emph}<Sigh> {#Prev}Another eventful night." },
		{ Cue = "/VO/Melinoe_3650", Text = "{#Emph}<Sigh> {#Prev}The task proceeds..." },
		{ Cue = "/VO/Melinoe_2569", Text = "...The Fates were on my side.", PreLineWait = 2.0,
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_2570", Text = "...I did all right that time...", PreLineWait = 2.0,
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_3643", Text = "{#Emph}Mm... {#Prev}good enough.",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_3644", Text = "...That's more like it.", PreLineWait = 2.1,
			GameStateRequirements =
			{
				{
					PathFalse = { "PrevRun", "Cleared" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3645", Text = "Just need to keep that up.", PreLineWait = 2.1,
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_5150", Text = "{#Emph}<Sigh> {#Prev}Properly done.",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_5151", Text = "{#Emph}<Sigh> {#Prev}One more then?" },
		{ Cue = "/VO/Melinoe_5152", Text = "{#Emph}<Sigh> {#Prev}That was good.",
			GameStateRequirements =
			{
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_5154", Text = "{#Emph}<Sigh> {#Prev}One after another...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "PrevRun", "Cleared" },
				},
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_5149", Text = "{#Emph}<Sigh> {#Prev}That's more like it.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "PrevRun" },
					HasNone = { "Cleared", "BountyCleared" }
				},
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
		{ Cue = "/VO/Melinoe_5153", Text = "{#Emph}<Sigh> {#Prev}We did it, Frinos.",
			PostLineFunctionName = "FrogFamiliarReaction",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Ids = { 566831 } },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4834", Text = "{#Emph}<Gasp> {#Prev}...We're getting somewhere...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					FunctionName = "RequireRunsSinceTextLines",
					FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 9 },
				},
				NamedRequirementsFalse = { "StalledProgressWithZagreus" },
			},
		},
	},
	-- packaged bounty cleared
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BountyCleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,

		{ Cue = "/VO/Melinoe_3042", Text = "{#Emph}Whew... {#Prev}Chaos Trial, check.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2703", Text = "{#Emph}Mm... {#Prev}Chaos got their way." },
		{ Cue = "/VO/Melinoe_2705", Text = "{#Emph}Mmph... {#Prev}thank you, Chaos..." },
		{ Cue = "/VO/Melinoe_2760", Text = "{#Emph}Nngh... {#Prev}Chaos shall be pleased." },
		{ Cue = "/VO/Melinoe_2761", Text = "{#Emph}Ungh... {#Prev}did what I had to do." },
		{ Cue = "/VO/Melinoe_3043", Text = "{#Emph}Mhm... {#Prev}another Chaos Trial down." },
		{ Cue = "/VO/Melinoe_3044", Text = "{#Emph}Nngh... {#Prev}Chaos Trial done..." },
		{ Cue = "/VO/Melinoe_3045", Text = "{#Emph}Whew... {#Prev}Trial complete..." },
		{ Cue = "/VO/Melinoe_3046", Text = "{#Emph}Mph... {#Prev}Trial finished." },
		{ Cue = "/VO/Melinoe_3047", Text = "{#Emph}Hm... {#Prev}Trial, done." },
		{ Cue = "/VO/Melinoe_3048", Text = "{#Emph}Nngh... {#Prev}cheers, Chaos." },
		{ Cue = "/VO/Melinoe_4832", Text = "{#Emph}<Gasp> {#Prev}...From out of the abyss...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" },
				},
				{
					FunctionName = "RequireRunsSinceTextLines",
					FunctionArgs = { TextLines = { "TrueEndingFinale01" }, Min = 9 },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2704", Text = "{#Emph}Whew... {#Prev}mission complete...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/Melinoe_0978", "/VO/Melinoe_0979", "/VO/Melinoe_0980" },
				},
			},
		},
	},
	-- lost near True Ending
	{
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
			{
				PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.25,

		{ Cue = "/VO/Melinoe_5129", Text = "{#Emph}<Gasp> {#Prev}No... again...!" },
		{ Cue = "/VO/Melinoe_5130", Text = "{#Emph}<Gasp> Urgh..." },
	},
	-- lost (partly) due to Chaos Curse
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "TookChaosCurseDamage" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2700", Text = "{#Emph}Urgh... {#Prev}the mark of Chaos..." },
		{ Cue = "/VO/Melinoe_2701", Text = "{#Emph}Oof... {#Prev}careless with Chaos..." },
	},
	-- lost due to BiomeTimer
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "KilledByName", },
				IsAny = { "BiomeTimer" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3053", Text = "{#Emph}Ungh... {#Prev}Time got the best of me for sure...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3054", Text = "{#Emph}Ngh... {#Prev}just wasn't swift enough..." },
		{ Cue = "/VO/Melinoe_3055", Text = "{#Emph}Augh... {#Prev}need to be faster still." },
		{ Cue = "/VO/Melinoe_3056", Text = "{#Emph}Urgh... {#Prev}I blame the Oath... or me." },
		{ Cue = "/VO/Melinoe_3057", Text = "{#Emph}Rngh... {#Prev}I brought that on myself." },
	},

	-- nightmare occurred
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "NightmareOccurred" },
			},
			{
				PathFalse = { "CurrentRun", "RoomsEntered", "I_Boss01" },
			},			
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.33,
		PreLineWait = 1.0,
	
		{ Cue = "/VO/Melinoe_2131", Text = "{#Emph}Augh... {#Prev}get out of my head...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2635", Text = "{#Emph}Eugh... {#Prev}just another nightmare..." },
	},
	-- minibosses
	-- lost to Erebus minibosses
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
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_MiniBoss03", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_5131", Text = "{#Emph}Mmph... {#Prev}Master-Slicer got a piece of me..." },
		{ Cue = "/VO/Melinoe_5132", Text = "{#Emph}Argh... {#Prev}good bladework, I admit..." },
	},
	-- lost to Oceanus minibosses
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_MiniBoss01", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2265", Text = "{#Emph}Ungh... {#Prev}that Sea-Serpent...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2266", Text = "{#Emph}Mmph... {#Prev}Sea-Serpents, I swear..." },
	},	
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_MiniBoss02", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2263", Text = "{#Emph}Ugh... {#Prev}that thing was evil...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2264", Text = "{#Emph}Urgh... {#Prev}that was terrifying..." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_MiniBoss03", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3948", Text = "{#Emph}Eugh... {#Prev}that stings..." },
		{ Cue = "/VO/Melinoe_3949", Text = "{#Emph}Brr... {#Prev}disgusting things..." },
	},
	-- lost to Fields minibosses
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_MiniBoss01", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2754", Text = "{#Emph}Rngh... {#Prev}that blood-sucking..." },
		{ Cue = "/VO/Melinoe_2755", Text = "{#Emph}Eugh... {#Prev}I don't like Phantom lairs...", PlayFirst = true },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_MiniBoss02", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2756", Text = "{#Emph}Ugh... {#Prev}blasted Lamia...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2757", Text = "{#Emph}Augh... {#Prev}all those snakes..." },
	},
	-- lost to Tartarus minibosses
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_MiniBoss01", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3038", Text = "{#Emph}Urgh... {#Prev}Satyrs..." },
		{ Cue = "/VO/Melinoe_3039", Text = "{#Emph}Augh... {#Prev}cheers to the Verminancer then..." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_MiniBoss02", },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3040", Text = "{#Emph}Eugh... {#Prev}I'll make that Goldwrath pay..." },
		{ Cue = "/VO/Melinoe_3041", Text = "{#Emph}Ngh... {#Prev}so close to Chronos there..." },
	},
	-- lost to Ephyra minibosses
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_MiniBoss01", "I_MiniBoss01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2573", Text = "{#Emph}Eugh... {#Prev}that wretched Satyr...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3038", Text = "{#Emph}Urgh... {#Prev}Satyrs..." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_MiniBoss02" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_5133", Text = "{#Emph}Augh... {#Prev}the tusks on that thing..." },
		{ Cue = "/VO/Melinoe_5134", Text = "{#Emph}Guh... {#Prev}I got the hooves..." },
	},
	-- lost to Thessaly minibosses
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_MiniBoss01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3167", Text = "{#Emph}Guh... {#Prev}Charybdis claims another sailor, then..." },
		{ Cue = "/VO/Melinoe_3168", Text = "{#Emph}Eugh... {#Prev}to think such things are living in the sea..." },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_MiniBoss02" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_4123", Text = "{#Emph}Argh... {#Prev}that sea-captain..." },
	},
	-- lost to Olympus minibosses
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_MiniBoss01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3635", Text = "{#Emph}Ugh... {#Prev}don't think I like Automatons..." },
		{ Cue = "/VO/Melinoe_3636", Text = "{#Emph}Tsch... {#Prev}Talos took me for a common foe...", PlayFirst = true },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_MiniBoss02" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3637", Text = "{#Emph}Aah... {#Prev}fell to a flying lizard..." },
		{ Cue = "/VO/Melinoe_3638", Text = "{#Emph}Ngh... {#Prev}just couldn't take the heat..." },
	},
	-- lost to Summit minibosses
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_MiniBoss02" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_4118", Text = "{#Emph}Eugh... {#Prev}monster breath..." },
		{ Cue = "/VO/Melinoe_4119", Text = "{#Emph}Rngh... {#Prev}blasted monstrosity...", PlayFirst = true },
	},
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "Q_MiniBoss05" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_4120", Text = "{#Emph}Augh... {#Prev}dislike those two...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_4121", Text = "{#Emph}Ngh... {#Prev}blasted broodlings..." },
	},
	-- bosses
	-- lost to hecate
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Boss01", "F_Boss02" },
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
		{ Cue = "/VO/Melinoe_0370", Text = "{#Emph}Augh{#Prev}, she's... strong.",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Hecate_0134" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5117", Text = "{#Emph}Ungh... {#Prev}just like old times...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Melinoe_5118", Text = "{#Emph}Ungh... {#Prev}her true strength...?",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
	},
	-- lost to scylla
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_Boss01", "G_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Scylla" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2259", Text = "{#Emph}Nrgh... {#Prev}blast those Sirens.", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2260", Text = "{#Emph}Ungh... {#Prev}I'm not a fan." },
		{ Cue = "/VO/Melinoe_2261", Text = "{#Emph}Ngh... {#Prev}what is her problem?" },
		{ Cue = "/VO/Melinoe_2262", Text = "{#Emph}Augh... {#Prev}beaten by Scylla?" },

		{ Cue = "/VO/Melinoe_5119", Text = "{#Emph}Guh... {#Prev}I prefer their smaller shows...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
		{ Cue = "/VO/Melinoe_5120", Text = "{#Emph}Ngh... {#Prev}I had nowhere to go...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 2,
				},
			},
		},
	},
	-- lost to cerberus
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_Boss01", "H_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "InfestedCerberus" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2750", Text = "{#Emph}Augh... {#Prev}we'll fix this, Cerberus...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "ReachedTrueEnding" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2751", Text = "{#Emph}Ungh... {#Prev}Cerberus just doing his job..." },
		{ Cue = "/VO/Melinoe_2694", Text = "{#Emph}Augh... {#Prev}blasted beast..."	},
		{ Cue = "/VO/Melinoe_2695", Text = "{#Emph}Ungh... {#Prev}bad dog..." },

		{ Cue = "/VO/Melinoe_5123", Text = "{#Emph}Ungh... {#Prev}what's gotten into him...?",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Melinoe_5124", Text = "{#Emph}Whew... {#Prev}too hot back there.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},

		{ Cue = "/VO/Melinoe_2696", Text = "{#Emph}Urgh... {#Prev}bad boy...",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "EnemyKills", "InfestedCerberus" }
				}
			},
		},
		{ Cue = "/VO/Melinoe_2697", Text = "{#Emph}Urgh... {#Prev}bad boy... boys...?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_2696" }
				}
			}
		},
	},
	-- lost to chronos
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2805", Text = "{#Emph}Augh... {#Prev}I could have had him...!" },
		{ Cue = "/VO/Melinoe_2806", Text = "{#Emph}Ungh... {#Prev}I had him in my grasp!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_2129", Text = "{#Emph}No... {#Prev}how long has it been...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 4,
				},
			},
		},
		{ Cue = "/VO/Melinoe_2807", Text = "{#Emph}Ngh... {#Prev}no, I could have beaten him!", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BossHealthBarRecord", "Chronos" },
					Comparison = "<",
					Value = 0.4,
				},
			}
		},
		{ Cue = "/VO/Melinoe_2808", Text = "{#Emph}Gah...! {#Prev}Again!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "I_Boss01" },
					Comparison = ">=",
					Value = 3,
				},
			}
		},
	},
	-- lost to polyphemus
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_Boss01", "N_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Polyphemus" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_0371", Text = "{#Emph}Augh{#Prev}, beaten by a Cyclops, then?" },
		{ Cue = "/VO/Melinoe_0372", Text = "{#Emph}Eugh{#Prev}, ate me alive back there..." },
		{ Cue = "/VO/Melinoe_2571", Text = "{#Emph}Augh... {#Prev}he hits hard..." },
		{ Cue = "/VO/Melinoe_2752", Text = "{#Emph}Urgh... {#Prev}he had me figured out..." },
		{ Cue = "/VO/Melinoe_2753", Text = "{#Emph}Ungh... {#Prev}barely escaped from him..." },

		{ Cue = "/VO/Melinoe_5121", Text = "{#Emph}Eugh... {#Prev}I still feel nauseous...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
			},
		},
		{ Cue = "/VO/Melinoe_5122", Text = "{#Emph}Bleh... {#Prev}they're an odd pairing...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 1,
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_5121" },
				},
			},
		},
	},
	-- lost to eris
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01", "O_Boss02" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Eris" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3163", Text = "{#Emph}Ungh... {#Prev}damn it, Eris...!", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3164", Text = "{#Emph}Augh... {#Prev}Eris and her blasted Rail..." },
		{ Cue = "/VO/Melinoe_3165", Text = "{#Emph}Ngh... {#Prev}to be beaten by {#Emph}her...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3166", Text = "{#Emph}Tsch... {#Prev}she had a blast at my expense again..." },
	},
	-- lost to prometheus
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Prometheus" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3631", Text = "{#Emph}Ngh... {#Prev}he saw right through me...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3632", Text = "{#Emph}<Scoff> {#Prev}He knew he'd win..." },
		{ Cue = "/VO/Melinoe_3633", Text = "{#Emph}Guh... {#Prev}Prometheus..." },
		{ Cue = "/VO/Melinoe_3634", Text = "{#Emph}Augh... {#Prev}these Titans..." },
		{ Cue = "/VO/Melinoe_5125", Text = "{#Emph}Eugh... {#Prev}Prometheus is more than enough...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Melinoe_5126", Text = "{#Emph}Eugh... {#Prev}don't know which one is worse...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
	},
	-- lost on the summit
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "Q" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3943", Text = "{#Emph}Ungh... {#Prev}Olympus...! No...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3945", Text = "{#Emph}Ngh...! {#Prev}Gods be safe...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3944", Text = "{#Emph}<Gasp> {#Prev}Typhon...",
			GameStateRequirements = 
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3942", Text = "{#Emph}Eyah! {#Prev}...That... monster...",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3946", Text = "{#Emph}Rngh... {#Prev}that... {#Emph}thing...",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_MiniBoss03", "Q_MiniBoss04" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_3947", Text = "{#Emph}Augh... {#Prev}so near the top...",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "RoomsEntered" },
					HasNone = { "Q_PostBoss01" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_4245", Text = "{#Emph}Ngh... {#Prev}he's... just another foe. He can be slain.",
			PostLineFunctionName = "FrogFamiliarReaction",
			GameStateRequirements = 
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss01", "Q_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5127", Text = "{#Emph}Nngh... {#Prev}my greatest foes at once...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "Q_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_5128", Text = "{#Emph}Argh... {#Prev}what a nightmare...",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ShrineUpgradesCache", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 4,
				},
			},
		},
	},
	-- lost to the champion of elysium
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "C_Boss01" },
			},
			{
				Path = { "CurrentRun", "BossHealthBarRecord", "Zagreus" },
				Comparison = ">",
				Value = 0,
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_5135", Text = "{#Emph}Nngh... {#Prev}I {#Emph}did {#Prev}hear he was strong...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_5136", Text = "{#Emph}Argh... {#Prev}got me {#Emph}good{#Prev}, Brother..." },
		{ Cue = "/VO/Melinoe_5137", Text = "{#Emph}Augh... {#Prev}next match is mine, Brother..." },
		{ Cue = "/VO/Melinoe_5138", Text = "{#Emph}Oof... {#Prev}well he {#Emph}is {#Prev}Security Specialist..." },
	},
	-- almost beat boss
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
				IsAny = { "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "O_Boss01", "O_Boss02", "P_Boss01", "Q_Boss01", "Q_Boss02" },
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
					IsAny = { "H_Boss01", "H_Boss02", "I_Boss01", "N_Boss01", "N_Boss02", "P_Boss01", "Q_Boss01", "Q_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2639", Text = "{#Emph}Khh... {#Prev}almost had her...!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "F_Boss01", "F_Boss02", "G_Boss01", "G_Boss02", "O_Boss01", "O_Boss02" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2640", Text = "{#Emph}Ngh... {#Prev}just when I thought..." },
		{ Cue = "/VO/Melinoe_2641", Text = "{#Emph}Eugh... {#Prev}thought I had that..." },
	},
	-- other encounters
	-- lost in devotion encounter
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "DevotionTestF", "DevotionTestG", "DevotionTestH", "DevotionTestI", "DevotionTestN", "DevotionTestO", "DevotionTestP" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_1876", Text = "...The gods don't like me very much I guess." },
	},
	-- other encounters
	-- lost in artemis encounter
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
	-- lost in nemesis encounter
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "NemesisCombatIntro", "NemesisCombatF", "NemesisCombatG", "NemesisCombatH", "NemesisCombatI" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2267", Text = "{#Emph}Eugh... {#Prev}damn it, Nemesis..." },
	},
	-- lost in anomaly encounter
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Encounter", "Name" },
				IsAny = { "GeneratedAnomalyB" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2268", Text = "{#Emph}<Gasp> {#Prev}...that was too real..." },
	},
	-- packaged bounties not cleared / failed chaos trial / lost to chaos trial
	-- multiple losses
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "ActiveBountyAttempts" },
				Comparison = ">=",
				ValuePath = { "CurrentRun", "ActiveBountyClears" },
				ValuePathAddition = 4,
			},
			{
				PathTrue = { "CurrentRun", "ActiveBounty" },
			},
			{
				PathFalse = { "CurrentRun", "BountyCleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_3489", Text = "{#Emph}Ungh... {#Prev}perhaps that Trial and I need a break..." },
		{ Cue = "/VO/Melinoe_3490", Text = "{#Emph}Ngh... {#Prev}why keep bashing my head against that one...?" },
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "ActiveBounty" },
			},
			{
				PathFalse = { "CurrentRun", "BountyCleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2706", Text = "{#Emph}Ungh... {#Prev}have to try that one again..." },
		{ Cue = "/VO/Melinoe_2707", Text = "{#Emph}Augh... {#Prev}was not an easy mission..." },
		{ Cue = "/VO/Melinoe_2708", Text = "{#Emph}Eugh... {#Prev}apologies, Chaos..." },
		{ Cue = "/VO/Melinoe_2709", Text = "{#Emph}<Gasp>... {#Prev}what happened there..." },
		{ Cue = "/VO/Melinoe_2632", Text = "{#Emph}Mm... {#Prev}no mere vision, was it?" },
		{ Cue = "/VO/Melinoe_2633", Text = "{#Emph}Augh... {#Prev}my head still aches..." },
		{ Cue = "/VO/Melinoe_2634", Text = "{#Emph}Ungh... {#Prev}was like a vivid dream..." },
		{ Cue = "/VO/Melinoe_3049", Text = "{#Emph}Augh... {#Prev}was not an easy Trial..." },
		{ Cue = "/VO/Melinoe_3050", Text = "{#Emph}Eugh... {#Prev}not a successful Trial..." },
		{ Cue = "/VO/Melinoe_3051", Text = "{#Emph}Ungh... {#Prev}Trial incomplete...", PlayFirst = true },
		{ Cue = "/VO/Melinoe_3052", Text = "{#Emph}Ngh... {#Prev}apologies, almighty Chaos." },
		{ Cue = "/VO/Melinoe_2707", Text = "{#Emph}Augh... {#Prev}was not an easy mission...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "ActiveBounty" },
					IsAny = { "PackageBountyRandomUnderworld_Difficulty2", "PackageBountyRandomSurface_Difficulty2" },
				},
			},
		},
	},

	-- failed on surface (cursed, etc.)
	{
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.33,

		-- { Cue = "/VO/Melinoe_0567", Text = "Rngh... the surface... I..." },
		{ Cue = "/VO/Melinoe_2423", Text = "{#Emph}<Gasp> {#Prev}...I couldn't breathe...", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2424", Text = "Has to be a way I can survive up there...",
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
				},
			},
		},
		{ Cue = "/VO/Melinoe_2572", Text = "{#Emph}Augh... {#Prev}so that's the surface, then...", PlayOnce = true },
	},
	-- lost in Thessaly
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "O_Intro" },
			},
			{
				Path = { "CurrentRun", "RoomsEntered" },
				HasNone = { "O_Boss01", "O_Boss02" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "O_Devotion01" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_3169", Text = "{#Emph}Oof... {#Prev}still feel a bit sea-sick from that..." },
		{ Cue = "/VO/Melinoe_4122", Text = "{#Emph}Urgh... {#Prev}went overboard..." },
	},	
	-- lost in Fields
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "H" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Melinoe_2698", Text = "{#Emph}Eugh... {#Prev}come so far..." },
		{ Cue = "/VO/Melinoe_2699", Text = "{#Emph}Mmph... {#Prev}not happy...", PlayFirst = true },
	},
	-- lost in Tartarus, misc.
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "RoomsEntered", "I_Story01" },
			},
			{
				PathFalse = { "CurrentRun", "Cleared" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_2930", Text = "{#Emph}Ungh... {#Prev}wait for me, Father..." },
	},
	-- lost in Olympus, misc.
	{
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
				IsAny = { "P", "Q" },
			},
		},
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlayAll = 0.1,

		{ Cue = "/VO/Melinoe_3641", Text = "{#Emph}Augh... {#Prev}what happened up there...?" },
		{ Cue = "/VO/Melinoe_3642", Text = "{#Emph}<Scoff> {#Prev}That's Olympus..." },

		{ Cue = "/VO/Melinoe_3639", Text = "{#Emph}Guh... {#Prev}back down to earth." },
		{ Cue = "/VO/Melinoe_3640", Text = "{#Emph}Hrm... {#Prev}so close to the summit...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "BiomeDepthCache" },
					Comparison = ">=",
					Value = 4,
				},
				{
					PathFalse = { "CurrentRun", "RoomsEntered", "Q_Intro" }
				},
			},
		},
	},
	-- artemis
	{
		GameStateRequirements =
		{
			{
				Path = { "AudioState", "AmbientTrackName" },
				IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
			},
		},
		BreakIfPlayed = true,
		PreLineWait = 1.0,
		SuccessiveChanceToPlay = 0.2,
	
		{ Cue = "/VO/Melinoe_4024", Text = "{#Emph}Augh... {#Prev}hey... Artemis..." },
	},
	-- lost in misc. ways
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

		{ Cue = "/VO/Melinoe_3556", Text = "{#Emph}Ungh... {#Prev}Frinos, you there...?",
			PostLineFunctionName = "FrogFamiliarReaction",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Ids = { 566831 } },
				},
			},
		},
		{ Cue = "/VO/Melinoe_0099", Text = "{#Emph}<Gasp> Ungh...", PreLineWait = 0.5 },
		{ Cue = "/VO/Melinoe_0008_V3", Text = "{#Emph}<Gasp> Augh...", PreLineWait = 0.5,
			GameStateRequirements =
			{
				{
					Path = { "GameState", "CompletedRunsCache", },
					Comparison = ">=",
					Value = 10,
				},
			},
		},
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
		{ Cue = "/VO/Melinoe_0374", Text = "{#Emph}<Gasp> <Scoff>" },
		{ Cue = "/VO/Melinoe_2397", Text = "{#Emph}Ngh{#Prev}... rise and shine..." },
		{ Cue = "/VO/Melinoe_2398", Text = "{#Emph}Eugh{#Prev}... what a night." },
		{ Cue = "/VO/Melinoe_2400", Text = "{#Emph}Ah{#Prev}... hm." },
		{ Cue = "/VO/Melinoe_2401", Text = "{#Emph}<Gasp> <Sigh>" },
		{ Cue = "/VO/Melinoe_2402", Text = "{#Emph}<Gasp> <Chuckle>" },
		{ Cue = "/VO/Melinoe_2710", Text = "{#Emph}Nngh... {#Prev}back already." },
		{ Cue = "/VO/Melinoe_2711", Text = "{#Emph}Augh... {#Prev}another night." },
		{ Cue = "/VO/Melinoe_5141", Text = "{#Emph}Nngh... {#Prev}blast..." },
		{ Cue = "/VO/Melinoe_5142", Text = "{#Emph}Augh... {#Prev}not quite..." },
		{ Cue = "/VO/Melinoe_5143", Text = "{#Emph}Rngh... {#Prev}not that time..." },
		{ Cue = "/VO/Melinoe_5144", Text = "{#Emph}<Scoff> <Sigh>" },
		{ Cue = "/VO/Melinoe_5146", Text = "{#Emph}Nngh... {#Prev}oh well..." },
		{ Cue = "/VO/Melinoe_5147", Text = "{#Emph}Mmm... {#Prev}just not my night..." },
		{ Cue = "/VO/Melinoe_5148", Text = "{#Emph}Hrnn... ow..." },
		{ Cue = "/VO/Melinoe_5145", Text = "{#Emph}Eugh... {#Prev}not my best, Frinos...",
			PostLineFunctionName = "FrogFamiliarReaction",
			GameStateRequirements =
			{
				{
					FunctionName = "RequiredAlive",
					FunctionArgs = { Ids = { 566831 } },
				},
			},
		},
	},
}
