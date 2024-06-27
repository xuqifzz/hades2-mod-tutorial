PresetEventArgs =
{
	ChronosGreeting =
	{
		WithinDistance = 950,
		-- PostTriggerAnimation = "AchillesIdleGreeting",
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
					},
				},

				{ Cue = "/VO/MelinoeField_0116", Text = "Is that...?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "ChronosFirstAppearance" },
				{ Cue = "/VO/MelinoeField_0113", Text = "He's there..." },
				{ Cue = "/VO/MelinoeField_0114", Text = "He's back..." },
				{ Cue = "/VO/Melinoe_0094", Text = "You!", PlayFirst = true,
					GameStateRequirements = 
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosAnomalyIntro01", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0115", Text = "The Titan...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosAnomalyIntro01", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0162", Text = "Chronos...!",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosAnomalyIntro01", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0165", Text = "Chronos...",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosAnomalyIntro01", "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",

				{ Cue = "/VO/Chronos_0008", Text = "Greetings, little one." },
				{ Cue = "/VO/Chronos_0024", Text = "How fare you, little one?" },
				{ Cue = "/VO/Chronos_0025", Text = "You." },
				{ Cue = "/VO/Chronos_0027", Text = "There you are." },
				{ Cue = "/VO/Chronos_0028", Text = "Just in time." },
				{ Cue = "/VO/Chronos_0029", Text = "Greetings." },
				{ Cue = "/VO/Chronos_0033", Text = "Returned, have you?" },
				{ Cue = "/VO/Chronos_0007", Text = "A word, if you please?", PlayFirst = true,
					PlayOnce = true, PlayOnceContext = "ChronosFirstGreeting",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
						},
					},
				},
				{ Cue = "/VO/Chronos_0009", Text = "{#Emph}Ah{#Prev}, there you are.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
						},
					},
				},
				{ Cue = "/VO/Chronos_0026", Text = "Granddaughter.",
					GameStateRequirements =
					{
						{
							Path = { "GameState", "TextLinesRecord" },
							HasAny = { "ChronosRevealFollowUp", "ChronosBossFirstMeeting_B", "ChronosPostBattleMeeting01" },
						},
					},
				},
			},
			--[[
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
				PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },

				{ Cue = "/VO/Chronos_0621", Text = "You rabble-rousing miscreant, {#Emph}again?" },
				{ Cue = "/VO/Chronos_0622", Text = "You have a long way yet to go, Granddaughter..." },
				{ Cue = "/VO/Chronos_0623", Text = "I shall be waiting for you hence, my girl!" },
				{ Cue = "/VO/Chronos_0624", Text = "Such an arduous path you have before you, girl." },
				{ Cue = "/VO/Chronos_0625", Text = "Have you learned nothing, Granddaughter...?" },
				{ Cue = "/VO/Chronos_0626", Text = "What a meddlesome child that Hades has in you." },
				{ Cue = "/VO/Chronos_0627", Text = "You ought be much better behaved than this." },
				{ Cue = "/VO/Chronos_0628", Text = "Such stubborn disobedience from a granddaughter of mine." },
				{ Cue = "/VO/Chronos_0629", Text = "I do not appreciate your stubbornness, my girl." },
				{ Cue = "/VO/Chronos_0630", Text = "This night shall not go quite as well as you expect." },

			},
			]]--
		},
	},
	ChronosNightmareGreeting =
	{
		WithinDistance = 1100,
		ScaleY = 0.75,
		LockToCharacter = true,

		VoiceLines =
		{
			{
				UsePlayerSource = true,
				{ Cue = "/VO/Hades_0020", Text = "No..." },
			},
			{
				PreLineWait = 0.5,
				PreLineAnim = "Enemy_Chronos_SittingGreeting",
				{ Cue = "/VO/Chronos_0055", Text = "Hello, Hades..." },
			},
		}
	},
	HecateFirstGreeting =
	{
		WithinDistance = 1300,
		ScaleY = 0.65,
		TriggerOnceThisRun = true,
		PostTriggerAnimation = "HecateHubGreet",
		LockToCharacter = true,
		VoiceLines =
		{
			{
				BreakIfPlayed = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "==",
						Value = 0,
					},
				},
				{ Cue = "/VO/Hecate_0618", Text = "There you are. Come here!" },
			},
		}
	},
	HecateGreeting =
	{
		WithinDistance = 1100,
		ScaleY = 0.65,
		TriggerOnceThisRun = true,
		PostTriggerAnimation = "HecateHubGreet",
		PostTriggerFunctionName = "LightRangedSalute",
		PostTriggerFunctionArgs = { WaitTime = 0.6 },
		GameStateRequirements =
		{
			-- leave space for Cauldron intro
			{
				Path = { "GameState", "CompletedRunsCache" },
				Comparison = "~=",
				Value = 1,
			},
			RequiredFalseQueuedTextLines = {
							"ArtemisHubFirstMeeting01",
						},
		},
		VoiceLines =
		{
			BreakIfPlayed = true,
			Cooldowns =
			{
				{ Name = "HecateGreetingSpeech", Time = 400 },
			},
			{
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"HecateAboutChronosBossW01",
						},
					},
					{ Cue = "/VO/Hecate_0054", Text = "Come here." },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"HecateAboutTask01",
						},
					},
					{ Cue = "/VO/Hecate_0006", Text = "{#Emph}Ah! {#Prev}You're here." },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"HecateAboutCerberus02",
						},
					},
					{ Cue = "/VO/Hecate_0673", Text = "You all right...?" },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"HecateLostAgainstHer01",
						},
					},
					{ Cue = "/VO/Hecate_0322", Text = "There you are." },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"HecateAboutTask02",
						},
					},
					{ Cue = "/VO/Hecate_0326", Text = "What news?" },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"HecateAboutWellness01",
							"HecateAboutErisFight01",
						},
					},
					{ Cue = "/VO/Hecate_0478", Text = "Alas..." },
				},
				{
					SuccessiveChanceToPlayAll = 0.75,
					-- PreLineAnim = "HecateIdleGreeting",
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" }
						},
					},

					{ Cue = "/VO/Hecate_0680", Text = "The task unfolds.", PlayFirst = true },
					{ Cue = "/VO/Hecate_0473", Text = "Well done out there." },
					{ Cue = "/VO/Hecate_0474", Text = "One step closer..." },
					{ Cue = "/VO/Hecate_0475", Text = "Continue apace." },
					{ Cue = "/VO/Hecate_0472", Text = "You finally returned..." },
					{ Cue = "/VO/Hecate_0614", Text = "All part of the task." },
					{ Cue = "/VO/Hecate_0615", Text = "We missed you here..." },
					{ Cue = "/VO/Hecate_0617", Text = "Commendable result." },
					{ Cue = "/VO/Hecate_0332", Text = "Well done." },
					{ Cue = "/VO/Hecate_0681", Text = "We welcome you." },
					{ Cue = "/VO/Hecate_0682", Text = "Our Princess." },
					{ Cue = "/VO/Hecate_0683", Text = "Sisters, salute.",},
					{ Cue = "/VO/Hecate_0684", Text = "I salute you.",
						PreLineAnim = "Hecate_Hub_Salute",
					},
					{ Cue = "/VO/Hecate_0685", Text = "Good work." },
					{ Cue = "/VO/Hecate_0616", Text = "You showed that wretch again.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
							},
							{
								Path = { "GameState", "EnemyKills", "Chronos" },
								Comparison = ">",
								Value = 2,
							},
						},
					},

				},
				{
					BreakIfPlayed = true,
					SuccessiveChanceToPlayAll = 0.75,
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "RoomsEntered", "F_Boss01" }
						},
						{
							PathFalse = { "CurrentRun", "RoomsEntered", "F_PostBoss01" }
						},
						{
							Path = { "GameState", "LastBossHealthBarRecord", "Hecate" },
							Comparison = "<",
							Value = 0.33,
						},
					},

					{ Cue = "/VO/Hecate_0676", Text = "You fought well.", PlayFirst = true },
					{ Cue = "/VO/Hecate_0677", Text = "You were close." },
					{ Cue = "/VO/Hecate_0678", Text = "'Twas quite a fight." },
					{ Cue = "/VO/Hecate_0679", Text = "Fiercely fought." },
				},
				{
					SuccessiveChanceToPlayAll = 0.75,
					RandomRemaining = true,
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Hecate_0060", Text = "Rise and shine.", PlayFirst = true },
					{ Cue = "/VO/Hecate_0052", Text = "You're awake." },
					{ Cue = "/VO/Hecate_0053", Text = "Melinoë?" },
					{ Cue = "/VO/Hecate_0055", Text = "Good evening." },
					{ Cue = "/VO/Hecate_0056", Text = "Good morrow." },
					{ Cue = "/VO/Hecate_0059", Text = "You're returned." },
					{ Cue = "/VO/Hecate_0061", Text = "Together we shine." },
					{ Cue = "/VO/Hecate_0062", Text = "Moonlight guide you." },
					{ Cue = "/VO/Hecate_0321", Text = "Approach." },
					{ Cue = "/VO/Hecate_0323", Text = "Back amongst the living." },
					{ Cue = "/VO/Hecate_0324", Text = "Back on your feet, I see." },
					{ Cue = "/VO/Hecate_0325", Text = "Melinoë." },
					{ Cue = "/VO/Hecate_0327", Text = "Returned again." },
					{ Cue = "/VO/Hecate_0328", Text = "Our wards are holding fast." },
					{ Cue = "/VO/Hecate_0470", Text = "Regained your strength, I see." },
					{ Cue = "/VO/Hecate_0471", Text = "From the shadows..." },
					{ Cue = "/VO/Hecate_0670", Text = "Recovered." },
					{ Cue = "/VO/Hecate_0673", Text = "You all right...?" },
					{ Cue = "/VO/Hecate_0674", Text = "Prepared for more?" },
					{ Cue = "/VO/Hecate_0675", Text = "Returned to us." },
					{ Cue = "/VO/Hecate_0006", Text = "{#Emph}Ah! {#Prev}You're here.",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpeechRecord", "/VO/Hecate_0006" },
							},
						},
					},
					{ Cue = "/VO/Hecate_0671", Text = "'Tis a new moon.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "GamePhase" },
								Comparison = "==",
								Value = 5,
							},
						},
					},
					{ Cue = "/VO/Hecate_0672", Text = "Full moon tonight.",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "GamePhase" },
								Comparison = "==",
								Value = 1,
							},
						},
					},
					{ Cue = "/VO/Hecate_0326", Text = "What news?",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpeechRecord", "/VO/Hecate_0326" },
							},
						},
					},
					{ Cue = "/VO/Hecate_0322", Text = "There you are.",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "SpeechRecord", "/VO/Hecate_0322" },
							},
						},
					},

				},
			},
		},
	},
	HecateHiding01 =
	{
		PreTriggerWait = 0.1,
		WithinDistance = 440,
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				Queue = "Interrupt",
				{ Cue = "/VO/Melinoe_2115", Text = "There...!" },
			},
			{
				ObjectType = "NPC_Hecate_Story_01",
				{ Cue = "/VO/Hecate_0527", Text = "{#Emph}Ah!", PreLineAnim = "Hecate_Hub_Hide_Fidget", },
			},
		}
	},
	HecateHiding02 =
	{
		PreTriggerWait = 0.1,
		WithinDistance = 440,
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				Queue = "Interrupt",
				{ Cue = "/VO/Melinoe_2116", Text = "Over there..." },

			},
			{
				ObjectType = "NPC_Hecate_Story_01",
				PreLineWait = 0.2,
				{ Cue = "/VO/Hecate_0528", Text = "Perceptive!", PreLineAnim = "Hecate_Hub_Hide_Fidget",  },
			},
		}
	},
	HecateHiding03 =
	{
		PreTriggerWait = 0.1,
		WithinDistance = 420,
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				Queue = "Interrupt",
				{ Cue = "/VO/Melinoe_2117", Text = "Ah-{#Emph}hah..." },
			},
			{
				ObjectType = "NPC_Hecate_Story_01",
				{ Cue = "/VO/Hecate_0526", Text = "{#Emph}<Chuckle>", PreLineAnim = "Hecate_Hub_Hide_Fidget",  },
			},
		}
	},

	OdysseusGreeting =
	{
		WithinDistance = 550,
		ScaleY = 0.75,
		-- PostTriggerAnimation = "AchillesIdleGreeting",
		VoiceLines =
		{
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
			},
			Cooldowns =
			{
				{ Name = "OdysseusGreetingSpeech", Time = 400 },
			},
			{	
				GameStateRequirements =
				{
					RequiredFalseQueuedTextLines = {
						"OdysseusAboutScylla02",
					},
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"OdysseusAboutErisCurse01",
							"OdysseusAboutPoseidon01",
							"OdysseusAboutPressure02",
							"OdysseusAboutChronosBossW01",
							"OdysseusAboutChronosBossL01",
							"OdysseusAboutErisBoss01",
						},
					},

					{ Cue = "/VO/Odysseus_0119", Text = "A moment, Goddess?" },
					{ Cue = "/VO/Odysseus_0120", Text = "If I may, Goddess?", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0121", Text = "Beg pardon, Goddess...", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0122", Text = "Hey, {#Emph}erm..." },
				},
				{
					SuccessiveChanceToPlayAll = 0.5,
					-- PreLineAnim = "HecateIdleGreeting",
					RandomRemaining = true,
					PreLineAnim = "Odysseus_Greet",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" }
						},
					},

					{ Cue = "/VO/Odysseus_0116", Text = "Good show that time." },
					{ Cue = "/VO/Odysseus_0117", Text = "Hello there." },
					{ Cue = "/VO/Odysseus_0334", Text = "Impressive work." },
					{ Cue = "/VO/Odysseus_0118", Text = "Fine work there!", PlayFirst = true },
				},
				{
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "AnyMailboxReady" },
						},
						{
							PathFalse = { "CurrentRun", "UseRecord", "Mailbox" }
						},
					},

					{ Cue = "/VO/Odysseus_0340", Text = "New shipment there for you." },
					{ Cue = "/VO/Odysseus_0341", Text = "Shipment came for you.", PlayFirst = true, PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0342", Text = "New shipment over there." },
					{ Cue = "/VO/Odysseus_0343", Text = "Shipment for you back there.", PreLineAnim = "Odysseus_Greet" },
				},
				{
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.75,
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Odysseus_0111", Text = "Goddess." },
					{ Cue = "/VO/Odysseus_0112", Text = "{#Emph}Ah." },
					{ Cue = "/VO/Odysseus_0114", Text = "Let's see..." },
					{ Cue = "/VO/Odysseus_0347", Text = "{#Emph}Hmm..." },
					{ Cue = "/VO/Odysseus_0350", Text = "Up and about?" },
					{ Cue = "/VO/Odysseus_0351", Text = "You have this." },
					{ Cue = "/VO/Odysseus_0110", Text = "Goddess.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0113", Text = "Hail.", PlayFirst = true, PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0344", Text = "Greetings.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0346", Text = "Something to report?", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0345", Text = "Back in one piece.", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0348", Text = "Evening!", PreLineAnim = "Odysseus_Greet" },
					{ Cue = "/VO/Odysseus_0349", Text = "Evening... I think.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Odysseus_0348" },
							},
						},
					},
				},
			},
		},
	},
	OdysseusFeasting =
	{
		WithinDistance = 750,
		-- PostTriggerAnimation = "AchillesIdleGreeting",
		VoiceLines =
		{
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
			},
			Cooldowns =
			{
				{ Name = "OdysseusGreetingSpeech", Time = 400 },
			},
			{
				{
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.75,
					PreLineAnim = "Odysseus_Greet",
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Odysseus_0106", Text = "{#Emph}<Chuckle>" },
					{ Cue = "/VO/Odysseus_0107", Text = "{#Emph}<Chuckle>" },
					{ Cue = "/VO/Odysseus_0108", Text = "{#Emph}<Laugh>", PlayFirst = true },
					{ Cue = "/VO/Odysseus_0109", Text = "{#Emph}<Laugh>" },
				},
			},
		},
	},
	OdysseusHideAndSeek =
	{
		WithinDistance = 360,
		VoiceLines =
		{
			{ Cue = "/VO/Odysseus_0203", Text = "You'll find her yet." },
		}
	},

	NemesisGreeting =
	{
		WithinDistance = 500,
		ScaleY = 0.75,
		-- PostTriggerAnimation = "AchillesIdleGreeting",
		VoiceLines =
		{
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
			},
			Cooldowns =
			{
				{ Name = "NemesisGreetingSpeech", Time = 400 },
			},
			{
				-- Nemesis field greetings
				{
					RandomRemaining = true,
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"NemesisFieldFirstMeeting",
						},
					},

					-- { Cue = "/VO/Nemesis_0105", Text = "{#Emph}Tsch." },
				},
				-- hub greetings
				{
					RandomRemaining = true,
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"NemesisAboutEris01",
							"NemesisAboutTraining01",
							"NemesisAboutSurface02",
						},
					},

					{ Cue = "/VO/Nemesis_0113", Text = "Hey, {#Emph}uh..." },
					{ Cue = "/VO/Nemesis_0114", Text = "Um..." },
					{ Cue = "/VO/Nemesis_0115", Text = "Come here..." },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"NemesisAboutTask01",
						},
					},

					{ Cue = "/VO/Nemesis_0106", Text = "{#Emph}Huh!" },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"NemesisAboutErisFightW01",
						},
					},

					{ Cue = "/VO/Nemesis_0280", Text = "Hey." },
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.75,
					-- PreLineAnim = "HecateIdleGreeting",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" }
						},
					},

					{ Cue = "/VO/Nemesis_0272", Text = "Oh, look..." },
					{ Cue = "/VO/Nemesis_0273", Text = "You..." },
					{ Cue = "/VO/Nemesis_0274", Text = "Well, well." },
					{ Cue = "/VO/Nemesis_0276", Text = "Did it again." },
					{ Cue = "/VO/Nemesis_0277", Text = "How did you...?" },
					{ Cue = "/VO/Nemesis_0280", Text = "Hey." },
					{ Cue = "/VO/Nemesis_0281", Text = "{#Emph}Hm." },
					{ Cue = "/VO/Nemesis_0275", Text = "You got there...?", PlayFirst = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" }
							},
						},
					},
					{ Cue = "/VO/Nemesis_0278", Text = "Got him, huh.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" }
							},
						},
					},
					{ Cue = "/VO/Nemesis_0279", Text = "Got him again?",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" }
							},
						},
					},
				},
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.75,
					PreLineAnim = "Nemesis_Hub_Greet",
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Nemesis_0102", Text = "What." },
					{ Cue = "/VO/Nemesis_0103", Text = "Yeah?" },
					{ Cue = "/VO/Nemesis_0104", Text = "{#Emph}Urgh..." },
					{ Cue = "/VO/Nemesis_0105", Text = "{#Emph}Tsch." },
					{ Cue = "/VO/Nemesis_0106", Text = "{#Emph}Huh!",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "TextLinesRecord", "NemesisAboutTask01" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0107", Text = "Back early." },
					{ Cue = "/VO/Nemesis_0108", Text = "Death to Chronos.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0109", Text = "Death to Chronos...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisGift02" },
							},
						},
					},
					{ Cue = "/VO/Nemesis_0110", Text = "Again?" },
					{ Cue = "/VO/Nemesis_0111", Text = "Oh, Mother..." },
					{ Cue = "/VO/Nemesis_0112", Text = "Tough times.", PlayFirst = true },
					{ Cue = "/VO/Nemesis_0116", Text = "What now?" },
					{ Cue = "/VO/Nemesis_0117", Text = "What is it?" },
					{ Cue = "/VO/Nemesis_0118", Text = "Yeah, what?" },
					{ Cue = "/VO/Nemesis_0282", Text = "Up and about." },
					{ Cue = "/VO/Nemesis_0283", Text = "Up late." },
					{ Cue = "/VO/Nemesis_0284", Text = "Try again?" },
					{ Cue = "/VO/Nemesis_0285", Text = "Again, huh?" },
					{ Cue = "/VO/Nemesis_0286", Text = "Still at it?" },
					{ Cue = "/VO/Nemesis_0287", Text = "All clear." },
					{ Cue = "/VO/Nemesis_0288", Text = "All clear..." },
					{ Cue = "/VO/Nemesis_0289", Text = "'Bout time." },
					{ Cue = "/VO/Nemesis_0290", Text = "Oh...",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "NemesisGift03" },
							},
						}
					},
					{ Cue = "/VO/Nemesis_0291", Text = "Princess." },

				},
			},
		},
	},
	NemesisRandomEventGreeting = 
	{
		WithinDistance = 1000,
		NotifyName = "NemesisRandomEventGreeting",
		SetupFunctions =
		{
			{
				Name = "OverwriteSelf",
				Args =
				{
					PostTriggerFunctionName = "NemesisFieldsApproachPresentation",	
					PostTriggerFunctionArgs = { SecretMusicSection = 1, MusicTransitionTime = 1.0, },
					WithinDistance = 1300,
					ScaleY = 0.5,
					Repeat = true,
					RepeatBufferDistance = 500,
					OnRepeatFunctionName = "NemesisFieldsBackAwayFromPresentation",
					OnRepeatFunctionArgs = { MusicTransitionTime = 1.0, },
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H", },
					},
				},
			},
		},
		
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.75,
				SuccessiveChanceToPlay = 0.25,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "H" },
					},
				},

				{ Cue = "/VO/MelinoeField_0038", Text = "Her again?",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "NemesisGift02" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_0039", Text = "Hi, Nem.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NemesisGift05" },
						}
					}
				},
				{ Cue = "/VO/MelinoeField_0034", Text = "Nemesis..." },
				{ Cue = "/VO/MelinoeField_0035", Text = "Nemesis?" },
				{ Cue = "/VO/MelinoeField_0036", Text = "Nemesis!" },
			},
			{
				-- SuccessiveChanceToPlay = 0.75,
				-- PreLineAnim = "HecateIdleGreeting",
				RandomRemaining = true,
				PreLineWait = 0.75,
				-- RequiresNullAmbientMusicId = true,
				Cooldowns =
				{
					{ Name = "NemesisGreetingSpeech", Time = 90 },
				},

				{ Cue = "/VO/NemesisField_0197", Text = "Well, well.", PlayFirst = true },
				{ Cue = "/VO/NemesisField_0198", Text = "You." },
				{ Cue = "/VO/NemesisField_0199", Text = "You again." },
				{ Cue = "/VO/NemesisField_0200", Text = "Again?" },
				{ Cue = "/VO/NemesisField_0201", Text = "Evening." },
				{ Cue = "/VO/NemesisField_0202", Text = "What a coincidence." },
				{ Cue = "/VO/NemesisField_0203", Text = "Thank the Fates." },
				{ Cue = "/VO/NemesisField_0204", Text = "Yes?" },
				{ Cue = "/VO/NemesisField_0205", Text = "What do you want." },
				{ Cue = "/VO/NemesisField_0206", Text = "Move along." },
				{ Cue = "/VO/NemesisField_0207", Text = "There you are." },
				{ Cue = "/VO/NemesisField_0208", Text = "Princess." },
				{ Cue = "/VO/NemesisField_0209", Text = "May I help you?" },
			},
		},
	},
	MedeaHubGreeting =
	{
		WithinDistance = 650,
		ScaleY = 0.75,
		TriggerOnceThisRun = true,
		-- PostTriggerAnimation = "HecateHubGreet",
		VoiceLines =
		{
			{
				UsePlayerSource = true,

				{ Cue = "/VO/Melinoe_3035", Text = "Lady Medea...!" },
			},
			{
				PreLineWait = 0.2,
				{ Cue = "/VO/Medea_0071", Text = "Good evening!" },
			},
		}
	},

	MorosPathArgs =
	{
		Loop = true,
		Timeout = 9.0,
		OverwriteSelf =
		{
			PreEventFunctionName = "MorosObservingInterrupt",
			PreSelectGiftFunctionName = "ActivityInterrupt",
		},
		Path =
		{
			{
				Branch =
				{
					{
						-- Branch Option A - FatedList South
						GameStateRequirements =
						{
							{
								PathFromSource  = true,
								Path = { "LastVisitedPathId", },
								IsNone = { 589009 },
							},
						},
						{
							Id = 589009,
							StartDelay = 1.5,
							SuccessDistance = 50,
							ArriveFunctionName = "MorosObserveFatedList",
						},
					},
					{
						-- Branch Option B - FatedList Southeast
						GameStateRequirements =
						{
							{
								PathFromSource  = true,
								Path = { "LastVisitedPathId", },
								IsNone = { 589010 },
							},
						},
						{
							Id = 589010,
							StartDelay = 1.5,
							SuccessDistance = 50,
							ArriveFunctionName = "MorosObserveFatedList",
						},
					},
					{
						-- Branch Option C - FatedList East
						GameStateRequirements =
						{
							{
								PathFromSource  = true,
								Path = { "LastVisitedPathId", },
								IsNone = { 589011 },
							},
						},
						{
							Id = 589011,
							StartDelay = 1.5,
							SuccessDistance = 50,
							ArriveFunctionName = "MorosObserveFatedList",
						},
					},
				},
			},
		},
	},

	MorosGreeting =
	{
		WithinDistance = 490,
		GameStateRequirements =
		{
			{
				-- PathEmpty = { "GameState", "ActiveLitter" },
			},
			{
				PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
			},
		},

		VoiceLines =
		{
			BreakIfPlayed = true,
			Cooldowns =
			{
				{ Name = "MorosGreetingSpeech", Time = 400 },
				{ Name = "MorosBeingPolite", Time = 2 },
			},
			{
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines =
						{
							"MorosFirstMeeting",
						},
					},
					{ Cue = "/VO/Moros_0363", Text = "A brief word?", PreLineAnim = "Moros_Salute" },
					-- { Cue = "/VO/Moros_0364", Text = "Beg pardon?" },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines =
						{
							"MorosAboutQuestLog01",
							"MorosAboutRelationship01",
						},
					},

					{ Cue = "/VO/Moros_0095", Text = "Do you have a moment?", PreLineAnim = "Moros_Salute" },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines =
						{
							"MorosAboutRelationship02",
						},
					},

					{ Cue = "/VO/Moros_0093", Text = "Princess?", PreLineAnim = "Moros_Attention" },
				},
				{
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines =
						{
							"MorosAboutQuestLog02",
						},
					},

					{ Cue = "/VO/Moros_0094", Text = "If I may?", PreLineAnim = "Moros_Salute" },
				},
				{
					SuccessiveChanceToPlayAll = 0.75,
					PreLineAnim = "Moros_Salute",
					RandomRemaining = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Cleared" }
						},
					},

					{ Cue = "/VO/Moros_0090", Text = "To your success." },
					{ Cue = "/VO/Moros_0091", Text = "To victory." },
					{ Cue = "/VO/Moros_0092", Text = "Heard the good news." },
					{ Cue = "/VO/Moros_0213", Text = "It's an auspicious night!" },
					{ Cue = "/VO/Moros_0214", Text = "It's an auspicious night." },
				},
				{
					SuccessiveChanceToPlayAll = 0.75,
					PreLineAnim = "Moros_Salute",
					RandomRemaining = true,
					-- RequiresNullAmbientMusicId = true,

					{ Cue = "/VO/Moros_0083", Text = "Princess." },
					{ Cue = "/VO/Moros_0084", Text = "Princess...!" },
					{ Cue = "/VO/Moros_0085", Text = "Hm.", PreLineAnim = "Moros_Attention" },
					{ Cue = "/VO/Moros_0086", Text = "Mm.", PreLineAnim = "Moros_Attention" },
					{ Cue = "/VO/Moros_0087", Text = "Fates protect you." },
					{ Cue = "/VO/Moros_0088", Text = "My greetings.", PlayFirst = true },
					{ Cue = "/VO/Moros_0089", Text = "You're back..." },
					{ Cue = "/VO/Moros_0082", Text = "Good evening." },
					{ Cue = "/VO/Moros_0208", Text = "Greetings." },
					-- { Cue = "/VO/Moros_0209", Text = "Oh!" },
					{ Cue = "/VO/Moros_0210", Text = "Hello.", PreLineAnim = "Moros_Attention" },
					-- { Cue = "/VO/Moros_0211", Text = "Oh hello." },
					{ Cue = "/VO/Moros_0212", Text = "Ready for more?" },
				},
			},
		},
	},

	ErisSnacking =
	{
		WithinDistance = 450,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
			},
		},
		PreTriggerAnimation = "Enemy_Eris_Hub_Eat_Start",
		PostTriggerAnimation = "Enemy_Eris_Hub_Eat_End",
		StatusAnimation = "StatusIconWantsToTalk",
		VoiceLines =
		{
			BreakIfPlayed = true,
			Source = { LineHistoryName = "NPC_Eris_01", SubtitleColor = Color.ErisVoice },
			Cooldowns =
			{
				{ Name = "ErisGreetingSpeech", Time = 400 },
			},
			{
				{
					PreLineWait = 0.65,
					RandomRemaining = true,

					{ Cue = "/VO/Eris_0143", Text = "{#Emph}Aah..." },
					{ Cue = "/VO/Eris_0144", Text = "{#Emph}<Chomp> Mmm." },
					{ Cue = "/VO/Eris_0145", Text = "Hit the spot!" },
					{ Cue = "/VO/Eris_0146", Text = "{#Emph}Mm{#Prev}, hey!" },
				},
			}
		},

	},
	ErisSnackingRepeatable =
	{
		WithinDistance = 450,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
			},
		},
		PreTriggerAnimation = "Enemy_Eris_Hub_Eat_Start",
		PostTriggerAnimation = "Enemy_Eris_Hub_Eat_End",
		-- StatusAnimation = "StatusIconWantsToTalk",
		VoiceLines =
		{
			BreakIfPlayed = true,
			Source = { LineHistoryName = "NPC_Eris_01", SubtitleColor = Color.ErisVoice },
			Cooldowns =
			{
				{ Name = "ErisGreetingSpeech", Time = 400 },
			},
			{
				{
					PreLineWait = 0.65,
					RandomRemaining = true,

					{ Cue = "/VO/Eris_0143", Text = "{#Emph}Aah..." },
					{ Cue = "/VO/Eris_0144", Text = "{#Emph}<Chomp> Mmm." },
					{ Cue = "/VO/Eris_0145", Text = "Hit the spot!" },
					{ Cue = "/VO/Eris_0146", Text = "{#Emph}Mm{#Prev}, hey!" },
				},
			}
		},
	},

	ErisGreeting =
	{
		WithinDistance = 509,
		ScaleX = 0.85,
		GameStateRequirements =
		{
			{
				PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
			},
		},

		SetupFunctions =
		{
			{
				Name = "OverwriteSelf",
				Args =
				{
					WithinDistance = 1100,
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},
			},
		},

		-- PostTriggerAnimation = "Eris_Salute",
		-- PostTriggerAnimation = "AchillesIdleGreeting",
		VoiceLines =
		{
			{
				-- curse greetings
				{
					{
						RandomRemaining = true,
						PreLineAnim = "Enemy_Eris_Hub_Greet",
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" },
							},
						},
						Cooldowns =
						{
							{ Name = "ErisSpokeRecently", Time = 2 },
						},

						{ Cue = "/VO/Eris_0077", Text = "Hey babe!" },
						{ Cue = "/VO/ErisField_0050", Text = "Hiya babe!" },
						{ Cue = "/VO/ErisField_0051", Text = "Hey hey!" },
						{ Cue = "/VO/ErisField_0052", Text = "Thought that was you." },
						{ Cue = "/VO/ErisField_0053", Text = "Look who!", PlayFirst = true },
						{ Cue = "/VO/ErisField_0054", Text = "Got here {#Emph}first!", PlayFirst = true,
							GameStateRequirements =
							{
								{
									PathTrue = { "GameState", "SpeechRecord", "/VO/ErisField_0053" },
								},
							},
						},
						{ Cue = "/VO/ErisField_0055", Text = "You made it!" },
						{ Cue = "/VO/ErisField_0056", Text = "Trouble!" },
						{ Cue = "/VO/ErisField_0057", Text = "Trouble." },
					},
					{
						PreLineWait = 0.3,
						BreakIfPlayed = true,
						RandomRemaining = true,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "CurrentRun", "Hero", "IsDead" },
							},
						},			

						{ Cue = "/VO/Melinoe_3064", Text = "Oh, no...", PlayFirst = true },
						{ Cue = "/VO/Melinoe_3065", Text = "Her again." },
						{ Cue = "/VO/Melinoe_3066", Text = "Oh great." },
						{ Cue = "/VO/Melinoe_3067", Text = "Eris...!" },
						{ Cue = "/VO/Melinoe_3068", Text = "Hello, Eris..." },
						{ Cue = "/VO/Melinoe_3069", Text = "Hello, Eris..." },
					},
				},
				-- hub greetings
				{
					BreakIfPlayed = true,
					Cooldowns =
					{
						{ Name = "ErisSpokeRecently", Time = 3 },
					},

					{
						ObjectType = "NPC_Eris_01",
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines =
							{
								"ErisFirstMeeting",
								"ErisFirstMeeting_B",
							},
						},
						{ Cue = "/VO/Eris_0072", Text = "Lookee who!" },
						{ Cue = "/VO/Eris_0082", Text = "{#Emph}Aw{#Prev}, what's wrong?", PlayFirst = true,
							GameStateRequirements = 
							{
								{
									PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
								},
							}
						},
					},
					{
						ObjectType = "NPC_Eris_01",
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines =
							{
								"NemesisWithEris01",
							},
						},
						{ Cue = "/VO/Eris_0138", Text = "{#Emph}Yes{#Prev}, ma'am!" },
					},
					{
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines =
							{
								"ErisAboutPurpose01",
							},
						},
						{ Cue = "/VO/Eris_0076", Text = "What're you looking at?" },
					},
					{
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines =
							{
								"ErisPostGift01",
							},
						},
						{ Cue = "/VO/Eris_0071", Text = "C'mere." },
					},
					{
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines =
							{
								"ErisAboutWeaponGun01",
							},
						},
						{ Cue = "/VO/Eris_0132", Text = "{#Emph}Wha?" },
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.75,
						-- PreLineAnim = "HecateIdleGreeting",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Cleared" }
							},
							{
								PathTrue = { "GameState", "UseRecord", "NPC_Eris_01" },
							},
						},

						{ Cue = "/VO/Eris_0083", Text = "{#Emph}Ohh {#Prev}it's you..." },
						{ Cue = "/VO/Eris_0084", Text = "Hooray..." },
						{ Cue = "/VO/Eris_0085", Text = "{#Emph}Tsch..." },
						{ Cue = "/VO/Eris_0086", Text = "What did you do now...?" },
						{ Cue = "/VO/Eris_0087", Text = "Stop getting somewhere...!" },
						{ Cue = "/VO/Eris_0128", Text = "Oh, hey..." },
						{ Cue = "/VO/Eris_0129", Text = "What's all the commotion?" },
						{ Cue = "/VO/Eris_0130", Text = "Hi..." },
						{ Cue = "/VO/Eris_0131", Text = "Blood and darkness..." },
						{ Cue = "/VO/Eris_0147", Text = "{#Emph}Kh!" },
						{ Cue = "/VO/Eris_0148", Text = "{#Emph}Ngh." },
						{ Cue = "/VO/Eris_0154", Text = "What?" },
					},
					{
						BreakIfPlayed = true,
						RandomRemaining = true,
						SuccessiveChanceToPlayAll = 0.5,
						-- PreLineAnim = "HecateIdleGreeting",
						-- RequiresNullAmbientMusicId = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "IsDead" },
							},
						},

						{ Cue = "/VO/Eris_0070", Text = "Here comes Trouble...!" },
						{ Cue = "/VO/Eris_0071", Text = "C'mere." },
						{ Cue = "/VO/Eris_0072", Text = "Lookee who!" },
						{ Cue = "/VO/Eris_0073", Text = "{#Emph}Yoo-hoo!", PlayFirst = true },
						{ Cue = "/VO/Eris_0074", Text = "{#Emph}Ahh, heh!" },
						{ Cue = "/VO/Eris_0075", Text = "Hi, hi!" },
						{ Cue = "/VO/Eris_0076", Text = "What're you looking at?",
							GameStateRequirements =
							{
								MinRunsSinceAnyTextLines = { TextLines = { "ErisAboutPurpose01" }, Count = 8 },
							},
						},
						{ Cue = "/VO/Eris_0077", Text = "Hey babe!" },
						{ Cue = "/VO/Eris_0078", Text = "{#Emph}Heh!" },
						{ Cue = "/VO/Eris_0080", Text = "May I help you?" },
						{ Cue = "/VO/Eris_0081", Text = "What's the matter?" },
						{ Cue = "/VO/Eris_0082", Text = "{#Emph}Aw{#Prev}, what's wrong?" },
						{ Cue = "/VO/Eris_0160", Text = "{#Emph}Huh..." },
						{ Cue = "/VO/Eris_0161", Text = "{#Emph}Oh..." },
					},
				},
			},
		},
	},

	ApplyErisCurse =
	{
		TraitName = "ErisCurseTrait",
	},

	ArtemisGreeting =
	{
		WithinDistance = 650,
		TriggerOnceThisRun = true,
		-- PostTriggerAnimation = "Artemis_Salute",
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "Hero", "IsDead" },
			},
		},
		VoiceLines =
		{
			{
				UsePlayerSource = true,
				Cooldowns =
				{
					-- { Name = "MelinoeAnyQuipSpeech", Time = 60 },
				},

				{ Cue = "/VO/Melinoe_1094", Text = "Artemis!" },
			},
			{
				ObjectType = "NPC_Artemis_01",
				PreLineAnim = "Artemis_Salute",

				{ Cue = "/VO/Artemis_0094", Text = "Fancy running into {#Emph}you {#Prev}again!" },
			},
		},
	},

	CharonGreeting =
	{
		WithinDistance = 650,
		SetupFunctions =
		{
			{
				Name = "OverwriteSelf",
				Args =
				{
					WithinDistance = 1000,
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "SpeechRecord", "/VO/MelinoeField_1580" },
					},
				},
			},
		},
		GameStateRequirements =
		{
			{
				-- PathFalse = { "CurrentRun", "Hero", "IsDead" },
			},
		},		
		VoiceLines =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
			},
			{
				BreakIfPlayed = true,				
				UsePlayerSource = true,
				TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

				{ Cue = "/VO/MelinoeField_1580", Text = "That breathing...",
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
			},
			{
				BreakIfPlayed = true,
				Source = { LineHistoryName = "NPC_Charon_01", SubtitleColor = Color.CharonVoice },
				GameStateRequirements =
				{
					RequiredAnyQueuedTextLines = {
						"CharonGrantsMailbox01",
					},
				},
				Cooldowns =
				{
					{ Name = "CharonSpokeRecently", Time = 10 },
				},
				{ Cue = "/VO/Charon_0058", Text = "{#Emph}Nrrrghh...." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.66,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_2278", Text = "You're here, Lord Charon!" },
				{ Cue = "/VO/Melinoe_2279", Text = "Welcome, Lord Charon!" },
			},
			-- fields & later greeting
			{
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlay = 0.25,
					SuccessiveChanceToPlayAll = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "H", "O" },
						},
						RequiredUnitsNotAlive = { "NPC_Nemesis_01", "NPC_Heracles_01" },
						RequiredMinHealthFraction = 0.2,
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_1371", Text = "Good to see you here, my lord!" },
					{ Cue = "/VO/MelinoeField_1372", Text = "The Boatman on the River Styx...!" },
					{ Cue = "/VO/MelinoeField_1373", Text = "Gone all this way, my lord...?" },
					{ Cue = "/VO/MelinoeField_1374", Text = "Lord Charon, thank the gods..." },
				},
			},
			-- tartarus greeting
			{
				{
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "I" },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						RequiredUnitsNotAlive = { "NPC_Nemesis_01", "NPC_Heracles_01" },
						RequiredMinHealthFraction = 0.2,
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/MelinoeField_1297", Text = "You made it here in all the clamor, Lord.",
						PlayFirst = true },
					{ Cue = "/VO/MelinoeField_1298", Text = "Remain unseen, my lord." },
				},
				{
					BreakIfPlayed = true,
					Cooldowns =
					{
						{ Name = "CharonSpokeRecently", Time = 10 },
					},
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1297", "/VO/MelinoeField_1298" },
						},
					},

					{ Cue = "/VO/Charon_0031", Text = "{#Emph}Sshhh..." },
				},
			},
			-- misc. greetings
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.5,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					RequiredUnitsNotAlive = { "NPC_Nemesis_01", "NPC_Heracles_01" },
				},
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1229", Text = "Lord Charon...?" },
				{ Cue = "/VO/Melinoe_1230", Text = "Lord Charon...!" },
				{ Cue = "/VO/Melinoe_1231", Text = "Hail, Boatman." },
				{ Cue = "/VO/Melinoe_1232", Text = "Lord Charon, I've returned." },
				{ Cue = "/VO/Melinoe_1233", Text = "Good evening, Boatman." },
				{ Cue = "/VO/Melinoe_2418", Text = "Night protect you, my lord." },
				{ Cue = "/VO/MelinoeField_1674", Text = "It's Charon...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1675", Text = "Lord Charon's set up shop...",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1676", Text = "What do we have in stock?",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_2414", Text = "You are a welcome sight, my lord.", PlayFirst = true,
					GameStateRequirements =
					{
						{
						},
						RequiredMaxHealthFraction = 0.33,
					}
				},
				{ Cue = "/VO/Melinoe_2415", Text = "I sure could use your aid...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1230" },
						},
						RequiredMaxHealthFraction = 0.33,
					}
				},
				{ Cue = "/VO/Melinoe_2416", Text = "I've little coin to trade...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1230" },
						},
						{
							Path = { "GameState", "Resources", "Money" },
							Comparison = "<",
							Value = 80,
						},
					}
				},
				{ Cue = "/VO/Melinoe_2417", Text = "I haven't much right now...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Melinoe_1230" },
						},
						{
							Path = { "GameState", "Resources", "Money" },
							Comparison = "<",
							Value = 80,
						},
					}
				},
			},
			{
				SuccessiveChanceToPlay = 0.33,
				-- PreLineAnim = "HecateIdleGreeting",
				RandomRemaining = true,
				-- RequiresNullAmbientMusicId = true,
				-- PreLineAnim = "Charon_Fierce",
				-- PreLineAnim = "Charon_Greeting",
				PreLineAnim = "Charon_Thanking",

				{ Cue = "/VO/Charon_0030", Text = "{#Emph}Mehhh...", PlayFirst = true },
				{ Cue = "/VO/Charon_0031", Text = "{#Emph}Sshhh..." },
				{ Cue = "/VO/Charon_0032", Text = "{#Emph}Ohhh..." },
				{ Cue = "/VO/Charon_0033", Text = "{#Emph}Kkrrrr..." },
				{ Cue = "/VO/Charon_0034", Text = "{#Emph}Hrrm..." },
				{ Cue = "/VO/Charon_0059", Text = "{#Emph}Nnggh..." },
				{ Cue = "/VO/Charon_0060", Text = "{#Emph}Rrnn..." },
				{ Cue = "/VO/Charon_0061", Text = "{#Emph}Grrhh..." },
				{ Cue = "/VO/Charon_0062", Text = "{#Emph}Mmm..." },
				{ Cue = "/VO/Charon_0063", Text = "{#Emph}Haah..." },				
			},
		},
	},

	SeleneGreeting =
	{
		WithinDistance = 830,
		-- PostTriggerAnimation = "AchillesIdleGreeting",
		VoiceLines =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
			},
			Cooldowns =
			{
				{ Name = "SeleneGreetingSpeech", Time = 400 },
			},
			{
				{
					Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"SeleneWithHecate01",
						},
					},
					{ Cue = "/VO/Selene_0105", Text = "Hail to you, Witch of the Crossroads." },
				},
				{
					BreakIfPlayed = true,
					UsePlayerSource = true,
					GameStateRequirements =
					{
						RequiredAnyQueuedTextLines = {
							"SeleneHome01",
						},
					},
					{ Cue = "/VO/Melinoe_0027", Text = "Sister Selene..." },
				},
			},
		},
	},

	ArachneMuttering =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "ArachneInterrupt",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.ArachneGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.ArachneMutteringLines,
		},
	},
	ArachneMutteringRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "ArachneInterrupt",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.ArachneGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.ArachneMutteringLines,
		},
	},

	ArachneCostumeChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "VitalityCostume",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "ManaCostume",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "AgilityCostume",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "IncomeCostume",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneFirstMeeting" },
					},		
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneFirstMeeting" },
					},	
				},
			},
			{
				Type = "Trait",
				ItemName = "CastDamageCostume",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneFirstMeeting" },
					},	
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneFirstMeeting" },
					},		
				},
			},
			{
				Type = "Trait",
				ItemName = "HighArmorCostume",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesSpent", "MetaFabric" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneFirstMeeting" },
					},		
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "ArachneFirstMeeting" },
					},	
				},
			},
		},
	},

	NarcissusMuttering =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "NarcissusInterrupt",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.NarcissusGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.NarcissusMutteringLines,
		},
	},
	NarcissusMutteringContinuous =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		VoiceLines =
		{
			[1] = GlobalVoiceLines.NarcissusMutteringLines,
		},
	},
	NarcissusMutteringRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "NarcissusInterrupt",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.NarcissusGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.NarcissusMutteringLines,
		},
	},
	NarcissusFieldsGreeting =
	{
		WithinDistance = 1111, ScaleY = 0.75,
		FunctionName = "FieldsBridgeEchoMusic",
		VoiceLines =
		{
			UsePlayerSource = true,
			{ Cue = "/VO/MelinoeField_1172", Text = "Is that...? It's him... Narcissus!"
			},
		},
	},
	NarcissusBenefitChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "NarcissusA",
				Rarity = "Common",
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusB",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "NarcissusC",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "NarcissusD",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "NarcissusE",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "NarcissusF",
				Rarity = "Common",
				GameStateRequirements =
				{
					NamedRequirements = { "RerollAvailable", },
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusG",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGrantsReward01" },
					},
				},
				PrioritySlotEntranceAnimation = "BoonEntranceLegendary",
				PriorityRequirements =
				{
					{
						PathFalse = { "GameState", "TraitsTaken", "NarcissusG" },
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusH",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "LifetimeResourcesGained", "PlantMoney" },
					},
					RequiredMinMaximumLastStands = 1,
					NotMaxLastStands = true,
				},
			},
			{
				Type = "Trait",
				ItemName = "NarcissusI",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "BlindBoxLoot" },
					},
					{
						PathTrue = { "GameState", "LifetimeResourcesGained", "SeedMystery" },
					},
					NamedRequirements = { "BlindBoxLootRequirements" },
				},
			},

		},
	},
		
	EchoBenefitChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "EchoLastReward",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "EchoLastRunBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "EchoDeathDefianceRefill",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "DiminishingDodgeBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "DiminishingHealthAndManaBoon",
				Rarity = "Common",
			},
		},
	},

	HadesGreeting =
	{
		WithinDistance = 800,
		VoiceLines =
		{
			BreakIfPlayed = true,
			GameStateRequirements =
			{
				{
					-- PathFalse = { "SessionMapState", "CauldronWitchcraftOccurring" },
				},
			},
			{
				{
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.5,
					ObjectType = "NPC_Hades_Field_01",
					PreLineAnim = "Hades_Hello",
					Cooldowns =
					{
						{ Name = "HadesSpokeRecently", Time = 5 },
					},

					{ Cue = "/VO/Hades_0081", Text = "{#Emph}Hrrnn?", PlayFirst = true, BreakIfPlayed = true },
					{ Cue = "/VO/Hades_0073", Text = "Who goes? ...You.", PlayFirst = true, BreakIfPlayed = true,
						GameStateRequirements =
						{
							{
								PathTrue = { "PrevRun", "SpeechRecord", "/VO/Hades_0081" },
							},
						},
					},
					{ Cue = "/VO/Hades_0074", Text = "It's you...", PlayFirst = true, },
					{ Cue = "/VO/Hades_0075", Text = "Daughter..." },
					{ Cue = "/VO/Hades_0076", Text = "Daughter...?" },
					{ Cue = "/VO/Hades_0077", Text = "Melinoë..." },
					{ Cue = "/VO/Hades_0078", Text = "Melinoë...?" },
					{ Cue = "/VO/Hades_0079", Text = "Is that you...?" },
					{ Cue = "/VO/Hades_0080", Text = "Back again?" },
					{ Cue = "/VO/Hades_0082", Text = "Wha...?" },
					{ Cue = "/VO/Hades_0083", Text = "Greetings..." },
					{ Cue = "/VO/Hades_0084", Text = "Cerberus, look who it is...",
						GameStateRequirements =
						{
							AreIdsAlive = { 506405 },
						},
					},
					{ Cue = "/VO/Hades_0150", Text = "Cerberus... look who it is.",
						GameStateRequirements =
						{
							AreIdsAlive = { 506405 },							
						},
					},
					{ Cue = "/VO/Hades_0151", Text = "She's back already, Cerberus...",
						GameStateRequirements =
						{
							AreIdsAlive = { 506405 },
						},
					},
				},
				{
					PreLineWait = 0.35,
					SuccessiveChanceToPlay = 0.75,
					RandomRemaining = true,
					UsePlayerSource = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Hades_Field_01" },
						},
					},

					{ Cue = "/VO/MelinoeField_1519", Text = "Father...!" },
					{ Cue = "/VO/MelinoeField_1520", Text = "Father...?" },
					{ Cue = "/VO/MelinoeField_1521", Text = "{#Emph}Erm... {#Prev}greetings, Father..." },
					{ Cue = "/VO/MelinoeField_1522", Text = "Greetings, Father..." },
					{ Cue = "/VO/MelinoeField_1523", Text = "It's me..." },
					{ Cue = "/VO/MelinoeField_1524", Text = "It's... me..." },

				},
			},
		},
	},

	MedeaCurseChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "HealingOnDeathCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "MoneyOnDeathCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "ManaOverTimeCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "SpawnDamageCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "ArmorPenaltyCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "SlowProjectileCurse",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "DeathDefianceRetaliateCurse",
				Rarity = "Common",
			},
		},
	},

	MedeaResearching =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "MedeaInterrupt",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.MedeaGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.MedeaCauldronLines,
			[2] = GlobalVoiceLines.MedeaCauldronLines,
			[3] = GlobalVoiceLines.MedeaCauldronLines,
			[4] = GlobalVoiceLines.MedeaCauldronLines,
			[5] = GlobalVoiceLines.MedeaCauldronLines,
			[6] = GlobalVoiceLines.MedeaCauldronLines,
			[7] = GlobalVoiceLines.MedeaCauldronLines,
			[8] = GlobalVoiceLines.MedeaCauldronLines,
			[9] = GlobalVoiceLines.MedeaCauldronWrapUpLines,
		},
	},
	MedeaResearchingRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "MedeaInterrupt",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.MedeaGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.MedeaCauldronLines,
			[2] = GlobalVoiceLines.MedeaCauldronLines,
			[3] = GlobalVoiceLines.MedeaCauldronLines,
			[4] = GlobalVoiceLines.MedeaCauldronLines,
			[5] = GlobalVoiceLines.MedeaCauldronLines,
			[6] = GlobalVoiceLines.MedeaCauldronLines,
			[7] = GlobalVoiceLines.MedeaCauldronLines,
			[8] = GlobalVoiceLines.MedeaCauldronLines,
			[9] = GlobalVoiceLines.MedeaCauldronWrapUpLines,
		},
	},
	MedeaWitchcraft =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "MedeaInterrupt",
			PreTriggerAnimation = "Medea_Casting_Start",
			PostTriggerAnimation = "Medea_Casting_End",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.MedeaGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.MedeaIncantationLines,
		},
	},

	CirceChanting =
	{
		StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "CirceInterrupt",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.CirceGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.CirceChanting,
			[2] = GlobalVoiceLines.CirceChanting,
			[3] = GlobalVoiceLines.CirceChanting,
			[4] = GlobalVoiceLines.CirceChantingWrapUp,
		},
	},
	CirceChantingRepeatable =
	{
		-- StatusAnimation = "StatusIconWantsToTalk",
		DistanceTrigger =
		{
			Name = "CirceInterrupt",
			WithinDistance = 450,
			VoiceLines = GlobalVoiceLines.CirceGreetingLines,
		},
		VoiceLines =
		{
			[1] = GlobalVoiceLines.CirceChanting,
			[2] = GlobalVoiceLines.CirceChanting,
			[3] = GlobalVoiceLines.CirceChanting,
			[4] = GlobalVoiceLines.CirceChantingWrapUp,
		},
	},

	CirceBlessingChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},
		
		PortraitShift = { Distance = 250, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "RandomArcanaTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "RemoveShrineTrait",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">",
						Value = 0,
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "DoubleFamiliarTrait",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						PathTrue = { "MapState", "FamiliarUnit" },
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "HealAmplifyTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "ArcanaRarityTrait",
				Rarity = "Common",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MetaUpgradeCostCache" },
						Comparison = ">",
						Value = 0,
					},
				},
			},
			{
				Type = "Trait",
				ItemName = "CirceEnlargeTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "CirceShrinkTrait",
				Rarity = "Common",
			},
		},
	},

	IcarusBenefitChoices =
	{
		SkipComponents =
		{
			"OlympusBackground",
			"ShopBackground",
			"ShopLighting",
		},
		
		PortraitShift = { Distance = 150, Angle = 180, Duration = 0.3, EaseIn = 0.5, EaseOut = 1.0, },

		OverwriteTableKeys =
		{
			SkipUpgradePresentationAndExitUnlock = true,	
		},

		UpgradeOptions =
		{
			{
				Type = "Trait",
				ItemName = "FocusAttackDamageTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "FocusSpecialDamageTrait",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "OmegaExplodeBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "CastHazardBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "BreakInvincibleArmorBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "BreakExplosiveArmorBoon",
				Rarity = "Common",
			},
			{
				Type = "Trait",
				ItemName = "SupplyDropBoon",
				Rarity = "Common",
			},
		},
	},

	NemesisGetFreeItemArgs =
	{
		Interval = 0.5,
		Force = 200,
		Consumables =
		{
			RandomSelection = true,
			{ Name = "EmptyMaxHealthDrop", },
			{ Name = "HealDrop" },
			{ Name = "LastStandDrop",
				GameStateRequirements =
				{
					NamedRequirements = { "LastStandAvailable", },
					NotMaxLastStands = true,
				},
			},
			{ Name = "HitShieldDrop" },
			{ Name = "ArmorBoost"},
		},
		SourceThreadedVoiceLines = "GivingItemVoiceLines",
		ConsumablePreDropFunctionName = "NemesisDropPresentation",
		ConsumablePreDropFunctionDelay = 0.7,
	},
	NemesisGetFreeItemPremiumArgs =
	{
		Interval = 0.5,
		Force = 200,
		Consumables =
		{
			RandomSelection = true,
			{
				Name = "LastStandDrop",
				GameStateRequirements =
				{
					NamedRequirements = { "LastStandAvailable", },
					NotMaxLastStands = true,
				},
				IgnoreSpawnRewardOnId = true,
			},
			{
				Name = "StackUpgradeBig",
				IgnoreLootPoints = true,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
				},
				IgnoreSpawnRewardOnId = true,
			},
			{ Name = "MaxHealthDropBig" },
			{ Name = "MaxManaDropBig"},
		},
		SourceThreadedVoiceLines = "GivingItemVoiceLines",
		ConsumablePreDropFunctionName = "NemesisDropPresentation",
		ConsumablePreDropFunctionDelay = 0.7,
	},

	NemesisDamageContestArgs =
	{
		Interval = 0.5,
		Force = 200,
		Timer = 5,
		DamageGoal = 1000,
		ExcessDamageGoal = 2000,
		SuccessConsumables =
		{
			RandomSelection = true,
			{ Name = "MaxHealthDrop", },
			{ Name = "MaxManaDrop", },
			{ Name = "StackUpgrade",
				IgnoreLootPoints = true,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
				},
			},
			{ Name = "RoomMoneyDrop", },
			{ Name = "TalentDrop",
				GameStateRequirements =
				{
					NamedRequirements = { "TalentLegal", },
				},
			},
		},
		FailConsumables =
		{
			RandomSelection = true,
			{ Name = "RoomRewardConsolationPrize", },
		},
		ConsumablePreDropFunctionName = "NemesisDropPresentation",
		ConsumablePreDropFunctionDelay = 0.7,
	},

	NemesisBuyItemChoices =
	{
		GetItemForce = 200,
		GetItemUpwardForce = 700,
		GiveOptions =
		{
			{
				UseGetCost = true,
			},
		},
		GetOptions =
		{
			--{ Name = "GiftDrop", CostResourceName = "Money", CostResourceMin = 60, CostResourceMax = 90, },
			{ Name = "MetaCurrencyDrop", DisplayName = "MetaCurrency", CostResourceName = "Money", CostResourceMin = 20, CostResourceMax = 40,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "MetaCurrencyDrop", Overrides = { AddResources = { MetaCurrency = 100, }, }, DisplayName = "MetaCurrency", CostResourceName = "Money", CostResourceMin = 40, CostResourceMax = 80,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MetaCurrencyDrop", Overrides = { AddResources = { MetaCurrency = 200, }, }, DisplayName = "MetaCurrency", CostResourceName = "Money", CostResourceMin = 80, CostResourceMax = 160,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "MetaCardPointsCommonDrop", DisplayName = "MetaCardPointsCommon", CostResourceName = "Money", CostResourceMin = 10, CostResourceMax = 19,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "MetaCardPointsCommonDrop", Overrides = { AddResources = { MetaCardPointsCommon = 10, }, }, DisplayName = "MetaCardPointsCommon", CostResourceName = "Money", CostResourceMin = 20, CostResourceMax = 39,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MetaCardPointsCommonDrop", Overrides = { AddResources = { MetaCardPointsCommon = 20, }, }, DisplayName = "MetaCardPointsCommon", CostResourceName = "Money", CostResourceMin = 40, CostResourceMax = 79,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "MemPointsCommonDrop", DisplayName = "MemPointsCommon", CostResourceName = "Money", CostResourceMin = 5, CostResourceMax = 9,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "MemPointsCommonDrop", Overrides = { AddResources = { MemPointsCommon = 20, }, }, DisplayName = "MemPointsCommon", CostResourceName = "Money", CostResourceMin = 10, CostResourceMax = 19,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MemPointsCommonDrop", Overrides = { AddResources = { MemPointsCommon = 40, }, }, DisplayName = "MemPointsCommon", CostResourceName = "Money", CostResourceMin = 20, CostResourceMax = 39,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "MaxHealthDrop", CostResourceName = "Money", CostResourceMin = 120, CostResourceMax = 135,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MaxHealthDropBig", CostResourceName = "Money", CostResourceMin = 240, CostResourceMax = 270,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "MaxManaDrop", CostResourceName = "Money", CostResourceMin = 95, CostResourceMax = 110,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MaxManaDropBig", CostResourceName = "Money", CostResourceMin = 190, CostResourceMax = 220,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "StackUpgrade", CostResourceName = "Money", CostResourceMin = 95, CostResourceMax = 110,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },

					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "StackUpgradeBig", CostResourceName = "Money", CostResourceMin = 180, CostResourceMax = 220,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
				},
			},

			{ Name = "WeaponUpgrade", CostResourceName = "Money", CostResourceMin = 190, CostResourceMax = 220,
				GameStateRequirements =
				{
					NamedRequirements = { "HammerLootRequirements", },
				},
			},
			{ Name = "WeaponUpgrade", CostResourceName = "Money", CostResourceMin = 190, CostResourceMax = 220,
				GameStateRequirements =
				{
					NamedRequirements = { "LateHammerLootRequirements", },
				},
			},

		},
		TradePostCostFunctionName = "NemesisTradePostCostPresentation",
	},

	NemesisTakeDamageForItemChoices =
	{
		GetItemForce = 200,
		GetItemUpwardForce = 700,
		GiveOptions =
		{
			{
				UseGetDamage = true,
			},
		},
		GetOptions =
		{
			{ Name = "MaxHealthDrop", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MaxHealthDropBig", DamageAmountMin = 20, DamageAmountMax = 40,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "MaxManaDrop", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 2,
					},
				},
			},
			{ Name = "MaxManaDropBig", DamageAmountMin = 20, DamageAmountMax = 40,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 2,
					},
				},
			},

			{ Name = "StackUpgrade", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "StackUpgradeBig", DamageAmountMin = 20, DamageAmountMax = 40,
				GameStateRequirements =
				{
					NamedRequirements = { "StackUpgradeLegal", },
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
				},
			},

			{ Name = "RoomMoneyDrop", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = "<=",
						Value = 1,
					},
				},
			},
			{ Name = "RoomMoneyDrop", DamageAmountMin = 20, DamageAmountMax = 40,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ClearedBiomes" },
						Comparison = ">",
						Value = 1,
					},
				},
			},

			{ Name = "TalentDrop", DamageAmountMin = 10, DamageAmountMax = 20,
				GameStateRequirements =
				{
					NamedRequirements = { "TalentLegal", },
				},
			},
		},

		TradePreCostFunctionName = "NemesisTakeDamagePreCostPresentation",
		TradePostCostFunctionName = "NemesisTakeDamagePostCostPresentation",
		AcceptSourceVoiceLines = "HitAcceptedVoiceLines",
		DeclineSourceVoiceLines = "HitDeclinedVoiceLines",
	},

	NemesisGiveTraitForItemChoices =
	{
		GetItemForce = 200,
		GetItemUpwardForce = 700,
		GiveOptions =
		{
			{
				SellTrait = true,
			},
		},
		GetOptions =
		{
			{ Name = "MaxHealthDropBig", },
			{ Name = "MaxManaDropBig", },
			{ Name = "StackUpgradeBig",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "UpgradableTraitCount" },
						Comparison = ">=",
						Value = 2,
					},
				},
			},
			{ Name = "RoomMoneyBigDrop", },
			{ Name = "TalentDrop",
				GameStateRequirements =
				{
					NamedRequirements = { "TalentLegal", },
				},
			},
		},		
		TradePostCostFunctionName = "NemesisTradePostCostPresentation",
	},

	RejectionBoonInteract =
	{
		PreLineWait = 1.0, -- currently unused
		SkipAnim = true,
	},

}

