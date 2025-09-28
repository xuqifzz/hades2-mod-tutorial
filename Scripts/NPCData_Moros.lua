UnitSetData.NPC_Moros =
{
	-- Moros, Id = 560612
	NPC_Moros_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		UseText = "NPCUseTextTalk",
		Portrait = "Portrait_Moros_Default_01",
		AnimOffsetZ = 25,
		Groups = { "NPCs" },
		SubtitleColor = Color.MorosVoice,
		EmoteOffsetY = -300,
		EmoteOffsetX = 70,
		SpeakerName = "Moros",
		LoadPackages = { "Moros" },
		TurnInPlaceAnimation = "Moros_Turn",
		TurnInPlaceAngleMin = 90,
		PreEventFunctionName = "AngleNPCToHero",
		ActivateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "WorldUpgradesRevealed", "TorchAutofireAspect" },
			},
			NamedRequirements = { "MorosUnlockedInHub" },
		},

		PreBathAnimationName = "Moros_Greet",
		BecomingCloserFunctionName = "BecomingCloserMorosPresentation",
		SpecialInteractFunctionName = "SpecialInteractSaluteInterrupt",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				PlayOnceThisRun = true,
				-- RandomRemaining = true,
				SuccessiveChanceToPlay = 0.2,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/Melinoe_1879", Text = "Peace, Lord Moros." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.3,
				ObjectType = "NPC_Moros_01",
				PreLineAnim = "Moros_Greet",

				{ Cue = "/VO/Moros_0198", Text = "Salutations, Princess.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Moros_0199", Text = "To you as well!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2", "/VO/Melinoe_1879" },
						},
					},
				},
				{ Cue = "/VO/Moros_0200", Text = "So it is Fated.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Moros_0201", Text = "Such is his Doom.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Moros_0202", Text = "Thank you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Moros_0203", Text = "Night protect you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2", "/VO/Melinoe_1879" },
						},
					},
				},
				{ Cue = "/VO/Moros_0204", Text = "I appreciate it.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Moros_0205", Text = "And Night protect us.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704_2", "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
				{ Cue = "/VO/Moros_0206", Text = "Indeed.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705_2" },
						},
					},
				},
				{ Cue = "/VO/Moros_0090", Text = "To your success.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Moros_0090_B" }
						},
					},
				},
				{ Cue = "/VO/Moros_0091", Text = "To victory.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Moros_0091_B" }
						},
					},
				},
				{ Cue = "/VO/Moros_0207", Text = "Proceed with care." },
				{ Cue = "/VO/Moros_0087", Text = "Fates protect you." },
			},
		},

		EntranceVoiceLines =
		{
			{
				PlayOnce = true,
				PreLineWait = 0.7,
				UsePlayerSource = true,
				GameStateRequirements = 
				{
					NamedRequirements = { "FatesDiscovered" }
				},

				{ Cue = "/VO/MelinoeField_4072", Text = "This feeling... hello...? Lord Moros, is that you...? {#Emph}<Gasp>" },

				{ Cue = "/VO/Moros_1001", Text = "All right, all right, all right, we're {#Emph}here{#Prev}, we're here...",
					BreakIfPlayed = true,
					PreLineFunctionName = "FatesEntranceSFX",
					Source = { LineHistoryName = "NPC_Unnamed_01", SubtitleColor = Color.FatesVoice },
				},
			},
			{
				PlayOnce = true,
				PlayOnceContext = "MorosBecomingCloserIntroVO",
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosTaverna02" },
					},
					NamedRequirementsFalse = { "TrueEndingCriticalPathEventOccurred" },
				},

				{ Cue = "/VO/Moros_0404", Text = "Forgive me, Princess..." },
			},
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				GameStateRequirements = 
				{
					NamedRequirementsFalse = { "FatesDiscovered" }
				},

				{ Cue = "/VO/Moros_0127", Text = "Found you at last.",
					GameStateRequirements =
					{
						{
							PathFalse = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog" },
						},
					},
				},
				{ Cue = "/VO/Moros_0131", Text = "I heed your call once more.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "MorosGrantsQuestLog" },
						},
					},
				},
				{ Cue = "/VO/Moros_0296", Text = "Just a moment...!",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = { "SurfacePenalty" },
						},
					},
				},
				--[[
				{ Cue = "/VO/Moros_0096", Text = "Princess!",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "Hero", "TraitDictionary" },
							HasAny = { "SurfacePenalty" },
						},
					},
				},
				]]--
			},
		},

		DeathPresentationTextLineSets =
		{
			MorosGrantsQuestLog =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeQuestLog", },
					},
					NamedRequirementsFalse = { "TrueEndingCriticalPathEventOccurred" },
				},
				SkipContextArt = true,

				{ Cue = "/VO/Moros_0128", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					PreLineWait = 1.0,
					-- PreLineFunctionName = "DoomContextArtPresentation",
					Text = "Princess of the Underworld: I regret having to contact you at such a time. It's not my custom to intervene during moments of Doom, only to observe." },
				{ Cue = "/VO/Melinoe_1582", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "{#Emph}Moments of Doom.... {#Prev}You're Lord Moros, emissary of the Three Fates! So your sisters heard me after all!" },
				{ Cue = "/VO/Moros_0129",
					Text = "They expected me to find you, for there's something they intend for you to have. Wherever you're going, look for it when you arrive. I'm uncertain if we'll meet again; farewell.",
					PostLineThreadedFunctionName = "HideDoomContextArtPresentation" },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "ThingUnlocked", Text = "QuestLog_Unlocked_Subtitle" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",

						{ Cue = "/VO/Moros_0130", Text = "It's been an honor..." },
					},
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1583", Text = "Wait...!" },
					},
				},
			},

			MorosSecondAppearance =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					NamedRequirementsFalse = { "TrueEndingCriticalPathEventOccurred" },
				},
				SkipContextArt = true,

				{ Cue = "/VO/Moros_0132",
					PreLineWait = 1.0,
					-- PreLineFunctionName = "DoomContextArtPresentation",
					Text = "Again our journeys intertwine. Why did you call upon me, Princess? Did you not receive the artifact I brought you from the Fates?" },
				{ Cue = "/VO/MelinoeField_1694", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Lord Moros...! I did receive the Fated List, and summoned you once more as it ordained. All children of Nyx are welcome where I reside. Might we speak further there...? I've many questions." },
				{ Cue = "/VO/Moros_0133",
					-- PreLineAnim = "Moros_Salute",
					Text = "I don't know whether I can answer them, as my own search for truth has not been going well of late. But I'll not decline your cordial invitation. Please lead the way.",
					PostLineThreadedFunctionName = "HideDoomContextArtPresentation" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1588", Text = "Then follow me." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",

						{ Cue = "/VO/Moros_0134", Text = "I shall." },
					},
				},
			},

			MorosGrantsSurfacePenaltyCure01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "MorosFirstSurfaceAppearance" },
				},
				SkipContextArt = true,

				{ Cue = "/VO/Moros_0297",
					PreLineWait = 1.0,
					-- PreLineFunctionName = "DoomContextArtPresentation",
					Text = "...You traveled to the surface. Knowing full well the Fates decided long ago that those of your line could not survive there, and would always be forced back to the Underworld." },
				{ Cue = "/VO/MelinoeField_0812", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Their curse was... palpable. I never intended to stay for long. Just long enough to lend my relatives support. But it seems your sisters insist that I do no such thing." },
				{ Cue = "/VO/Moros_0298",
					Text = "Well... I don't see them around right now, do you? Incidentally, there once was an incantation that I happened upon, which was not intended for my eyes. But I now choose to think that it was intended for yours.",
					PostLineThreadedFunctionName = "HideDoomContextArtPresentation" },
				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { Duration = 2, Title = "WorldUpgradeAdded", Text = "SurfacePenaltyCure_Subtitle" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",

						{ Cue = "/VO/Moros_0185", Text = "Farewell!" },
					},
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_0813", Text = "{#Emph}Unraveling a Fateful Bond..." },
					},
				},
			},

			-- relationship
			MorosBecomingCloser01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipContextArt = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosTaverna02" },
					},
					-- sorry, no...
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "CirceShrinkTrait", "CirceEnlargeTrait" },
					},
					NamedRequirements = { "NoRecentBecomingCloserEvent" },
					NamedRequirementsFalse = { "StandardPackageBountyActive", "FatesDiscovered", "FatesDiscoveredTooSoon", "NearTrueEnding" },
					--[[
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					]]--
				},

				{ Cue = "/VO/Moros_0405",
					PreLineWait = 1.0,
					-- PreLineFunctionName = "DoomContextArtPresentation",
					Text = "I apologize for the abruptness of my approach. My mind... told me not to appear before you without good cause, but my heart demanded otherwise. Is this... not a good time?" },

				{ Cue = "/VO/MelinoeField_3730_B", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Empathetic_01",
					Text = "Oh, you know, Lord Moros, I... was just in the middle of evading my latest brush with death. Why are you here? {#Emph}<Scoff> {#Prev}I must look like hell..." },

				{ Cue = "/VO/Moros_0406",
					Text = "No, you look... well, I am truly at a loss for words... I should have rehearsed what I sought to say more thoroughly." },

				{ Cue = "/VO/MelinoeField_3731", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Casual_01",
					Text = "You don't need to be so nervous around me, or so formal for that matter. And it's nice to see you here as well, in one of my many moments of wretched failure. How long can we stay here, anyway? It's so peaceful..." },

				{ Cue = "/VO/Moros_0407",
					Portrait = "Portrait_Moros_Pleased_01",
					SecretMusic = "/Music/NarcissusTheme",
					PreLineWait = 0.5,
					Text = "We can stay for... I don't exactly know. A while, that to others shall seem merely an instant, so... I sought to see you here again, in the off chance... you sought to see me...?" },

				EndVoiceLines =
				{
					{
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesChoiceRecord", "MorosBecomingCloser01", },
								IsAny = { "Choice_MorosDecline" },
							},
						},
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							{ Cue = "/VO/MelinoeField_3734", Text = "Farewell..." },
						},
					},
					{
						PreLineWait = 1.5,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesChoiceRecord", "MorosBecomingCloser01", },
								IsAny = { "Choice_MorosAccept" },
							},
						},
						{
							PreLineWait = 0.4,
							UsePlayerSource = true,
							{ Cue = "/VO/MelinoeField_3738", Text = "{#Emph}<Sigh> {#Prev}Return to shadow, now..." },
						},
					},
				},
				{
					Text = "Choice_MorosBecomingCloser01",
					Portrait = "Portrait_Moros_Pleased_01",
					IgnoreRawText = true,
					BoxAnimation = "NarrationBubbleRomance",
					BoxExitAnimation = "NarrationBubbleRomanceOut",
					DisableCharacterFadeColorLag = true,
					IsNarration = true,
					SkipContextArt = true,
					IgnoreContinueArrow = true,
					TextOffsetY = 0,
					PreContentSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					Choices =
					{
						{
							ChoiceText = "Choice_MorosDecline",
							{ Cue = "/VO/MelinoeField_3732",
								SkipContextArt = true,
								UsePlayerSource = true,
								PreLineWait = 1.0,
								Portrait = "Portrait_Mel_Vulnerable_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "It is the height of flattery that you would feel this way, Lord Moros. But... in listening to my own heart once again... it's not my wish to risk or change what we already have. I know you must be disappointed, but I hope you understand." },

							{ Cue = "/VO/Moros_0408",
								SkipContextArt = true,
								PreLineWait = 0.5,
								Portrait = "Portrait_Moros_Pleased_01",
								Text = "No, not disappointed in the least, Princess. And I do understand. Forgive me, once again, this outburst of feeling... I don't wish to pretend I never asked, but... may we perhaps still carry on as close acquaintances?" },

							{ Cue = "/VO/MelinoeField_3733",
								Portrait = "Portrait_Mel_Empathetic_01",
								SkipContextArt = true,
								UsePlayerSource = true,
								PreLineWait = 0.35,
								Text = "If it were any other way, I'd never forgive myself, nor you." },

							{ Cue = "/VO/Moros_0409",
								SkipContextArt = true,
								Portrait = "Portrait_Moros_Pleased_01",
								Text = "{#Emph}Hah! {#Prev}Well then, may you recover as swiftly as ever, and I shall see you shortly on the other side. Farewell for now.",
								PostLineThreadedFunctionName = "HideDoomContextArtPresentation" },
						},
						{
							ChoiceText = "Choice_MorosAccept",
							{ Cue = "/VO/MelinoeField_3735",
								SkipContextArt = true,
								UsePlayerSource = true,
								PreLineWait = 1.0,
								Portrait = "Portrait_Mel_Proud_01",
								PortraitExitAnimation = "Portrait_Mel_Proud_01_Exit",
								PostLineFunctionName = "BecomingCloserPresentation",
								PostLineFunctionArgs = { SkipFadeOut = true, SkipTimePassage = true, Text= "BedroomIntermissionMessageAlt", TitleTextOffetX = 101, Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", Partner = "Moros", TimeTicks = 10, ExtraWaitTime = 0.25 },

								Text = "...Chance has nothing to do with it, Lord Moros. Most nights I have a brush with death, but not with you. I {#Emph}have {#Prev}wanted this, yes." },

							-- INTERMISSION PRESENTATION

							{ Cue = "/VO/MelinoeField_3736", 
								SkipContextArt = true,
								UsePlayerSource = true,
								Portrait = "Portrait_Mel_EmpatheticFlushed_01",
								Text = "...Lord Moros, are... are you certain this shall only seem an instant by the time we return? Because..." },

							{ Cue = "/VO/Moros_0411",
								SkipContextArt = true,
								Portrait = "Portrait_Moros_Flushed_01",
								EndSecretMusic = true,

								Text = "You have my word. As for your own sense of time, {#Emph}that {#Prev}I cannot change. So, as much as I would like remaining here with you eternally... we should probably be getting back." },

							{ Cue = "/VO/Melinoe_4158", 
								SkipContextArt = true,
								UsePlayerSource = true,
								Portrait = "Portrait_Mel_EmpatheticFlushed_01",

								-- no time passes at all...
								-- PostLineThreadedFunctionName = "InCombatTextEvent",
								-- PostLineThreadedFunctionArgs = GameData.PostIntermissionArgs,

								Text = "You're probably right.", PostLineThreadedFunctionName = "HideDoomContextArtPresentation" },
							--[[
							{ Cue = "",
								SkipContextArt = true,
								Portrait = "Portrait_Moros_Pleased_01",
								Text = "Probably... but, my heart says we can stay a little longer. And my mind has no coherent arguments to the contrary." },

							{ Cue = "/VO/Moros_0412",
								UsePlayerSource = true,
								Text = "On that you'll hear no arguments from me either." },
							]]--
						},
					},
				},
			},

			-- @ ending
			-- beware, you who read on from this point. we know all that is to come. do you think that power ought to be yours as well? how well can you weave?
			FatesEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "FatesDiscovered" },
				},
				SkipContextArt = true,

				{ Cue = "/VO/Moros_1002",
					-- PreLineFunctionName = "DoomContextArtPresentation",
					StartSound = "/Leftovers/Menu Sounds/EmoteAscendedNergal",
					PreLineWait = 2.0,
					Portrait = "Portrait_Fates_02",
					Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Text = "Well, whaddaya know, we got ourselves a visitor, ladies! Who woulda thought? You found us, sweetie! You get, I don't know, three questions? Three of us, three questions, sounds reasonable, right?" },

				{ Cue = "/VO/MelinoeField_4073", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "You're... you're the Fates, you're... really here! Are you safe, in any distress? Your brother Lord Moros, he's searched everywhere for you, and not just him!" },

				{ Cue = "/VO/Moros_1003",
					Portrait = "Portrait_Fates_02",
					Speaker = "NPC_Fates_01",
					PortraitExitAnimation = "Portrait_Fates_02_NoEnter_Exit",
					Text = "{#Emph}Are you safe, in any distress? Whew! {#Prev}What do you think, ladies, we count that as {#Emph}one {#Prev}question or {#Emph}two? {#Prev}I say go easy on her, seems like a nice girl. {#Emph}Count it just as one, OK?" },

				{ Cue = "/VO/Moros_1004_C",
					Portrait = "Portrait_Fates_03_NoEnter",
					Speaker = "NPC_Fates_02",
					PortraitExitAnimation = "Portrait_Fates_03_NoEnter_Exit",
					Text = "Oh yeah, nice girl, you're right, count it as one! {#Emph}OK!" },

				{ Cue = "/VO/Moros_1006",
					Portrait = "Portrait_Fates_02_NoEnter",
					Speaker = "NPC_Fates_01",
					PortraitExitAnimation = "Portrait_Fates_02_Exit",
					Text = "{#Emph}OK! {#Prev}We're {#Emph}fine{#Prev}, sweetie, least {#Emph}now {#Prev}we are! Your grandpa got us, yeah, we were a little miffed, you know? Cause we'd been {#Emph}weaving{#Prev}, and {#Emph}weaving{#Prev}, and {#Emph}weaving{#Prev}, so then we figured: What's a better time to take a break?" },

				{ Cue = "/VO/MelinoeField_4074", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "{#Emph}Take a break... {#Prev}shouldn't you have sent word to Lord Moros, much less anybody else? He's been very concerned!" },

				{ Cue = "/VO/Moros_1007",
					Portrait = "Portrait_Fates_02",
					Speaker = "NPC_Fates_01",
					Text = "That's question {#Emph}two! {#Prev}We {#Emph}did {#Prev}send word, that's why {#Emph}you're {#Prev}here! Moros, he's a {#Emph}real {#Prev}sweetheart. We figured he could use a little alone time... OK, last question!" },

				{ Cue = "/VO/MelinoeField_4075", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Last question, I... what do you all intend to do, now that Chronos no longer seems to be a threat? How do we prevent something like this from happening again?" },

				{ Cue = "/VO/Moros_1008",
					Portrait = "Portrait_Fates_02",
					Speaker = "NPC_Fates_01",
					Text = "OK now {#Emph}that {#Prev}I'm counting as {#Emph}two {#Prev}questions so I'm only gonna give you the first one, or maybe it was the second, I'm getting mixed up, point is: {#Emph}We're not gonna do a thing...! {#Prev}This has been nice." },

				{ Cue = "/VO/MelinoeField_4076", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Not going to do a thing, and I'm unable to ask further questions, so... perhaps you're going to elaborate..." },

				{ Cue = "/VO/Moros_1011",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Fates_02",
					Speaker = "NPC_Fates_01",
					PortraitExitAnimation = "Portrait_Fates_02_NoEnter_Exit",
					Text = "Hey, who knows what's gonna happen, you or me? Look, all you gods, you got yourselves into this. I know, {#Emph}I know{#Prev}, you think it's 'cause of us, well, we don't {#Emph}like {#Prev}that kind of pressure! And you've been doing OK on your own, so..." },

				{ Cue = "/VO/Moros_1012_C",
					Portrait = "Portrait_Fates_03_NoEnter",
					Speaker = "NPC_Fates_02",
					PortraitExitAnimation = "Portrait_Fates_03_NoEnter_Exit",
					Text = "Yeah you've been doing OK, {#Emph}haha! {#Prev}So we are gonna let ya {#Emph}keep this up!" },

				{ Cue = "/VO/Moros_1014",
					Portrait = "Portrait_Fates_02_NoEnter",
					Speaker = "NPC_Fates_01",
					PortraitExitAnimation = "Portrait_Fates_02_Exit",
					Text = "We're gonna let you keep this up. And once you've had your fill, being without us for a while, you're gonna hand it over to mortals. Just like {#Emph}we're {#Prev}handing it over to {#Emph}you!" },

				{ Cue = "/VO/MelinoeField_4077", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Hand {#Emph}what {#Prev}over to mortals... which is to say... I don't know how I can respond to that without another question." },

				{ Cue = "/VO/Moros_1015",
					Portrait = "Portrait_Fates_02",
					Speaker = "NPC_Fates_01",
					Text = "{#Emph}That's {#Prev}all right, sweetie! Think of it like, {#Emph}uh... {#Prev}you gods can do your {#Emph}own {#Prev}thing for a while, then mortals can do {#Emph}theirs! {#Prev}It'll be a brand new age! Been a while since the last one of {#Emph}those." },

				{ Cue = "/VO/MelinoeField_4078", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "So you're retiring... all three of you. No more weavings... we're to keep fending for ourselves, come what may." },

				{ Cue = "/VO/Moros_1016",
					Portrait = "Portrait_Fates_02",
					Speaker = "NPC_Fates_01",
					Emote = "PortraitEmoteSparkly",
					PortraitExitAnimation = "Portrait_Fates_02_NoEnter_Exit",
					Text = "Oh {#Emph}come on{#Prev}, don't make it sound like such a big deal! Not like you're gonna do anything different anyway. But you {#Emph}could! {#Prev}Just ask your old teacher sometime. Now {#Emph}she's {#Prev}pulled some strings, let me tell {#Emph}you!" },

				{ Cue = "/VO/Moros_1017_C",
					Portrait = "Portrait_Fates_03_NoEnter",
					Speaker = "NPC_Fates_02",
					PortraitExitAnimation = "Portrait_Fates_03_Exit",
					Text = "{#Emph}Oh {#Prev}yeah Teach has {#Emph}definitely {#Prev}pulled some strings all right, {#Emph}huhuh!" },

				{ Cue = "/VO/MelinoeField_4079", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "You mean Headmistress. So you're saying... I don't know what you're saying, but I'll ask. As you well know, I couldn't have done any of this without her." },

				{ Cue = "/VO/Moros_1018_C",
					Portrait = "Portrait_Fates_04",
					Speaker = "NPC_Fates_03",
					PortraitExitAnimation = "Portrait_Fates_04_NoEnter_Exit",
					Text = "{#Emph}Guuuhhhhh, ngghhh..." },

				{ Cue = "/VO/Moros_1019",
					Portrait = "Portrait_Fates_02_NoEnter",
					Speaker = "NPC_Fates_01",
					EndSound = "/Leftovers/Menu Sounds/EmoteAscendedNergal",
					PostLineThreadedFunctionName = "HideDoomContextArtPresentation",
					PortraitExitAnimation = "Portrait_Fates_02_Exit",
					Text = "Ohh, {#Emph}yeah{#Prev}, we know. Well anyway, sweetie, we're gonna cut ya loose, as we've got other things to do! But {#Emph}not {#Prev}weaving! {#Emph}Not for the foreseeable future{#Prev}, as they say, {#Emph}heh. {#Prev}So nice to finally meet ya. {#Emph}Bye!" },

				EndFunctionName = "PostEpiloguePresentation",
				EndFunctionArgs = { Title = "EpilogueReached", Stinger = "/Music/IrisVictoryStingerSMALL" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						UsePlayerSource = true,

						{ Cue = "/VO/MelinoeField_4080", Text = "{#Emph}Erm{#Prev}, bye...! And, thank you all!" },
					},
				},
			},
			-- goes to Outro_Epilogue01 =
		},

		InteractTextLineSets =
		{
			MorosFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "MorosUnlockedInHub" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				--[[
				{ Cue = "/VO/Moros_0135",
					-- Portrait = "Portrait_Moros_Pleased_01",

					-- PreLineAnim = "Moros_Perplexed_Start",
					-- PostLineAnim = "Moros_Perplexed_End",
					-- PreLineAnim = "Moros_Pensive_Start",
					-- PostLineAnim = "Moros_Pensive_End",
					-- PreLineAnim = "Moros_Greet", -- bow
					-- PreLineAnim = "Moros_Salute", -- hand wave
					-- PreLineAnim = "Moros_Considers",
					-- PreLineAnim = "Moros_Attention",
					Text = "Princess! We've not met formally. I'm the Official Bearer of Bad News. The Witch of the Crossroads apprised me of the situation here, and... was gracious to invite me to stay for now." },
				]]--
				{ Cue = "/VO/Moros_0703",
					Text = "Princess, we've not met formally. I'm called Moros, Doom, or the official Bearer of Bad News. The Witch of the Crossroads apprised me of the situation here, and was gracious to invite me to stay for now." },
				{ Cue = "/VO/Melinoe_1589", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're welcome here and safe, Lord Moros. So then, you know of my task." },
				{ Cue = "/VO/Moros_0136",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "To vanquish the usurper of the House of Hades seems more than a task. I regret this burden is yours to bear, and much sooner than expected." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/Melinoe_0872", Text = "It's all right. I was born for this." },
					},
				},
			},

			MorosAboutReturning01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutFates02" },
					},
					{
						Path = { "CurrentRun" },
						HasNone = { "Cleared", "BountyCleared" }
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0145",
					Text = "Are you all right, Princess? I'm realizing that whenever you return, it's likely due to some unfortunate result. One I might have easily anticipated in the past, but not anymore..." },

				{ Cue = "/VO/Melinoe_2057", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm fine, Lord Moros, thank you for asking. I'm fairly accustomed to such outcomes at this point. It's interesting to know the Fates are not forcing it along... that it's all in my control. And all my fault." },

				{ Cue = "/VO/Moros_0146",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Well... now that you mention it, I can't entirely be sure the Fates have no more influence at all. How frustrating, not knowing whether our actions have been preordained or not..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2058", Text = "I try not to think on it too much." },
					},
				},
			},

			MorosAboutSearch01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_1803", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You must know what I'm about to ask, Lord Moros... especially since I promised many questions. You mentioned you were on a fruitless search. What was it that you sought?" },
				{ Cue = "/VO/Moros_0138",
					PreLineAnim = "Moros_Attention",
					Text = "Oh! Well, the Fates do like to send me off to fetch them this or that, now and again. My search in some respects was similar. Though, I'm beginning to think they tricked me..." },
				{ Cue = "/VO/Melinoe_1804", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They sent you to find something that couldn't be found... and you can't just tell me what it is, can you." },
				{ Cue = "/VO/Moros_0139",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I think they simply wanted me out of the way. Although, I shouldn't speculate, or further speak of this at all... apologies." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,

						{ Cue = "/VO/Melinoe_1959", Text = "I understand..." },
					},
				},
			},
			MorosAboutSearch02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutFates02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2055", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "When you and I first met, you were searching for the Fates. But you discovered {#Emph}me {#Prev}among the shadows. I can navigate back to the Crossroads that way... but you can go farther?" },
				{ Cue = "/VO/Moros_0143",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I can, yes. I'm from the deepest reaches of the Underworld, where there exists no light at all. The chasm from which all creation sprang a while back." },
				{ Cue = "/VO/Melinoe_2056", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I suppose even if one knew the Fates resided in such a place, they might still prove difficult to find..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0144", Text = "Difficult, though not impossible, as we now know..." },
					},
				},
			},

			MorosAboutTask01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0873", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I have to ask you something, Lord Moros, though I think I may already have the answer. Has the war with Chronos and Olympus taken some new turn?" },
				{ Cue = "/VO/Moros_0034",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I'm sorry I can't answer you, Princess. I'm bound never to speak of matters in connection to the weavings of the Fates. If you knew more right now, it could unduly influence your path." },
				{ Cue = "/VO/Melinoe_0874", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And...? Knowledge is preparation. It seems strictly to our benefit for me to know as much as possible about what I'm getting myself into." },
				{ Cue = "/VO/Moros_0035",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Perhaps. Nevertheless, I cannot break my oath. I trust, though, that you'll learn the truth of it when the time is right." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0875", Text = "I'll be waiting." },
					},
				},
			},

			MorosAboutQuestLog01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequireQuestCount",
						FunctionArgs = { Status = "CashedOut", Min = 1, Max = 12 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0140",
					Text = "If I may, Princess? The Fated List of Minor Prophecies... have you been able to make use of it?" },

				{ Cue = "/VO/Melinoe_1805", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I have. Thank you for bringing it to me. So then, the Fates already know what's going to happen in all this? Everything I'm going to do?" },

				{ Cue = "/VO/Moros_0039",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Well, yes and no. The Fated List says as little of your future as necessary. I briefly was its host myself, and saw there but a single prophecy... that I would pass it on to you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0877", Text = "Then that's a prophecy fulfilled." },
					},
				},
			},
			MorosAboutQuestLog02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosAboutQuestLog03" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosAboutQuestLog01" }, Min = 3 },
					},
					{
						FunctionName = "RequireQuestCount",
						FunctionArgs = { Status = "CashedOut", Min = 5, Max = 25 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0141",
					Text = "The Fated List continues to unfold, so thank you. While the Fates often let events unfold naturally, at times they value an additional degree of certainty. And are willing to make it worthwhile." },
				{ Cue = "/VO/Melinoe_0878", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I've seen a number of the listed prophecies already come to pass. Still others are foretold in their place. The magick in that scroll, it's beyond anything I've learned..." },
				{ Cue = "/VO/Moros_0142",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "You must have your doubts; the Fates are rather famous for their sense of irony. But, no matter the outcome, I'm grateful for your willingness to discover their design. Our families are at stake." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0879", Text = "Our families, and more..." },
					},
				},
			},

			MorosAboutQuestLog03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "ScreensViewed", "QuestLog" },
					},
					{
						FunctionName = "RequireQuestCount",
						FunctionArgs = { Status = "CashedOut", Min = 15 },
					},
					NamedRequirementsFalse = { "AllQuestsCompleted" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
				
				{ Cue = "/VO/Melinoe_2059", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "I confess I feel a bit self-conscious that the Fated List is there for you and all to see. Some of the matters it describes are rather personal." },
				{ Cue = "/VO/Moros_0147",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "If it's any comfort, the prophecies appear only to you. We see there only what's meant for us. Although, when you fulfill a prophecy... I can usually tell. It's like a sudden realization." },
				{ Cue = "/VO/Melinoe_2060", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "We know our paths are intertwined to an extent... well, may your sudden realizations connected to my actions not be {#Emph}too {#Prev}embarrassing." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Moros_0148", Text = "I'm certain that they won't." },
					},
				},
			},

			MorosAboutQuestLog04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						-- PathFalse = { "GameState", "ScreensViewed", "QuestLog" },
					},
					{
						FunctionName = "RequireQuestCount",
						FunctionArgs = { Status = "CashedOut", Min = 35 },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "QuestLog" },
						-- CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
				
				{ Cue = "/VO/Melinoe_2061", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You know, some of these Fated prophecies are rather substantial. I shudder to think what might be on a list of {#Emph}major {#Prev}prophecies..." },
				{ Cue = "/VO/Moros_0149",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I trust this doesn't make you feel as though your service hasn't been of value, because certainly it has. However, the prophecies listed there are indeed minor, in the grand scheme of things." },
				{ Cue = "/VO/Melinoe_2062", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The grand scheme of things... as in all existence, the unfathomable past, unknowable future... that sort of grandeur, you mean?" },
				{ Cue = "/VO/Moros_0150",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Yes. The Fates preside over the smallest minutiae and the greatest of patterns. So don't take the idea of minor prophecies the wrong way. A small ripple can become a great wave." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2063", Text = "Now you sound like Poseidon." },
					},
				},
			},

			MorosAboutQuestLog05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutFates02" },
					},
					{
						FunctionName = "RequireQuestCount",
						FunctionArgs = { Status = "CashedOut", Min = 40 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
				
				{ Cue = "/VO/Moros_0154",
					Text = "Your father once was bearer of the Fated List, you know. A {#Emph}House-warming {#Prev}gift, my sisters said. But Hades put it away... until your brother unearthed it from the archives, and started using it himself." },
				{ Cue = "/VO/Melinoe_2067", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I know Zagreus sought our mother... perhaps the Fated List helped him succeed. Come to think, I wouldn't have even been born if he hadn't. Wait... how did you end up with the List after that?" },
				{ Cue = "/VO/Moros_0155",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "It wasn't until rather recently. The Fates sent me to retrieve the List from your father's House. Chronos would be absent, they said. And they were right; for when I returned, they were gone." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2068", Text = "That's when he got them..." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0156", Text = "Yes." },
					},
				},
			},

			MorosAboutQuestLog06 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequireQuestCount",
						FunctionArgs = { Status = "CashedOut", Min = 30 },
					},
					{
						-- PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Opening01" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
				
				{ Cue = "/VO/Melinoe_4750", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Some nights I'm on the surface, I remember I'm defying the will of the Fates simply by being there. Yet the Fated List has certain prophecies that cannot be fulfilled anywhere else. Your sisters, they... must have anticipated this." },

				{ Cue = "/VO/Moros_0436",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "It certainly is possible, even probable. Yet, historically, my sisters have had little patience for those who disregard their prophecies. Perhaps they're making an exception." },

				{ Cue = "/VO/Melinoe_4751", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Or perhaps I'm inviting some terrible consequence. Although if Chronos didn't disobey their prophecies, I wouldn't have either." },

				{ Cue = "/VO/Moros_0437",
					PreLineAnim = "Moros_Pensive_End",
					Text = "In my experience it's best to avoid dwelling on such subject matter. Not even I can always see the pattern in my sisters' reasoning, and I think that's their preference." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4752", Text = "To make our heads ache?" },
					},
					{
						PreLineWait = 0.48,
						ObjectType = "NPC_Moros_01",
						PreLineAnim = "Moros_Salute",
						{ Cue = "/VO/Moros_0438", Text = "Quite likely, yes." },
					},
				},
			},

			MorosAboutQuestLog07 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						Path = { "UseRecord", "QuestLog" },
						-- CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "FatesEpilogue01" }, Min = 4 },
					},
					NamedRequirements = { "ReachedEpilogue" },
					NamedRequirementsFalse = { "AllQuestsCompleted" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
				
				{ Cue = "/VO/Moros_0439",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "You... haven't often looked upon the Fated List of late. For many nights, I would anticipate your safe return, then watch as you fulfilled one prophecy after another. Now you brush right by it to come speak with me." },

				{ Cue = "/VO/Melinoe_4760", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 7.95 },

					Text = "Lord Moros, at the risk of profoundly disrespecting your sisters, I find you wholly more interesting than a bunch of minor prophecies. Well, most of them... I also don't have many left at the moment." },

				{ Cue = "/VO/Moros_0440",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "You have done very well. Or rather you have done what would inevitably come to pass... although I choose to think that this result required much intention on your part." },

				{ Cue = "/VO/Melinoe_4761", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "What happens if I have no further prophecies I can fulfill?" },

				{ Cue = "/VO/Moros_0441",
					PreLineAnim = "Moros_Pensive_End",
					Text = "Perhaps then there shall be another prophecy for me... to pass the Fated List along to someone else." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.39,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4762", Text = "You'd have to leave?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0442", Text = "I do not know." },
					},
				},
			},

			MorosAboutQuestLog08 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "QuestLog" },
						IgnoreCurrentRun = true,
						Comparison = "==",
						Value = 0,
					},
					NamedRequirements = { "AllQuestsCompleted" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4783", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",

					Text = "No minor prophecies remain for me that have not come to pass. I've not seen new ones show up in a while, and... sounds like I shouldn't be expecting more anytime soon..." },

				{ Cue = "/VO/Moros_0443",
					Text = "If that is true, then my own purpose for arriving at these Crossroads is achieved. But now I do not know how to proceed, with neither my sisters nor the List to direct me." },

				{ Cue = "/VO/Melinoe_4784", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Your sisters did suggest you may have had another purpose here, beyond ensuring that the Fated List is safe and everything within it gets checked off." },

				{ Cue = "/VO/Moros_0444",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Pensive_End",
					Text = "And what might that have been, to violate their will repeatedly while growing close to you? My sisters like to scheme, but not to that extent." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.39,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4785", Text = "You're not in any rush to leave, are you?" },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0445", Text = "On the contrary, I would be with you here as long as I can." },
					},
				},
			},

			MorosAboutBountyBoard01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBountyBoard" },
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "BountyBoard" },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "BountyBoard" },
						-- CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0180",
					Text = "A Pitch-Black Stone has been here this entire time, and I failed to detect it. I fear I'm beginning to slip up more often than acceptable." },
				{ Cue = "/VO/Melinoe_3119", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It was inert just recently, Lord Moros. Until your grandparent gave me an idea for how to see the possibilities within. Though, perhaps I ought have checked with you first. You're troubled..." },
				{ Cue = "/VO/Moros_0311",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Well, it's just... Chaos and my sisters didn't always get along. Chaos wanted everything to be possible... while the Fates, their desire is for things a certain way. But, they would all agree that you should use the Stone as you see fit." },
				{ Cue = "/VO/Melinoe_3120", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nothing like a Pitch-Black Stone to bring the family together, right?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						RequiredMinElapsedTime = 2,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0312", Text = "Right." },
					},
				},
			},

			MorosAboutShrine01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "Shrine" },
						-- CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 8,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0313",
					Text = "The Oath of the Unseen is somewhere here, isn't that so, Princess...? The aura that it emanates... I haven't felt it since before all this. I thought the Oath was lost with Mother Nyx, but it was in the care of Lady Hecate." },
				{ Cue = "/VO/Melinoe_3121", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's in my own care now. The will of Night shall be done no matter what, isn't that so? You're here among the Unseen; you know our charge." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0314", Text = "The Oath is clearly in good hands." },
					},
				},
			},

			MorosAboutCrossroads01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "MorosGift05", "MorosGrantsSurfacePenaltyCure01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0880", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hail, Lord Moros. How have you been acclimating so far? Is there something we can do to make your stay more comfortable?" },
				{ Cue = "/VO/Moros_0042",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "No, Princess, I'm well, and acclimating, as you say. I've never been to such a place as this! And making every effort not to be a nuisance here." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0693", Text = "You're welcome here and safe." },
					},
				},
			},

			MorosAboutDoom01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosAboutFates02" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0881", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What did you use to do, Lord Moros? I mean before all this. I have only the vaguest sense of it." },
				{ Cue = "/VO/Moros_0043",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I served my sisters the Three Fates, both as their advocate, and as their guardian. The Fates determine when mortal lives draw to a close, and also sometimes {#Emph}how. {#Prev}I would bear witness to these more-specific weavings..." },
				{ Cue = "/VO/Melinoe_0882", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The mortals must have appreciated your diligence. Has somebody else since taken over your responsibilities?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0044", Text = "{#Emph}Heh! {#Prev}You could say that, I suppose." },
					},
				},
			},
			MorosAboutDoom02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						--
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0883", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The Shades around here... I know they've been avoiding you, Lord Moros. Some are filled with fear. Others with contempt. You ended their lives?" },
				{ Cue = "/VO/Moros_0045",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "It never was for me to decide why a mortal's life should suddenly be cut short. But, I did get to choose the {#Emph}how {#Prev}of it. Knowing the future could be monotonous work, so my sisters and I tried to keep things... interesting." },
				{ Cue = "/VO/Melinoe_0884", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You brought misery to mortals because you were bored?" },
				{ Cue = "/VO/Moros_0046",
					Text = "I'm not proud of it. Especially not when you put it {#Emph}that {#Prev}way. And I regret I've caused dissension in your ranks." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0885", Text = "I'll handle it." },
					},
				},
			},
			MorosAboutDoom03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutDoom01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0047",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "You said something before to me, Princess. Concerning mortalkind. That surely they {#Emph}appreciate my diligence{#Prev}, because I'm with them in the final moments of their lives. The truth of it, however, is they hate me; most of them. In life, as well as death." },
				{ Cue = "/VO/Melinoe_0886", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I appreciate your candor. What you say aligns with some of the rumblings I've heard from Shades loyal to us. Though it's strange, Lord Moros. Your reputation is one thing; but {#Emph}you{#Prev}, it seems, are entirely another." },
				{ Cue = "/VO/Moros_0048",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "{#Emph}Heh! {#Prev}From you, Princess, I'll take that as a compliment." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0887", Text = "It {#Emph}was {#Prev}a compliment." },
					},
				},
			},
			MorosAboutDoom04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutDoom01", "MorosAboutOdysseus01", "MorosGift06" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4772", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What were some of your favorite examples of the work you and your sisters did? Particularly inventive ends delivered with theatrics, anything like that?" },

				{ Cue = "/VO/Moros_0679",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "Oh, where to start? Children slaughtering their parents was an old standby of ours; I'm reluctant to choose our best. There also was the war from which I first took notice of Master Odysseus. That had some good ones." },

				{ Cue = "/VO/Melinoe_4773", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The part where mortals perished in the throes of agony and terror, leaving behind loved ones to bitterly mourn their loss... you were unmoved by all of that?" },

				{ Cue = "/VO/Moros_0680",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "We have a responsibility to the realm that takes precedence. And besides, mortals don't realize that everything ends up all right for most of them." },

				{ Cue = "/VO/Melinoe_4774", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps we haven't done enough to promote the way the Underworld operates. Or used to." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						PreLineAnim = "Moros_Salute",
						{ Cue = "/VO/Moros_0681", Text = "As long as mortals fear us still." },
					},
				},
			},

			MorosAboutArtemisSinging01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "AudioState", "AmbientTrackName" },
						IsAny = { "/Music/ArtemisSong_MC", "/Music/Music/IrisEndThemeCrossroads_MC" },
					},
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.1,
					},
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Artemis_0304" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0493",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "You sing beautifully, Princess. One of the Three Fates likes to hum while she weaves, but sounds nothing like you." },

				{ Cue = "/VO/Melinoe_4755", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's mostly Artemis whose voice carries so strongly through this clearing, though thank you. We sometimes sing like this in preparation for the night." },

				{ Cue = "/VO/Moros_0494",
					PreLineAnim = "Moros_Perplexed_End",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "The goddess of the hunt and you seem rather close. The other Olympians less so, true?" },

				{ Cue = "/VO/Melinoe_4756", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Besides Lord Hermes, I met most of the others one by one around the time you first showed up." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0495", Text = "So many new acquaintances." },
					},
				},
			},

			MorosAboutForesight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutFates03", "MorosGift03" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0899", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You used to know everything that was going to occur, didn't you, Lord Moros? Up until recently, from what I gathered. I can't imagine..." },
				{ Cue = "/VO/Moros_0057",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Well, imagine it being rather dull, always knowing what's to come. But now I'm no different than you. How do you... get by like this? Many surprises are unwelcome, yet there also can be pleasant ones, true?" },
				{ Cue = "/VO/Melinoe_0900", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm sure it helps that I don't know it any other way. This must be very difficult for you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0058", Text = "{#Emph}Hah! {#Prev}Yes." },
					},
				},
			},
			MorosAboutForesight02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "MorosAboutFates03" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0901", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Something the matter, Lord Moros? You seem more ill-at-ease than usual. If there's additional bad news you're at liberty to share, I'm listening." },
				{ Cue = "/VO/Moros_0059",
					PreLineAnim = "Moros_Salute",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "Oh, {#Emph}haha! {#Prev}It's nothing of the sort, at least for now, Princess. It's just... this sensation of uncertainty. Not just in the grander scheme, but even from one evening to the next... I'm still unused to it." },
				{ Cue = "/VO/Melinoe_0902", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "There can be pleasure in the unexpected. But even those of us who never had the gift of foresight struggle in the way that you describe. For me, it helps to focus on a present state of mind. In being here right now." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0060", Text = "The now... thank you, Princess..." },
					},
				},
			},
			MorosAboutForesight03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutForesight02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0061",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I've been attempting what you said before, to focus on a present state of mind. It's proving difficult, because... my mind invariably drifts to many possibilities of negative outcomes." },
				{ Cue = "/VO/Melinoe_0903", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm familiar with that feeling. We have to consider favorable outcomes side-by-side, and plan for them. Then, at a certain point, all we can do is hope..." },
				{ Cue = "/VO/Moros_0062",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Hope... I much prefer a sense of certainty. It's odd to think that my sisters the Fates, to others, represent sheer chance. Matters beyond one's control. Yet to me, they made everything so clear... I'd rather trust than hope." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0904", Text = "You can do both." },
					},
				},
			},

			MorosAboutWitchcraft01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0063",
					PreLineAnim = "Moros_Attention",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "There's so much here for me to learn! Lady Hecate has been generous enough to teach me something of the herbal ways and of your craft. An everlasting pursuit! I'm getting a late start." },
				{ Cue = "/VO/Melinoe_0905", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You wish to become a witch, Lord Moros? Maybe I can give you some pointers sometime." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0064", Text = "Oh I would welcome that." },
					},
				},
			},

			MorosAboutDeath01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0165",
					Text = "If you don't mind me asking, Princess: Have you ever died before? Not in the mortal sense, it's just... you seem to have exceptional tenacity in moments most gods couldn't endure." },
				{ Cue = "/VO/Melinoe_2076", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I cannot afford to lose my grip on consciousness out there. Headmistress taught me always to return to shadows with my final bit of strength. I learned the hard way, but I learned." },
				{ Cue = "/VO/Moros_0166",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "It shows. Remarkable, to have met someone equally as comfortable with death as well as life. I practically see it in your eyes." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2077", Text = "It's not a big concern." },
					},
				},
			},

			MorosAboutWeapons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "WeaponDagger" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "WeaponAxe", "WeaponTorch", "WeaponLob" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosAboutMorosAspect01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2087", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, you must know something of the Nocturnal Arms. So, your mother and sisters collaborated on these weapons to be used only in dire need? And entrusted them to Headmistress?" },
				{ Cue = "/VO/Moros_0176",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Mother Nyx knew the fickle nature of the Olympians and the Fate-forged weapons that they used to seal away the Titans. She desired a set of counterparts that would awaken only if the realm itself was in upheaval." },
				{ Cue = "/VO/Melinoe_2088", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I suppose there ought to be another set of weapons forged to keep these in check. And another for {#Emph}those{#Prev}, and so on." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0177", Text = "Now you are being humorous, Princess." },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2089", Text = "I wasn't." },
					},
				},
			},
			MorosAboutMorosAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TraitCache", "TorchDetonateAspect" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3155", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I figured that you knew something of the Nocturnal Arms, Lord Moros. But your connection to Ygnium, I'd not have guessed. You once wielded the Umbral Flames yourself! I revealed an Aspect of them that could only be your own." },
				{ Cue = "/VO/Moros_0432",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Princess, I take it you're not saying this for sake of jest, so please believe in turn that I have never used the Flames before; I know them only by reputation. Can you be certain that this Aspect is my own? I've many relatives..." },
				{ Cue = "/VO/Melinoe_3156", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I... yes, I think it is! The Nocturnal Arms bond with their bearers in such a way that their connections to other bearers become almost like shared memories. Although..." },
				{ Cue = "/VO/Moros_0316",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "...Although, these glimpses can be both of bearers past, and still to come, true? So it may be that I shall bear those Flames in some other age in which the realm's in need. I... trust the Fates must have wanted me to know in advance." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3157", Text = "Well, {#Emph}erm... {#Prev}surprise...!" },
					},
				},
			},

			MorosAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
					{
						PathTrue = { "GameState", "TraitsTaken", "BlockDeathKeepsake" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0178",
					Text = "The artifact I gave to you... it can forestall the inevitable. Almost like a {#Emph}Doom Repellant{#Prev}... except, it works in the opposite way. Such technicalities aside, I trust it shall be of some benefit." },
				{ Cue = "/VO/Melinoe_2090", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm certain it shall. Sometimes all I need is a few moments more. So if I use your Pin, you get to accompany me on my evenings out?" },
				{ Cue = "/VO/Moros_0179",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Only in the final moments of your evenings, I'm afraid. Of course, we also have the evenings here..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2091", Text = "Then I'll be seeing you around." },
					},
				},
			},

			MorosAboutArrangement01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift05" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0380",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "I've come to value our companionship, Princess, so there's something you should know about me in case it becomes pertinent to us... I'm promised to another, by the Fates." },
				{ Cue = "/VO/Melinoe_4597", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Pleased_01", WaitTime = 2.5 },

					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Promised to another, as in, you are betrothed? Well then, congratulations are in order I should think! Though to whom, if I may ask...? If the Fates even let on." },
				{ Cue = "/VO/Moros_0381",
					PreLineAnim = "Moros_Pensive_End",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "Well, at the risk of being overly direct, I've concluded that she isn't you. The Fates described her as the morning light, whose luminance breaks through the darkness and reveals the beauty of the world. You're... well, different than that." },
				{ Cue = "/VO/Melinoe_4598", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh... that could be Eos, I suppose. I know her sister Selene the Moon rather well, but am not very familiar with Dawn. Are you supposed to seek her out?" },
				{ Cue = "/VO/Moros_0382",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I fear I do not know. She and I are to meet at some point, but apparently not yet. When first you and I met, I thought perhaps... that I might find her in this place." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4599", Text = "It's dark here; I don't think you shall." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0383", Text = "I realize that now." },
					},
				},
			},
			MorosAboutArrangement02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutArrangement01", "MorosGift06" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4627", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "About this goddess to whom you're betrothed. If she really is Eos the incarnate of Dawn, perhaps I could facilitate an introduction through her sister, if you like?" },
				{ Cue = "/VO/Moros_0420",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Oh, {#Emph}um{#Prev}, well, I wouldn't want for you to go out of your way, or for Selene, for that matter. You have a vital task, and I know that the Moon herself is aiding you." },
				{ Cue = "/VO/Melinoe_4628", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "But, you said you thought you might find her here. Perhaps the Three Fates knew you'd come to us eventually, and that I'd set you on the path to meet your love?" },
				{ Cue = "/VO/Moros_0421",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "Princess, if this prophecy concerning me and the one to whom I have been promised hasn't appeared on the Fated List, then there truly is no need for you to intervene." },
				{ Cue = "/VO/Melinoe_4629", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You don't sound all that enthusiastic about it. Do you not want to meet this goddess at some point?" },
				{ Cue = "/VO/Moros_0422",
					Text = "We are {#Emph}bound {#Prev}to meet; whether I want to or not is irrelevant." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4630", Text = "But... suit yourself." },
					},
				},
			},
			MorosAboutArrangement03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutArrangement02", "MorosAboutQuestLog04" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0423",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "You took some interest in this goddess to whom I am said to be bound, presuming she is Eos, the incarnate of Dawn. The truth is, when the Fates first told me about her, I grew rather frustrated." },
				{ Cue = "/VO/Melinoe_4631", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I would have probably been frustrated as well. Did your sisters foresee this union, or arrange it? Perhaps they sought to unite your powerful family with that of a Titaness." },
				{ Cue = "/VO/Moros_0424",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "In typical fashion, they revealed little. But the way in which they kept describing this goddess, or Titaness, and telling me how contented I would be... it was the first time I questioned their wisdom. Not {#Emph}outwardly{#Prev}, of course." },
				{ Cue = "/VO/Melinoe_4632", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They probably meant well, but... what is it you intend to do?" },
				{ Cue = "/VO/Moros_0425",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 2.0 },

					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If I am doomed to be with Dawn, then so be it. But I shall not be forcing that outcome along. I would much prefer to remain here... if you'll have me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4633", Text = "The choice ought to be yours." },
					},
				},
			},

			MorosAboutRelationship00 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosGift04" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosGift07" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0417",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Hello Princess, I, {#Emph}um. {#Prev}I trust that when we spoke quite recently that I did not make you, {#Emph}uh{#Prev}, well..." },
				{ Cue = "/VO/Melinoe_4624", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What is it, Lord Moros? I've enjoyed our conversations lately, so you needn't fear. I'd tell you if I thought something was wrong. I'd ask you do the same." },
				{ Cue = "/VO/Moros_0418",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "And I shall... except, in this case, I believe I misconstrued something... I thought {#Emph}you {#Prev}may have thought, because, admittedly I am a little new at all of this." },
				{ Cue = "/VO/Melinoe_4625", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My own experience in such matters is significantly lacking, too. As long as we stumble together, I suppose." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0419", Text = "I, too, suppose. {#Emph}Um{#Prev}, you be well tonight." },
					},
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4626", Text = "OK." },
					},
				},
			},

			MorosAboutRelationship01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosTaverna01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0430",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I have been thinking more about what you said at the taverna, Princess. About finding one's source of motivation, whether through encouraging results or through adversity. Or more Ambrosia." },
				{ Cue = "/VO/Melinoe_4634", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Oh {#Prev}I wasn't being serious about the Ambrosia part. It's just, I find it remarkable sometimes that adversity and negativity spur me more than expressions of faith and support." },
				{ Cue = "/VO/Moros_0431",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Salute",				
					Text = "{#Emph}Hah! {#Prev}As a force of adversity and negativity myself, I appreciate your open-mindedness. But I wanted to say that Ambrosia's quite a motivator, too. I trust we can share some again sometime." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2073", Text = "For certain." },
					},
				},
			},

			MorosAboutRelationship02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutRelationship01", "DoraWithMoros01", "MorosGift05" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosBecomingCloser01" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosAboutRelationship01" }, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0163",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "I have a bit of an awkward question, Princess... what is the custom here for making declarations of affection? I did try asking Dora first, but she didn't give me practical advice." },
				{ Cue = "/VO/Melinoe_2074", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Erm... {#Prev}declarations of affection... I'm afraid I have bad news in that there is no custom for that here. You just choose the moment to express yourself, and hope your feelings are reciprocated." },
				{ Cue = "/VO/Moros_0164",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I see. Well then, I'll have to choose a moment very carefully. I appreciate the information and your patience." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2075", Text = "Oh. Anytime!" },
					},
				},
			},

			-- alt below
			MorosAboutRelationship03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesChoiceRecord", "MorosBecomingCloser01", },
						IsAny = { "Choice_MorosAccept" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4619", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Lord Moros... {#Emph}erm{#Prev}, so how are you this eve?" },

				{ Cue = "/VO/Moros_0413",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Princess, I... was going to ask you the same. As for me, it's... well, it's as though I'm in a dream. The wonderful kind I've sometimes heard described. But, what of you...?" },

				{ Cue = "/VO/Melinoe_4620", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I'm very well, yes. My dreams... have often haunted me. Though I've experienced the good kind, too. And you're right, it's kind of like this... except the feeling never lasts." },

				{ Cue = "/VO/Moros_0414",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Pensive_End",
					Text = "Perhaps that shall be the difference in what we have; that it {#Emph}can {#Prev}last. If you would like, of course." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4621", Text = "We'll just have to find out." },
					},
				},
			},
			MorosAboutRelationship03_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesChoiceRecord", "MorosBecomingCloser01", },
						IsAny = { "Choice_MorosDecline" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4619", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Lord Moros... {#Emph}erm{#Prev}, so how are you this eve?" },

				{ Cue = "/VO/Moros_0415",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Princess! I... was going to ask you the same thing. As for me... I'm doing well, pending your response to the same question. In any case, I'm grateful that we had a chance to speak the way we did." },

				{ Cue = "/VO/Melinoe_4622", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "I'm grateful, too. So... we remain close acquaintances then, right?" },

				{ Cue = "/VO/Moros_0416",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "Of course. Although, I haven't had a lot of close acquaintances given my work, so... forgive me if I stumble." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4623", Text = "We'll do our best." },
					},
				},
			},

			MorosAboutRelationship04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "MorosBecomingCloser01" },
						IsAny = { "Choice_MorosAccept" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosBecomingCloser01" }, Min = 3 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4694", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You said before your sister Clotho revealed to you that we would meet, though you already knew you were promised to another. I suppose I've complicated things for you..." },

				{ Cue = "/VO/Moros_0426",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "And I am grateful that you did. I had no expectations for our meeting, but the truth is, I was drawn to you quite early on. Certainly in fewer than, say... five Nectar bottles." },

				{ Cue = "/VO/Melinoe_4695", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Just because you're drawn to me, doesn't mean you won't also be drawn to Eos if and when you finally meet. From all I've heard, the break of Dawn is very beautiful." },

				{ Cue = "/VO/Moros_0427",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Pensive_End",
					Text = "Princess, let us never speak of Dawn again. Perhaps my sisters know what shall become of me, but I increasingly suspect that they do not. They certainly did not prepare me for {#Emph}your {#Prev}beauty, for one." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.34,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4696", Text = "{#Emph}Hah{#Prev}, surprise!" },
					},
				},
			},

			MorosAboutRelationships01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosBecomingCloser01" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NemesisPostCombatBecomingCloser01", "ErisBecomingCloser01", "IcarusBecomingCloser01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosBecomingCloser01", "NemesisPostCombatBecomingCloser01", "ErisBecomingCloser01", "IcarusBecomingCloser01" }, Min = 2 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0428",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Princess, I ought to mention, I know there are others whom you're close with, all of whom I think you've known longer than me. I, on the other hand, have no one else. Living with my sisters, I had little opportunity." },
				{ Cue = "/VO/Melinoe_4749", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I can think of no other explanation. Many different goddesses or gods would surely be delighted if they had you in their lives, Moros. But if I'm to have you to myself for now, that's certainly all right." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						PreLineAnim = "Moros_Greet",
						{ Cue = "/VO/Moros_0429", Text = "I'm pleased you do not mind." },
					},
				},
			},

			MorosAboutSurfacePenaltyCure01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "MorosGrantsSurfacePenaltyCure01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3146", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Thank you for visiting me last night, Lord Moros. So, hypothetically, if I were to complete a certain incantation that somehow loosened the grip the Three Fates have on my birthright... how angry would they be?" },
				{ Cue = "/VO/Moros_0299",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Please understand, Princess, that I am not at liberty to give advice on matters such as that, not even hypothetically. I trust I've been sufficiently direct in putting it this way?" },
				{ Cue = "/VO/Melinoe_3147", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "In other words, we shouldn't be talking about this at all, and I assume all risk for my actions related to any potentially forbidden incantations that I've learned." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0300", Text = "Yes, that covers it." },
					},
				},
			},
			MorosAboutSurfacePenaltyCure02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "GameState", "RoomsEntered", "N_Hub" },
						Comparison = ">=",
						Value = 3,
					},
					{
						SumPrevRuns = 9,
						Path = { "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0301",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Princess, officially I cannot condone your actions. Your visits to the surface violate the terms the Fates set for your father's lineage, and you invite whichever consequences they see fit." },
				{ Cue = "/VO/Melinoe_3148", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Yes, but {#Emph}un{#Prev}officially, Lord Moros? If you'll permit yourself to speak of it this once. Or are we limited to candid conversations only when I'm on the verge of death?" },
				{ Cue = "/VO/Moros_0302",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Our conversations are most definitely more secure that way, but {#Emph}un{#Prev}officially... I am amazed by your accomplishment. Perhaps living so close to the surface predisposed you, but still... I was uncertain it was possible." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3149", Text = "May the Fates forgive my transgressions." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0303", Text = "Likewise..." },
					},
				},
			},

			-- about other characters
			MorosAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
					NamedRequirements = { "MorosUnlockedInHub" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0306",
					Text = "How far were you able to go last night, Princess? You were gone for some time. I sensed the growing fear and excitement in the air, even heard some of the rumblings." },

				{ Cue = "/VO/Melinoe_3150", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If the rumblings were that I reached the depths of Tartarus, broke into my father's stolen House, confronted Chronos there, and outfought him, then you heard correctly. Hardly a final victory, but still." },

				{ Cue = "/VO/Moros_0307",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I would object to anyone but you diminishing such a victory. Is this not a vitally important component of the task you've been entrusted to complete?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3151", Text = "Well, yes it is, but..." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						PreLineAnim = "Moros_Salute",
						{ Cue = "/VO/Moros_0308", Text = "Then congratulations, and may the Fates avail your next move." },
					},
				},
			},
			MorosAboutChronosBossW02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0433",
					Text = "Chronos fell to you once more, that much I heard. It's an impressive feat, although... you mean to bring him death, yet he is deathless. This seems to be a paradox." },

				{ Cue = "/VO/Melinoe_4697", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That's right. Mortal death is not the end, but mortals often think it is. When we say {#Emph}Death to Chronos{#Prev}, we mean it in that absolute way. As impossible as it may seem." },

				{ Cue = "/VO/Moros_0434",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "So then, to vanquish him must be at least a step toward that end. What shall become of everything if you succeed and Time is truly killed? A world without Time..." },

				{ Cue = "/VO/Melinoe_4698", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...A world without ruin and decay; our world existed before Time and can exist without." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0435", Text = "Another paradox, yet one that must be true." },
					},
				},
			},

			MorosAboutPostEndingChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "EnemyKills", "Chronos" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Chronos_02" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0469",
					PreLineAnim = "Moros_Perplexed_Start",					
					Text = "Another victory within the depths of Tartarus... except now, your fight requires you to transcend space and time, with assistance from your grandfather, of course. True...?" },
				{ Cue = "/VO/Melinoe_4808", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "True, as far as I can understand, Lord Moros. Headmistress notified you of these new details, then? You don't sound terribly surprised." },
				{ Cue = "/VO/Moros_0470",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "I assure you that my inability to sound terribly surprised does not prevent my feeling so. You have many such battles left to fight?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4809", Text = "Whenever time permits." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						PreLineAnim = "Moros_Greet",
						{ Cue = "/VO/Moros_0471", Text = "Then to your many victories to come." },
					},
				},
			},

			MorosAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutNyx01" }
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0891", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Lord Moros... I understand you can't reveal the weavings of the Fates. But, could you just tell me what the three of them are like?" },

				{ Cue = "/VO/Moros_0051",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "My sisters. They... well each is her own goddess, I suppose. Clotho the spinstress is the talkative one, the decisive one. Lachesis is a little more agreeable; she apportions the thread. And Atropos, she sticks to the cutting." },

				{ Cue = "/VO/Melinoe_0892", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "It must be a little imposing, knowing your sisters determine the course of every life. Even your own?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0052", Text = "Even my own." },
					},
				},
			},
			MorosAboutFates02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					NamedRequirements = { "MorosUnlockedInHub" },
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				{ Cue = "/VO/Melinoe_2998", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...My task began immediately following reports that Chronos found a way to gain the upper hand against Olympus. We just didn't know which sort of way. But, now I think I do: your sisters the Three Fates... he got them, didn't he? Is that why you're here?" },

				{ Cue = "/VO/Moros_0157",
					PreLineWait = 0.35,
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "...You ask while making clear to me that you already know. I ought to have been there when it happened. Perhaps the Fates knew I lacked the strength to protect them; so they protected me." },

				{ Cue = "/VO/Melinoe_0894", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How did he find them? What does he want from them?" },

				{ Cue = "/VO/Moros_0054",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I don't know how he found them. Few beings with knowledge of their whereabouts exist. As to what he wants from them... and this is a conjecture of my own... surely he'll try to influence their weavings from here on." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0895", Text = "Oh..." },
					},
				},
			},
			MorosAboutFates03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutFates02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0896", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Lord Moros, you said before you think Chronos is going to influence the weavings of the Fates. You mean he's going to try to change the future? Force a favorable outcome?" },

				{ Cue = "/VO/Moros_0055",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Yes. I think he's already trying to do just that. Unfortunately for him, the Three Fates can be a bit headstrong. I trust they may be quite resistant as captives." },

				{ Cue = "/VO/Melinoe_0897", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "I can't imagine Chronos tolerating insolence, whether from your sisters or anybody else. How he must hate them! When he was overthrown before, that was the outcome of a fated prophecy..." },

				{ Cue = "/VO/Moros_0056",
					PreLineAnim = "Moros_Pensive_End",
					Text = "Indeed. As for now, I sense there are no weavings happening at all. No new futures foretold. Chronos believes he has no prophecy to fear. Yet, I believe this is an opportunity for you. To make a better future for us all." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_0898", Text = "{#Emph}<Gasp>" },
					},
				},
			},
			MorosAboutFates04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutFates02" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0151",
					Text = "Your family has been of keen interest to the Fates for some time, hasn't it? Ever since Chronos learned he was doomed to be usurped by his own children." },

				{ Cue = "/VO/Melinoe_2064", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "A prophecy that was only fulfilled because Chronos learned of it, and desperately tried to prevent it from coming to pass. Perhaps I'd have an easier time with the Fated List if I try to thwart it at every turn." },

				{ Cue = "/VO/Moros_0152",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "I wouldn't second-guess too much. Later your father and uncles drew lots to divide up their rule of the world. By {#Emph}chance{#Prev}, your father wound up with the least desirable part, didn't he?" },

				{ Cue = "/VO/Melinoe_2065", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps the Underworld best suited him. So now it's {#Emph}my {#Prev}turn to see that the will of the Fates is done? If they even planned this far ahead." },

				{ Cue = "/VO/Moros_0153",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "They {#Emph}were {#Prev}captured, so this can't all be according to their plan. But they are counting on your aid." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_2066", Text = "I appreciate their confidence." },
					},
				},
			},
			MorosAboutFates05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutFates03" },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2069", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How can you be so certain that there are no more weavings taking place? That rather than the Fates setting the course of our lives, there's no pattern anymore... only sheer, mindless chance?" },

				{ Cue = "/VO/Moros_0158",
					PreLineAnim = "Moros_Considers",
					Text = "I never said I was certain... only that I no longer sensed my sisters' work, and it's a relatively well-honed sense. But, I've also never been apart from my sisters like this. I feel... unmoored." },

				{ Cue = "/VO/Melinoe_2070", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "As though you don't know where you're going. To me, everything feels the same as ever. Present circumstances notwithstanding. How much control did the Fates truly have?" },

				{ Cue = "/VO/Moros_0159",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "They are highly influential, I can tell you that. But can they force your every action, every thought? Of course not. You are conscious. It was your choice to speak with me just now." },
				EndVoiceLines =
				{
					{
						UsePlayerSource = true,
						PreLineWait = 0.35,
						{ Cue = "/VO/Melinoe_2071", Text = "But the Fates knew we'd meet." },
					},
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0160", Text = "Precisely." },
					},
				},
			},

			MorosAboutWeaving01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift06" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4820", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Always wanted to ask this about the Fates, Lord Moros... why the {#Emph}weaving? {#Prev}Of all the ways one could foretell what's to come... I mean why not compose ballads, paint vases?" },
				{ Cue = "/VO/Moros_0693",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "You'd think I'd know the answer, Princess, but it pains me to admit... I never once stopped to consider that. Weaving is just what they did. There aren't too many activities fit for exactly three. Perhaps {#Emph}that's {#Prev}it." },
				{ Cue = "/VO/Melinoe_4821", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It just seems like they could make their prophecies much faster if they chose a simpler craft." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0694", Text = "Best not to give them any ideas." },
					},
				},
			},

			MorosAboutNyx01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0888", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You must know the Three Fates better than anyone, besides maybe Nyx, herself! {#Emph}Erm{#Prev}, though, forgive me for invoking her..." },

				{ Cue = "/VO/Moros_0049",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "It's quite all right. The Fates, I know full well, but Mother Nyx...? We saw her seldomly. The nature of our work was such that even she would almost never get involved. Besides, she'd many other children to attend to." },

				{ Cue = "/VO/Melinoe_0889", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm sorry to hear that. My mother's the Queen. We've never even met since I was an infant. Nobody around here seems to know their blasted mothers, come to think!" },

				{ Cue = "/VO/Moros_0050",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "Come now, the mothers can't be blamed. We children {#Emph}are {#Prev}insufferable at times." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0890", Text = "{#Emph}Heh. {#Prev}True." },
					},
				},
			},

			MorosAboutChaos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ChaosAboutNyx01", "MorosAboutChaos02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3116", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How well would you say you know your grandparent, Lord Moros? I'd not expected to meet Primordial Chaos of all beings. But they summoned me to their domain, and... I don't quite know what they want from me." },

				{ Cue = "/VO/Moros_0304",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Chaos summoned you...? That is unusual, though not entirely without precedent. And in this case, I can imagine why. Chaos and Mother Nyx were rather close, after all." },

				{ Cue = "/VO/Melinoe_3117", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So Chaos seeks their daughter. They did mention something about a quandary." },

				{ Cue = "/VO/Moros_0305",
					PreLineAnim = "Moros_Pensive_End",
					Text = "This isn't the first time they took an interest in your family. Or took action that the Fates themselves likely never preordained. I choose to think you've made a new ally." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3118", Text = "I hope you're right." },
					},
				},
			},
			MorosAboutChaos02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChaosAboutChronosNightmare01", "ChaosAboutChronosNightmare01_B" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3152", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I learned what happened to the Fates, Lord Moros. Or rather, how Chronos discovered where they were. It was Chaos who led Chronos to them. Chaos, of course, seems to regret this now, and I don't think had any ill intent..." },
				{ Cue = "/VO/Moros_0309",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Oh. That is a lot of information to take in. It does make some amount of sense. Chronos, having free reign in your father's House, eventually found his way to Chaos, then coaxed this vital information out of them. Then, he ambushed the Fates, as part of his plans for conquest." },
				{ Cue = "/VO/Melinoe_3153", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're taking all this better than I would have. Come to think of it, I've never seen you angry." },
				{ Cue = "/VO/Moros_0310",
					PreLineAnim = "Moros_Pensive_End",
					Text = "You're seeing me right now. It's just, my anger changes nothing, typically. So Chaos now is working to undo some of the damage caused? Chronos removed one threat in the Fates, but created another. Perhaps an unwise trade." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3154", Text = "Making a mockery of Chaos seems unwise to me!" },
					},
				},
			},

			MorosAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NemesisGift07" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NemesisAboutTask01", "NemesisAboutFamily02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0120",
					Text = "Forgive me if I overstep, Princess. It's just... it seems to me that you and Nemesis don't always get along..." },

				{ Cue = "/VO/Melinoe_0931", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Whatever could have given you such an impression, Lord Moros? Perhaps all our incessant squabbles over petty things?" },

				{ Cue = "/VO/Moros_0121",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "They can't be petty things if they're of your concern, or for that matter, hers. I understand there's some dispute about your task. You were chosen for it, she was not. True?" },

				{ Cue = "/VO/Melinoe_0932", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "That's true. Nemesis trained hard, but so have I. The choice was never mine, yet she blames me." },

				{ Cue = "/VO/Moros_0122",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "If I know Nemesis, she blames herself. Although, she takes it out on you, that I can see. If anyone, she ought to blame the Fates..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0933", Text = "I know, right?" },
					},
				},
			},
			MorosAboutNemesis02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutNemesis01", "NemesisGift06", "NemesisAboutCombatFailure01", "NemesisPostCombatAboutArmor01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0171",
					PreLineAnim = "Moros_Considers",
					Text = "You and Nemesis appear to have been interacting in a more productive way of late. If I may ask, what changed between you two?" },
				{ Cue = "/VO/Melinoe_2082", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think we're becoming more comfortable with our respective roles in all of this. And perhaps Nemesis has finally gained a modicum of faith in my ability." },
				{ Cue = "/VO/Moros_0172",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I see... although I think there's something more. Her respect for you doesn't seem newly formed." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "NemesisGift08" },
							},
						},
						{ Cue = "/VO/Melinoe_2083", Text = "Could have fooled me." },
					},
				},
			},

			MorosAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "MorosAboutEris02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisFoughtAgainstHer01", "ErisFirstMeeting_B", "ErisFirstMeeting" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 585573 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0317",
					Text = "I'd ask what my sister Eris is doing here, but then they say {#Emph}wheresoever goes Doom, Strife follows. {#Prev}Or the other way around, whether I like it or not. Has she been here long?" },
				{ Cue = "/VO/Melinoe_3158", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "She comes and goes from time to time, typically after some bloody battle between the forces of Chronos and Olympus. We first met a while back. Briefly trained together though Headmistress soon gave up on her, as patient as she is." },
				{ Cue = "/VO/Moros_0318",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "The Fates gave up on her as well. Ordered that we never interact, that I not clean her messes anymore; although sometimes she'll goad a conversation out of me. I trust she hasn't made your lives too difficult?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3159", Text = "We've managed." },
					},
				},
			},
			MorosAboutEris02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						Path = { "GameState", "RoomsEntered", "O_Boss01" },
						Comparison = "<=",
						Value = 10,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3160", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eris outright attacked me, just as I was approaching Mount Olympus. Who gave her the Adamant Rail, anyway? A weapon once used to slay Titans, turned against the gods..." },

				{ Cue = "/VO/Moros_0319",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "The Rail {#Emph}has {#Prev}turned against the gods before. Only the Fates know its true and final purpose... but Eris has it by {#Emph}their {#Prev}own decree. Perhaps as a plaything to keep her occupied." },

				{ Cue = "/VO/Melinoe_3161", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "To keep {#Emph}me {#Prev}occupied, apparently. Makes me wonder if the Fates want Chronos stopped, or not. Did you and Eris ever fight like this?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0320", Text = "Oh, yes. Much as I tried to avoid it." },
					},
				},
			},

			MorosAboutHypnos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0475",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I noticed Hypnos was no longer in his spot, though for how long, I couldn't say. Perhaps Odysseus had him relocated someplace where the snoring would be less of a distraction." },
					
				{ Cue = "/VO/Melinoe_4812", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh no, I woke him up. Required a series of increasingly complex alchemical processes and dreamwalks, but still. He immediately left for the House of Hades in a bit of a panic." },

				{ Cue = "/VO/Moros_0476",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I'm sorry I missed him! From what I know about your father, he does value punctuality. And from what I know about my brother Sleep, he must have greeted you enthusiastically." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4813", Text = "You could say that." },
					},
				},
			},

			MorosAboutOdysseus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids =  { 557112 }, },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0173",
					PreLineAnim = "Moros_Salute",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "I'm attempting to contain my enthusiasm for the venerable hero of mortalkind over there, Princess. Our adversary may be crafty, but Odysseus is renowned for his wiles above all!" },
				{ Cue = "/VO/Melinoe_2084", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It figures you would be familiar with the Great Tactician! Likely he evaded you at least once or twice in his life, if his many tales are to be believed." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0174", Text = "Oh, they're to be believed, I can attest." },
					},
				},

			},

			MorosAboutDora01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraWithMoros01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0167",
					Text = "Your companion Dora... she's a lively one. Especially for her age. Most of the dead grow quite lethargic over time. Although I suppose things have been more eventful recently." },
				{ Cue = "/VO/Melinoe_2078", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Dora seems to be quite intrigued by you, Lord Moros. Call it a morbid fascination. You mention her age... she doesn't seem to have any recollection of such details. But, you can just tell?" },
				{ Cue = "/VO/Moros_0168",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I have my ways. Dora is... well, she's not the eldest one here, though she's been around longer than most. That much is safe for me to divulge." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2079", Text = "Huh." },
					},
				},
			},
			MorosAboutDoraMemories01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraWithMoros01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "DoraAboutMemories01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0490",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Something seems to have occurred with your companion Dora. She hasn't been as keen to make her remarks or possess my belongings. Is she all right?" },
				{ Cue = "/VO/Melinoe_4753", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Yes, I think so. Something's been nagging at her for a while that she's finally started to sort out. She may well tell you more about it at some point." },
				{ Cue = "/VO/Moros_0491",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "I think I may already know. Well, she's an old soul but a strong one. And fortunate to have you as a friend. Do you suppose there's something I may do to help?" },
				{ Cue = "/VO/Melinoe_4754", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Act frightened from her hauntings. She loves that." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0492", Text = "Certainly she's startled me before..." },
					},

				},
			},

			MorosAboutSkelly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosGift03", "SkellyGift03" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "SkellyAboutPast04" }
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2085", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Considering how well you seem to know Odysseus, surely you know brave Commander Schelemeus, do you not? Brave and humble, for I scarce know anything about his past." },

				{ Cue = "/VO/Moros_0175",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "{#Emph}Schelemeus{#Prev}, you say...? I know of no one by that name. And my recollection is infallible. Perhaps he hails from a distant land, presided over by its own strange gods..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_2086", Text = "No, that can't be..." },
					},
				},
			},

			MorosAboutArachne01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosGift01", "ArachneAboutSpiders03" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ArachneCurseQuestComplete01" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Arachne_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2080", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, I've a friend who lives in the woods called Arachne. Long story, but she was on the receiving end of a powerful curse that... changed her into a spider. Do you deal in curses at all?" },

				{ Cue = "/VO/Moros_0169",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I remember the case of Arachne. I didn't know what became of her after her metamorphosis, so... it's interesting to learn that you are friends. But no... I'm afraid curses aren't my specialty." },

				{ Cue = "/VO/Melinoe_2081", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You called it {#Emph}the case of Arachne. {#Prev}She was thought to be the greatest weaver in the world, greater than the gods... greater even than the {#Emph}Fates? {#Prev}Unwelcome competition, perhaps...?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0170", Text = "...Perhaps." },
					},
				},
			},

			MorosAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3599", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You must know the Titan Prometheus. I faced him on Olympus. Little wonder he now fights against the gods, having met his doom and lived... unlike the mortals he supposedly cares for so much." },

				{ Cue = "/VO/Moros_0337_B",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Prometheus... I took no pleasure in his plight. The gods certainly know how to make an example of someone. Now he seeks vengeance? A favored pattern in the weavings of the Fates." },

				{ Cue = "/VO/Melinoe_3600", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Now that you mention it, his knowledge of the future seems similar to that of your sisters. Do you suppose he's sided with Chronos because he knows Chronos will ultimately win?" },

				{ Cue = "/VO/Moros_0338",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I do not wish to speculate, Princess. All I know is the Titan of Foresight never was the violent sort. His experience in captivity... must have changed him." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_3601", Text = "I'll have to change him some more." },
					},
				},
			},
			MorosAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutPrometheus01" },
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_Boss01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0339",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "In my weakest moments... I used to envy Prometheus, even knowing his plight. For he was loved by mortals, having given them the gift of fire from Olympus. {#Emph}I{#Prev}, on the other hand, was {#Emph}hated. {#Prev}It should not have mattered to me... but it did." },

				{ Cue = "/VO/Melinoe_3602", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Come on, Lord Moros. What mortals think of us is of no consequence. Even if it were, better to be hated than a traitor. Prometheus thinks only of mortals and himself. I'm surprised Chronos would entrust anything to him." },

				{ Cue = "/VO/Moros_0340",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "Although I said I didn't wish to speculate, I... cannot shake the sense that Chronos values him {#Emph}because {#Prev}so many mortals do. The new Golden Age he seeks to bring about... an age for mortals, not for gods..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_3603", Text = "Doubtless all the mortals' problems would be solved..." },
					},
				},
			},

			MorosAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0341",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "My sisters told me of a certain prophecy even I thought would never come to pass... that Olympus would once again face the fury of the Father of All Monsters, and their conflict would shake the world to its core. And now it's happening..." },
				{ Cue = "/VO/Melinoe_3924", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "You mean you {#Emph}knew {#Prev}Typhon's attack was a real possibility? Why didn't you warn us? We could have prepared!" },
				{ Cue = "/VO/Moros_0342",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "I... was not permitted to warn you. Had I done so, it merely would have expedited an outcome I now realize was bound to happen anyway. Though perhaps your implication is correct, and this {#Emph}is {#Prev}all my fault..." },
				{ Cue = "/VO/Melinoe_3925", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What? How is this all your fault? Unless you aided Chronos in awakening the most notorious fiend the gods ever faced, I don't see how {#Emph}you {#Prev}had anything to do with this." },
				{ Cue = "/VO/Moros_0343",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "{#Emph}Unraveling a Fateful Bond. {#Prev}I abetted your plans to gain the surface. The awakening of Typhon... perhaps it's a punishment... and a reminder never to defy the Fates. Princess, please forgive me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_3926", Text = "Nonsense. {#Emph}Chronos {#Prev}did this, not you." },
					},
				},
			},
			MorosAboutTyphon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutTyphon01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Intro" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4589", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The prophecy concerning Typhon's reawakening... what made you think it would never come to pass? I thought the weavings of your sisters were always certain to come true." },

				{ Cue = "/VO/Moros_0375",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "The Fates are not always straightforward. Their prophecies are represented visually, not written in detail... at least the major ones. I thought my interpretation of Typhon's return was likely misguided." },

				{ Cue = "/VO/Melinoe_4590", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "So the Fates wove the image of some terrible monstrosity climbing Olympus and the gods all desperately trying to fight back, and you thought it meant what?" },

				{ Cue = "/VO/Moros_0376",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Well it wasn't that, exactly, though I didn't take it quite as literally as I should have in hindsight. I thought it prophesized that the Olympians would have to stand against some sort of existential threat..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4591", Text = "Well you weren't wrong!" },
					},
				},
			},
			MorosAboutTyphon03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutTyphon01" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4594", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The prophecy of Typhon's return... was your interpretation that the gods were going to prevail or not? Or was there any detail you recall that we might use to our advantage?" },

				{ Cue = "/VO/Moros_0379",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Well there was lightning, which I took to represent Zeus; the earth seemed to shake, recalling Poseidon; and a red spear reminiscent of your father's, piercing the storm. But even these specifics don't seem to pertain to the matter at hand." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						GameStateRequirements =
						{
							{
								PathFalse = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
							},
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4595", Text = "No, I suppose not..." },
					},
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04" },
							},
						},
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4596", Text = "A red spear, huh...?" },
					},
				},
			},
			MorosAboutTyphonW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4592", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I wonder, did the weavings of the Fates foretell that I would knock the Father of All Monsters down the mountain last night? He didn't see it coming at least." },

				{ Cue = "/VO/Moros_0377",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "No, not as such. The weavings of the Fates tend not to be precise in their detail, which I know can make them a bit confounding. But I salute your victory, Princess! I'd like to think that I foretold it, even if the Fates did not." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4593", Text = "You knew I'd vanquish Typhon?" },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0378", Text = "I had a feeling." },
					},
				},
			},

			MorosAboutPostEndingTyphonW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Chronos_02" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0472",
					PreLineAnim = "Moros_Perplexed_Start",					
					Text = "Are your attempts to scale the mountain of the gods less difficult at least, now than before? The war with Chronos having ended surely must bring some relief." },
				{ Cue = "/VO/Melinoe_4810", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well on that front, not too much has changed as yet. Apparently it's important for the stalemate between the Titan's legions and Olympus to persist, for sake of our clean-up efforts." },
				{ Cue = "/VO/Moros_0473",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "So then your fight continues as before, except without a burning vengeance for your family to compel you. What is the motivating factor now?" },
				{ Cue = "/VO/Melinoe_4811", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, where to start... I have some matters that I wish to see resolved. And, just to see what happens, I suppose!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.32,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0474", Text = "I, too, increasingly have the desire to see that." },
					},
				},
			},

			MorosAboutTyphonDeath01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0446",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "It's true, isn't it? You scoured Typhon from this world. The prophecy I saw must have... not merely been about his reawakening, but his {#Emph}eradication. {#Prev}How did you manage this, if I may ask?" },
				{ Cue = "/VO/Melinoe_4786", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "A complicated incantation from Headmistress, alongside the essence of Gigaros, my father's spear he took up after Chronos first was overthrown. It all worked out." },
				{ Cue = "/VO/Moros_0447",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Your father's spear... in what I saw, a spear could be seen piercing through the storm. Then that must have been {#Emph}you. {#Prev}And so, the Fates truly {#Emph}did {#Prev}anticipate that you'd prevail." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4787", Text = "Do they anticipate I shall slay Chronos next?" },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0448", Text = "If I but knew..." },
					},
				},
			},

			MorosGrantsHiddenAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponDagger", "WeaponTorch", "WeaponAxe", "WeaponLob", "WeaponSuit" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "TorchDetonateAspect", "TorchSprintRecallAspect" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "TorchDetonateAspect5", "TorchSprintRecallAspect5" },
					},
					NamedRequirementsFalse =
					{
						"StaffHiddenAspectRevealInProgress",
						"DaggerHiddenAspectRevealInProgress",
						-- "TorchHiddenAspectRevealInProgress",
						"AxeHiddenAspectRevealInProgress",
						"LobHiddenAspectRevealInProgress",
						"SuitHiddenAspectRevealInProgress"
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0369",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Something unusual occurred, Princess. The Fated List scrolled to a point that caught my eye. What it said made little sense to me though I'm implored to tell you: {#Emph}I see your spirits glimmer as the metals underneath the Earth." },
				{ Cue = "/VO/Melinoe_4370", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}I see your spirits glimmer as the metals underneath the Earth. {#Prev}That sounds much like a waking-phrase! Headmistress told me of them when she lent me the Nocturnal Arms. When you think on it, what do you see...?" },
				{ Cue = "/VO/Moros_0370",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "A daemon of some sort. A mask-like face, in shadow, some nocturnal realm, not necessarily our own. Who is this?" },
				{ Cue = "/VO/Melinoe_4371", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We'll soon find out I think. Likely a bearer of the Arms of Night, but whether past or future, I can't say." },
				{ Cue = "/VO/Moros_0371",
					PreLineAnim = "Moros_Greet",
					Text = "I may have just fulfilled part of a prophecy in relaying those words. I trust they'll be of benefit, not harm?" },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineThreadedFunctionArgs = { Duration = 2.5, Title = "HiddenAspectRevealed", Text = "HiddenAspectRevealed_Torch" },
				},
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4372", Text = "I think so. {#Emph}I see your spirits glimmer as the metals underneath the Earth..." },
					},
				},
			},
			MorosAboutHiddenAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TraitCache", "TorchAutofireAspect" },
					},
					--[[ asserting... but why...
					{
						SumPrevRuns = 8,
						Path = { "WeaponsUnlocked", "TorchAutofireAspect" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					]]--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4586", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The phrase you told me ended up revealing a new Aspect of the Umbral Flames, of a dark god known as Supay. Is that name at all familiar to you?" },
				{ Cue = "/VO/Moros_0372_B",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Not until now. The Fates presumably chose each and every bearer of the Arms of Night. Those bearers may not be bound by blood, but are connected still. And it seems I was to be your link to this Supay..." },
				{ Cue = "/VO/Melinoe_4587", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How can it be that there are Underworld gods that neither of us know? Most of them must be your mother's side." },
				{ Cue = "/VO/Moros_0373",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I couldn't say. Perhaps there shall be other Underworlds besides our own. Or there already are." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4588", Text = "That's quite far-fetched." },
					},
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0374", Text = "True." },
					},
				},
			},

			MorosGrantsMixer6Common =
			{
				PlayOnce = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer6Common" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer6Common" },
						Comparison = "<=",
						Value = 50,
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeWeaponUpgradeSystem" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift04" },
					},
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = ">=",
						Value = 29,
					},
					NamedRequirements = { "ShrineUnlocked" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0503",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I have something for you, Princess. Where I reside, such Darkness was quite commonplace, but perhaps not anymore. Here, in case you need it." },
				{ Cue = "/VO/Melinoe_4635", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteSurprise", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 6.5 },
					Text = "Oh, thank you, Lord Moros! Here in the Crossroads we get {#Emph}just {#Prev}enough moonlight that Darkness such as this is almost never seen. {#Emph}Wait... {#Prev}did you fulfill a prophecy just now?" },

				EndFunctionName = "ResourceGiftedInEventPresentation",
				EndFunctionArgs = { ResourceName = "Mixer6Common", ResourceAmount = 3, SoundName = "/SFX/Player Sounds/DarknessCollectionPickup" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0504", Text = "I would have given it to you even if not." },
					},
				},
			},

			MorosAboutHecateKidnapped01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "HecateMissing" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0449",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					-- PreLineAnim = "Moros_Pensive_Start",
					-- PostLineAnim = "Moros_Pensive_End",
					Text = "I've not seen the Witch of the Crossroads recently, Princess. Do you know where she may be?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4788", Text = "I have an idea, yes. I have to go." },
					},
				},
			},

			MorosPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0451",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					-- PreLineAnim = "Moros_Pensive_Start",
					-- PostLineAnim = "Moros_Pensive_End",
					Text = "Your task is finally complete...! Perhaps the Fates knew you'd succeed, but I couldn't always be certain. Although I held to what could be considered hope." },

				{ Cue = "/VO/Melinoe_4789", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "And your support made it possible, Lord Moros. For one thing, if you hadn't intervened when I was trying to reach the surface, Typhon might have reduced Olympus to ruin." },

				{ Cue = "/VO/Moros_0452",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Doom averted...! We children of Nyx have already heard that Mother is no longer bound in Tartarus; you have our deepest gratitude, certainly mine. Well then... what happens now?" },

				{ Cue = "/VO/Melinoe_4790", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "...I suppose I ought to go make certain everything's in order. My father started renovations to the Underworld, and I've volunteered to help clean up. The surface needs it too." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0453", Text = "Then it sounds like I may see you again soon?" },
					},
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4791", Text = "Absolutely." },
					},
				},
			},
			MorosPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny =
						{
							"NeoChronosAboutTartarus01",
							"NeoChronosAboutTartarus01_B",
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny =
						{
							"NeoChronosAboutOlympus01",
							"NeoChronosAboutOlympus01_B",
						},
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0454",
					PreLineAnim = "Moros_Perplexed_Start",
					-- PreLineAnim = "Moros_Pensive_Start",
					-- PostLineAnim = "Moros_Pensive_End",
					Text = "How fares your effort to cleanse all of the disorder Chronos wrought? I trust this new task doesn't fall solely to you." },

				{ Cue = "/VO/Melinoe_4792", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, everybody's pitching in, even Chronos... my grandfather. You heard what happened to him, right? His new self seems more tolerable than before." },

				{ Cue = "/VO/Moros_0455",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "{#Emph}Death to Chronos... {#Prev}to his old self. I don't know how you managed it, Princess. Perhaps not even my sisters could know such a thing, wherever they may be." },

				{ Cue = "/VO/Melinoe_4793", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "We ought to find where they've been exiled, and I don't think Chronos can simply tell us. What about you, perhaps enough has changed that you can locate them somehow?" },

				{ Cue = "/VO/Moros_0456",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I often search the void where you and I first met, since the Fates would sometimes go there, too. But it's a vast place..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4794", Text = "We'll keep searching." },
					},
				},
			},

			MorosAboutEpilogueProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll =
						{
							"MorosPostTrueEnding02",
							"MorosTaverna02",
							"NeoChronosAboutFates01",
							"PrometheusAboutFates02",
							"HeraclesFieldAboutFates01",
							"HecateFishing02",
						},
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ChaosAboutChronosNightmare01", "ChaosAboutChronosNightmare01_B" },
					},
					NamedRequirementsFalse = { "FatesDiscovered" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0457",
					PreLineAnim = "Moros_Perplexed_Start",
					-- PreLineAnim = "Moros_Pensive_Start",
					-- PostLineAnim = "Moros_Pensive_End",
					Text = "While you were out, the Fated List... it started shaking, and scrolled over to a prophecy I'd never seen, and already fulfilled. I think there may be more to it, but..." },

				{ Cue = "/VO/Melinoe_4796", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You're not supposed to tell me any more than that, I know. I think I have an idea of what that prophecy concerned, as the Fated List revealed some more to me as well." },

				{ Cue = "/VO/Moros_0458",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "I'm attempting to understand what could have prompted such a change. You'll follow where the List is leading, yes?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4797", Text = "You have my word." },
					},
				},
			},

			MorosPostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0460",
					PreLineAnim = "Moros_Pensive_Start",
					Portrait = "Portrait_Moros_Pleased_01",
					-- PreLineAnim = "Moros_Pensive_Start",
					-- PostLineAnim = "Moros_Pensive_End",
					Text = "My sisters... they're all right! I was about to say {#Emph}thank the Fates{#Prev}, but in this case, Princess? I can only say {#Emph}thank you. {#Prev}While you'd best not tell me how you did it, please do tell how it was to meet them finally..." },

				{ Cue = "/VO/Melinoe_4798", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Proud_01", WaitTime = 2.5 },

					Text = "It was an interesting conversation! And they seem to be doing well, that much I can say. And you're probably aware of the new major prophecy that they foretold." },

				{ Cue = "/VO/Moros_0461",
					PreLineAnim = "Moros_Pensive_End",
					Text = "The advent of another age! They notified me, yes. Perhaps it's their way of preventing any further attempts to circumvent their will. Assuming this age {#Emph}does {#Prev}arrive." },

				{ Cue = "/VO/Melinoe_4799", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What does this mean for you, though, Moros? I got the sense your sisters have no immediate plans to resume their customary weavings." },

				{ Cue = "/VO/Moros_0462",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I think it means that mortals shall be having a reprieve from me, potentially for quite some time. And that I'll have to find something to do..." },

				{ Cue = "/VO/Melinoe_4800", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You could remain here with us. Help tend the Crossroads. Learn our craft." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0463", Text = "...I'd like that very much." },
					},
					{
						PreLineWait = 0.37,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4801", Text = "Same." },
					},
				},
			},
			MorosPostEpilogue02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutEpilogue01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_4802", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "This advent of another age your sisters have described... do you think it's possible Prometheus anticipated it? When I think back on things he said..." },

				{ Cue = "/VO/Moros_0464",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "You're asking if the Titan of Foresight knew the Fates would eventually make this choice, before even {#Emph}they {#Prev}knew it. {#Emph}Hm. {#Prev}Perhaps the lot of them conspired to achieve a shared goal..." },

				{ Cue = "/VO/Melinoe_4803", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Lord Moros! {#Prev}I'm surprised you would even suggest such things! To have conspired against the gods, {#Emph}and {#Prev}Chronos for that matter!" },

				{ Cue = "/VO/Moros_0465",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "I merely seek alternatives to the suggestion that my sisters may not be the first to know. So then Prometheus prevailed on behalf of mortals after all. Or shall, when comes this age." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4804", Text = "To think that far ahead..." },
					},
				},
			},
			MorosPostEpilogue03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusPostTrueEnding02" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0466",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Sometimes I don't know what to do with myself anymore, Princess. I thought if you succeeded in your task that I'd return to my responsibilities. But now it seems I won't." },

				{ Cue = "/VO/Melinoe_4805", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm familiar with that feeling. I've been so fixated on my goal that I hadn't really thought about what's next... but here we are still, right? The task wasn't the end." },

				{ Cue = "/VO/Moros_0467",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "So what {#Emph}are {#Prev}we supposed to do? I'm Doom Incarnate; I'll never be known for my fishing, for instance. I fear... perhaps my best work is behind me." },

				{ Cue = "/VO/Melinoe_4806", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I fear that too, though it's nonsense. We have the rest of our existence ahead of us. Mortals have but the blink of an eye." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0468", Text = "We have it easier than mortals, certainly." },
					},
					{
						PreLineWait = 0.41,
						UsePlayerSource = true,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4807", Text = "Poor things." },
					},
				},
			},

			MorosAboutRelatives01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosTaverna02" },
					},	
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,


				{ Cue = "/VO/Melinoe_4780", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How many of your other siblings do you know? Besides the ones I've met. I've heard of so many others... Momus, the Keres, Oizys... she sounds like a lot." },

				{ Cue = "/VO/Moros_0701",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I've met most of them, I think, at one time or another. We very seldomly have family get-togethers, something Mother Nyx decided to {#Emph}try {#Prev}after Olympus and your father tried to make a similar tradition out of it. But that did not go well." },

				{ Cue = "/VO/Melinoe_4781", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How come? Wait, I know the answer to that. So, tell me this: Who was the worst behaved {#Emph}other {#Prev}than Strife?" },

				{ Cue = "/VO/Moros_0702",
					PreLineWait = 0.25,
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "Well... you named several top contenders already." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.34,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
						{ Cue = "/VO/Melinoe_4782", Text = "{#Emph}Ooh..." },
					},
				},
			},

			-- partner conversations
			MorosWithOdysseus01 =
			{
				Partner = "NPC_Odysseus_01",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutOdysseus02" },
					},
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				-- StatusAnimation = false,
				TeleportToId = 557112,
				TeleportOffsetX = 100,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 557112,
				InteractDistance = 300,
				{ Cue = "/VO/Moros_0192",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "To be direct with you, Master Odysseus, I am what you might call an admirer. At first, I found you {#Emph}extraordinarily {#Prev}frustrating, so adept were you at avoiding certain Doom. But gradually, perhaps grudgingly, I grew very impressed." },
				{ Cue = "/VO/Odysseus_0166", Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					PreLineAnim = "Odysseus_Greet",
					PreLineAnimTarget = 557112,
					Text = "Oh, {#Emph}hah{#Prev}, I'm... flattered and relieved to hear it, very kind of you to let me know, particularly after... all this time..." },
				{ Cue = "/VO/Moros_0193",
					PreLineAnim = "Moros_Greet",
					Text = "It's quite humorous, in fact. While you drew breath, I never once had opportunity to tell you!" },
				{ Cue = "/VO/Odysseus_0167", Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					Text = "{#Emph}Erm, {#Prev}quite humorous indeed, milord! I intended no offense by avoiding you, you know that, of course? A mortal impulse, whilst in mortal peril." },
				{ Cue = "/VO/Moros_0194",
					Text = "Oh, you were a wonder to behold! There were the Laestrygonian giants, Charybdis, and, lest we forget... the war of Ilium...!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0168", Text = "I never do...!" },
					},
				},
			},
			MorosWithOdysseus02 =
			{
				Partner = "NPC_Odysseus_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutOdysseus01", "OdysseusBackstory01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosWithOdysseus01" }, Min = 3 },
					},
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				-- StatusAnimation = false,
				TeleportToId = 557112,
				TeleportOffsetX = 100,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 557112,
				InteractDistance = 300,
				{ Cue = "/VO/Moros_0195",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "...So then... were you ever certain you had finally met your Doom? Or did you truly think there was always a plan of escape to be discovered, no matter how dire the circumstance?" },
				{ Cue = "/VO/Odysseus_0169", Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					PreLineAnim = "Odysseus_Greet",
					PreLineAnimTarget = 557112,
					Text = "Well, to be quite frank with you, Moros — may we be informal thus? I had the hardest time untangling myself not from near-fatal situations, but the arms of certain goddesses... my greatest weakness, looking back..." },
				{ Cue = "/VO/Moros_0196_B",
					PreLineAnim = "Moros_Salute",
					Text = "{#Emph}Ah{#Prev}, indeed... but how was this a weakness? As I understand, your wife Penelope stood by your side... I trust I do not overstep; I know this can be a sensitive topic with those from the surface." },
				{ Cue = "/VO/Odysseus_0701", Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Aye, Penelope stood by my side, having spent her best years awaiting a man who was not always in a hurry to return. After we each lived out our days, we reunited in the Underworld, but... we needed a break." },
				{ Cue = "/VO/Moros_0197",
					Text = "I see. After everything you'd been through, did your relationship end in an amicable way, at least?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0702", Text = "It didn't end so much as {#Emph}changed{#Prev}, but... aye." },
					},
				},
			},
			MorosWithOdysseus03 =
			{
				Partner = "NPC_Odysseus_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosWithOdysseus02" },
					},
					{
						Path = { "CurrentRun", "RoomsEntered" },
						HasAny = { "N_Boss01", "N_Boss02" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosWithOdysseus02" }, Min = 3 },
					},
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				-- StatusAnimation = false,
				TeleportToId = 557112,
				TeleportOffsetX = 100,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 557112,
				InteractDistance = 300,
				{ Cue = "/VO/Moros_0329",
					PreLineAnim = "Moros_Salute",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "...The wooden horse was an exquisite trick. Your own inevitable Doom, misdirected toward your unsuspecting foes! A masterstroke. But my personal favorite had to be the Polyphemus incident..." },
				{ Cue = "/VO/Odysseus_0226", Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					PreLineAnim = "Odysseus_Greet",
					PreLineAnimTarget = 557112,
					Text = "You speak of it like an old action yarn. Big bastard massacred my crew. My heart threatened to burst from my chest getting past him, and {#Emph}now {#Prev}he's up to his old antics with the Goddess there." },
				{ Cue = "/VO/Moros_0330",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "{#Emph}Oh{#Prev}, but I have no doubt that with your guidance, the Princess shall outsmart the Cyclops {#Emph}again {#Prev}and {#Emph}again. {#Prev}As recompense for the trouble that he caused you!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0227", Text = "Hear that, Goddess?" },
					},
				},
			},

			MorosWithCharon01 =
			{
				Partner = "NPC_Charon_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "CharonAboutFates01", "MorosAboutFates02" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosWithCharon02" }, Min = 3 },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				-- StatusAnimation = false,
				TeleportToId = 589589,
				TeleportOffsetX = 20,
				TeleportOffsetY = 80,
				AngleTowardTargetId = 557743,
				InteractDistance = 300,
				{ Cue = "/VO/Moros_0188",
					PreLineWait = 0.35,
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "...Nevertheless, I feel as though I ought have been there, Brother. Perhaps I could have protected them as was my charge. To think the Fates themselves may have denied me the attempt. It's discomforting that I may never know." },
				{ Cue = "/VO/Charon_0083",
					PreLineAnim = "Charon_Fierce",
					PreLineAnimTarget = 557743,
					Portrait = "Portrait_Charon_Default_01", Speaker = "NPC_Charon_01",
					Text = "{#Emph}Keeehhhh, hraaauuggghhh...!" },
				{ Cue = "/VO/Moros_0189",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "You have every reason to be angry. I'm angry, too. Nonetheless, I'm grateful that our paths have intertwined again. Be safe, Charon." },
			},
			MorosWithCharon02 =
			{
				Partner = "NPC_Charon_01",
				GameStateRequirements =
				{
					{
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Ids = { 585573 }, Alive = false },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosWithCharon01" }, Min = 3 },
					},
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				-- StatusAnimation = false,
				TeleportToId = 589589,
				-- TeleportOffsetX = 100,
				-- TeleportOffsetY = 100,
				AngleTowardTargetId = 557743,
				InteractDistance = 300,

				{ Cue = "/VO/Moros_0190",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Charon... you, Nemesis, even Hypnos. Who else, Eris? It seems I was one of the last to know of these Crossroads among the children of Nyx. Perhaps I ought have stayed in better contact." },
				{ Cue = "/VO/Charon_0084", Portrait = "Portrait_Charon_Default_01", Speaker = "NPC_Charon_01", 
					Text = "{#Emph}Mrrnngggghhh, hnnnn..." },
				{ Cue = "/VO/Melinoe_2096", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Come, Lord Charon, your brother is our guest. And even if you did all drift apart, you're here together now. Moving forward." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0191", Text = "Wait, how did you...? No matter." },
					},
				},
			},

			MorosWithHypnos01 =
			{
				Partner = "NPC_Hypnos_01",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Hypnos_01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "HypnosFinalDreamMeeting01" },
					},
				},

				PlayOnce = true,
				UseableOffSource = true,
				-- GiftableOffSource = true,
				-- UseText = "UseListenNPC",
				-- BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				SkipPreEventFunction = true,
				-- StatusAnimation = false,
				TeleportToId = 566612,
				TeleportOffsetX = 250,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 370024,
				InteractDistance = 300,
				{ Cue = "/VO/Hypnos_0006_C", Portrait = "Portrait_Hypnos_Sleeping_01", Speaker = "NPC_Hypnos_01",
					-- Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Zzzzz, zzzz{#Prev}..." },
				{ Cue = "/VO/Moros_0067",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "How strange to be encountering this brother of mine here. So then he truly hasn't stirred at all?" },
				{ Cue = "/VO/Melinoe_0907", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not once. Headmistress Hecate says Hypnos was already fast asleep when she recovered him from my father's House. You never visited him there before?" },
				{ Cue = "/VO/Moros_0068",
					PreLineAnim = "Moros_Pensive_End",
					Text = "It wasn't my place. We each come from big families, don't we? Odd families. You know how it is." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0908", Text = "I'm beginning to, yes." },
					},
				},
			},

			MorosWithEris01 =
			{
				Partner = "NPC_Eris_01",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosWithEris02" }, Min = 5 },
					},
				},
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 590426,
				AngleTowardTargetId = 585573,
				InteractDistance = 450,

				{ Cue = "/VO/Moros_0327",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Come to your senses, Eris. You're not doing yourself any favors by impeding the will of the Fates. Have you heard of even a single incident where that turned out for the best?" },

				{ Cue = "/VO/Eris_0174", Portrait = "Portrait_Eris_Default_01",
					Speaker = "NPC_Eris_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PreLineAnimTarget = 585573,
					PreLineWait = 0.35,
					Text = "{#Emph}No! {#Prev}But there's a first time for everything, and I'm not interested in hearing veiled threats from them through {#Emph}you. {#Prev}If they care so much about what I'm up to, why don't they contact me {#Emph}themselves?" },

				{ Cue = "/VO/Moros_0328",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "You know that isn't how it works. Have you truly made up your mind, to side against... well, {#Emph}everyone? Eugh{#Prev}, even {#Emph}I'm {#Prev}not supposed to be speaking to you..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.37,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0175", Text = "I do what I want, {#Emph}Moros." },
					},
				},
			},
			MorosWithEris02 =
			{
				Partner = "NPC_Eris_01",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosGift03", "ErisGift01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosWithEris01" }, Min = 5 },
					},
				},
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 590426,
				AngleTowardTargetId = 585573,
				InteractDistance = 450,

				{ Cue = "/VO/Eris_0114", Portrait = "Portrait_Eris_Default_01",
					Speaker = "NPC_Eris_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PreLineAnimTarget = 585573,
					PreLineWait = 0.35,
					Text = "{#Emph}Come on{#Prev}, man! Gotta tell me why you're really {#Emph}here! {#Prev}The Three don't just send you out on long {#Emph}assignments {#Prev}like this! Wait... is it because of {#Emph}her?" },

				{ Cue = "/VO/Moros_0324",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Please, Eris. The Princess ought to be addressed as such. And lest you forget, the details of my arrival are not for me to divulge. There must be something else we can discuss." },

				{ Cue = "/VO/Eris_0115", Portrait = "Portrait_Eris_Default_01",
					Speaker = "NPC_Eris_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PreLineAnimTarget = 585573,
					PreLineWait = 0.35,
					Text = "{#Emph}Oh{#Prev}, I can think of {#Emph}lots {#Prev}of things. I want to know what's going on with you two. I see the way you look up at her as she trots by. Maybe the Three sent you here to {#Emph}set the two of you up...?" },

				{ Cue = "/VO/Moros_0325",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "You're trying to embarrass me... it isn't going to work. And besides, we both know the Fates have better uses of their weaving-time than things like that." },

				{ Cue = "/VO/Eris_0116", Portrait = "Portrait_Eris_Default_01",
					Speaker = "NPC_Eris_01",
					PreLineAnim = "Enemy_Eris_Hub_Scoff",
					PreLineAnimTarget = 585573,
					PreLineWait = 0.35,
					Text = "Do they {#Emph}really? {#Prev}Thought they were all about meddling with the smallest details of everybody's lives! {#Emph}But{#Prev}, you'd know better than me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0326", Text = "I know better than to be provoked like this..." },
					},
					{
						PreLineWait = 0.2,
						ObjectType = "NPC_Eris_01",
						{ Cue = "/VO/Eris_0163", Text = "{#Emph}Hm!" },
					},
				},
			},

			MorosWithIcarus01 =
			{
				Partner = "NPC_Icarus_01",
				PartnerVariant = "IcarusHome",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				-- StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutIcarus01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "IcarusHomeAboutMoros01", "IcarusHomeAboutMoros01_B" },
					},
				},
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 743557,
				TeleportOffsetY = 50,
				InteractDistance = 450,

				{ Cue = "/VO/Moros_0477",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "...Oh yes, I certainly remember you. Would it be any consolation knowing that the Fates had already decided that your wings would fail you, and you would fall?" },

				{ Cue = "/VO/Icarus_0472",
					PreLineWait = 0.15,
					Portrait = "Portrait_Icarus_Unsure_01", Speaker = "NPC_Icarus_01",
					PreLineAnim = "Icarus_Flustered_Start", PreLineAnimTarget = 800098,
					PostLineAnim = "Icarus_Flustered_End", PostLineAnimTarget = 800098,
					Text = "{#Emph}Erm{#Prev}, not exactly, no. For one thing, that would make the Three Fates seem a little, well, you know... {#Emph}mean. {#Prev}I was just some kid, and an {#Emph}imprisoned {#Prev}kid! Why pick on {#Emph}me? {#Prev}And for another, are you saying that I had no real choice?" },

				{ Cue = "/VO/Moros_0478",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "Well first, my sisters have to be impartial, to keep a healthy distance from their work. Rarely is it ever personal. As for the choice you made... it was still yours, except... the outcome would have likely happened either way." },

				{ Cue = "/VO/Icarus_0473",
					Portrait = "Portrait_Icarus_Unsure_01", Speaker = "NPC_Icarus_01",
					PreLineAnim = "Icarus_Explaining_Start", PreLineAnimTarget = 800098,
					PostLineAnim = "Icarus_Explaining_End", PostLineAnimTarget = 800098,
					Text = "You're saying if I didn't fly up like a dolt and melt my wings, they would have simply broken or something later on, and I'd have plunged into the water anyway...?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0479", Text = "Not necessarily exactly that... but yes." },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Icarus_01",

						{ Cue = "/VO/Icarus_0474", Text = "Well {#Emph}that's {#Prev}reassuring!" },
					},
				},
			},

			MorosWithHecate01 =
			{
				Partner = "NPC_Hecate_01",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				PlayOnce = true,
				UseText = "UseListenNPC",
				-- StatusAnimation = false,
				BlockDistanceTriggers = true,
				SkipPreEventFunction = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 566620,
				TeleportOffsetX = -50,
				-- TeleportOffsetY = -300,
				InteractDistance = 450,

				{ Cue = "/VO/Moros_0482",
					PreLineWait = 0.35,
					PreLineAnim = "Moros_Greet",
					Text = "...As long as it is not an imposition, Lady Hecate. I know you have far greater responsibilities than looking after yet another child of Nyx. Especially when Nyx herself is back." },

				{ Cue = "/VO/Hecate_0879",
					PreLineAnim = "HecateHubGreet", PreLineAnimTarget = 556921,
					Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					Text = "When Melinoë first summoned you I said that you could stay for now, and it continues to {#Emph}be {#Prev}now, does it not? You seem the sort to make yourself useful without getting underfoot. 'Tis all that I require." },

				{ Cue = "/VO/Moros_0483",
					Portrait = "Portrait_Moros_Default_01",
					PreLineAnim = "Moros_Salute",
					Text = "Then I shall do so to the best of my ability. Please notify me if you deem my performance unsatisfactory in any way." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.39,
						ObjectType = "NPC_Hecate_01",
						PreLineAnim = "Hecate_Hub_Scoff",

						{ Cue = "/VO/Hecate_0880", Text = "{#Emph}Oh {#Prev}gods, you're just like her." },
					},
					{
						PreLineWait = 0.42,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0484", Text = "Like who...?" },
					},
				},
			},

			-- partner conversations
			NemesisWithMoros01 =
			{
				Partner = "NPC_Nemesis_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PostBlockSpecialInteract = true,
			},
			NemesisWithMoros02 =
			{
				Partner = "NPC_Nemesis_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PostBlockSpecialInteract = true,
			},
			NemesisWithMorosAboutRelationships01 =
			{
				Partner = "NPC_Nemesis_01",
				PlayOnce = true,
				UseableOffSource = true,
				-- StatusAnimation = false,
				PostBlockSpecialInteract = true,
			},

			DoraWithMoros01 =
			{
				Partner = "NPC_Dora_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PostBlockSpecialInteract = true,
			},
			DoraWithMoros02 =
			{
				Partner = "NPC_Dora_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				PostBlockSpecialInteract = true,
			},
			DoraWithMoros03 =
			{
				Partner = "NPC_Dora_01",
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = false,
				CopyDataFromPartner = true,
			},

			-- Repeatable
			MorosChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0004",
					Text = "I thank the Fates you're safe with us, Princess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat02 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0005",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "You'll be pleased to know I've no additional bad news to share, for now." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat03 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0006",
					Text = "May the Fates be favorable on your next attempt." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat04 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0007",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "I'm beginning to acclimate to these Crossroads, I think!" },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat05 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0008",
					Text = "I'm managing, Princess, though this is very strange for me." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat06 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0009",
					Text = "Who can say what the Fates have in store for any of us now..." },
			},
			MorosChat07 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0010",
					Text = "The Fates entrusted you with so much, Princess..." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat08 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0011",
					Text = "I'll do my best to make myself useful around here." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat09 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0012",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "It's a pleasure to see you again, as always, Princess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat10 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Cleared" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0013",
					Text = "I regret the setbacks you've encountered, though at least you're here." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat11 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0014",
					Text = "Please don't hesitate to let me know if I can be of service in some way." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat12 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0015",
					Text = "May you be well-prepared for whatever is to come." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat13 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0016",
					Text = "Remember that the future is yet to be woven, Princess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat14 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0017",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I've so much left to learn about this way of life..." },
			},
			MorosChat15 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0018",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Do let me know if there's something I could do to ease your burden even for a bit." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat16 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0019",
					Text = "I trust your task is growing ever closer to completion, Princess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat17 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0020",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Some of the Shades here still don't seem particularly fond of me, I'm afraid..." },
			},
			MorosChat18 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0021",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "What would the Fates have me do next, I wonder..." },
			},
			MorosChat19 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0022",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "Thank you for making me feel welcome here, Princess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat20 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0023",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "If the Fates have taught me anything, it's that our lives can take the strangest turns..." },
			},
			MorosChat21 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0024",
					Text = "Be well, Princess Melinoë, and may my sisters always favor you." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat22 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0025",
					Text = "Always a pleasure, Princess. Though, please... don't let me keep you." },
			},
			MorosChat23 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0026",
					Text = "Take heart knowing the Fates themselves believe that you'll succeed." },
			},
			MorosChat24 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0027",
					Text = "Go bring those foes of ours some more bad news for me." },
			},
			MorosChat25 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0028",
					Text = "Princess Melinoë. May doom befall your foes." },
			},
			MorosChat26 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0029",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "I seldom get to say {#Emph}we meet again{#Prev}, yet here we are, Princess." },
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
			},
			MorosChat27 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0030",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "To think that we were fated to meet under such circumstances..." },
			},
			MorosChat28 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0031",
					Text = "I'm certain you've more urgent matters to attend to than keeping company with me." },
			},
			MorosChat29 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift05" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0032", PreLineWait = 0.25,
					Text = "...Forgive me, Princess. I... I need some time to think." },
			},
			MorosChat30 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0033",
					Text = "I've no additional bad news for now, I'm pleased to say, Princess." },
			},
		},

		GiftTextLineSets =
		{
			MorosGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
				},
				{ Cue = "/VO/Melinoe_0909", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, as our honored guest, {#Emph}erm{#Prev}, we wanted you to have this. To make your stay a bit more comfortable." },
				{ Cue = "/VO/Moros_0069",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Attention",
					Text = "The Nectar of the gods! Thank you, Princess. I've... not received an offering before. Though I do like to come prepared. So here! From me to you." },
			},
			MorosGift02 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				{ Cue = "/VO/Moros_0070",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Attention",
					Text = "{#Emph}Huh! {#Prev}I must admit I'm unaccustomed to displays of flattery. Forgive me, I don't quite know what to say, except... thank you." },
				{ Cue = "/VO/Melinoe_0910", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're very welcome! Though, I'd not intended it as {#Emph}flattery{#Prev}, it's just.... Don't even mention it, all right?" },
			},
			MorosGift03 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "MorosGift02" },
					},
				},
				{ Cue = "/VO/Moros_0071",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "You're very kind to me, Princess. I arrived at these Crossroads in a desperate state. I didn't expect to be made welcome here." },
				{ Cue = "/VO/Melinoe_0911", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And I didn't expect to meet Doom face-to-face, much less for him to be rather agreeable. Yet here we are!" },
			},
			MorosGift04 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "MorosGift03" },
					},
				},
				{ Cue = "/VO/Moros_0072",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "Why, thank you for this, truly, though you needn't go out of your way for me. You've been so generous. Forgive my asking, but... this isn't due to some sort of prophecy in the Fated List, is it?" },
				{ Cue = "/VO/Melinoe_0912", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}No! {#Prev}No, of course not, Lord Moros! Although, even if it was, I would be duty-bound not to inform you, wouldn't I?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0073", Text = "{#Emph}Heh! {#Prev}That's true." },
					},
				},
			},
			MorosGift05 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "MorosGift04" },
					},
				},
				{ Cue = "/VO/Moros_0074",
					Text = "I'm honored to accept this, Princess Melinoë. When the Fates first indicated that we'd meet, I asked them what I should expect; what you were like. Clotho smiled and simply said, {#Emph}you'll see. {#Prev}I felt certain they were playing a prank!" },
				{ Cue = "/VO/Melinoe_0913", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You make me glad I don't have any sisters, Lord Moros. So what would you have said in Clotho's place?" },
				{ Cue = "/VO/Moros_0075",
					Portrait = "Portrait_Moros_Pleased_01",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Moros_Attention",
					Text = "Oh! Perhaps I would have said... she's a great witch and enchantress. The Princess of the Underworld, daughter to the goddess of spring and the lord of the dead. Though whatever you imagine her to be... she's more." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.5,
						UsePlayerSource = true,
						-- RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0914", Text = "...That's not bad." },
					},
				},
			},
			MorosGift06 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "MorosGift04" },
					},
				},
				{ Cue = "/VO/Moros_0387",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "This Nectar of the gods, it's... such a luxury. With my sisters, I led a relatively simple life. Now to find myself in such a place, much less with you... no prophecy could have prepared me." },
				{ Cue = "/VO/Melinoe_4601", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You seem to truly like it here. I think we have our needs fulfilled, though I've not often heard anything in the Crossroads described as luxurious. Are things so different where you're from?" },
				{ Cue = "/VO/Moros_0388",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Attention",
					Text = "Well, it was an excellent place to be a weaver. But there was not a lot of other recreational activity, or other company. I fear I may become quite self-indulgent with all this..." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4602", Text = "I don't think you're at any risk of that just yet." },
					},
				},

			},
			MorosGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_MorosUnlockHint01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosGift06", "MorosAboutArrangement03" },
					},
				},
				{ Cue = "/VO/Melinoe_4603", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I wanted you to have this, Lord Moros, since you seemed to enjoy it last time. Ambrosia may flow freely on Olympus, but we chthonic gods should get our share as well, wouldn't you say?" },

				{ Cue = "/VO/Moros_0389",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "{#Emph}Oh! {#Prev}I think that's a better question for Nemesis. It's not for me to say whether we {#Emph}deserve {#Prev}such things. And the Fates did not advise me as to whether I should accept such gifts. Nor did I ever think to ask..." },

				{ Cue = "/VO/Melinoe_4604", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I can't believe I'm saying this, though there's no need to overthink it so much. Since the Fates aren't here to tell you, you could always listen to your heart in such a situation...?" },

				{ Cue = "/VO/Moros_0390",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "My heart... it isn't saying anything, Princess. But it is... beating faster than I'm accustomed, even though I'm at rest, and comfortable, mostly. {#Emph}Very {#Prev}comfortable! {#Emph}Ah{#Prev}, I don't wish to be so rude, so thank you very much." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4605", Text = "You're very welcome." },
					},
				},

			},
			MorosGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				StartBecomingCloserTrack = true,
				HintId = "Codex_GrowingCloser01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosGift07" },
					},
				},
				{ Cue = "/VO/Melinoe_4606", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If I've learned anything it's that with practice comes perfection, or as close as we can ever get. So, what do you say we practice listening to our hearts a little more? Here, this is for you." },

				{ Cue = "/VO/Moros_0391",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Moros_Attention",
					Text = "I'm... I'm attempting to listen to my heart right now, Princess. But if truly it can speak, I'm afraid it's speaking a bit rapidly, such that I can't entirely understand or know what to do... as though I'm in one of your binding spells." },

				{ Cue = "/VO/Melinoe_4607", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How about I go first, and next I offer you Ambrosia, you can be prepared. For now, my heart says... I feel comfortable around you. Even though you make me feel like royalty, which come to think of it, I do not mind at all." },

				{ Cue = "/VO/Moros_0392",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I... thank you very much for that, Princess. I'm pleased that you approve of me this way. And, next time, as you say, I'll... be better prepared to express my sentiment, in turn." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,

						{ Cue = "/VO/Melinoe_4759", Text = "Looking forward to it." },
					},
				},

			},
			MorosGift09 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_GrowingCloser01",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosGift08" },
					},
				},
				{ Cue = "/VO/Melinoe_4608", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well, Lord Moros, ready to let your heart do the talking this time? Because here's something that I wanted you to have. Your calm and considerate presence in these Crossroads has meant a lot to me, so thank you." },

				{ Cue = "/VO/Moros_0393",
					PreLineAnim = "Moros_Attention",
					Text = "I should be thanking you instead, Princess. Not merely for this gift, which is beautiful... but also because you've given me something else to strive for, besides the Fate-appointed calling that I've known." },

				{ Cue = "/VO/Melinoe_4609", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Something to strive for? You mean the Nectar and Ambrosia? Good, isn't it? I should be able to get more!" },

				{ Cue = "/VO/Moros_0394",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I'd welcome that, although it isn't what I meant, which is... knowing you could spend your time with anyone, I'll strive to make the time you spend with me worthwhile. As fulfilling for you as it is for me." },

				{ Cue = "/VO/Melinoe_4610", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "But I already find the time we share fulfilling. I wouldn't want you thinking otherwise, or changing how you are with me. I like the way I feel when I'm with you." },

				{ Cue = "/VO/Moros_0395",
					-- Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "And you don't know how glad I am to hear it. Well, I've relayed what I believe my heart has said, after a closer listening. Perhaps I ought have kept its message to myself..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4611", Text = "No, of course not. I'm glad." },
					},
				},

			},

			-- taverna
			MorosTaverna01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				HintId = "Codex_TavernaGiftHint",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift05" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_0915", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Moros? I wanted you to have this either way, though if you're not too busy at the moment, would you care to share it with me at the taverna? I know this is sudden, it's just... I'm past due for a little break..." },

				{ Cue = "/VO/Moros_0076",
					PreLineAnim = "Moros_Greet",
					Portrait = "Portrait_Moros_Pleased_01",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Moros_Pleased_01_Exit",
					Text = "Princess Melinoë, it would be my pleasure. Would you please lead the way?" },

				{ Cue = "/VO/Melinoe_0916", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...So, it {#Emph}can {#Prev}be a lot, of course. I don't know what's the better source of motivation, those completely certain I'll succeed in everything, or those completely certain that I'll fail." },

				{ Cue = "/VO/Moros_0077",
					SkipContextArt = true,
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Salute",
					Text = "{#Emph}Hah! {#Prev}I have the same thought pattern frequently. The Fates, they could anticipate the outcomes of my efforts and would chastise me sometimes for small mistakes I'd yet to make. It wasn't always as encouraging as intended." },

				{ Cue = "/VO/Melinoe_0917", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Then, where did you find the strength? Your responsibilities sound like they must have been a lot." },

				{ Cue = "/VO/Moros_0078",
					SkipContextArt = true,
					Text = "It all simply became a force of habit at some point. You practice a skill to a level of proficiency, then fear letting it go... fear you'll never be as capable at other things..." },

				{ Cue = "/VO/Melinoe_0918", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "I wouldn't have expected Doom himself to harbor such misgivings." },

				{ Cue = "/VO/Moros_0079",
					SkipContextArt = true,
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Well! Perhaps I should have been born as {#Emph}Fear! {#Prev}So then where do {#Emph}you {#Prev}think it comes from? Your source of motivation for your task." },

				{ Cue = "/VO/Melinoe_3353", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PortraitExitAnimation = "Portrait_Mel_Casual_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "I've decided it comes from the thought of finding more of this Ambrosia out there; this is {#Emph}good!" },

				{ Cue = "/VO/Moros_0081",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,

					Text = "I very much enjoyed your company, Princess, and thank you for the drink. I trust we'll have more opportunities like this?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0920", Text = "I trust so too." },
					},
				},

			},

			-- bond forged
			MorosTaverna02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				HintId = "Codex_TavernaGiftHint",
				CompletedHintId = "Codex_BondForgedMoros",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosGift09" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_4612", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Forgive me for presuming, though you seem a little tense of late, Lord Moros. What would you say if we shared one of these bottles together at the taverna? It's been a while." },

				{ Cue = "/VO/Moros_0396",
					PreLineAnim = "Moros_Salute",
					Portrait = "Portrait_Moros_Pleased_01",
					PortraitExitAnimation = "Portrait_Moros_Pleased_01_Exit",
					Text = "Nothing would please me more, Princess... except, it's not my wish to burden you, and I regret that I've permitted my concerns, which are slight, to become apparent. So please, don't go out of your way on my account." },

				{ Cue = "/VO/Melinoe_4613", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'm not going out of my way. And if it's truly your wish for the time we share to be fulfilling, then you can start by taking the opportunities that present themselves." },

				{ Cue = "/VO/Moros_0397",
					Portrait = "Portrait_Moros_Pleased_01",
					PortraitExitAnimation = "Portrait_Moros_Pleased_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "You make a strong case. It would be my honor to accompany you, then. Shall we head down?" },

				{ Cue = "/VO/Moros_0398",
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineAnim = "Moros_Greet",
					PreLineWait = 0.35,
					SkipContextArt = true,
					Text = "...I have been drawn to others on occasion, yes. But, I knew better than to let myself become attached. If my heart started to speak to me, I always could make it quiet down." },

				{ Cue = "/VO/Melinoe_4614", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "In that, at least, we're quite alike... skilled at quieting our hearts. Though if the Lady Aphrodite's taught me anything, it's that our passions needn't always be suppressed." },

				{ Cue = "/VO/Moros_0399",
					SkipContextArt = true,
					Text = "What do you mean, Princess? What passions could you have possibly suppressed, given all that you've achieved?" },

				{ Cue = "/VO/Melinoe_4615", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Well, for one thing, even being here with you... the past me never would have had the clarity of mind to ask, I think. My mind would have talked my heart out of it." },

				{ Cue = "/VO/Moros_0400",
					SkipContextArt = true,
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Then I'm very grateful that your heart is beginning to prevail in more of these debates. I think it only makes you stronger, and... perhaps it's the Ambrosia, but... I'm very fond of that. Of you in your entirety, truly." },

				{ Cue = "/VO/Melinoe_4616", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Pleased_01", WaitTime = 6.2 },
					Text = "Oh...! While we're being candid, then... I've become rather fond of you as well... but, if you're promised to another, I don't wish to interfere." },

				{ Cue = "/VO/Moros_0401",
					SkipContextArt = true,
					PreLineAnim = "Moros_Pensive_End",
					Portrait = "Portrait_Moros_Pleased_01",
					PortraitExitAnimation = "Portrait_Moros_Pleased_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },
					Text = "I don't know this other goddess to whom I've been promised, nor do I want to. And I've violated the will of the Fates already; we both have. Wherever all this leads, I would have {#Emph}you {#Prev}by my side." },

				{ Cue = "/VO/Moros_0403",
					Portrait = "Portrait_Moros_Pleased_01",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Moros_01", Icon = "Keepsake_Moros", EndFunctionName = "InCombatTextEvent", EndFunctionArgs = GameData.PostTavernaArgs },

					Text = "I very much enjoyed our time, Princess, and will anticipate when we can be together next. Soon, I trust." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4618", Text = "I feel the same way." },
					},
				},

			},

			MorosBathHouseDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},		
				{ Cue = "/VO/Melinoe_3555", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					Text = "I was thinking about a visit to the hot springs and thought you might be interested, my lord." },
				{ Cue = "/VO/Moros_0344",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Respectfully, Princess, I've past events to document so I had better not. Some other time, perhaps?" },
			},

			MorosBathHouse01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_HotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift02" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_0921", UsePlayerSource = true,
					Text = "Have you experienced our hot springs yet, Lord Moros? The waters cleanse the body and the mind. I'm headed over if you'd care to join me?" },
				{ Cue = "/VO/Moros_0101",
					Emote = "PortraitEmoteSurprise",
					PortraitExitAnimation = "Portrait_Moros_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "Why, I... I don't see why not! I've seen and heard about such springs as these, though never been." }, 
				{ Cue = "/VO/Moros_0105",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					Text = "...To think that such a place is hidden here..."
				},
				{ Cue = "/VO/Melinoe_0923", UsePlayerSource = true,
					PreLineWait = 0.5,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "So, what did you and the Fates do for recreation where you're from, anyhow?" },
				{ Cue = "/VO/Moros_0111", Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					Text = "Have I mentioned that they liked to weave? Their weaving was their occupation and their {#Emph}passion. {#Prev}I never got too good at it myself, and all they needed was the three of them, so..." },
				{ Cue = "/VO/Melinoe_0924", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I know an excellent spinstress who could maybe help with your technique. What did you do while they were busy spinning away?" },
				{ Cue = "/VO/Moros_0112", Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					Text = "Well, I would travel the world! To witness mortals in their final moments. Look them square in the face as they perished... often in horror..." },
				{ Cue = "/VO/Melinoe_0925", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "...You do this for recreation's sake?" },
				{ Cue = "/VO/Moros_0113", Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12 },
					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "The nature of the role leaves little time for recreation. And it's all I could do to make those final moments dignified... though I don't think the gesture always comes across." },
				{ Cue = "/VO/Moros_0117",
					NarrativeContextArt = "DialogueBackgroundBiome_Woods",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "I've not felt so refreshed in... well, it's been a while now. Thank you again." },
			},
			MorosBathHouse02 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				HintId = "Codex_HotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift04" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_0922", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, would you accompany me to the springs again sometime? And by sometime I mean... are you busy now?" },
				{ Cue = "/VO/Moros_0102",
					PortraitExitAnimation = "Portrait_Moros_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "I feared you'd never ask again, Princess! I've longed for the warmth of the springs since last we visited." }, 
				{ Cue = "/VO/Moros_0104",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					Text = "...I surely can get used to this..."
				},
				{ Cue = "/VO/Melinoe_0927", UsePlayerSource = true,
					PreLineWait = 0.5,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Your relationship with the Fates sounds like it must have been a complicated one. You've never been on your own, have you?" },
				{ Cue = "/VO/Moros_0114", Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					Text = "I haven't. They're my sisters, and my elders. I grew up under their watchful eye, and I'm more than their brother; I was their guardian. But I couldn't protect them, in the end. Perhaps they always knew I'd fail them, and loved me anyway." },
				{ Cue = "/VO/Melinoe_0928", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "You can't go thinking like that. You had one of the most important responsibilities in the world. The Fates are as all-knowing as they come, aren't they? Then it stands to reason there wasn't anybody better suited for the task than you." },
				{ Cue = "/VO/Moros_0115", Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					Text = "...Princess? Would you just let me wallow in my misery a bit? {#Emph}Ah... {#Prev}no, wait. Forget it. It's gone. A mighty incantation on your part just now." },
				{ Cue = "/VO/Melinoe_0929", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "{#Emph}Heh{#Prev}, anyway. I know you love your sisters, but... the circumstances being what they are, perhaps some distance will be good for you." },
				{ Cue = "/VO/Moros_0116", Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12 },
					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "Perhaps.... These springs are good for me, of that I have no doubt." },
				{ Cue = "/VO/Moros_0118",
					NarrativeContextArt = "DialogueBackgroundBiome_Woods",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "I think I really needed that. And always wonderful to have your company." },
			},
			MorosBathHouse03 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				Cost =
				{
					GiftPointsRare = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosPostEpilogue01", "MorosBecomingCloser01" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},

				{ Cue = "/VO/Melinoe_4814", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How about a visit to the springs again, Moros? I'm not in any hurry at the moment if you're not either." },

				{ Cue = "/VO/Moros_0682",
					Portrait = "Portrait_Moros_Pleased_01",
					PortraitExitAnimation = "Portrait_Moros_Pleased_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "I'd like that very much. It's very peaceful there... almost like when we meet during the moment you return." },

				{ Cue = "/VO/Melinoe_4815", UsePlayerSource = true,
					PreLineWait = 0.5,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Text = "...I think it's possible the Fates arranged all this. Between the two of us. And I mean {#Emph}all {#Prev}of it. Has that occurred to you?" },

				{ Cue = "/VO/Moros_0684",
					Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					Text = "Perhaps a little, but it's something I refuse to believe. Why would the Fates have promised me to another if they wanted me to be with you? That makes very little sense." },

				{ Cue = "/VO/Melinoe_4816", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I know, it's just... sometimes to get someone to do something, it's best to compel them to do some opposite thing they {#Emph}don't {#Prev}want to do. They'll do what you truly want in defiance. A simple bit of psychic manipulation." },

				{ Cue = "/VO/Moros_0685", Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					Text = "But I always was obedient. They had no reason to think I'd defy them... no, I just can't accept we were tricked into this somehow. We may not have met by chance, but still. My sisters had more important things to do." },

				{ Cue = "/VO/Melinoe_4817", UsePlayerSource = true,
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I suppose it doesn't really matter. But if they did determine you and I should meet, I'm grateful. They could have chosen someone far less suitable." },

				{ Cue = "/VO/Moros_0686", Portrait = "Portrait_Moros_Bath_01",
					PortraitExitAnimation = "Portrait_Moros_Bath_01_Exit",
					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, PreTextWait = 1.5 },
					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,
					Text = "They certainly have their way. And I have never felt more grateful to them, or to you." },

				{ Cue = "/VO/Moros_0687",
					NarrativeContextArt = "DialogueBackgroundBiome_Woods",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Portrait = "Portrait_Moros_Pleased_01",
					Text = "...{#Emph}Whew! {#Prev}I think I'm ready for whatever else the Fates may have in store. See you, Melinoë." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4819", Text = "See you, Moros." },
					},
				},
			},

			MorosFishingDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPointsEpic = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},		
				{ Cue = "/VO/Melinoe_3501", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					Text = "I don't suppose you'd join me for a little while at the fishing pier, Lord Moros? Thought we could use these Twin Lures." },
				{ Cue = "/VO/Moros_0119",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "{#Emph}Ah! {#Prev}I fear the river denizens will not approach this evening if I'm there, for they can sense me every now and then. Apologies." },
			},

			MorosFishing01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				UnfilledIcon = "EmptyHeartWithLuresIcon",
				FilledIcon = "FilledHeartWithLuresIcon",
				HintId = "Codex_FishingGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				Cost =
				{
					GiftPointsEpic = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift03" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					{
						Path = { "CurrentHubRoom", "Name" },
						IsNone = { "Hub_PreRun"},
					},
				},
				{ Cue = "/VO/Melinoe_0937", UsePlayerSource = true,
					Text = "Say, Lord Moros, would you accompany me to the riverside? I've a feeling your mere presence may help with the evening's catch." },
				{ Cue = "/VO/Moros_0123",
					PostLineRemoveContextArt = true,
					Portrait = "Portrait_Moros_Pleased_01",
					PortraitExitAnimation = "Portrait_Moros_Pleased_01_Exit",
					Text = "I have a way with mortal creatures of all sorts, so I'll accompany you, yes." },

				{ Cue = "/VO/Moros_0321",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Forgive me, though I never have quite understood the compulsion to extract water-creatures from their natural environs. I know for mortals it is sometimes necessary sustenance, though others do it for the sake of sport. Why?" },
				{ Cue = "/VO/Melinoe_3239", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "For mortals, it seems to be an opportunity to assert themselves over the natural world. Though I would take no pride in outsmarting such creatures if I were them. In our case... we safeguard habitats for all the species that we find." },
				{ Cue = "/VO/Moros_0322",
					SkipContextArt = true,
					PreLineAnim = "Moros_Perplexed_End",
					Text = "That seems like a burdensome responsibility for creatures that ought to take better care of themselves." },
				{ Cue = "/VO/Melinoe_3240", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Well, there's more to it, I suppose. For one thing it sets a contemplative mood, right? Means we can talk a little about matters unrelated to our {#Emph}own {#Prev}burdensome responsibilities." },
				{ Cue = "/VO/Moros_0323",
					SkipContextArt = true,
					Text = "I can certainly appreciate that part. And now we wait...",
					PortraitExitAnimation = "Portrait_Moros_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 }, },

				{ Cue = "/VO/Moros_0361",
					PreLineFunctionName = "FishingPierEndPresentation",

					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Portrait = "Portrait_Moros_Pleased_01",
					Text = "Perhaps it's good to let the mind wander a bit to such pursuits, every once in a while." },
			},

		},

		MissingDistanceTrigger =
		{
			WithinDistance = 500,
			VoiceLines =
			{
				{
					BreakIfPlayed = true,
					RandomRemaining = true,
					UsePlayerSource = true,
					SuccessiveChanceToPlayAll = 0.1,
					PlayOnceFromTableThisRun = true,
					SkipCooldownCheckIfNonePlayed = true,
					GameStateRequirements =
					{
						{
							Path = { "PreviousDeathAreaRoom", "Name" },
							IsNone = { "Hub_PreRun" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},
					{ Cue = "/VO/Melinoe_1150", Text = "Lord Moros is away..." },
					{ Cue = "/VO/Melinoe_1151", Text = "Where's Lord Moros?" },
				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Moros_01",
			CooldownTime = 7,

			-- Pathetic.
			-- { Cue = "/VO/Hades_0050", Text = "Pathetic." },
		},

		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1149", Text = "How thoughtful, I accept!" },
		},
		
		Using =
		{
			Sounds = 
			{
				"/Leftovers/SFX/RobeFlutter",
				"/Leftovers/World Sounds/Caravan Interior/CobwebClear",
				"/Leftovers/World Sounds/Caravan Interior/ClothInteract2",
				"/Leftovers/World Sounds/Caravan Interior/ClothInteract",
				"/Leftovers/SFX/RobeFlutterInScene",
			},
		},
	},

}
OverwriteTableKeys( EnemyData, UnitSetData.NPC_Moros )

-- Global Moros Lines
GlobalVoiceLines.MorosLastStandSurvivedLines =
{
	GameStateRequirements =
	{
		{
			PathTrue = { "CurrentRun", "CurrentRoom", "LastStandsUsed", "BlockDeathLastStand" },
		},
		{
			Path = { "CurrentRun", "CurrentRoom", "LastStandsUsed" },
			HasNone = { "Default", "LastStandFamiliar" },
		},
	},
	Queue = "Interrupt",
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 1.0,
	Cooldowns =
	{
		{ Name = "MorosBlockedDeathSpeech", Time = 360 },
	},

	{ Cue = "/VO/Moros_0649", Text = "Doom averted." },
	{ Cue = "/VO/Moros_0650", Text = "Keep going." },
	{ Cue = "/VO/Moros_0651", Text = "Impressive." },
	{ Cue = "/VO/Moros_0652", Text = "Such tenacity." },
	{ Cue = "/VO/Moros_0653", Text = "Fight on.", PlayFirst = true },
	{ Cue = "/VO/Moros_0654", Text = "Proceed." },
	{ Cue = "/VO/Moros_0655", Text = "Unexpected..." },
	{ Cue = "/VO/Moros_0656", Text = "Close call." },
	{ Cue = "/VO/Moros_0657", Text = "Well done." },
	{ Cue = "/VO/Moros_0658", Text = "Survived again." },
}