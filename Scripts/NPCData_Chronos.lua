UnitSetData.NPC_Chronos =
{
	-- Chronos, Id = 561902
	NPC_Chronos_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Chronos_Default_01",
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleScale = 1.65,
		Groups = { "NPCs" },
		SpeakerName = "Chronos",
		LoadPackages = { "Chronos", },
		SubtitleColor = Color.ChronosVoice,
		EmoteOffsetY = -320,
		EmoteOffsetX = 85,

		ActivateRequirements =
		{
			--
		},

		PostActivateEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args =
				{
					ThingProperties =
					{
						GrannyTexture = "Models/Chronos/ChronosShadow_Color",
					},
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_PostBoss01" },
					},
				},
			},
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					LineHistoryName = "NPC_Unnamed_01",
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone =
						{
							"ChronosAnomalyIntro01",
							"ChronosReveal01B",
							"ChronosRevealFollowUp",
							"ChronosBossFirstMeeting_B",
							"ChronosBossFirstMeeting_C",
						 },
					},
				},
			},
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					SkipInvulnerableOnHitPresentation = true,
					OnHitFunctionName = "DoChronosOnHitConversation",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosRevealFollowUp" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
			},
		},

		DeathPresentationTextLineSets =
		{
			-- alt below
			ChronosAnomalyIntro01 =
			{
				PlayOnce = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosAnomalyIntro01_B" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				-- SkipContextArt = true,

				{ Cue = "/VO/Chronos_0147", Speaker = "NPC_Unnamed_01", 
					Portrait = "Portrait_Chronos_Pained_01",
					SpeakerLabelOffsetY = 18,
					PreLineAnim = "Melinoe_Drop_Exit_FireLoop", PreLineAnimTarget = "Hero",
					Text = "I know who you are. I know where you go. You shall not get there." },
				{ Cue = "/VO/MelinoeField_0246", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "This magick... Chronos! I'll carve you limb from limb for this. For everything!" },
				{ Cue = "/VO/Chronos_0152",
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "How frightening. Unfortunately, we shall never know if yours was a mere-empty threat, for you are going on a little {#Emph}time out{#Prev}. At least until some other matters are resolved..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1682", Text = "No!" },
					},
				},
			},

			ChronosAnomalyIntro01_B =
			{
				PlayOnce = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosAnomalyIntro01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				-- SkipContextArt = true,

				{ Cue = "/VO/Chronos_0209",
					PreLineAnim = "Melinoe_Drop_Exit_FireLoop", PreLineAnimTarget = "Hero",
					Text = "I am afraid I must ask you to cease this at once..." },
				{ Cue = "/VO/MelinoeField_0246", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "This magick... Chronos! I'll carve you limb from limb for this. For everything!" },
				{ Cue = "/VO/Chronos_0152",
					Text = "How frightening. Unfortunately, we shall never know if yours was a mere-empty threat, for you are going on a little {#Emph}time out{#Prev}. At least until some other matters are resolved..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1682", Text = "No!" },
					},
				},
			},

		},

		InteractTextLineSets =
		{
			ChronosFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "F_PostBoss01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_0142", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Pray, who might you be, my girl? And what compelled you to wander in and out of Erebus?" },
				{ Cue = "/VO/Melinoe_0093", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not your {#Emph}girl{#Prev}, old man. My name and business are not your concern." },
				{ Cue = "/VO/Chronos_0143", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "So it seems. You appear to be quite pressed for time. Forgive this {#Emph}old man {#Prev}his transgressions..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.65,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1947", Text = "{#Emph}<Scoff>" },
					},
				},
			},

			ChronosMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "F_PostBoss01", },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },
				{ Cue = "/VO/Chronos_0144", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "You have returned. Or lost your way, perhaps, in those interminable passageways beyond." },
				{ Cue = "/VO/MelinoeField_0244", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know where I'm going. Whom do I address? And what are you doing here yourself, in such a place?" },
				{ Cue = "/VO/Chronos_0145", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "{#Emph}My name and business are not your concern{#Prev}, is that not what you said? {#Emph}Ahh{#Prev}, the impertinence of the youth of this age..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.35,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_0245", Text = "Wait..." },
					},
				},
			},

			ChronosReveal01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomCountCache", "F_PostBoss01", },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosReveal01B" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },
				-- see ChronosRevealFollowUp below
				SkipClearRoomRequiredObject = true,
				{ Cue = "/VO/Chronos_0146",
					StartSound = "/Leftovers/Menu Sounds/TextReveal5FilterSweep",
					PreLineThreadedFunctionName = "StartChronosFakeBossMusic",
					PreLineAnim = "MelinoeActionIdle", PreLineAnimTarget = "Hero",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "You seem to know your way around. I am master of this realm, yet even {#Emph}I {#Prev}would never venture into yonder woods. You even found your way back from your {#Emph}detour {#Prev}in Asphodel..." },
				{ Cue = "/VO/Melinoe_0035", UsePlayerSource = true,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_Mel_Intense_01",
					PostLineThreadedFunctionName = "StartChronosFakeBossPresentation",
					Text = "Damn you, Chronos...!" },
				EndVoiceLines =
				{
					RecheckRequirementsForSubLines = true,
					RecheckRequirementsPostWait = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosRevealFollowUp" },
						},
					},

					{ Cue = "/VO/Chronos_0020", Text = "The Fates cannot help you now...",
						PreLineWait = 0.35,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting" },

					{ Cue = "/VO/Chronos_0301", Text = "Time is running out...",
						PreLineWait = 4,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting" },

					{ Cue = "/VO/Chronos_0333", Text = "Embarrassing.",
						PreLineWait = 4,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting" },

					{ Cue = "/VO/Chronos_0591", Text = "Then let us wait...",
						PreLineWait = 5,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting" },
				},
			},

			ChronosMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosAnomalyIntro01", "ChronosBossFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
					},				
					{
						Path = { "GameState", "RoomCountCache", "F_PostBoss01", },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "PrevRun", "TextLinesRecord" },
						HasNone = { "ChronosBossFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },
				{ Cue = "/VO/Chronos_0031",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "You, my girl, are meddling in matters you do not understand. Your father made certain choices; he was bound by them, but you are not. You need not follow in his ruinous path." },
				{ Cue = "/VO/Melinoe_0163", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "{#Emph}Ruinous?! You {#Prev}brought ruin to the Underworld and the surface! I'll never accept what you've done. Now, enough talk!" },
				{ Cue = "/VO/Chronos_0032",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 2.0 },
					Text = "How {#Emph}very {#Prev}spirited! You truly think you can stop Time. Well, then... I would like to see you try." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeRemainsSilent" },
						{ Cue = "/VO/Melinoe_0164", Text = "Then watch this!" },
					},
					{
						PreLineWait = 0.5,
						{ Cue = "/VO/Intercom_0023", Text = "{#Emph}<Laughter>" },
					},
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0322", Text = "{#Emph}Grr!" },
					},
				},
			},
			ChronosMeeting04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosMeeting03" },
					},
					{
						Path = { "GameState", "RoomCountCache", "F_PostBoss01", },
						Comparison = ">=",
						Value = 7,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChronosMeeting03" }, Min = 2 },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_0034",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Which rock did you crawl out from under, {#Emph}hm? {#Prev}My forces, they are terribly confused! They have no idea where you live! So I thought I would {#Emph}attempt {#Prev}asking you nicely here." },
				{ Cue = "/VO/Melinoe_0166", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I live in your nightmares, Titan. I thrive on them! I'll see you dead, and then destroyed. However long it takes." },
				{ Cue = "/VO/Chronos_0035",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "{#Emph}However long it takes? {#Prev}You speak of inevitability, little one. A subject on which I happen to be the expert. As to whomever sent you after me... I shall find them." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0167", Text = "We'll see!" },
					},
				},
			},
			ChronosMeeting05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosMeeting04" },
					},
					{
						Path = { "GameState", "RoomCountCache", "F_PostBoss01", },
						Comparison = ">=",
						Value = 9,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChronosMeeting04" }, Min = 2 },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0077",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "You yet persist, despite my generous attempts to dissuade you. Then, very well! You carry on as the distraction which you are, whilst I turn my attention to matters of greater import..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
					},
				},
			},

			ChronosPostSurfaceMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosAnomalyIntro01", "ChronosBossFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
					},
					{
						Path = { "GameState", "RoomCountCache", "F_PostBoss01", },
						Comparison = ">=",
						Value = 11,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Opening01" },
					},
					{
						PathFalse = { "PrevRun", "RoomsEntered", "P_Intro" }
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0157",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "I was beginning to think I had successfully dissuaded you, when it came to my attention you were trespassing some other place instead. You dared venture above?" },
				{ Cue = "/VO/MelinoeField_0494", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I've seen your work up there firsthand. To have unsealed the very gates of hell! And brought disaster to mortals who've nothing to do with your petty vendetta." },
				{ Cue = "/VO/Chronos_0158",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "You speak of the bedraggled city of Ephyra, which once stood in sycophantic tribute to your upstart father. Perhaps what mortals yet remain there shall think twice next time before they put their faith in {#Emph}gods." },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.0,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_0495", Text = "Coward..." },
					},
				},
			},
			ChronosPostSurfaceMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosPostSurfaceMeeting01" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Opening01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChronosPostSurfaceMeeting01", "ChronosPostSurfaceMeeting03" }, Min = 2 },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0159",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "You cannot help the gods above, you know. My legions are vast, and death means little to them anymore. Not that your efforts here shall be of much consequence, either." },
				{ Cue = "/VO/MelinoeField_0496", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Your surface legions fight and die for you, yet you hide behind them here. If you're so certain of your victory, you'd be leading them." },
				{ Cue = "/VO/Chronos_0160",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "Leadership, my girl, is not about having to do everything oneself. It is about ensuring others share your same ideals and methodology. Wherever you may go, you shall encounter many who embrace my point of view, I think." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_0497", Text = "No shortage of fools..." },
					},
				},
			},
			-- intentionally plays before 2
			ChronosPostSurfaceMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosPostSurfaceMeeting02" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Opening01" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
					{
						Path = { "GameState", "ClearedSurfaceRunsCache" },
						Comparison = "<",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChronosPostSurfaceMeeting01", "ChronosPostSurfaceMeeting02" }, Min = 2 },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0161",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "No victories upon the surface as of yet? It appears you have {#Emph}two {#Prev}hopeless goals, rather than one." },
				{ Cue = "/VO/MelinoeField_0498", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I've only one, and hope has nothing to do with it. I may not be able to stop you yet, but neither can you stop me. You've tried." },
				{ Cue = "/VO/Chronos_0162",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "You {#Emph}have {#Prev}been more resistant than {#Emph}some {#Prev}members of your family, I admit. Well then, see where your scattered ventures to the surface, or these depths, shall ultimately lead!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_0499", Text = "We'll both see." },
					},
				},
			},

			ChronosPostSurfaceMeeting04 =
			{
				PlayOnce = true, 
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosPostSurfaceMeeting03" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						SumPrevRuns = 4,
						Path = { "BiomesReached", "N" },
						IgnoreCurrentRun = true,
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "N_Boss01", "N_Boss02" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChronosPostSurfaceMeeting02", "ChronosPostSurfaceMeeting03" }, Min = 2 },
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0611",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "At last you have returned to more-familiar environs, girl. Neither the gods nor the Fates want you upon the surface of this world! Yet you insist on fighting there, for them." },
				{ Cue = "/VO/MelinoeField_2022", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "I suppose I'll be more welcome in my father's home later this eve? As you can see I'm willing to fight there as well." },
				{ Cue = "/VO/Chronos_0612",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "{#Emph}Ah{#Prev}, but you have such a long way to go! Confined to making the journey by foot, like a pathetic mortal. Do be sure to conserve some of your strength for the {#Emph}final stretch." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.9,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_2023", Text = "{#Emph}Ungh..." },
					},
				},
			},

			ChronosPostBattleMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = "<",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0210",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "I thought that I might find you here, my girl. Such fire in your eyes! How obstinate the members of our family can be. Have you learned nothing from our previous exchange?" },
				{ Cue = "/VO/MelinoeField_1400", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "Oh, I learned plenty, and I'm eager to learn more. So why don't you get out of my way, since there's nothing you can do within these woods but try to slow me down?" },
				{ Cue = "/VO/Chronos_0211",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "Past the point of reason, and so very self-assured. Then, very well! Come find me if you must, and learn some more. You know where I reside. I do not hide from {#Emph}gods!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1401", Text = "See you soon..." },
					},
				},
			},

			ChronosPostBattleMeeting02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "N_Opening01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0004",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "Little one, do not presume to think your movements are invisible to me! I see you plainly where you stand. A trespass for which you shall suffer, although, regrettably, not by my hand right now. Not yet." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosPostBattleMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Boss01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0005",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "I am Time itself. What are you? A thrall of those calling themselves gods, mindlessly serving at their whim. My children are crafty... to them, you are nothing but a common tool! And not an especially sharp one, it appears to me." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosPostBattleMeeting04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs =
						{
							TextLines = 
							{
								"ChronosPostBattleMeeting02",
								"ChronosPostBattleMeeting03",
								-- "ChronosPostBattleMeeting04",
							},
							Min = 3
						},
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0006",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "If there is one thing on which the accursed Fates and I agree, it is that all eventually shall decay. All sprang from nothingness, and back into that Chaos we shall all return. You merely hurry it along." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			ChronosPostWinStreakMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0613",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Why, here comes our shadowy assassin on her nightly escapade to try and do me harm! Although perhaps the outcome shall not be so fortunate, this time." },
				{ Cue = "/VO/MelinoeField_2024", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "We'll soon find out, won't we? I promise not to keep you waiting long. I'm well on my way already, as you can see." },
				{ Cue = "/VO/Chronos_0614",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "Oh, that I {#Emph}can. {#Prev}Then, I had best return and make ready! We have to tidy up for your arrival, after all. Until later tonight." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.6,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_2025", Text = "...Until then." },
					},
				},
			},

			ChronosMeetingAboutZeus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs =
						{
							TextLines = 
							{
								"ChronosMeeting05",
								-- "ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
							Min = 4
						},
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0615",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "My dear son Zeus is already abetting you this night? I fear not his famous thunderbolt, young fool that he is." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutPoseidon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs =
						{
							TextLines = 
							{
								"ChronosMeeting05",
								"ChronosMeetingAboutZeus01",
								-- "ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
							Min = 4
						},
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0616",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "{#Emph}Ah{#Prev}, so Poseidon gave you his blessing, has he now? What are you going to do... pour water on me?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutHestia01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HestiaUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs =
						{
							TextLines = 
							{
								"ChronosMeeting05",
								"ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								-- "ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
							Min = 4
						},
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0619",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "The goddess of the hearth has blessed you now? There is no flame which {#Emph}Time {#Prev}cannot extinguish soon enough." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutDemeter01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs =
						{
							TextLines = 
							{
								"ChronosMeeting05",
								"ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								-- "ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
							Min = 4
						},
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0617",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "The frosty goddess Demeter is urging you along this eve? Alas, there are no {#Emph}seasons {#Prev}in the Underworld." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutHera01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs =
						{
							TextLines = 
							{
								"ChronosMeeting05",
								"ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								-- "ChronosMeetingAboutHera01",
							},
							Min = 4
						},
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0618",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "The self-made Queen of the Gods, bestowing you her Boon? Is there not some mortal wedding she ought to officiate?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutOlympians01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
					{
						Path = { "PrevRun" },
						HasNone = { "Cleared", "ActiveBounty" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll =
						{
							"ChronosMeetingAboutZeus01",
							"ChronosMeetingAboutPoseidon01",
							"ChronosMeetingAboutHestia01",
							"ChronosMeetingAboutDemeter01",
							"ChronosMeetingAboutHera01",
						},
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs =
						{
							TextLines = 
							{
								"ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
							Min = 4
						},
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0620",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "Try all you like, my girl; but the outcome of this night shall be no different from the last." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			ChronosMeetingAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "ActiveBounty" },
					},
					{
						PathFalse = { "PrevRun", "RoomsEntered", "Q_Intro" },
					},
					-- ignoring CurrentRun, not spawned PrevRun or the run before
					{
						SumPrevRuns = 3,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Chronos_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0911",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "Has crafty Prometheus proven too much for you, that you believe you shall fare better against {#Emph}me?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
					},
					{
						SumPrevRuns = 4,
						Path = { "BiomesReached", "F" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 4,
					},
					-- ignoring CurrentRun, not spawned PrevRun, the run before that, or the run before that
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Chronos_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0912",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "As you yet flail against me here, the shrewd Prometheus has many of your relatives entirely preoccupied..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Intro" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" },
					},
					{
						Path = { "PrevRun" },
						HasNone = { "Cleared", "ActiveBounty" },
					},
					{
						SumPrevRuns = 3,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Chronos_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0908",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "So you have seen what shall become of Mount Olympus, and abandoned that foolhardy path... soon, this one, too." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutTyphonW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Chronos_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0909",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "I know not how you bested the Father of All Monsters, but all it did was make him angrier." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutTyphon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						SumPrevRuns = 4,
						Path = { "BiomesReached", "F" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0910",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "I would be more concerned with that which now transpires on Olympus, were I you. I hear Typhon is rather upset..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutShrine01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 12,
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "SpawnRecord", "NPC_Chronos_01" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "ChronosNPCSetup",

				{ Cue = "/VO/Chronos_0913",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.35 },
					Text = "There is a thickness to the air tonight... such darkness is presumably {#Emph}your {#Prev}doing, but shall do you little good." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

		},

		-- see PostActivateEvents for OnHitFunctionName setup
		OnHitTextLinePriorities =
		{
			"ChronosReveal01B",
			"ChronosRevealFollowUp",
		},
		UseBossHealthBar = true,
		NeverLeavesShadeMerc = true,
		EarlyExit = true, -- used to prevent health bar from appearing too early
		MaxHealth = 99999,
		HealthBarTextId = "Chronos_Full",
		OnHitTextLineSets =
		{
			ChronosReveal01B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ChronosReveal01" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,
				SkipClearRoomRequiredObject = true,
				{ Cue = "/VO/Chronos_0156",
					InputDelay = 1.8,
					StartSound = "/Leftovers/Menu Sounds/TextReveal5FilterSweep",
					PreLineThreadedFunctionName = "StartChronosFakeBossMusic",
					PreLineAnim = "MelinoeActionIdle", PreLineAnimTarget = "Hero",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Such rage! Lashing out like a petulant child. You wish to fight with me, then so be it...!" },
				{ Cue = "/VO/Melinoe_0035", UsePlayerSource = true,
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal3",
					Portrait = "Portrait_Mel_Intense_01",
					PostLineThreadedFunctionName = "StartChronosFakeBossPresentation",
					Text = "Damn you, Chronos...!" },
				EndVoiceLines =
				{
					RecheckRequirementsForSubLines = true,
					RecheckRequirementsPostWait = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "TextLinesRecord", "ChronosRevealFollowUp" },
						},
					},

					{ Cue = "/VO/Chronos_0020", Text = "The Fates cannot help you now...",
						PreLineWait = 0.35,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting" },

					{ Cue = "/VO/Chronos_0301", Text = "Time is running out...",
						PreLineWait = 4,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting" },

					{ Cue = "/VO/Chronos_0333", Text = "Embarrassing.",
						PreLineWait = 4,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting" },

					{ Cue = "/VO/Chronos_0591", Text = "Then let us wait...",
						PreLineWait = 5,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting" },
				},
			},

			ChronosRevealFollowUp =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				AngleHeroTowardTargetId = 561902,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasAny = { "ChronosReveal01", "ChronosReveal01B" },
					}
				},

				{ Cue = "/VO/Chronos_0075",
					PreLineWait = 0.4,
					InputDelay = 1.8,
					Portrait = "Portrait_Chronos_Pained_01",
					Text = "{#Emph}Oh{#Prev}, stop. It is a pity that this granddaughter of mine is both a weakling and a fool, though an elusive one. I ought to thank the Fates that we have met at last." },
				{ Cue = "/VO/Melinoe_0095", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "The Fates had nothing to do with this. You took my family." },
				{ Cue = "/VO/Chronos_0076",
					PreLineThreadedFunctionName = "StopSecretMusic",
					PreLineThreadedFunctionArgs = { true },
					Portrait = "Portrait_Chronos_Pained_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { WaitTime = 0.3, CheckCodex = true },
					Text = "{#Emph}Our {#Prev}family! Make not their same mistakes, and in time, we surely shall grow past this halted start to our relationship. I shall see you later." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0096", Text = "Wait! You..." },
					},
				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 250,
		OnHitVoiceLines =
		{
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
				{
					Path = { "CurrentRun", "TextLinesRecord" },
					HasNone = { "ChronosMeeting03" },
				},
			},
			{
				Queue = "Interrupt",
				PlayOnceFromTableThisRun = true,
				UsePlayerSource = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChronosReveal01", "ChronosReveal01B" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				{ Cue = "/VO/Melinoe_0304", Text = "Suffer!" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Chronos_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosAnomalyIntro01", "ChronosBossFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChronosReveal01", "ChronosReveal01B", "ChronosPostBattleMeeting01" },
					},
				},
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 10 },
				},

				{ Cue = "/VO/Chronos_0153", Text = "Temper!", PlayFirst = true, },
				{ Cue = "/VO/Chronos_0154", Text = "The {#Emph}nerve!" },
			},
			{
				Queue = "Interrupt",
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Chronos_01",
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs =
						{
							IsAny =
							{
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
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 10 },
				},
				PreLineFunctionName = "GenericPresentation",
				PreLineFunctionArgs =
				{
					UseableOff = true
				},
				PostLineFunctionName = "ChronosExit",
				PostLineFunctionArgs =
				{
					AnimationState = "NPCChronosExited"
				},

				{ Cue = "/VO/Chronos_0014", Text = "I think not." },
				{ Cue = "/VO/Chronos_0094", Text = "Oh, {#Emph}please..." },
				{ Cue = "/VO/Chronos_0095", Text = "That shall not work." },
				{ Cue = "/VO/Chronos_0096", Text = "You waste your time." },
				{ Cue = "/VO/Chronos_0097", Text = "Such youthful arrogance." },
				{ Cue = "/VO/Chronos_0098", Text = "I can wait..." },
				{ Cue = "/VO/Chronos_0099", Text = "Your wrath is all for naught." },
				{ Cue = "/VO/Chronos_0153", Text = "{#Emph}Temper!" },
				{ Cue = "/VO/Chronos_0154", Text = "The {#Emph}nerve!" },
				{ Cue = "/VO/Intercom_0023", Text = "{#Emph}<Laughter>" },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Chronos_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosReveal01", "ChronosReveal01B", "ChronosBossFirstMeeting", "ChronosBossFirstMeeting_B", "ChronosBossFirstMeeting_C" },
					},
				},
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 10 },
				},

				{ Cue = "/VO/Chronos_0528", Text = "Hah!", PlayFirst = true, },
				{ Cue = "/VO/Chronos_0014", Text = "I think not." },
				{ Cue = "/VO/Chronos_0094", Text = "Oh, {#Emph}please..." },
				{ Cue = "/VO/Chronos_0095", Text = "That shall not work." },
				{ Cue = "/VO/Chronos_0096", Text = "You waste your time." },
				{ Cue = "/VO/Chronos_0097", Text = "Such youthful arrogance." },
				{ Cue = "/VO/Chronos_0098", Text = "I can wait..." },
				{ Cue = "/VO/Chronos_0099", Text = "Your wrath is all for naught." },
				{ Cue = "/VO/Chronos_0153", Text = "{#Emph}Temper!",
					GameStateRequirements =
					{
						{
							FunctionName = "RequireRunsSinceTextLines",
							FunctionArgs = { TextLines = { "ChronosRevealFollowUp" }, Min = 5 },
						},
					},
				},
				{ Cue = "/VO/Chronos_0154", Text = "The {#Emph}nerve!",
					GameStateRequirements =
					{
						{
							FunctionName = "RequireRunsSinceTextLines",
							FunctionArgs = { TextLines = { "ChronosRevealFollowUp" }, Min = 5 },
						},
					},
				},
			},
		},

		Using = { "ChronosInvincibubble", "Chronos360BlockFront", },
	},
	NPC_Chronos_Story_01 =
	{
		InheritFrom = { "NPC_Chronos_01" },

		UseTextSpecial = "ChronosUseTextSpecial",
		SpecialInteractFunctionName = "SpecialInteractThreatenChronos",
		SpecialInteractGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "I_DeathAreaRestored" },
			},
			{
				PathFalse = { "GameState", "TextLinesRecord", "TrueEnding02", },
			},
		},
		SpecialInteractCooldown = 999,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.25,
				UsePlayerSource = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_5149", Text = "This had better work." },
				-- { Cue = "/VO/MelinoeField_0269_B", Text = "Stay where you are." },
			},
		},

		InteractTextLineSets =
		{
			ChronosNightmare01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				UseInitialInteractSetup = true,
				InteractDistance = 500,
				StatusAnimation = "StatusIconWantsToTalkImportant_ChronosStory",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NyxNightmare01", },
					},
				},
				{ Cue = "/VO/Chronos_0056",
					Text = "{#Emph}Ahh{#Prev}, there you are, my son. Grown a full beard and a broad frame, I see. And now you have a family of your own! How full of life they are, despite the dour environs." },

				{ Cue = "/VO/Hades_0003",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01", LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice,
					PreLineWait = 0.35,
					Text = "Greetings, Father. I... was not expecting your arrival. You... must forgive us that the House was unprepared for guests. To what do we owe the pleasure of your company?" },

				{ Cue = "/VO/Chronos_0057",
					Text = "Oh, you know, for one thing, I was in the area! You might recall the time you, Zeus, and the rest of you little brats cut me to ribbons? Sprinkled all my bits, all throughout Tartarus?" },

				{ Cue = "/VO/Hades_0004",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01", LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice,
					PreLineWait = 0.5,
					Text = "Father... that was a war {#Emph}you {#Prev}started, and you know it! We took no joy in what we had to do! But how can this be? I thought that you were gone...!" },

				{ Cue = "/VO/Chronos_0058",
					Text = "Do not sound so disappointed! It is {#Emph}I {#Prev}who should be disappointed here, not {#Emph}you. {#Prev}You thought I was gone? I was! But it turns out spite is a powerful motivator. Blood sacrifices also helped." },

				{ Cue = "/VO/Hades_0021",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01", LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice,
					Text = "What do you intend to do? And... what have you done to the others? To my family?!" },

				{ Cue = "/VO/Chronos_0059",
					Text = "Your cries fall on deaf ears. Fear not, my son. I have not {#Emph}eaten {#Prev}them or anything. I have merely... set them aside. They stand imprisoned in a moment that shall never pass. My qualm is not with {#Emph}them." },

				{ Cue = "/VO/Hades_0022",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01", LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice,
					PreLineWait = 0.35,
					Text = "...Olympus shall have your head. You can take {#Emph}mine{#Prev}, for all I care, {#Emph}blast you! {#Prev}But don't you {#Emph}dare {#Prev}harm anybody in my House." },

				{ Cue = "/VO/Chronos_0071",
					Text = "{#Emph}Tsk! {#Prev}You have grown so accustomed to issuing commands that you forget yourself. Though, I do have such a command for {#Emph}you: {#Prev}Tell me, exactly, where the Fates reside." },

				{ Cue = "/VO/Hades_0023",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01", LineHistoryName = "NPC_Hades_01", SubtitleColor = Color.HadesVoice,
					PostLineFunctionName = "ConcludeFlashback",
					Text = "The {#Emph}Fates? {#Prev}How should {#Emph}I {#Prev}know? Not even Nyx herself knows where her daughters are! Why are you... asking {#Emph}me...?" },

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosNightmareGreeting,
			},

		},

	},

	-- @ ending
	NPC_Chronos_02 =
	{
		InheritFrom = { "NPC_Chronos_01" },

		Portrait = "Portrait_Chronos_Default_02",
		LineHistoryName = "Speaker_Chronos_02",
		UseBossHealthBar = false,
		GiftPresentationIconOffsetY = -130,
		CancelExitIfInteractable = true,

		ActivateRequirements =
		{
			{
				-- PathFalse = { "GameState", "TextLinesRecord", "ChronosFirstMeeting" },
			},
		},

		GiftGameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_PostBoss01" }
			},
			{
				PathFromSource = true,
				PathFalse = { "Exiting" },
			},
		},

		PostActivateEvents =
		{
			--
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				Path = { "GameState", "TextLinesRecord" },
				HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutTartarus01_B", "NeoChronosAboutOlympus01", "NeoChronosAboutOlympus01_B" },
			},
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsNone = { "I_PreBoss02", "P_PostBoss01" },
			},
			{
				PathFromSource = true,
				PathFalse = { "Exiting" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PlayOnceThisRun = true,
				PreLineWait = 0.25,
				RandomRemaining = true,
				UsePlayerSource = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_5074", Text = "Hail, Grandfather.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
							HasNone = { "/VO/MelinoeField_4193", "/VO/MelinoeField_4194" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_5075", Text = "Grandfather.",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
							HasNone = { "/VO/MelinoeField_4193", "/VO/MelinoeField_4194" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_5166", Text = "May time flow freely forth.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift02" },
						},
					},
				},
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				-- PreLineAnim = "Hades_Hello",
				ObjectType = "NPC_Chronos_02",

				{ Cue = "/VO/Chronos_1297", Text = "Come now...",
					GameStateRequirements = 
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_5074" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1298", Text = "Salutations...",
					GameStateRequirements = 
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/Melinoe_5075" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1299", Text = "{#Emph}Oh{#Prev}, my...",
					GameStateRequirements = 
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1300", Text = "To my former self, yes?",
					GameStateRequirements = 
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1299" }
						},
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1301", Text = "I would like that.",
					GameStateRequirements = 
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1302", Text = "Is that what you say?" ,
					GameStateRequirements = 
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 250,
		OnHitVoiceLines =
		{
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Chronos_02",
				GameStateRequirements =
				{
					-- 
				},
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 10 },
				},

				{ Cue = "/VO/Chronos_1096", Text = "You are upset..." },
				{ Cue = "/VO/Chronos_1097", Text = "I cannot change the past..." },
				{ Cue = "/VO/Chronos_1098", Text = "I shall not retaliate...", PlayFirst = true },
				{ Cue = "/VO/Chronos_1099", Text = "Do as you must..." },
				{ Cue = "/VO/Chronos_1100", Text = "Such pain I caused..." },
				{ Cue = "/VO/Chronos_1101", Text = "For old time's sake...?" },
			},
		},

		BossFinisherVoiceLines =
		{
			Queue = "Interrupt",
			{
				RandomRemaining = true,
				PreLineWait = 0.5,
				ObjectType = "NPC_Chronos_02",

				{ Cue = "/VO/Chronos_1108", Text = "{#Emph}May time flow freely forth!", PlayFirst = true },
				{ Cue = "/VO/Chronos_1109", Text = "{#Emph}May time flow freely forth...!", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1108" }
						},
					},
				},
				{ Cue = "/VO/Chronos_1110", Text = "{#Emph}May time flow freely forth.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1108" }
						},
					},
				},
				{ Cue = "/VO/Chronos_1111", Text = "{#Emph}May time flow freely forth...", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1108" }
						},
					},
				},
				{ Cue = "/VO/Chronos_1054", Text = "{#Emph}May time flow freely forward!" },
				{ Cue = "/VO/Chronos_1055", Text = "{#Emph}May time flow freely forward...!" },
				{ Cue = "/VO/Chronos_1056", Text = "{#Emph}May time flow freely forward." },
				{ Cue = "/VO/Chronos_1057", Text = "{#Emph}May time flow freely forward..." },
				{ Cue = "/VO/Chronos_1061", Text = "Sorry there, old boy." },
				{ Cue = "/VO/Chronos_1062", Text = "This shall not hurt at all." },
				{ Cue = "/VO/Chronos_1058", Text = "{#Emph}Death to Chronos{#Prev}, was it?",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
						},
						{
							Path = { "GameState", "SpeechRecord" },
							HasAll = { "/VO/Chronos_1108", "/VO/Chronos_1109", "/VO/Chronos_1110", "/VO/Chronos_1111" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1059", Text = "{#Emph}Death to Chronos.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
						},
					},
				},
				{ Cue = "/VO/Chronos_1060", Text = "{#Emph}Death to Chronos!",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
						},
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1058" },
						},
					},
				},

			},
		},

		InteractTextLineSets =
		{
			-- f_postboss events
			NeoChronosAboutErebus01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_1480",
					Text = "Would you permit that we occasionally meet thus, Granddaughter? I realize our prior conversations here in Erebus were fraught... but perhaps we may yet start anew, here in this life." },

				{ Cue = "/VO/MelinoeField_4137", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'll have to learn not to attack you here on sight, but let's give it a shot. What is it about this place that's so special?" },

				{ Cue = "/VO/Chronos_1481",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Well I know how to find it, for one! And you tend to pass through it, for two! At any rate, you now have seen the real possibilities that linger on Olympus and below. Let us eliminate the ones that would have led to ruin." },

				{ Cue = "/VO/MelinoeField_5181", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I do like preventing ruin. You'll be closely watched by Olympus and the Underworld every step of the way. Don't squander the chance you've been given." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Chronos_02",
						PostLineFunctionName = "ChronosExit",
						PostLineFunctionArgs = { WaitTime = 3 },
						{ Cue = "/VO/Chronos_1482", Text = "I keep telling myself the same!" },
					},
				},
				-- EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			NeoChronosAboutNewJob01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPostTrueEnding03" },
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_1085",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Your father and his brother Zeus were generous enough to give me an opportunity to be of some small service to the Underworld. The Isles of the Blessed are the finest spots in all Elysium! And I shall certainly keep them that way." },

				{ Cue = "/VO/MelinoeField_4139", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That's a high honor you've been given, Grandfather! Some of the greatest mortal heroes must be there. Shall the new responsibility leave you with time enough to meet like this?" },

				{ Cue = "/VO/Chronos_1086",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Oh I should think it shall be more convenient than before. Elysium is really not that far; you shall have to visit at some point, once your father's Underworld renovations are complete. Which I suppose may take another age." },

				{ Cue = "/VO/MelinoeField_4140", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Father does seem the exacting type. Well, all the best in the new role. Fates willing, see you soon in Tartarus." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Chronos_02",
						PostLineFunctionName = "ChronosExit",
						PostLineFunctionArgs = { WaitTime = 3 },
						{ Cue = "/VO/Chronos_1087", Text = "Retrace your steps with care!" },
					},
				},
				-- EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			NeoChronosAboutFailure01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "I_Boss01", "Q_Boss01", "Q_Boss02" },
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_5032", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "One thing I've wondered, Grandfather... for all these possibilities we face... I understand what happens if I prevail, more or less. But if I fail there, what then?" },

				{ Cue = "/VO/Chronos_1390",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Why, the possibility remains... nothing more! Do not concern yourself with that too much. We know there are a lot of these to go around! You may not prevail in them all." },

				{ Cue = "/VO/MelinoeField_5033", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Will I have other chances to correct my mistakes? Return to the same possibility and clear it up?" },

				{ Cue = "/VO/Chronos_1391",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "I do not know! Perhaps not! Perhaps even your {#Emph}failures{#Prev}, as you call them, shall have the desired result. There is much I do not fully understand... embarrassing as that may be." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_5034", Text = "I'm learning, too." },
					},
				},
				-- EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			NeoChronosAboutFates01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChaosAboutChronosNightmare01", "ChaosAboutChronosNightmare01_B" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosPostTrueEnding02" },
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_4141", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Grandfather, what of the Three Fates? You truly sent them into exile without knowing where they went?" },

				{ Cue = "/VO/Chronos_1088",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Well, yes. Another terrible mistake I dearly wish to rectify. I am attempting to locate them in the depths of possibility, except... they could be almost anywhere in there." },

				{ Cue = "/VO/MelinoeField_4142", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "There must be something we can do. Are they in any danger? And don't you fear reprisal if we ever find them?" },

				{ Cue = "/VO/Chronos_1089",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 3.3 },

					Text = "I must admit I do fear somewhat more for {#Emph}me {#Prev}than them. But my attempts to resist the workings of the Fates have never been successful in the past. Should they return, I shall accept whatsoever they may have in store..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4143", Text = "We'll figure something out." },
					},
				},
				-- EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			NeoChronosAboutTyphon01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_5029", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How did you reawaken Typhon, Grandfather? I always wondered about that. And to have caught the Olympians by surprise with such a monstrous being..." },

				{ Cue = "/VO/Chronos_1387",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					Text = "{#Emph}Oh{#Prev}, I... would rather not discuss such bitter memories, but... that monster's reawakening was in some ways akin to mine, when Zagreus found me. On a much larger scale, of course." },

				{ Cue = "/VO/MelinoeField_5030", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I see, and I won't press you on it, but... this may be strange to ask, though did you and Typhon know each other well?" },

				{ Cue = "/VO/Chronos_1388",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",

					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 5.3 },

					Text = "He was the Father of All Monsters... showing no concern for his own brood, much less others. He was a means to an end. We were using each other, one could say." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_5031", Text = "I understand. That's all." },
					},
					{
						PreLineWait = 0.32,
						ObjectType = "NPC_Chronos_02",
						{ Cue = "/VO/Chronos_1389", Text = "Very well." },
					},
				},
				-- EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			NeoChronosAboutPrometheus01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutPostTyphon02" }
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_5035", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Have you made contact with Prometheus after everything that's happened with us? He and I never really got along. Though I started to sense he wasn't really on your side..." },

				{ Cue = "/VO/Chronos_1392",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "He is {#Emph}intelligent{#Prev}, that one. Perhaps even too much for his own good. I regret that you were forced to come to blows. But, he and I are no longer in touch... to keep conditions closer to the way they were." },

				{ Cue = "/VO/MelinoeField_5036", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",

					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 5.3 },

					Text = "He has navigated this situation rather carefully, for all the trouble he's caused the gods. I suppose that all makes sense, if he truly could anticipate every outcome. " },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.32,
						ObjectType = "NPC_Chronos_02",
						{ Cue = "/VO/Chronos_1393", Text = "That sounds like the Prometheus I know." },
					},
				},
				-- EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			NeoChronosAboutGoldenAge01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraBathHouse03" },
					},
					{
						SumPrevRuns = 2,
						Path = { "BiomesReached", "P" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_5182", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "For what it's worth, Grandfather... I think the bitter war you waged against Olympus may have been eye-opening for some of our relatives, at least. They may be gods... but they know they're not perfect." },

				{ Cue = "/VO/Chronos_1483",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Well... perfection, to my knowledge, cannot be achieved! Merely striven for. My children could be obstinate about their weaknesses, but most likely they inherited that trait from {#Emph}me." },

				{ Cue = "/VO/MelinoeField_5183", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Even still... with the war finally ended, there's much to be done on the surface as well as here. I'm realizing that our renovation effort in the Underworld to some extent is worldwide." },

				{ Cue = "/VO/Chronos_1484",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 3.3 },

					Text = "When you get to be my age, you may yet wistfully recall the way the world used to be. It is a curse of growing old, perhaps! May our family yet guide this world into more-prosperous times." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_5184", Text = "May that be so." },
					},
				},
			},


			NeoChronosAboutChronos01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosBossOutroPostTrueEnding01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ChronosBossOutroPostTrueEnding01" }, Min = 2 },
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_4554", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "These other possibilities of you whom I face... it's strange to speak with them as though none of this occurred." },

				{ Cue = "/VO/Chronos_1311",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Oh very much so, yes. However, that is the reason they are possibilities and nothing more. Thus you may humor them before proceeding with the quite unpleasant bit." },

				{ Cue = "/VO/MelinoeField_4555", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And it doesn't trouble you to be involved? Personally eliminating something that looks just like you... that {#Emph}is {#Prev}you?" },

				{ Cue = "/VO/Chronos_1312",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 3.3 },

					Text = "But {#Emph}I {#Prev}am me. For are we not the sum of our experiences, Granddaughter? To reject one's stubborn old thoughts and ways... it can be quite invigorating! So let us carry on." },

				-- EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			NeoChronosAboutKeepsake01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "GoldifyKeepsake" },
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_1290",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Why you have there the Time Piece which I gave to you. I thought you would sooner cast it into the lowest depths! The ever-turning clockwork is quite fascinating, is it not?" },

				{ Cue = "/VO/MelinoeField_4369", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It is unusual. Is this something that Master Daedalus originally made? To have fitted all these little wheels together so that they could move in perfect harmony..." },

				{ Cue = "/VO/Chronos_1291",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 3.3 },

					Text = "The mechanisms governing the ever-shifting chambers of Tartarus were a source of inspiration, certainly. This sense of perfect harmony, which you describe... perhaps it can only be achieved in such a form! But it {#Emph}can {#Prev}be achieved." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/MelinoeField_4370", Text = "I suppose I agree." },
					},
				},
			},
			NeoChronosAboutAnomaly01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = {
							"GeneratedAnomalyB" },
						Comparison = ">=",
						Value = 1,
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_1292",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Oh down in Oceanus, it is possible you may encounter remnants of my spell, which casts you to a vision out of time. I've not yet found the means to stop {#Emph}that {#Prev}one..." },

				{ Cue = "/VO/MelinoeField_4371", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You have no control over your own magick? I wondered whether that was you, or one of your less agreeable selves." },

				{ Cue = "/VO/Chronos_1293",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 2.3 },

					Text = "I cannot rightly deny all responsibility, but it is one of {#Emph}those{#Prev}, yes. And your susceptibility, why... perhaps it is some connection which we share. Resistances and sensitivities..." },
			},

			NeoChronosAboutBoons01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "UseRecord" },
						CountOf =
						{
							"ZeusUpgrade",
							"PoseidonUpgrade",
						},
						Comparison = ">=",
						Value = 2,
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_1313",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "You have my children's blessings even now. I am relieved they are still offering their aid, considering the crisis I created, and the harm I brought upon their home..." },

				{ Cue = "/VO/MelinoeField_4556", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It seems we're all committed to setting this right, such as we can. The Olympians are no strangers to occasional fights anyhow, although perhaps not quite as bad as this last one." },

				{ Cue = "/VO/Chronos_1314",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 2.3 },

					Text = "Yes, well, if we are to exist in this small world together for eternity, we have incentive to alleviate the misery which we ourselves create... I thank you all for the support." },
			},
			NeoChronosAboutNemesis01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisPostTrueEndingTimeStopped01" },
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_4559", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Grandfather, Nemesis mentioned that she may have encountered you in Tartarus. How did that go?" },

				{ Cue = "/VO/Chronos_1317",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Oh, very well, indeed! I had presumed that only {#Emph}you {#Prev}would have capacity to face unwanted traces of myself, but as it happens, so can {#Emph}Nemesis! And {#Prev}she is very strong." },

				{ Cue = "/VO/MelinoeField_4560", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So she {#Emph}was {#Prev}serious! She confronted one of those traces with your aid, and was able to prevail? What, did she hack him to bits with the Stygian Blade?" },

				{ Cue = "/VO/Chronos_1318",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 3.3 },

					Text = "Well I prefer not to describe the details, but... she used effective means. This must be possible only because she was so near your path before!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4561", Text = "She truly did it..." },
					},
				},
			},

			NeoChronosAboutBeard01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift04" },
					},
					NamedRequirements = { "NeoChronosCanSpawnInErebus" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_1315",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "I have a question for you, Granddaughter, if you would share your point of view. Do you suppose I ought permit myself to grow a beard? To fit in better with my children, I suppose..." },

				{ Cue = "/VO/MelinoeField_4557", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, {#Emph}erm... {#Prev}that's largely a matter of taste. Personally, I think growing a beard would mostly make you look older. And, my father and uncles aren't expecting you to {#Emph}be {#Prev}like them." },

				{ Cue = "/VO/Chronos_1316",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 3.3 },

					Text = "I do suppose that you are right. I always did prefer a cleaner countenance. Perhaps that is the very reason that my children opted otherwise..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4558", Text = "I could see that..." },
					},
				},
			},

			NeoChronosPostEpilogue01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_4372", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Good news, Grandfather. The Three Fates have returned! And they didn't mention any reprisal when it comes to you. On the contrary, they promised a new age would dawn..." },

				{ Cue = "/VO/Chronos_1294",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "My, but that is good news! Particularly the no-reprisal part, and it is a relief to know the Three have navigated out of temporary exile. But what is this about a {#Emph}new age?" },

				{ Cue = "/VO/MelinoeField_4373", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Well... it sounds as though they're not planning to weave as much as they used to. And at some point, the gods apparently will hold less sway over mortals' lives..." },

				{ Cue = "/VO/Chronos_1295",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "But that is reminiscent of the Golden Age in which {#Emph}I {#Prev}ruled...! Of course, once you have lived sufficient aeons you begin to see such patterns circulating constantly. That which is old becomes the new. How fares our family with all this?" },

				{ Cue = "/VO/MelinoeField_4374", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "I think we're all having to give it some consideration, though we'll have plenty of time. This age may not be soon." },

				{ Cue = "/VO/Chronos_1296",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 3.3 },

					Text = "Perhaps not... but even still, this age may arrive before you know it. Take it from me..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4375", Text = "Time can move swiftly..." },
					},
				},
			},

			NeoChronosPostEpilogue02 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/Chronos_1434",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "I always did admire mortalkind... I am pleased the Fates decided they shall have a chance at doing things their way. I shall be curious to see what comes of it." },

				{ Cue = "/VO/MelinoeField_5074", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Prometheus must have wanted to work with you toward that common goal. Most of what I know of mortals is from the dead... what's the appeal of the living?" },

				{ Cue = "/VO/Chronos_1435",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",

					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 4.3 },

					Text = "Well it is simply that they understand the value of Time... some of them, anyhow. For they have so little, whilst they live and breathe. It is a pity in some ways, but quite inspiring in others." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/MelinoeField_5075", Text = "I do see that in them." },
					},
				},
			},

			NeoChronosAboutPast01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift01" },
					},
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true },

				{ Cue = "/VO/MelinoeField_5071", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Grandfather, do you ever... experience your old feelings of bitterness and spite...? Toward the gods, about your bygone Golden Age, anything of the sort?" },

				{ Cue = "/VO/Chronos_1432",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "There is no undoing past mistakes. I held to those feelings for a very long time; they shall never leave me in their entirety. But you have given me this other chance." },

				{ Cue = "/VO/MelinoeField_5072", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You seemed so unyielding, so certain of your convictions. Sometimes I still cannot believe the memory of a better past was enough to change your mind." },

				{ Cue = "/VO/Chronos_1433",

					PostLineThreadedFunctionName = "ChronosExit",
					PostLineFunctionArgs = { WaitTime = 4.3 },

					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "I was taken aback as well. My memories of seeing you grow up... they represent but a fraction of my existence. But an important one. Change can happen in an instant." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/MelinoeField_5073", Text = "Well may you stay like this." },
					},
				},
			},

			-- partner conversations
			NeoChronosWithNemesis01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				Partner = "NPC_Nemesis_01",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "SpawnNemesisWithNeoChronos" },
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				InteractDistance = 650,
				InteractOffsetX = -500,

				{ Cue = "/VO/Chronos_1073",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "...To think the task of vanquishing me almost fell to you! I am most fortunate that it did not, for I could not have easily resisted Retribution Incarnate; I cannot imagine who could!" },

				{ Cue = "/VO/Nemesis_0431",
					Portrait = "Portrait_Nemesis_Default_01",
					Speaker = "NPC_Nemesis_01",
					PreLineAnim = "Nemesis_Hub_Glare_Start",
					PreLineAnimTarget = 772131,
					PostLineAnim = "Nemesis_Hub_Glare_End",
					PostLineAnimTarget = 772131,
					Text = "Me neither, so don't try anything around here. And if you and the Princess need another helping hand cleaning up after yourself, let me know. Been wanting to pitch in." },

				{ Cue = "/VO/Chronos_1074",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Then you have heard about the nature of our present course? There are so many possibilities which must be ruled out one by one. If you are truly willing to assist in this..." },

				{ Cue = "/VO/Nemesis_0432", UsePlayerSource = true,
					Portrait = "Portrait_Nemesis_Default_01",
					Speaker = "NPC_Nemesis_01",
					PreLineAnim = "Nemesis_Hub_Greet",
					PreLineAnimTarget = 772131,
					Text = "Might as well. Set my mind to it a while back, and can get all the way to Tartarus, just not inside the House." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.32,
						ObjectType = "NPC_Chronos_02",
						{ Cue = "/VO/Chronos_1075", Text = "I can readily address that detail!" },
					},
					{
						PreLineWait = 0.54,
						ObjectType = "NPC_Nemesis_01",
						{ Cue = "/VO/Nemesis_0433", Text = "Tell me more." },
					},
				},
			},

			-- time warp events
			-- alt below
			NeoChronosAboutTartarus01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_PreBoss01", "I_PreBoss02" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "NeoChronosAboutOlympus01", "NeoChronosAboutTartarus01_B" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true, HideUntilWithinDistance = true },

				{ Cue = "/VO/Chronos_1030",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Greet",
					-- PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Good, you are here at last! Now that you faithfully re-traced your path, I ought be able to manipulate the course of time such that you find yourself within the House whilst a remnant self of mine sits on your father's throne. Ready?" },

				{ Cue = "/VO/MelinoeField_4128", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Text = "No, not yet. What shall happen if I prevail, let alone fail? Are you certain any of this shall even {#Emph}work?" },

				{ Cue = "/VO/Chronos_1031",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Well I am relatively certain, yes! The visions I can conjure up of Asphodel; the principle of this is much the same! And you have likewise demonstrated aptitude at breaking free of temporal restraints." },

				{ Cue = "/VO/MelinoeField_4129", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So I'm to enter the House exactly as before, and deal with this remnant Chronos as I have in the past... then you shall do the rest?" },

				{ Cue = "/VO/Chronos_1032",
					Text = "Exactly so. First I shall create a shift whilst you enter, then you do as you must with the wrong-headed version of me in {#Emph}there! {#Prev}We shall be {#Emph}rid {#Prev}of the mere {#Emph}possibility {#Prev}of him!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4130", Text = "All right, then... off I go!" },
					},
				},
			},
			-- player did post-ending olympus route first
			NeoChronosAboutTartarus01_B =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_PreBoss01", "I_PreBoss02" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NeoChronosAboutOlympus01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NeoChronosAboutTartarus01" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true, HideUntilWithinDistance = true },

				{ Cue = "/VO/Chronos_1030",
					Text = "Good, you are here at last! Now that you faithfully re-traced your path, I ought be able to manipulate the course of time such that you find yourself within the House whilst a remnant self of mine sits on your father's throne. Ready?" },

				{ Cue = "/VO/MelinoeField_4131", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not quite. Shall this go much like on the summit of Olympus? The way you conjured up a vision of a time that could have been... " },

				{ Cue = "/VO/Chronos_1034",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Well I certainly believe this ought transpire as you say! Of course, that which awaits within shall perhaps be a little different in each instance that we venture thus..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4134", Text = "Very well then." },
					},
				},
			},

			NeoChronosAboutTartarus02 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "I_PreBoss01", "I_PreBoss02" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true, HideUntilWithinDistance = true },

				{ Cue = "/VO/Chronos_1046",
					Text = "All right, my girl, this shall unfold exactly as before! You leap into the river, I ensure you end up in the proper stream." },
			},

			-- alt below
			NeoChronosAboutOlympus01 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_PostBoss01" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "NeoChronosAboutTartarus01", "NeoChronosAboutOlympus01_B" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true, HideUntilWithinDistance = true },

				{ Cue = "/VO/Chronos_1035",
					Text = "{#Emph}Ah{#Prev}, there you are, my girl. As you have faithfully re-traced your path, now I in turn may shift you to a different sort of time in which a remnant of the monstrous Typhon yet looms large over this very place. Ready?" },

				{ Cue = "/VO/MelinoeField_4128", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Text = "No, not yet. What shall happen if I prevail, let alone fail? Are you certain any of this shall even {#Emph}work?" },

				{ Cue = "/VO/Chronos_1031",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Well I am relatively certain, yes! The visions I can conjure up of Asphodel; the principle of this is much the same! And you have likewise demonstrated aptitude at breaking free of temporal restraints." },

				{ Cue = "/VO/MelinoeField_4132", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So I'm to launch toward the summit, where I'll find Typhon's forces from another time awaiting me, I'll deal with him as I once did, and you shall do the rest?" },

				{ Cue = "/VO/Chronos_1036",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "If all proceeds as planned, then yes! I shall create a shift as you depart; seek that monster and do battle, so that we may yet eliminate even the {#Emph}possibility {#Prev}of him." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4130", Text = "All right, then... off I go!" },
					},
				},
			},
			-- player did post-ending tartarus route first
			NeoChronosAboutOlympus01_B =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_PostBoss01" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NeoChronosAboutTartarus01" }
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NeoChronosAboutOlympus01" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true, HideUntilWithinDistance = true },

				{ Cue = "/VO/Chronos_1035",
					Text = "{#Emph}Ah{#Prev}, there you are, my girl. As you have faithfully re-traced your path, now I in turn may shift you to a different sort of time in which a remnant of the monstrous Typhon yet looms large over this very place. Ready?" },

				{ Cue = "/VO/MelinoeField_4133", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not quite. Shall this go much like at my father's House? The way you conjured up a vision of a time that could have been..." },

				{ Cue = "/VO/Chronos_1036",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "If all proceeds as planned, then yes! I shall create a shift as you depart; seek that monster and do battle, so that we may yet eliminate even the possibility of him." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4134", Text = "Very well then." },
					},
				},
			},

			NeoChronosAboutOlympus02 =
			{
				PlayOnce = true,
				RoomUseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "P_PostBoss01" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "NeoChronosNPCSetup",
				OnQueuedFunctionArgs = { RequiredRoomInteraction = true, HideUntilWithinDistance = true },

				{ Cue = "/VO/Chronos_1047",
					Text = "Now then, my girl, you know what to expect! Leap for the summit, all whilst I shall ensure you find the proper stream." },
			},

			-- partner conversations
			HadesTrueEnding01 =
			{
				Partner = "NPC_Hades_02",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				UseText = "UseListenNPC",
			},
			ZeusPalacePostTrueEnding01 =
			{
				Partner = "NPC_Zeus_Story_01",
				PlayOnce = true,
				UseableOffSource = true,
			},
		},

		GiftTextLineSets =
		{
			NeoChronosGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				LockedHintId = "Codex_ChronosGiftHint",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/MelinoeField_4204", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Grandfather...? The wounds our family has suffered perhaps shall never truly heal, but... you've at least tried to take some of the initial steps. So here, this is for you." },

				{ Cue = "/VO/Chronos_1284",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					PostLineThreadedFunctionName = "ChronosExit",
					PostLineThreadedFunctionArgs = { WaitTime = 6.0, FromGiftEvent = true },
					Text = "{#Emph}Oh{#Prev}, what a precious bottle, thank you, Granddaughter! Nectar from Olympus... but, it does look rather good. The custom still is to provide some sort of gift in kind, is that not so? Then here, if you please." },
			},
			NeoChronosGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Chronos_1285",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "Why, this is {#Emph}very {#Prev}generous of you. The House of Hades had a relatively small supply of this, but in my rancor, I... well, had it all smashed up. This bottle I'll be careful to preserve." },

				{ Cue = "/VO/MelinoeField_4365", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please keep it, knowing Nectar is also to be savored. As for those other bottles, their contents would have soaked into the Earth, so... perhaps the House is a bit brighter now." },

				EndVoiceLines =
				{
					{
						ObjectType = "NPC_Chronos_02",
						PostLineFunctionName = "ChronosExit",
						PostLineFunctionArgs = { WaitTime = 2.5, FromGiftEvent = true },
					},
				},
			},
			NeoChronosGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Chronos_1286",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",
					Text = "This bottle's golden hue... I cannot imagine a more beauteous color, truly. In this life, I did not realize Olympus delighted in gold the way I do. Although you seem to prefer silver, Granddaughter..." },

				{ Cue = "/VO/MelinoeField_4366", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I always have. We work under the Moon and stars... the sheen of silver reminds me of them. But gold now reminds me of Apollo I suppose, and he is quite approachable, in case you haven't met." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Chronos_02",
						PostLineFunctionName = "ChronosExit",
						PostLineFunctionArgs = { WaitTime = 2.0, FromGiftEvent = true },
						{ Cue = "/VO/Chronos_1287", Text = "Apollo, the musician. He seemed a talented young lad..." },
					},
				},
			},
			NeoChronosGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				CompletedHintId = "Codex_BondForgedChronos",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				{ Cue = "/VO/Chronos_1288",
					Text = "I partook of the Nectar which you previously gave to me, and my, such a wondrous flavor... and so I thought, I've not yet rightly earned such privileges from you." },

				{ Cue = "/VO/MelinoeField_4367", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "It's not a privilege, it's a simple gift. It's not even the fancy stuff! You'll have to try Ambrosia sometime, especially since you enjoy a nice golden hue." },

				{ Cue = "/VO/Chronos_1289",
					PreLineAnim = "NPC_Chronos_Enlightened_Explaining",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Chronos_02", Icon = "Keepsake_Chronos", Delay = 1.5, UseInputBlock = true, EndFunctionName = "ChronosExit", EndFunctionArgs = { WaitTime = 0.5, FromGiftEvent = true } },

					Text = "Ambrosia, yes... perhaps at some point I shall have opportunity to share in it along with this family. But that I know shall take considerable time. No more for now, please, Granddaughter. Not whilst so much is left undone." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4368", Text = "Some other time, then." },
					},
				},
			},

		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/MelinoeField_4205", Text = "What an unusual device... and made of gold. Thank you." },
		},

	},

}

