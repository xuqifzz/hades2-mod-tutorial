OverwriteTableKeys( EncounterData,
{
	-- Story Encounters
	Story_Arachne_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,

		OnSpawnFunctionName = "ArachneCombatDrumCheck",
		OnKillFunctionName = "ArachneCombatDrumCheck",
		
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Arachne_01" }, } },

			{ FunctionName = "CheckConversations" },
			-- HecateWithArachne01
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "HecateWithArachne01_FollowUp", }, },
					},
				},
				Args =
				{
					Ids = { 593595, },
				},
			},
			{ FunctionName = "SpawnArachneCocoons", Args = { CocoonCountMin = 0, CocoonCountMax = 3, CocoonOptions = { "ArachneCocoonMedium", "ArachneCocoon" } } }
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "SurpriseNPCPresentation",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "HecateWithArachne01_FollowUp", }, },
					},
				},
				Args =
				{
					SourceId = 593595,
					IntroWait = 0.4,
					PanIds = { 593595, 557839, },
					VoiceLines =
					{
						Queue = "Interrupt",
						{
							PreLineWait = 0.75,
							UsePlayerSource = true,
							{ Cue = "/VO/Melinoe_0036", Text = "Headmistress..." }
						},
					},
					TextLineSet =
					{
						HecateWithArachne01 =
						{
							-- requirements are above
							{ Cue = "/VO/Hecate_0549", PreLineWait = 0.5,
								AngleTowardTargetId = 557839,
								PreLineAnim = "Hecate_Hub_Explaining_Start",
								PostLineAnim = "Hecate_Hub_Explaining_End",
								Text = "...My point, Arachne, is... I've no intention to deflect blame for what I've done. And although I cannot rescind my actions, know that your safety in these woods is guaranteed." },
							{ Cue = "/VO/Arachne_0102", Portrait = "Portrait_Arachne_Default_01", Speaker = "NPC_Arachne_01",
								Text = "I do appreciate your candor in this, Titaness. However, if my safety now is your concern... you can begin by showing yourself out. With all due respect." },
						{ Cue = "/VO/Hecate_0550",
								PreLineWait = 0.35,
								PreLineAnim = "Hecate_Hub_Scoff",
								PreLineAnimTarget = 593595,
								PostLineThreadedFunctionName = "HecateFlashback02Exit",
								Text = "Very well. I shan't intrude upon your home again; good evening." },
						},
					},
				},
			},
			-- any others
		},

		ExitVoiceLines =
		{
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasNone = GameData.ArachneUpsetEvents,
				},
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlay = 0.8,
				ObjectType = "NPC_Arachne_01",

				{ Cue = "/VO/Arachne_0299", Text = "Farewell, my friend!" },
				{ Cue = "/VO/Arachne_0300", Text = "Farewell..." },
				{ Cue = "/VO/Arachne_0301", Text = "Goodbye for now!" },
				{ Cue = "/VO/Arachne_0302", Text = "Come back soon...!" },
				{ Cue = "/VO/Arachne_0303", Text = "Do be careful out there!" },
				{ Cue = "/VO/Arachne_0304", Text = "Do come again, won't you?" },
				{ Cue = "/VO/Arachne_0305", Text = "I'll be right here, all right?" },
				{ Cue = "/VO/Arachne_0306", Text = "You truly do look great!" },
				{ Cue = "/VO/Arachne_0307", Text = "To your success!", PlayFirst = true },
				{ Cue = "/VO/Arachne_0308", Text = "Away she goes..." },
				{ Cue = "/VO/Arachne_0309", Text = "Alone again... {#Emph}ha ha ha..." },
				{ Cue = "/VO/Arachne_0310", Text = "{#Emph}<Sigh>" },
			},
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.66,
				PreLineWait = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1764", Text = "Weave on." },
				{ Cue = "/VO/Melinoe_1765", Text = "Until we meet again." },
				{ Cue = "/VO/Melinoe_1766", Text = "Keep on spinning." },
				{ Cue = "/VO/Melinoe_1767", Text = "Be well, all right?" },
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Arachne_01", WithinDistance = 800,
				LeaveDistanceBuffer = 60,

				VoiceLines =
				{
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.66,
					SuccessiveChanceToPlayAll = 0.2,
					UsePlayerSource = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "UseRecord", "NPC_Arachne_01" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech", Time = 60 },
					},

					{ Cue = "/VO/Melinoe_0830", Text = "Oh.", PlayFirst = true },
					{ Cue = "/VO/Melinoe_1092", Text = "Arachne!" },
					{ Cue = "/VO/Melinoe_1093", Text = "Hi, Arachne." },
					{ Cue = "/VO/Melinoe_1406", Text = "Arachne's fineries..." },
				},

			},
		},
	},

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
					{
						PathFalse = { "PrevRun", "SpawnedChronosForTaunt" },
					},
					{
						Path = { "PrevRun", "TextLinesRecord" },
						HasNone = GameData.NeoChronosErebusEvents,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				Args =
				{
					IgnorePartnerExists = true,
					Conversations = GameData.NeoChronosErebusEvents,
				},
			},
			{
				FunctionName = "SpawnChronosForTaunt",
				Args =
				{
					UnitId = 772130,
					UnitName = "NPC_Chronos_02",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "SpawnRecord", "NPC_Chronos_02" },
					},
					{
						PathFalse = { "PrevRun", "SpawnedChronosForTaunt" },
					},
					{
						Path = { "PrevRun", "TextLinesRecord" },
						HasNone = GameData.NeoChronosErebusEvents,
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
					ChanceToPlay = 0.5,
				},
			},

			-- pre-ending
			{
				FunctionName = "CheckPriorityConversations",
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathFalse = { "PrevRun", "SpawnRecord", "NPC_Chronos_01" },
							},
						},
						{
							{
								Path = { "PrevRun", "TextLinesRecord" },
								HasAny = { "ChronosAnomalyIntro01" },
							},
						},
					},
					-- @ ending
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirementsFalse = { "HecateMissing" },
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
						"ChronosMeetingAboutPrometheus01",
						"ChronosMeetingAboutPrometheus02",
						"ChronosMeetingAboutTyphon01",
						"ChronosMeetingAboutTyphon02",
						"ChronosMeetingAboutTyphonW01",
						"ChronosMeetingAboutShrine01",
					},
				},
			},
			{
				FunctionName = "SpawnChronosForTaunt",
				Args =
				{
					UnitId = 561902,
					UnitName = "NPC_Chronos_01",
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = ">=",
						Value = 1,
					},
					-- not spawned PrevRun, or the run before that
					{
						SumPrevRuns = 3,
						Path = { "SpawnRecord", "NPC_Chronos_01" },
						Comparison = "<=",
						Value = 0,
					},
					NamedRequirementsFalse = { "HecateMissing" },
					ChanceToPlay = 0.5,
				},
			},
		},

		DistanceTriggers =
		{
			{
				TriggerObjectType = "NPC_Chronos_02", WithinDistance = 950,
				VoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineAnim = "NPC_Chronos_Enlightened_Greet",

					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.1 },
					Cooldowns =
					{
						{ Name = "ChronosSpokeRecently", Time = 4 },
					},

					{ Cue = "/VO/Chronos_1319", Text = "Go on, Granddaughter, and I shall be waiting at the House." },
					{ Cue = "/VO/Chronos_1327", Text = "Fight on, Granddaughter, and farewell till Tartarus!" },
					{ Cue = "/VO/Chronos_1328", Text = "Let us eliminate all traces of my foul former self." },
					{ Cue = "/VO/Chronos_1322", Text = "Death to Chronos, Granddaughter!",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
							},
						},
					},
					{ Cue = "/VO/Chronos_1323", Text = "Death to Chronos, Granddaughter! But only to the other ones.",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
							},
							{
								PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Chronos_1323" },
							},
						},
					},
					{ Cue = "/VO/Chronos_1320", Text = "Go forth! I know that you shall once again prevail!",
						GameStateRequirements =
						{
							{
								Path = { "GameState", "LastBossHealthBarRecord", "Chronos" },
								Comparison = "<=",
								Value = 0,
							},
						},
					},
					{ Cue = "/VO/Chronos_1321", Text = "Last night perhaps did not pan out but there is always {#Emph}now!",
						GameStateRequirements =
						{
							{
								PathFalse = { "PrevRun", "Cleared" },
							},
						},
					},
					{ Cue = "/VO/Chronos_1324", Text = "If you already have the might of Zeus, then this bodes well!",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
							},
						},
					},
					{ Cue = "/VO/Chronos_1325", Text = "The strength of my strong son Poseidon already at hand!",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" },
							},
						},
					},
					{ Cue = "/VO/Chronos_1326", Text = "You have your father's blessing even now...!",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "Hero", "TraitDictionary" },
								HasAny =
								{
									"HadesLifestealBoon",
									"HadesCastProjectileBoon",
									"HadesPreDamageBoon",
									"HadesChronosDebuffBoon",
									"HadesInvisibilityRetaliateBoon",
									"HadesDeathDefianceDamageBoon",
									"HadesManaUrnBoon",
								},
							},
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "SpawnedChronosForTaunt" },
					},
				},
			},
			{
				TriggerObjectType = "NPC_Chronos_01", WithinDistance = 950,
				VoiceLines =
				{
					RandomRemaining = true,
					BreakIfPlayed = true,
					PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",

					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.1 },
					Cooldowns =
					{
						{ Name = "ChronosSpokeRecently", Time = 4 },
					},

					{ Cue = "/VO/Chronos_0621", Text = "You rabble-rousing miscreant, {#Emph}again?", PlayFirst = true },
					{ Cue = "/VO/Chronos_0622", Text = "You have a long way yet to go, Granddaughter..." },
					{ Cue = "/VO/Chronos_0623", Text = "I shall be waiting for you hence, my girl!" },
					{ Cue = "/VO/Chronos_0624", Text = "Such an arduous path you have before you, girl." },
					{ Cue = "/VO/Chronos_0625", Text = "Have you learned nothing, Granddaughter...?" },
					{ Cue = "/VO/Chronos_0626", Text = "What a meddlesome child that Hades has in you." },
					{ Cue = "/VO/Chronos_0627", Text = "You ought be much better behaved than this." },
					{ Cue = "/VO/Chronos_0628", Text = "Such stubborn disobedience from a granddaughter of mine." },
					{ Cue = "/VO/Chronos_0629", Text = "I do not appreciate your stubbornness, my girl." },
					{ Cue = "/VO/Chronos_0630", Text = "This night shall not go quite as well as you expect." },
					{ Cue = "/VO/Chronos_0924", Text = "You stubborn and incorrigible child..." },
					{ Cue = "/VO/Chronos_0926", Text = "Safe travels down to Tartarus my girl." },
					{ Cue = "/VO/Chronos_0925", Text = "Are you enjoying this nightly routine?",
						GameStateRequirements =
						{
							{
								PathTrue = { "PrevRun", "RoomsEntered", "G_Intro" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0929", Text = "Night after night you carry on like this?",
						GameStateRequirements =
						{
							{
								PathTrue = { "PrevRun", "RoomsEntered", "G_Intro" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0927", Text = "Decided to give poor Typhon a break?",
						GameStateRequirements =
						{
							{
								Path = { "PrevRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
							{
								PathTrue = { "PrevRun", "Cleared" },
							},
							{
								PathFalse = { "PrevRun", "ZeusPalaceAboutTyphonDeath01" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0928", Text = "How shall Olympus withstand Typhon with you here?",
						GameStateRequirements =
						{
							{
								Path = { "PrevRun", "RoomsEntered" },
								HasAny = { "Q_Boss01", "Q_Boss02" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0930", Text = "That staff of yours is no match for my scythe.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponStaffSwing" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0931", Text = "Come to assassinate me with those knives?",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0932", Text = "Those torches of yours made you easy to detect.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0933", Text = "That axe of yours looks awfully unwieldy to me.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0934", Text = "You traipse about with that exploding skull?",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponLob" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0935", Text = "You look absurd with those newfangled armaments.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0936", Text = "At least you bring a proper weapon to our fight.",
						GameStateRequirements =
						{
							{
								PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AxePerfectCriticalAspect" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0937", Text = "You mock me with all these nightly affronts.",
						GameStateRequirements =
						{
							{
								PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
							},
							{
								PathTrue = { "PrevRun", "Cleared" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0938", Text = "Go on, face me again, see if I care!",
						GameStateRequirements =
						{
							{
								PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
							},
							{
								PathTrue = { "PrevRun", "Cleared" },
							},
						},
					},
					{ Cue = "/VO/Chronos_0939", Text = "This night shall go no different from the last.",
						GameStateRequirements =
						{
							{
								PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
							},
							{
								PathFalse = { "PrevRun", "Cleared" },
							},
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "SpawnedChronosForTaunt" },
					},
				},
			},
		},

	},

	Story_Narcissus_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Narcissus_01" }, } },

			{ FunctionName = "CheckConversations" },
			-- NemesisWithNarcissus01
			{
				FunctionName = "ActivatePrePlacedUnits",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "NemesisWithNarcissus01_FollowUp", "NemesisWithNarcissus02_FollowUp", }, },
					},
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
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "NemesisWithNarcissus01_FollowUp", }, },
					},
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
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "NemesisWithNarcissus02_FollowUp", }, },
					},
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
		ThreadedEvents =
		{
			{ FunctionName = "NarcissusAdmirersPresentation" },
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
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "NemesisWithNarcissus01_FollowUp", "NemesisWithNarcissus02_FollowUp" }, },
					},
					-- NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},

				VoiceLines =
				{
					UsePlayerSource = true,
					RandomRemaining = true,
					SuccessiveChanceToPlay = 0.25,
					SuccessiveChanceToPlayAll = 0.5,
					SkipCooldownCheckIfNonePlayed = true,
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
					-- [1] = { GlobalVoiceLines = "NarcissusPostGiftMutteringLines" },
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
				PathTrue = { "GameState", "RoomsEntered", "H_Boss01" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "MutePermanent" },
			},
		},
		RequireRoomReward = "Story",

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
					IgnorePartnerExists = true,
					Conversations =
					{
						"NarcissusWithEcho01",
						"NarcissusWithEcho02",
						"NarcissusWithEcho03",
					},
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Echo_01", }, },
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
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny = { "EchoFirstMeeting", }, },
					},
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
							PreLineAnim = "Echo_Greeting_Start",

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
				PostTriggerFunctionName = "GenericPresentation",
				PostTriggerFunctionArgs = { Id = 617749, SetAnimation = "Echo_Greeting_Start" },
				VoiceLines =
				{
					Queue = "Always",
					UsePlayerSource = true,
					{
						GameStateRequirements =
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutEcho01", }, },
							},
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
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutHelp01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0749", Text = "Hey, it's Melinoë!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNymphs01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0999", Text = "She's still here, poor thing...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutHeart01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1181", Text = "How goes it, Echo? I'm doing all right!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutBridge01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1194", Text = "Aren't you a welcome sight...!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutCurse01", }, },
							},
						},
					},

					{ Cue = "/VO/MelinoeField_1183", Text = "Echo! Look, I have your Keepsake here. Your Concave Stone!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutKeepsake01", }, },
							},
						},
					},

					{ Cue = "/VO/MelinoeField_1185", Text = "{#Emph}Whew... {#Prev}barely made it this far...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutChronos01", }, },
							},
						},
					},

					{ Cue = "/VO/MelinoeField_1188", Text = "{#Emph}Ungh... {#Prev}just a little farther...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoLowHealth01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1190", Text = "{#Emph}Whew... {#Prev}just the Nymph I wished to see...!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoLowHealth02", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1179", Text = "Closer and closer to Cerberus...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutCerberus01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1002", Text = "Hello again, Echo. How have you been?",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNarcissus01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1164", Text = "Echo, he's sorry! Narcissus, I mean. I think he's sorry.",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNarcissus02", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1166", Text = "Echo? Hey, about Narcissus...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNarcissus03", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1170", Text = "Echo, good, it's you! There's something I wanted to say.",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNarcissus04", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1168", Text = "Hey Echo, glad you're here!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNarcissus05", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1175", Text = "It's her again. Though all alone this time.",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNarcissus06", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1695", Text = "Echo, I have to talk to you.",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNarcissus07", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2871", Text = "Hello Echo, my friend!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutFields01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_2874", Text = "Message for me, Mel?",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNarcissus08", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1177", Text = "Echo, good evening to you!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutCharon01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1192", Text = "And there she is...!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutNemesis01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4641", Text = "That looks like quite the gathering of Shades...!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutHelp02", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4645", Text = "Echo, we did it!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoPostTrueEnding01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4623", Text = "It's you. It's been too long!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutOlympus01", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4668", Text = "Don't give in.",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutCurse02", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4638", Text = "Echo, are you back...?",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoAboutCurse03", }, },
							},
						},
					},

