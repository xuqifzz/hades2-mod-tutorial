UnitSetData.NPC_Icarus =
{
	NPC_Icarus_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Icarus_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.IcarusVoice,
		SpeakerName = "Icarus",
		AnimOffsetZ = 250,
		InvincibubbleScale = 1.2,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		ThemeMusic = "/Music/ArtemisTheme_MC", -- for now
		DoorTakenText = "CannotUseObject",
		ExitSpeed = 500,
		HideHealthBar = true,

		UpgradeScreenOpenSound = "/SFX/WeaponUpgradeHammerDrop2",
		UpgradeSelectedSound = "/SFX/HammerBoonChoice",
		MenuTitle = "IcarusChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Icarus",
		FlavorTextIds =
		{
			"IcarusChoiceMenu_FlavorText01",
		},

		PackageName = "NPC_Icarus_01",
		Traits = {
			"FocusAttackDamageTrait",
			"FocusSpecialDamageTrait",
			"OmegaExplodeBoon",
			"CastHazardBoon",
			"BreakInvincibleArmorBoon",
			"BreakExplosiveArmorBoon",
			"SupplyDropBoon",
		},
		GiftGameStateRequirements = 
		{
			--
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Icarus_01" },
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
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_3509", Text = "Be safe, Icarus.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3510", Text = "Go unseen, all right?" },
			},
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				{ Cue = "/VO/Icarus_0061", Text = "You too, Meli.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_3509", "/VO/Melinoe_3510" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0098", Text = "Same.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_3509", "/VO/Melinoe_3510" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0099", Text = "Hello...!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0100", Text = "Hey.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0101", Text = "Evening!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698_2", "/VO/Melinoe_1699_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0102", Text = "You'll show him.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0103", Text = "Death to Chronos...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0104", Text = "Cheers.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0105", Text = "You too.",					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2", "/VO/Melinoe_1703_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0106", Text = "I'll take it.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703_2", "/VO/Melinoe_1705_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0107", Text = "Beautiful evening.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0108", Text = "Wherever we're going.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
			},
		},

		ActivateRequirements =
		{
			-- None
		},

		--[[
		SpawnVoiceLines =
		{
		},
		]]--

		InteractTextLineSets =
		{
			IcarusFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GiftableOffSource = true,

				{ Cue = "/VO/Icarus_0062",
					Text = "It's really you. Before you say anything, I know I'm not supposed to be here, but I spotted this ship and had to drop in for a closer look. And now I'm going to take off! So let's pretend this never happened, hey?" },
				{ Cue = "/VO/MelinoeField_1930", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hold it right there, Icarus! I'm not about to let you just fly out on me again without a chat at least. To start with, what are you doing in the middle of this blasted war?" },
				{ Cue = "/VO/Icarus_0003",
					Text = "The same thing I've {#Emph}been {#Prev}doing: slowing these bastards down. If everyone like me pitched in a little bit, this war would have been well over by now." },
				{ Cue = "/VO/MelinoeField_1931", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That may be so. But this is a matter between gods and Titans. I wouldn't want you to get hurt." },
				{ Cue = "/VO/Icarus_0004",
					Text = "Bit late for that, Meli! Anyway, I've kept you for too long, but let me give you something I've been working on before I go — and these all work. I swear!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutMelinoe01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
					},
				},

				{ Cue = "/VO/Icarus_0025_D",
					Text = "Your arm...! Never got better, did it? I'm really sorry, I should never have put you on the spot." },
				{ Cue = "/VO/MelinoeField_2010", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not your fault. I had... grown very confident in my abilities. Headmistress always said there was no way to make Shades whole again, but I thought otherwise. Overextended, learned a lesson I'm not going to forget." },
				{ Cue = "/VO/Icarus_0026",
					Text = "I felt so bad... couldn't look at anybody in the Crossroads anymore. Thought I'd never see you again. That it'd be for the best. I... had a lot I needed to sort out." },
				{ Cue = "/VO/MelinoeField_2011", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And how did it go? You learned to fly, at least! Top of your list of fears, conquered. With your father's wings, no less!" },
				{ Cue = "/VO/Icarus_0027",
					Text = "These wings are mine, Meli. That was all part of it. Had to learn to do things for myself, like you did. And for what it's worth, I still think your arm looks amazing. Now, here." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutFlying01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",

				{ Cue = "/VO/Icarus_0028",
					Text = "Been flying for a while now! At first, it brought me back to the terror I felt as a kid. Those final moments... I wanted to put myself through them, again and again. Don't know why." },
				{ Cue = "/VO/MelinoeField_2012", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Icarus, you were young and you made a mistake. What's the use torturing yourself for it for all eternity? I thought you wanted to learn to fly to prove yourself to your father." },
				{ Cue = "/VO/Icarus_0029",
					Text = "Come on, Meli. I'm never going to prove myself to him. But something happened as I kept trying to use my wings... I, I started to like it! Seeing from a different point of view." },
				{ Cue = "/VO/MelinoeField_2013", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You look so in your element up there! I always believed, if I could make you whole again, perhaps some night we'd learn to fly together. I still want to feel what it's like." },
				{ Cue = "/VO/Icarus_0030",
					Text = "You've no idea know how much I wanted that too. But, it was something I had to do on my own. I'd offer to take you up with me now, but... yeah, Shades and goddesses don't mix." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutFlying02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutFlying01", "IcarusGift02" },
					},
				},

				{ Cue = "/VO/MelinoeField_2015", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know, you've changed. You seem... more full of life. I catch these glimpses of your face while you're in flight, and... it's like there's a joy in you I never saw before." },
				{ Cue = "/VO/Icarus_0032",
					Text = "{#Emph}Heh{#Prev}, well... there's the flying, which admittedly doesn't get old... and then there's seeing you, taking on the legions of Chronos single-handedly. Using all your training. {#Emph}Wow..." },
				{ Cue = "/VO/MelinoeField_2016", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I didn't take them on single-handedly, Icarus, but... it's good to know about the flying! It must be exhilarating." },
				{ Cue = "/VO/Icarus_0033",
					Text = "It is, Meli. You could always see right through me so no point in trying to sell it short. I hope some night you'll get a shot at it and tell me what you think." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutFlying03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",

				{ Cue = "/VO/MelinoeField_2150", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If you love flying so much, why do you keep helping me? Once my father's throne is restored, the gates of the Underworld will shut, and you'll be forced to return." },
				{ Cue = "/VO/Icarus_0063",
					Text = "I know. I would miss flying, sure. But, I think I could live without it if I had to — {#Emph}exist {#Prev}without it, you know what I mean. My plan is just to make the most of it, for now. We mortals are taught to believe nothing lasts forever anyway." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "TempHammerKeepsake" },
					},
				},

				{ Cue = "/VO/Icarus_0076",
					Text = "You brought along the little Hammer from me, hey? First one I ever made! First that was any good, at least. Sort of a funny process, making things for making things..." },
				{ Cue = "/VO/MelinoeField_2158", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Icarus, how could you give me this? You should hold onto it, as a reminder of how far you've come as a creator. I would have figured this to be one of your father's masterworks...!" },
				{ Cue = "/VO/Icarus_0077",
					Text = "It's much more special in your care than mine. Creating tools that others can use to reach new heights... that's how I reach them myself. You're doing me a solid here, Meli!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutReturning01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",

				{ Cue = "/VO/MelinoeField_2014", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You said yourself you're not supposed to be here, Icarus. Chronos may have flung open the Underworld gates, but your place is still below with us. Come back." },
				{ Cue = "/VO/Icarus_0031",
					PreLineWait = 0.35,
					Text = "...I always messed everything up, you know. I just want to be useful to someone, for once! So please... let me stay here. Let me have this!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutReturning02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",

				{ Cue = "/VO/Icarus_0072",
					Text = "The wretches on these ships don't have their wits, but they hit hard. I, I know you're good and everything, {#Emph}better {#Prev}than good, it's just... if things go bad... what happens to you then?" },
				{ Cue = "/VO/MelinoeField_2156", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The first thing Headmistress taught me was how not to give in. If my strength is failing me, I use it to return to shadow whence I came. Almost a reflex at this point." },
				{ Cue = "/VO/Icarus_0073",
					Text = "And then at the Crossroads, you're up and about by the following night, raring to go? Too bad you can't return-to-shadow back to where you left off..." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutSurfaceCurse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
					},
				},

				{ Cue = "/VO/Icarus_0066",
					Text = "Wait, what are you even {#Emph}doing {#Prev}here? I thought you were supposed to be bound to the Underworld, but here you are, commandeering warships and whatnot!" },
				{ Cue = "/VO/MelinoeField_2152", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I am still bound there, I just loosened the bindings a bit. Though I feel absolutely wretched now, so if the legions of Chronos don't stop me soon, my blood-curse surely will." },
				{ Cue = "/VO/Icarus_0067",
					Emote = "PortraitEmoteSurprise",
					Text = "Really? Because you look great! {#Emph}Erm{#Prev}, you look... you look {#Emph}well{#Prev}, I mean. Unafflicted by a curse of any sort. Maybe a little seasick is all! Just, take one of these hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutDaedalus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "WeaponUpgrade" }
					},
				},

				{ Cue = "/VO/MelinoeField_2147", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How fares your father, by the way? You've no idea how happy I am to find Daedalus Hammers out there... I never see him around, so can never thank him in person." },
				{ Cue = "/VO/Icarus_0034",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Heh! {#Prev}I'll be sure to send him your regards when next I happen to run into him, though it's been a little while. I'm glad his Hammers have been of some use. Have another?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutDaedalus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutDaedalus01" },
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "WeaponUpgrade" },
					},
				},
				{ Cue = "/VO/Icarus_0035",
					Text = "You asked about my father the other night... and truth is, though you probably already know, I never see him around either. I think he might have retired!" },
				{ Cue = "/VO/MelinoeField_2148", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Daedalus, {#Emph}retired? {#Prev}I just found one of his Hammers earlier! He's been of constant help to me since all this started, he... wait... {#Emph}what...?" },
				{ Cue = "/VO/Icarus_0036",
					Text = "Meli, I'm his apprentice! He'd been building for a long time and needed a break. I'm nowhere near him but it's not like there was anybody else.... The Hammers come in handy though?" },
				{ Cue = "/VO/MelinoeField_2149", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Stop, you're hurting my head. The {#Emph}Daedalus Hammers {#Prev}I've been finding are from {#Emph}you? {#Prev}Shouldn't they be {#Emph}Icarus {#Prev}Hammers then?" },
				{ Cue = "/VO/Icarus_0037",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Erm{#Prev}, we have a certain reputation to uphold. Not sure slapping my name on my father's designs would do us any good. Please... don't go telling anyone about this hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutDaedalus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift02", "IcarusAboutDaedalus02" },
					},
				},
				{ Cue = "/VO/MelinoeField_2154", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You made your own wings, munitions, apparently the latest Daedalus Hammers... you've become quite the craftsman!" },
				{ Cue = "/VO/Icarus_0070",
					Text = "Come on, Meli. My father was a master by the time he was my age, even before I died. I'll never surpass him." },
				{ Cue = "/VO/MelinoeField_2155", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's not what I've said. Your work is your own, and it's good! Better than good. When are you finally going to step out from your father's shadow?" },
				{ Cue = "/VO/Icarus_0071",
					Text = "Funny question coming from you! My father may not be a god... but he's probably the greatest artist and inventor that ever lived. He'd be the first to say I'll never reach his level. Anyway, I'm through trying to prove myself to him." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
				},

				{ Cue = "/VO/Icarus_0068",
					Text = "The other night, I saw these huge black wings on the horizon; definitely {#Emph}not {#Prev}a Harpy. Could have sworn it was bloody Eris... but, wasn't she still at the Crossroads, with you?" },
				{ Cue = "/VO/MelinoeField_2153", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well I'm not at the Crossroads either, but... unfortunately Strife Incarnate has been getting in my way. So she showed up around the time I did?" },
				{ Cue = "/VO/Icarus_0069",
					Text = "Come to think of it, yes! {#Emph}Whew...! {#Prev}I was beginning to worry she was here because of something {#Emph}I {#Prev}did. Never occurred to me she was just following you around, same as ever." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutOdysseus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
				},

				{ Cue = "/VO/Icarus_0074",
					Text = "How's everybody back at the Crossroads lately hey? Master Odysseus putting all his plans to action at long last?" },
				{ Cue = "/VO/MelinoeField_2157", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, yes. My route through here is thanks only to him. Say, he didn't put you up to this, did he? Deploying Shades with makeshift wings and explosives seems like something the Great Tactician would do..." },
				{ Cue = "/VO/Icarus_0075",
					Text = "I'm acting on my own. Although maybe we're all part of the Great Tactician's plan and just don't realize it yet. He always said we'll have to improvise... might be I finally took it to heart." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					-- @ update with improved reqs; clears since last meeting
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "ActiveBounty" },
					},

					{
						PathTrue = { "CurrentRun", "UseRecord", "WeaponUpgrade" },
					},
				},
				{ Cue = "/VO/Icarus_0064",
					Text = "Something happened since the last time you were here... these ships, one after another they all {#Emph}sank! {#Prev}Never seen these waters so calm. {#Emph}Did you...?" },
				{ Cue = "/VO/MelinoeField_2151", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Did I reach Chronos in my father's House and slay him? Yes. And, did he then reconstitute himself, perhaps entirely negating whatever I achieved? Also, yes." },
				{ Cue = "/VO/Icarus_0065",
					Text = "I always knew you'd get him, Meli. Well as you can see his risen fleet has risen once again! Though sounds to me like you've found one of its weaknesses." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			-- Repeatable
			IcarusChat01 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0005",
					Text = "Was just out for a little jaunt is all and figured I'd stop in. Was good seeing you, Meli." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat02 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0006",
					Text = "Rough waters this evening, though the skies above aren't bad. You take care of yourself, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat03 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0007",
					Text = "Think I saw Eris further up the coast. How about you bring her a little surprise?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0008",
					Text = "What I wouldn't give to stay here longer and catch up, but I know it's not the time or place." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat05 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0009",
					Text = "You were amazing, Meli. I saw everything up there! Keep going hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat06 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0010",
					Text = "Got places to be, I know. Fortunately, I've got just the thing to help you get there." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat07 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0011",
					Text = "Think we'll look back someday on all of this and miss it, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat08 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0012",
					Text = "Don't know how you handle this night after night, though I am glad you do." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat09 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0013",
					Text = "Always good to see you, Meli, even for a bit. Nobody else will test this stuff for me!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat10 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0014",
					Text = "The coast is clear for now! Though, past this point, no guarantees." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat11 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0015",
					Text = "Think I took care of one or two of them back there. Better than nothing hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat12 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0016",
					Text = "Been tinkering around with these. Take whichever one you want!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat13 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0017",
					Text = "Whichever one of these you choose comes with a total satisfaction guarantee." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat14 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0018",
					Text = "The mountain isn't far from here. Maybe these will help you make the climb." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat15 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0019",
					Text = "I know that you don't have a lot of time, so here. For the road ahead." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat16 =
			{
				GameStateRequirements =
				{
					{
					},
					RequiredMinHealthFraction = 0.75,
				},
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0020",
					Text = "Still perfectly all right...! Had me a little worried for a moment there." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat17 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0021",
					Text = "I'd fly you right up to the palace of the gods right now, if only I could..." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat18 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0022",
					Text = "Anything you need, just say the word. Though right now, this is all I've got." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat19 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0023",
					Text = "Even the gods themselves need somebody to fight for them, don't they...?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat20 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0024",
					Text = "You're more than halfway there, Meli... or pretty close, I think. No stopping now!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat21 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0081",
					Text = "We'll have to catch up when you're free. No rush! Got all the time in the world." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat22 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0082",
					Text = "Only so much I can do to help! But then it's something, hey? So here." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat23 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Icarus_0083",
					Text = "This ship feels like it's going to sink at any moment, so let's not stick around..." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat24 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0084",
					Text = "Maybe you'll find some use in one of these. They're all I've got tonight." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat25 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0085",
					Text = "These aren't up to my father's standard, but they're not too bad I think..." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat26 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift03" },
					},
				},
				{ Cue = "/VO/Icarus_0086",
					Text = "Keep thinking how I've never felt so alive as when I'm here with you..." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat27 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0087",
					Text = "Olympus isn't too much farther. I'll fly on ahead and draw some of the heat." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat28 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0088",
					Text = "A lot of Shades out there believe in you and what you're working to achieve." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat29 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0089",
					Text = "Can I just say, these wings hold up {#Emph}much {#Prev}better than the ones my father made?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat30 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0090",
					Text = "Safe to say I never imagined my afterlife would turn out anything like this." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat31 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0091",
					Text = "I know you can handle yourself, but let me see what I can do to help here. Please." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat32 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
					},
				},
				{ Cue = "/VO/Icarus_0092",
					Text = "Always a pleasure, Meli... I'm back on my feet but still feel like I'm flying...!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

		},

		GiftTextLineSets =
		{
			IcarusGift01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Icarus_01" },
					},
				},
				{ Cue = "/VO/Melinoe_3264", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You can fly wherever you want now! But, I'm glad you didn't go so far I couldn't catch up. Here! In light of your godlike wings, a little gift." },
				{ Cue = "/VO/Icarus_0038",
					Emote = "PortraitEmoteSurprise",
					Text = "Oh come on, just because I've been flying around near Olympus, doesn't mean I get to feast like I'm from there! Maybe with your permission, hey? Know what, I got something for you, too." },
			},
			IcarusGift02 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Icarus_01" },
					},
				},
				{ Cue = "/VO/Icarus_0039",
					Text = "The last Nectar you got me was {#Emph}so {#Prev}good, can't even imagine what it would have been like while I was still alive. Wasn't going to ask for another, but... since you're offering!" },
				{ Cue = "/VO/Melinoe_3266", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm offering, so here! Maybe it's even better now that you're a Shade. You mortals had to eat and drink out of necessity. But Nectar helps fulfill a different kind of need." },
			},

			IcarusGift03 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Icarus_01" },
					},
				},
				{ Cue = "/VO/Icarus_0078",
					Text = "As a mortal kid confined to a tower, I was relatively well provided for, but {#Emph}this? {#Prev}I know better than to envy the gods, especially with what they're going through lately... but they definitely know their drink." },
				{ Cue = "/VO/Melinoe_3499", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The gods have always lived well... but your own life was so short and difficult. You must still have a lot of making up to do, and I thought maybe this could help!" },
			},

			-- placeholder
			IcarusGiftTemp =
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

			{ Cue = "/VO/Melinoe_3265", Text = "Is this one of your inventions? Amazing! Thank you...!" },
		},

		EncounterStartVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1.15,
				Source = { LineHistoryName = "NPC_Icarus_01", SubtitleColor = Color.IcarusVoice },
				Cooldowns =
				{
					{ Name = "IcarusAnyQuipSpeech", Time = 10 },
				},

				{ Cue = "/VO/Icarus_0040", Text = "Mind if I swoop in?" },
				{ Cue = "/VO/Icarus_0041", Text = "Incoming!" },
				{ Cue = "/VO/Icarus_0042", Text = "Heads up, Meli!" },
				{ Cue = "/VO/Icarus_0043", Text = "Hey, what's going on?" },
				{ Cue = "/VO/Icarus_0044", Text = "Death from above!" },
				{ Cue = "/VO/Icarus_0045", Text = "Thought I'd drop in!" },
				{ Cue = "/VO/Icarus_0046", Text = "You get away from her!" },
				{ Cue = "/VO/Icarus_0047", Text = "Brought some for everyone!" },
				{ Cue = "/VO/Icarus_0048", Text = "Fight on, I'll back you up!" },
				{ Cue = "/VO/Icarus_0093", Text = "You have this, Meli!" },
				{ Cue = "/VO/Icarus_0094", Text = "How's your evening going?" },
				{ Cue = "/VO/Icarus_0095", Text = "Bunch 'em up for me hey?" },
				{ Cue = "/VO/Icarus_0096", Text = "Beginning attack run...!", PlayFirst = true },
				{ Cue = "/VO/Icarus_0097", Text = "Engaging!" },
			},
			{
				PlayOnce = true,
				PlayOnceContext = "IcarusIntroReactionVO",
				UsePlayerSource = true,
				PreLineWait = 1.5,

				{ Cue = "/VO/MelinoeField_1932", Text = "What? {#Emph}Icarus...?" },
				{ Cue = "/VO/MelinoeField_1933", Text = "What are you doing here?!", PreLineWait = 0.7, BreakIfPlayed = true },
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

				{ Cue = "/VO/MelinoeField_2211", Text = "Icarus...!" },
				{ Cue = "/VO/MelinoeField_2212", Text = "He's back...!" },
				{ Cue = "/VO/MelinoeField_2213", Text = "Icarus!" },
				{ Cue = "/VO/MelinoeField_2214", Text = "Hi!" },
				{ Cue = "/VO/MelinoeField_2215", Text = "I see you!" },
				{ Cue = "/VO/MelinoeField_2216", Text = "Not much, you?",
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Icarus_0043" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2217", Text = "You're very welcome!",
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Icarus_0045" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2218", Text = "Even for me?",
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Icarus_0047" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2219", Text = "Let's do it!",
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Icarus_0048", "/VO/Icarus_0093" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2220", Text = "We have this!",
					PlayOnce = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Icarus_0097", "/VO/Icarus_0095" },
						},
					},
				},
			},
		},

		KillingEnemyVoiceLines =
		{
			--[[
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlay = 0.75,
				Source = { LineHistoryName = "NPC_Icarus_01", SubtitleColor = Color.IcarusVoice },
				Cooldowns =
				{
					{ Name = "IcarusAnyQuipSpeech", Time = 15 },
				},

				--
			},
			]]--
			{
				UsePlayerSource = true,
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				ChanceToPlay = 0.33,
				SuccessiveChanceToPlay = 0.05,
				Cooldowns =
				{
					{ Name = "MelinoeAnyQuipSpeech" },
				},
				TriggerCooldowns =
				{
					"IcarusAnyQuipSpeech",
				},

				{ Cue = "/VO/MelinoeField_2225", Text = "Well done!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2226", Text = "Got something!" },
				{ Cue = "/VO/MelinoeField_2227", Text = "Got another!" },
				{ Cue = "/VO/MelinoeField_2228", Text = "Cheers!" },
			}
		},

		EncounterEndVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.65,

				{ Cue = "/VO/Icarus_0049", Text = "Hello...!" },
				{ Cue = "/VO/Icarus_0050", Text = "Evening...!", PlayFirst = true },
				{ Cue = "/VO/Icarus_0051", Text = "Hey, Meli!" },
				{ Cue = "/VO/Icarus_0052", Text = "{#Emph}Aaand{#Prev}, done." },
				{ Cue = "/VO/Icarus_0120", Text = "Got you something...!" },
				{ Cue = "/VO/Icarus_0121", Text = "How goes it?" },
				{ Cue = "/VO/Icarus_0122", Text = "You all right...?" },
				{ Cue = "/VO/Icarus_0123", Text = "What's new?" },
				{ Cue = "/VO/Icarus_0124", Text = "You did it..." },
				{ Cue = "/VO/Icarus_0125", Text = "Rough waters..." },
				{ Cue = "/VO/Icarus_0126", Text = "Sorry to interrupt..." },
				{ Cue = "/VO/Icarus_0127", Text = "That was ugly..." },
				{ Cue = "/VO/Icarus_0128", Text = "Nice night...!" },
				{ Cue = "/VO/Icarus_0129", Text = "That was amazing." },
				{ Cue = "/VO/Icarus_0130", Text = "Not too bad..." },
			},
			{
				PreLineWait = 0.2,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,
				Cooldowns =
				{
					-- { Name = "MelinoeAnyQuipSpeech", Time = 60 },
				},

				{ Cue = "/VO/MelinoeField_2229", Text = "Hello..." },
				{ Cue = "/VO/MelinoeField_2230", Text = "Hi." },
				{ Cue = "/VO/MelinoeField_2231", Text = "Hey..." },
				{ Cue = "/VO/MelinoeField_2232", Text = "Good work." },
				{ Cue = "/VO/MelinoeField_2233", Text = "Nicely done." },
				{ Cue = "/VO/MelinoeField_2234", Text = "We made it." },
			},
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				PreLineWait = 0.75,
				Queue = "Always",
				ObjectType = "NPC_Icarus_01",

				{ Cue = "/VO/Icarus_0057", Text = "Bye for now...!", PlayFirst = true },
				{ Cue = "/VO/Icarus_0058", Text = "See you again...?" },
				{ Cue = "/VO/Icarus_0112", Text = "Nice seeing you...!" },
				{ Cue = "/VO/Icarus_0113", Text = "Be safe...!" },
				{ Cue = "/VO/Icarus_0114", Text = "All right I'm off...!" },
				{ Cue = "/VO/Icarus_0115", Text = "I'll be in touch...!" },
				{ Cue = "/VO/Icarus_0116", Text = "Good night...!" },
				{ Cue = "/VO/Icarus_0117", Text = "Till next time...!" },
				{ Cue = "/VO/Icarus_0118", Text = "See you..." },
				{ Cue = "/VO/Icarus_0119", Text = "I better go..." },
			},
			{
				PreLineWait = 0.2,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,
				Cooldowns =
				{
					-- { Name = "MelinoeAnyQuipSpeech", Time = 60 },
				},

				{ Cue = "/VO/MelinoeField_2235", Text = "Bye..." },
				{ Cue = "/VO/MelinoeField_2237", Text = "Off he goes." },
				{ Cue = "/VO/MelinoeField_2238", Text = "Careful out there..." },
				{ Cue = "/VO/MelinoeField_2239", Text = "See you..." },
				{ Cue = "/VO/MelinoeField_2240", Text = "{#Emph}<Sigh>" },
				{ Cue = "/VO/MelinoeField_2236", Text = "Yes...",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Icarus_0058" },
						},
					},
				},
			}
		},

		MissingDistanceTrigger =
		{
		},
	},

}