-- Global Chronos Lines / Chronos Global Lines
GlobalVoiceLines.ChronosLaunchVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		SuccessiveChanceToPlayAll = 0.75,
		PreLineWait = 0.35,
		ObjectTypes =  { "NPC_Chronos_02" },
		PreLineAnim = "NPC_Chronos_Enlightened_Greet",
		GameStateRequirements =
		{
		},

		{ Cue = "/VO/Chronos_1033", Text = "Farewell!", PlayFirst = true },
		{ Cue = "/VO/Chronos_1037", Text = "See you later!" },
		{ Cue = "/VO/Chronos_1037_B", Text = "See you later!" },
		{ Cue = "/VO/Chronos_1040", Text = "Another time!" },
		{ Cue = "/VO/Chronos_1041", Text = "Do take care!" },
		{ Cue = "/VO/Chronos_1043", Text = "Go get him!" },
		{ Cue = "/VO/Chronos_1045", Text = "Go on then!" },
		{ Cue = "/VO/Chronos_1399", Text = "Like {#Emph}clockwork!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChronosBossAboutClockwork01" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1397", Text = "Do beware ahead!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 4,
				},
			},
		},
		{ Cue = "/VO/Chronos_1398", Text = "Go on my Time Keeper!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "NeoChronosGift02" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1396", Text = "Watch out for {#Emph}me {#Prev}up there!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "BiomesReached", "P" },
				},
				{
					Path = { "GameState", "ShrineUpgrades", "BossDifficultyShrineUpgrade" },
					Comparison = ">=",
					Value = 4,
				},
				{
					PathTrue = { "GameState", "TextLinesRecord", "TyphonBossAltFight01" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1336", Text = "Time to go.",
			GameStateRequirements =
			{
				{
					PathFalse = { "PrevRun", "Cleared" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1337", Text = "Right! Time to go.",
			GameStateRequirements =
			{
				{
					PathFalse = { "PrevRun", "Cleared" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1038", Text = "Hello! Goodbye!",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "UseRecord", "NPC_Chronos_02" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1039", Text = "Hello and goodbye!",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "UseRecord", "NPC_Chronos_02" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1042", Text = "There you are!",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "UseRecord", "NPC_Chronos_02" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1044", Text = "See you shortly!",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "Name" },
					IsAny = { "I_PreBoss02" },
				},
			},
		},
	},
	{ GlobalVoiceLines = "InfiltratingHouseLines" },
}

GlobalVoiceLines.ChronosGoldifyVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.25,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" }
			},
		},
		Cooldowns =
		{
			{ Name = "RewardGoldifiedSpeech", Time = 30 },
		},

		{ Cue = "/VO/Chronos_1340", Text = "{#Emph}Solid Gold!", PlayFirst = true },
		{ Cue = "/VO/Chronos_1338", Text = "{#Emph}To Gold!" },
		{ Cue = "/VO/Chronos_1339", Text = "{#Emph}To Gold!" },
		{ Cue = "/VO/Chronos_1341", Text = "{#Emph}A golden opportunity!" },
		{ Cue = "/VO/Chronos_1342", Text = "{#Emph}Gold." },
		{ Cue = "/VO/Chronos_1343", Text = "{#Emph}Gold!" },
		{ Cue = "/VO/Chronos_1344", Text = "{#Emph}Boon? Gold!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"ZeusUpgrade",
						"HeraUpgrade",
						"PoseidonUpgrade",
						"DemeterUpgrade",
						"ApolloUpgrade",
						"AphroditeUpgrade",
						"HephaestusUpgrade",
						"HestiaUpgrade",
						"AresUpgrade",
						"TrialUpgrade",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1345", Text = "{#Emph}Onion? Gold!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"RoomRewardConsolationPrize",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1346", Text = "{#Emph}Ashes? Gold!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"MetaCardPointsCommonDrop",
						"MetaCardPointsCommonBigDrop",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1347", Text = "{#Emph}Bones? Gold.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"MetaCurrencyDrop",
						"MetaCurrencyBigDrop",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1348", Text = "{#Emph}Nectar? Gold.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"GiftDrop",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1349", Text = "{#Emph}Hammer? Gold.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"WeaponUpgrade",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1350", Text = "{#Emph}Moon? Gold!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"SpellDrop",
						"TalentDrop",
						"MinorTalentDrop",
						"TalentBigDrop",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1351", Text = "{#Emph}Tonic? Gold!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"MaxManaDrop",
						"MaxManaDropBig",
						"MaxManaDropSmall",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1352", Text = "{#Emph}Centaur Heart? Centaur Gold!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"MaxHealthDrop",
						"MaxHealthDropBig",
						"MaxHealthDropSmall",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1394", Text = "{#Emph}Pom? Gold.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"StackUpgrade",
						"StackUpgradeBig",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
		{ Cue = "/VO/Chronos_1395", Text = "{#Emph}Armor? Gold!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "SessionMapState", "GoldifySource" },
					IsAny =
					{
						"ArmorBoost",
						"ArmorBigBoost",
					},
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Chronos_1340" },
				},
			},
		},
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.45,
		ObjectType = "NPC_Nyx_Story_01",
		PreLineAnim = "Nyx_Greeting",
		-- SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "NyxSpokeRecently", Time = 6 },
		},

		{ Cue = "/VO/Nyx_0151", Text = "Oh..." },
		{ Cue = "/VO/Nyx_0152", Text = "Odd..." },
		{ Cue = "/VO/Nyx_0153", Text = "Unusual..." },
		{ Cue = "/VO/Nyx_0154", Text = "Creation..." },
		{ Cue = "/VO/Nyx_0155", Text = "Chaos...?", PlayFirst = true },
		{ Cue = "/VO/Nyx_0156", Text = "{#Emph}Hmm..." },
	},
}

GlobalVoiceLines.MiscEndVoiceLines_Chronos =
{
	RandomRemaining = true,
	UsePlayerSource = true,
	PreLineWait = 1.0,
	SuccessiveChanceToPlay = 0.5,
	GameStateRequirements =
	{
		--
	},
	Cooldowns =
	{
		{ Name = "MelinoeAnyQuipSpeech" },
	},

	{ Cue = "/VO/Melinoe_1947", Text = "{#Emph}<Scoff>" },
	{ Cue = "/VO/Melinoe_1949", Text = "{#Emph}<Sigh>" },
	{ Cue = "/VO/Melinoe_0580", Text = "{#Emph}Ugh..." },
	{ Cue = "/VO/Melinoe_0322", Text = "{#Emph}Grr!" },
	{ Cue = "/VO/MelinoeField_0495", Text = "Coward..." },
	{ Cue = "/VO/MelinoeField_2023", Text = "{#Emph}Ungh..." },
}

GlobalVoiceLines.ChronosDeathTauntVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlay = 0.25,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpentShrinePointsCache" },
				Comparison = ">=",
				Value = 16,
			},
		},

		{ Cue = "/VO/Intercom_0884", Text = "That Fear in the air... it is none other than your own." },
		{ Cue = "/VO/Intercom_0885", Text = "You, who invoke the Night: Suffer the consequence." },
		{ Cue = "/VO/Intercom_0886", Text = "The Fear is growing in you, is it not?" },
		{ Cue = "/VO/Intercom_0887", Text = "You pledge yourself to a forgotten cause." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "F_Boss01", "F_Boss02" },
			},
		},

		{ Cue = "/VO/Intercom_0083", Text = "Weakling! You shall never be her equal.", PlayFirst = true },
		{ Cue = "/VO/Intercom_0084", Text = "Your master cannot best me; how could you?" },
		{ Cue = "/VO/Intercom_0890", Text = "You cannot even find your way out of those woods?" },
		{ Cue = "/VO/Intercom_0891", Text = "So many lost souls in Erebus! You are but one." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "G_Boss01", "G_Boss02" },
			},
		},

		{ Cue = "/VO/Intercom_0088", Text = "Distracted by the Sirens' song, were you?" },
		{ Cue = "/VO/Intercom_0089", Text = "Like so many sailors sent to a watery grave..." },
		{ Cue = "/VO/Intercom_0713", Text = "May the Sirens' song torment you even beyond their vicinity." },
		{ Cue = "/VO/Intercom_0714", Text = "Drowned out once more by the din of the Sirens' song!" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "H_Boss01", "H_Boss02" },
			},
		},

		{ Cue = "/VO/Intercom_0715", Text = "It seems that wretched cur is good for something after all!" },
		{ Cue = "/VO/Intercom_0716", Text = "That three-headed beast has no kinship for you, or anyone." },
		{ Cue = "/VO/Intercom_0717", Text = "Only a hollow fool would deign to tame such a monstrosity.", PlayFirst = true },
		{ Cue = "/VO/Intercom_0718", Text = "Your poor old family dog just wanted to be left alone." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "N_Boss01", "N_Boss02" },
			},
		},

		{ Cue = "/VO/Intercom_0719", Text = "Best not to come between a shepherd and his flock." },
		{ Cue = "/VO/Intercom_0720", Text = "Even a sightless Cyclops saw through your pathetic plan." },
		{ Cue = "/VO/Intercom_0721", Text = "You are nothing but a morsel to a peckish Cyclops, girl." },
		{ Cue = "/VO/Intercom_0722", Text = "Merely another sheep that decided to step out of line." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "O_Boss01", "O_Boss02" },
			},
		},

		{ Cue = "/VO/Intercom_0723", Text = "Wherever you may voyage, Strife shall follow in your wake." },
		{ Cue = "/VO/Intercom_0724", Text = "This could have ended quickly, but you had to invite Strife." },
		{ Cue = "/VO/Intercom_0725", Text = "Perhaps {#Emph}you {#Prev}are the cause of all this strife, not Strife herself?", PlayFirst = true },
		{ Cue = "/VO/Intercom_0726", Text = "The sting of that infernal Rail of Adamant is {#Emph}painful{#Prev}, is it not?" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "CurrentRoom", "Name" },
				IsAny = { "P_Boss01" },
			},
		},

		{ Cue = "/VO/Intercom_0727", Text = "A Titan's vengeance is a flame that cannot be quenched." },
		{ Cue = "/VO/Intercom_0728", Text = "Why bother when Prometheus has seen that you shall fail?", PlayFirst = true },
		{ Cue = "/VO/Intercom_0729", Text = "The Titan of Foresight chose the winning side; my own." },
		{ Cue = "/VO/Intercom_0730", Text = "It seems you made our poor Prometheus very upset again." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "P" },
			},
		},

		{ Cue = "/VO/Intercom_0888", Text = "The fall of Mount Olympus is inevitable, as you plainly see." },
		{ Cue = "/VO/Intercom_0889", Text = "The gods are not so proud as they once were." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.1,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "BiomesReached", "N" },
			},
		},

		{ Cue = "/VO/Intercom_0090", Text = "The surface is no place for you, my girl.", PlayFirst = true },
		{ Cue = "/VO/Intercom_0091", Text = "Should you have reached Olympus, what then?",
			GameStateRequirements =
			{
				{
					PathFalse = { "CurrentRun", "BiomesReached", "P" },
				},
			},
		},
		{ Cue = "/VO/Intercom_0092", Text = "The age of gods is drawing to a close." },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		SuccessiveChanceToPlayAll = 0.05,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
			},
		},
		{ Cue = "/VO/Intercom_0067", Text = "You gods are too unfit to rule this world. That is apparent from a single glance." },
		{ Cue = "/VO/Intercom_0065", Text = "You took everything from me, Hades. It's only fitting I should do the same.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "I_Story01" }
				},
			},
		},
		{ Cue = "/VO/Intercom_0066", Text = "What happened to your daughter, Hades, {#Emph}hm? {#Prev}I'll ask nicely only one last time.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "I_Story01" }
				},
			},
		},
		{ Cue = "/VO/Intercom_0068", Text = "You and my children stopped me once, Hades. But now, I've had plenty of time to prepare.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "I_Story01" }
				},
			},
		},
		{ Cue = "/VO/Intercom_0069", Text = "You speak of justice, Hades? How many mortal souls have you cruelly tortured, for how long?",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "RoomsEntered", "I_Story01" }
				},
			},
		},
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 1.25,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Intercom_0085", Text = "Shall you remain forever lost in Erebus?",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsAny = { "F" },
				},
			},
		 },
		{ Cue = "/VO/Intercom_0093", Text = "I foresee every one of your useless attempts." },
		{ Cue = "/VO/Intercom_0086", Text = "So fiercely fought, yet so far from your goal." },
		{ Cue = "/VO/Intercom_0087", Text = "I have naught to fear from witches such as you.",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Intercom_0021", Text = "{#Emph}<Laughter>" },
		{ Cue = "/VO/Intercom_0022", Text = "{#Emph}<Laughter>" },
		{ Cue = "/VO/Intercom_0023", Text = "{#Emph}<Laughter>" },
		{ Cue = "/VO/Intercom_0036", Text = "You cannot stop Time." },
		{ Cue = "/VO/Intercom_0037", Text = "Give up already, girl." },
		{ Cue = "/VO/Intercom_0038", Text = "You appear to be a slow learner." },
		{ Cue = "/VO/Intercom_0039", Text = "Another unsuccessful try." },
		{ Cue = "/VO/Intercom_0040", Text = "Are you becoming used to this result?" },
		{ Cue = "/VO/Intercom_0041", Text = "You struggle ceaselessly, but to what end?" },
		{ Cue = "/VO/Intercom_0042", Text = "I almost pity you your wasted efforts." },
		{ Cue = "/VO/Intercom_0043", Text = "All of your efforts, once again in vain." },
		{ Cue = "/VO/Intercom_0044", Text = "You are beginning to annoy me, girl." },
		{ Cue = "/VO/Intercom_0045", Text = "Never trifle with a Titan, girl." },
		{ Cue = "/VO/Intercom_0046", Text = "I ought to have you chained in Tartarus." },
		{ Cue = "/VO/Intercom_0047", Text = "Cease with these pointless attempts of yours." },
		{ Cue = "/VO/Intercom_0048", Text = "Your failure was inevitable." },
		{ Cue = "/VO/Intercom_0049", Text = "You are spirited, but not invincible." },
		{ Cue = "/VO/Intercom_0050", Text = "The Fates shall be no kinder to you next time." },
		{ Cue = "/VO/Intercom_0051", Text = "Was that the limit of your power, hm?" },
		{ Cue = "/VO/Intercom_0052", Text = "You could have done better than that." },
		-- { Cue = "/VO/Intercom_0053", Text = "How many further chambers can you stand?" },
		-- { Cue = "/VO/Intercom_0054", Text = "You were quite fortunate back there I think." },
	},
}

