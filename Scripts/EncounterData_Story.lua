OverwriteTableKeys( EncounterData,
{
	-- Story Encounters
	Story_Chronos_01 =
	{
		InheritFrom = { "Empty" },
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
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
						"ChronosReveal01",
						"ChronosFirstMeeting",
						"ChronosPostBattleMeeting01",
						"ChronosPostWinStreakMeeting01",
						"ChronosMeeting02",
						"ChronosMeeting03",
						"ChronosMeeting04",
						"ChronosMeeting05",
						"ChronosPostSurfaceMeeting01",
						"ChronosPostSurfaceMeeting02",
						"ChronosPostSurfaceMeeting03",
						"ChronosPostSurfaceMeeting04",
						"ChronosMeetingAboutZeus01",
						"ChronosMeetingAboutPoseidon01",
						"ChronosMeetingAboutHestia01",
						"ChronosMeetingAboutDemeter01",
						"ChronosMeetingAboutHera01",
						"ChronosPostBattleMeeting02",
						"ChronosPostBattleMeeting03",
						"ChronosPostBattleMeeting04",
						"ChronosMeetingAboutOlympians01",
					},
				},
			},
		},
	},

	Story_Narcissus_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Narcissus_01" }, } },

			{ FunctionName = "CheckConversations" },
			-- NemesisWithNarcissus01
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					RequiredAnyQueuedTextLines = { "NemesisWithNarcissus01_FollowUp", "NemesisWithNarcissus02_FollowUp", }
				},
				Args =
				{
					Ids = { 623584, },
				},
			},
		},
		UnthreadedEvents =
		{
			{ FunctionName = "EncounterAudio" },
			{ FunctionName = "HandleTrapChains" },
			{ FunctionName = "HandleEnemySpawns" },
			{ FunctionName = "CheckForAllEnemiesDead" },
			{ FunctionName = "PostCombatAudio" },
			{ FunctionName = "SpawnRoomReward" },
			{
				FunctionName = "SurpriseNPCPresentation",
				GameStateRequirements =
				{
					RequiredQueuedTextLines = "NemesisWithNarcissus01_FollowUp",
				},
				Args =
				{
					SourceId = 623584,
					IntroWait = 0.8,
					PanIds = { 623584, 563070, },
					VoiceLines =
					{
						Queue = "Interrupt",
						{
							PreLineWait = 0.75,
							UsePlayerSource = true,

							{ Cue = "/VO/MelinoeField_0034", Text = "Nemesis..." },
						},
					},
					TextLineSet =
					{
						NemesisWithNarcissus01 =
						{
							-- requirements are above
							{ Cue = "/VO/NemesisField_0025", PreLineWait = 0.35,
								AngleTowardTargetId = 563070,
								PreLineAnim = "Nemesis_Hub_Glare_Start",
								PreLineAnimTarget = 623584,
								Text = "...Look at me when I'm talking to you, you louse. Oh, right. You can't. Must be so sick of staring at yourself by now." },
							{ Cue = "/VO/Narcissus_0063", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
								-- PreLineAnim = "SisyphusExplaining", PreLineAnimTarget = 370001,
								Text = "The only thing I'm sick of, {#Emph}I-Forget-Your-Name{#Prev}, is you tramping about, disturbing my peace! If you don't have anything nice to say, why don't you {#Emph}go?" },
						{ Cue = "/VO/NemesisField_0026",
								PreLineAnim = "Nemesis_Hub_Glare_End",
								PreLineAnimTarget = 623584,
								PostLineFunctionName = "NemesisTeleportExitPresentation", PostLineFunctionArgs = { SkipVoice = true },
								Text = "Still indignant after all this time. Had you learned to show respect, you might not be stuck forever in the company of a buffoon. Well, drink it in." },
						},
					},
				},
			},
			{
				FunctionName = "SurpriseNPCPresentation",
				GameStateRequirements =
				{
					RequiredQueuedTextLines = "NemesisWithNarcissus02_FollowUp",
				},
				Args =
				{
					SourceId = 623584,
					IntroWait = 0.8,
					PanIds = { 623584, 563070, },
					VoiceLines =
					{
						Queue = "Interrupt",
						{
							PreLineWait = 0.75,
							UsePlayerSource = true,

							{ Cue = "/VO/MelinoeField_0035", Text = "Nemesis?" },
						},
					},
					TextLineSet =
					{
						NemesisWithNarcissus02 =
						{
							-- requirements are above
							{ Cue = "/VO/NemesisField_0423", PreLineWait = 0.35,
								AngleTowardTargetId = 563070,
								PreLineAnim = "Nemesis_Hub_Glare_Start",
								PreLineAnimTarget = 623584,
								Text = "...Tell me again I'm playing {#Emph}hard-to-get{#Prev}, and so help me, I will pluck your limbs from you one at a time like they're the petals of an {#Emph}itty bitty flower. {#Prev}How's that sound?" },
							{ Cue = "/VO/Narcissus_0186", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
								Emote = "PortraitEmoteFiredUp",
								-- PreLineAnim = "SisyphusExplaining", PreLineAnimTarget = 370001,
								Text = "Sounds {#Emph}bad{#Prev}, that's how! But also like something somebody playing hard-to-get would say. So I don't know! Now why don't you... {#Emph}tell me some more about yourself?" },
							{ Cue = "/VO/NemesisField_0424",
								PreLineAnim = "Nemesis_Hub_Glare_End",
								PreLineAnimTarget = 623584,
								PostLineFunctionName = "NemesisTeleportExitPresentation", PostLineFunctionArgs = { SkipVoice = true },
								Text = "Wait, you want me to {#Emph}stay. {#Prev}Something's come over you, all right. Well, clear enough that my work here is done. Know what's good for you, then don't go breaking any other hearts." },
							EndVoiceLines =
							{
								{
									ObjectType = "NPC_Narcissus_01",
									{ Cue = "/VO/Narcissus_0187", Text = "Oh {#Emph}yeah. {#Prev}She wants you, man. That much is {#Emph}very {#Prev}clear!", PreLineWait = 0.4 },
									{ Cue = "/VO/Narcissus_0188", Text = "Speaking of which...", PreLineWait = 1.1 },
								},
							},
						},

					},
				},
			},

		},

		StartVoiceLines =
		{
			-- 
		},

		ExitVoiceLines =
		{
			ObjectType = "NPC_Narcissus_01",
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				-- PreLineAnim = "",

				--
			}
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Narcissus_01", WithinDistance = 800,
				LeaveDistanceBuffer = 60,
				GameStateRequirements =
				{
					RequiredFalseQueuedTextLines =  { "NemesisWithNarcissus01_FollowUp", "NemesisWithNarcissus02_FollowUp" },
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},

				VoiceLines =
				{
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.25,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 60 },
					},

					{ Cue = "/VO/Melinoe_2148", Text = "What's all this?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "NarcissusFirstMeetingVO" },
					{ Cue = "/VO/Melinoe_2149", Text = "See anything you like?" },
					{ Cue = "/VO/Melinoe_2150", Text = "Don't mind me." },
					{ Cue = "/VO/Melinoe_2151", Text = "Just passing through..." },
				},

			},
			{
				PreTriggerWait = 1.0,
				TriggerObjectType = "OceanusExitDoor", WithinDistance = 300,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					-- [1] = GlobalVoiceLines.NarcissusPostGiftMutteringLines,
				},
			},

		},

	},

	Story_Echo_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "RoomCountCache", "H_Boss01" },
			},
		},
		RequireRoomReward = "Story",

		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Echo_01", "NPC_Narcissus_Field_01" }, }
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
						"NarcissusWithEcho01",
					},
				},
			},
			{ FunctionName = "CheckConversations" },
		},

		StartVoiceLines =
		{
			-- 
		},

		ExitVoiceLines =
		{
			ObjectType = "NPC_Echo_01",
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				-- PreLineAnim = "",

				--
			}
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Echo_01", WithinDistance = 1500, ScaleY = 0.75,
				LeaveDistanceBuffer = 60,
				FunctionName = "FieldsBridgeEchoMusic",
				GameStateRequirements =
				{
					RequiredAnyQueuedTextLines = { "EchoFirstMeeting" },
				},
				VoiceLines =
				{
					Queue = "Always",
					UsePlayerSource = true,
					{
						PreLineFunctionName = "GenericPresentation",
						PreLineFunctionArgs =
						{
							UseableOffIds = { 617749 },
						},
						PostLineFunctionName = "GenericPresentation",
						PostLineFunctionArgs =
						{
							UseableOnIds = { 617749 },
						},
						-- intro sequence
						{
							PlayOnce = true,
							PlayOnceContext = "EchoIntro",
  							SuccessiveChanceToPlayAll = 0.25,
							UsePlayerSource = true,

							{ Cue = "/VO/MelinoeField_0737", Text = "Someone there...?", PlayFirst = true },
						},
						{
							PlayOnce = true,
							PlayOnceContext = "EchoIntro",
							ObjectType = "NPC_Echo_01",

							{ Cue = "/VO/Echo_0002", Text = "Someone there? {#Echo1}Someone there? {#Prev}{#Echo2}Someone there?",
								GameStateRequirements =
								{
									{
										Path = { "LastLinePlayed" },
										IsAny = { "/VO/MelinoeField_0737" },
									},
								}
							},
						},
						{
							PlayOnce = true,
							PlayOnceContext = "EchoIntro",
							BreakIfPlayed = true,
							SuccessiveChanceToPlayAll = 0.25,
							UsePlayerSource = true,

							{ Cue = "/VO/MelinoeField_0738", Text = "I mean you no harm." },
						},
					},
				},
			},

			{
				TriggerObjectType = "NPC_Echo_01", WithinDistance = 1111, ScaleY = 0.75,
				LeaveDistanceBuffer = 60,
				FunctionName = "FieldsBridgeEchoMusic",
				VoiceLines =
				{
					Queue = "Always",
					UsePlayerSource = true,
					{
						GameStateRequirements =
						{
							RequiredAnyQueuedTextLines = { "EchoAboutEcho01" },
						},
						PreLineFunctionName = "GenericPresentation",
						PreLineFunctionArgs =
						{
							UseableOffIds = { 617749 },
						},
						PostLineFunctionName = "GenericPresentation",
						PostLineFunctionArgs =
						{
							UseableOnIds = { 617749 },
						},
						{
							UsePlayerSource = true,

							-- { Cue = "/VO/MelinoeField_0742", Text = "It's you again." },
							{ Cue = "/VO/MelinoeField_0743", Text = "It's only me. Who are you, may I ask?" },
						},
					},
					{ Cue = "/VO/MelinoeField_0746", Text = "Echo, is that you?",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutHelp01" },
						},
					},
					{ Cue = "/VO/MelinoeField_0749", Text = "Hey, it's Melinoë!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNymphs01" },
						},
					},
					{ Cue = "/VO/MelinoeField_0999", Text = "She's still here, poor thing...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutHeart01" },
						},
					},
					{ Cue = "/VO/MelinoeField_1181", Text = "How goes it, Echo? I'm doing all right!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutBridge01" },
						},
					},
					{ Cue = "/VO/MelinoeField_1194", Text = "Aren't you a welcome sight...!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutCurse01" },
						},
					},

					{ Cue = "/VO/MelinoeField_1183", Text = "Echo! Look, I have your Keepsake here. Your Concave Stone!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutKeepsake01" },
						},
					},

					{ Cue = "/VO/MelinoeField_1185", Text = "{#Emph}Whew... {#Prev}barely made it this far...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutChronos01" },
						},
					},

					{ Cue = "/VO/MelinoeField_1188", Text = "{#Emph}Ungh... {#Prev}just a little farther...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoLowHealth01" },
						},
					},
					{ Cue = "/VO/MelinoeField_1190", Text = "{#Emph}Whew... {#Prev}just the Nymph I wished to see...!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoLowHealth02" },
						},
					},
					{ Cue = "/VO/MelinoeField_1179", Text = "Closer and closer to Cerberus...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutCerberus01" },
						},
					},
					{ Cue = "/VO/MelinoeField_1002", Text = "Hello again, Echo. How have you been?",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNarcissus01" },
						},
					},
					{ Cue = "/VO/MelinoeField_1164", Text = "Echo, he's sorry! Narcissus, I mean. I think he's sorry.",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNarcissus02" },
						},
					},
					{ Cue = "/VO/MelinoeField_1166", Text = "Echo? Hey, about Narcissus...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNarcissus03" },
						},
					},
					{ Cue = "/VO/MelinoeField_1170", Text = "Echo, good, it's you! There's something I wanted to say.",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNarcissus04" },
						},
					},
					{ Cue = "/VO/MelinoeField_1168", Text = "Hey Echo, glad you're here!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNarcissus05" },
						},
					},
					{ Cue = "/VO/MelinoeField_1175", Text = "It's her again. Though all alone this time.",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNarcissus06" },
						},
					},
					{ Cue = "/VO/MelinoeField_1695", Text = "Echo, I have to talk to you.",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNarcissus07" },
						},
					},
					{ Cue = "/VO/MelinoeField_1177", Text = "Echo, good evening to you!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutCharon01" },
						},
					},
					{ Cue = "/VO/MelinoeField_1192", Text = "And there she is...!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoAboutNemesis01" },
						},
					},
					{ Cue = "/VO/MelinoeField_0752", Text = "Hi, Echo!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat01", "EchoChat02" },
						},
					},
					{ Cue = "/VO/MelinoeField_0753", Text = "Hello, hello, hello!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat03" },
						},
					},
					{ Cue = "/VO/MelinoeField_0754", Text = "Echo, how've you been?",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat04" },
						},
					},
					{ Cue = "/VO/MelinoeField_0755", Text = "It's only me again.",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat05" },
						},
					},
					{ Cue = "/VO/MelinoeField_0756", Text = "Echo, you all right?",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat06" },
						},
					},
					{ Cue = "/VO/MelinoeField_0757", Text = "Must be something I can do to help...?",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat07" },
						},
					},
					{ Cue = "/VO/MelinoeField_1007", Text = "Echo, let me know if I can help you...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat08" },
						},
					},
					{ Cue = "/VO/MelinoeField_1008", Text = "Always pleased to see you!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat09" },
						},
					},
					{ Cue = "/VO/MelinoeField_1009", Text = "Echo, it's you!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat10" },
						},
					},
					{ Cue = "/VO/MelinoeField_1010", Text = "It's you, thank the Fates...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat11" },
						},
					},
					{ Cue = "/VO/MelinoeField_1011", Text = "Finally a cheerful sight!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat12" },
						},
					},

					{ Cue = "/VO/MelinoeField_1203", Text = "Hellooo!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat13" },
						},
					},
					{ Cue = "/VO/MelinoeField_1204", Text = "Echooo!",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat14" },
						},
					},
					{ Cue = "/VO/MelinoeField_1205", Text = "Have to press on...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat15" },
						},
					},
					{ Cue = "/VO/MelinoeField_1206", Text = "So close to Tartarus...",
						GameStateRequirements = 
						{
							RequiredAnyQueuedTextLines = { "EchoChat16" },
						},
					},
					{ Cue = "/VO/MelinoeField_1207", Text = "I'm feeling wonderful tonight!",
						GameStateRequirements = 
						{
							{
								PathTrue = { "PrevRun", "Cleared" },
								PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
							},
							RequiredMinHealthFraction = 0.7,
							RequiredAnyQueuedTextLines = { "EchoChat17" },
						},
					},
					{ Cue = "/VO/MelinoeField_1208", Text = "Don't you despair, Echo...",
						GameStateRequirements = 
						{
							{
								PathTrue = { "PrevRun", "Cleared" },
							},
							RequiredAnyQueuedTextLines = { "EchoChat18" },
						},
					},

				},

			},

		},
	},

	Story_Medea_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Medea_01" }, } },
			{ FunctionName = "CheckConversations" },
		},

		StartVoiceLines =
		{
			-- 
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.33,
				SuccessiveChanceToPlay = 0.8,
				ObjectType = "NPC_Medea_01",
				-- PreLineAnim = "",
				Cooldowns =
				{
					{ Name = "MedeaIncantationSpeech", Time = 100 },
				},

				{ Cue = "/VO/Medea_0110", Text = "May all your foes be damned..." },
				{ Cue = "/VO/Medea_0111", Text = "Moonlight guide you on." },
				{ Cue = "/VO/Medea_0112", Text = "Tread lightly, sorceress." },
				{ Cue = "/VO/Medea_0113", Text = "Seek vengeance, sorceress." },
				{ Cue = "/VO/Medea_0114", Text = "Let none stand in our way." },
				{ Cue = "/VO/Medea_0115", Text = "They shall be terrified of you." },
				{ Cue = "/VO/Medea_0116", Text = "A pox upon our enemies.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Medea_0116" },
						},
					},
				},
				{ Cue = "/VO/Medea_0117", Text = "Now where was I with this...", PlayFirst = true },
				{ Cue = "/VO/Medea_0118", Text = "Alone again at last..." },
				{ Cue = "/VO/Medea_0119", Text = "Perhaps she shall go far..." },
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Medea_01", WithinDistance = 800,
				LeaveDistanceBuffer = 60,

				VoiceLines =
				{
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.25,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 60 },
					},

					-- { Cue = "/VO/Melinoe_2148", Text = "What's all this?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "NarcissusFirstMeetingVO" },
				},

			},
		},
	},

	Story_Circe_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Circe_01" }, } },
			{ FunctionName = "CheckConversations" },
		},

		StartVoiceLines =
		{
			-- 
		},

		ExitVoiceLines =
		{
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Circe_01", WithinDistance = 800,
				LeaveDistanceBuffer = 60,

				VoiceLines =
				{
					RandomRemaining = true,
					SuccessiveChanceToPlayAll = 0.25,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 60 },
					},

					-- { Cue = "/VO/Melinoe_2148", Text = "What's all this?", PlayFirst = true, PlayOnce = true, PlayOnceContext = "NarcissusFirstMeetingVO" },
				},

			},
		},
	},

	NemesisRandomEvent =
	{
		InheritFrom = { "NonCombat" },

		DisableTraps = true,
		NextRoomResumeMusic = true,
		BlockMaxBonusRewards = true,

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
			},
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "NemesisCombatFirstIntro", "NemesisWithNarcissus01" },
			},
			{
				Path = { "CurrentRun", "BiomeDepthCache" },
				Comparison = ">=",
				Value = 4,
			},
			{
				PathFalse = { "CurrentRun", "ActiveBounty" },
			},
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "ManaUpgrade", "TalentDrop" },

		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "SimulateCombatDestruction",
				Args =
				{
					DecalNames = { "BloodSplatGroundRandom", },
					DecalsMin = 50,
					DecalsMax = 100,
					DecalRadius = 30,
					DestroyBreakablesMin = 5,
					DestroyBreakablesMax = 10,
				},
			},
			{
				FunctionName = "SpawnNemesisForRandomEvents",
				Args =
				{
					PreferredSpawnPointGroup = "BonusRewardSpawnPoints",
					PreferredSpawnPoint = "LootPoint",
					CheckRewardPointsUsed = true,
					NPCVariantData = "NemesisRandomEvent",
				}
			},
		},

		ExitsUnlockedThreadedEvents =
		{
			{
				FunctionName = "CheckFieldsExitIndicators",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
				},
			},
			{
				FunctionName = "FieldsExitsReadyPresentation",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
				},
			},
			{
				FunctionName = "NemesisTakeRoomExit",
				Args =
				{
					RandomWaitMin = 1.0,
					RandomWaitMax = 3.0,
				},
				GameStateRequirements =
				{
					ChanceToPlay = 1.0,
				},
			},
		},
	},

	BridgeNemesisRandomEvent =
	{
		InheritFrom = { "NemesisRandomEvent" },

		RequireRoomReward = "Story",
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "SpawnNemesisForRandomEvents",
				Args =
				{
					PreferredSpawnPointGroup = "BonusRewardSpawnPoints",
					PreferredSpawnPoint = "EnemyPoint",
					NPCVariantData = "NemesisRandomEvent",
				}
			},
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatIntro" },
			},
			{
				Path = { "GameState", "RoomsEntered", "H_Bridge01" },
				Comparison = ">=",
				Value = 6,
			},
			{
				SumPrevRuns = 5,
				Path = { "EncountersOccurredCache", "BridgeNemesisRandomEvent" },
				Comparison = "<=",
				Value = 0,
			},
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
		},

	},

	Story_Heracles_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Heracles_01" }, } },
			{ FunctionName = "CheckConversations" },
		},

		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "HeraclesFirstMeeting" },
			},
		},

		StartVoiceLines =
		{
			-- 
		},

		ExitVoiceLines =
		{
			ObjectType = "NPC_Heracles_01",
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				-- PreLineAnim = "",

				--
			}
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Heracles_01", WithinDistance = 800,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.33,
					UsePlayerSource = true,
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 60 },
					},

					{ Cue = "/VO/Melinoe_0576", Text = "Mmm.", PlayFirst = true },
					{ Cue = "/VO/Melinoe_1096", Text = "Peace, sir." },
					{ Cue = "/VO/Melinoe_1097", Text = "Good evening." },
				},
			},
		},
	},

	Story_Hades_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					LegalTypes = { "NPC_Hades_Field_01", },
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					LegalTypes = { "NPC_Bouldy_01" },
				},
			},
			{
				-- Cerberus always spawn before HadesAboutSisyphus01
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					LegalTypes = { "NPC_Cerberus_Field_01", },
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "HadesAboutSisyphus01", },
					},
				},
			},
			{
				-- Cerberus sometimes spawns after HadesAboutSisyphus01
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					LegalTypes = { "NPC_Cerberus_Field_01", },
				},
				GameStateRequirements =
				{
					ChanceToPlay = 0.8,
					{
						PathTrue = { "GameState", "TextLinesRecord", "HadesAboutSisyphus01", },
					},
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
						"CerberusFirstMeeting",
					},
				},
			},
			{ FunctionName = "CheckConversations" },
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Hades_Field_01", WithinDistance = 600,
				LeaveDistanceBuffer = 60,
				VoiceLines =
				{
					{
						RandomRemaining = true,
						-- PreLineAnim = "",

						--
					},
					{
						UsePlayerSource = true,
						RandomRemaining = true,
						SuccessiveChanceToPlay = 0.66,

						--
					},
				},
			},
		},
	},
})