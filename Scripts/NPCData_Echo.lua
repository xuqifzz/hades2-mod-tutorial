UnitSetData.NPC_Echo =
{
	-- Echo, Id = TKTK
	NPC_Echo_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Echo_Default_01",
		AnimOffsetZ = 25,
		Groups = { "NPCs" },
		LineHistoryName = "NPC_Echo_01",
		SpeakerName = "Echo",
		LoadPackages = { "Echo" },
		SubtitleColor = Color.EchoVoice,
		EmoteOffsetY = -205,
		EmoteOffsetX = 10,
		DisableCharacterFadeColorLag = true,

		UpgradeScreenOpenSound = "/SFX/Menu Sounds/PortraitEmoteCheerfulSFX",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeEchoStone2",

		MenuTitle = "EchoChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Echo",
		LastRewardEligible = false,
		IgnoreStackBoost = true,
		AllowInteractDuringEndVoiceLines = true,
		TurnInPlaceAnimation = "Echo_Greeting_Turn",
		-- TurnInPlaceDelay = 1.17,
		PreEventFunctionName = "AngleNPCToHero",

		SetupEvents =
		{
			{
				FunctionName = "OverwriteSelf",
				Args =
				{
					Speaker = "NPC_Echo_02",
					Portrait = "Portrait_Echo_Smiling_01",
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusWithEcho01" },
					},
				},
			},
		},

		FlavorTextIds =
		{
			"EchoChoiceMenu_FlavorText01",
		},
		Traits = 
		{
			"EchoLastReward",
			"EchoLastRunBoon",
			"EchoDeathDefianceRefill",
			"EchoDoubleLevelBoon",
			"DiminishingDodgeBoon",
			"DiminishingHealthAndManaBoon",
			"EchoDoubleShop",

			"EchoRepeatKeepsakeBoon",
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
				PreLineWait = 0.4,
				UsePlayerSource = true,
				RandomRemaining = true,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},
				{ Cue = "/VO/MelinoeField_1198", Text = "Be at peace.", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_1199", Text = "Rest easy now." },
				{ Cue = "/VO/MelinoeField_1200", Text = "Till next we meet." },
				{ Cue = "/VO/MelinoeField_1201", Text = "You can do it, Mel!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", 
							"EchoGift03" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1202", Text = "Death to Chronos...",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", 
							"EchoGift03" },
						},
					},
				},
			},
			{
				RandomRemaining = true,
				-- PreLineWait = 0.4,
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
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
			EchoAboutHelp02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift08" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0128",
					Text = "A gathering of Shades... {#Echo1}gathering of Shades... {#Prev}{#Echo2}gathering of Shades..." },

				{ Cue = "/VO/MelinoeField_4642", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They're here to see you, aren't they? Thank you for consoling them... for bringing them a sense of peace." },

				{ Cue = "/VO/Echo_0129",
					Text = "A sense of peace... {#Echo1}a sense of peace... {#Prev}{#Echo2}a sense of peace..." },
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

					Portrait = "Portrait_Mel_Casual_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Default_01", WaitTime = 2.2 },

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
					Portrait = "Portrait_Echo_Smiling_01",
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
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "A welcome sight... {#Echo1}a welcome sight... {#Prev}{#Echo2}a welcome sight...!" },
				{ Cue = "/VO/MelinoeField_1195", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I know you didn't always speak this way... without the full use of your voice. But you possess such strength, despite the change. My words, perhaps, but the intent is yours." },
				{ Cue = "/VO/Echo_0078",
					Text = "...My words... but the intent is yours... {#Prev}{#Echo1}my words... but the intent is yours..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoAboutCurse02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift07" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0155",
					Portrait = "Portrait_Echo_Default_01",
					Text = "Don't give in... {#Echo1}don't give in... {#Prev}{#Echo2}don't give in..." },

				{ Cue = "/VO/MelinoeField_4633", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm still amazed you spoke to me last time, Echo. In words of your own choosing, I mean! It was wonderful to hear from you, however briefly... perhaps we have the makings of a cure." },

				{ Cue = "/VO/Echo_0120",
					Portrait = "Portrait_Echo_Default_01",
					Text = "The makings of a cure... {#Echo1}of a cure... {#Prev}{#Echo2}of a cure..." },

				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoAboutCurse03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift08" },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0125",
					Text = "Are you back...?  {#Echo1}Are you back...? {#Prev}{#Echo2}Are you back...?" },

				{ Cue = "/VO/MelinoeField_4639", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I am... and so are you. No more Ambrosia then, and... all these Shades nearby... you're helping them, aren't you? To work through their sorrow." },

				{ Cue = "/VO/Echo_0126",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
					Text = "Work through their sorrow... {#Echo1}their sorrow... {#Prev}{#Echo2}their sorrow..." },

				{ Cue = "/VO/MelinoeField_4640", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm glad... a lot of Shades likely could use your aid. It seems like it must be a difficult job, but a rewarding one." },

				{ Cue = "/VO/Echo_0127",
					Text = "A rewarding one... {#Echo1}rewarding one... {#Prev}{#Echo2}rewarding one..." },

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
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "Your Concave Stone! {#Echo1}Your Concave Stone! {#Prev}{#Echo2}Your Concave Stone!" },
				{ Cue = "/VO/MelinoeField_1184", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands" },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.5, },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Echo_0068",
					Text = "Barely made it this far... {#Echo1}made it this far... {#Prev}{#Echo2}made it this far..." },
				{ Cue = "/VO/MelinoeField_1186", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
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
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "H_Boss01", "H_Boss02" },
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
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Narcissus_01" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "EchoGift01", "NarcissusGift01" },
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
					Portrait = "Portrait_Mel_Hesitant_01",
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
					Portrait = "Portrait_Echo_Smiling_01", Speaker = "NPC_Echo_02",
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
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How was your meeting with Narcissus? I'm glad he was decent enough to pay you a visit. I know it must have hurt, but... I hope it helped to see him again." },
				{ Cue = "/VO/Echo_0059",
					-- added automatically from here
					-- Portrait = "Portrait_Echo_Smiling_01",
					-- Speaker = "NPC_Echo_02",
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
					Portrait = "Portrait_Echo_Smiling_01", Speaker = "NPC_Echo_02",
					Text = "...don't ever want to change, I... {#Echo1}don't ever want to change... {#Prev}{#Echo2}I don't ever want to change..." },

				{ Cue = "/VO/MelinoeField_1697", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We each are cursed with our experiences. I am nothing without mine. Thank you for reflecting my thoughts and sharing your feelings, Echo. But are you all right to remain here?" },

				{ Cue = "/VO/Echo_0094",
					Portrait = "Portrait_Echo_Smiling_01", Speaker = "NPC_Echo_02",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 0.25 },

					Text = "All right to remain here... {#Echo1}all right to remain here... {#Prev}{#Echo2}all right to remain..." },

				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutNarcissus08 =
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

				{ Cue = "/VO/Echo_0106",
					Text = "Message for me, Mel? {#Echo1}Message for me, Mel? {#Prev}{#Echo2}Message for me, Mel?" },
				{ Cue = "/VO/MelinoeField_2875", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Why, yes! I saw Narcissus again recently, and he wanted me to tell you he said hi. For what it's worth, I think he's genuinely hoping that the two of you can still be friends." },
				{ Cue = "/VO/Echo_0107",
					Text = "Can still be friends... {#Echo1}still be friends... {#Prev}{#Echo2}be friends..." },
				{ Cue = "/VO/MelinoeField_2876", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You've grown past your prior feelings for him. Though, you don't mind if he still visits you now and again, do you? If he can tear himself away from his reflection..." },
				{ Cue = "/VO/Echo_0108",
					Text = "If he can tear himself away... {#Echo1}tear himself away... {#Prev}{#Echo2}tear himself away..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoAboutFields01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus07" },
					},
				},

				{ Cue = "/VO/Echo_0103",
					Text = "Hello... {#Echo1}my friend... {#Prev}{#Echo2}my friend... {#Prev}{#Echo3}my friend..." },
				{ Cue = "/VO/MelinoeField_2872", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I always thought... these Fields of Mourning, they were just a place for falling deep into despair. But you really have been getting better here?" },
				{ Cue = "/VO/Echo_0104",
					Text = "Getting better here... {#Echo1}better here... {#Prev}{#Echo2}better here..." },
				{ Cue = "/VO/MelinoeField_2873", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well... I know it's difficult to seek for aid, but... if there's anything that I can do, I'm here for you, all right?" },
				{ Cue = "/VO/Echo_0105",
					Text = "All right... {#Echo1}I'm here for you... {#Prev}{#Echo2}all right, I'm here for you..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "H_PostBoss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift02" },
					},
				},

				{ Cue = "/VO/Echo_0111",
					Text = "It's been too long! {#Echo1}Too long! {#Prev}{#Echo2}Too long!" },
				{ Cue = "/VO/MelinoeField_4624", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes... for I have matters not just in the depths of Tartarus, but also far above... on the besieged summit of Olympus. Rightful home of Lord Zeus and Queen Hera." },
				{ Cue = "/VO/Echo_0112",
					Text = "Zeus and Queen Hera... {#Echo1}Queen Hera... {#Prev}{#Echo2}Queen Hera..." },
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
					{
						Path = { "GameState", "RoomsEntered", "H_PreBoss01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						Path = { "GameState", "EncountersOccurredCache", "BridgeShop" },
						Comparison = ">",
						Value = 1,
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
						PathTrue = { "CurrentRun", "EncountersOccurredCache", "NemesisCombatH" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = {  "NemesisGetFreeItemIntroBridge01", "NemesisPostCombatAboutCerberus01" },
					},
				},
				{ Cue = "/VO/Echo_0075",
					Text = "There she is... {#Echo1}there she is... {#Prev}{#Echo2}there she is...!" },
				{ Cue = "/VO/MelinoeField_1193", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must have hidden back when Nemesis was here. Big dark-haired daughter of Nyx that sometimes storms through these Fields? But you don't have to be afraid of her." },
				{ Cue = "/VO/Echo_0076",
					Text = "...afraid of her... {#Echo1}don't have to be afraid of her... {#Prev}{#Echo2}don't be afraid of her..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			EchoPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
					},
				},

				{ Cue = "/VO/Echo_0132",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "We did it...! {#Echo1}We did it...! {#Prev}{#Echo2}We did it...!" },

				{ Cue = "/VO/MelinoeField_4646", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The House of Hades is restored! The Underworld King and Queen won't let this place languish as it has...! In time, I'm certain it shall be better here for everyone." },

				{ Cue = "/VO/Echo_0133",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "Better here for everyone... {#Echo1}for everyone... {#Prev}{#Echo2}for everyone..." },

				{ Cue = "/VO/MelinoeField_4647", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes. But for now, I may continue passing through much like before. I have to visit Tartarus to ensure everything's all right." },

				{ Cue = "/VO/Echo_0134",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "Everything's all right... {#Echo1}all right... {#Prev}{#Echo2}all right..." },

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

				{ Cue = "/VO/Echo_0054", Portrait = "Portrait_Echo_Smiling_01", Speaker = "NPC_Echo_01",
					Text = "Narcissus! {#Echo1}Narcissus! {#Prev}{#Echo2}Narcissus!" },

				{ Cue = "/VO/Narcissus_0078", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Text = "Oh hey, {#Emph}um{#Prev}, Echo and I, we were just catching up a bit, I guess. It's been a while! Forgot how much I loved the Fields! Isn't this great?" },

				{ Cue = "/VO/Echo_0055", Portrait = "Portrait_Echo_Smiling_01", Speaker = "NPC_Echo_02",
					Text = "Isn't this great? {#Echo1}Isn't this great? {#Prev}{#Echo2}Isn't this great?" },

				{ Cue = "/VO/MelinoeField_1173", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm pleased to see you here, the both of you! The energy feels completely different than usual — in a good way! Echo, {#Emph}erm... {#Prev}I hope that everything's OK?" },

				{ Cue = "/VO/Echo_0056",
					Portrait = "Portrait_Echo_Smiling_01",
					Speaker = "NPC_Echo_02",
					Text = "Everything's OK? {#Echo1}Everything's OK! {#Prev}{#Echo2} Everything's OK." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			NarcissusWithEcho02 =
			{
				PlayOnce = true,
				Partner = "NPC_Narcissus_Field_01",
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters04" }
					},
					{
						PathFalse = { "CurrentRun", "TextLinesRecord", "NarcissusAboutWaters04" }
					},
					NamedRequirements = { "NarcissusInFields" },
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				InteractDistance = 450,

				{ Cue = "/VO/Narcissus_0242", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Emote = "PortraitEmoteDepressed",
					Text = "...So anyways, I guess what I am trying to say is, {#Emph}um... {#Prev}I, I didn't mean for you to end up here, you know? But I get that you did! {#Emph}Ungh! {#Prev}I don't want you to hate me." },

				{ Cue = "/VO/Echo_0098", Speaker = "NPC_Echo_01",
					Portrait = "Portrait_Echo_Default_01",
					Text = "Don't want you to hate me... {#Echo1}to hate me... {#Prev}{#Echo2}hate me..." },

				{ Cue = "/VO/Narcissus_0243", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Emote = "PortraitEmoteFiredUp",
					Text = "But I {#Emph}don't {#Prev}hate you! You're a great conversationalist, great listener — which I don't mean romantically, just to be clear — but just... oh man. I'm a dummy... and I'm sorry too, OK?" },

				{ Cue = "/VO/Echo_0099",
					Emote = "PortraitEmoteSparkly",
					Text = "OK... {#Echo1}I'm sorry, too... {#Prev}{#Echo2}OK, I'm sorry, too." },

				{ Cue = "/VO/Narcissus_0244", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Text = "Oh you don't have to say that! But I'm glad you feel the same way. So like maybe... we can still be friends?" },

				{ Cue = "/VO/Echo_0100",
					Text = "We can still be friends...? {#Echo1}Still be friends...? {#Prev}{#Echo2}Be friends..." },

				{ Cue = "/VO/Narcissus_0245", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Nice! {#Prev}And by the way I like this bridge!" },

				{ Cue = "/VO/Echo_0101",
					Text = "I like this bridge... {#Echo2}this bridge... {#Prev}{#Echo3}this bridge." },

				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},

			NarcissusWithEcho03 =
			{
				PlayOnce = true,
				Partner = "NPC_Narcissus_Field_01",
				StatusAnimation = false,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NarcissusWithEcho02", "EchoGift08", "NarcissusGift07" }
					},
					NamedRequirements = { "NarcissusInFields" },
				},
				UseText = "UseListenNPC",
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				InteractDistance = 450,

				{ Cue = "/VO/Narcissus_0285", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Text = "Looks like you've put down roots here, {#Emph}huh? {#Prev}Pretty nice spot! The River Styx right over there, the rustle of the wheat..." },

				{ Cue = "/VO/Echo_0158", Speaker = "NPC_Echo_01",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "Rustle of the wheat... {#Echo1}rustle of the wheat... {#Prev}{#Echo2}rustle of the wheat... " },

				{ Cue = "/VO/Narcissus_0286", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Text = "{#Emph}Yeah{#Prev}, kind of like back when we were up top! The trees, the flowers, and all that. You ever miss those times?" },

				{ Cue = "/VO/Echo_0159",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "Ever miss those times? {#Echo1}Miss those times? {#Prev}{#Echo2}Miss those times?" },

				{ Cue = "/VO/Narcissus_0287", Portrait = "Portrait_Narcissus_Default_01", Speaker = "NPC_Narcissus_01",
					Text = "Well personally not so much, I guess. I mean, look at all this! I'd say we have it pretty good!" },

				{ Cue = "/VO/Echo_0160",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "We have it pretty good! {#Echo1}Pretty good! {#Prev}{#Echo2}Pretty good!" },

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
					Portrait = "Portrait_Echo_Smiling_01",
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
					Portrait = "Portrait_Echo_Smiling_01",
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
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift07" },
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.7, },
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0090",
					Portrait = "Portrait_Echo_Smiling_01",
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
			EchoChat19 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0138",
					Text = "You're not alone... {#Echo1}not alone... {#Prev}{#Echo2}not alone." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat20 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift07" }
					},
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0139",
					Text = "You're looking well...! {#Echo1}Looking well...! {#Prev}{#Echo2}Looking well...!" },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat21 =
			{
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Echo_0141",
					Text = "Moonlight guide you... {#Echo1}guide you... {#Prev}{#Echo2}guide you..." },
				PrePortraitExitFunctionName = "EchoChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.EchoBenefitChoices,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
			EchoChat22 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				PreBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoGift06" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Echo_0145",
					Text = "Just passing through... {#Echo1}passing through... {#Prev}{#Echo2}passing through..." },
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
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "Even in a place of sorrow such as this, there's beauty... gentleness. I know not how to ease your burden yet, though perhaps this will help." },
				{ Cue = "/VO/Echo_0022",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
					Text = "Perhaps this will help... {#Echo1}this will help... {#Prev}{#Echo2}this will help..." },
			},
			EchoGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithProphecyIcon",
				FilledIcon = "FilledHeartWithProphecyIcon",
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
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It means a lot to see your gentle face! May this Nectar sweeten your time here. Look how vast these Fields are! Plenty of room for more than just sorrow." },
				{ Cue = "/VO/Echo_0079",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
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
					Portrait = "Portrait_Mel_Empathetic_01",
					Text = "I have more Nectar for you, Echo, if you please! Where I am from, it's a small gift we offer those we care about. I don't know about you, but even just handing over this stuff, I feel a bit better." },
				{ Cue = "/VO/Echo_0080",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "I feel a bit better... {#Echo1}bit better... {#Prev}{#Echo2}bit better..." },
			},
			EchoGift04 =
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
				{ Cue = "/VO/MelinoeField_4625", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Proud_01", WaitTime = 2.8 },

					Text = "I suppose not even Nectar is enough to lift the mood here. Though you're surrounded by stone monuments at least. If you're from the mountains, perhaps it's like being at home." },

				{ Cue = "/VO/Echo_0113",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "It's like being at home... {#Echo1}like being at home... {#Prev}{#Echo2}like being at home..." },
			},
			EchoGift05 =
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
				{ Cue = "/VO/MelinoeField_4626", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Empathetic_01",

					Text = "Please let me know somehow if there is anything I could get you or do for you one of these nights. At least it seems safe here. For now, I hope this Nectar is enough." },

				{ Cue = "/VO/Echo_0114",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "This Nectar is enough... {#Echo1}is enough... {#Prev}{#Echo2}is enough..." },
			},
			EchoGift06 =
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
				{ Cue = "/VO/MelinoeField_4627", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Empathetic_01",

					Text = "Thank you for reminding me just how much can be said using few words or even none at all. When you respond, the words may be mine, but I know what you mean. And I know you understand me, too." },

				{ Cue = "/VO/Echo_0115",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "You understand me, too... {#Echo1}understand me, too... {#Prev}{#Echo2}you understand..." },
			},
			EchoGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_EchoUnlockHint01",
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
						HasAll = { "EchoGift06", "EchoAboutNarcissus07" },
					},
				},
				{ Cue = "/VO/MelinoeField_4628", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Empathetic_01",

					Text = "As we've grown to know each other more, Echo, I wanted to get you something special if you're up for it. This is Ambrosia, from the tallest peaks of Mount Olympus." },

				{ Cue = "/VO/Echo_0116",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
					Portrait = "Portrait_Echo_Smiling_01",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", Portrait = "Portrait_Echo_Default_01", WaitTime = 5 },

					Text = "The tallest peaks of Mount Olympus... {#Echo1}peaks of Mount Olympus... {#Prev}{#Echo2}the tallest peaks of, {#Prev}I... {#Emph}ngh..." },

				{ Cue = "/VO/MelinoeField_4629", UsePlayerSource = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "{#Emph}Echo! {#Prev}Did you just...? You {#Emph}said {#Prev}something! You said {#Emph}I{#Prev}, in your own words! I know I heard you say it!" },

				{ Cue = "/VO/Echo_0117",
					Portrait = "Portrait_Echo_Default_01",
					Text = "...heard you say it... I... I know, I hear you, and... I thank you. This Ambrosia, it's... it's doing this for me, I think, but I... {#Echo1}but I... {#Prev}{#Echo2}but I... {#Prev}don't think that it will last for long... {#Echo1}for long..." },

				{ Cue = "/VO/MelinoeField_4630", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Empathetic_01",

					Text = "Then I shall get more! Echo, this is amazing! I knew Ambrosia could be good, but not this good!" },

				{ Cue = "/VO/Echo_0118",
					Portrait = "Portrait_Echo_Default_01",
					Text = "Not this good... {#Echo1}not this, {#Prev}{#Echo1Italic}guh... {#Prev}this is hard for me to explain, but... I don't need any... {#Echo1}don't need any... {#Prev}{#Echo2}don't need any..." },

				{ Cue = "/VO/MelinoeField_4631", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",

					Text = "Echo, what happened...? The Ambrosia. You don't need anymore for now...? It was too much..." },

				{ Cue = "/VO/Echo_0119",
					Portrait = "Portrait_Echo_Default_01",
					Text = "It was too much... {#Echo1}too much... {#Prev}{#Echo2}too much..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.41,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4632", Text = "...All right. I'll return." },
					},
				},
			},
			-- bond forged
			EchoGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedEcho",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "EchoGift07" },
					},
				},
				{ Cue = "/VO/MelinoeField_4634", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "All right, Echo, we need to sort this out. It must have been Ambrosia that gave you back your voice last time, so perhaps it shall work again. Is it doing anything?" },

				{ Cue = "/VO/Echo_0121",
					PreLineAnim = "Echo_Greeting_Start",
					PostLineAnim = "Echo_Greeting_End",
					Portrait = "Portrait_Echo_Default_01",

					Text = "Is it doing anything...? {#Echo1}Doing anything... {#Prev}{#Echo2}anything, {#Prev}is it... I... {#Echo1}I{#Prev}, Melinoë, look. {#Echo1}Look{#Prev}, I haven't stayed here because I need help... {#Echo1}need help... {#Prev}{#Echo2}need help..." },

				{ Cue = "/VO/MelinoeField_4635", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "Echo, it's you! Then, what do you need? I don't understand. Who would wish to wallow in a place like this?" },

				{ Cue = "/VO/Echo_0122",
					Portrait = "Portrait_Echo_Smiling_01",
					Text = "A place like... this is where I can help... {#Echo1}I can help... {#Prev}{#Echo2}I can help... {#Prev}others, who... have no one to talk to. To turn to. Because I found... I can reflect their feelings, and their thoughts... {#Echo1}and their thoughts... {#Prev}{#Echo2}and their thoughts..." },

				{ Cue = "/VO/MelinoeField_4636", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",

					Text = "The way that you've reflected mine. But, we have to find a way to give you back your voice. We're close to a breakthrough!" },

				{ Cue = "/VO/Echo_0123",
					Portrait = "Portrait_Echo_Smiling_01",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Echo_01", Icon = "Keepsake_Echo" },

					Text = "A breakthrough... {#Echo1}a break... {#Prev}no. No, back when I could speak... like this... {#Echo1}like this... {#Prev}{#Echo2}like this... {#Prev}I couldn't hear myself or others. Not like now. So please... I already have what I want, I promise you... {#Echo1}I promise you... {#Prev}{#Echo2}I promise..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.45,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_4637", Text = "Echo... I... I see. And... I understand." },
					},
					{
						ObjectType = "NPC_Echo_01",
						{ Cue = "/VO/Echo_0124", Text = "I understand... {#Echo1}I understand... {#Prev}{#Echo2}I understand..." },
					},
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
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0023", Text = "An honor... {#Echo1}an honor... {#Prev}{#Echo2}an honor..." },
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
						{
							FunctionName = "RequiredAlive",
							FunctionArgs = { Ids = { 370006 }, Alive = false },
						},
					},
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