GlobalVoiceLines.AnomalyLocatedVoiceLines =
{
	[1] = { GlobalVoiceLines = "AnomalyReactionVoiceLines" },
	[2] =
	{
		PlayOnce = true,
		PlayOnceContext = "ChronosAnomalyReveal",
		BreakIfPlayed = true,
		PreLineWait = 0.5,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Intercom_0037", Text = "Give up already, girl." },

		-- { Cue = "/VO/Intercom_0147", Text = "I know who you are. I know where you go. You shall not get there.", PlayFirst = true, PlayOnce = true },
	},
	[3] =
	{
		ThreadName = "RoomThread",
		RandomRemaining = true,
		PreLineWait = 0.8,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Intercom_1282", Text = "Wait, what is going on... how can this {#Emph}be?",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" }
				},
			},
		},
		{ Cue = "/VO/Intercom_1283", Text = "You, who stalks me as a nightmare... {#Emph}begone!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "ReachedTrueEnding" }
				},
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Intercom_1282" },
				},
			},
		},
		{ Cue = "/VO/Intercom_0100", Text = "Where do you think you are going?" },
		{ Cue = "/VO/Intercom_0101", Text = "Such mindless, flailing persistence on your part." },
		{ Cue = "/VO/Intercom_0102", Text = "You venture into {#Emph}my {#Prev}domain." },
		{ Cue = "/VO/Intercom_0103", Text = "I know what you are attempting to achieve." },
		{ Cue = "/VO/Intercom_0104", Text = "My tolerance for you grows very thin." },
		{ Cue = "/VO/Intercom_0105", Text = "You wish to see your father's domain, do you?" },
		{ Cue = "/VO/Intercom_0106", Text = "Your efforts have not gone unnoticed, Granddaughter." },
		{ Cue = "/VO/Intercom_0107", Text = "Perhaps you should return some other {#Emph}time." },
		{ Cue = "/VO/Intercom_0108", Text = "This never was your father's realm." },
		{ Cue = "/VO/Intercom_0109", Text = "You speak to me of nightmares; here is one.",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting03" },
				},
			},
		},
	},
}
GlobalVoiceLines.AnomalyEnteredVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 1.15,
		SuccessiveChanceToPlay = 0.75,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		Cooldowns =
		{
			{ Name = "AnomalyVOPlayed", Time = 5 },
		},

		{ Cue = "/VO/Intercom_0148", Text = "You wish to traipse through this realm, then here! Bask in it.", PlayFirst = true, PlayOnce = true },
		{ Cue = "/VO/Intercom_0110", Text = "Behold the splendor of your father's Underworld." },
		{ Cue = "/VO/Intercom_0112", Text = "The Underworld you never knew! But, you did not miss much..." },
		{ Cue = "/VO/Intercom_0113", Text = "A glimpse of the past, or one of your nightmares?" },
		-- { Cue = "/VO/Intercom_0114", Text = "Here then is glorious Elysium, before it fell on harder times." },
		-- { Cue = "/VO/Intercom_0115", Text = "The champions within Elysium were always eager for a fight." },
		-- { Cue = "/VO/Intercom_0116", Text = "So many glory-seekers such as you wound up within Elysium." },
		{ Cue = "/VO/Intercom_0117", Text = "Your father's wretches within Asphodel so hated trespassers." },
		{ Cue = "/VO/Intercom_0118", Text = "Welcome to the verdant meadows of Asphodel." },
		{ Cue = "/VO/Intercom_0119", Text = "Bask now in the intolerable heat of Asphodel." },
		{ Cue = "/VO/Intercom_0111", Text = "This is your father's realm as once it was.",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "SpeechRecord" },
					HasNone = { "/VO/Intercom_0108" },
				},
			},
		},
	},
	{
		PreLineWait = 0.1,
		UsePlayerSource = true,
		PlayOnce = true,
		GameStateRequirements = 
		{
			{
				Path = { "LastLinePlayed" },
				IsAny = { "/VO/Intercom_0148" },
			},
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasNone = { "/VO/MelinoeField_0206", "/VO/Intercom_0149" },
			},
			{
				PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
			},
		},
		{ Cue = "/VO/MelinoeField_0248", Text = "That old man... it was {#Emph}him..." },
	},
	{
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.75,
		UsePlayerSource = true,
		PreLineWait = 0.85,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "SpeechRecord" },
				HasNone = { "/VO/MelinoeField_0206", "/VO/Intercom_0149" },
			},
		},
		SkipCooldownCheckIfNonePlayed = true,
		Cooldowns =
		{
			{ Name = "AnomalyVOPlayed", Time = 10 },
		},

		{ Cue = "/VO/MelinoeField_0190", Text = "Where am I... or {#Emph}when...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0191", Text = "This isn't real..." },
		{ Cue = "/VO/MelinoeField_0192", Text = "Trapped..." },
		{ Cue = "/VO/MelinoeField_0193", Text = "This again..." },
		{ Cue = "/VO/MelinoeField_0194", Text = "He's trying to slow me down..." },
		{ Cue = "/VO/MelinoeField_0195", Text = "Is this really Asphodel...?" },
		-- { Cue = "/VO/MelinoeField_0196", Text = "This is Elysium..." },
	},
}
GlobalVoiceLines.AnomalyCombatBeginsVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.35,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		SuccessiveChanceToPlayAll = 0.5,

		{ Cue = "/VO/Intercom_0149", Text = "What witchery is this...?", PlayFirst = true },
		{ Cue = "/VO/Intercom_0130", Text = "So, you can see a pathway out..." },
		{ Cue = "/VO/Intercom_0131", Text = "But you just got here..." },
		{ Cue = "/VO/Intercom_0132", Text = "Do you really have to go so soon?" },
		{ Cue = "/VO/Intercom_0133", Text = "Why do you so wish to wake from such a beautiful dream?" },
		{ Cue = "/VO/Intercom_0134", Text = "Who taught you to perform such trickery?" },
		{ Cue = "/VO/Intercom_0135", Text = "You know something of Time and Dream, do you?" },
	},
}
GlobalVoiceLines.AnomalySurvivedVoiceLines =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.95,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },

		{ Cue = "/VO/Intercom_0150", Text = "You knew how to resist my little spell...", PlayFirst = true },
		{ Cue = "/VO/Intercom_0120", Text = "So what if you withstood all that..." },
		{ Cue = "/VO/Intercom_0121", Text = "Is this truly that which you are fighting for?" },
		{ Cue = "/VO/Intercom_0122", Text = "You survive, but you do not learn." },
		{ Cue = "/VO/Intercom_0123", Text = "That was, of course, a very different time." },
		{ Cue = "/VO/Intercom_0124", Text = "The times can change, but often stay the same." },
		{ Cue = "/VO/Intercom_0125", Text = "You wish your nightmares to become reality?" },
		{ Cue = "/VO/Intercom_0126", Text = "Continue at your peril, Granddaughter." },
		{ Cue = "/VO/Intercom_0127", Text = "Such nightmares shall consume you, in the end." },
		{ Cue = "/VO/Intercom_0128", Text = "Cease this whilst you have the opportunity." },
		{ Cue = "/VO/Intercom_0129", Text = "Even still you rush headlong toward oblivion." },
	},
}
GlobalVoiceLines.AnomalyConcludedVoiceLines =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "CurrentRoom", "Name" },
			IsNone = { "G_Story01" },
		},
	},
	{
		PlayOnce = true,
		PlayOnceContext = "MelReturnFromAnomalyVO",
		RandomRemaining = true,
		PreLineWait = 0.7,
		UsePlayerSource = true,
		--SuccessiveChanceToPlay = 0.5,

		{ Cue = "/VO/MelinoeField_0216", Text = "Made it back..." },
		{ Cue = "/VO/MelinoeField_0217", Text = "Like waking from a dream..." },
		{ Cue = "/VO/MelinoeField_0218", Text = "It'll take more than that, Chronos...", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_0219", Text = "Merely a vision..." },
		{ Cue = "/VO/MelinoeField_0220", Text = "Back to reality..." },
		{ Cue = "/VO/MelinoeField_1410", Text = "Just an illusion...!" },
	},
}