-- { Cue = "/VO/MelinoeField_4641", Text = "That looks like quite the gathering of Shades...!" },
-- { Cue = "/VO/MelinoeField_4643", Text = "Hecuba, remember this place?" },
-- { Cue = "/VO/MelinoeField_4645", Text = "Echo, we did it!" },
-- { Cue = "/VO/MelinoeField_4648", Text = "Whew, it's tough out there..." },
-- { Cue = "/VO/MelinoeField_4651", Text = "You're not alone." },
-- { Cue = "/VO/MelinoeField_4652", Text = "You're looking well!" },
-- { Cue = "/VO/MelinoeField_4653", Text = "Take care OK?" },
-- { Cue = "/VO/MelinoeField_4654", Text = "Moonlight guide you." },
-- { Cue = "/VO/MelinoeField_4655", Text = "Thank you for your help." },
-- { Cue = "/VO/MelinoeField_4656", Text = "Let's keep going..." },
-- { Cue = "/VO/MelinoeField_4657", Text = "Always good to see a friendly face!" },
-- { Cue = "/VO/MelinoeField_4658", Text = "Just passing through...!" },
-- { Cue = "/VO/MelinoeField_4659", Text = "Hi Echo, what's new?" },
-- { Cue = "/VO/MelinoeField_4660", Text = "Why hello again." },
-- { Cue = "/VO/MelinoeField_4661", Text = "I'm back from Olympus...!" },

					{ Cue = "/VO/MelinoeField_0752", Text = "Hi, Echo!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat01", "EchoChat02", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0753", Text = "Hello, hello, hello!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat03", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0754", Text = "Echo, how've you been?",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat04", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0755", Text = "It's only me again.",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat05", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0756", Text = "Echo, you all right?",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat06", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_0757", Text = "Must be something I can do to help...?",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat07", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1007", Text = "Echo, let me know if I can help you...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat08", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1008", Text = "Always pleased to see you!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat09", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1009", Text = "Echo, it's you!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat10", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1010", Text = "It's you, thank the Fates...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat11", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1011", Text = "Finally a cheerful sight!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat12", }, },
							},
						},
					},

					{ Cue = "/VO/MelinoeField_1203", Text = "Hellooo!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat13", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1204", Text = "Echooo!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat14", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1205", Text = "Have to press on...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat15", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1206", Text = "So close to Tartarus...",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat16", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1207", Text = "I'm feeling wonderful tonight!",
						GameStateRequirements = 
						{
							{
								PathTrue = { "PrevRun", "Cleared" },
							},
							{
								PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
							},
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat17", }, },
							},
							{
								FunctionName = "RequiredHealthFraction",
								FunctionArgs = { Comparison = ">=", Value = 0.7, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_1208", Text = "Don't you despair, Echo...",
						GameStateRequirements = 
						{
							{
								PathTrue = { "PrevRun", "Cleared" },
							},
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat18", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4651", Text = "You're not alone.",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat19", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4652", Text = "You're looking well!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat20", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4654", Text = "Moonlight guide you.",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat21", }, },
							},
						},
					},
					{ Cue = "/VO/MelinoeField_4658", Text = "Just passing through...!",
						GameStateRequirements = 
						{
							{
								FunctionName = "RequiredQueuedTextLine",
								FunctionArgs = { IsAny = { "EchoChat22", }, },
							},
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
				PreLineWait = 0.25,
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
	},

	Story_Circe_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Circe_01" }, } },
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 0.2, FractionMax = 1.0, LegalTypes = { "Pig" }, } },
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "PigSad" }, } },
			{ FunctionName = "CheckConversations" },
		},

		StartVoiceLines =
		{
			-- 
		},
	},

	Story_Dionysus_01 =
	{
		InheritFrom = { "NonCombat" },
		MaxAppearancesThisBiome = 1,
		UnthreadedEvents = {},
		StartRoomUnthreadedEvents =
		{
			{ FunctionName = "ActivatePrePlaced", Args = { FractionMin = 1.0, FractionMax = 1.0, LegalTypes = { "NPC_Dionysus_01" }, } },
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
				PreLineWait = 0.25,
				SuccessiveChanceToPlayAll = 0.8,
				ObjectType = "NPC_Dionysus_01",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.ArachneUpsetEvents,
					},
				},

				{ Cue = "/VO/Dionysus_0103", Text = "Take it easy!" },
				{ Cue = "/VO/Dionysus_0104", Text = "Stay warm all right?" },
				{ Cue = "/VO/Dionysus_0105", Text = "Going so soon?" },
				{ Cue = "/VO/Dionysus_0106", Text = "Well see you!" },
				{ Cue = "/VO/Dionysus_0107", Text = "Stay cool!" },
				{ Cue = "/VO/Dionysus_0108", Text = "Bye now!" },
				{ Cue = "/VO/Dionysus_0109", Text = "Don't worry!" },
				{ Cue = "/VO/Dionysus_0110", Text = "It'll be fine!" },
				{ Cue = "/VO/Dionysus_0111", Text = "Have a great night!" },
				{ Cue = "/VO/Dionysus_0112", Text = "{#Emph}Whew{#Prev}, where were we?" },
				{ Cue = "/VO/Dionysus_0113", Text = "What's with her...?" },
				{ Cue = "/VO/Dionysus_0114", Text = "Bit uptight there, yeah?", PlayFirst = true },
				{ Cue = "/VO/Dionysus_0115", Text = "She'll be back." },
				{ Cue = "/VO/Dionysus_0116", Text = "Off she goes!" },
				{ Cue = "/VO/Dionysus_0071", Text = "What's with {#Emph}her?" },
				{ Cue = "/VO/Dionysus_0219", Text = "{#Emph}Whew! {#Prev}Anyhow, does anybody need another drink or what?" },
				{ Cue = "/VO/Dionysus_0220", Text = "Now anybody need another round?" },
				{ Cue = "/VO/Dionysus_0221", Text = "Who needs a refill, you just say the word!" },
				{ Cue = "/VO/Dionysus_0222", Text = "{#Emph}Anyway {#Prev}what were we on about before, remind me yeah?" },
				{ Cue = "/VO/Dionysus_0223", Text = "Come, everybody loosen up, what's gotten into you?" },
				{ Cue = "/VO/Dionysus_0224", Text = "Hey everybody good, got what they need?" },
				{ Cue = "/VO/Dionysus_0225", Text = "And while I'm at it anybody else want anything?" },
				{ Cue = "/VO/Dionysus_0226", Text = "Hey you there in the pool I {#Emph}saw {#Prev}that!" },
				{ Cue = "/VO/Dionysus_0210", Text = "You're welcome back here anytime!" },
			},

		},
	},

	NemesisRandomEvent =
	{
		InheritFrom = { "NonCombat" },

		DisableTraps = true,
		NextRoomResumeMusic = true,
		BlockMaxBonusRewards = true,

		-- For Fields where this is the room's encounter.
		MoneyDropStore = 25,

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
			NamedRequirements = { "NoRecentNemesisEncounter", "NoRecentFieldNPCEncounter" },
			NamedRequirementsFalse = { "StandardPackageBountyActive", "HecateMissing", "NemesisBecomingCloserAvailable", },
		},

		RequireNotRoomReward = { "Boon", "SpellDrop", "Devotion", "HermesUpgrade", "WeaponUpgrade", "StackUpgrade", "TalentDrop" },

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
		RequireMinPlayerDistance = 300,

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
					RandomWaitMin = 0.1,
					RandomWaitMax = 0.5,
				},
				GameStateRequirements =
				{
					ChanceToPlay = 1.0,
					{
						PathEmpty = { "GameState", "NemesisTakeExitRecord" },
					},
				},
			},
			{
				FunctionName = "NemesisTakeRoomExit",
				Args =
				{
					RandomWaitMin = 0.5,
					RandomWaitMax = 2.0,
				},
				GameStateRequirements =
				{
					ChanceToPlay = 1.0,
					{
						PathNotEmpty = { "GameState", "NemesisTakeExitRecord" },
					},
				},
			},
		},

		SetupEvents =
		{
			{
				FunctionName = "EraseRoomKeys",
				Args =
				{
					EraseKeys =
					{
						"FishingPointSuccess",
						"ExorcismPointSuccess",
					},
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
				PathFalse = { "GameState", "EncountersCompletedCache", "BridgeNemesisRandomEvent" },
			},
			--[[
			{
				SumPrevRuns = 5,
				Path = { "EncountersOccurredCache", "BridgeNemesisRandomEvent" },
				Comparison = "<=",
				Value = 0,
			},
			]]
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
				GameStateRequirements =
				{
					-- None
				},
				Args =
				{
					LegalTypes = { "NPC_Hades_Field_01" },
					SpawnOverrides =
					{
						AllowSpecialInteractInPartnerConversation = true,
					},
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs =
						{
							IsNone =
							{
								"HadesAboutBouldy01_B",
								"HadesAboutMelinoe01",
								"HadesAboutPersephoneAway01",
							},
						},
					},
					OrRequirements =
					{
						{
							-- Always spawn before final gift
							{
								PathFalse = { "GameState", "TextLinesRecord", "HadesWithPersephoneGift06" },
							},
						},
						{
							-- Always spawn if didn't spawn last run
							{
								PathFalse = { "PrevRun", "SpawnRecord", "NPC_Persephone_01" },
							},
						},
						{
							-- Otherwise 80% chance to spawn
							ChanceToPlay = 0.8,
						},
						
					},
				},
				Args =
				{
					LegalTypes = { "NPC_Persephone_01" },
					-- Persephone is never separately usable
					AddInteractBlock = "PartnerConversationOnly",
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
				FunctionName = "SetupCerberusStory",
				Args =
				{
					ActivateUnitsByType = { "NPC_Cerberus_Field_01", },
					ActivateIdsByGroup = { "Cerberus" },
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "HadesAboutSisyphus01", "HadesAboutSisyphus01_B" },
					},
				},
			},
			{
				-- Cerberus sometimes spawns after HadesAboutSisyphus01
				FunctionName = "SetupCerberusStory",
				Args =
				{
					ActivateUnitsByType = { "NPC_Cerberus_Field_01", },
					ActivateIdsByGroup = { "Cerberus" },
				},
				GameStateRequirements =
				{
					ChanceToPlay = 0.8,
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HadesAboutSisyphus01", "HadesAboutSisyphus01_B" },
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

	-- @ ending
	Empty_Chaos =
	{
		InheritFrom = { "Empty" },
		StartRoomUnthreadedEvents =
		{
			-- Nyx in Chaos appearances
			{
				FunctionName = "ActivatePrePlaced",
				GameStateRequirements =
				{
					-- Force = true,
					NamedRequirements = { "NyxUnlockedInChaos", },
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Nyx_Story_01" },
						Comparison = "<=",
						Value = 0,
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive", "ReachedEpilogueRecently" },
					ChanceToPlay = 0.75,
				},
				Args =
				{
					LegalTypes = { "NPC_Nyx_Story_01" },
				},
			},
			{
				FunctionName = "CheckConversations",
				Args = {},
			},
		},
	},

	-- @ ending
	Story_Palace_01 =
	{
		InheritFrom = { "Empty" },
		UnthreadedEvents = EncounterSets.EncounterEventsNonCombat,
		MaxAppearancesThisBiome = 1,
		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					LegalTypes =
					{
						"NPC_Zeus_Story_01",
						"NPC_Hera_Story_01",
						"NPC_Apollo_Story_01",
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
					IgnorePartnerExists = true,
					Conversations =
					{
						"ZeusPalaceFirstMeeting",
						"ZeusPalaceMeeting02",
						"DemeterPalaceFirstMeeting",
						"ZeusPalaceMeeting03_B",
						"ZeusPalaceMeeting03_A",
						"ZeusPalaceMeeting03",
						"ZeusPalaceMeeting04",
						"ZeusPalaceMeeting04_B",
						"ZeusPalaceAboutTyphonDeath01",
						"DemeterPalacePostTrueEnding01",
						"DemeterPalacePostTrueEnding01_B",
						"DemeterPalaceAboutTyphonDeath01",
						"ZeusPalacePostTrueEnding01",
					},
				},
			},
			{
				FunctionName = "SetupApolloMusic",
				Args =
				{
					ApolloId = 723553,
					Params =
					{
						LowPass = 0.0,
						Vocals = 1.0,
					},
				},
			},
			--[[
			{
				FunctionName = "ActivatePrePlacedObstacles",
				GameStateRequirements =
				{
					RequiredTextLines = { "PersephoneMeeting09" },
				},
				Args =
				{
					Groups = { "TravelBags" },
				},
			},
			]]--
		},
	},

	Story_DeathAreaRestored =
	{
		InheritFrom = { "Empty" },

		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Zagreus", "Hades", "Persephone", "Selene", "Nyx", "Achilles", },
					LoadPackages = { "Zagreus", "Hades", "Persephone", "Selene", "Nyx", "Cerberus", "Achilles", },
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					Types = { "NPC_Chronos_Story_01" },
					OverwriteSelf =
					{
						Animation = "Enemy_Chronos_Idle",
					},
				},
			},
			{
				FunctionName = "ActivatePrePlaced",
				Args =
				{
					Types = { "NPC_Hecate_Story_01" },
				},
			},
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "SurpriseNPCPresentation",
				Args =
				{
					SourceId = 774366,
					SkipAngleTowardTarget = true,
					SkipCameraLock = true,
					PanIds = { 560366, 772454 },
					TextLineSet =
					{
						-- see also TrueEnding02, TrueEndingFinale01
						TrueEnding01 =
						{
							PlayOnce = true,
							SkipContextArt = true,
							UseableOffSource = true,
							InitialGiftableOffSource = true,
							GiftableOffSource = true,
							PreBlockSpecialInteract = true,
							PostBlockSpecialInteract = true,
							SkipAngleTowardTarget = true,

							{ Cue = "/VO/HecateField_0323",
								Source = "NPC_Hecate_01",
								-- Emote = "PortraitEmoteFiredUp",
								Text = "Prepare to suffer for all that you've done, wretch! Or shall I stay my hand merely because you made the mistake of loosening your hold on me?" },

							{ Cue = "/VO/Chronos_1520",
								PreLineWait = 0.35,
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								Text = "...All of these... newfound thoughts... within my mind...! Was all of this {#Emph}your {#Prev}doing, witch? I... have no memory of you, and yet.... Who {#Emph}are {#Prev}you...?" },

							{ Cue = "/VO/MelinoeField_5144",
								UsePlayerSource = true,
								Portrait = "Portrait_Mel_Intense_01",
								PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

								SecretMusicMutedStems = { "Bass" },

								Text = "Chronos...! Headmistress, {#Emph}wait! {#Prev}I can... I think I can explain." },

							{ Cue = "/VO/HecateField_0324",
								Source = "NPC_Hecate_01",
								Emote = "PortraitEmoteSurprise",
								Text = "Melinoë! Where are we? One instant I discovered that our enemy invaded Erebus, then next I know he's groveling about my feet! How is this possible? What have you done...?" },

							{ Cue = "/VO/MelinoeField_5188",
								UsePlayerSource = true,
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Portrait = "Portrait_Mel_Vulnerable_01",

								PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 5.85 },

								Text = "Headmistress, you... you don't remember... because you weren't there with me. But as for you, Chronos! Who am I now to you...?" },

							{ Cue = "/VO/Chronos_1465",
								PreLineWait = 0.5,
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								Text = "You are... my granddaughter... Melinoë... whom I know both from this life, and an altogether different one... which I now realize... was but a dream. A {#Emph}delusion! {#Prev}So then... all I have left... is {#Emph}this?" },

							{ Cue = "/VO/MelinoeField_5189",
								UsePlayerSource = true,
								PreLineAnim = "Melinoe_Defiant", PreLineAnimTarget = "Hero",
								Portrait = "Portrait_Mel_Intense_01",

								SecretMusicActiveStems = { "Bass" },

								Text = "All that you see is what you wrought! As for this other life... how much of it do you recall?" },

							{ Cue = "/VO/Chronos_1466",
								PreLineWait = 0.5,
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",

								SecretMusicMutedStems = { "Guitar" },

								Text = "...Your youth, here in this House, with me. How you delighted in a hiding-game, when you were but a girl! How you and Zagreus would fight, but out of love... not in the way we fought this very night. I did not realize there could have been this {#Emph}other {#Prev}past we shared... this {#Emph}better {#Prev}past." },

							{ Cue = "/VO/HecateField_0427",
								Source = "NPC_Hecate_01",
								-- Emote = "PortraitEmoteFiredUp",

								SecretMusicActiveStems = { "Guitar", "Drums" },

								Text = "A better past...? {#Emph}Nonsense! {#Prev}None of it occurred! Nothing has {#Emph}changed! {#Prev}You should be {#Emph}gone{#Prev}, Titan...! Not flooded with false memories!" },

							{ Cue = "/VO/MelinoeField_5147",
								UsePlayerSource = true,
								Portrait = "Portrait_Mel_Vulnerable_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

								SecretMusicMutedStems = { "Drums" },

								Text = "...All these memories that sprang to his mind... I remember them as well. A life I could have lived... had the Titan never struck." },

							{ Cue = "/VO/Chronos_1467",
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								-- Emote = "PortraitEmoteFiredUp",
								PreLineAnim = "Enemy_Chronos_Knockdown_Frustrated", PreLineAnimTarget = 774365,

								SecretMusicActiveStems = { "Drums", },
								-- SecretMusicMutedStems = { "Drums" },

								Text = "But I {#Emph}struck! {#Prev}Ever-hated and shunned! Finish what you set your mind to, Granddaughter! For I have no desire to exist in such a world, with all of you, like {#Emph}this! {#Prev}Not for one moment longer...!" },

							{ Cue = "/VO/HecateField_0428",
								Source = "NPC_Hecate_01",
								Emote = "PortraitEmoteAnger",
								-- PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

								-- SecretMusicActiveStems = { "Drums", },
								SecretMusicMutedStems = { "Guitar" },

								Text = "{#Emph}Silence! {#Prev}Melinoë, come to your senses. Whatever you did, this wretch is finished, and shan't be using his old tricks again! {#Emph}End him!" },

							{ Cue = "/VO/MelinoeField_5148",
								UsePlayerSource = true,
								Portrait = "Portrait_Mel_Intense_01",
								PreLineAnim = "Melinoe_Defiant", PreLineAnimTarget = "Hero",

								SecretMusicMutedStems = { "Drums" },

								Text = "Wait, please, let me prove this to you...! Chronos! Grandfather. Listen to me: Steady yourself. Use what power you yet have, and release our family from your hold!" },

							{ Cue = "/VO/Chronos_1468",
								PreLineWait = 0.35,
								Emote = "PortraitEmoteSurprise",
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								PortraitExitAnimation = "Portrait_Chronos_Confused_01_Exit",
								PostLineFunctionName = "SummonFamilyMembers",
								PostLineRemoveContextArt = true,

								SecretMusicActiveStems = { "Guitar", },
								SecretMusicMutedStems = { "Bass" },

								Text = "{#Emph}<Gasp> {#Prev}Our family...? They... why, they are bound as yet! I had them bound... for all this time. What have I done...?" },

							{ Cue = "/VO/Hades_0403",
								Emote = "PortraitEmoteFiredUp",
								Portrait = "Portrait_Hades_Chained_02",
								Source = "NPC_Hades_Story_01",
								PreLineWait = 0.2,
								Text = "My family...! Where are we...? Is this... my {#Emph}House? {#Prev}Father...! What is the meaning of all this?!" },

							{ Cue = "/VO/Chronos_1469",
								Source = "NPC_Chronos_01",
								Portrait = "Portrait_Chronos_Confused_01",
								PostLineFunctionName = "SetupFamilyRescueCamera",
								Text = "{#Emph}Oh{#Prev}, Hades... perhaps the Princess can explain. As for the Queen, and Prince, and all the rest... Melinoë, they need but hear your voice. And I await their judgment, and your own." },
						},
						-- the story continues in FamilyRescuePresentation & TrueEnding02
					},
				},
			},
		},
	},

	Story_EndCredits =
	{
		InheritFrom = { "Empty" },

		StartRoomUnthreadedEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					LoadVoiceBanks = { "Chronos", "Artemis", "Apollo", "Selene" },
					LoadPackages = { "Chronos", "Artemis", "Apollo", "Selene" },
				},
			},
			{
				FunctionName = "SetupEndingCredits",
			},
		},

		UnthreadedEvents =
		{
			{
				FunctionName = "SurpriseNPCPresentation",
				Args =
				{
					IntroWait = 1.5,
					SourceId = 780625,
					SkipPan = true,
					SkipAngleTowardTarget = true,
					SkipCameraLock = true,
					TextLineSet =
					{
						TrueEndingFinale01 =
						{
							PlayOnce = true,
							UseableOffSource = true,
							SkipContextArt = true,

							{ Cue = "/VO/Selene_0379",
								PreLineWait = 0.25,
								Source = "NPC_Selene_01",
								Portrait = "Portrait_Selene_InPerson_01",
									Text = "...If I may briefly interrupt, we have arrived at our initial destination, everyone. Olympus is not far from here." },

							{ Cue = "/VO/Chronos_1028",
								PreLineWait = 0.35,
								Source = "NPC_Chronos_02",
								Speaker = "NPC_Chronos_01",
								Text = "...I do appreciate the ride upon your gleaming chariot, O Moon; but it is time for me to go. Perhaps my conversations with Hades have prepared me to face my other sons..." },

							{ Cue = "/VO/MelinoeField_5172", UsePlayerSource = true,
								Text = "We've informed Lord Uncle Zeus of what happened, and given our recommendations, though he'll have many questions for you. And ought to be expecting you by now. Remember the chance you've been given, Grandfather." },

							{ Cue = "/VO/Chronos_1479_B",
								Source = "NPC_Chronos_02",
								Speaker = "NPC_Chronos_01",

								Text = "Time cannot forget, and ought never to be late. May Zeus at least permit me to assist you from here on, knowing there were real possibilities this all could have gone worse." },

							{ Cue = "/VO/MelinoeField_5218_B", UsePlayerSource = true,
								Text = "To think that the entire flow of Time has fractured because of what occurred..." },

							{ Cue = "/VO/Chronos_1528",
								Source = "NPC_Chronos_02",
								Speaker = "NPC_Chronos_01",
								PortraitExitAnimation = "Portrait_Chronos_Default_02_Exit",
								PostLineFunctionName = "TwinsEntrancePresentation",

								Text = "I would liken it more to a moment of self-discovery on my part! Despite my advanced age, it seems I did not know all that there is to know about myself. But then again... who does? Now, farewell. And thank you, Granddaughter." },

							-- Twins Enter
							{ Cue = "/VO/MelinoeField_3907", UsePlayerSource = true,
								PreLineWait = 0.5,
								Portrait = "Portrait_Mel_Pleased_01",
								Text = "Lord Apollo! And Lady Artemis!" },

							{ Cue = "/VO/Apollo_0204",
								Source = "NPC_Apollo_Story_01",
								Portrait = "Portrait_Apollo_InPerson_01",
								Text = "It's a beautiful night, Lady Selene! And {#Emph}you {#Prev}must be the esteemed Witch of the Crossroads! You've trained my cousin very well indeed, to have brought Chronos to our heights, still in one piece!" },

							{ Cue = "/VO/Artemis_0382",
								Source = "NPC_Artemis_01",
								Text = "Fine, Apollo, I was incorrect for once, no need to boast. Melinoë, I may have wagered that you'd cut the Titan to ribbons sooner than you'd bring him here." },

							{ Cue = "/VO/MelinoeField_3908", UsePlayerSource = true,
								Portrait = "Portrait_Mel_Proud_01",
								PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSurprise", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 6.5 },
								Text = "I know it's unimaginable, but he came here willingly. And Lord Zeus wanted to speak to him in private. Wait, does that mean... you were kicked out of your {#Emph}house?" },

							{ Cue = "/VO/Apollo_0205",
								PostLineFunctionName = "CreditsSecretMusicOff",
								Source = "NPC_Apollo_Story_01",
								Portrait = "Portrait_Apollo_InPerson_01",
								Text = "Well we consider it a Palace, but, {#Emph}erm... {#Prev}no! No, we've been appointed to escort you to the Crossroads as a symbol of our family's unity, and come bearing a gift. Shall we be off?" },

							EndVoiceLines =
							{
								{
									PreLineWait = 1.1,
									PlayOverTextLines = true,
									AllowTalkOverTextLines = true,
									Source = { LineHistoryName = "NPC_Selene_01", SubtitleColor = Color.SeleneVoice },

									{ Cue = "/VO/Selene_0381", Text = "We ride." },
								},
								{
									PreLineWait = 0.4,
									PlayOverTextLines = true,
									AllowTalkOverTextLines = true,
									Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },

									{ Cue = "/VO/Artemis_0384", Text = "Here we go." },
								},
							},
						},
					},
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "SessionMapState", "SkipCreditsPreamble" },
					},
				},
			},
			{
				FunctionName = "EndingCreditsPresentation",
				Args =
				{
					CameraPanId = 780638,
					CameraZoom = 0.75,
					ChariotId = 780625,
				},
			},
		},
		Using =
		{
			GrannyModels = { "Artemis_Mesh", "Apollo_Mesh" },
			Animations =
			{
				"Tilesets/Olympus/Olympus_Credits_Constellation_01",
				"Tilesets/Olympus/Olympus_Credits_Constellation_02",
				"Tilesets/Olympus/Olympus_Credits_Constellation_03",
				"Tilesets/Olympus/Olympus_Credits_Constellation_04",
				"Tilesets/Olympus/Olympus_Credits_Constellation_05",
				"Tilesets/Olympus/Olympus_Credits_Constellation_06",
				"Tilesets/Olympus/Olympus_Credits_Constellation_07",
				"Tilesets/Olympus/Olympus_Credits_Constellation_08",
				"Tilesets/Olympus/Olympus_Credits_Constellation_09",
				"Tilesets/Olympus/Olympus_Credits_Constellation_10",
			},
		},
	},

})