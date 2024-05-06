UnitSetData.NPC_Hypnos =
{
	-- Hypnos, Id = 370024
	NPC_Hypnos_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		UseText = "NPCUseTextTalkAlt",
		Portrait = "Portrait_Hypnos_Sleeping_01",
		SubtitleColor = Color.HypnosVoice,
		AnimOffsetZ = 220,
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
					Text = "{#Emph}Zzzzz, welcome to the... haah, zzzz..." },
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

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Hypnos )