VariantSetData.NPC_Icarus_01 =
{
	IcarusCombat =
	{
		NonHeroKillCombatText = "PartnerKill",
		TreatAsGodLootByShops = true,
		RequiredRoomInteraction = true,
		SkipAISetupOnActivate = true,
		CanReceiveGift = true,
		Consumables = { },
		RarityChances =
		{
			Rare = 0.05,
			Epic = 0.01,
		},
		RarityRollOrder = { "Common", "Rare", "Epic" },

		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		InvincibubbleScale = 1.33,
		DefaultAIData =
		{
		},
		AIWakeDelay = 3.0,
		SkipAISetupOnActivate = true,
		AIOptions = { "AttackerAI" },
		PostCombatAI = "IcarusPostCombat",
		PostCombatTeleportIfPastDistance = 800,

		WeaponOptions =
		{
			--"IcarusBombardmentLine", "IcarusBombardmentLine2", "IcarusBombardmentLine3",
			"IcarusBombardmentLine", "IcarusBombardmentLine",
			"IcarusBombardmentSingle", "IcarusBombardmentSingle", "IcarusBombardmentSingle",
		},
		--WeaponOptions = { "IcarusBombardmentLine" },

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

		SkipNextTextLinesCheck = true,
	},
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Icarus )
OverwriteTableKeys( NPCVariantData, VariantSetData.NPC_Icarus_01 )