GlobalVoiceLines.ChronosHideAndSeekVoiceLines =
{
	{
		PlayOnce = true,
		PlayOnceContext = "ChronosFlashbackVO",
		UsePlayerSource = true,
		AllowTalkOverTextLines = true,
		{ Cue = "/VO/Chronos_1418", Text = "{#Emph}Ah-hah!" },
	},
	{
		ObjectType = "NPC_Melinoe_Story_01",
		AllowTalkOverTextLines = true,

		{ Cue = "/VO/MelinoeField_5055", Text = "{#Emph}Ah!" },
	}
}

GlobalVoiceLines.ChronosAlertVoiceLines =
{
	PreLineWait = 0.95,
	{
		RandomRemaining = true,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_LordHades_01", SubtitleColor = Color.HadesVoice },
		SuccessiveChanceToPlayAll = 0.5,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		GameStateRequirements =
		{
			{
				PathTrue = { "GameState", "ReachedTrueEnding" },
			},
		},

		{ Cue = "/VO/Intercom_7352", Text = "Who reconfigured Tartarus?! Oh, it is you, Daughter...!", PlayFirst = true },
		{ Cue = "/VO/Intercom_7353", Text = "These disrespecting Satyrs and such are all in for it now." },
		{ Cue = "/VO/Intercom_7354", Text = "Everything proceeds as planned." },
		{ Cue = "/VO/Intercom_7355", Text = "The Satyrs and their ilk yet remain dedicated to the Titan's cause." },
		{ Cue = "/VO/Intercom_7356", Text = "Daughter, you have full permission to ransack this place." },
		{ Cue = "/VO/Intercom_7357", Text = "Everything in the vicinity must go!" },
		{ Cue = "/VO/Intercom_7358", Text = "This blasted temporal decor can never stay destroyed!" },
		{ Cue = "/VO/Intercom_7359", Text = "We welcome you unto the lowest depths, Daughter." },
		{ Cue = "/VO/Intercom_7360", Text = "Permission granted to the Princess of the Underworld." },
		{ Cue = "/VO/Intercom_7361", Text = "Whatever it takes to ensure time flows freely from here on..." },
		{ Cue = "/VO/Intercom_7362", Text = "These wretches shall not welcome you, Daughter, but I shall." },
		{ Cue = "/VO/Intercom_7363", Text = "Hardly the first time violence broke out within Tartarus..." },
		{ Cue = "/VO/Intercom_7364", Text = "Your brother used to utterly destroy this place, so why not you?" },
		{ Cue = "/VO/Intercom_7365", Text = "I shall be having a word with Father about the extent of this incursion." },
		{ Cue = "/VO/Intercom_7366", Text = "Your contributions to our clean-up effort are appreciated, Daughter." },
		{ Cue = "/VO/Intercom_7367", Text = "We have not seen you here in quite some time, Daughter.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Intercom_7352" }
				},
				{
					SumPrevRuns = 6,
					IgnoreCurrentRun = true,
					Path = { "RoomsEntered", "I_Intro" },
					Comparison = "==",
					Value = 0,
				},
			}
		},
		{ Cue = "/VO/Intercom_7368", Text = "Where have you been, Melinoë? Not in the Underworld, that we know.",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Intercom_7352" }
				},
				{
					SumPrevRuns = 4,
					IgnoreCurrentRun = true,
					Path = { "BiomesReached", "N" },
					CountPathTrue = true,
					Comparison = ">=",
					Value = 3,
				},
			}
		},
		{ Cue = "/VO/Intercom_7369", Text = "So even these are remnant forces from the Titan, then?" },
		{ Cue = "/VO/Intercom_7370", Text = "Spare not a single wretch that dares to stand against you, Daughter." },
		{ Cue = "/VO/Intercom_7371", Text = "Proceed with caution, or whatever is the most efficient course." },
	},
	{
		RandomRemaining = true,
		NoTarget = true,
		Source = { LineHistoryName = "NPC_Chronos_01", SubtitleColor = Color.ChronosVoice },
		SuccessiveChanceToPlayAll = 0.5,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
		},

		{ Cue = "/VO/Intercom_0473", Text = "You are trespassing on private property...", PlayFirst = true },
		{ Cue = "/VO/Intercom_0151", Text = "Be very careful where you tread, my girl..." },
		{ Cue = "/VO/Intercom_0136", Text = "How interesting that you are able to resist..." },
		{ Cue = "/VO/Intercom_0475", Text = "An infiltrator breached through our defenses...!" },
		{ Cue = "/VO/Intercom_0476", Text = "We seem to have a bit of an infestation here..." },
		{ Cue = "/VO/Intercom_0477", Text = "It seems we have an unscheduled visitor..." },
		{ Cue = "/VO/Intercom_0478", Text = "My worshipers shall soften you up, if not stop you outright!" },
		{ Cue = "/VO/Intercom_0481", Text = "Perhaps we cannot find you in the Fields, but {#Emph}here?" },
		{ Cue = "/VO/Intercom_0483", Text = "{#Emph}Ah{#Prev}, Granddaughter! How kind of you to visit us again!" },
		{ Cue = "/VO/Intercom_0484", Text = "We bid you a warm welcome to the depths of Tartarus." },
		{ Cue = "/VO/Intercom_0485", Text = "Whatever brings you to my doorstep once again, my girl?" },
		{ Cue = "/VO/Intercom_0487", Text = "As predictable as the turning of the gears throughout this place..." },
		{ Cue = "/VO/Intercom_0488", Text = "Did you perhaps forget something when last you interfered?" },
		{ Cue = "/VO/Intercom_0490", Text = "Anybody sensible would {#Emph}flee {#Prev}from Tartarus, not {#Emph}barge {#Prev}right in!" },
		{ Cue = "/VO/Intercom_0491", Text = "This place was once my tomb; shall it be yours?" },
		{ Cue = "/VO/Intercom_0479", Text = "She has returned. Muster our defenses!",
			PlayFirst = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
				},
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 8,
				},
			},
		},
		{ Cue = "/VO/Intercom_0492", Text = "I shall be anticipating your arrival, Granddaughter.",
			GameStateRequirements =
			{
				{
					PathFalse = { "PrevRun", "EnemyKills", "Chronos" }
				},
				{
					Path = { "GameState", "RoomsEntered", "I_Boss01" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Intercom_0474", Text = "Why must everybody in our family be such an irritant?",
			GameStateRequirements =
			{
				{
					PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
				},
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Intercom_0480", Text = "Confound it, but you are a difficult one to pin down...",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "I_Boss01" },
					Comparison = ">=",
					Value = 5,
				},
			},
		},
		{ Cue = "/VO/Intercom_0482", Text = "Do tell Hades I said greetings if you happen to run into him!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "I_Story01" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},
		{ Cue = "/VO/Intercom_0486", Text = "We have not seen you in a little while, my girl.",
			GameStateRequirements =
			{
				{
					PathFalse = { "PrevRun", "RoomsEntered", "I_Intro" },
				},
			},
		},
		{ Cue = "/VO/Intercom_0489", Text = "She is heading for the House again. Stop her!",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "EnemyKills", "Chronos" },
					Comparison = ">=",
					Value = 3,
				},
			},
		},

	},
	{
		UsePlayerSource = true,
		RandomRemaining = true,
		SuccessiveChanceToPlay = 0.25,
		PreLineWait = 0.45,
		GameStateRequirements =
		{
			{
				PathFalse = { "GameState", "ReachedTrueEnding" },
			},
		},

		{ Cue = "/VO/MelinoeField_1538", Text = "No more hiding in shadows...!" },
		{ Cue = "/VO/MelinoeField_1539", Text = "Try and stop me...!" },
		{ Cue = "/VO/MelinoeField_1540", Text = "Out of my way!" },
		{ Cue = "/VO/MelinoeField_1541", Text = "I'm not finished with you!" },
		{ Cue = "/VO/MelinoeField_1542", Text = "I'll see you soon, Titan!" },
		{ Cue = "/VO/MelinoeField_1543", Text = "He hides behind these wretches!", PlayFirst = true },
	},

}
-- more in EnemyData_Chronos

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Chronos )