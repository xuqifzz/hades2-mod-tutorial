UnitSetData.NPC_Echo =
{
	-- Echo, Id = TKTK
	NPC_Echo_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Echo_Default_01",
		AnimOffsetZ = 250,
		Groups = { "NPCs" },
		LineHistoryName = "NPC_Echo_01",
		SpeakerName = "Echo",
		SubtitleColor = Color.EchoVoice,
		DisableCharacterFadeColorLag = true,
		MenuTitle = "EchoChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Echo",
		LastRewardEligible = false,
		AllowInteractDuringEndVoiceLines = true,
		FlavorTextIds =
		{
			"EchoChoiceMenu_FlavorText01",
		},
		Traits = 
		{
			"EchoLastReward",
			"EchoLastRunBoon",
			"EchoDeathDefianceRefill",
			"DiminishingDodgeBoon",
			"DiminishingHealthAndManaBoon",
		},

		RequiredRoomInteraction = true,

		ActivateRequirements =
		{
			-- None
		},

		PostActivateEvents =
		{
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
							"EchoAboutEcho01",
						},
					},
				},
			},
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.2,
				UsePlayerSource = true,
				RandomRemaining = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/MelinoeField_1198", Text = "Be at peace." },
				{ Cue = "/VO/MelinoeField_1199", Text = "Rest easy now." },
				{ Cue = "/VO/MelinoeField_1200", Text = "Till next we meet." },
				{ Cue = "/VO/MelinoeField_1201", Text = "You can do it, Mel!" },
				{ Cue = "/VO/MelinoeField_1202", Text = "Death to Chronos..." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0081", Text = "Be at peace... {#Echo1}at peace... {#Prev}{#Echo2}at peace...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1198" },
						},
					},
				},
				{ Cue = "/VO/Echo_0082", Text = "Rest easy now... {#Echo1}easy now... {#Prev}{#Echo2}easy now...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1199" },
						},
					},
				},
				{ Cue = "/VO/Echo_0083", Text = "Next we meet... {#Echo1}next we meet... {#Prev}{#Echo2}next we meet...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1200" },
						},
					},
				},
				{ Cue = "/VO/Echo_0084", Text = "Do it, Mel...! {#Echo1}Do it, Mel...! {#Prev}{#Echo2}Do it, Mel...!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1201" },
						},
					},
				},
				{ Cue = "/VO/Echo_0085", Text = "Death to Chronos... {#Echo1}to Chronos... {#Prev}{#Echo2}to Chronos...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1202" },
						},
					},
				},
			},
		},

		InteractTextLineSets =
		{
			EchoFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "UseRecord", "NPC_Echo_02" },
					},
				},

				{ Cue = "/VO/Echo_0003", SpeakerNameplateId = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Text = "I mean you no harm. {#Echo1}You no harm. {#Prev}{#Echo2}No harm. {#Prev}{#Echo3}No harm." },
				{ Cue = "/VO/MelinoeField_0739", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That makes two of us. What ails you, Shade? Is there something I could do to ease your burden?" },
				{ Cue = "/VO/Echo_0004", SpeakerNameplateId = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Text = "I could ease your burden? {#Echo1}Your burden? {#Prev}{#Echo2}Your burden?" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoLowHealth01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.33,
				},

				{ Cue = "/VO/Echo_0071",
					Text = "Just a little farther... {#Echo1}little farther... {#Prev}{#Echo2}little farther..." },
				{ Cue = "/VO/MelinoeField_1189", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you for the encouragement, Echo. It can be such a struggle getting through this place. But you seem to manage, in your own way." },
				{ Cue = "/VO/Echo_0072",
					Text = "Manage, in your own way... {#Echo1}in your own way... {#Prev}{#Echo2}your own way..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoLowHealth02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift02" },
					},
					RequiredMaxHealthFraction = 0.33,
				},

				{ Cue = "/VO/Echo_0073",
					Text = "The Nymph I wished to see...! {#Echo1}I wished to see...! {#Prev}{#Echo2}I wished to see...!" },
				{ Cue = "/VO/MelinoeField_1191", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I confess I'm in a pretty sorry state right now, Echo. But I know if I can make it this far, your blessings may be just the thing to let me go the rest of the way." },
				{ Cue = "/VO/Echo_0074",
					Text = "...rest of the way... {#Echo1}go the rest of the way... {#Prev}{#Echo2}go..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutEcho01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "UseRecord", "NPC_Echo_02" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0007", SpeakerNameplateId = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Text = "Who are you, may I ask? {#Echo1}May I ask? {#Prev}{#Echo2}May I ask?" },
				{ Cue = "/VO/MelinoeField_0744", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well I can sense you're of no danger to me, so... I am Melinoë. Family business down in Tartarus. And you are...? Do I hear an echo?" },
				{ Cue = "/VO/Echo_0008",
					Text = "I am... Echo! {#Echo1}Echo! {#Prev}{#Echo2}Echo! {#Prev}{#Echo3}Echo!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutHelp01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "UseRecord", "NPC_Echo_02" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0010",
					Text = "Is that you? {#Echo1}Is that you? {#Prev}{#Echo2}Is that you?" },
				{ Cue = "/VO/MelinoeField_1163", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's me all right, Echo. I don't know how come you've been assisting me, but I'm a long way from home and could use all the help I can get going farther." },
				{ Cue = "/VO/Echo_0011",
					Text = "Help going farther... {#Echo1}going farther... {#Prev}{#Echo2}going farther..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNymphs01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						-- PathTrue = { "GameState", "UseRecord", "NPC_Echo_02" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0013",
					Text = "Hey, it's Melinoë! {#Echo1}It's Melinoë! {#Prev}{#Echo2}Melinoë!" },
				{ Cue = "/VO/MelinoeField_0750", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's Echo! Echo! Echo! You're an Oread, aren't you? Though you're not speaking in the customary way of Mountain Nymphs... some sort of curse?" },
				{ Cue = "/VO/Echo_0014",
					Text = "Some sort of curse... {#Echo1}sort of curse... curse... {#Prev}{#Echo2}curse..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutHeart01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "EchoAboutNarcissus02" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0024",
					Text = "Poor thing... {#Echo1}poor thing... {#Prev}{#Echo2}poor thing..." },
				{ Cue = "/VO/MelinoeField_1000", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wish I knew what you were doing in a place like this. Though, you can't just tell me can you? Your heart must have been broken..." },
				{ Cue = "/VO/Echo_0025",
					Text = "Must have been broken... {#Echo1}heart broken... {#Prev}{#Echo2}heart broken..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutBridge01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0064",
					Text = "I'm doing all right! {#Echo1}Doing all right! {#Prev}{#Echo2}All right!" },
				{ Cue = "/VO/MelinoeField_1182", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So many dangers all throughout these Fields. Yet here on this bridge, I feel a sense of comfort. Even peace. It's because of your presence and your power..." },
				{ Cue = "/VO/Echo_0065",
					Text = "Your presence and your power... {#Echo1}presence and power... {#Prev}{#Echo2}presence and power..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoAboutCurse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0077",
					Text = "A welcome sight... {#Echo1}a welcome sight... {#Prev}{#Echo2}a welcome sight...!" },
				{ Cue = "/VO/MelinoeField_1195", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know you didn't always speak this way... without the full use of your voice. But you possess such strength, despite the change. My words, perhaps, but the intent is yours." },
				{ Cue = "/VO/Echo_0078",
					Text = "...My words... but the intent is yours... {#Prev}{#Echo2}my words... but the intent is yours..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "UnpickedBoonKeepsake" },
					},
				},

				{ Cue = "/VO/Echo_0066",
					Text = "Your Concave Stone! {#Echo1}Your Concave Stone! {#Prev}{#Echo2}Your Concave Stone!" },
				{ Cue = "/VO/MelinoeField_1184", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's a beautiful gift. It must have come from the mountains where you used to reside. Do you ever miss it? I can't imagine you prefer it here..." },
				{ Cue = "/VO/Echo_0067",
					Text = "Imagine you prefer it here... {#Echo1}prefer it here... {#Prev}{#Echo2}prefer it here..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			-- about other characters
			EchoAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					RequiredMaxHealthFraction = 0.5,
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0068",
					Text = "Barely made it this far... {#Echo1}made it this far... {#Prev}{#Echo2}made it this far..." },
				{ Cue = "/VO/MelinoeField_1186", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, Echo. Please don't tell anyone, but... I come from Erebus, all the way across the outskirts of the Underworld. I seek the House of Hades... to slay the usurper of the throne." },
				{ Cue = "/VO/Echo_0069",
					Text = "...usurper of the throne... {#Echo1}slay the usurper of the throne... {#Prev}{#Echo2}slay the usurper..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_1187", Text = "Even knowing, you still support me." },
					},
					{
						ObjectType = "NPC_Echo_01",
						{ Cue = "/VO/Echo_0070", Text = "You still support me... {#Echo1}support me... {#Prev}{#Echo2}support me..." },
					}
				},
			},

			EchoAboutCerberus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "H_Boss01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "H_PostBoss01" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0062",
					Text = "Closer to Cerberus... {#Echo1}Cerberus... {#Prev}{#Echo2}Cerberus..." },
				{ Cue = "/VO/MelinoeField_1180", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know him? Massive triple-headed monster elsewhere in these Fields. He's not supposed to be here, and it's made him very angry, poor dog." },
				{ Cue = "/VO/Echo_0063",
					Text = "Angry poor dog... {#Echo1}angry poor dog... {#Prev}{#Echo2}poor dog... {#Prev}{#Echo3}poor dog." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNarcissus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Narcissus_01", },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Narcissus_01" }
					},
				},

				{ Cue = "/VO/Echo_0027",
					Text = "How have you been? {#Echo1}How have you been? {#Prev}{#Echo2}How have you been?" },
				{ Cue = "/VO/MelinoeField_1003", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, you know. This place sure is a change from Oceanus, if you've ever been. About the only friendly face up there is that Narcissus..." },
				{ Cue = "/VO/Echo_0028",
					Text = "Is that Narcissus... {#Echo1}that Narcissus... {#Prev}{#Echo2}that Narcissus...!" },
				{ Cue = "/VO/MelinoeField_1004", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait, your voice... you know him? Oh, no. Knowing all his suitors, and knowing you're here in the land of the broken-hearted..." },
				{ Cue = "/VO/Echo_0029",
					Text = "Broken-hearted... {#Echo1}broken-hearted... {#Prev}{#Echo2}broken-hearted..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNarcissus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutEcho02" },
					},
				},

				{ Cue = "/VO/Echo_0047",
					Text = "Think he's sorry... {#Echo1}he's sorry... {#Prev}{#Echo2}he's sorry...?" },
				{ Cue = "/VO/MelinoeField_1165", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He had no idea what happened to you. But he remembers you! And he didn't mean to hurt you. So please don't take it personally. I think he only loves himself." },
				{ Cue = "/VO/Echo_0031",
					Text = "He only loves himself... {#Echo1}only loves himself... {#Prev}{#Echo2}only loves himself..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNarcissus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutEcho03" },
					},
				},

				{ Cue = "/VO/Echo_0048",
					Text = "About Narcissus...? {#Echo1}About Narcissus... {#Prev}{#Echo2}about Narcissus...!" },
				{ Cue = "/VO/MelinoeField_1167", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't know what he was like back when you met, but he has a certain vanity about him that... perhaps dulls his other senses a bit. When we speak, it's often like I'm not even there." },
				{ Cue = "/VO/Echo_0049",
					Text = "I'm not even there... {#Echo1}not even there... {#Prev}{#Echo2}not even there..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNarcissus04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutEcho04" },
					},
				},

				{ Cue = "/VO/Echo_0052",
					Text = "I wanted to say... {#Echo1}wanted to say... {#Prev}{#Echo2}wanted to say..." },
				{ Cue = "/VO/MelinoeField_1171", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's really nothing, but... a, {#Emph}erm{#Prev}, wise fellow with a very keen sense of self-worth once told me... {#Emph}I hope you find someone who loves you like I love myself." },
				{ Cue = "/VO/Echo_0053",
					Text = "Like I love myself... {#Echo1}I love myself... {#Prev}{#Echo2}love myself..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNarcissus05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters01" },
					},
				},

				{ Cue = "/VO/Echo_0050",
					Text = "Glad you're here! {#Echo1}Glad you're here! {#Prev}{#Echo2}Glad you're here!" },
				{ Cue = "/VO/MelinoeField_1169", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I spoke with Narcissus again. I'm certain that... he really wants what's best for you. How could he not? Among the countless souls here, you're so generous and sweet." },
				{ Cue = "/VO/Echo_0051",
					Text = "So generous and sweet... {#Echo1}and sweet... {#Prev}{#Echo2}and sweet..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNarcissus06 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusWithEcho01" },
					},
				},

				{ Cue = "/VO/Echo_0058",
					Text = "All alone this time... {#Echo1}alone this time... {#Prev}{#Echo2}this time..." },
				{ Cue = "/VO/MelinoeField_1176", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How was your meeting with Narcissus? I'm glad he was decent enough to pay you a visit. I know it must have hurt, but... I hope it helped to see him again." },
				{ Cue = "/VO/Echo_0059",
					Text = "It helped to see him again... {#Echo1}helped to see him again... {#Prev}{#Echo2}to see him again." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNarcissus07 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters05" },
					},
				},

				{ Cue = "/VO/Echo_0092",
					Text = "I have to talk to you... {#Echo1}to talk to you... {#Prev}{#Echo2}to talk to you..." },
				{ Cue = "/VO/MelinoeField_1696", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was able to assist Narcissus with a certain plight. And you seem to have let go of him yourself. But as for {#Emph}you... {#Prev}the way you are... I sense that you don't ever want to change." },
				{ Cue = "/VO/Echo_0093",
					Text = "...don't ever want to change, I... {#Echo1}don't ever want to change... {#Prev}{#Echo2}I don't ever want to change..." },
				{ Cue = "/VO/MelinoeField_1697", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We each are cursed with our experiences. I am nothing without mine. Thank you for reflecting my thoughts and sharing your feelings, Echo. But are you all right to remain here?" },
				{ Cue = "/VO/Echo_0094",
					Text = "All right to remain here... {#Echo1}all right to remain here... {#Prev}{#Echo2}all right to remain..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutCharon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					-- @ update with real prereqs
					{
						Path = { "GameState", "RoomCountCache", "H_PreBoss01" },
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Echo_0060",
					Text = "Good evening to you! {#Echo1}Evening to you! {#Prev}{#Echo2}Evening to you!" },
				{ Cue = "/VO/MelinoeField_1178", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know, you're never around when the Boatman Charon's in the area. Fear not, for he's a friend. Though, not always easy to talk to." },
				{ Cue = "/VO/Echo_0061",
					Text = "Always easy to talk to... {#Echo1}easy to talk to... {#Prev}{#Echo2}to talk to..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "NemesisCombatH" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NemesisPostCombatAboutCerberus01" },
					},
				},
				{ Cue = "/VO/Echo_0075",
					Text = "There she is... {#Echo1}there she is... {#Prev}{#Echo2}there she is...!" },
				{ Cue = "/VO/MelinoeField_1193", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must have hidden back when Nemesis was here. Big, dark-haired daughter of Nyx that sometimes storms through these Fields? But you don't have to be afraid of her." },
				{ Cue = "/VO/Echo_0076",
					Text = "...afraid of her... {#Echo1}don't have to be afraid of her... {#Prev}{#Echo2}don't be afraid of her..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			-- Partner Conversations
			NarcissusWithEcho01 =
			{
				PlayOnce = true,
				Partner = "NPC_Narcissus_Field_01",
				StatusAnimation = false,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusInFields" },
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				InteractDistance = 450,
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusFieldsGreeting,

				{ Cue = "/VO/Echo_0054", Portrait = "Portrait_Echo_Default_01", Speaker = "NPC_Echo_01",
					Text = "Narcissus! {#Echo1}Narcissus! {#Prev}{#Echo2}Narcissus!" },

				{ Cue = "/VO/Narcissus_0078", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Text = "Oh hey, {#Emph}um{#Prev}, Echo and I, we were just catching up a bit, I guess. It's been a while! Forgot how much I loved the Fields! Isn't this great?" },

				{ Cue = "/VO/Echo_0055", Portrait = "Portrait_Echo_Default_01", Speaker = "NPC_Echo_01",
					Text = "Isn't this great? {#Echo1}Isn't this great? {#Prev}{#Echo2}Isn't this great?" },

				{ Cue = "/VO/MelinoeField_1173", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm pleased to see you here, the both of you! The energy feels completely different than usual — in a good way! Echo, {#Emph}erm... {#Prev}I hope that everything's OK?" },

				{ Cue = "/VO/Echo_0056", Portrait = "Portrait_Echo_Default_01", Speaker = "NPC_Echo_01",
					Text = "Everything's OK? {#Echo1}Everything's OK! {#Prev}{#Echo2} Everything's OK." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			-- Repeatable
			EchoChat01 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0012",
					Text = "Echo... {#Echo1}Echo... {#Prev}{#Echo2}Echo..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat02 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0016",
					Text = "Hi... {#Echo1}Hi... {#Prev}{#Echo2}Hi..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat03 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0017",
					Text = "Hello...! {#Echo1}Hello...! {#Prev}{#Echo2}Hello...!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat04 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0018",
					Text = "How've you been... {#Echo1}you been... {#Prev}{#Echo2}you been..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat05 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0019",
					Text = "Me again... {#Echo1}me again... {#Prev}{#Echo2}me again..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat06 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0020",
					Text = "All right... {#Echo1}all right... {#Prev}{#Echo2}all right...!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat07 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0021",
					Text = "...help... {#Echo1}I can help... {#Prev}{#Echo2}I can help..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat08 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0032",
					Text = "I can help you... {#Echo1}help you... {#Prev}{#Echo2}help you..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat09 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0033",
					Text = "Pleased to see you... {#Echo1}see you... {#Prev}{#Echo2}see you..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat10 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0034",
					Text = "Echo, it's you... {#Echo1}it's you... {#Prev}{#Echo2}it's you...!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat11 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0035",
					Text = "Thank the Fates... {#Echo1}thank the Fates... {#Prev}{#Echo2}thank the Fates..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat12 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0036",
					Text = "A cheerful sight... {#Echo1}cheerful sight... {#Prev}{#Echo2}cheerful sight!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoChat13 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0086",
					Text = "Hellooo! {#Echo1}Hellooo! {#Prev}{#Echo2}Hellooo!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat14 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0087",
					Text = "Echo...! {#Echo1}Echo...! {#Prev}{#Echo2}Echo...!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat15 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0088",
					Text = "Have to press on... {#Echo1}press on... {#Prev}{#Echo2}press on..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat16 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0089",
					Text = "Close to Tartarus... {#Echo1}to Tartarus... {#Prev}{#Echo2}to Tartarus..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat17 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "Cleared" }
					}
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0090",
					Text = "Feeling wonderful tonight! {#Echo1}Wonderful tonight! {#Prev}{#Echo2}Wonderful tonight!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat18 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "Cleared" }
					}
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0091",
					Text = "...Echo... {#Echo1}don't you despair... {#Prev}{#Echo2}Echo... {#Prev}{#Echo3}don't you despair..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

		},

		GiftTextLineSets =
		{
			EchoGift01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Echo_01" },
					},
				},
				{ Cue = "/VO/MelinoeField_0758", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Even in a place of sorrow such as this, there's beauty... gentleness. I know not how to ease your burden yet, though perhaps this will help." },
				{ Cue = "/VO/Echo_0022",
					Text = "Perhaps this will help... {#Echo1}this will help... {#Prev}{#Echo2}this will help..." },
			},
			EchoGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartIcon",
				FilledIcon = "FilledHeartIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Echo_01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1196", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It means a lot to see your friendly face. May this Nectar sweeten your time here! Look how vast these Fields are. Plenty of room for more than just sorrow!" },
				{ Cue = "/VO/Echo_0079",
					Text = "More than just sorrow... {#Echo1}just sorrow... {#Prev}{#Echo2}just sorrow..." },
			},
			EchoGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartIcon",
				FilledIcon = "FilledHeartIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Echo_01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1197", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have more Nectar for you, Echo, if you please! Where I am from, it's a small gift we offer those we care about. I don't know about you, but even just handing over this stuff, I feel a bit better." },
				{ Cue = "/VO/Echo_0080",
					Text = "I feel a bit better... {#Echo1}bit better... {#Prev}{#Echo2}bit better..." },
			},

			-- placeholder
			EchoGiftTemp =
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
			{
				PreLineWait = 1.0,
				PlayFromTarget = true,

				{ Cue = "/VO/MelinoeField_0759", Text = "You're giving this to me? It's an honor." },
			},
			{
				PreLineWait = 0.5,
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0023", Text = "An honor... {#Echo1}an honor... {#Prev}{#Echo2}an honor..." },
			}
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
			ObjectType = "NPC_Echo_01",
			GameStateRequirements =
			{
				{
					PathEmpty = { "RequiredKillEnemies" },
				},
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
			},
			Cooldowns =
			{
				{ Name = "EchoSpokeRecently", Time = 7 },
			},

		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Echo )