UnitSetData.NPCs =
{
	NPC_Neutral =
	{
		InheritFrom = { "IsNeutral" },
		OnUsedFunctionName = "UseNPC",
	},

	NPC_Giftable =
	{
		UsePromptOffsetX = 50,
		UsePromptOffsetY = -80,
		CanReceiveGift = true,
	},

	-- Nyx, -- Night, -- Mother Nyx, Id = 370010
	NPC_Nyx_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Nyx_Default_01",
		-- AnimOffsetZ = 270,
		AnimOffsetZ = 220,
		Groups = { "NPCs" },

		ActivateRequirements =
		{
			--
		},

		InteractTextLineSets =
		{
			NyxNightmare01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				UseText = "CannotUseObject",

				InteractDistance = 400,
				{ Cue = "/EmptyCue", Portrait = "Portrait_Nyx_Frozen_01",
					Text = ". . . ." },
				{ Cue = "/VO/Hades_0018", Speaker = "NPC_LordHades_01", 
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					PreLineWait = 0.35,
					Text = "...Nyx?" },
				{ Cue = "/EmptyCue", Portrait = "Portrait_Nyx_Frozen_01",
					Text = ". . . ." },
				{ Cue = "/VO/Hades_0019", Speaker = "NPC_LordHades_01",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Emote = "PortraitEmoteFiredUp",
					PostLineFunctionName = "FlashbackExpandClamps",
					Text = "Nyx? {#Emph}Nyx! Answer me! {#Prev}Blast...." },
			},
		},
	},

	-- Raki
	Familiar_Raven_01 =
	{
		UseSound = "/SFX/Familiars/RavenSquawk3",
		HappySound = "/SFX/Familiars/RavenGentleSquawk",
		FearSound = "/SFX/Familiars/RavenSquawkAngry",

		InteractVoiceLines =
		{
			PreLineWait = 0.4,
			RandomRemaining = true,
			BreakIfPlayed = true,
			{ Cue = "/VO/Melinoe_0984", Text = "Greetings, little raven.", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0986", Text = "I won't hurt you...", },
		},

		RecruitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			{ Cue = "/VO/Melinoe_0847", Text = "Come, little one, let's go.", },
		},
	},

	-- Other NPCs
	NPC_LightRanged =
	{
		InheritFrom = { "NPC_Neutral" },

		Groups = { "NPCS", "3DGhosts" },

		--[[
		SpecialInteractFunctionName = "SpecialInteractLightRanged",
		SpecialInteractGameStateRequirements =
		{
			{
				--PathTrue = { "GameState", "UseRecord", "NPC_Hecate_01", },
			},
		},
		SpecialInteractCooldown = 60,
		]]--

		ActivateRequirements =
		{
		},

		InteractTextLineSets = {},

		PostActivateEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					SetAnimation = "Enemy_LightRanged_Idle",
					AnimationSpeedMultiplierMin = 0.5,
					AnimationSpeedMultiplierMax = 1.0,
				},
				GameStateRequirements =
				{
					-- None
				},
			},
		},
	},
	NPC_3DGhostAlt =
	{
		InheritFrom = { "NPC_Neutral" },

		Groups = { "NPCS", "3DGhosts" },

		ActivateRequirements =
		{
		},

		InteractTextLineSets = { }
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPCs )

NPCVariantData =
{
	
}