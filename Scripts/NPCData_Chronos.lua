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
		SubtitleColor = Color.ChronosVoice,
		RequiredRoomInteraction = true,

		ActivateRequirements =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "PrevRun", "SpawnRecord", "NPC_Chronos_01" },
				},
			},
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
		},

		DeathPresentationTextLineSets =
		{
			ChronosAnomalyIntro01 =
			{
				PlayOnce = true,
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0142", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Pray, who might you be, my girl? And what compelled you to wander in and out of Erebus?" },
				{ Cue = "/VO/Melinoe_0093", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not your girl, old man. My name and business are not your concern." },
				{ Cue = "/VO/Chronos_0143", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "So it seems. You appear to be quite pressed for time. Forgive this {#Emph}old man {#Prev}his transgressions..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 1.65,
						UsePlayerSource = true,
						-- { Cue = "/VO/MelinoeField_0243", Text = "...Can't be..." },
						{ Cue = "/VO/MelinoeField_0242", Text = "...Couldn't have been..." },
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,
				{ Cue = "/VO/Chronos_0144", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "You have returned. Or lost your way, perhaps, in those interminable passageways beyond." },
				{ Cue = "/VO/MelinoeField_0244", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know where I'm going. Whom do I address? And what are you doing here yourself, in such a place?" },
				{ Cue = "/VO/Chronos_0145", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,
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
					{
						PreLineWait = 0.35,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
						{ Cue = "/VO/Chronos_0020", Text = "The Fates cannot help you now..." },
					},
					{
						PreLineWait = 4,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
						{ Cue = "/VO/Chronos_0301", Text = "Time is running out..." },
					},
					{
						PreLineWait = 4,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
						{ Cue = "/VO/Chronos_0333", Text = "Embarrassing." },
					},
					{
						PreLineWait = 5,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
						{ Cue = "/VO/Chronos_0591", Text = "Then let us wait..." },
					},
				},
			},

			ChronosMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,
				{ Cue = "/VO/Chronos_0031",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "You, my girl, are meddling in matters you do not understand. Your father made certain choices; he was bound by them, but you are not. You need not follow in his ruinous path." },
				{ Cue = "/VO/Melinoe_0163", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Ruinous?! You {#Prev}brought ruin to the Underworld and the surface! I'll never accept what you've done. Now, enough talk!" },
				{ Cue = "/VO/Chronos_0032",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 2.0 },
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
						NoTarget = true,
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
					MinRunsSinceAnyTextLines = { TextLines = { "ChronosMeeting03" }, Count = 2 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0034",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Which rock did you crawl out from under, {#Emph}hm? {#Prev}My forces, they are terribly confused! They have no idea where you live! So I thought I would {#Emph}attempt {#Prev}asking you nicely here." },
				{ Cue = "/VO/Melinoe_0166", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I live in your nightmares, Titan. I thrive on them! I'll see you dead, and then destroyed. However long it takes." },
				{ Cue = "/VO/Chronos_0035",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
					MinRunsSinceAnyTextLines = { TextLines = { "ChronosMeeting04" }, Count = 2 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0077",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0157",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "I was beginning to think I had successfully dissuaded you, when it came to my attention you were trespassing some other place instead. You dared venture above?" },
				{ Cue = "/VO/MelinoeField_0494", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've seen your work up there firsthand. To have unsealed the very gates of hell! And brought disaster to mortals who've nothing to do with your petty vendetta." },
				{ Cue = "/VO/Chronos_0158",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
					MinRunsSinceAnyTextLines = { TextLines = { "ChronosPostSurfaceMeeting01" }, Count = 2 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0159",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "You cannot help the gods above, you know. My legions are vast, and death means little to them anymore. Not that your efforts here shall be of much consequence, either." },
				{ Cue = "/VO/MelinoeField_0496", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your surface legions fight and die for you, yet you hide behind them here. If you're so certain of your victory, you'd be leading them." },
				{ Cue = "/VO/Chronos_0160",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
			ChronosPostSurfaceMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
					MinRunsSinceAnyTextLines = { TextLines = { "ChronosPostSurfaceMeeting02" }, Count = 2 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0161",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "No victories upon the surface as of yet? It appears you have {#Emph}two {#Prev}hopeless goals, rather than one." },
				{ Cue = "/VO/MelinoeField_0498", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've only one, and hope has nothing to do with it. I may not be able to stop you yet, but neither can you stop me. You've tried." },
				{ Cue = "/VO/Chronos_0162",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChronosPostSurfaceMeeting03" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					--[[
					{
						SumPrevRuns = 3,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 2,
					},
					]]--
					{
						PathTrue = { "PrevRun", "RoomsEntered", "N_Boss01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ChronosPostSurfaceMeeting03" }, Count = 2 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0611",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "At last you have returned to more-familiar environs, girl. Neither the gods nor the Fates want you upon the surface of this world! Yet you insist on fighting there, for them." },
				{ Cue = "/VO/MelinoeField_2022", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I suppose I'll be more welcome in my father's home later this eve? As you can see I'm willing to fight there as well." },
				{ Cue = "/VO/Chronos_0612",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0210",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "I thought that I might find you here, my girl. Such fire in your eyes! How obstinate the members of our family can be. Have you learned nothing from our previous exchange?" },
				{ Cue = "/VO/MelinoeField_1400", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, I learned plenty, and I'm eager to learn more. So why don't you get out of my way, since there's nothing you can do within these woods but try to slow me down?" },
				{ Cue = "/VO/Chronos_0211",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0004",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "Little one, do not presume to think your movements are invisible to me! I see you plainly where you stand. A trespass for which you shall suffer, although, regrettably, not by my hand right now. Not yet." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosPostBattleMeeting03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0005",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "I am Time itself. What are you? A thrall of those calling themselves gods, mindlessly serving at their whim. My children are crafty... to them, you are nothing but a common tool! And not an especially sharp one, it appears to me." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosPostBattleMeeting04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					MinRunsSinceAnyTextLines = {
						TextLines = 
							{
								"ChronosPostBattleMeeting02",
								"ChronosPostBattleMeeting03",
								-- "ChronosPostBattleMeeting04",
							},
						Count = 3 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0006",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "If there is one thing on which the accursed Fates and I agree, it is that all eventually shall decay. All sprang from nothingness, and back into that Chaos we shall all return. You merely hurry it along." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

			ChronosPostWinStreakMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0613",
					Portrait = "Portrait_Chronos_Averted_01",
					Text = "Why, here comes our shadowy assassin on her nightly escapade to try and do me harm! Although perhaps the outcome shall not be so fortunate, this time." },
				{ Cue = "/VO/MelinoeField_2024", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We'll soon find out, won't we? I promise not to keep you waiting long. I'm well on my way already, as you can see." },
				{ Cue = "/VO/Chronos_0614",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
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
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					MinRunsSinceAnyTextLines = {
						TextLines = 
							{
								"ChronosMeeting05",
								-- "ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
						Count = 4 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0615",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "My dear son Zeus is already abetting you this night? I fear not his famous thunderbolt, young fool that he is." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutPoseidon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					MinRunsSinceAnyTextLines = {
						TextLines = 
							{
								"ChronosMeeting05",
								"ChronosMeetingAboutZeus01",
								-- "ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
						Count = 4 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0616",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "{#Emph}Ah{#Prev}, so Poseidon gave to you his blessing, has he now? What are you going to do... pour water on me?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutHestia01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HestiaUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					MinRunsSinceAnyTextLines = {
						TextLines = 
							{
								"ChronosMeeting05",
								"ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								-- "ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
						Count = 4 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0619",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "The goddess of the hearth has blessed you now? There is no flame which {#Emph}Time {#Prev}cannot extinguish soon enough." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutDemeter01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					MinRunsSinceAnyTextLines = {
						TextLines = 
							{
								"ChronosMeeting05",
								"ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								-- "ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
						Count = 4 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0617",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "The frosty goddess Demeter is urging you along this eve? Alas, there are no {#Emph}seasons {#Prev}in the Underworld." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutHera01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosMeeting05" },
					},
					MinRunsSinceAnyTextLines = {
						TextLines = 
							{
								"ChronosMeeting05",
								"ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								-- "ChronosMeetingAboutHera01",
							},
						Count = 4 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0618",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "The self-made Queen of the Gods, bestowing you her Boon? Is there not some mortal wedding she ought to officiate?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},
			ChronosMeetingAboutOlympians01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" },
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
					MinRunsSinceAnyTextLines = {
						TextLines = 
							{
								"ChronosMeetingAboutZeus01",
								"ChronosMeetingAboutPoseidon01",
								"ChronosMeetingAboutHestia01",
								"ChronosMeetingAboutDemeter01",
								"ChronosMeetingAboutHera01",
							},
						Count = 4 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosGreeting,

				{ Cue = "/VO/Chronos_0620",
					Portrait = "Portrait_Chronos_Averted_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.35 },
					Text = "Try all you like, my girl; but the outcome of this night shall be no different from the last." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Chronos",
			},

		},

		-- see ChronosOnHitConversationRequirements =
		OnHitFunctionName = "DoChronosOnHitConversation",
		OnHitTextLinePriorities =
		{
			"ChronosReveal01B",
			"ChronosRevealFollowUp",
		},
		UseBossHealthBar = true,
		MaxHealth = 99999,
		HealthBarTextId = "Chronos_Full",
		OnHitTextLineSets =
		{
			ChronosReveal01B =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
					{
						PreLineWait = 0.35,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
						{ Cue = "/VO/Chronos_0020", Text = "The Fates cannot help you now..." },
					},
					{
						PreLineWait = 4,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
						{ Cue = "/VO/Chronos_0301", Text = "Time is running out..." },
					},
					{
						PreLineWait = 4,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
						{ Cue = "/VO/Chronos_0333", Text = "Embarrassing." },
					},
					{
						PreLineWait = 5,
						PreLineAnim = "Enemy_Chronos_Shadowed_Greeting",
						{ Cue = "/VO/Chronos_0591", Text = "Then let us wait..." },
					},
				},
			},

			ChronosRevealFollowUp =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
					Text = "{#Emph}Oh{#Prev}, stop. 'Tis a pity that this granddaughter of mine is both a weakling and a fool, though an elusive one. I ought to thank the Fates that we have met at last." },
				{ Cue = "/VO/Melinoe_0095", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					Text = "The Fates had nothing to do with this. You took my family." },
				{ Cue = "/VO/Chronos_0076",
					PreLineThreadedFunctionName = "StopSecretMusic",
					PreLineThreadedFunctionArgs = { true },
					Portrait = "Portrait_Chronos_Pained_01",
					PostLineThreadedFunctionName = "ChronosExit", PostLineFunctionArgs = { AnimationState = "NPCChronosExited", WaitTime = 0.3, },
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
					{ Name = "ChronosSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Chronos_0153", Text = "Temper!", PlayFirst = true, },
				{ Cue = "/VO/Chronos_0154", Text = "The {#Emph}nerve!" },
			},

			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Chronos_01",
				GameStateRequirements =
				{
					RequiredAnyQueuedTextLines =
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
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Chronos_0014", Text = "I think not.",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Chronos_0094", Text = "Oh, please...",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Chronos_0095", Text = "That shall not work.",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Chronos_0096", Text = "You waste your time.",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Chronos_0097", Text = "Such youthful arrogance.",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Chronos_0098", Text = "I can wait...",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Chronos_0099", Text = "Your wrath is all for naught.",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Chronos_0153", Text = "{#Emph}Temper!",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Chronos_0154", Text = "The {#Emph}nerve!",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
				{ Cue = "/VO/Intercom_0023", Text = "{#Emph}<Laughter>",
					PostLineFunctionName = "ChronosExit",
					PostLineFunctionArgs = { AnimationState = "NPCChronosExited" },
				},
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
						HasAny = { "ChronosReveal01", "ChronosReveal01B" },
					},
				},
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 12 },
				},

				{ Cue = "/VO/Chronos_0528", Text = "Hah!", PlayFirst = true, },
				{ Cue = "/VO/Chronos_0014", Text = "I think not." },
				{ Cue = "/VO/Chronos_0094", Text = "Oh, please..." },
				{ Cue = "/VO/Chronos_0095", Text = "That shall not work." },
				{ Cue = "/VO/Chronos_0096", Text = "You waste your time." },
				{ Cue = "/VO/Chronos_0097", Text = "Such youthful arrogance." },
				{ Cue = "/VO/Chronos_0098", Text = "I can wait..." },
				{ Cue = "/VO/Chronos_0099", Text = "Your wrath is all for naught." },
				{ Cue = "/VO/Chronos_0153", Text = "{#Emph}Temper!",
					GameStateRequirements =
					{
						MinRunsSinceAnyTextLines = { TextLines = { "ChronosRevealFollowUp" }, Count = 5 },
					},
				},
				{ Cue = "/VO/Chronos_0154", Text = "The {#Emph}nerve!",
					GameStateRequirements =
					{
						MinRunsSinceAnyTextLines = { TextLines = { "ChronosRevealFollowUp" }, Count = 5 },
					},
				},
			},
		},
		ChronosOnHitConversationRequirements =
		{
			{
				PathTrue = { "GameState", "EncountersOccurredCache", "GeneratedAnomalyB" },
			},
			{
				PathFalse = { "GameState", "TextLinesRecord", "ChronosRevealFollowUp" },
			},
		},
	},
	NPC_Chronos_Story_01 =
	{
		InheritFrom = { "NPC_Chronos_01" },

		ActivateRequirements =
		{
			GameStateRequirements =
			{
				{
					PathFalse = { "GameState", "TextLinesRecord", "ChronosFirstMeeting" },
				},
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
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
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
					Speaker = "NPC_LordHades_01",
					PreLineWait = 0.35,
					Text = "Greetings, Father. I... was not expecting your arrival. You... must forgive us that the House was unprepared for guests. To what do we owe the pleasure of your company?" },

				{ Cue = "/VO/Chronos_0057",
					Text = "Oh, you know, for one thing, I was in the area! You might recall the time you, Zeus, and the rest of you little brats cut me to ribbons? Sprinkled all my bits, all throughout Tartarus?" },

				{ Cue = "/VO/Hades_0004",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01",
					PreLineWait = 0.5,
					Text = "Father... that was a war {#Emph}you {#Prev}started, and you know it! We took no joy in what we had to do! But how can this be? I thought that you were gone...!" },

				{ Cue = "/VO/Chronos_0058",
					Text = "Do not sound so disappointed! It is {#Emph}I {#Prev}who should be disappointed here, not {#Emph}you. {#Prev}You thought I was gone? I was! But it turns out spite is a powerful motivator. Blood sacrifices also helped." },

				{ Cue = "/VO/Hades_0021",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01",
					Text = "What do you intend to do? And... what have you done to the others? To my family?!" },

				{ Cue = "/VO/Chronos_0059",
					Text = "Your cries fall on deaf ears. Fear not, my son. I have not {#Emph}eaten {#Prev}them or anything. I have merely... set them aside. They stand imprisoned in a moment that shall never pass. My qualm is not with {#Emph}them." },

				{ Cue = "/VO/Hades_0022",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01",
					PreLineWait = 0.35,
					Text = "...Olympus shall have your head. You can take {#Emph}mine{#Prev}, for all I care, {#Emph}blast you! {#Prev}But don't you {#Emph}dare {#Prev}harm anybody in my House." },

				{ Cue = "/VO/Chronos_0071",
					Text = "{#Emph}Tsk! {#Prev}You have grown so accustomed to issuing commands that you forget yourself. Though, I do have such a command for {#Emph}you: {#Prev}Tell me, exactly, where the Fates reside." },

				{ Cue = "/VO/Hades_0023",
					Portrait = "Portrait_Hades_Past_01",
					PortraitExitAnimation = "Portrait_Hades_Past_01_Exit",
					Speaker = "NPC_LordHades_01",
					PostLineFunctionName = "ConcludeFlashback",
					Text = "The {#Emph}Fates? {#Prev}How should {#Emph}I {#Prev}know? Not even Nyx herself knows where her daughters are! Why are you... asking {#Emph}me...?" },

				--[[
				{ Cue = "/VO/Chronos_0072",
					Text = "Help me, Hades. For if I cannot locate Nyx's daughters, I shall have to locate yours. The little one, what was her name, again?" },

				{ Cue = "/VO/Hades_0024", Portrait = "Portrait_Hades_Past_01", Speaker = "NPC_LordHades_01",
					PreLineWait = 0.5,
					PostLineFunctionName = "ConcludeFlashback",
					-- Emote = "PortraitEmoteFiredUp",	
					Text = "...Melinoë. You stay away from her..." },
				]]--

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ChronosNightmareGreeting,
			},
		},

	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Chronos )