UnitSetData.NPC_Artemis =
{
	-- Artemis, Id = TKTK (Field Version Below)
	NPC_Artemis_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Artemis_Default_01",
		AnimOffsetZ = 0,
		Groups = { "NPCs" },
		SubtitleColor = Color.ArtemisVoice,
		SpeakerName = "Artemis",
		ThemeMusic = "/Music/ArtemisTheme_MC",
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		TurnInPlaceAnimation = "Artemis_Turn",

		ActivateRequirements =
		{
			-- None
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				-- PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			[1] =
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_1711", Text = "Together we shine, Sister.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1697", Text = "Together we shine." },
				{ Cue = "/VO/Melinoe_0025", Text = "Together we shine." },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.35,
				ObjectTypes = { "NPC_Artemis_Field_01", "NPC_Artemis_01" },
				PreLineAnim = "Artemis_Salute",
				-- PreLineThreadedFunctionName = "PlayCharacterAnim",
				-- PreLineThreadedFunctionArgs = { Name = "Artemis_Salute", WaitTime = 1, AngleNPCToHero = true, },

				{ Cue = "/VO/Artemis_0130", Text = "Moonlight guide you." },
				{ Cue = "/VO/Artemis_0125", Text = "Together we shine.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0025", "/VO/Melinoe_1697", "/VO/Melinoe_1711", "/VO/Melinoe_2785", "/VO/Melinoe_2787" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0132", Text = "Stay safe, Sister.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2", "/VO/Melinoe_1711", "/VO/Melinoe_2785", "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0137", Text = "{#Emph}Erm{#Prev}, hey?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0241", Text = "Together we shine!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_0025", "/VO/Melinoe_1697", "/VO/Melinoe_1711", "/VO/Melinoe_2785", "/VO/Melinoe_2787" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0242", Text = "Hello again.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0243", Text = "Hey.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2784" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0244", Text = "He's marked.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0245", Text = "You, too.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0246", Text = "You as well.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2785", "/VO/Melinoe_2786" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0247", Text = "And our aim be true.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_2787", "/VO/Melinoe_2788" },
						},
					},
				},

			},
		},

		InteractTextLineSets =
		{
			-- story events (home)
			ArtemisHubFirstMeeting01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead", },
					},
					{
						PathFalse = { "CurrentRun", "Cleared" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisAboutMission01" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "MorosGrantsQuestLog", "MorosSecondAppearance", "MorosGrantsSurfacePenaltyCure01", },
					},
					AreIdsAlive = { 556921 },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.ArtemisGreeting,

				{ Cue = "/VO/Artemis_0152",
					Text = "Hey Melinoë, I just wrapped a debrief here with Sister Hecate. This place has changed a {#Emph}lot {#Prev}since last I checked!" },
				{ Cue = "/VO/Melinoe_1187", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hi Artemis, welcome! We've had to scramble a bit to make ready for everything. Can I show you around? Have you said hi to Nemesis?" },
				{ Cue = "/VO/Artemis_0153",
					PreLineAnim = "Artemis_Shrug",
					PostLineThreadedFunctionName = "ArtemisExitPresentation", PostLineFunctionArgs = { AnimationState = "Artemis_Disappear", WaitTime = 3.1 },
					Text = "Oh, {#Emph}no{#Prev}, I have to go. Olympus needs me back up top, at least a little while. Maybe next time, all right?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_1188", Text = "I hear you. Bye for now." },
					},
				},
			},

		},

		GiftTextLineSets =
		{
			ArtemisGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Melinoe_1194", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It's been a pleasure to have worked more closely with you, Sister Artemis. This is hardly worth the gift of impeccable precision, though I wanted you to have it." },
				{ Cue = "/VO/Artemis_0163",
					PreLineAnim = "Artemis_Shrug",
					Text = "Doing the old traditions now, are we? Well sure, then I accept your offering, Sister Melinoë. And I've an offering for {#Emph}you{#Prev}, in kind!" },
			},
			ArtemisGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0164",
					PreLineAnim = "Artemis_Shrug",
					Text = "You do know we have {#Emph}barrels {#Prev}of this stuff up on Olympus, right? Used to, at least. Damn near forgotten what it tastes like, come to think..." },
				{ Cue = "/VO/Melinoe_1195", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "May the good memories come flooding back! Whenever you have the time for it, of course." },
			},

			ArtemisGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0189",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 1 },
					Text = "What's all this extra generosity from you lately? It's putting me on edge. Don't you go acting like this is goodbye...!" },
				{ Cue = "/VO/Melinoe_2341", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's merely that the arrow-riddled remnants of my foes give me occasion to reflect! I tell myself never to take my dear friends for granted." },
			},

			ArtemisGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0190",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 1 },
					Text = "I can't exactly drink this on the hunt, you know! But I can squirrel it away for safekeeping. Maybe once all this is settled, we can share a bottle and get properly caught up." },
				{ Cue = "/VO/Melinoe_2342", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Or, failing that, we could always keep on teaming against vengeful spirits and the like! Although it's nice to keep the possibility in mind." },
			},

			ArtemisGift05 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0191",
					Text = "Hey, thank you! Sure enough, Olympus started running a little low on this stuff. I'll be sure to lord it over the others, long as you don't mind me exploiting your good graces." },
				{ Cue = "/VO/Melinoe_3502", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't recall anything about exploiting one another's good graces in the bylaws of the Silver Sisters, so you should be fine! May you enjoy it either way." },
			},

			ArtemisGift06 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				Cost =
				{
					GiftPoints = 1,
				},
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				{ Cue = "/VO/Artemis_0192",
					PreLineWait = 0.35,
					Text = "...Hard making friends with goddesses, but I have what {#Emph}I {#Prev}need. We can be on our own without feeling alone, you know? I hope you know. That's how it is for me." },
				{ Cue = "/VO/Melinoe_3503", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I do know, and feel much the same. When we're not watching one another's backs, we have Selene and Headmistress watching over us. Still, it's always good to see you face-to-face." },
				{ Cue = "/VO/Artemis_0193",
					Text = "You, too. Most of my family I can do without most of the time. You're an exception! We may not be sisters by blood, but... you'll always be Sister Melinoë to me." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_3504", Text = "Likewise, Sister Artemis." },
					},
				},

			},

			-- placeholder
			ArtemisGiftTemp =
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

		},
		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/Melinoe_1732", Text = "Truly? You're the best." },
		},

		EncounterStartVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1.15,
				Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
				Cooldowns =
				{
					{ Name = "ArtemisAnyQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/Artemis_0036", Text = "Finally tracked you down...", PlayFirst = true },
				{ Cue = "/VO/Artemis_0037", Text = "Got here as quickly as I could." },
				{ Cue = "/VO/Artemis_0038", Text = "I have your back, Sister!" },
				{ Cue = "/VO/Artemis_0039", Text = "Multiple targets sighted." },
				{ Cue = "/VO/Artemis_0040", Text = "This won't take long." },
				{ Cue = "/VO/Artemis_0041", Text = "Hold on, Sister!" },
				{ Cue = "/VO/Artemis_0042", Text = "They won't know what hit them." },
				{ Cue = "/VO/Artemis_0043", Text = "Let's take these wretches down." },
				{ Cue = "/VO/Artemis_0044", Text = "Oh good, some target practice then!" },
				{ Cue = "/VO/Artemis_0045", Text = "Providing covering fire!" },
				{ Cue = "/VO/Artemis_0046", Text = "There they are..." },
				{ Cue = "/VO/Artemis_0047", Text = "There you are..." },
				{ Cue = "/VO/Artemis_0048", Text = "The hunt is on..." },
				{ Cue = "/VO/Artemis_0049", Text = "Found you." },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				PreLineWait = 0.15,
				SuccessiveChanceToPlay = 0.75,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},

				{ Cue = "/VO/Melinoe_1238", Text = "I know that voice...", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1239", Text = "Artemis...!" },
				{ Cue = "/VO/Melinoe_1240", Text = "You wretches are in for it now." },
				{ Cue = "/VO/Melinoe_1241", Text = "Take your shot, Sister!" },
				{ Cue = "/VO/Melinoe_1242", Text = "Just watch your aim!" },
				{ Cue = "/VO/Melinoe_1243", Text = "You're just in time." },
				{ Cue = "/VO/Melinoe_1244", Text = "I'll keep them busy for you!" },
			}
		},

		PlayerInjuredReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
			Cooldowns =
			{
				{ Name = "ArtemisAnyQuipSpeech", Time = 40 },
			},

			{ Cue = "/VO/Artemis_0078", Text = "Careful!" },
			{ Cue = "/VO/Artemis_0079", Text = "Watch out!" },
			{ Cue = "/VO/Artemis_0080", Text = "Get back!" },
			{ Cue = "/VO/Artemis_0081", Text = "You OK?" },
			{ Cue = "/VO/Artemis_0082", Text = "Steady, Sister!" },
			{ Cue = "/VO/Artemis_0083", Text = "Damn it!" },
			{ Cue = "/VO/Artemis_0084", Text = "Stand clear!" },
			{ Cue = "/VO/Artemis_0085", Text = "They'll pay for that!" },
		},
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
			Cooldowns =
			{
				{ Name = "ArtemisLastStandSpeech", Time = 40 },
			},
			TriggerCooldowns =
			{
				"ArtemisAnyQuipSpeech",
			},
			{ Cue = "/VO/Artemis_0235", Text = "No, hold on...!" },
			{ Cue = "/VO/Artemis_0236", Text = "Damn it...!" },
			{ Cue = "/VO/Artemis_0237", Text = "Melinoë...!" },
			{ Cue = "/VO/Artemis_0238", Text = "You all right?!", PlayFirst = true },
			{ Cue = "/VO/Artemis_0239", Text = "Take cover...!" },
			{ Cue = "/VO/Artemis_0240", Text = "Fall back...!" },
		},

		KillingEnemyVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlay = 0.75,
				Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
				Cooldowns =
				{
					{ Name = "ArtemisAnyQuipSpeech", Time = 20 },
				},

				{ Cue = "/VO/Artemis_0050", Text = "One less." },
				{ Cue = "/VO/Artemis_0051", Text = "One down." },
				{ Cue = "/VO/Artemis_0052", Text = "Target down." },
				{ Cue = "/VO/Artemis_0053", Text = "Got one." },
				{ Cue = "/VO/Artemis_0054", Text = "Got that one." },
				{ Cue = "/VO/Artemis_0055", Text = "Got 'em." },
				{ Cue = "/VO/Artemis_0056", Text = "There." },
				{ Cue = "/VO/Artemis_0057", Text = "Easy." },
				{ Cue = "/VO/Artemis_0058", Text = "Simple." },
				{ Cue = "/VO/Artemis_0059", Text = "Next." },
				-- { Cue = "/VO/Artemis_0060", Text = "See that?" },
				{ Cue = "/VO/Artemis_0061", Text = "{#Emph}Hah!" },
				{ Cue = "/VO/Artemis_0062", Text = "{#Emph}Hmph." },
				{ Cue = "/VO/Artemis_0063", Text = "Who else..." },
				-- { Cue = "/VO/Artemis_0223", Text = "Down." },
				{ Cue = "/VO/Artemis_0224", Text = "Down..." },
				-- { Cue = "/VO/Artemis_0225", Text = "It's down." },
				-- { Cue = "/VO/Artemis_0226", Text = "It's down." },
			},
			{
				UsePlayerSource = true,
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				SuccessiveChanceToPlay = 0.02,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns =
				{
					"ArtemisAnyQuipSpeech",
				},

				{ Cue = "/VO/Melinoe_1245", Text = "Nice shot!", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_1246", Text = "How does she do that...?" },
				{ Cue = "/VO/MelinoeField_2097", Text = "Perfect." },
				{ Cue = "/VO/MelinoeField_2098", Text = "Down!" },
				{ Cue = "/VO/MelinoeField_2099", Text = "...Ouch." },
				{ Cue = "/VO/MelinoeField_2100", Text = "Good shot." },
				{ Cue = "/VO/MelinoeField_2101", Text = "Thank you...!" },
				{ Cue = "/VO/MelinoeField_2102", Text = "Got 'em." },
			}
		},

		KillStolenVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.5,
			Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
			Cooldowns =
			{
				{ Name = "ArtemisKillStealSpeech", Time = 40 },
				{ Name = "ArtemisAnyQuipSpeech", Time = 12 }
			},

			{ Cue = "/VO/Artemis_0072", Text = "I had that one!" },
			{ Cue = "/VO/Artemis_0073", Text = "I had that..." },
			{ Cue = "/VO/Artemis_0074", Text = "Beat me to that one." },
			{ Cue = "/VO/Artemis_0075", Text = "Beat me to it...", PlayFirst = true },
			{ Cue = "/VO/Artemis_0076", Text = "That was mine." },
			{ Cue = "/VO/Artemis_0077", Text = "That was my mark." },
		},

		EncounterEndVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1.65,

				{ Cue = "/VO/Artemis_0086", Text = "That's all of them." },
				{ Cue = "/VO/Artemis_0087", Text = "Area secure." },
				{ Cue = "/VO/Artemis_0088", Text = "All clear." },
				{ Cue = "/VO/Artemis_0089", Text = "Short work!" },
				{ Cue = "/VO/Artemis_0090", Text = "That ought to do it!", PlayFirst = true },
				{ Cue = "/VO/Artemis_0091", Text = "Hail, Sister." },
				{ Cue = "/VO/Artemis_0092", Text = "Hail, Sister!" },
				{ Cue = "/VO/Artemis_0093", Text = "Good evening." },
				{ Cue = "/VO/Artemis_0094", Text = "Fancy running into {#Emph}you {#Prev}again!" },
				{ Cue = "/VO/Artemis_0095", Text = "So how's it going?" },
				{ Cue = "/VO/Artemis_0096", Text = "Thought I'd drop in!" },
				{ Cue = "/VO/Artemis_0097", Text = "Peace and quiet." },
				{ Cue = "/VO/Artemis_0098", Text = "You all right?",
					GameStateRequirements =
					{
						RequiredMaxHealthFraction = 0.6,
					},
				},
				{ Cue = "/VO/Artemis_0099", Text = "Damn, you're hurt...",
					GameStateRequirements =
					{
						RequiredMaxHealthFraction = 0.3,
					},
				},
				{ Cue = "/VO/Artemis_0100", Text = "That got ugly...",
					GameStateRequirements =
					{
						RequiredMaxHealthFraction = 0.3,
					},
				},
			},
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,
				Cooldowns =
				{
					-- { Name = "MelinoeAnyQuipSpeech", Time = 60 },
				},

				{ Cue = "/VO/Melinoe_1094", Text = "Artemis!" },
				{ Cue = "/VO/Melinoe_1095", Text = "Hail, Sister." },
				{ Cue = "/VO/Melinoe_1247", Text = "Good work." },
				{ Cue = "/VO/Melinoe_1248", Text = "Appreciate the backup." },
				{ Cue = "/VO/Melinoe_1249", Text = "Sister Artemis!" },
				{ Cue = "/VO/Melinoe_1250", Text = "There you are." },
				{ Cue = "/VO/Melinoe_1251", Text = "Good evening!", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1252", Text = "You're in top form!" },
			},
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				PreLineWait = 0.75,
				Queue = "Always",
				ObjectType = "NPC_Artemis_Field_01",
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
				},

				{ Cue = "/VO/Artemis_0126", Text = "All right, I'm off." },
				{ Cue = "/VO/Artemis_0127", Text = "Farewell for now." },
				{ Cue = "/VO/Artemis_0128", Text = "Fight on, Sister." },
				{ Cue = "/VO/Artemis_0129", Text = "Go find your mark.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "SpeechRecord" },
							HasNone = { "Artemis_0123", "Artemis_0122" },
						},
					},
				},
				{ Cue = "/VO/Artemis_0130", Text = "Moonlight guide you." },
				{ Cue = "/VO/Artemis_0131", Text = "Till we meet again." },
				{ Cue = "/VO/Artemis_0132", Text = "Stay safe, Sister." },
				{ Cue = "/VO/Artemis_0133", Text = "Good hunting." },
				{ Cue = "/VO/Artemis_0134", Text = "See you." },
				{ Cue = "/VO/Artemis_0135", Text = "Got to go." },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				SuccessiveChanceToPlay = 0.5,
				PreLineWait = 0.35,

				{ Cue = "/VO/Melinoe_1253", Text = "Farewell." },
				{ Cue = "/VO/Melinoe_1254", Text = "Good hunting.", PlayFirst = true, },
				{ Cue = "/VO/Melinoe_1255", Text = "Fight on." },
				{ Cue = "/VO/Melinoe_1256_C", Text = "See you." },
				{ Cue = "/VO/Melinoe_1257", Text = "Go unseen." },
				{ Cue = "/VO/Melinoe_1258", Text = "Let's do this again sometime." },
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
					AreIdsNotAlive = { 370006 },

				},
			},
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Artemis_Field_01",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
			},
			Cooldowns =
			{
				{ Name = "ArtemisAnyQuipSpeech", Time = 40 },
			},

			{ Cue = "/VO/Artemis_0105", Text = "Sister?" },
			{ Cue = "/VO/Artemis_0106", Text = "Come off it." },
			{ Cue = "/VO/Artemis_0107", Text = "No time to spar.", PlayFirst = true },
			{ Cue = "/VO/Artemis_0108", Text = "Don't take it out on me." },
			{ Cue = "/VO/Artemis_0109", Text = "Focus, Sister." },
			{ Cue = "/VO/Artemis_0110", Text = "{#Emph}<Sigh...>" },
		},
	},

	-- Artemis, field version
	NPC_Artemis_Field_01 =
	{
		InheritFrom = { "NPC_Artemis_01" },
		GenusName = "NPC_Artemis_01",
		OnUsedFunctionName = "UseLoot",
		OnUsedFunctionArgs = { SkipInteractAnim = true, SkipSound = true, PackageName = "NPC_Artemis_Field_01" },
		PostPickupFunctionName = "ArtemisExitPresentation",
		PostPickupFunctionArgs = { WaitTime = 3.5 },
		AnimOffsetZ = 0,

		NonHeroKillCombatText = "PartnerKill",
		TreatAsGodLootByShops = true,
		RequiredRoomInteraction = true,
		SkipAISetupOnActivate = true,
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		Weight = 10,
		LightingColor = {210, 255, 97, 255},
		LootColor = {110, 255, 0, 255},
		SubtitleColor = Color.ArtemisVoice,
		UpgradeScreenOpenSound = "/SFX/ArtemisBoonArrow",
		UpgradeSelectedSound = "/SFX/ArtemisBoonChoice",
		LootRejectionAnimation = "BoonDissipateA_Artemis",
		MenuTitle = "UpgradeChoiceMenu_Artemis",
		EchoLastRewardId = "EchoLastRewardBoon_Artemis",
		PriorityUpgrades = { },
		PackageName = "NPC_Artemis_Field_01",
		Traits = { 
			"SupportingFireBoon", 
			"CritBonusBoon", 
			"DashOmegaBuffBoon", 
			"HighHealthCritBoon", 
			"InsideCastCritBoon",
			"OmegaCastVolleyBoon",
			"TimedCritVulnerabilityBoon",
		},
		Consumables = { },
		RarityChances =
		{
			Rare = 0.0,
			Epic = 0.0,
		},
		
		RarityRollOrder = { "Common", "Rare", "Epic" },
		Speaker = "NPC_Artemis_01",
		Portrait = "Portrait_Artemis_Default_01",
		WrathPortrait = "Portrait_Artemis_Wrath_01",
		OverlayAnim = "ArtemisOverlay",
		Gender = "Female",
		SpawnSound = "/SFX/ArtemisBoonArrow",
		FlavorTextIds =
		{
			"ArtemisUpgrade_FlavorText01",
			"ArtemisUpgrade_FlavorText02",
			"ArtemisUpgrade_FlavorText03",
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Artemis_01", SubtitleColor = Color.ArtemisVoice },
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					--
				},
				
				{ Cue = "/VO/Artemis_0111", Text = "For your journey." },
				{ Cue = "/VO/Artemis_0112", Text = "My blessings..." },
				{ Cue = "/VO/Artemis_0113", Text = "For you." },
				{ Cue = "/VO/Artemis_0114", Text = "Here's what I have." },
				{ Cue = "/VO/Artemis_0115", Text = "The choice is yours." },
				{ Cue = "/VO/Artemis_0116", Text = "Here." },
			},
			[2] = GlobalVoiceLines.FoundRareBoonVoiceLines,
		},

		--SpawnAnimation = "ThanatosTalkDismissal",
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleScale = 1.33,
		DefaultAIData =
		{
			TeleportStartFx = "ArtemisTeleportFx",
			TeleportEndFx = "ArtemisTeleportFx",

			TargetRequiredKillEnemy = true,
			TargetClosestToPlayer = true,
			IgnoreInvulnerable = true,
			AIWanderDistance = 200,
		},
		AIWakeDelay = 3.0,
		OutgoingCritModifiers =
		{
			{
				Chance = 1.0,
			}
		},
		AIOptions = { "AttackerAI" },
		PostCombatAI = "ArtemisPostCombat",
		PostCombatTeleportIfPastDistance = 800,

		WeaponOptions = { "ArtemisSniper", "ArtemisSniper", "ArtemisHuntersMark", "ArtemisHuntersMark",
							 "ArtemisHealDrop", "ArtemisHealDrop", "ArtemisHealDrop", "ArtemisHealDrop", },
		OutgoingDamageModifiers =
		{
			{
				PlayerMultiplier = 0,
			}
		},
		IncomingDamageModifiers =
		{
			{
				Name = "Innate",
				PlayerMultiplier = 0.0,
			}
		},

		ActivateRequirements =
		{
			-- None
		},

		InteractTextLineSets =
		{
			ArtemisFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
					},
				},
				{ Cue = "/VO/Artemis_0167",
					Text = "It's been too long, Sister. Look at you, on your great hunt! Not ideal circumstances but you've finally begun. Know that the family has your back, surprised as they are about this." },
				{ Cue = "/VO/Melinoe_1179", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No shortage lately of surprises on Olympus or below. It's good to see you, Artemis. But, I must be off. Time's against us, and all that." },
				{ Cue = "/VO/Artemis_0168",
					Text = "{#Emph}Time{#Prev}'s an old fool too busy besieging the mountain of the gods to sense the threat headed his way. Go get him." },
			},

			-- low health
			ArtemisLowHealth01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.3,
				},
				{ Cue = "/VO/Artemis_0151",
					Text = "Oh, you look like {#Emph}hell{#Prev}, Sister. Don't have anything to patch you up, but I {#Emph}can {#Prev}help you kill the wretches that did this to you!" },
			},

			-- story events
			ArtemisAboutApollo01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				{ Cue = "/VO/Artemis_0171",
					Text = "Has my little brother lived up to his shining reputation so far? At least he did his part. Soon as I told him about {#Emph}you{#Prev}, sure enough he was plenty eager to let all Olympus know." },
				{ Cue = "/VO/Melinoe_1180", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Apollo was very kind. Though, easy for me to say, I'm not his twin. What'd you tell him anyway?" },
				{ Cue = "/VO/Artemis_0172",
					Text = "Only the truth! That I ran into the reclusive Witch of the Crossroads while scouting out our foe... and that she introduced me to a secret {#Emph}Titan killer {#Prev}she's been training up." },
				{ Cue = "/VO/Melinoe_1181", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You just didn't tell him how long ago that was. So now they really think this long-lost relative of theirs is going to find Chronos and slay him?" },
				{ Cue = "/VO/Artemis_0173",
					PreLineAnim = "Artemis_Shrug",
					Text = "Oh, they think you don't stand a chance! But they don't have a lot of options, so... they'll support you anyway, especially since you're family and all. And you know {#Emph}I {#Prev}will." },
			},

			ArtemisAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "EnemyKills", "Hecate" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
				},
				{ Cue = "/VO/Artemis_0159",
					Text = "You bested Sister Hecate! She told me so herself, and with dare-I-say more than a hint of pride. Though, she's intent on testing you still?" },
				{ Cue = "/VO/Melinoe_1192", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "She always said I can't beat Chronos if I can't beat her. And so we spar. I think she's gone easy on me, to boost my confidence." },
				{ Cue = "/VO/Artemis_0160",
					PreLineAnim = "Artemis_Shrug",
					Text = "Well, I can plainly see she failed. Gone {#Emph}easy? {#Prev}If there's one thing the Witch of the Crossroads hasn't ever done, it's that." },
			},

			-- alt below
			ArtemisAboutSelene01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutSelene01_B" },
					},
				},
				{ Cue = "/VO/Artemis_0146",
					Text = "I can often depend on Sister Selene's light to guide me on my hunts. But where you're going, she can't follow, can she? Nor can I." },
				{ Cue = "/VO/Melinoe_1184", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And Headmistress Hecate is needed at the Crossroads. I alone have the authority to enter the House of Hades. If I can make it there." },
				{ Cue = "/VO/Artemis_0147",
					PreLineAnim = "Artemis_Shrug",
					Text = "Hey, what do you mean {#Emph}if? {#Prev}It's a matter of {#Emph}when{#Prev}, as far as I'm concerned. I'm thinking maybe very {#Emph}soon{#Prev}, in fact." },
			},
			ArtemisAboutSelene01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "SpellDrop" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutSelene01" },
					},
				},
				{ Cue = "/VO/Artemis_0198",
					Text = "I can often depend on Sister Selene's light to guide me on my hunts. But where you're going, she can't follow easily, can she? Nor can I." },
				{ Cue = "/VO/MelinoeField_2138", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sister Selene has her ways, though I know it's difficult for her, and Headmistress is needed at the Crossroads. I alone have the authority to enter the House of Hades. But I'd have never gotten there without you all." },
				{ Cue = "/VO/Artemis_0199",
					PreLineAnim = "Artemis_Shrug",
					Text = "Could {#Emph}really {#Prev}use a proper hunting party for this one! Fortunately it's kind of our thing as Silver Sisters to not have to be in the same place at the same time." },
			},

			ArtemisAboutHermes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesFirstPickUp" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutFates01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeAltRunDoor" },
					},
				},
				{ Cue = "/VO/Artemis_0148",
					Text = "Hermes finally got a hold of you, did he? Sounds like things have really taken a turn on Olympus. Glad I'm not there!" },
				{ Cue = "/VO/Melinoe_1185", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Artemis, how can you say that? It's your home. I'm going to see if I can head up there and lend a hand." },
				{ Cue = "/VO/Artemis_0149",
					Text = "Is that even possible for you, born of the Underworld and all that? Then again, you're a witch! Must have a remedy for everything!" },
			},

			ArtemisAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisPostCombatFirstMeeting", "NemesisGetFreeItemIntro01", "ArtemisGift03", "NemesisGift03", "NemesisAboutArtemis02" }, 
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirements = { "NoRecentNemesisEncounter" },
				},
				{ Cue = "/VO/MelinoeField_2141", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You haven't seen Nemesis tonight, have you? Not that she should be anywhere near here, as opposed to keeping watch over the gateways at the Crossroads." },
				{ Cue = "/VO/Artemis_0206",
					PreLineAnim = "Artemis_Shrug",
					Text = "I haven't seen her, no. But I was tracking her! Those footprints are only slightly harder to spot than {#Emph}she {#Prev}is. She's not supposed to be out here, is she..." },
				{ Cue = "/VO/MelinoeField_2142", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineWait = 0.35,
					Text = "...That she is not. She's just trying to make herself useful, I get it. And the Fates themselves know that I probably could use the help. Though, how have you two been?" },
				{ Cue = "/VO/Artemis_0207",
					Text = "We each need company, we each need solitude, the same old thing. She's frustrated, which can go a couple of ways depending on the night. Anyway, she's a big girl!" },
			},

			ArtemisAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
				},
				{ Cue = "/VO/Artemis_0202",
					Text = "It's really true about the Fates, that Chronos somehow got to them? Doesn't want to take any chances anymore. Did the Fates prophesize their own captivity...?" },
				{ Cue = "/VO/MelinoeField_2139", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How can you be so casual about this? If the Fates themselves couldn't stop Chronos, we won't have an easy time! We're beholden to chance ourselves." },
				{ Cue = "/VO/Artemis_0203",
					PreLineAnim = "Artemis_Shrug",
					Text = "So what if we are! You know not even {#Emph}I {#Prev}always hit my mark. What do I do if I miss? {#Emph}I take another shot. {#Prev}The greater the skill, the less is up to chance." },
			},

			ArtemisAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Artemis_0157",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 1 },
					Text = "It's strange, isn't it? He's our own grandfather... Chronos, I mean. But, I feel no connection to him at all! I just want him gone." },
				{ Cue = "/VO/Melinoe_1191", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Doesn't matter who he is; he's a threat. We're the Silver Sisters. We'll {#Emph}make {#Prev}him gone. For the sake of the realms." },
				{ Cue = "/VO/Artemis_0158",
					-- PreLineAnim = "Artemis_Shrug",
					Text = "Strictly business then, is it? Even still, funny how it falls on {#Emph}us {#Prev}to settle the older generation's scores." },
			},
			ArtemisAboutChronosBossL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Boss01" },
					},
				},
				{ Cue = "/VO/Artemis_0194",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Artemis_Shrug", WaitTime = 1 },
					Text = "Got all the way down to the House of Hades, so I heard. Must be nice having fated authority over the lowest reaches of the Underworld... unless you're Chronos." },
				{ Cue = "/VO/MelinoeField_2136", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He was most certainly annoyed. Wields a scythe that's twice my height, surrounds himself with feral Satyr-worshipers ready to die for him. I'm not surprised it once took both our fathers and more to bring him down." },
				{ Cue = "/VO/Artemis_0195",
					-- PreLineAnim = "Artemis_Shrug",
					Text = "No reason to compare yourself. They're high and mighty lords of the heavens and the Underworld, but they fought Chronos by necessity. You were trained to do {#Emph}precisely this." },
			},
			ArtemisAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EnemyKills", "Chronos" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				{ Cue = "/VO/Artemis_0196",
					Text = "You found Chronos... sank your fangs into his throat. Sister Hecate gave me the gist. How'd you do it...? Found some exploitable weakness, something like that?" },
				{ Cue = "/VO/MelinoeField_2137", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Mostly I just kept evading a lot. He's very powerful, but must have underestimated my ability to resist his tricks." },
				{ Cue = "/VO/Artemis_0197",
					-- PreLineAnim = "Artemis_Shrug",
					Text = "He won't always underestimate you, though. Must have his vulnerabilities. {#Emph}The old are seldom wise, and often weak{#Prev}, right? He's bloodied... go for the kill." },
			},

			ArtemisAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeMorosUnlock" },
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Artemis_0169",
					Text = "Hey, is it really true Moros himself showed up at your Crossroads because you {#Emph}summoned {#Prev}him? As in, you {#Emph}literally invited Doom...?" },
				{ Cue = "/VO/MelinoeField_2019", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It doesn't seem the wisest course when you put it that way. Chronos once was brought low by a prophecy of the Three Fates. I felt they might be willing to intervene again." },
				{ Cue = "/VO/Artemis_0170",
					PreLineAnim = "Artemis_Shrug",
					Text = "And they did so by sending you the embodiment of misfortune and unforeseen consequences. Well if that's what the Fates have in store, you're going to need {#Emph}this." },
			},

			ArtemisAboutMission01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2131", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why has Olympus sent you all the way out here, anyway? I thought you'd have gone back by now. You're always welcome in the Crossroads!" },
				{ Cue = "/VO/Artemis_0179",
					Text = "Appreciate it, Sister, and I might stop by, but... I don't mind the woods. As for why I'm all the way out here, mostly to spy on you! Olympus likes to be informed." },
				{ Cue = "/VO/MelinoeField_2132", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm certain that they do. Do you ever slip up with them? By now the other gods must have their suspicions about you and Hermes." },
				{ Cue = "/VO/Artemis_0180",
					PreLineAnim = "Artemis_Shrug",
					Text = "Depends on who you're talking about I guess, but for the most part they just think we're young and flighty. But we're the best they've got." },
			},

			ArtemisAboutSilverSisters01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift01" },
					},
				},
				{ Cue = "/VO/Artemis_0181",
					Text = "When I became one of the Silver Sisters, I figured all we'd really do was stalk in shadows, make occasional reports... but this is a full-on {#Emph}worst-case scenario!" },
				{ Cue = "/VO/MelinoeField_2133", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You sound excited rather than dismayed. You must have known it'd come to this eventually. Not like Headmistress would band us together just for ceremony's sake." },
				{ Cue = "/VO/Artemis_0182",
					PreLineAnim = "Artemis_Shrug",
					Text = "No, I guess you're right. Still, we've been together biding our time for so long... I got to thinking we might never get the opportunity to strike. Yet here we are!" },
			},

			ArtemisAboutFamily01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Melinoe_1186", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've been so far from home for so long. Don't you miss being on Olympus? If not now, then... back before the Titan's siege?" },
				{ Cue = "/VO/Artemis_0150",
					PreLineAnim = "Artemis_Shrug",
					Text = "What, you mean being with my father and stepmother, my perfect twin brother, and all the rest? Just because I'm willing to aid them doesn't mean I'm willing to live with them again." },
			},
			ArtemisAboutFamily02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "AphroditeFirstPickUp", "HephaestusUpgrade", "HestiaUpgrade" },
					},
				},
				{ Cue = "/VO/Artemis_0165",
					Text = "So what do you think of the family? Most of them are stuck on their mountaintop, though... you've seen what they're like." },
				{ Cue = "/VO/Melinoe_2340",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh they don't seem so bad! Especially things being as they are. But you can't stand any of them..." },
				{ Cue = "/VO/Artemis_0166",
					PreLineAnim = "Artemis_Shrug",
					Text = "Hey I wouldn't go {#Emph}that {#Prev}far! Though, yes, they can get under my skin. They're going to owe us {#Emph}big {#Prev}once all of this is over." },
			},

			--[[
			ArtemisAboutMission01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Melinoe_1189", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So when you're not aiding me in my repeated failures, what else have you been up to, Artemis? Some special quarry you're after?" },
				{ Cue = "/VO/Artemis_0154",
					Text = "There might be. Olympus has been shaking, for reasons unknown. Sister Selene asked that I look into it. Surely it's nothing, right?" },
			},
			]]--

			ArtemisAboutErebus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
				},
				{ Cue = "/VO/Artemis_0183",
					Text = "Poor wretches, left to linger here. Could be relaxing in Elysium, or Asphodel at least. No wonder they're upset." },
				{ Cue = "/VO/MelinoeField_2134",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos claimed it was an act of magnanimity, unsealing the Underworld gates, letting the dead roam free. This can't possibly be better than when my father ruled." },
				{ Cue = "/VO/Artemis_0184",
					PreLineAnim = "Artemis_Shrug",
					Text = "Hey, at least it means I can set foot in these parts without inciting some huge territorial dispute! Setting aside the fact that we're already in the middle of one." },
			},

			ArtemisAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				{ Cue = "/VO/Artemis_0204",
					Text = "Fine mess we made! Not many hiding-places here compared to Erebus. Might be the end of the line for me... I'm a huntress, not a fisher." },
				{ Cue = "/VO/MelinoeField_2140",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Fishing is a form of hunting, isn't it? Anyway I appreciate the backup, and understand if you're now at the limit of your range. Olympus probably expects you back." },
				{ Cue = "/VO/Artemis_0205",
					PreLineAnim = "Artemis_Shrug",
					Text = "They'll want to hear from me! About the situation, and about {#Emph}you{#Prev}, too. You know they still take me and Hermes for their spies? Although, we do tell them a lot..." },
			},

			ArtemisAboutSurface01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ArtemisAboutEphyra01", "ArtemisAboutPolyphemus01" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Intro" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				{ Cue = "/VO/Artemis_0174",
					Text = "You made it quite a ways up on the surface recently, Sister Selene said. Did it live up to all your hopes and dreams?" },
				{ Cue = "/VO/Melinoe_2339",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I tend to have a lot of nightmares, and it did live up to those. The dead are left to linger there. They should be safely in the Underworld!" },
				{ Cue = "/VO/Artemis_0175",
					Text = "Well, Chronos evidently has other ideas for how things should be governed. I know your main objective is below, though... thank you for any aid you can provide up top." },
			},

			ArtemisAboutSurfacePenalty01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Opening01" },
					},
				},
				{ Cue = "/VO/Artemis_0185",
					Text = "So much for visiting the surface, huh? Not seen a trace of you up there! Don't feel bad. You have nice woods here, too!" },
				{ Cue = "/VO/MelinoeField_2135",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not supposed to be up there... could hardly breathe. But there might be something I can do. Hermes wouldn't have asked me to go if it wasn't important." },
				{ Cue = "/VO/Artemis_0186",
					PreLineAnim = "Artemis_Shrug",
					Text = "No, I guess not. I'd offer to escort you though Olympus wants me to stay out of sight. And I won't bother saying not to push yourself too hard..." },
			},

			-- alt below
			ArtemisAboutEphyra01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "O" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArtemisAboutSurfacePenalty01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "ArtemisAboutEphyra01_B" },
					},
				},
				{ Cue = "/VO/Artemis_0176",
					Text = "Look at {#Emph}you{#Prev}, Sister! Your brother once had us all convinced he was trying to fight his way to Olympus. Now none of us can believe you're trying to do it for real." },
				{ Cue = "/VO/MelinoeField_2020",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've known Hermes about as long as you, and can count the number of favors he's asked of me on one hand. Besides, I could use the change of scenery." },
				{ Cue = "/VO/Artemis_0177",
					PreLineAnim = "Artemis_Shrug",
					Text = "Then by all means! What a time, that you're on your way up to the mountain while I'm on my way down to the Underworld. At least we crossed paths!" },
			},
			ArtemisAboutEphyra01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "O" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = {  "ArtemisAboutEphyra01", "ArtemisAboutSurfacePenalty01" },
					},
				},
				{ Cue = "/VO/Artemis_0176",
					Text = "Look at {#Emph}you{#Prev}, Sister! Your brother once had us all convinced he was trying to fight his way to Olympus. Now none of us can believe you're trying to do it for real." },
				{ Cue = "/VO/MelinoeField_2020_B",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hermes wouldn't have asked me to go if it wasn't important. Besides, I could use the change of scenery." },
				{ Cue = "/VO/Artemis_0177",
					PreLineAnim = "Artemis_Shrug",
					Text = "Then by all means! What a time, that you're on your way up to the mountain while I'm on my way down to the Underworld. At least we crossed paths!" },
			},

			ArtemisAboutPolyphemus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Polyphemus" },
					},
				},
				{ Cue = "/VO/Artemis_0250",
					Text = "That massive Cyclops Polyphemus... saw him fast asleep the other night! Then {#Emph}you {#Prev}were able to sneak up and incapacitate him, just like {#Emph}that! {#Prev}I stay far downwind of him, myself." },
				{ Cue = "/VO/MelinoeField_2145",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm tempted to just smile and nod through this one, Artemis, but my dealings with the Cyclops haven't involved much stealth. Though at least I can get past him, at this point." },
				{ Cue = "/VO/Artemis_0251",
					PreLineAnim = "Artemis_Shrug",
					Text = "And how do you get through the Rift beyond the docks, you {#Emph}swim? {#Prev}You still like doing things the hard way. The {#Emph}only {#Prev}way!" },
			},

			ArtemisAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
				},
				{ Cue = "/VO/Artemis_0208",
					Text = "You probably know {#Emph}Eris {#Prev}has been buzzing around Olympus recently? One good lightning bolt from Father Zeus would normally take {#Emph}care {#Prev}of that, but... he's been occupied." },
				{ Cue = "/VO/MelinoeField_2143",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "One good lightning bolt, how about one good arrow? We'd be saved a lot of trouble if Eris were to be plucked from the sky one of these nights." },
				{ Cue = "/VO/Artemis_0209",
					PreLineAnim = "Artemis_Shrug",
					Text = "I'd gladly volunteer, it's just that Father has everything {#Emph}well under control. {#Prev}Says I'm needed way out here instead. But if I do spot the wings of Strife... they're going down." },
			},

			ArtemisAboutDagger01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponDagger" },
					},
					{
						Path = { "GameState", "WeaponsFiredRecord", "WeaponDaggerDouble" },
						Comparison = "<=",
						Value = 100,
					},
				},
				{ Cue = "/VO/Artemis_0155",
					Text = "Those blades of yours doing you any good? Let me know if you need any, {#Emph}erm... pointers...?" },
				{ Cue = "/VO/Melinoe_1190", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Sister Blades are almost like having you by my side in every fight. Though, you can shoot a lot farther than I can throw..." },
				{ Cue = "/VO/Artemis_0156",
					PreLineAnim = "Artemis_Shrug",
					Text = "{#Emph}Oh{#Prev}, don't be so hard on yourself, I can shoot farther than anybody! Especially Apollo. Well, just keep going for their vitals, and you'll be fine." },
			},

			ArtemisAboutArtemisAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DaggerBlockAspect" },
					},
				},
				{ Cue = "/VO/Artemis_0210",
					Text = "Hey, I recognize those blades! Didn't want to let on before, but... now I guess you know. You best be taking care of them! " },
				{ Cue = "/VO/MelinoeField_2144", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not to worry. I am, I swear! So, {#Emph}you {#Prev}were the bearer of the Sister Blades yourself? Did you have to give them up because of me...?" },
				{ Cue = "/VO/Artemis_0211",
					PreLineAnim = "Artemis_Shrug",
					Text = "I gave them up because I did what needed to be done. Hecate so likes her little tests. Anyway I'm glad to see old Lim and Oros in good hands." },
			},


			ArtemisAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "LowHealthCritKeepsake" },
					},
				},
				{ Cue = "/VO/Artemis_0200",
					Text = "Brought the White Antler with you just in case! The stag who gave it up, it was his time. And I vowed to him I'd make it quick. His Shade and I, we still commune every so often!" },
				{ Cue = "/VO/MelinoeField_2146", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Artemis, your tales have this remarkable capacity to warm the heart and yet disturb the mind. In case you ever need a calling other than the hunt." },
				{ Cue = "/VO/Artemis_0201",
					PreLineAnim = "Artemis_Shrug",
					Text = "If none of this works out, I was thinking {#Emph}songs {#Prev}and {#Emph}music-making? {#Prev}If Apollo can do it, so can {#Emph}I. {#Prev}Though we've not tired of the hunter's life just yet." },
			},

			ArtemisAboutMoon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "==",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				{ Cue = "/VO/Artemis_0162",
					Text = "A full moon... Sister Selene's power at its peak. On nights like this, I truly feel my immortality. May our combined strength be enough." },
			},
			ArtemisSendOff01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					--
				},
				{ Cue = "/VO/Melinoe_1193", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hey, Artemis. Is everything all right?" },
				{ Cue = "/VO/Artemis_0161",
					Text = "So much to talk about, so little time, Sister. I'm needed elsewhere, but I wanted to make sure to send you off." },
			},

			ArtemisAboutRetrying01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "RoomsEntered", "H_Boss01" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "Chronos" },
					},
				},
				{ Cue = "/VO/Melinoe_1182", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "You've likely heard I didn't get there, Artemis. Didn't even come close." },
				{ Cue = "/VO/Artemis_0143",
					Text = "Sister, I have {#Emph}every {#Prev}faith in you, but not even {#Emph}I {#Prev}believed you were going to vanquish Chronos straightaway. Let's be a little realistic here?",
				},
			},

			ArtemisAboutProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					-- @ update with updated requirements
					{
					},
				},
				{ Cue = "/VO/Melinoe_1055", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Any progress yet with your investigation?" },
				{ Cue = "/VO/Artemis_0178",
					PreLineAnim = "Artemis_Shrug",
					Text = "Not near as much as I'd like. Here, let me give you a boost. Maybe you'll get somewhere even if I don't.",
				},
			},

			-- Repeatable
			ArtemisChat01 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0004",
					UseEventEndSound = true,
					Text = "Take this, Sister, and go find your mark." },
			},
			ArtemisChat02 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0005",
					UseEventEndSound = true,
					Text = "Tread ever softly and strike swift and true, Sister." },
			},
			ArtemisChat03 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0006",
					UseEventEndSound = true,
					Text = "Happened to be in the area again, so thought I'd stop on by." },
			},
			ArtemisChat04 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0007",
					UseEventEndSound = true,
					Text = "May Moonlight guide you to your prey, and expose his every weakness." },
			},
			ArtemisChat05 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0008",
					UseEventEndSound = true,
					Text = "Another night, another duty for the Silver Sisters." },
			},
			ArtemisChat06 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0009",
					UseEventEndSound = true,
					Text = "I have to say, these woods are not my favorite..." },
			},
			ArtemisChat07 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				{ Cue = "/VO/Artemis_0010",
					UseEventEndSound = true,
					Text = "I can't venture any further below, though I can give you this." },
			},
			ArtemisChat08 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0011",
					UseEventEndSound = true,
					Text = "The skilled huntress keeps her bag of tricks full and with her at all times." },
			},
			ArtemisChat09 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0012",
					UseEventEndSound = true,
					Text = "Steady yourself, Sister. You have my full support and more." },
			},
			ArtemisChat10 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0013",
					UseEventEndSound = true,
					Text = "May your aim ever be true. Not unlike mine!" },
			},
			ArtemisChat11 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0014",
					UseEventEndSound = true,
					Text = "I still think you should try a bow again sometime..." },
			},
			ArtemisChat12 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0015",
					UseEventEndSound = true,
					Text = "We hunt alone. Although these run-ins aren't so bad!" },
			},
			ArtemisChat13 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0016",
					UseEventEndSound = true,
					Text = "Always a pleasure working with you, Sister." },
			},
			ArtemisChat14 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0017",
					UseEventEndSound = true,
					Text = "Go cut that wretched Titan down to size for me, would you?" },
			},
			ArtemisChat15 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0018",
					UseEventEndSound = true,
					Text = "May none dare stand between a witch and her prey." },
			},
			ArtemisChat16 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0019",
					UseEventEndSound = true,
					Text = "Fine night for hunting Titans, don't you think?" },
			},
			ArtemisChat17 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0020",
					UseEventEndSound = true,
					Text = "Picked up the scent of a few stragglers I'll take care of after this..." },
			},
			ArtemisChat18 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0021",
					UseEventEndSound = true,
					Text = "You'll find your mark. I know you will." },
			},
			ArtemisChat19 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0022",
					UseEventEndSound = true,
					Text = "Yours is the most dangerous prey of all. I'm a bit envious!" },
			},
			ArtemisChat20 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0023",
					UseEventEndSound = true,
					Text = "Here's a little something to go with those witching arts of yours." },
			},
			ArtemisChat21 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0024",
					UseEventEndSound = true,
					Text = "I've got your back, Sister, so just keep moving forward." },
			},
			ArtemisChat22 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0025",
					UseEventEndSound = true,
					Text = "We're the Silver Sisters, and we never miss our mark." },
			},
			ArtemisChat23 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0026",
					UseEventEndSound = true,
					Text = "We are the Silver Sisters, and this is our time to shine." },
			},
			ArtemisChat24 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0027",
					UseEventEndSound = true,
					Text = "Got to say it's nice to get away from it all like this." },
			},
			ArtemisChat25 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "SpeechRecord", },
						HasNone = { "/VO/Melinoe_0229", },
					},
				},				
				{ Cue = "/VO/Artemis_0094",
					UseEventEndSound = true,
					Text = "Fancy running into you again, and here of all places!" },
			},
			ArtemisChat26 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0029",
					UseEventEndSound = true,
					Text = "You tracked {#Emph}me {#Prev}down this time, I'll have you know!" },
			},
			ArtemisChat27 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0030",
					UseEventEndSound = true,
					Text = "You were born to do this, Sister, and you're going to succeed." },
			},
			ArtemisChat28 =
			{
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0031",
					UseEventEndSound = true,
					Text = "Sure beats being back on that mountaintop, let me tell you." },
			},
			ArtemisChat29 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 1,
					},
				},
				{ Cue = "/VO/Artemis_0032",
					UseEventEndSound = true,
					Text = "The Moon is full again. May our combined might take you far." },
			},
			ArtemisChat30 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 5,
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0033",
					UseEventEndSound = true,
					Text = "A new Moon marks a new beginning, so take heart, Sister." },
			},
			ArtemisChat31 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 4,
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0034",
					UseEventEndSound = true,
					Text = "The Moon's light wanes again, but your strength needn't falter." },
			},
			ArtemisChat32 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "==",
						Value = 8,
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Artemis",
				{ Cue = "/VO/Artemis_0035",
					UseEventEndSound = true,
					Text = "As the light of the waxing Moon intensifies, so too does our potential, Sister." },
			},

		},

		-- GiftTextLineSets on NPC_Artemis_01

	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Artemis )