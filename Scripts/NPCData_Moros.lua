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
		SpeakerName = "Moros",

		ActivateRequirements =
		{
			{
				PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
			},
			{
				PathTrue = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },
			},
			{
				PathFalse = { "CurrentRun", "TextLinesRecord", "MorosGrantsSurfacePenaltyCure01" },
			},
		},

		PreBathAnimationName = "Moros_Greet",
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
			[1] =
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
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
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
				{ Cue = "/VO/Moros_0207", Text = "Proceed with care." },
				{ Cue = "/VO/Moros_0090", Text = "To your success." },
				{ Cue = "/VO/Moros_0091", Text = "To victory." },
				{ Cue = "/VO/Moros_0087", Text = "Fates protect you." },
			},
		},

		EntranceVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.7,

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
				},
				SkipContextArt = true,

				{ Cue = "/VO/Moros_0128", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Text = "Princess of the Underworld: I regret having to contact you at such a time. It's not my custom to intervene during moments of Doom, only to observe." },
				{ Cue = "/VO/Melinoe_1582", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "{#Emph}Moments of Doom.... {#Prev}You're Lord Moros, emissary of the Three Fates! So your sisters heard me after all!" },
				{ Cue = "/VO/Moros_0129",
					Text = "They expected me to find you, for there's something they intend for you to have. Wherever you're going, look for it when you arrive. I'm uncertain if we'll meet again; farewell." },
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
				},
				SkipContextArt = true,

				{ Cue = "/VO/Moros_0132",
					Text = "Again our journeys intertwine. Why did you call upon me, Princess? Did you not receive the artifact I brought you from the Fates?" },
				{ Cue = "/VO/MelinoeField_1694", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Lord Moros...! I did receive the Fated List, and summoned you once more as it ordained. All children of Nyx are welcome where I reside. Might we speak further there...? I've many questions." },
				{ Cue = "/VO/Moros_0133",
					-- PreLineAnim = "Moros_Salute",
					Text = "I don't know whether I can answer them, as my own search for truth has not been going well of late. But I'll not decline your cordial invitation. Please lead the way." },
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
					Text = "...You traveled to the surface. Knowing full well the Fates decided long ago that those of your line could not survive there, and would always be forced back to the Underworld." },
				{ Cue = "/VO/MelinoeField_0812", UsePlayerSource = true,
					Text = "Their curse was... palpable. I never intended to stay for long. Just long enough to lend my relatives support. But it seems your sisters insist that I do no such thing." },
				{ Cue = "/VO/Moros_0298",
					Text = "Well... I don't see them around right now, do you? Incidentally, there once was an incantation that I happened upon, which was not intended for my eyes. But I now choose to think that it was intended for yours." },
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

		},

		InteractTextLineSets =
		{
			MorosFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosSecondAppearance" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0135",
					-- PreLineAnim = "Moros_Perplexed_Start",
					-- PostLineAnim = "Moros_Perplexed_End",
					-- PreLineAnim = "Moros_Pensive_Start",
					-- PostLineAnim = "Moros_Pensive_End",
					-- PreLineAnim = "Moros_Greet",
					-- PreLineAnim = "Moros_Salute",
					-- PreLineAnim = "Moros_Considers",
					-- PreLineAnim = "Moros_Attention",
					Text = "Princess! We've not met formally. I'm the Official Bearer of Bad News. The Witch of the Crossroads apprised me of the situation here, and... was gracious to invite me to stay for now." },
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0145",
					Text = "Are you all right, Princess? I'm realizing that whenever you return, it's likely due to some unfortunate result. One I might have easily anticipated in the past, but not anymore..." },
				{ Cue = "/VO/Melinoe_2057", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must know what I'm about to ask, Lord Moros... especially since I promised many questions. You mentioned you were on a fruitless search. What was it that you sought?" },
				{ Cue = "/VO/Moros_0138",
					PreLineAnim = "Moros_Attention",
					Text = "Oh! Well, the Fates do like to send me off to fetch them this or that, now and again. My search in some respects was similar. Though, I'm beginning to think they tricked me..." },
				{ Cue = "/VO/Melinoe_1804", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They sent you to find something that couldn't be found. And, you can't just tell me what it is, can you?" },
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "When you and I first met, you were searching for the Fates. But you discovered {#Emph}me {#Prev}among the shadows. I can navigate back to the Crossroads that way... but you can go farther?" },
				{ Cue = "/VO/Moros_0143",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I can, yes. I'm from the deepest reaches of the Underworld, where there exists no light at all. The chasm from which all creation sprang a while back." },
				{ Cue = "/VO/Melinoe_2056", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "TextLinesRecord", "ChronosNightmare01", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0873", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have to ask you something, Lord Moros, though I think I may already have the answer. Has the war with Chronos and Olympus taken some new turn?" },
				{ Cue = "/VO/Moros_0034",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I'm sorry I can't answer you, Princess. I'm bound never to speak of matters in connection to the weavings of the Fates. If you knew more right now, it could unduly influence your path." },
				{ Cue = "/VO/Melinoe_0874", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						-- PathFalse = { "GameState", "ScreensViewed", "QuestLog" },
					},
					RequiredMinQuestsComplete = 1,
					RequiredMaxQuestsComplete = 12,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0140",
					Text = "If I may, Princess? The Fated List of Minor Prophecies... have you been able to make use of it?" },
				{ Cue = "/VO/Melinoe_1805", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have. Thank you for bringing it to me. So then, the Fates already know what's going to happen in all this? Everything I'm going to do?" },
				{ Cue = "/VO/Moros_0039",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Well, yes and no. The Fated List says as little of your future as necessary. I briefly was its host, myself, and saw there but a single prophecy... that I would pass it on to you." },
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
						-- PathFalse = { "GameState", "ScreensViewed", "QuestLog" },
						PathFalse = { "GameState", "TextLinesRecord", "MorosAboutQuestLog03" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "MorosAboutQuestLog01" }, Count = 3 },
					RequiredMinQuestsComplete = 5,
					RequiredMaxQuestsComplete = 25,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0141",
					Text = "The Fated List continues to unfold, so thank you. While the Fates often let events unfold naturally, at times they value an additional degree of certainty. And are willing to make it worthwhile." },
				{ Cue = "/VO/Melinoe_0878", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					RequiredMinQuestsComplete = 10,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
				
				{ Cue = "/VO/Melinoe_2059", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I confess I feel a bit self-conscious that the Fated List is there for you and all to see. Some of the matters it describes are rather personal." },
				{ Cue = "/VO/Moros_0147",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "If it's any comfort, the prophecies appear only to you. We see there only what's meant for us. Although, when you fulfill a prophecy... I can usually tell. It's like a sudden realization." },
				{ Cue = "/VO/Melinoe_2060", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We know our paths are intertwined to an extent. Well, may your sudden realizations connected to my actions not be {#Emph}too {#Prev}embarrassing." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
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
					RequiredMinQuestsComplete = 12,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
				
				{ Cue = "/VO/Melinoe_2061", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know, some of these Fated prophecies are rather substantial. I shudder to think what might be on a list of {#Emph}major {#Prev}prophecies..." },
				{ Cue = "/VO/Moros_0149",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I trust this doesn't make you feel as though your service hasn't been of value, because certainly it has. However, the prophecies listed there are indeed minor, in the grand scheme of things." },
				{ Cue = "/VO/Melinoe_2062", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					RequiredMinQuestsComplete = 10,
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,
				
				{ Cue = "/VO/Moros_0154",
					Text = "Your father once was bearer of the Fated List, you know. A {#Emph}House-warming {#Prev}gift, my sisters said. But Hades put it away... until your brother unearthed it from the archives, and started using it himself." },
				{ Cue = "/VO/Melinoe_2067", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0180",
					Text = "A Pitch-Black Stone has been here this entire time, and I failed to detect it. I fear I'm beginning to slip up more often than acceptable." },
				{ Cue = "/VO/Melinoe_3119", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathFalse = { "GameState", "ScreensViewed", "Shrine" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0313",
					Text = "The Oath of the Unseen is somewhere here, isn't that so, Princess...? The aura that it emanates... I haven't felt it since before all this. I thought the Oath was lost with Mother Nyx, but it was in the care of Lady Hecate." },
				{ Cue = "/VO/Melinoe_3121", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's in my own care now. The will of Night shall be done, no matter what, isn't that so? You're here among the Unseen; you know our charge." },
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
						PathFalse = { "GameState", "TextLinesRecord", "MorosGift05", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0880", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hail, Lord Moros. How have you been acclimating so far? Is there something we can do to make your stay more comfortable?" },
				{ Cue = "/VO/Moros_0042",
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
						--
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0881", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What did you use to do, Lord Moros? I mean before all this. I have only the vaguest sense of it." },
				{ Cue = "/VO/Moros_0043",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "I served my sisters the Three Fates, both as their advocate, and as their guardian. The Fates determine when mortal lives draw to a close, and also sometimes {#Emph}how. {#Prev}I would bear witness to these more-specific weavings..." },
				{ Cue = "/VO/Melinoe_0882", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Shades around here... I know they've been avoiding you, Lord Moros. Some are filled with fear. Others with contempt. You ended their lives?" },
				{ Cue = "/VO/Moros_0045",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "It never was for me to decide why a mortal's life should suddenly be cut short. But, I did get to choose the {#Emph}how {#Prev}of it. Knowing the future could be monotonous work, so my sisters and I tried to keep things... interesting." },
				{ Cue = "/VO/Melinoe_0884", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You brought misery to mortals because you were bored?" },
				{ Cue = "/VO/Moros_0046",
					Text = "I'm not proud of it. Especially not when you put it that way. And I regret I've caused dissension in your ranks." },
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutDoom01", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0047",
					Text = "You said something before to me, Princess. Concerning mortalkind. That surely they {#Emph}appreciate my diligence{#Prev}, because I'm with them in the final moments of their lives. The truth of it, however, is they hate me; most of them. In life, as well as death." },
				{ Cue = "/VO/Melinoe_0886", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I appreciate your candor. What you say aligns with some of the rumblings I've heard from Shades loyal to us. Though, it's strange, Lord Moros. Your reputation is one thing; but {#Emph}you{#Prev}, it seems, are entirely another." },
				{ Cue = "/VO/Moros_0048",
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

			MorosAboutForesight01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutFates03" },
					}
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0899", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You used to know everything that was going to occur, didn't you, Lord Moros? Up until recently, from what I gathered. I can't imagine..." },
				{ Cue = "/VO/Moros_0057",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Well, imagine it being rather dull, always knowing what's to come. But now I'm no different than you. How do you... get by like this? Many surprises are unwelcome, yet there also can be pleasant ones, true?" },
				{ Cue = "/VO/Melinoe_0900", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0901", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Something the matter, Lord Moros? You seem more ill-at-ease than usual. If there's additional bad news you're at liberty to share, I'm listening." },
				{ Cue = "/VO/Moros_0059",
					PreLineAnim = "Moros_Salute",
					Text = "Oh, {#Emph}haha! {#Prev}It's nothing of the sort, at least for now, Princess. It's just... this sensation of uncertainty. Not just in the grander scheme, but even from one evening to the next... I'm still unused to it." },
				{ Cue = "/VO/Melinoe_0902", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutForesight02", },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0061",
					Text = "I've been attempting what you said before, to focus on a present state of mind. It's proving difficult, because... my mind invariably drifts to many possibilities of negative outcomes." },
				{ Cue = "/VO/Melinoe_0903", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm familiar with that feeling. We have to consider favorable outcomes side-by-side, and plan for them. Then, at a certain point, all we can do is hope..." },
				{ Cue = "/VO/Moros_0062",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Hope... I much prefer a sense of certainty. It's odd to think that my sisters the Fates, to others, represent sheer chance. Matters beyond one's control. Yet to me, they made everything so clear. I'd rather trust than hope." },
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
					Text = "There's so much here for me to learn! Lady Hecate has been generous enough to teach me something of the herbal ways, and of your craft. An everlasting pursuit! I'm getting a late start." },
				{ Cue = "/VO/Melinoe_0905", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2087", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, you must know something of the Nocturnal Arms. So, your mother and sisters collaborated on these weapons to be used only in dire need? And entrusted them to Headmistress?" },
				{ Cue = "/VO/Moros_0176",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Mother Nyx knew the fickle nature of the Olympians and the Fate-forged weapons that they used to seal away the Titans. She desired a set of counterparts that would awaken only if the realm itself was in upheaval." },
				{ Cue = "/VO/Melinoe_2088", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I suppose there ought to be another set of weapons forged to keep these in check, and another for those, and so on." },
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
						PathTrue = { "GameState", "WeaponsUnlocked", "TorchDetonateAspect" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3155", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I figured that you knew something of the Nocturnal Arms, Lord Moros. But your connection to Ygnium, I'd not have guessed. You once wielded the Umbral Flames yourself! I revealed an Aspect of them that could only be your own." },
				{ Cue = "/VO/Moros_0315",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Princess, I take it you're not saying this to humor me, so please believe in turn that I have never used the Flames before; I know them only by their reputation. Can you be certain that this Aspect is my own? I've many relatives..." },
				{ Cue = "/VO/Melinoe_3156", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I... yes, I think it is. The Nocturnal Arms bond with their bearers in such a way that their connections to other bearers become almost like shared memories. Although..." },
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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

			MorosAboutRelationship01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift06" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0161",
					Text = "I've been thinking more about what you said at the taverna, Princess. About finding one's source of motivation, whether through encouraging results or through adversity. Or more Nectar." },
				{ Cue = "/VO/Melinoe_2072", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh I wasn't being serious about the Nectar part. It's just, I find it remarkable sometimes that adversity and negativity spurs me more fiercely than an expression of faith and support..." },
				{ Cue = "/VO/Moros_0162",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Moros_Salute",				
					Text = "{#Emph}Hah! {#Prev}As a force of adversity and negativity myself, I appreciate your open-mindedness. But I wanted to say that Nectar's quite a motivator, too. I trust we can share one again sometime." },
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
					-- @ update with additional requirements
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "MorosAboutRelationship01", "DoraWithMoros02" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "MorosAboutRelationship01" }, Count = 3 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0163",
					Text = "I have a bit of an awkward question, Princess. What is the custom here for making declarations of affection? I did try asking Dora first, but she didn't give me practical advice." },
				{ Cue = "/VO/Melinoe_2074", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Erm... {#Prev}declarations of affection. I'm afraid I have bad news in that there is no custom for that here. You just choose the moment to express yourself, and hope your feelings are reciprocated." },
				{ Cue = "/VO/Moros_0164",
					PreLineAnim = "Moros_Perplexed_Start",
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
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you for visiting me last night, Lord Moros. So, hypothetically, if I were to complete a certain incantation that somehow loosened the grip the Three Fates have on my birthright... how angry would they be?" },
				{ Cue = "/VO/Moros_0299",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Please understand, Princess, that I am not at liberty to give advice on matters such as that, not even hypothetically. I trust I've been sufficiently direct in putting it this way?" },
				{ Cue = "/VO/Melinoe_3147", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0301",
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "Princess, officially I cannot condone your actions. Your visits to the surface violate the terms the Fates set for your father's lineage, and you invite whichever consequences they see fit." },
				{ Cue = "/VO/Melinoe_3148", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
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

				{ Cue = "/VO/Moros_0306",
					Text = "How far were you able to go last night, Princess? You were gone for some time. I sensed the growing fear and excitement in the air, even heard some of the rumblings." },
				{ Cue = "/VO/Melinoe_3150", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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

			MorosAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0891", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Moros... I understand you can't reveal the weavings of the Fates. But, could you just tell me what the three of them are like?" },
				{ Cue = "/VO/Moros_0051",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "My sisters. They... well, each is her own goddess, I suppose. Clotho the spinstress is the talkative one, the decisive one. Lachesis is a little more agreeable; she apportions the thread. And Atropos, she sticks to the cutting." },
				{ Cue = "/VO/Melinoe_0892", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				},
				-- OnQueuedFunctionName = "NPCFollowPath",
				-- OnQueuedFunctionArgs = PresetEventArgs.MorosPathArgs,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2998", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "...My task began immediately following reports that Chronos found a way to gain the upper hand against Olympus. We just didn't know which sort of way. But, now I think I do: your sisters the Three Fates... he got them, didn't he? Is that why you're here?" },
				{ Cue = "/VO/Moros_0157",
					PreLineWait = 0.35,
					PreLineAnim = "Moros_Perplexed_Start",
					PostLineAnim = "Moros_Perplexed_End",
					Text = "...You ask while making clear to me that you already know. I ought to have been there when it happened. Perhaps the Fates knew I lacked the strength to protect them; so they protected me." },
				{ Cue = "/VO/Melinoe_0894", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
				EndFunctionName = "NPCFollowPath",
				EndFunctionArgs = PresetEventArgs.MorosPathArgs,
			},
			MorosAboutFates03 =
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

				{ Cue = "/VO/Melinoe_0896", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, you said before you think Chronos is going to influence the weavings of the Fates. You mean he's going to try to change the future? Force a favorable outcome?" },
				{ Cue = "/VO/Moros_0055",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Yes. I think he's already trying to do just that. Unfortunately for him, the Three Fates can be a bit headstrong. I trust they may be quite resistant as captives." },
				{ Cue = "/VO/Melinoe_0897", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can't imagine Chronos tolerating insolence, whether from your sisters or anybody else. How he must hate them! When he was overthrown before, that was the outcome of a fated prophecy..." },
				{ Cue = "/VO/Moros_0056",
					PreLineAnim = "Moros_Pensive_End",
					Text = "Indeed. As for now, I sense there are no weavings happening at all. No new futures foretold. Chronos believes he has no prophecy to fear. Yet, I believe this is an opportunity for you. To make a better future for us all." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_0898", Text = "{#Emph}<Gasp>" },
					},
				},
				EndFunctionName = "NPCFollowPath",
				EndFunctionArgs = PresetEventArgs.MorosPathArgs,
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0151",
					Text = "Your family has been of keen interest to the Fates for some time, hasn't it? Ever since Chronos learned he was doomed to be usurped by his own children." },
				{ Cue = "/VO/Melinoe_2064", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A prophecy that was only fulfilled because Chronos learned of it, and desperately tried to prevent it from coming to pass. Perhaps I'd have an easier time with the Fated List if I try to thwart it at every turn." },
				{ Cue = "/VO/Moros_0152",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "I wouldn't second-guess too much. Later your father and uncles drew lots to divide up their rule of the world. By {#Emph}chance{#Prev}, your father wound up with the least desirable part, didn't he?" },
				{ Cue = "/VO/Melinoe_2065", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps the Underworld best suited him. So now it's my turn to see that the will of the Fates is done? If they even planned this far ahead." },
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2069", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How can you be so certain that there are no more weavings taking place? That rather than the Fates setting the course of our lives, there's no pattern anymore... only sheer, mindless chance?" },
				{ Cue = "/VO/Moros_0158",
					PreLineAnim = "Moros_Considers",
					Text = "I never said I was certain... only that I no longer sensed my sisters' work, and it's a relatively well-honed sense. But, I've also never been apart from my sisters like this. I feel... unmoored." },
				{ Cue = "/VO/Melinoe_2070", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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

			MorosAboutNyx01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_0888", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must know the Three Fates better than anyone, besides maybe Nyx, herself! {#Emph}Erm{#Prev}, though, forgive me for invoking her..." },
				{ Cue = "/VO/Moros_0049",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "It's quite all right. The Fates, I know full well, but Mother Nyx...? We saw her seldomly. The nature of our work was such that even she would almost never get involved. Besides, she'd many other children to attend to." },
				{ Cue = "/VO/Melinoe_0889", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm sorry to hear that. My mother's the Queen. We've never even met since I was an infant. Nobody around here seems to know their blasted mothers, come to think!" },
				{ Cue = "/VO/Moros_0050",
					PreLineAnim = "Moros_Perplexed_End",
					Text = "Come now, the mothers can't be blamed. We children can be so insufferable, true?" },
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
						PathTrue = { "CurrentRun", "UseRecord", "TrialUpgrade" },
					},
					-- @ update with add't'l requirements (timeout)
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3116", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How well would you say you know your grandparent, Lord Moros? I'd not expected to meet Primordial Chaos of all beings. But they summoned me to their domain, and... I don't quite know what they want from me." },
				{ Cue = "/VO/Moros_0304",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Chaos summoned you...? That is unusual, though not entirely without precedent. And in this case, I can imagine why. Chaos and Mother Nyx were rather close, after all." },
				{ Cue = "/VO/Melinoe_3117", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "GameState", "TextLinesRecord", "ChaosAboutChronosNightmare01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3152", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I learned what happened to the Fates, Lord Moros. Or rather, how Chronos discovered where they were. It was Chaos who led Chronos to them. Chaos, of course, seems to regret this now, and I don't think had any ill intent..." },
				{ Cue = "/VO/Moros_0309",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "Oh. That is a lot of information to take in. It does make some amount of sense. Chronos, having free reign in your father's House, eventually found his way to Chaos, then coaxed this vital information out of them. Then, he ambushed the Fates, as part of his plans for conquest." },
				{ Cue = "/VO/Melinoe_3153", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're taking all this better than I would have. Come to think of it, I've never seen you angry." },
				{ Cue = "/VO/Moros_0310",
					PreLineAnim = "Moros_Pensive_End",
					Text = "You're seeing me right now. It's just, my anger changes nothing, typically. So, Chaos now is working to undo some of the damage caused? Chronos removed one threat in the Fates, but created another. Perhaps an unwise trade." },
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Nemesis_01", },
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
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Whatever could have given you such an impression, Lord Moros? Perhaps all our incessant squabbles over petty things?" },
				{ Cue = "/VO/Moros_0121",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "They can't be petty things if they're of your concern, or for that matter, hers. I understand there's some dispute about your task. You were chosen for it, she was not. True?" },
				{ Cue = "/VO/Melinoe_0932", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						HasAll = {  "MorosAboutNemesis01", "NemesisGift05", "NemesisAboutCombatFailure01", "NemesisPostCombatAboutArmor01" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0171",
					PreLineAnim = "Moros_Considers",
					Text = "You and Nemesis appear to have been interacting in a more productive way of late. If I may ask, what changed between you two?" },
				{ Cue = "/VO/Melinoe_2082", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					AreIdsAlive = { 585573 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0317",
					Text = "I'd ask what my sister Eris is doing here, but then they say {#Emph}wheresoever goes Doom, Strife follows. {#Prev}Or the other way around, whether I like it or not. Has she been here long?" },
				{ Cue = "/VO/Melinoe_3158", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "CurrentRun", "RoomsEntered", "O_Boss01" },
					},
					-- @ update with add't'l requirements
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_3160", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Eris outright attacked me, just as I was approaching Mount Olympus. Who gave her the Adamant Rail, anyway? A weapon once used to slay Titans, turned against the gods..." },
				{ Cue = "/VO/Moros_0319",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "The Rail {#Emph}has {#Prev}turned against the gods before. Only the Fates know its true and final purpose... but Eris has it by their own decree. Perhaps as a plaything to keep her occupied." },
				{ Cue = "/VO/Melinoe_3161", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "To keep {#Emph}me {#Prev}occupied, apparently. Makes me wonder if the Fates want Chronos stopped, or not. Did you and Eris ever fight like this?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Moros_01",
						{ Cue = "/VO/Moros_0320", Text = "Oh, yes. Much as I tried to avoid it." },					},
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
						Path = { "GameState", "UseRecord", "NPC_Odysseus_01", },
						Comparison = ">=",
						Value = 3,
					},
					AreIdsAlive = { 557112 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Moros_0173",
					PreLineAnim = "Moros_Salute",
					Text = "I'm attempting to contain my enthusiasm for the venerable hero of mortalkind over there, Princess. Our adversary may be crafty, but Odysseus is renowned for his wiles above all." },
				{ Cue = "/VO/Melinoe_2084", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "GameState", "TextLinesRecord", "DoraWithMoros01", },
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
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2085", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Arachne_01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.MorosGreeting,

				{ Cue = "/VO/Melinoe_2080", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, I've a friend who lives in the woods called Arachne. Long story, but she was on the receiving end of a powerful curse that... changed her into a spider. Do you deal in curses at all?" },
				{ Cue = "/VO/Moros_0169",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "I remember the case of Arachne. I didn't know what became of her after her metamorphosis, so... it's interesting to learn that you are friends. But no... I'm afraid curses aren't my specialty." },
				{ Cue = "/VO/Melinoe_2081", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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

			-- partner conversations
			MorosWithOdysseus01 =
			{
				Partner = "NPC_Odysseus_01",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosAboutOdysseus01" },
					},
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
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
					MinRunsSinceAnyTextLines = { TextLines = { "MorosWithOdysseus01" }, Count = 3 },
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
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
				{ Cue = "/VO/Moros_0196",
					PreLineAnim = "Moros_Salute",
					Text = "{#Emph}Ah{#Prev}, indeed... but how was this a weakness? As I understand, your wife Penelope stood by your side despite your indiscretions... I trust I do not overstep; I know this can be a sensitive topic with those from the surface." },
				{ Cue = "/VO/Odysseus_0238", Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					Text = "Aye, Penelope stood by my side... because I only told her so much about my {#Emph}indiscretions{#Prev}, as you call them. Then when we reunited after death, I had to tell her the rest. She had spent her best years awaiting an unfaithful man." },
				{ Cue = "/VO/Moros_0197",
					Text = "I see. After everything you'd been through, did your relationship end in an amicable way, at least?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0171", Text = "Aye, surprisingly enough... it did." },
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
						PathTrue = { "CurrentRun", "RoomsEntered", "N_Boss01" }
					},
					MinRunsSinceAnyTextLines = { TextLines = { "MorosWithOdysseus02" }, Count = 3 },
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				-- StatusAnimation = false,
				TeleportToId = 557112,
				TeleportOffsetX = 100,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 557112,
				InteractDistance = 300,
				{ Cue = "/VO/Moros_0329",
					PreLineAnim = "Moros_Salute",
					Text = "...The wooden horse was an exquisite trick. Your own inevitable Doom, misdirected toward your unsuspecting foes! A masterstroke. But my personal favorite had to be the Polyphemus incident..." },
				{ Cue = "/VO/Odysseus_0226", Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					PreLineAnim = "Odysseus_Greet",
					PreLineAnimTarget = 557112,
					Text = "You speak of it like an old action yarn. Big bastard massacred my crew. My heart threatened to burst from my chest getting past him, and {#Emph}now {#Prev}he's up to his old antics with the Goddess there." },
				{ Cue = "/VO/Moros_0330",
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
						PathTrue = { "GameState", "TextLinesRecord", "CharonAboutFates01" }
					},
					MinRunsSinceAnyTextLines = { TextLines = { "MorosWithCharon02" }, Count = 3 },
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				-- StatusAnimation = false,
				TeleportToId = 589589,
				-- TeleportOffsetX = 100,
				-- TeleportOffsetY = 100,
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
					AreIdsNotAlive = { 585573 },
					MinRunsSinceAnyTextLines = { TextLines = { "MorosWithCharon01" }, Count = 3 },
				},

				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
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
				},

				PlayOnce = true,
				UseableOffSource = true,
				-- GiftableOffSource = true,
				-- UseText = "UseListenNPC",
				-- BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				-- StatusAnimation = false,
				TeleportToId = 566612,
				TeleportOffsetX = 250,
				TeleportOffsetY = 100,
				AngleTowardTargetId = 370024,
				InteractDistance = 300,
				{ Cue = "/VO/Hypnos_0006", Portrait = "Portrait_Hypnos_Sleeping_01", Speaker = "NPC_Hypnos_01",
					-- Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Zzzzzzzzz{#Prev}...." },
				{ Cue = "/VO/Moros_0067",
					PreLineAnim = "Moros_Pensive_Start",
					Text = "How strange to be encountering this brother of mine here. So then he truly hasn't stirred at all?" },
				{ Cue = "/VO/Melinoe_0907", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
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
					MinRunsSinceAnyTextLines = { TextLines = { "MorosWithEris02" }, Count = 5 },
				},
				BlockDistanceTriggers = true,
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
						HasAll = { "MorosGift03" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisGift01", "ErisGift01_B" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "MorosWithEris01" }, Count = 5 },
				},
				BlockDistanceTriggers = true,
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

			-- Partner Conversations
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
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0025",
					Text = "Always a pleasure, Princess. Though, please... don't let me keep you." },
				OnQueuedFunctionName = "NPCFollowPath",
				OnQueuedFunctionArgs = PresetEventArgs.MorosPathArgs,
			},
			MorosChat23 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0029",
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0030",
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift05", },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Moros",
				{ Cue = "/VO/Moros_0032", PreLineWait = 0.35,
					Text = "...Forgive me, Princess. I... I need some time to think." },
			},
			MorosChat30 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01", },
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
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, as our honored guest, {#Emph}erm{#Prev}, we wanted you to have this. To make your stay a bit more comfortable." },
				{ Cue = "/VO/Moros_0069",
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift01" },
					},
				},
				{ Cue = "/VO/Moros_0070",
					PreLineAnim = "Moros_Attention",
					Text = "{#Emph}Huh! {#Prev}I must admit I'm unaccustomed to displays of flattery. Forgive me, I don't quite know what to say, except... thank you." },
				{ Cue = "/VO/Melinoe_0910", UsePlayerSource = true,
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift02" },
					},
				},
				{ Cue = "/VO/Moros_0071",
					Text = "You're very kind to me, Princess. I arrived at these Crossroads in a desperate state. I didn't expect to be made welcome here." },
				{ Cue = "/VO/Melinoe_0911", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift03" },
					},
				},
				{ Cue = "/VO/Moros_0072",
					Text = "Why, thank you for this, truly, though you needn't go out of your way for me. You've been so generous. Forgive my asking, but... this isn't due to some sort of prophecy in the Fated List, is it?" },
				{ Cue = "/VO/Melinoe_0912", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}No! {#Prev}No, of course not, Lord Moros. Although, even if it was, I would be duty-bound not to inform you, wouldn't I?" },
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
						PathTrue = { "GameState", "TextLinesRecord", "MorosGift04" },
					},
				},
				{ Cue = "/VO/Moros_0074",
					Text = "I'm honored to accept this, Princess Melinoë. When the Fates first indicated that we'd meet, I asked them what I should expect; what you were like. Clotho smiled and simply said, {#Emph}you'll see. {#Prev}I felt certain they were playing a prank!" },
				{ Cue = "/VO/Melinoe_0913", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You make me glad I don't have any sisters, Lord Moros. So what would you have said in Clotho's place?" },
				{ Cue = "/VO/Moros_0075",
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
			-- taverna
			MorosTaverna01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UseableOffSource = true,
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
				},
				{ Cue = "/VO/Melinoe_0915", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Moros, I wanted you to have this either way, though if you're not too busy at the moment, would you care to share it with me at the taverna? I know this is sudden, it's just... I'm past due for a little break..." },

				{ Cue = "/VO/Moros_0076",
					PreLineAnim = "Moros_Greet",
					PortraitExitAnimation = "Portrait_Moros_Default_01_Exit",
					Text = "Princess Melinoë, it would be my pleasure. Would you please lead the way?" },

				{ Cue = "/VO/Melinoe_0916", UsePlayerSource = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...So, it {#Emph}can {#Prev}be a lot, of course. I don't know what's the better source of motivation, those completely certain I'll succeed in everything, or those completely certain that I'll fail." },

				{ Cue = "/VO/Moros_0077",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Moros_Salute",
					Text = "{#Emph}Hah! {#Prev}I have the same thought pattern frequently. The Fates, they could anticipate the outcomes of my efforts and would chastise me sometimes for small mistakes I'd yet to make. It wasn't always as encouraging as intended." },

				{ Cue = "/VO/Melinoe_0917", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "Then, where did you find the strength? Your responsibilities sound like they must have been a lot." },

				{ Cue = "/VO/Moros_0078",
					Text = "It all simply became a force of habit at some point. You practice a skill to a level of proficiency, then fear letting it go... fear you'll never be as capable at other things..." },

				{ Cue = "/VO/Melinoe_0918", UsePlayerSource = true,
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "I wouldn't have expected Doom himself to harbor such misgivings." },

				{ Cue = "/VO/Moros_0079",
					PreLineAnim = "Moros_Pensive_Start",
					PostLineAnim = "Moros_Pensive_End",
					Text = "Well! Perhaps I should have been born as {#Emph}Fear! {#Prev}So then where do {#Emph}you {#Prev}think it comes from? Your source of motivation for your task." },

				{ Cue = "/VO/Melinoe_3353", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					PortraitExitAnimation = "Portrait_Mel_Pleased_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "I've decided it comes from the thought of finding more of this Ambrosia out there; this is {#Emph}good!" },

				{ Cue = "/VO/Moros_0081",
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
			
			-- placeholder
			MorosGiftTemp =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				UnfilledIcon = "UnavailableHeartIcon",
				HintId = "Codex_UnavailableHint",
				Cost =
				{
					MysteryResource = 1,
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
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},		
				{ Cue = "/VO/Melinoe_3555", UsePlayerSource = true,
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
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
				},
				{ Cue = "/VO/Melinoe_0921", UsePlayerSource = true,
					Text = "Have you experienced our hotsprings yet, Lord Moros? The waters cleanse the body and the mind. I'm headed over if you'd care to join me?" },
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
					Text = "I've not felt so refreshed in... well, it's been a while now. Thank you again." },
			},
			MorosBathHouse02 =
			{
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
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
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
					Text = "I think I really needed that. And always wonderful to have your company." },
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
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
				},		
				{ Cue = "/VO/Melinoe_3501", UsePlayerSource = true,
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
						Path = { "CurrentRun", "GiftResourceRecord" },
						HasNone = { "GiftPointsRare", "GiftPointsEpic" },
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
					PortraitExitAnimation = "Portrait_Moros_Default_01_Exit",
					Text = "I have a way with mortal creatures of all sorts, so I'll accompany you, yes." },

				{ Cue = "/VO/Moros_0321",
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					PreLineAnim = "Moros_Perplexed_Start",
					Text = "Forgive me, though I never have quite understood the compulsion to extract water-creatures from their natural environs. I know for mortals it is sometimes necessary sustenance, though others do it for the sake of sport. Why?" },
				{ Cue = "/VO/Melinoe_3239", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "For mortals, it seems to be an opportunity to assert themselves over the natural world. Though I would take no pride in outsmarting such creatures if I were them. In our case... we safeguard habitats for all the species that we find." },
				{ Cue = "/VO/Moros_0322",
					SkipContextArt = true,
					PreLineAnim = "Moros_Perplexed_End",
					Text = "That seems like a burdensome responsibility for creatures that ought to take better care of themselves." },
				{ Cue = "/VO/Melinoe_3240", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkBrooding01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Well there's more to it, I suppose. For one thing... it sets a contemplative mood, right? Means we can talk a little about matters unrelated to our {#Emph}own {#Prev}burdensome responsibilities." },
				{ Cue = "/VO/Moros_0323",
					SkipContextArt = true,
					Text = "I can certainly appreciate that part. And now we wait...",
					PortraitExitAnimation = "Portrait_Moros_Default_01_Exit",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 }, },

				{ Cue = "/VO/Moros_0361",
					PreLineFunctionName = "FishingPierEndPresentation",

					PortraitExitAnimation = "Portrait_Moros_Default_01_Exit",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash" },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

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
					GameStateRequirements =
					{
						AreIdsNotAlive = { 560612 },
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
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Moros )