-- Global Echo Lines
GlobalVoiceLines.EchoKeepsakeLines =
{
	RandomRemaining = true,
	PreLineWait = 0.5,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Echo_01", SubtitleColor = Color.EchoVoice },
	TriggerCooldowns = { "MelinoeAnyQuipSpeech", },

	{ Cue = "/VO/Echo_0005_B", Text = "Have this... {#Echo1}have this... {#Prev}{#Echo2}have this..."
	},
	{ Cue = "/VO/Echo_0012_B", Text = "Echo... {#Echo1}Echo... {#Prev}{#Echo2}Echo...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0012" },
			},
		},
	},
	{ Cue = "/VO/Echo_0015_B", Text = "Won't forget... {#Echo1}forget... {#Prev}{#Echo2}forget...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0015" },
			},
		},
	},
	{ Cue = "/VO/Echo_0037_B", Text = "Grateful... {#Echo1}grateful... {#Prev}{#Echo2}grateful...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0037" },
			},
		},
	},
	{ Cue = "/VO/Echo_0038_B", Text = "Power... {#Echo1}power... {#Prev}{#Echo2}power...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0038" },
			},
		},
	},
	{ Cue = "/VO/Echo_0039_B", Text = "The best... {#Echo1}the best... {#Prev}{#Echo2}the best...!",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0039" },
			},
		},
	},
	{ Cue = "/VO/Echo_0042_B", Text = "Take care... {#Echo1}care... {#Prev}{#Echo2}care...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0042" },
			},
		},
	},
	{ Cue = "/VO/Echo_0043_B", Text = "Be strong... {#Echo1}strong... {#Prev}{#Echo2}strong...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0043" },
			},
		},
	},
	{ Cue = "/VO/Echo_0045_B", Text = "My friend... {#Echo1}friend... {#Prev}{#Echo2}friend...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0045" },
			},
		},
	},
	{ Cue = "/VO/Echo_0046_B", Text = "Help... {#Echo1}help... {#Prev}{#Echo2}help...",
		GameStateRequirements =
		{
			{
				Path = { "GameState", "SpeechRecord" },
				HasAll = { "/VO/Echo_0046" },
			},
		},
	},
}

