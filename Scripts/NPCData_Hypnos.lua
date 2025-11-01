UnitSetData.NPC_Hypnos =
{
	-- Hypnos, Id = 370024
	NPC_Hypnos_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		UseText = "NPCUseTextTalkAlt",
		Portrait = "Portrait_Hypnos_Sleeping_01",
		SubtitleColor = Color.HypnosVoice,
		AnimOffsetZ = 50,
		AnimOffsetX = 20,
		EmoteOffsetX = 50,
		EmoteOffsetY = -370,
		-- EndTextLinesThreadedFunctionName = "HypnosReturnToSleep",
		EndTextLinesFunctionArgs =
		{
			HighChanceToPlay = 0.85,
			LowChanceToPlay = 0.3,
			RandomWaitMin = 5.0,
			RandomWaitMax = 10.0,
			OutsideDistance = 450,
			OutsideVfx = "StatusSleeping",
			OutsideGlobalVoiceLines = "HypnosDozingOffVoiceLines",
			InsideDistance = 320,
			InsideGlobalVoiceLines = "HypnosAwakenedVoiceLines",
			InsideVfx = "StatusAwakened",
		},

		Groups = { "NPCs" },
		SpeakerName = "Hypnos",
		LoadPackages = { "Hypnos" },

		ActivateRequirements =
		{
			{
				PathFalse = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
			},
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Hypnos_01" },
				Comparison = ">=",
				Value = 2,
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				UsePlayerSource = true,
				-- RandomRemaining = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "SessionState", "InDreamSequence" }
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/Melinoe_3576", Text = "Not a care in the world." },
				{ Cue = "/VO/Melinoe_3577", Text = "You're safe here..." },
			},
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				UsePlayerSource = true,
				-- RandomRemaining = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "SessionState", "InDreamSequence" }
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/Melinoe_1883", Text = "Rest easy, Son of Nyx.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3573", Text = "Sleep well." },
				{ Cue = "/VO/Melinoe_3574", Text = "Pleasant dreams." },
				{ Cue = "/VO/Melinoe_3575", Text = "You look comfortable." },
				{ Cue = "/VO/Melinoe_3576", Text = "Not a care in the world." },
				{ Cue = "/VO/Melinoe_3577", Text = "You're safe here..." },
				{ Cue = "/VO/Melinoe_3578", Text = "Moonlight guide you." },
			},
		},

		InteractTextLineSets =
		{
			HypnosFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,

				{ Cue = "/VO/Hypnos_0004",
					-- Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Zzzz, mm-hm, hmm..." },

				{ Cue = "/VO/Melinoe_0088", UsePlayerSource = true,
					-- PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					-- PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "We'll find a way to wake you, O Sleep. I promise." },
			},

			HypnosAboutPoppies01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_Hypnos",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosGift02" }
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "PlantIPoppy" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "GameState", "WorldUpgrades", "WorldUpgradeWakeHypnos" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,

				{ Cue = "/VO/Hypnos_0008",
					Text = "{#Emph}Zzzz... hmm, zzzz..." },

				{ Cue = "/VO/Melinoe_3910", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Casual_01", WaitTime = 9.1 },

					Text = "Lord Hypnos, when I was in Tartarus, I found some seeds, which grew into Poppies... like the ones that line your bedding there. What if I used them with... {#Emph}<Gasp> {#Prev}I just had an idea...!" },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "WorldUpgradeWakeHypnos" },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.0,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3911", Text = "...I promise to be careful." },
					}
				},
			},

			HypnosAboutUltimateProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasAny = 
						{
							"ZagreusPastFirstMeeting",
							"ZagreusPastMeeting02",
							"ZagreusPastMeeting03",
							"ZagreusPastMeeting04",
							"ZagreusPastMeeting05",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,

				{ Cue = "/VO/Hypnos_0007_A",
					Text = "{#Emph}Zzzzz... zzz..." },

				{ Cue = "/VO/Melinoe_5679", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I mustn't speak of this, Lord Hypnos, but... I was able to descend to the abyss of the subconscious, and I found my brother there...! Thank you for sparking my fascination with dream. All that I've worked for... last night, it felt in reach!" },
			},
			HypnosAboutUltimateProgress02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,

				{ Cue = "/VO/Hypnos_0006_B",
					Text = "{#Emph}Zzz... zzzzz..." },

				{ Cue = "/VO/Melinoe_5680_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I never could delve into the abyss of the subconscious with {#Emph}you{#Prev}, O Sleep. With my brother, the path was so clear...! Well we shall find another way." },
			},

			HypnosPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,

				{ Cue = "/VO/Hypnos_0007_B",
					Text = "{#Emph}Zzzz... zzzz..." },

				{ Cue = "/VO/Melinoe_5682", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Your mother and the rest are safe, Lord Hypnos! They'll surely be expecting your return, and presumed you'd wake after all this, but... you're still sound asleep. Well don't worry... I made you a promise, and I intend to keep it." },
			},
			HypnosPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AchillesTrueEnding01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,

				{ Cue = "/VO/Hypnos_0007_C",
					Text = "{#Emph}Zzzz... zzz... zzzz..." },

				{ Cue = "/VO/Melinoe_5747", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My memories of you from that potential past I experienced in the House of Hades... you were... so {#Emph}different{#Prev}, Lord Hypnos. Who {#Emph}are {#Prev}you, truly...? How can I finally get through to you...?" },
			},

			HypnosAboutStoryReset01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "StoryResetCount" },
						Comparison = ">=",
						Value = 1,
					},
					{
						SumPrevRuns = 4,
						Path = { "UsedStoryReset" },
						IgnoreCurrentRun = true,
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesRevealed", "WorldUpgradeWakeHypnos" }
					},
					{
						-- has hypnos ever woken up?
						PathTrue = { "GameState", "AchievementsUnlocked", "AchHelpHypnos" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,

				{ Cue = "/VO/Hypnos_0006_B",
					Text = "{#Emph}Zzzzz, zzzzz{#Prev}..." },

				{ Cue = "/VO/Melinoe_5778", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Hypnos, for a moment, I thought... I almost forgot you were still here, as though... I dreamt you had already woken up...? {#Emph}Augh{#Prev}, it's nonsense. I must be weary." },
			},

			HypnosHideAndSeek01 =
			{
				PlayOnce = true,
				SkipNextTextLinesCheck = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						Path = { "CurrentHubRoom", "Name" },
						IsAny = { "Flashback_Hub_Main" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				EndFunctionName = "UpdateHubMainFlashback",
				EndFunctionArgs = { Hypnos = true },

				{ Cue = "/VO/Hypnos_0003",
					Text = "{#Emph}Zzz, zzzzz..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2272", Text = "I bid you farewell for now, Lord Hypnos!" },
						{ Cue = "/VO/Melinoe_2109", Text = "Where could she be...", PreLineWait = 3.1 },
					},
				},
			},

			-- partner conversations
			NemesisWithHypnos01 =
			{
				Partner = "NPC_Nemesis_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PostBlockSpecialInteract = true,
			},
			MorosWithHypnos01 =
			{
				Partner = "NPC_Moros_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PostBlockSpecialInteract = true,
			},

			-- Repeatable
			HypnosSleepingChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0002",
					Text = "{#Emph}Zzzz, zzzz..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat02 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0003",
					Text = "{#Emph}Zzz, zzzzz..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat03 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0005",
					Text = "{#Emph}Zzzz... hm, hm, hm, hm, hm..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat04 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0008",
					Text = "{#Emph}Zzzz... hmm, zzzz..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat05 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0009",
					Text = "{#Emph}Zzzz... hm, zzzz..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat06 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0010",
					Text = "{#Emph}Hm-hm, zzzz... hm, zzz, hmhmhm...." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat07 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Hypnos_0007_B",
					Text = "{#Emph}Zzzz... zzzz..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat08 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastFirstMeeting" },
					},
				},
				{ Cue = "/VO/Hypnos_0007_A",
					Text = "{#Emph}Zzzzz... zzz..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
		},

		GiftTextLineSets =
		{
			HypnosWakeUp01 =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				Cost =
				{
					HypnosPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWakeHypnos" }
					},
				},

				{ Cue = "/VO/Hypnos_0013",
					-- Emote = "PortraitEmoteDepressed",
					PreLineFunctionName = "PauseMusicianMusic",
					Text = "{#Emph}Zzz... mm, hmm... zzz... hmhm..." },

				{ Cue = "/VO/Melinoe_3681", UsePlayerSource = true,
					SkipContextArt = true,
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "HypnosDream01StartPresentation",
					PortraitExitAnimation = "Portrait_Mel_Default_01_Exit",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Please work... {#Prev}Lord Hypnos, you have slumbered long enough! I know you're lost in dream, but I shall do my best to lead you back here to reality. Now breathe in deep!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.65,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3682", Text = "Is this...? Where am I?" },
					},
				},
				-- leads to HypnosDreamMeeting01
			},
			HypnosWakeUp02 =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				Cost =
				{
					HypnosPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWakeHypnosT2" }
					},
				},

				{ Cue = "/VO/Hypnos_0019",
					-- Emote = "PortraitEmoteDepressed",
					PreLineFunctionName = "PauseMusicianMusic",
					Text = "{#Emph}Zzz... hmmm, hm-hm..." },

				{ Cue = "/VO/Melinoe_4638", UsePlayerSource = true,
					SkipContextArt = true,
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "HypnosDream01StartPresentation",
					PortraitExitAnimation = "Portrait_Mel_Default_01_Exit",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "All right, Lord Hypnos, let's give this a new attempt. We have to get you out of there, but first, breathe deep." },
				-- leads to HypnosDreamMeeting02, which leads to HypnosWakeUp02_B
			},

			-- @ ending
			HypnosWakeUp03 =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				Cost =
				{
					HypnosPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "WorldUpgradeWakeHypnosT3" }
					},
				},

				{ Cue = "/VO/Hypnos_0030",
					-- Emote = "PortraitEmoteDepressed",
					PreLineFunctionName = "PauseMusicianMusic",
					Text = "{#Emph}Hmmm... tsk, tsk, hm... zzz..." },

				{ Cue = "/VO/Melinoe_4707", UsePlayerSource = true,
					SkipContextArt = true,
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "HypnosDream01StartPresentation",
					PortraitExitAnimation = "Portrait_Mel_Default_01_Exit",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know how it goes, Lord Hypnos, and you had better comply because, I'll admit, I'm growing just a bit impatient here. Now breathe deep!" },
				-- leads to HypnosDreamMeeting03, which leads to HypnosWakeUp03_B
			},

			HypnosGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				PostBlockSpecialInteract = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hypnos_01" },
					},
				},
				{ Cue = "/VO/Melinoe_3385", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "May you have pleasant dreams for as long as you slumber. And if and when you finally wake... know that this Nectar shall be waiting for you." },
				{ Cue = "/VO/Hypnos_0011",
					Text = "{#Emph}Zzzzz, welcome... to the haah, hm, zzzz..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3482", Text = "Wait, welcome to the {#Emph}what...?" },
					},
				},
			},
			HypnosGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				PostBlockSpecialInteract = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hypnos_01" },
					},
				},
				{ Cue = "/VO/Melinoe_3386", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So often has my sleep been wracked with nightmares... memories, perhaps, of when Headmistress took me in. If your dreams are troubled too, O Sleep... you show no sign of it, at least." },
				{ Cue = "/VO/Hypnos_0012",
					Text = "{#Emph}Zzz... have... zzz... you tried... zzzz..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3483", Text = "Did he just... have I tried what...?" },
					},
				},

			},

		},

	},

	-- Dream Hypnos 1
	NPC_Hypnos_02 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		UseText = "NPCUseTextTalkAlt",
		Portrait = "Portrait_Hypnos_Sleeping_01",
		SubtitleColor = Color.HypnosVoice,
		AnimOffsetZ = 100,
		EmoteOffsetX = -20,
		EmoteOffsetY = -160,
		Groups = { "NPCs" },
		SpeakerName = "Hypnos",

		ActivateRequirements =
		{
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{ GlobalVoiceLines = "HypnosDreamSaluteVoiceLines" }
		},

		InteractTextLineSets =
		{
			HypnosDreamMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp01" },
					},
				},

				{ Cue = "/VO/Hypnos_0014",
					SkipContextArt = true,
					Text = "{#Emph}Zzzz... welcome to the how... zzz..." },

				{ Cue = "/VO/Melinoe_3684", UsePlayerSource = true,
					SkipContextArt = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He said {#Emph}how? {#Prev}He's... trying to communicate! Lord Hypnos, I'm Melinoë, daughter of Hades, and I mean to find a way to rouse you from your slumber! Can you hear me?" },

				{ Cue = "/VO/Hypnos_0015",
					SkipContextArt = true,
					Text = "{#Emph}Zzzz... a wake I'm a wake I... haha hm, zzz..." },

				{ Cue = "/VO/Melinoe_3685", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How is it that you sleep, even in dream? What can I do to bring you back to us? Because we need you... your own sister tells me that your wisdom and knowledge are second to none!" },

				{ Cue = "/VO/Hypnos_0016",
					SkipContextArt = true,
					Text = "{#Emph}Zzzz... so you walked... zzz... straight into... zzz..." },

				{ Cue = "/VO/Melinoe_3686", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I walked straight into {#Emph}what? {#Prev}Lord Hypnos, I don't understand. You have to snap out of this! My time here runs short, and if this doesn't work, I... don't know what else to do..." },

				{ Cue = "/VO/Hypnos_0017",
					SkipContextArt = true,
					PortraitExitAnimation = "Portrait_Hypnos_Sleeping_01_Exit",
					Text = "{#Emph}Zzz... dream... come... true... zzz... thanks... zzz... for stopping... by... zzz..." },

				{ Cue = "/VO/Hypnos_0018",
					PreLineFunctionName = "HypnosDream01EndPresentation",
					PreLineWait = 0.35,
					Text = "{#Emph}Zzzz... hmm, tsk-tsk, hm... zzz..." },

				{ Cue = "/VO/Melinoe_3688", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle",
					PreLineAnimTarget = "Hero",
					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostDreamArgs,
					PostLineFunctionName = "ResumeMusicianMusic",
					Text = "No, his consciousness, it... slipped away from me. How am I... {#Emph}augh{#Prev}. I need to think..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.46,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3689", Text = "...Pleasant dreams, for now..." },
					},
				},
			},

			-- 2nd visit
			HypnosDreamMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp02" },
					},
				},

				{ Cue = "/VO/Hypnos_0023",
					SkipContextArt = true,
					Text = "{#Emph}Zzz... welcome to the... thanks... for dying..." },

				{ Cue = "/VO/Melinoe_4641", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I've something for you here, one moment please..." },
			},

			-- @ ending
			-- 3rd visit
			HypnosDreamMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03" },
					},
				},

				{ Cue = "/VO/Melinoe_4710", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It is past time for you to wake." },
			},
		},

		GiftTextLineSets =
		{
			-- 2nd visit
			HypnosWakeUp02_B =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				SkipContextArt = true,
				Cost =
				{
					HypnosPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp02" }
					},
				},

				{ Cue = "/VO/Hypnos_0022",
					-- Emote = "PortraitEmoteDepressed",
					PreLineFunctionName = "PauseMusicianMusic",
					Text = "{#Emph}Zzz... died... again... hm..." },

				{ Cue = "/VO/Melinoe_4642", UsePlayerSource = true,
					SkipContextArt = true,
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "HypnosDream02StartPresentation",
					PortraitExitAnimation = "Portrait_Mel_Default_01_Exit",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If you are dreaming even here, then I must ask if I could see into your psyche deeper still, Lord Hypnos. Whether you let me in is up to you, but once again... breathe deep." },
				-- leads to HypnosDreamMeeting02_B
			},

			-- @ ending
			-- 3rd visit
			HypnosWakeUp03_B =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				SkipContextArt = true,
				Cost =
				{
					HypnosPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03" }
					},
				},

				{ Cue = "/VO/Hypnos_0033",
					SkipContextArt = true,
					Text = "{#Emph}Zzz... my list it... never..." },

				{ Cue = "/VO/Melinoe_4711", UsePlayerSource = true,
					SkipContextArt = true,
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "HypnosDream02StartPresentation",
					PortraitExitAnimation = "Portrait_Mel_Default_01_Exit",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I must see deeper into your psyche once again, my lord, so forgive the intrusion, and... here we go." },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.65,
						UsePlayerSource = true,
					},
				},
				-- leads to HypnosDreamMeeting03_C
			},

		},
	},

	-- Dream Hypnos 2
	NPC_Hypnos_03 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		UseText = "NPCUseTextTalkAlt",
		Portrait = "Portrait_Hypnos_Sleeping_01",
		SubtitleColor = Color.HypnosVoice,
		AnimOffsetZ = 100,
		EmoteOffsetX = -20,
		EmoteOffsetY = -160,
		Groups = { "NPCs" },
		SpeakerName = "Hypnos",

		ActivateRequirements =
		{
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{ GlobalVoiceLines = "HypnosDreamSaluteVoiceLines" }
		},

		InteractTextLineSets =
		{
			HypnosDreamMeeting02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp02_B" },
					},
				},

				{ Cue = "/VO/Hypnos_0026",
					SkipContextArt = true,
					Text = "{#Emph}Zzz... there is... no esc... hhnnn..." },

				{ Cue = "/VO/Melinoe_4647", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Hypnos? Lord Hypnos! Can you hear me? Answer me! {#Emph}Anything? {#Prev}A twitch of the eye? Oh, come on, {#Emph}please!" },

				{ Cue = "/VO/Hypnos_0027",
					SkipContextArt = true,
					PreLineWait = 0.35,
					Text = "{#Emph}Zzz... won't catch... mmssllppnnhhh..." },

				{ Cue = "/VO/Melinoe_4648", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "He's dreaming about... sleeping? Or about {#Emph}dreaming? {#Prev}This is beyond me still. How far has he descended...?" },

				{ Cue = "/VO/Hypnos_0028",
					SkipContextArt = true,
					PreLineWait = 0.35,
					PortraitExitAnimation = "Portrait_Hypnos_Sleeping_01_Exit",
					Text = "{#Emph}Zzz... good old... thanuhtose... busy... allatime..." },

				{ Cue = "/VO/Hypnos_0029",
					PreLineFunctionName = "HypnosDream01EndPresentation",
					PreLineFunctionArgs = { WaitTime = 3.8 },
					PreLineWait = 0.35,
					Text = "{#Emph}Hnn...?! Hhnnnhh..." },

				{ Cue = "/VO/Melinoe_4650", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle",
					PreLineAnimTarget = "Hero",
					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostDreamArgs,
					PostLineFunctionName = "ResumeMusicianMusic",
					Text = "{#Emph}Augh. {#Prev}Got farther that time, but... how many dreams are you {#Emph}having? {#Prev}But if you're dreaming of Death, perhaps... {#Emph}hm..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.46,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4651", Text = "Sleep well for now, my lord." },
					},
				},
			},

			HypnosDreamMeeting03_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03_B" },
					},
				},

				{ Cue = "/VO/Melinoe_4714", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You are very stubborn, my lord..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.46,
						UsePlayerSource = true,
						-- { Cue = "/VO/Melinoe_3689", Text = "...Pleasant dreams, for now..." },
					},
				},
			},


		},

		GiftTextLineSets =
		{
			-- @ ending
			HypnosWakeUp03_C =
			{
				PlayOnce = true,
				OnGiftTrack = false,
				Cost =
				{
					HypnosPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03" }
					},
				},

				{ Cue = "/VO/Melinoe_4715", UsePlayerSource = true,
					SkipContextArt = true,
					PostLineRemoveContextArt = true,
					PostLineFunctionName = "HypnosDream03StartPresentation",
					PortraitExitAnimation = "Portrait_Mel_Default_01_Exit",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...All right, Lord Hypnos, one more time. You're still hiding something from me and from yourself. You must be awake somewhere in your consciousness, so let's go find you there. Breathe deep once more!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.65,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4716", Text = "No... no, he's.... {#Emph}ungh..." },
						{ Cue = "/VO/Melinoe_4717", Text = "There's nothing here...", PreLineWait = 1.35 },
					},
					{
						PreLineWait = 1.0,
						ObjectType = "NPC_Hypnos_04",

						{ Cue = "/VO/Hypnos_0039", Text = "{#Emph}Zzz... you keep... hm..." },
					}
				},
				-- leads to HypnosFinalDreamMeeting01
			},

		},
	},

	-- Dream Hypnos 3
	NPC_Hypnos_04 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		UseText = "NPCUseTextTalkAlt",
		Portrait = "Portrait_Hypnos_Sleeping_01",
		SubtitleColor = Color.HypnosVoice,
		AnimOffsetZ = 100,
		EmoteOffsetX = 35,
		EmoteOffsetY = -340,
		Groups = { "NPCs" },
		SpeakerName = "Hypnos",

		ActivateRequirements =
		{
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{ GlobalVoiceLines = "HypnosDreamSaluteVoiceLines" }
		},

		InteractTextLineSets =
		{
			HypnosFinalDreamMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreBlockSpecialInteract = true,
				-- PostBlockSpecialInteract = true,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "HypnosWakeUp03_C" },
					},
				},

				{ Cue = "/VO/Hypnos_0038",
					SkipContextArt = true,
					Text = "{#Emph}Zzz, hmhmhmhm... zzz, hmm, hmhmhm..." },

				{ Cue = "/VO/Melinoe_4718", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSurprise", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 7.9 },
					Text = "Blast it, Lord Hypnos, what is this going to take? Though... what is this, some sort of note, it says... in childlike scrawl, it says... {#Emph}Have you tried saying wake up? {#Prev}Wait, {#Emph}what?" },

				{ Cue = "/VO/Hypnos_0040",
					SkipContextArt = true,
					PreLineWait = 0.35,
					PortraitExitAnimation = "Portrait_Hypnos_Sleeping_01_Exit",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}<Gasp> <Yawwwn>" },

				{ Cue = "/VO/Melinoe_4719", UsePlayerSource = true,
					PreLineFunctionName = "HypnosDream01EndPresentation",
					PreLineFunctionArgs = { WakeUp = true },
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "He yawned. Lord Hypnos... wake up. {#Emph}Wake up!" },

				{ Cue = "/VO/Hypnos_0042",
					Portrait = "Portrait_Hypnos_Waking_01",
					PreLineWait = 0.35,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSurprise", WaitTime = 6.5 },
					Text = "{#Emph}<Yawn> {#Prev}Welcome to the House of Ha— I, {#Emph}uh... {#Prev}wait. Where am I? What {#Emph}is {#Prev}this? Who are {#Emph}you?" },

				{ Cue = "/VO/Melinoe_4720", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Hypnos, you're... you're {#Emph}here! {#Prev}These are the Crossroads between realms. I'm Melinoë, the daughter of Lord Hades and Persephone the Queen. Welcome!" },

				{ Cue = "/VO/Hypnos_0043",
					Portrait = "Portrait_Hypnos_Waking_01",
					Text = "{#Emph}<Yawn> {#Prev}Wait, wait, wait, what do you {#Emph}mean {#Prev}you're Master's daughter, you're {#Emph}huge{#Prev}, I mean you grew up {#Emph}fast{#Prev}, I mean, you were just {#Emph}born! {#Prev}Unless... unless, I, {#Emph}uh..." },

				{ Cue = "/VO/Melinoe_4721", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You've been in a deep slumber for... quite some time, my lord. Ever since the Titan Chronos took my father's House as I understand. We've been busy with that matter since." },

				{ Cue = "/VO/Hypnos_0044",
					Portrait = "Portrait_Hypnos_Shocked_01",
					Emote = "PortraitEmoteSurprise",
					Text = "...oh no! {#Emph}Aah! AAAAAH! {#Prev}Oh no! Oh no, oh no, they'll... where'd all this Nectar come from? Oh, I'll never be the featured Houseservant again, oh {#Emph}no...!" },

				{ Cue = "/VO/Melinoe_4722", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Wait, Lord Hypnos, calm yourself, {#Emph}please! {#Prev}Everything's all right! Especially now that you're back with us. The House is well again! Or getting there." },

				{ Cue = "/VO/Hypnos_0045",
					Portrait = "Portrait_Hypnos_Shocked_01",
					Emote = "PortraitEmoteFiredUp",
					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostDreamArgs,
					PostLineFunctionName = "ResumeMusicianMusic",

					Text = "No no no you don't understand... I am so late for work. I am {#Emph}so {#Prev}late for work! I have to go! I have to go, thanks for the wake-up call, if you see Zagreus tell him I'll be right there!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.2,
						ObjectType = "NPC_Hypnos_01",

						{ Cue = "/VO/Hypnos_0047", Text = "I love you! So long!", PreLineThreadedFunctionName = "HypnosExitPresentation" },
					},
					{
						PreLineWait = 0.53,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4723", Text = "...What in blazes happened, he... that's {#Emph}it?" },
					},
					{
						PreLineWait = 0.88,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4724", Text = "...That's really it." },
					},
				},
			},

		},


	},	

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Hypnos )