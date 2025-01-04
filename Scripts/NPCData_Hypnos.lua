UnitSetData.NPC_Hypnos =
{
	-- Hypnos, Id = 370024
	NPC_Hypnos_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		UseText = "NPCUseTextTalkAlt",
		Portrait = "Portrait_Hypnos_Sleeping_01",
		SubtitleColor = Color.HypnosVoice,
		AnimOffsetZ = 110,
		EmoteOffsetX = -20,
		EmoteOffsetY = -160,
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
		SubtitleColor = Color.HypnosVoice,
		SpeakerName = "Hypnos",

		ActivateRequirements =
		{
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
					Text = "{#Emph}Zzzz, mm-hm, hmm....{#Prev}" },

				{ Cue = "/VO/Melinoe_0088", UsePlayerSource = true,
					-- PreLineAnim = "ZagreusTalkEmpathyStart", PreLineAnimTarget = "Hero",
					-- PostLineAnim = "ZagreusTalkEmpathy_Return", PostLineAnimTarget = "Hero",
					Text = "We'll find a way to wake you, O Sleep. I promise." },
			},

			HypnosAboutPoppies01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
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
					-- back compat
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWakeHypnos" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,

				{ Cue = "/VO/Hypnos_0008",
					Text = "{#Emph}Zzzz... hmm, zzzz...." },
				{ Cue = "/VO/Melinoe_3910", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Hypnos, when I was in Tartarus, I found some seeds, which grew into Poppies... like the ones that line your bedding there. What if I used them with... I just had an idea...!" },
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

				{ Cue = "/VO/Hypnos_0003",
					Text = "{#Emph}Zzz, zzzzz....{#Prev}" },
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

			-- Partner Conversations
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
					Text = "{#Emph}Zzzz, zzzz...." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat02 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0003",
					Text = "{#Emph}Zzz, zzzzz...." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat03 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0005",
					Text = "{#Emph}Zzzz... hm, hm, hm, hm, hm...." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.Sleeping,
				StatusAnimation = false,
			},
			HypnosSleepingChat04 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Hypnos",
				{ Cue = "/VO/Hypnos_0008",
					Text = "{#Emph}Zzzz... hmm, zzzz...." },
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
					Text = "{#Emph}Zzzz... hm, zzzz...." },
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
					Text = "{#Emph}Zzz... mm, hmm... zzz... hmhm... " },

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
			},

			HypnosGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = false,
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
		AnimOffsetZ = 110,
		EmoteOffsetX = -20,
		EmoteOffsetY = -160,
		Groups = { "NPCs" },
		SubtitleColor = Color.HypnosVoice,
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
			[1] =
			{
				PreLineWait = 0.3,
				RandomRemaining = true,
				UsePlayerSource = true,
				-- RandomRemaining = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/Melinoe_1883", Text = "Rest easy, Son of Nyx.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3575", Text = "You look comfortable." },
				{ Cue = "/VO/Melinoe_3576", Text = "Not a care in the world." },
				{ Cue = "/VO/Melinoe_3577", Text = "You're safe here..." },
				{ Cue = "/VO/Melinoe_3578", Text = "Moonlight guide you." },
			},
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
					Text = "{#Emph}Zzzz... a wake I'm a wake I... haha hm, zzz...." },

				{ Cue = "/VO/Melinoe_3685", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How is that you sleep, even in dream? What can I do to bring you back to us? Because we need you... your own sister tells me that your wisdom and knowledge are second to none!" },

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
		},
	},
	

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Hypnos )