GlobalVoiceLines.MiscEndVoiceLines_Echo =
{
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "TextLinesRecord", "NarcissusWithEcho01" },
			}
		},
		{
			{
				PreLineWait = 0.4,
				ObjectType = "NPC_Narcissus_Field_01",
				{ Cue = "/VO/Narcissus_0079", Text = "Be seeing you, Laurel!" },
			},
			{
				UsePlayerSource = true,
				PreLineWait = 0.4,
				{ Cue = "/VO/MelinoeField_1174", Text = "It's Melinoë! Forget it..." },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Echo_01",
				{ Cue = "/VO/Echo_0057", Text = "Melinoë, forget it... {#Echo1}forget it... {#Prev}{#Echo2}forget it..." },
			}
		},
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "TextLinesRecord", "NarcissusWithEcho02" },
			}
		},
		{
			{
				UsePlayerSource = true,
				PreLineWait = 0.4,
				{ Cue = "/VO/MelinoeField_2870", Text = "Thanks as always, Echo. Good seeing you two." },
			},
			{
				PreLineWait = 0.4,
				ObjectType = "NPC_Echo_01",
				{ Cue = "/VO/Echo_0102", Text = "Good seeing you, too... {#Echo1}you, too... {#Prev}{#Echo2}you, too...!" },
			},
			{
				BreakIfPlayed = true,
				UsePlayerSource = true,
				PreLineWait = 1.8,
				{ Cue = "/VO/MelinoeField_2856", Text = "Now they're getting somewhere..." },
			}
		},
	},
	{
		GameStateRequirements =
		{
			{
				PathTrue = { "CurrentRun", "CurrentRoom", "TextLinesRecord", "NarcissusWithEcho03" },
			}
		},
		{
			{
				UsePlayerSource = true,
				PreLineWait = 0.4,
				{ Cue = "/VO/MelinoeField_4662", Text = "Take care, you two." },
			},
			{
				BreakIfPlayed = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Echo_01",
				{ Cue = "/VO/Echo_0149", Text = "You, too... {#Echo1}you, too... {#Prev}{#Echo2}you, too..." },
			},
		},
	},
	{
		PlayOnce = true,
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord", "NPC_Echo_01" },
				Comparison = "==",
				Value = 1,
			}
		},
		{
			PreLineWait = 0.4,
			UsePlayerSource = true,

			{ Cue = "/VO/MelinoeField_0741", Text = "I don't know who you are, but thanks..." },
		},
		{
			ObjectType = "NPC_Echo_01",

			{ Cue = "/VO/Echo_0006", Text = "Thanks... {#Echo1}thanks... {#Prev}{#Echo2}thanks...", BreakIfPlayed = true },
		}
	},
	{
		RandomRemaining = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "NarcissusWithEcho01", "NarcissusWithEcho02", "NarcissusWithEcho03" },
			},
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "MelinoeField_0741" }
				},
			},
			{
				PreLineWait = 0.4,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0740", Text = "I can have this?" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0005", Text = "Have this... {#Echo1}have this... {#Prev}{#Echo2}have this..." },
			},
		},
		{
			{
				PreLineWait = 0.4,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1001", Text = "Please take care." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0026", Text = "Take care... {#Echo1}take care... {#Prev}{#Echo2}take care...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0745", Text = "For me? You sure?" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0009", Text = "Sure... {#Echo1}sure... {#Prev}{#Echo2}sure...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
				},
			},
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0748", Text = "Thank you, Echo." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0012", Text = "Echo... {#Echo1}Echo... {#Prev}{#Echo2}Echo...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
				},
			},
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_0751", Text = "I won't forget this, Echo." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0015", Text = "Won't forget... {#Echo1}forget... {#Prev}{#Echo2}forget...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1012", Text = "I'm grateful." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0037", Text = "Grateful... {#Echo1}grateful... {#Prev}{#Echo2}grateful...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1013", Text = "Such a power..." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0038", Text = "Power... {#Echo1}power... {#Prev}{#Echo2}power...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
				},
			},
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1014", Text = "You're the best!" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0039", Text = "The best... {#Echo1}the best... {#Prev}{#Echo2}the best...!", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1015", Text = "See you next time?" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0040", Text = "Next time... {#Echo1}next time... {#Prev}{#Echo2}next time...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
				},
			},
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1016", Text = "Farewell, Echo." },
			},
			{
				ObjectType = "NPC_Echo_01",
				{ Cue = "/VO/Echo_0041", Text = "Farewell... {#Echo1}farewell... {#Prev}{#Echo2}farewell...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1017", Text = "Take care now..." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0042", Text = "Take care... {#Echo1}care... {#Prev}{#Echo2}care...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1018", Text = "Be strong, OK?" },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0043", Text = "Be strong... {#Echo1}strong... {#Prev}{#Echo2}strong...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
				},
				{
					Path = { "GameState", "UseRecord", "NPC_Echo_01", },
					Comparison = ">=",
					Value = 3,
				},
			},
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1019", Text = "Please don't give in." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0044", Text = "Don't give in... {#Echo1}give in... {#Prev}{#Echo2}give in...", BreakIfPlayed = true },
			}
		},
		{
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "TextLinesRecord", "EchoGift01" },
				},
				{
					Path = { "GameState", "UseRecord", "NPC_Echo_01", },
					Comparison = ">=",
					Value = 3,
				},
			},
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1020", Text = "Thank you, my friend." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0045", Text = "My friend... {#Echo1}friend... {#Prev}{#Echo2}friend...", BreakIfPlayed = true },
			}
		},
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,

				{ Cue = "/VO/MelinoeField_1021", Text = "This shall help." },
			},
			{
				ObjectType = "NPC_Echo_01",

				{ Cue = "/VO/Echo_0046", Text = "Help... {#Echo1}help... {#Prev}{#Echo2}help...", BreakIfPlayed = true },
			}
		},

	},
	-- [3] = { GlobalVoiceLines = "ThankingCharacterVoiceLines" },
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Echo )