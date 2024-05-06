UnitSetData.NPC_Narcissus =
{
	-- Narcissus, Id = TKTK
	NPC_Narcissus_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Narcissus_Default_01",
		AnimOffsetZ = 250,
		Groups = { "NPCs" },
		SpeakerName = "Narcissus",
		SubtitleColor = Color.NarcissusVoice,

		RequiredRoomInteraction = true,

		UpgradeScreenOpenSound = "/SFX/Menu Sounds/PortraitEmoteCheerfulSFX",
		UpgradeSelectedSound = "/Leftovers/Menu Sounds/TalismanPaperEquipLEGENDARY",
		MenuTitle = "NarcissusGiftsMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Narcissus",
		FlavorTextIds =
		{
			"NarcissusGiftsMenu_FlavorText01",
		},
		
		Traits = 
		{
			"NarcissusA",
			"NarcissusB",
			"NarcissusC",
			"NarcissusD",
			"NarcissusE",
			"NarcissusF",
			"NarcissusG",
			"NarcissusH",
			"NarcissusI",
		},
		ActivateRequirements =
		{
			-- None
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift03" },
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
				{ Cue = "/VO/MelinoeField_0719", Text = "May these waters run clear.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "SpeechRecord", "/VO/MelinoeField_0720" },
						}
					},
				},
				{ Cue = "/VO/MelinoeField_0720", Text = "Peace, Narcissus.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_1698_2", Text = "Salutations." },
				{ Cue = "/VO/Melinoe_1699_2", Text = "Salutations!" },
				{ Cue = "/VO/Melinoe_1701_2", Text = "Moonlight guide you." },
				{ Cue = "/VO/Melinoe_1703_2", Text = "May moonlight guide you." },
			},
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Narcissus_01",

				{ Cue = "/VO/Narcissus_0031", Text = "I guess!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0719", "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Narcissus_0024", Text = "What?" },
				{ Cue = "/VO/Narcissus_0142", Text = "Hey.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0720", "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Narcissus_0143", Text = "Salutations.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Narcissus_0145", Text = "Same.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0720", "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Narcissus_0146", Text = "Thanks.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_0719", "/VO/MelinoeField_0720", "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Narcissus_0147", Text = "OK." },
				{ Cue = "/VO/Narcissus_0148", Text = "I guess." },
				{ Cue = "/VO/Narcissus_0149", Text = "Huh?" },
				{ Cue = "/VO/Narcissus_0150", Text = "Like, OK." },
				{ Cue = "/VO/Narcissus_0151", Text = "{#Emph}Uh-huh." },
			},
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 1.3,
				Queue = "Always",
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "NarcissusGrantsReward01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1987", Text = "{#Emph}Oh! Erm{#Prev}, thank you!" },
			},
		},


		InteractTextLineSets =
		{
			NarcissusFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0097", Speaker = "NPC_Unnamed_01", SpeakerLabelOffsetY = 18,
					Emote = "PortraitEmoteSparkly",
					Text = "Well, would you look at that. Another would-be suitor journeyed far and wide, just to gaze upon me, not that I blame you... and get totally rejected! {#Emph}Fine. {#Prev}Ogle if you {#Emph}must." },
				{ Cue = "/VO/Melinoe_2047", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You have the wrong idea. I'm not seeking a mate. I don't even know who you are." },
				{ Cue = "/VO/Narcissus_0003",
					Emote = "PortraitEmoteSurprise",
					Text = "What? I'm Narcissus, dummy! {#Emph}The {#Prev}Narcissus? And if you're no would-be suitor... then why don't you relieve me of one of these innumerable gifts the others offered in vain. {#Emph}Then beat it." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusLowHealth01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0094",
					Text = "Uh {#Emph}whoa {#Prev}what's wrong with you? Coming in here like that. You don't need {#Emph}me{#Prev}, dummy. You need a doctor, or {#Emph}healer{#Prev}, or something." },
				{ Cue = "/VO/MelinoeField_1162", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, well, I've found those somewhat difficult to locate around here. Though on the flip side, no shortage of fishlike monstrosities determined to cut me a set of gills." },
				{ Cue = "/VO/Narcissus_0095",
					Text = "Yeah that's what they all say. Look, there's probably a fountain or something somewhere around here. Wash up, come back, we'll {#Emph}talk." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusLowHealth02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
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
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0096",
					Text = "{#Emph}Whew, {#Prev}you are never gonna find a mate looking all scratched up like that, bleeding everywhere. Might have something you could use to patch yourself up, if it'll make you go away." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutLooks01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0014",
					Text = "I have one rule, and that's {#Emph}look, but don't touch{#Prev}, OK? In fact, why don't you stand a little farther back, and also tell me how come you keep showing up like this?" },
				{ Cue = "/VO/Melinoe_2048", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've some affairs to settle in the lower reaches of the Underworld. Thought I'd take this rather scenic route, through this chamber of yours." },
				{ Cue = "/VO/Narcissus_0015",
					Text = "Oh, it isn't my chamber. I just find the waters here particularly clean and reflective, and far fewer would-be suitors than in Asphodel. Remember to take a gift before you go!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutLooks02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0016",
					Emote = "PortraitEmoteSparkly",
					Text = "Sometimes I wonder, what would it have been like were I not so unbelievably attractive? Some things would've been easier... not having everybody fall in love with me... maybe arithmetic..." },
				{ Cue = "/VO/Melinoe_2049", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're concerned that you're too winsome for your own good...? Well if it makes you feel any better, I don't find you particularly attractive..." },
				{ Cue = "/VO/Narcissus_0017",
					Text = "Oh, I know you don't mean that. Though I appreciate you trying to comfort me. {#Emph}As a friend." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutBeauty01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0090",
					Text = "Here comes Laurel or whatever her name is. I was just thinking about the time we met. I mean, the time I first gazed upon my reflection. Up till that point, man, I had {#Emph}no idea..." },
				{ Cue = "/VO/MelinoeField_1160", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have to say, I don't think I've met anyone who's quite so taken with themselves as you, Narcissus. I'm a little envious. When I see myself... I see so many flaws." },
				{ Cue = "/VO/Narcissus_0091",
					Text = "{#Emph}Oof{#Prev}, I know what you mean. Not everybody's born with perfect skin... lustrous hair... total package. But everybody's beautiful in their own way! {#Emph}Even you." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutLove01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift03" }
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_1992", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's hard to believe you're so completely in love with yourself. Don't you ever... consider the mistakes you've made, or ways in which you can improve? Or {#Emph}not {#Prev}improve, even..." },
				{ Cue = "/VO/Narcissus_0197",
					Text = "What, are you kidding? How could you possibly improve on {#Emph}this? {#Prev}Though, I definitely see your point. In your case." },
				{ Cue = "/VO/MelinoeField_1993", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Was that a bit of ridicule, or do you in fact have some keen bit of insight or feedback about me you're willing to share?" },
				{ Cue = "/VO/Narcissus_0198",
					Text = "If you're unhappy with the way you are, why don't you just, like, {#Emph}change? {#Prev}Or if you can't... get over it I guess, I don't know." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutSolitude01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Melinoe_2050", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't you get lonely sitting here, staring into those waters? Especially in a place like this." },
				{ Cue = "/VO/Narcissus_0018",
					Emote = "PortraitEmoteSparkly",
					Text = "Lonely? I don't know the meaning of the word. I have the best company you could ever ask for: {#Emph}Me!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutDanger01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_0028", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Don't the vicious creatures contaminating these chambers make this a rather dangerous place in which to laze about?" },
				{ Cue = "/VO/Narcissus_0051",
					Text = "Oh, I've made clear to them that they don't stand a chance with me at all. In my position, it's not good to send mixed messages. Both for my suitor's sakes... and for {#Emph}my own." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutOceanus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_0029", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Narcissus, how did you discover this place anyhow? I'd not expected to have a friendly chat along the outskirts of the Underworld." },
				{ Cue = "/VO/Narcissus_0052",
					Text = "I always knew my way around the rivers and the seas. After I died, I got stuck in Asphodel for a while. Way too {#Emph}dry. {#Prev}So once the Underworld opened up, I swam straight here. Where it's {#Emph}cool." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutOceanus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NarcissusAboutOceanus01", "NarcissusGift02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0057",
					Text = "Hey what's your problem, anyway? Always huffing through here like you're late to something. You got to learn to {#Emph}relax." },
				{ Cue = "/VO/MelinoeField_0032", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sounds like you were there when the Underworld opened up. It shouldn't have." },
				{ Cue = "/VO/Narcissus_0058",
					Text = "How come? That way I'd still be shriveled up in Asphodel! Know what, though, just forget I asked. You're killing my mood here." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutReflection01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift01" },
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringContinuous,

				{ Cue = "/VO/Narcissus_0053",
					PreLineWait = 0.35,
					Text = "...Don't worry, man, she's not so bad, she doesn't stay for long. Soon it'll just be you and me again... and all those {#Emph}Shades {#Prev}back there." },
				{ Cue = "/VO/MelinoeField_0030", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Pardon the interruption, Narcissus. Were you just... speaking to your own reflection there?" },
				{ Cue = "/VO/Narcissus_0054",
					Text = "They're always quick to judge, aren't they? Look, Laurel, or whatever your name is: You'll never understand what I've got. Don't even {#Emph}try." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutReflection02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringContinuous,

				{ Cue = "/VO/Narcissus_0084",
					PreLineWait = 0.35,
					Text = "...What would you say is your best quality, if you had to choose? The one thing you most adore... what drives everyone around you {#Emph}wild...?" },
				{ Cue = "/VO/MelinoeField_1157", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, I, {#Emph}erm... {#Prev}well... I'm quite attentive, I think. If you tell me something, you don't have to tell me twice! Chances are I'll take it to heart the first time. Though, why do you ask?" },
				{ Cue = "/VO/Narcissus_0085",
					Text = "{#Emph}Pff{#Prev}, there she goes, butting into our private conversations! I know your best quality, man: your {#Emph}looks. {#Prev}Whoever says looks aren't everything's a dummy. Like this girl over here! Just give her a gift, and she leaves us alone!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutReflection03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutReflection02" }
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0086",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteAffection",
					Text = "...Got to say, your hair is looking {#Emph}awesome {#Prev}lately, you know? Whole wet-look thing! Must be all the humidity and brine. {#Emph}Keep it up." },
				{ Cue = "/VO/MelinoeField_1158", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was about to thank you for the compliment when it occurred to me that you're just talking to yourself again, most likely. In which case, forgive the interruption!" },
				{ Cue = "/VO/Narcissus_0087",
					Text = "Don't worry about it. I have plenty of time to myself. But you only get to see me, what, maybe once a day, tops? Better than nothing, though {#Emph}not nearly enough." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutReflection04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0088",
					PreLineWait = 0.35,
					Text = "...Hey remember the time you were, like, checking yourself out, and then a bee or something lands right on your face, so you swat it, {#Emph}bam! {#Prev}Your eye was swollen shut for like a week. You looked {#Emph}terrible{#Prev}, man!" },
				{ Cue = "/VO/MelinoeField_1159", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Pardon, Narcissus. That sounds like it must have been a harrowing experience. Was your love for yourself tested when the reflection staring back at you had a big puffy eyelid?" },
				{ Cue = "/VO/Narcissus_0089",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}No! {#Prev}I mean... not really. But this love is more than skin-deep. Even if I can't look at me... I can still talk to me... and even if I can't do that, I can always {#Emph}think {#Prev}about me, you know? And so can {#Emph}you." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "FountainRarityKeepsake" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0092",
					Emote = "PortraitEmoteSparkly",
					Text = "There was this wonderful aroma in the air just now... lilac on a summer breeze, or something like that. I {#Emph}thought {#Prev}it was you. But it's just the gift I gave you before. {#Emph}Good stuff." },
				{ Cue = "/VO/MelinoeField_1161", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This Aromatic Phial you gave me does smell rather pleasant, doesn't it? I scarcely notice with all the brine and fishy odor around here. Though it doesn't seem to bother you." },
				{ Cue = "/VO/Narcissus_0093",
					Text = "Oh I just tune it out. Like all the rest. I give my undivided attention... to {#Emph}me... {#Prev}and I guess some of it to you, but you don't stay for long so it's OK." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			-- about other characters
			NarcissusAboutNemesis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "EncountersCompletedCache", "NemesisCombatG" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0055",
					Text = "{#Emph}Huh{#Prev}, it's only you. Been getting crowded lately between all these chats and {#Emph}what's-her-name {#Prev}stomping around... least you're not {#Emph}her." },
				{ Cue = "/VO/MelinoeField_0031", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What's-her-name, that sounds like Nemesis. Scornful expression, dark hair and armor? What's your concern with her?" },
				{ Cue = "/VO/Narcissus_0056",
					Text = "Gives me a bad {#Emph}vibe. {#Prev}Storms around, shakes everything up. Something about her, I don't know. Don't hurt my head, OK?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NemesisWithNarcissus01_FollowUp =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutNemesis01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "NarcissusAboutNemesis01" }, Count = 2 },
					NamedRequirements = { "NoRecentNemesisEncounter" },
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_1145", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Are you all right? Nemesis can be rather terse. She didn't hurt you or anything, did she?" },
				{ Cue = "/VO/Narcissus_0152",
					Emote = "PortraitEmoteDepressed",
					Text = "She said something just there... about how I'm {#Emph}stuck forever in the company of a buffoon. {#Prev}She couldn't have meant... no way. She's jealous. She {#Emph}likes {#Prev}me! And playing hard-to-get. Unlike {#Emph}some {#Prev}people, who come on a little strong." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NemesisWithNarcissus02_FollowUp =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisWithNarcissus01_FollowUp", "NarcissusGrantsReward01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "NemesisWithNarcissus01_FollowUp" }, Count = 2 },
					NamedRequirements = { "NoRecentNemesisEncounter" },
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				-- OnQueuedThreadedFunctionName = "AmbientChatting",
				-- OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_2033", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I don't think Nemesis was playing hard-to-get. She wants to make certain you don't have too much of a good thing! Fortunately, I think she may leave you alone from here out." },
				{ Cue = "/VO/Narcissus_0189",
					Text = "Is that so? Or are you just trying to get her out of the picture so you can have me to {#Emph}yourself? {#Prev}Expecting special favors just because you helped me with the water situation, {#Emph}eugh!" },
				{ Cue = "/VO/MelinoeField_2034", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What? I don't want any special favors from you! Although... I fear I've grown accustomed to the gifts you've offered me each time I visit. How easily we take to certain habits." },
				{ Cue = "/VO/Narcissus_0190",
					Text = "Yeah well, {#Emph}I've {#Prev}taken to getting a headache whenever you talk about this stuff. I'm gonna keep giving you these because I pity you... and because I {#Emph}don't want 'em." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutSirens01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered", "G_Boss01" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift02" },
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_1991", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Ever been to one of the local shows around here? Scylla and the Sirens keep playing night after night, much as I'd hoped they'd move on to the next stage of their tour by now..." },
				{ Cue = "/VO/Narcissus_0196",
					Text = "Only music that I care for is {#Emph}my voice. {#Prev}The rest can get so loud, it disturbs the surface of the water. And whatever disturbs the surface of the water... {#Emph}disturbs me." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutReflection01" }
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_1990", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Nothing gets to you! A war rages between the Titan Chronos and the gods, but you've shown not even the slightest concern. What's your secret?" },
				{ Cue = "/VO/Narcissus_0195",
					Text = "I don't keep secrets, Laurel. It's just that... {#Emph}I don't care. {#Prev}If it doesn't affect me, it doesn't affect me. Got enough problems of my own... such as, how best to get rid of all {#Emph}these." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutEcho01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Narcissus_01", },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NarcissusAboutEcho01B" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Melinoe_2051", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're very focused. Centered on the self. Become inured somehow to the incessant singing that always echoes through these halls." },
				{ Cue = "/VO/Narcissus_0049",
					Text = "Speak not to me of Echo's this or Echo's that, OK? Echo meant nothing to me and somehow got the wrong idea anyway. And don't {#Emph}you {#Prev}get any ideas either." },
				{ Cue = "/VO/MelinoeField_2032", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Speak not to me of echoes{#Prev}, what...? I'm talking about Scylla's song. You've somehow learned to block it out, though... gods, I think I'm beginning to like it..." },
				{ Cue = "/VO/Narcissus_0050",
					Text = "How about I learn to block {#Emph}you {#Prev}out! With {#Emph}this." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutEcho01B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "UseRecord", "NPC_Narcissus_01", },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoAboutEcho01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "NarcissusAboutEcho01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Melinoe_2051", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're very focused. Centered on the self. Become inured somehow to the incessant singing that always echoes through these halls." },
				{ Cue = "/VO/Narcissus_0049",
					Text = "Speak not to me of Echo's this or Echo's that, OK? Echo meant nothing to me and somehow got the wrong idea anyway. And don't {#Emph}you {#Prev}get any ideas either." },
				{ Cue = "/VO/MelinoeField_1144", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Echo meant nothing to you{#Prev}, what... I was talking about Scylla's song and how you've blocked it out. Come to think, I can't quite hear it now either." },
				{ Cue = "/VO/Narcissus_0050",
					Text = "How about I learn to block {#Emph}you {#Prev}out! With {#Emph}this." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutEcho02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0065",
					Text = "Look, I can tell you're having trouble moving on. Maybe you ought to spend a little time down in the Fields. Clear your head, put the pieces of your heart back together, and all that?" },
				{ Cue = "/VO/MelinoeField_1146", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If you mean the Mourning Fields, I don't think that's a healing place. The Shades there wallow in self-pity and speechless despair. Although, there is one who repeats whatever I say to her..." },
				{ Cue = "/VO/Narcissus_0066",
					Emote = "PortraitEmoteSurprise",
					Text = "Repeats whatever you say to her! I knew a Nymph like that one time. Nice girl. But she didn't get me! Only ever talked about {#Emph}herself. {#Prev}I had to cut her off." },
				{ Cue = "/VO/MelinoeField_1147", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So you do know Echo, the Mountain Nymph! She's languishing in the Fields even now. Apparently because of you. I can hardly get through to her..." },
				{ Cue = "/VO/Narcissus_0067",
					Text = "Oh, that's too bad. Well, tell her Narcissus really wants what's best for her. Unless that's {#Emph}me. {#Prev}Don't tell her that part, though." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutEcho03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_1492", UsePlayerSource = true,

					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I spoke to Echo about you. Said you didn't mean to hurt her, though perhaps I shouldn't have. She responded in her usual way but I could tell something happened. You broke her heart?" },
				{ Cue = "/VO/Narcissus_0068",
					Text = "She broke her {#Emph}own {#Prev}heart! They always fall for people who don't love them back. Anyway, I'm sure she'll find someone who thinks she's... {#Emph}awesome. {#Prev}Plenty of fish... {#Emph}in the sea!" },
				{ Cue = "/VO/MelinoeField_1149", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Yes, I've noticed. So, has anybody ever fallen out of love with you? Or do they all end up in the Mourning Fields, pining for you for eternity?" },
				{ Cue = "/VO/Narcissus_0069",
					Text = "All I know is no one's ever loved me as much as {#Emph}me. {#Prev}They're all too busy feeling sorry for themselves to really care, you know? Can't love someone... if you can't love {#Emph}yourself." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutEcho04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "EchoAboutNarcissus03" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0070",
					Text = "Hey tell me something. Is Echo really not OK? I thought about the things you said, how she was all alone down in the Fields... how could I hurt someone without even trying, you know?" },
				{ Cue = "/VO/MelinoeField_1150", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Narcissus, don't take this the wrong way, but I'm impressed you've given any thought to someone else. As for Echo, she seems to be getting by. Is there something you'd like to say to her should I cross paths with her again?" },
				{ Cue = "/VO/Narcissus_0071",
					Text = "Sure, {#Emph}um... {#Prev}go ahead and tell her that I hope she finds someone who loves her like I love {#Emph}me. {#Prev}But don't tell her I said it, she'd just get the wrong idea and her heart would break... again." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutEcho05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGrantsReward01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_1988", UsePlayerSource = true,
					Text = "Do you ever think you'll visit Echo again in the Fields? You seemed to have no trouble getting there and back." },
				{ Cue = "/VO/Narcissus_0193",
					Emote = "PortraitEmoteSparkly",
					Text = "You know, maybe I might! But it's a little crowded there, and I do like it here. So then again, maybe I won't! We made a clean break. Why mess with a {#Emph}perfectly good thing?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutWaters01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0072",
					Text = "Oh it's you again. Look, I... want you to leave me alone, OK? Because I'm in a state of grief. And the only one I want to see me that way... is {#Emph}me." },
				{ Cue = "/VO/MelinoeField_1151", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}State of grief{#Prev}, wait. What's with the water here...? It's gone all murky or something. Oh, no! You can't see your reflection anymore..." },
				{ Cue = "/VO/Narcissus_0073",
					Emote = "PortraitEmoteFiredUp",
					Text = "Don't need to rub it in, dummy! Not like you can do something about it anyway. A lot of things turn ugly after a while. So please excuse me while I mourn for what I've lost..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutWaters02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_1152", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "These waters are still filthy. I know all sorts of purification rites. You've aided me so often, the least I can do is help sort this out." },
				{ Cue = "/VO/Narcissus_0074",
					Text = "And what exactly do you have in mind, a bunch of soap? I don't think that's gonna work. It's a big sea out there. No, I think... I think I'm just gonna have to move on..." },
				{ Cue = "/VO/MelinoeField_1153", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That may be just the thing. You said before you wished to mourn for what you've lost. I know the perfect place for that. Find Echo in the Mourning Fields, sincerely speak to her, thus cleansing your aura... and I can do the rest." },
				{ Cue = "/VO/Narcissus_0075",
					Text = "You think me talking to Echo's gonna clear things up? Well... couldn't hurt, I guess. And they love me down in the Fields! Tell you what. I'm gonna... {#Emph}give it some thought..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutWaters03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters02" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0076",
					Text = "Oh, hey. Yeah I'm still here and everything. Though I've been thinking of a visit to the Fields one of these days. Nights? I dunno." },
				{ Cue = "/VO/MelinoeField_1154", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Take all the time you need. I know it must be difficult, and the trip is treacherous. You could accompany me if you wish?" },
				{ Cue = "/VO/Narcissus_0077",
					Text = "Sounds like a date, {#Emph}no {#Prev}thanks. I get around just fine all by myself. But for now... I can still see a bit of my reflection if I squint hard enough. {#Emph}It's a good look..." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusAboutWaters04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusWithEcho01" },
					},
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeNarcissusWaters" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0080",
					Text = "I talked to Echo like you said I should. What {#Emph}gives? {#Prev}This place is still the same! I thought you were gonna fix everything." },
				{ Cue = "/VO/MelinoeField_1155", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Fear not, I keep my vows; I still have a purification rite to complete. I appreciate that you had the courage to meet with Echo, even if it was for your own sake." },
				{ Cue = "/VO/Narcissus_0081",
					Text = "Yeah, well, that's love for you, right? I guess I'll just... hang out here till you do your thing. The Fields are nice and all, but... too many would-be suitors over there." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutStillDirtyWaters01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "WorldUpgradesAdded", "WorldUpgradeNarcissusWaters" },
					},
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/MelinoeField_1989", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You're still wallowing in misery trying to see your reflection in a muddy pool. Why not just relocate? The waters aren't like this everywhere." },
				{ Cue = "/VO/Narcissus_0194",
					PreLineWait = 0.35,
					Text = "...I'll never leave you, man. I got us into this, I'll find a way to get us out, OK? So don't you quit on me! We'll figure something out, just need to stay focused. No distractions!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusAboutWaters05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeNarcissusWaters" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0082",
					Emote = "PortraitEmoteFiredUp",
					Text = "Laurel, look! The waters are all clear! You don't know how glad I am to see {#Emph}me. {#Prev}You must have done your thing! I'd give you a hug or something, but... I wouldn't want you to take it the wrong way." },
				{ Cue = "/VO/MelinoeField_1156", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Excellent. So then the purification worked out after all. Echo must have taken whatever you said to heart. Perhaps you're not as hopelessly self-absorbed as I feared." },
				{ Cue = "/VO/Narcissus_0083",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteAffection",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAffection", WaitTime = 4 },
					Text = "...Say what? Sorry, I was just... yeah, I mean, just {#Emph}look {#Prev}at this, the {#Emph}chin{#Prev}, the turn of the {#Emph}cheek... {#Prev}have you ever seen anything like it? Tell Echo I said hi. But as a {#Emph}friend." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusGrantsReward01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutWaters05" },
					},
					{
						Path = { "GameState", "LifetimeResourcesGained", "Mixer5Common" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMuttering,

				{ Cue = "/VO/Narcissus_0191",
					Emote = "PortraitEmoteSparkly",
					Text = "Don't know how to thank you for the water-cleaning thing! Look at how crisp my reflection is! And the color contrast, {#Emph}ungh! {#Prev}You've got a real future in water sanitation!" },
				{ Cue = "/VO/MelinoeField_1986", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps the improved image quality will help you start to notice details other than yourself. The effect of the purification should last longer if you do." },
				{ Cue = "/VO/Narcissus_0192",
					Text = "What I'm trying to say is, I've decided to give to you the greatest gift of all that I've received. So here's something from my {#Emph}private reserve!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			-- Repeatable
			NarcissusChat01 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0004",
					Emote = "PortraitEmoteSparkly",
					Text = "You can't have my looks, but you can have {#Emph}this." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat02 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0005",
					Text = "I don't mean to be rude, but I'm kind of in the middle of something here?" },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat03 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0006",
					Text = "Tread softly, OK? I like it when the waters here are perfectly still." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat04 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0007",
					Emote = "PortraitEmoteSparkly",
					Text = "Sometimes I wonder... how could a face be any better looking than {#Emph}this?" },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat05 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0008",
					Text = "Some come here to reflect... but nobody reflects better than {#Emph}me." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat06 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0009",
					Text = "For somebody who's not a would-be suitor, you sure come around a lot." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat07 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0010",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteAffection",
					Text = "...Those eyes... that jawline... the hair... oh man, the hair..." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat08 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0011",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteAffection",
					Text = "...Wow, you know you really do look great tonight, man..." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat09 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0012",
					Text = "Don't worry, I'm sure you'll find someone who loves you at some point." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat10 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0013",
					Text = "Oh, it's you again. Just help yourself I guess, and leave the rest to {#Emph}me." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat11 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0039",
					Emote = "PortraitEmoteSparkly",
					Text = "No one's going to help you if you don't help {#Emph}yourself." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat12 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0040",
					Emote = "PortraitEmoteSparkly",
					Text = "Got everything I need right here. Plus all this stuff I welcome you to take!" },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat13 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0041",
					Text = "I'm already spoken for, but all this other stuff is up for {#Emph}grabs." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat14 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0042",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteSparkly",
					Text = "...Good to see your face again, man! Don't even worry about her." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat15 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0043",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteAffection",
					Text = "...Look at yourself, man! You're too good for any of these dummies." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat16 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0044",
					Text = "Take one of these, maybe it'll help you get your {#Emph}own {#Prev}suitors." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat17 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0045",
					Text = "I felt that piercing gaze upon me once again and figured it was {#Emph}you." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat18 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0046",
					Emote = "PortraitEmoteSparkly",
					Text = "These waters are so clear, they really bring out the best in me." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat19 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0047",
					Emote = "PortraitEmoteSparkly",
					Text = "You're always looking out for me, and you found me, so {#Emph}good job." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat20 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0048",
					Emote = "PortraitEmoteSparkly",
					Text = "Congratulations finding me again! Now take your prize, and {#Emph}go." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusChat21 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0215",
					Emote = "PortraitEmoteSparkly",
					Text = "Stay as long as you like! Or better yet, pick one of these and {#Emph}go." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat22 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0216",
					Text = "Take what you want, but only one. Not playing favorites here." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat23 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0217",
					Text = "Why don't you take one of these away from me, then {#Emph}go away yourself." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat24 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0218",
					Emote = "PortraitEmoteFiredUp",
					Text = "Get your own reflective pool, and choice of complimentary gift!" },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat25 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0219",
					Text = "{#Emph}Ungh{#Prev}, still not a single dent in my stockpile of stuff to give away..." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat26 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusGift04" },
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0220",
					Emote = "PortraitEmoteSparkly",
					Text = "Oh {#Emph}hey! Uh, {#Prev}since you're not a would-be suitor, feel free to {#Emph}cut in line." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat27 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "NarcissusAboutReflection01" }
					},
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0221",
					Text = "What's new, Laurel, same old same old? OK good seeing you, buh-bye!" },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat28 =
			{
				UseableOffSource = true,
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0222",
					Text = "I know you're still kind of obsessed with me, but I get it, believe me I {#Emph}do." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat29 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0223",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteAffection",
					Text = "...Look at the definition in the chin... the hue of the eyes... the curl of the lip..." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusChat30 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0224",
					PreLineWait = 0.35,
					Emote = "PortraitEmoteAffection",
					Text = "...When our eyes meet like this, nothing else matters... and they meet like this {#Emph}a lot." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

			NarcissusSadChat01 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0209",
					Emote = "PortraitEmoteDepressed",
					Text = "I still can't see myself. Am I still here? Are {#Emph}any {#Prev}of us here? Man..." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusSadChat02 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0210",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Ugh{#Prev}, why did this have to happen to me? To {#Emph}us? {#Prev}It isn't {#Emph}fair!" },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusSadChat03 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0211",
					Emote = "PortraitEmoteDepressed",
					Text = "Please leave me to my sorrow. But take a complimentary gift on your way out!" },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusSadChat04 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0212",
					Emote = "PortraitEmoteDepressed",
					Text = "Man... this is the worst thing that's ever happened to {#Emph}anyone..." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusSadChat05 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0213",
					Text = "Still can't see anything in here... but if I {#Emph}squint, or tilt my head a certain way..." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},
			NarcissusSadChat06 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "NarcissusDirtyWater" },
				},
				EndGlobalVoiceLines = "MiscEndVoiceLines_Narcissus",
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusMutteringRepeatable,

				{ Cue = "/VO/Narcissus_0214",
					Emote = "PortraitEmoteFiredUp",
					Text = "I'm kind of in a crisis here, so just help yourself, and {#Emph}go." },
				PrePortraitExitFunctionName = "NarcissusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.NarcissusBenefitChoices,
			},

		},

		GiftTextLineSets =
		{
			NarcissusGift01 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				UnfilledIcon = "EmptyHeartWithGiftIcon",
				FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Narcissus_01" },
					},
				},
				{ Cue = "/VO/Melinoe_2053", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "As you've made no attempt to snap my head from my shoulders unlike many other things lurking about, I'm compelled to give you this. Just as a casual acquaintance, to be clear." },
				{ Cue = "/VO/Narcissus_0059",
					Text = "You'd give me such tokens of affection, full knowing I've already got a lot of them and, more importantly, am spoken for? Fine! Here's something to remember me by." },
			},
			NarcissusGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Narcissus_01" },
					},
				},
				{ Cue = "/VO/Narcissus_0060",
					Text = "Whoa, a present, you're so thoughtful and all that. Don't mean to be rude about it, just... don't get the wrong idea, OK?" },
				{ Cue = "/VO/Melinoe_2054", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "If I'm to keep taking from your copious supply of unused gifts, seems only fair that I give something in return from time to time." },
			},
			NarcissusGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Narcissus_01" },
					},
				},
				{ Cue = "/VO/Narcissus_0061",
					Text = "Oh! How thoughtful, and all that. You dummy, though! Don't you realize I'm just going to add this to the pile with the rest, so that some other would-be suitor ends up taking it?" },
				{ Cue = "/VO/MelinoeField_0735", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Sure, it's a gift! You get to decide what to do with it. Perhaps one of those other would-be suitors would enjoy it, if that's what you want." },
			},
			NarcissusGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Narcissus_01" },
					},
					NamedRequirementsFalse = { "NarcissusDirtyWater" },
				},
				{ Cue = "/VO/Narcissus_0062",
					Text = "Oh whoa, for {#Emph}me{#Prev}, how thoughtful. Look: Try all you like, I can't requite your {#Emph}love. {#Prev}Thought I'd make myself about as clear as these waters, just in case you've got the wrong idea {#Emph}again." },
				{ Cue = "/VO/MelinoeField_0736", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Not every gesture needs to be interpreted as having some romantic overtones, does it? You've made your feelings unambiguous, and I appreciate that. {#Emph}As a friend." },
			},

			-- placeholder
			NarcissusGiftTemp =
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

			{ Cue = "/VO/MelinoeField_0033", Text = "How could I ever forget you, Narcissus?" },
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
			ObjectType = "NPC_Narcissus_01",
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
				{ Name = "NarcissusSpokeRecently", Time = 7 },
			},

			{ Cue = "/VO/Narcissus_0033", Text = "Excuse me?" },
			{ Cue = "/VO/Narcissus_0034", Text = "You're rippling the water!" },
			{ Cue = "/VO/Narcissus_0035", Text = "Oh stop.", PlayFirst = true },
			{ Cue = "/VO/Narcissus_0036", Text = "I don't like you like that." },
			{ Cue = "/VO/Narcissus_0037", Text = "Quit it." },
			{ Cue = "/VO/Narcissus_0038", Text = "Would you cut it out?" },
		},
	},

	NPC_Narcissus_Field_01 =
	{
		InheritFrom = { "NPC_Narcissus_01" },
		GenusName = "NPC_Narcissus_01",
		ActivateRequirements =
		{
			NamedRequirements = { "NarcissusInFields" },
		},

		InteractTextLineSets =
		{
			-- partner conversations
			NarcissusWithEcho01 =
			{
				Partner = "NPC_Echo_01",
				PlayOnce = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,

				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.NarcissusFieldsGreeting,

				EndGlobalVoiceLines = "MiscEndVoiceLines_Echo",
			},
		}
	}

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Narcissus )