UnitSetData.NPC_Icarus =
{
	-- home version below
	NPC_Icarus_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Icarus_Default_01",
		Groups = { "NPCs" },
		SubtitleColor = Color.IcarusVoice,
		EmoteOffsetY = -300,
		EmoteOffsetX = -30,
		AnimOffsetZ = 50,
		SpeakerName = "Icarus",
		InvincibubbleScale = 1.2,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		ThemeMusic = "/Music/IcarusTheme_MC", -- for now
		DoorTakenText = "CannotUseObject",
		ExitSpeed = 500,
		HideHealthBar = true,
		TurnInPlaceAnimation = "Icarus_Turn",
		PreEventFunctionName = "AngleNPCToHero",
		BecomingCloserFunctionName = "BecomingCloserIcarusPresentation",

		UpgradeScreenOpenSound = "/SFX/WeaponUpgradeHammerDrop2",
		UpgradeSelectedSound = "/SFX/HammerBoonChoice",
		UpgradeAcquiredAnimation = "MelinoeEquip",
		UpgradeAcquiredAnimationDelay = 1.2,

		MenuTitle = "IcarusChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Icarus",
		FlavorTextIds =
		{
			"IcarusChoiceMenu_FlavorText01",
		},

		GoSomeplacePoint1 = 800387,
		GoSomeplacePoint2 = 800388,

		LoadPackages = { "NPC_Icarus_01", "Icarus" },
		Traits =
		{
			"FocusAttackDamageTrait",
			"FocusSpecialDamageTrait",
			"OmegaExplodeBoon",
			"CastHazardBoon",
			"BreakInvincibleArmorBoon",
			"BreakExplosiveArmorBoon",
			"SupplyDropBoon",
			"UpgradeHammerBoon",
		},

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args = { CreateAnimation = "OlympusColdBreathEmitter", },
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsAny =
							{
								"IcarusBecomingCloser01"
							},
						},
					},
				},
			},
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
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/Melinoe_3509", Text = "Be safe, Icarus.", PlayFirst = true },
				{ Cue = "/VO/Melinoe_3510", Text = "Go unseen, all right?" },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				PreLineWait = 0.32,
				RandomRemaining = true,
				ObjectType = "NPC_Icarus_01",
				PreLineAnim = "Icarus_Salute",

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
				{ Cue = "/VO/Icarus_0105", Text = "You too.",
					GameStateRequirements =
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
							IsAny = { "/VO/Melinoe_1703_2", "/VO/Melinoe_1704_2", "/VO/Melinoe_1705_2" },
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
							IsAny = { "/VO/Melinoe_1704_2", "/VO/Melinoe_1705_2", "/VO/Melinoe_1709_2" },
						},
					},
				},
			},
		},

		PlayerInjuredReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			Cooldowns =
			{
				{ Name = "IcarusAnyQuipSpeech", Time = 40 },
			},

			{ Cue = "/VO/Icarus_0317", Text = "Get {#Emph}off {#Prev}her...!" },
			{ Cue = "/VO/Icarus_0318", Text = "You all right?" },
			{ Cue = "/VO/Icarus_0319", Text = "Hey...!" },
			{ Cue = "/VO/Icarus_0320", Text = "Hold on...!" },
			{ Cue = "/VO/Icarus_0321", Text = "{#Emph}Urgh{#Prev}, damn...!", PlayFirst = true },
			{ Cue = "/VO/Icarus_0322", Text = "Let me help...!" },
			{ Cue = "/VO/Icarus_0323", Text = "Stand clear...!" },
			{ Cue = "/VO/Icarus_0324", Text = "Hey over {#Emph}here...!" },
		},
		LastStandReactionVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Cooldowns =
			{
				{ Name = "IcarusLastStandSpeech", Time = 40 },
			},
			TriggerCooldowns =
			{
				"IcarusAnyQuipSpeech",
			},
			{ Cue = "/VO/Icarus_0325", Text = "Come {#Emph}on{#Prev}, Meli...!", PlayFirst = true },
			{ Cue = "/VO/Icarus_0503", Text = "Just... {#Emph}argh!" },
			{ Cue = "/VO/Icarus_0504", Text = "{#Emph}Augh{#Prev}, just hang on...!" },
			{ Cue = "/VO/Icarus_0505", Text = "No..." },
			{ Cue = "/VO/Icarus_0506", Text = "Come {#Emph}on!" },
			{ Cue = "/VO/Icarus_0507", Text = "Those... {#Emph}rngh...!" },
		},

		KillingEnemyVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.45,
				SuccessiveChanceToPlay = 0.5,
				Source = { LineHistoryName = "NPC_Icarus_01", SubtitleColor = Color.IcarusVoice },
				Cooldowns =
				{
					{ Name = "IcarusAnyQuipSpeech", Time = 20 },
				},

				{ Cue = "/VO/Icarus_0302", Text = "That's a {#Emph}hit!" },
				{ Cue = "/VO/Icarus_0303", Text = "Got 'em!" },
				{ Cue = "/VO/Icarus_0304", Text = "Think I got 'em!" },
				{ Cue = "/VO/Icarus_0305", Text = "Got one!", PlayFirst = true },
				{ Cue = "/VO/Icarus_0306", Text = "{#Emph}Hah!" },
				{ Cue = "/VO/Icarus_0307", Text = "See that?" },
				{ Cue = "/VO/Icarus_0308", Text = "Eat {#Emph}that!" },
				{ Cue = "/VO/Icarus_0309", Text = "Direct hit." },
				{ Cue = "/VO/Icarus_0310", Text = "Easy enough!" },
				{ Cue = "/VO/Icarus_0311", Text = "There!" },
				{ Cue = "/VO/Icarus_0312", Text = "Yes...!" },
				{ Cue = "/VO/Icarus_0313", Text = "Threat destroyed." },
				{ Cue = "/VO/Icarus_0314", Text = "That worked!" },
				{ Cue = "/VO/Icarus_0315", Text = "Down they go." },
				{ Cue = "/VO/Icarus_0316", Text = "That's it." },
				{ Cue = "/VO/Icarus_0219", Text = "{#Emph}There!" },
			},
			{
				UsePlayerSource = true,
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.15,
				SuccessiveChanceToPlay = 0.05,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.5, },
					},
					ChanceToPlay = 0.33,
				},
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
			},
		},

		KillStolenVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 0.5,
			SuccessiveChanceToPlay = 0.5,
			SuccessiveChanceToPlayAll = 0.25,
			Source = { LineHistoryName = "NPC_Icarus_01", SubtitleColor = Color.IcarusVoice },
			GameStateRequirements =
			{
				ChanceToPlay = 0.5,
			},
			Cooldowns =
			{
				{ Name = "IcarusKillStealSpeech", Time = 40 },
				{ Name = "IcarusAnyQuipSpeech", Time = 12 }
			},

			{ Cue = "/VO/Icarus_0530", Text = "Missed..." },
			{ Cue = "/VO/Icarus_0531", Text = "I missed...?", PlayFirst = true },
			{ Cue = "/VO/Icarus_0532", Text = "Blast..." },
			{ Cue = "/VO/Icarus_0533", Text = "Damn it...!" },
			{ Cue = "/VO/Icarus_0534", Text = "{#Emph}Augh..." },
			{ Cue = "/VO/Icarus_0535", Text = "Not quite..." },
		},

		InteractTextLineSets =
		{
			IcarusFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				InitialGiftableOffSource = true,
				GiftableOffSource = true,

				{ Cue = "/VO/Icarus_0062",
					-- Portrait = "Portrait_Icarus_Pleased_01",
					-- Portrait = "Portrait_Icarus_Unsure_01",
					-- PreLineAnim = "Icarus_Salute",
					-- PreLineAnim = "Icarus_Explaining_Start",
					-- PostLineAnim = "Icarus_Explaining_End",
					-- PreLineAnim = "Icarus_Flustered_Start",
					-- PostLineAnim = "Icarus_Flustered_End",
					-- PreLineAnim = "Icarus_Pensive_Start",
					-- PostLineAnim = "Icarus_Pensive_End",
					-- PreLineAnim = "Icarus_Offer_Start",
					-- PostLineAnim = "Icarus_Offer_End",

					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "It's really you. Before you say anything, I know I'm not supposed to be here, but I spotted this ship and had to drop in for a closer look. And now I'm going to take off! So let's pretend this never happened, hey?" },
				{ Cue = "/VO/MelinoeField_1930", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hold it right there, Icarus! I'm not about to let you just fly out on me again without a chat at least. To start with, what are you doing in the middle of this blasted war?" },
				{ Cue = "/VO/Icarus_0003",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Portrait = "Portrait_Icarus_Unsure_01",
					Text = "The same thing I've {#Emph}been {#Prev}doing: slowing these bastards down. If everyone like me pitched in a little bit, this war would have been well over by now." },
				{ Cue = "/VO/MelinoeField_1931", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That may be so. But this is a matter between gods and Titans. I wouldn't want you to get hurt." },
				{ Cue = "/VO/Icarus_0004",
					Portrait = "Portrait_Icarus_Pleased_01",
					Text = "Bit late for that, Meli! Anyway, I've kept you for too long, but let me give you something I've been working on before I go — and these all work. I swear!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutMelinoe01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
					},
				},

				{ Cue = "/VO/Icarus_0025_D",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "Your arm...! Never got better, did it? I'm really sorry, I should never have put you on the spot." },
				{ Cue = "/VO/MelinoeField_2010", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Not your fault. I had... grown very confident in my abilities. Headmistress always said there was no way to make Shades whole again, but I thought otherwise. Overextended, learned a lesson I'm not going to forget." },
				{ Cue = "/VO/Icarus_0026",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "I felt so bad... couldn't look at anybody in the Crossroads anymore. Thought I'd never see you again. That it'd be for the best. I... had a lot I needed to sort out." },
				{ Cue = "/VO/MelinoeField_2011", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And how did it go? You learned to fly, at least! Top of your list of fears, conquered. With your father's wings, no less!" },
				{ Cue = "/VO/Icarus_0027",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "These wings are mine, Meli. That was all part of it. Had to learn to do things for myself, like you did. And for what it's worth, I think your arm looks amazing. Now, here." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			-- alt below
			IcarusAboutFlying01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusAboutFlying01_B" }
					},
				},

				{ Cue = "/VO/Icarus_0028",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Been flying for a while now! At first, it brought me back to the terror I felt as a kid. Those final moments... I wanted to put myself through them, again and again. Don't know why." },
				{ Cue = "/VO/MelinoeField_2012", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Icarus, you were young and you made a mistake. What's the use torturing yourself for it for all eternity? I thought you wanted to learn to fly to prove yourself to your father." },
				{ Cue = "/VO/Icarus_0029",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "Come on, Meli. I'm never going to prove myself to him. But something happened as I kept trying to use my wings... I, I started to like it! Seeing from a different point of view." },
				{ Cue = "/VO/MelinoeField_2013", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You look so in your element up there! I always believed, if I could make you whole again, perhaps some night we'd learn to fly together. I still want to feel what it's like." },
				{ Cue = "/VO/Icarus_0030",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "You've no idea know how much I wanted that too. But, it was something I had to do on my own. I'd offer to take you up with me now, but... yeah, Shades and goddesses don't mix." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutFlying01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusAboutFlying01" }
					},
				},

				{ Cue = "/VO/Icarus_0028",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Been flying for a while now! At first, it brought me back to the terror I felt as a kid. Those final moments... I wanted to put myself through them, again and again. Don't know why." },
				{ Cue = "/VO/MelinoeField_2012", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Icarus, you were young and you made a mistake. What's the use torturing yourself for it for all eternity? I thought you wanted to learn to fly to prove yourself to your father." },
				{ Cue = "/VO/Icarus_0029",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "Come on, Meli. I'm never going to prove myself to him. But something happened as I kept trying to use my wings... I, I started to like it! Seeing from a different point of view." },
				{ Cue = "/VO/MelinoeField_2013_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You look so in your element up there! I always believed, if I could make you whole again, perhaps some night we'd fly together..." },
				{ Cue = "/VO/Icarus_0030",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "You've no idea know how much I wanted that too. But, it was something I had to do on my own. I'd offer to take you up with me now, but... yeah, Shades and goddesses don't mix." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			-- heart unlock
			-- alt below
			IcarusAboutFlying02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusBathHouse02", "IcarusTaverna01", "IcarusFishing01", "IcarusGift06" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "IcarusAboutFlying01", "IcarusAboutFlying01_B" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusAboutFlying02_B" },
					},
				},

				{ Cue = "/VO/MelinoeField_2015", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know, you've changed. You seem... more full of life. I catch these glimpses of your face while you're in flight, and... it's like there's a joy in you I never saw before." },
				{ Cue = "/VO/Icarus_0032",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "{#Emph}Heh{#Prev}, well... there's the flying, which admittedly doesn't get old... and then there's seeing you, taking on the legions of Chronos single-handedly. Using all your training. {#Emph}Wow..." },
				{ Cue = "/VO/MelinoeField_2016", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I didn't take them on single-handedly, Icarus, but... it's good to know about the flying! It must be exhilarating." },
				{ Cue = "/VO/Icarus_0033",

					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },

					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "It is, Meli. You could always see right through me so no point in trying to sell it short. I hope some night you'll get a shot at it and tell me what you think." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutFlying02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusBathHouse02", "IcarusTaverna01", "IcarusFishing01", "IcarusGift06" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "IcarusAboutFlying01", "IcarusAboutFlying01_B" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusAboutFlying02" },
					},
				},

				{ Cue = "/VO/MelinoeField_2015", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkPensive01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know, you've changed. You seem... more full of life. I catch these glimpses of your face while you're in flight, and... it's like there's a joy in you I never saw before." },
				{ Cue = "/VO/Icarus_0032",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "{#Emph}Heh{#Prev}, well... there's the flying, which admittedly doesn't get old... and then there's seeing you, taking on the legions of Chronos single-handedly. Using all your training. {#Emph}Wow..." },
				{ Cue = "/VO/MelinoeField_2016", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I didn't take them on single-handedly, Icarus, but... it's good to know about the flying! It must be exhilarating." },
				{ Cue = "/VO/Icarus_0033_B",

					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },

					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "It is, Meli. You could always see right through me so no point in trying to sell it short." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutFlying03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/MelinoeField_2150", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkBrooding01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If you love flying so much, why do you keep helping me? Once my father's throne is restored, the gates of the Underworld will shut, and you'll be forced to return." },
				{ Cue = "/VO/Icarus_0063",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I know. I would miss flying, sure. But, I think I could live without it if I had to — {#Emph}exist {#Prev}without it, you know what I mean. My plan is just to make the most of it, for now. We mortals are taught to believe nothing lasts forever anyway." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
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
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "It's much more special in your care than mine. Creating tools that others can use to reach new heights... that's how I reach them myself. You're doing me a solid here, Meli!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutKeepsake02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "TempHammerKeepsake" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "TempHammerKeepsake", 1, "Rarity" },
						IsAny = { "Epic", "Heroic" },
					},
				},

				{ Cue = "/VO/Icarus_0397",
					Text = "Been getting use from that old Hammer of mine, hey? I thought maybe you'd stash it somewhere it would gather dust. It's earned a break from everything I put it through!" },

				{ Cue = "/VO/MelinoeField_4033", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Wait you {#Emph}don't {#Prev}want me using it like this? If your intent was that it gather dust from the environment, then I think some sort of fur-lined surface would make it much more effective." },

				{ Cue = "/VO/Icarus_0398",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "No, no, I think the way you're using it is great. Seems like the charm on it is even stronger than it used to be! I'm just glad it's been of any help." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutReturning01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusAboutCrossroads01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
					},
					NamedRequirementsFalse = { "IcarusUnlockedInHub" },
				},

				{ Cue = "/VO/MelinoeField_2014", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You said yourself you're not supposed to be here, Icarus. Chronos may have flung open the Underworld gates, but your place is still below with us. Come back." },
				{ Cue = "/VO/Icarus_0031",
					PreLineWait = 0.35,
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "...I always messed everything up, you know. I just want to be useful to someone, for once! So please... let me stay here. Let me have this!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutReturning02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Icarus_0072",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "The wretches on these ships don't have their wits, but they hit hard. I, I know you're good and everything, {#Emph}better {#Prev}than good, it's just... if things go bad... what happens to you then?" },
				{ Cue = "/VO/MelinoeField_2156", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The first thing Headmistress taught me was how not to give in. If my strength is failing me, I use it to return to shadow whence I came. Almost a reflex at this point." },
				{ Cue = "/VO/Icarus_0073",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "And then at the Crossroads, you're up and about by the following night, raring to go? Too bad you can't return-to-shadow back to where you left off..." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutSurfaceCurse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},

				{ Cue = "/VO/Icarus_0066",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Portrait = "Portrait_Icarus_Unsure_01",
					Text = "Wait, what are you even {#Emph}doing {#Prev}here? I thought you were supposed to be bound to the Underworld, but here you are, commandeering warships and whatnot!" },
				{ Cue = "/VO/MelinoeField_2152", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I am still bound there, I just loosened the bindings a bit. Though I feel absolutely wretched now, so if the legions of Chronos don't stop me soon, my blood-curse surely will." },
				{ Cue = "/VO/Icarus_0067",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Icarus_Unsure_01", WaitTime = 5 },
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "Really? Because you look great! {#Emph}Erm{#Prev}, you look... you look {#Emph}well{#Prev}, I mean. Unafflicted by a curse of any sort. Maybe a little seasick is all! Just... take one of these, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutTimePassing01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					-- borderline
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/Icarus_0162",
					Text = "Been some nights since we last did this hasn't it, Meli? I figured you'd show up soon enough, though... unless maybe Chronos finally got you or something terrible like that?" },
				{ Cue = "/VO/MelinoeField_3100", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If you were truly worried for me, thank you, Icarus... but also don't do that. The concern does us no good; if you're distracted, you can't fight the Titan's legions to the fullest." },
				{ Cue = "/VO/Icarus_0163",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Oh, it's all right, I get distracted all the time! Except when I'm at work, or in the sky. Which, not coincidentally, are the two things that keep me busy recently!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			-- about other characters
			IcarusAboutDaedalus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "WeaponUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift02" },
					},
				},

				{ Cue = "/VO/MelinoeField_2147", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How fares your father, by the way? You've no idea how happy I am to find Daedalus Hammers out there... I never see him around, so can never thank him in person." },
				{ Cue = "/VO/Icarus_0034",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					Text = "{#Emph}Heh! {#Prev}I'll be sure to send him your regards when next I happen to run into him, though it's been a little while. I'm glad his Hammers have been of some use. Have another?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutDaedalus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
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
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "You asked about my father the other night... and truth is, though you probably already know, I never see him around either. I think he might have retired!" },
				{ Cue = "/VO/MelinoeField_2148", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Daedalus, {#Emph}retired? {#Prev}I just found one of his Hammers earlier! He's been of constant help to me since all this started, he... wait... {#Emph}what...?" },
				{ Cue = "/VO/Icarus_0036",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Meli, I'm his apprentice! He'd been building for a long time and needed a break. I'm nowhere near him but it's not like there was anybody else.... The Hammers come in handy though?" },
				{ Cue = "/VO/MelinoeField_2149", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Stop, you're hurting my head. The {#Emph}Daedalus Hammers {#Prev}I've been finding are from {#Emph}you? {#Prev}Shouldn't they be {#Emph}Icarus {#Prev}Hammers then?" },
				{ Cue = "/VO/Icarus_0037",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					Text = "{#Emph}Erm{#Prev}, we have a certain reputation to uphold. Not sure slapping my name on my father's designs would do us any good. Please... don't go telling anyone about this, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutDaedalus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
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
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "Come on, Meli. My father was a master by the time he was my age, even before I died. I'll never surpass him." },
				{ Cue = "/VO/MelinoeField_2155", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's not what I've said. Your work is your own, and it's good! Better than good. When are you finally going to step out from your father's shadow?" },
				{ Cue = "/VO/Icarus_0071",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "Funny question coming from you! My father may not be a god... but he's probably the greatest artist and inventor that ever lived. He'd be the first to say I'll never reach his level. Anyway, I'm through trying to prove myself to him." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutDaedalus04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutDaedalus03" },
					},
				},
				{ Cue = "/VO/MelinoeField_3098", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "How is it that you know so much about all the Nocturnal Arms, to have devised so many custom Hammer tune-ups you've conveniently left for me? The Arms of Night are a closely guarded secret with little room for improvement." },
				{ Cue = "/VO/Icarus_0160",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "My father worked for yours, remember? Came up with the interlocking chambers of the Underworld and so on? He must have earned a lot of trust... and learned a lot of secrets." },
				{ Cue = "/VO/MelinoeField_3099", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And then he shared those secrets with his apprentice who supposedly can never live up to his lofty expectations?" },
				{ Cue = "/VO/Icarus_0161",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "If you're insinuating that I likewise earned my father's trust... fear not! When it comes to the Nocturnal Arms, I {#Emph}may {#Prev}have snooped around his notes and blueprints just a bit..." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutDaedalus05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutDaedalus04" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "I_Story01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4042", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "MelTalkExplaining01", WaitTime = 1, UsePlayerSource = true },
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I only met my father rather recently in all of this... I thought Headmistress could be stern, but so is he. No big surprise considering the tales, but still. Perhaps your father took some inspiration from him." },

				{ Cue = "/VO/Icarus_0456",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "I almost envy you, not having known your father for too long. Once I was working with a Hammer of my father's, broke it like a dolt, called it a failed experiment. {#Emph}No, you're the failed experiment{#Prev}, he said. He was always so calm." },

				{ Cue = "/VO/MelinoeField_4043", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Icarus, that's horrid. And he clearly couldn't have meant it. You're his apprentice! Your work bears the Daedalus name." },

				{ Cue = "/VO/Icarus_0457",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "I think my father loves me, in his way, he's just better with inventions than words. I'm sure yours is different. {#Emph}The god of the dead! {#Prev}He must be tough, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutOdysseus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift01" },
					},
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "TextLinesRecord" },
								CountOf =
								{
									"IcarusAboutMelinoe01",
									"IcarusAboutFlying01",
									"IcarusAboutFlying01_B",
									"IcarusAboutFlying02",
									"IcarusAboutReturning02",
									"IcarusAboutSurfaceCurse01",
								},
								Comparison = ">=",
								Value = 2,
							},
						},
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "IcarusGift04" },
							},
						},
					},
				},

				{ Cue = "/VO/Icarus_0074",
					Text = "How's everybody back at the Crossroads lately, hey? Master Odysseus putting all his plans to action at long last?" },
				{ Cue = "/VO/MelinoeField_2157", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, yes. My route through here is thanks only to him. Say, he didn't put you up to this, did he? Deploying Shades with makeshift wings and explosives seems like something the Great Tactician would do..." },
				{ Cue = "/VO/Icarus_0075",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I'm acting on my own. Although maybe we're all part of the Great Tactician's plan and just don't realize it yet. He always said we'll have to improvise... might be I finally took it to heart." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutCrossroads01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutOdysseus01" }
					},
				},

				{ Cue = "/VO/MelinoeField_3634", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Icarus, I want you to come back. To the Crossroads. You want to aid our efforts here, you'll do an even better job of it if you're in contact with Odysseus and all our Shades." },

				{ Cue = "/VO/Icarus_0390",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "Not sure that everybody feels the same, Meli. I've been able to make do here on my own, and don't do well in crowds. Maybe from living in a prison tower all my life." },

				{ Cue = "/VO/MelinoeField_3635", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But we could see each other more? And it's really not that crowded there, is it? Just give the possibility some thought..." },

				{ Cue = "/VO/Icarus_0391",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "All right, all right, I will. Give it some thought, that is. But if I show up and the Witch of the Crossroads turns me into the Shade of a newt or something, it'll be on your conscience." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutCrossroads02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutCrossroads01" }
					},
				},

				{ Cue = "/VO/MelinoeField_3636", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I was so pleased to see that you decided to come back! How was it at the Crossroads after all this time?" },

				{ Cue = "/VO/Icarus_0392",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "A bit uncomfortable at first, but then you showed up. And it was great to see Master Odysseus again, gave me a few flight path ideas. I didn't overstay did I...?" },

				{ Cue = "/VO/MelinoeField_3637", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",					
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, not at all! Well, if you didn't mind it there, then I hope you'll return. And perhaps start to think of it again as a place to stay, not just a place to go." },

				{ Cue = "/VO/Icarus_0393",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "It's called the Crossroads, Meli, I never considered it could be a place to stay! Hey... cheers for giving me a push." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutCirce01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceEnlargeTrait" },
					},
				},

				{ Cue = "/VO/Icarus_0154",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					Text = "{#Emph}Oh{#Prev}, you've {#Emph}erm, uh... {#Prev}grown! A bit... I mean... I'm not imagining it, am I, hey? Since normally I don't quite have to crane my neck this much to look at you." },
				{ Cue = "/VO/MelinoeField_3095", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Just a bit of magick, courtesy of Circe the Enchantress. A temporary boost of strength, though with what seems to be a noticeable side effect..." },
				{ Cue = "/VO/Icarus_0155",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "It's not a bad thing, I just couldn't help but notice...! And now I'm staring... and now, I'm going to stop. Here you go." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutCirce02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceShrinkTrait" },
					},
				},

				{ Cue = "/VO/Icarus_0156",
					PostLineAnim = "Icarus_Flustered_End",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					Text = "What happened to you, Meli, you're so {#Emph}small! {#Prev}Not that you're usually {#Emph}big{#Prev}, I mean, I mean... you've always been just right, but normally you're... just forget I spoke?" },
				{ Cue = "/VO/MelinoeField_3096", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's all right, Icarus. You must be noticing the work of Circe the Enchantress, who provided one of her protective blessings for the night. Is the effect really that noticeable?" },
				{ Cue = "/VO/Icarus_0157",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "{#Emph}No! {#Prev}No, it really isn't! {#Emph}Erm{#Prev}, I just... tend to notice the little things, I mean I notice details — of all sizes! Anyway, I like it. Not that that matters. Here! Let me get you on your way." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
				},

				{ Cue = "/VO/Icarus_0068",
					Text = "The other night, I saw these huge black wings on the horizon; definitely {#Emph}not {#Prev}a Harpy. Could have sworn it was bloody Eris... but, wasn't she still at the Crossroads, with you?" },
				{ Cue = "/VO/MelinoeField_2153", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, I'm not at the Crossroads either, but... unfortunately Strife Incarnate has been getting in my way. So she showed up around the time I did?" },
				{ Cue = "/VO/Icarus_0069",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Come to think of it, yes! {#Emph}Ah! {#Prev}I was beginning to worry she was here because of something {#Emph}I {#Prev}did! Never occurred to me she was just following {#Emph}you {#Prev}around, same as ever." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutEris02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusWithEris01" }
					},
				},

				{ Cue = "/VO/MelinoeField_4031", UsePlayerSource = true,
					Text = "You shouldn't let Eris boss you around, you know. I overheard you chatting at the Crossroads. She's all talk... especially {#Emph}there{#Prev}, where her Rail of Adamant won't work." },

				{ Cue = "/VO/Icarus_0395",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Easy for you to say, you're immortal like she is. We Shades know better than to stand up to the deathless gods." },

				{ Cue = "/VO/MelinoeField_4032", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You don't shrivel up in {#Emph}my {#Prev}presence. You're not a coward, Icarus. So why let Strife get the better of you?" },

				{ Cue = "/VO/Icarus_0396",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I figure there's already enough conflict at the moment. Eris doesn't really get to me. I just don't mind letting her think she does. Not like she's the goddess of wisdom, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
					},
				},

				{ Cue = "/VO/Icarus_0146",
					Text = "I saw huge plumes of fire shooting from the summit of Olympus recently. Thought the whole mountain was erupting! But on closer inspection, it was you! Fighting someone. And then some deranged eagle chased me off." },

				{ Cue = "/VO/MelinoeField_3091", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That was Prometheus the Titan and his pet. He's turned against the gods, and is personally leading the siege of Olympus. Claims to know the future, and to fight for mortalkind... using the flames he stole from my family." },

				{ Cue = "/VO/Icarus_0147",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I didn't realize he'd broken free. What do mortals have to do with this whole feud with Chronos, anyhow? I thought all he wanted was his vengeance! Probably Prometheus as well..." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutPrometheus01" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
				},

				{ Cue = "/VO/Icarus_0150",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Icarus_Explaining_Start", WaitTime = 0.2, AngleNPCToHero = true, },
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Sorry I'm late! Had a run-in with an eagle on the way. Maybe if I had a liver still I could offer it a bite and we'd become fast friends... worked for Prometheus apparently." },
				{ Cue = "/VO/MelinoeField_3093", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Beloved by birds as well as mortals. Though you don't seem to have much fondness for Prometheus yourself. Perhaps his affection for mortals isn't always reciprocated." },
				{ Cue = "/VO/Icarus_0151",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "Well, I mean... we've never met! When I was whole, we worshiped gods, not Titans. And Prometheus angered the gods, so... look, if you don't like him, that's enough for me." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutPrometheus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusHomeFirstMeeting" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "IcarusAboutPrometheus01", "TrueEndingFinale01" },
					},
				},

				{ Cue = "/VO/Icarus_0401",
					Text = "Some Shades back at the Crossroads, they were going on about Prometheus lately. Some of them seem to like him, more than Chronos anyway. Must be real charming, hey?" },
				{ Cue = "/VO/MelinoeField_4048", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I wouldn't say that, but he's very caught up in his cause. To let himself be tortured for the sake of mortalkind... full knowing that most mortals would never realize or care." },
				{ Cue = "/VO/Icarus_0402",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Sounds a bit like a sob story to me. If he knew everything how come he let himself get caught? The gods probably would have given mortals fire anyway!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutHeracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatO", "HeraclesCombatO2" },
					},
					{
						SumPrevRuns = 2,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = {
							"HeraclesCombatIntro", "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
						Comparison = ">=",
						Value = 1,
					},
				},

				{ Cue = "/VO/Icarus_0403",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Icarus_Explaining_Start", WaitTime = 0.2, AngleNPCToHero = true, },
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I could have sworn I saw the hero Heracles the other night...! Launching himself from one ship to the next, crushing deathless sailors with his club! I flew well clear of {#Emph}him." },

				{ Cue = "/VO/MelinoeField_4035", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You probably saw true. Olympus has him fighting back the Titan's legions and his fleet. We've worked together on occasion but he's kept me at arm's length..." },

				{ Cue = "/VO/Icarus_0404",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "You worked with {#Emph}Heracles? Oh{#Prev}, if only I could meet him for myself sometime...! But I don't even know what I would say. {#Emph}Hey! I'm like everybody else who thinks you're great!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutHeracles02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraclesFieldAboutIcarus01" },
					},
				},

				{ Cue = "/VO/MelinoeField_4036", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I had a passing chance to mention you to Heracles. Unfortunately he's not keen on meeting anyone unless he's out to kill them for the gods, but... he seemed to know of you." },

				{ Cue = "/VO/Icarus_0405",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "{#Emph}What? {#Prev}How could he possibly...? {#Emph}He's {#Prev}the famous one! You sure he didn't mention Daedalus instead of me?" },

				{ Cue = "/VO/MelinoeField_4037", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He mentioned Daedalus, too, because... apparently he saw your final moments when you fell. I think, from what he said... he dove into the sea to find your body. To bury you." },

				{ Cue = "/VO/Icarus_0406",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "To {#Emph}bury {#Prev}me, but I... always wondered how I got here, as my memory is murky then. But I was buried by great Heracles himself! {#Emph}Incredible! {#Prev}Tell him I, I said {#Emph}cheers{#Prev}, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutHeracles03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraclesFieldAboutIcarus02" },
					},
				},

				{ Cue = "/VO/Icarus_0407",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Icarus_Explaining_Start", WaitTime = 0.2, AngleNPCToHero = true, },
					PostLineAnim = "Icarus_Explaining_End",
					Text = "So how is the mighty Heracles lately? I'm half surprised the legions of the Titan got as far as they did knowing he's out there fighting for the gods." },

				{ Cue = "/VO/MelinoeField_4038", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}How is Heracles{#Prev}, that's difficult for me to say. I've never seen so fierce a warrior, but he's very guarded, too. When I told him you said cheers, he grunted; that was it." },

				{ Cue = "/VO/Icarus_0408",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "He grunted... about {#Emph}me. {#Prev}And he knows who I am! {#Emph}Ah{#Prev}, thank you, Meli, that's amazing news! I'm sure all he needs is a little rest, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},

				{ Cue = "/VO/Icarus_0139",
					Text = "There's some catastrophic storm brewing at the top of Olympus. Can't get anywhere near it. What's happening up there...?" },
				{ Cue = "/VO/MelinoeField_3087", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					Text = "That storm conceals the real threat. Chronos awakened the Father of All Monsters and set him loose. These forces we're fighting... they're just a stalling tactic and a feint." },
				{ Cue = "/VO/Icarus_0140",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "You're saying that's bloody {#Emph}Typhon? {#Prev}Oh, gods... since I was young I'd pray to all of you for safety and good fortune from my tower. Now it's you yourselves who'd better pray..." },
				{ Cue = "/VO/MelinoeField_3088", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "No; we're going to {#Emph}destroy {#Prev}that thing. I don't yet know all that requires, though prayer most likely won't be necessary." },
				{ Cue = "/VO/Icarus_0141",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Well then I'll pray just in case! Figure it couldn't hurt. Just please be careful, Meli. And before you go... take one of these." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutTyphon02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "TyphonHead" },
						Comparison = "<=",
						Value = 0,
					},
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutTyphon01" },
					},
				},

				{ Cue = "/VO/Icarus_0142",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Icarus_Explaining_Start", WaitTime = 0.2, AngleNPCToHero = true, },
					PostLineAnim = "Icarus_Explaining_End",
					Text = "You really went and took on Typhon, hey? I caught a glimpse of him! As close as I dared fly to that huge storm. He could have squished you like a bug! Although I guess bugs can't use magick to escape..." },
				{ Cue = "/VO/MelinoeField_3089", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And bugs have wings, kind of like you! But yes, I can attest to Typhon's size and strength. Fortunately, I'm quicker... and have every god and goddess on Olympus backing me." },
				{ Cue = "/VO/Icarus_0143",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "But their might {#Emph}pales {#Prev}in comparison to my inventions here...! {#Emph}Erm{#Prev}, I, I, I shouldn't even jest... like that. You don't suppose they heard...? Don't tell them I said anything." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutTyphon03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "Q_Boss01", "Q_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusAboutTyphon01" },
					},
				},

				{ Cue = "/VO/Icarus_0144",
					Text = "The other night I thought I saw you launch yourself toward the Olympus summit... right into that awful storm. I couldn't even get close! What was it like up there?" },
				{ Cue = "/VO/MelinoeField_3090", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh it was awful... I normally like rain, but not like that. Typhon is drawn to the Fortress of the Gods, as it's the last defense before the Palace of Zeus... likely his real goal." },
				{ Cue = "/VO/Icarus_0145",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "So the gods keep knocking him down, but he keeps getting back up, trying over and over to accomplish the same thing? A {#Emph}battle of wills! {#Prev}A battle of wits would have been easier, I guess." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Icarus_0064",
					Text = "Something happened since the last time you were here... these ships, one after another they all {#Emph}sank! {#Prev}Never seen these waters so calm. {#Emph}Did you...?" },
				{ Cue = "/VO/MelinoeField_2151", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Did I reach Chronos in my father's House and slay him? Yes. And, did he then reconstitute himself, perhaps entirely negating whatever I achieved? Also, yes." },
				{ Cue = "/VO/Icarus_0065",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I always knew you'd get him, Meli. Well as you can see, his risen fleet has risen once again! Though, sounds to me like you've found one of its weaknesses!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutCharybdis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "O_MiniBoss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift09" },
					},
				},

				{ Cue = "/VO/Icarus_0399",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Icarus_Explaining_Start", WaitTime = 0.2, AngleNPCToHero = true, },
					PostLineAnim = "Icarus_Explaining_End",
					Text = "You must have seen Charybdis out there, massive whirlpool-nightmare-octopus-type thing? I've seen it swallow ships like {#Emph}this. {#Prev}I don't fly anywhere close!" },

				{ Cue = "/VO/MelinoeField_4034", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 5 },

					Text = "I'm not so fortunate to have that option, and some nights, I've little choice but to confront Charybdis face-to... probably a face? Could use your aid if you decide to take the risk." },

				{ Cue = "/VO/Icarus_0400",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "Oh, {#Emph}absolutely {#Prev}not. I said I'd follow you into the sun, Meli, but Charybdis, no. My fear of flying was one thing, my fear of octopuses is another." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutFrogFamiliar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
				},

				{ Cue = "/VO/Icarus_0158",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					Text = "Is that...? {#Emph}No. {#Prev}That's really Frinos with you, isn't it? All he used to do was sit there happily! Or sadly, I could never tell. And now he's in the middle of all this..." },
				{ Cue = "/VO/MelinoeField_3097", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is indeed the one and only! I never knew he had it in him either, till Headmistress let me in on more of her secrets to working with Familiars." },
				{ Cue = "/VO/Icarus_0159",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I always thought Familiars were just pets! Well, Frinos? It's good to see you again, mate. {#Emph}Keep Meli safe, will you...?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutRavenFamiliar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "RavenFamiliar" },
					},
				},

				{ Cue = "/VO/Icarus_0413",
					Text = "Going to introduce me to your other winged companion over there? Looks like a raven though I've never seen one {#Emph}quite {#Prev}like that before..." },
				{ Cue = "/VO/MelinoeField_4041", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh, right, pardon my rudeness both of you! Icarus, this is Raki, my Familiar. Raki, this is Icarus, my friend! You two are birds of a feather." },
				{ Cue = "/VO/Icarus_0414",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Well! Pleased to meet you, then, Raki. Know that I'll be studying your flight technique, since I'm always finding mine can still improve." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},


			-- other reactions
			IcarusLowHealth01 =
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
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.33, },
					},
				},

				{ Cue = "/VO/Icarus_0152",
					Emote = "PortraitEmoteFiredUp",					
					Text = "Look what they did to you, those... {#Emph}augh! {#Prev}I'm sorry I didn't get here sooner, Meli.... Do you ever just turn back? I mean if you're {#Emph}this {#Prev}hurt already, why go on...." },
				{ Cue = "/VO/MelinoeField_3094", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm not as hurt as you may think, and know my limits, Icarus. Though I appreciate the show of concern." },
				{ Cue = "/VO/Icarus_0153",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "I just — It's hard to see you put yourself through this. Even if your wounds heal by tomorrow, what matters is right now. Anyway... I might have something to help keep you going." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutHammers01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift03" },
					},
					{
						Path = { "GameState", "TraitsTaken" },
						CountOf =
						{
							"FocusAttackDamageTrait",
							"FocusSpecialDamageTrait",
							"BreakInvincibleArmorBoon",
							"BreakExplosiveArmorBoon",
							"OmegaExplodeBoon",
							"SupplyDropBoon",
							"CastHazardBoon",
						},
						Comparison = ">=",
						Value = 5,
					},
				},

				{ Cue = "/VO/Icarus_0409",
					Text = "You should see how many inventions of mine don't work out even the slightest bit. I know some are better than others, but {#Emph}these {#Prev}are the best of the best. You have my guarantee." },

				{ Cue = "/VO/MelinoeField_4039", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Hesitant_01", WaitTime = 3.9 },

					Text = "I suppose it must be helpful to have someone such as me willing to test them out for you. No way of knowing if they're any good until they're put to real use, presumably?" },

				{ Cue = "/VO/Icarus_0410",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "{#Emph}<Scoff> {#Prev}You're not testing them, Meli! My Hammers all go through {#Emph}extremely {#Prev}rigorous evaluation to earn the Daedalus name. But if you have any notes, let me know." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusGrantsReward01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "UpgradableHammerCount" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift03" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},

				{ Cue = "/VO/Icarus_0411",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Icarus_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Been working on something for quite a while here, and didn't want to say till it was ready, but I put it through more testing recently and think it's good to go." },

				{ Cue = "/VO/MelinoeField_4040", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "Oh that's exciting. Your inventions must take quite a while to make ready and produce. What's this one all about?" },

				{ Cue = "/VO/Icarus_0412",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "You'll see, but it makes just about everything better, kind of like, well, {#Emph}you. {#Prev}Don't have to try it if you don't want!" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutHiddenAspects01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = GameData.AllHiddenAspects,
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						CountOf = GameData.AllHiddenAspects,
						Comparison = ">=",
						Value = 2,
					},
				},

				{ Cue = "/VO/Icarus_0415",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Icarus_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I knew the Nocturnal Arms could take on many different forms, but to see them like {#Emph}this... {#Prev}you must have done something to earn their favor, hey?" },

				{ Cue = "/VO/MelinoeField_4030", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",

					Text = "I suppose? Either that or the Arms just want me to keep using them for now, in one Aspect or another. Say, how can your Hammers still work even if the Arms change shape?" },

				{ Cue = "/VO/Icarus_0416",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I make sure of it, that's why! And seeing different Aspects put to use always gives me plenty of ideas." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},

				{ Cue = "/VO/Icarus_0148",
					Text = "Fancy meeting you up here! I used to never fly anywhere near this place but noticed somewhat fewer Harpies and Automaton defenses... and, well, {#Emph}you. {#Prev}Going all right so far?" },
				{ Cue = "/VO/MelinoeField_3092", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Going better than before now thanks to you. So what do you think? Does the mountain of the gods live up to everything you imagined?" },
				{ Cue = "/VO/Icarus_0149",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Mostly, yes... considering mortals living or otherwise were never meant to see Olympus in all its glory. I'd rather see you anyway, Meli. Here, something for the rest of your climb." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutOlympus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/Icarus_0434",
					Text = "Not been as stormy on this mountain anymore, but is your family {#Emph}really {#Prev}going to tolerate all these Satyrs and things continuing to desecrate their home? Seems unlike them..." },
				{ Cue = "/VO/MelinoeField_4054", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They're leading me to Typhon, Icarus... some scattered remnant of him beyond time. We're working with Grandfather on a cleanup effort, you could say." },
				{ Cue = "/VO/Icarus_0435",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "{#Emph}Grandfather{#Prev}, y-you mean bloody {#Emph}Chronos? {#Prev}And, you're saying Typhon still {#Emph}exists? {#Prev}What happened to him being gone, I mean, I've seen no sign of him. This must be one of those things that's beyond mortal understanding, hey?" },
				{ Cue = "/VO/MelinoeField_4055", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "I don't yet entirely understand it either... there's a lot we don't know about time and how it works, though we're learning, slowly." },
				{ Cue = "/VO/Icarus_0436",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Don't see what's so complicated about it. Time drags on when things are bad, goes too quick when things are good. Though I'm still learning how to deal with that myself." },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},


			IcarusAboutBecomingCloser01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "IcarusBecomingCloser01" },
						IsAny = { "Choice_IcarusAccept" },
					},
				},

				{ Cue = "/VO/MelinoeField_4044", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So did you get a chance to feel the wind and sea using the Ectoplasmic Draught? I wasn't sure how long it was going to last, and wanted you to make the most of it." },

				{ Cue = "/VO/Icarus_0385",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "That was the greatest night of my existence, by a lot. Feeling the wind and sea was the perfect end to it! At first I thought the cold was making me numb, but it was just the Draught wearing off." },

				{ Cue = "/VO/MelinoeField_4045", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That night was special for me, too. Apparently my grandmother Demeter was with a mortal once... and had my mother after that, who then had me! So I'm not a true goddess, and always had an interest in my mortal roots." },

				{ Cue = "/VO/Icarus_0386",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "You are a true goddess, Meli. If you've a bit of mortal blood, so much the better. Anyway, that was an amazing time... but now that it's over, at least I have the memory!" },

				{ Cue = "/VO/MelinoeField_4046", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We could make more sometime, perhaps. Memories that is. Because considering the Ectoplasmic Draught worked like it did... I may look into replicating it." },

				{ Cue = "/VO/Icarus_0387",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "{#Emph}<Gasp> {#Prev}Well if my heart were beating still it likely would have burst! I'd give anything to be with you again... but unlike last time, I'll be patient about it. I swear." },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusAboutBecomingCloser01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "IcarusBecomingCloser01" },
						IsAny = { "Choice_IcarusDecline" },
					},
				},

				{ Cue = "/VO/MelinoeField_4044", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "So did you get a chance to feel the wind and sea using the Ectoplasmic Draught? I wasn't sure how long it was going to last, and wanted you to make the most of it." },

				{ Cue = "/VO/Icarus_0388",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "That was the greatest night of my existence. It was so wonderful to feel alive with you, and then the wind and the sea! At first I thought the cold was making me numb, but it was just the Draught wearing off." },

				{ Cue = "/VO/MelinoeField_4047", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm glad. I was concerned I may have hurt you once again. What we have... may not be everything you want. But it means a lot to me, and it's all I can give." },

				{ Cue = "/VO/Icarus_0389",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "It means a lot to me, too. And you've given me more than I ever could have dreamed... so how about a nice Hammer as a means of making it up to you, hey?" },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			-- alt below
			IcarusPostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusPostTrueEnding01_B" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},

				{ Cue = "/VO/Icarus_0417",
					Text = "Where have you {#Emph}been{#Prev}, Meli? Not seen you here or {#Emph}anywhere {#Prev}in far too many nights. Something's off, I don't know what but I think Chronos might be up to something new. His forces have been acting {#Emph}very {#Prev}strange...!" },

				{ Cue = "/VO/MelinoeField_4049", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "His forces have been acting very strange because Chronos {#Emph}abandoned his campaign! {#Prev}Icarus... our war is won! The House of Hades is restored! You'd not believe me if I told you how, but it's {#Emph}true!" },

				{ Cue = "/VO/Icarus_0418",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Chronos has given up, wait, {#Emph}what...? No! {#Prev}But we just fought more of his forces {#Emph}here! {#Prev}You're really serious..." },

				{ Cue = "/VO/MelinoeField_4050", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "When am I not? The Titan of Time is {#Emph}changed. {#Prev}We were able to get through to him finally, in the moment when his continued existence was on the line. I'm off to Olympus now, to make certain things are stable over there." },

				{ Cue = "/VO/Icarus_0419",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "I just, I can't {#Emph}believe {#Prev}it! Well, I mean, of course I can. {#Emph}Heh! {#Prev}You got him, {#Emph}finally! {#Prev}You did get him, didn't you? I, {#Emph}erm{#Prev}, I don't know what to say... have one of these?" },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusPostTrueEnding01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusPostTrueEnding01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},

				{ Cue = "/VO/Icarus_0417",
					Text = "Where have you {#Emph}been{#Prev}, Meli? Not seen you here or {#Emph}anywhere {#Prev}in far too many nights. Something's off, I don't know what but I think Chronos might be up to something new. His forces have been acting {#Emph}very {#Prev}strange...!" },

				{ Cue = "/VO/MelinoeField_4049", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "His forces have been acting very strange because Chronos {#Emph}abandoned his campaign! {#Prev}Icarus... our war is won! The House of Hades is restored! You'd not believe me if I told you how, but it's {#Emph}true!" },

				{ Cue = "/VO/Icarus_0418",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Chronos has given up, wait, {#Emph}what...? No! {#Prev}But we just fought more of his forces {#Emph}here! {#Prev}You're really serious..." },

				{ Cue = "/VO/MelinoeField_4050_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "When am I not? The Titan of Time is {#Emph}changed. {#Prev}We were able to get through to him finally, in the moment when his continued existence was on the line." },

				{ Cue = "/VO/Icarus_0419",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "I just, I can't {#Emph}believe {#Prev}it! Well, I mean, of course I can. {#Emph}Heh! {#Prev}You got him, {#Emph}finally! {#Prev}You did get him, didn't you? I, {#Emph}erm{#Prev}, I don't know what to say... have one of these?" },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusPostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomePostTrueEnding01" },
					},
				},

				{ Cue = "/VO/Icarus_0437",
					Text = "Hey, last we spoke in the Crossroads, I... didn't mean to upset you, Meli. It's just... I didn't realize you'd have to keep fighting like this." },

				{ Cue = "/VO/MelinoeField_4056", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You asked me what I was going to do with the rest of my existence, and it set me off. I've not thought that far ahead." },

				{ Cue = "/VO/Icarus_0438",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Well, it seems you don't need an answer anyway if you still have to keep heading up here. And probably down to the Underworld as well." },

				{ Cue = "/VO/MelinoeField_4057", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "There's certainly a comfort in routine. But, I have to accept that this may be all I'm meant to do. All I'm proficient at." },

				{ Cue = "/VO/Icarus_0439",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "You don't have to accept {#Emph}any {#Prev}such thing, Meli. All my father ever did was work. Felt it was his calling! But you're not like him. Anyway... the rest of existence can wait! Let's make {#Emph}this {#Prev}night a good one and go from there, hey?" },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutFlying04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},

				{ Cue = "/VO/MelinoeField_4051", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I meant to tell you, Icarus, I finally got to fly! With great Selene and her moonlit steeds. I certainly see the appeal, and I didn't even get to steer the chariot." },

				{ Cue = "/VO/Icarus_0430",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Wait you were all the way up {#Emph}there? {#Prev}That's {#Emph}amazing! {#Prev}The Moon herself, giving you a ride across the sky. I've thought maybe if {#Emph}I {#Prev}could just fly a bit higher, I could reach her myself, but, {#Emph}erm... {#Prev}I talked myself down." },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusPostTrueEnding03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},

				{ Cue = "/VO/Icarus_0431",
					Text = "There really is more to be done then, hey? If the war with Chronos truly ended, it sure doesn't look that way from all these ships. The Harpies don't seem any friendlier, either." },

				{ Cue = "/VO/MelinoeField_4052", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Some must be zealots still believing that the Titan of Time shall rise again. But we're seeing to it that the threat of Chronos and Typhon can never recur. Just have to retrace my steps to Olympus as part of that process." },

				{ Cue = "/VO/Icarus_0432",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "So then... all right. Because if what you're saying is I get to keep on flying, and I get to keep on seeing {#Emph}you {#Prev}up {#Emph}here... {#Prev}that doesn't sound so bad to me." },

				{ Cue = "/VO/MelinoeField_4053", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, right! We thought the war ending would mean you'd have to put away your wings. But, my father's Underworld renovations seem like they'll be going on a long, long time." },

				{ Cue = "/VO/Icarus_0433",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "Guess I may need to head back to my designated spot eventually. But for now, I'd like to make the most of this." },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutUnderworld01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutOlympus02" },
					},
					-- Surface run on PrevRun, the run before that, and the run before that; CurrentRun is ignored (would return false)
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "BiomesReached", "F" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
				},

				{ Cue = "/VO/Icarus_0440",
					Text = "Not seen you out here in a bit! Been busy in the Underworld, or relaxing in the hot springs with a bottle of Ambrosia or two?" },

				{ Cue = "/VO/MelinoeField_4059", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I won't confess so easily. Though I suppose you're right, it has been a while since we saw each other here. Anything new to report?" },

				{ Cue = "/VO/Icarus_0441",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I'd report I'm pleased to see you though that's nothing new, I guess. Your grandfather is also {#Emph}very good {#Prev}at reviving his slain followers, if that's part of your plan. It's been packed!" },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			IcarusAboutSayingLittle01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusBecomingCloser01" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},

				{ Cue = "/VO/Icarus_0481",
					Text = "I like this routine we've got going here, Meli! I feel like I could keep doing this forever. We've become ruthlessly efficient... don't even need to chitchat anymore." },

				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},

			-- Repeatable
			IcarusChat01 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0005",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Was just out for a little jaunt is all and figured I'd stop in. Was good seeing you, Meli." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat02 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				{ Cue = "/VO/Icarus_0006",
					Text = "Rough waters this evening, though the skies above aren't bad. You take care of yourself, hey?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat03 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusAboutEris01" }
					},
				},
				{ Cue = "/VO/Icarus_0007",
					Text = "Think I saw Eris further up the coast. How about you bring her a little surprise?" },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat04 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0008",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "What I wouldn't give to stay here longer and catch up, but I know it's not the time or place." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat05 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0009",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "You were amazing, Meli. I saw everything up there! Keep going, hey?" },
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
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
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
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "The coast is clear for now! Though, past this point, no guarantees." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat11 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0015",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Think I took care of one or two of them back there. Better than nothing, hey?" },
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
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
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
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<", Value = 0.66, },
					},
				},
				{ Cue = "/VO/Icarus_0020",
					Text = "Still perfectly all right...! Had me a little worried for a moment there." },
				PrePortraitExitFunctionName = "IcarusBenefitChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.IcarusBenefitChoices,
			},
			IcarusChat17 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Icarus_0021",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
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
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
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
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
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
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
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
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
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
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
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
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
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
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You can fly wherever you want now! But, I'm glad you didn't go so far I couldn't catch up. Here! In light of your godlike wings, a little gift." },
				{ Cue = "/VO/Icarus_0038",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "Oh come on, just because I've been flying around near Olympus, doesn't mean I get to feast like I'm from there! Maybe with your permission, hey? Know what, I got something for you, too." },
			},
			IcarusGift02 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Icarus_01" },
					},
				},
				{ Cue = "/VO/Icarus_0039",
					Portrait = "Portrait_Icarus_Pleased_01",
					Text = "The last Nectar you got me was {#Emph}so {#Prev}good, can't even imagine what it would have been like while I was still alive. Wasn't going to ask for another, but... since you're offering!" },
				{ Cue = "/VO/Melinoe_3266", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
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
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Icarus_Default_01", WaitTime = 4.3 },
					Text = "As a mortal kid confined to a tower, I was relatively well provided for, but {#Emph}this? {#Prev}I know better than to envy the gods, especially with what they're going through lately... but they definitely know their drink." },
				{ Cue = "/VO/Melinoe_3499", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The gods have always lived well... but your own life was so short and difficult. You must still have a lot of making up to do, and I thought maybe this could help!" },
			},

			IcarusGift04 =
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
				{ Cue = "/VO/Icarus_0176",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Way back when, I always wanted to find you the best bottle of Nectar I could... but I never did. Adding to the list of things I perhaps should have approached differently." },
				{ Cue = "/VO/Melinoe_3500", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please don't dwell on the past so much. You thought you'd never see me again, but I'm here, now. I appreciate this moment that we have." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Icarus_01",
						{ Cue = "/VO/Icarus_0080", Text = "I won't forget it." },
					}
				},
			},

			IcarusGift05 =
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
				{ Cue = "/VO/Icarus_0177",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Can hardly feel this bottle... just its weight. Though I still have fond memories to fill the gaps. It's funny, I've lost track of how long I've been dead, but still not used to it entirely." },
				{ Cue = "/VO/Melinoe_4529", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Perhaps it's impossible to become entirely accustomed to the way we are. Though, I'm surprised you have any nostalgia for a time when you were young." },
				{ Cue = "/VO/Icarus_0178",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "{#Emph}You're {#Prev}one to talk! How many times have you reminisced about your quiet evenings listening to the river and the frogs? Sometimes we forget the pain, and sometimes it's all we remember. Though I'll remember this too." },
			},

			IcarusGift06 =
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
				{ Cue = "/VO/Icarus_0179",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "I was so reckless when I was a kid. My father always told me to be careful, but I was stuck in a bloody tower... couldn't do anything to hurt myself if I tried. But now... I just don't want to mess things up." },
				{ Cue = "/VO/Melinoe_4530", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "For someone who spends so much time up in the clouds, you're far too stuck in your own head at times. This isn't a test, Icarus. It's me. And I simply like it when you're you." },
				{ Cue = "/VO/Icarus_0180",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "Come on, Meli, look at us...! You're the immortal Princess of the Underworld; I'm a Shade of a failed apprentice who couldn't follow one simple instruction from his father and got dead ahead of schedule. {#Emph}This {#Prev}is what you like?" },
				{ Cue = "/VO/Melinoe_4531", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, because that isn't who you are. I have no pity for you; why do you have so much for yourself? Cast it aside. But your true feelings, you should never hide from me." },
				{ Cue = "/VO/Icarus_0181",
					PreLineWait = 0.35,
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I'll try... I'll definitely try, I'd be a fool not to. So, then...! Onward toward whatever comes our way?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4532", Text = "Though still appreciate the moment, yes." },
					},
				},
			},

			IcarusGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- HintId = "Codex_NemesisGiftHint01",
				PostBlockSpecialInteract = true,
				LockedHintId = "Codex_IcarusUnlockHint01",
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
						HasAll = { "IcarusBathHouse02", "IcarusTaverna01", "IcarusFishing01", "IcarusGift06" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "IcarusAboutFlying02", "IcarusAboutFlying02_B" },
					},
					NamedRequirements = { "IcarusUnlockedInHub" },
				},

				{ Cue = "/VO/Melinoe_4558", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You seemed to enjoy your first taste of Ambrosia, so I want you to have a bottle for yourself. For when the occasion warrants it." },

				{ Cue = "/VO/Icarus_0246",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "A bottle for myself, when the occasion warrants it... {#Emph}wow, what? {#Prev}Oh, come on, Meli, this is really too much! I've nothing {#Emph}near {#Prev}this good to give {#Emph}you!" },

				{ Cue = "/VO/Melinoe_4559", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I beg to differ! You have given me {#Emph}much {#Prev}more. And I don't just mean the hammers you've been busy working on." },

				{ Cue = "/VO/Icarus_0247",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "I've not done anything that scores of Shade admirers of yours wouldn't have done in a heartbeat, if they still had one." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.33,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4560", Text = "Wait, you're a Shade admirer of mine?" },
					},
					{
						PreLineWait = 0.35,
						ObjectTypes = { "NPC_Icarus_01" },
						{ Cue = "/VO/Icarus_0248", Text = "Oh, stop. And, give me that." },
					}
				},
			},

			IcarusGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				StartBecomingCloserTrack = true,
				HintId = "Codex_GrowingCloser01",
				PostBlockSpecialInteract = true,
				-- LockedHintId = "Codex_ErisGiftHint01",
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
						HasAll = { "IcarusGift07" },
					},
				},

				{ Cue = "/VO/Melinoe_4561", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How about we try this whole Ambrosia thing again, but {#Emph}this {#Prev}time, no pretending you are just another Shade. You're more than that. And more than a friend." },

				{ Cue = "/VO/Icarus_0249",
					PreLineWait = 0.35,
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "...Fine, but... don't you think this wasn't meant to be, hey? When I try to touch you it's barely a breeze, like I'm not even here..." },

				{ Cue = "/VO/Melinoe_4562", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You {#Emph}are {#Prev}here. I don't want to get hurt again either but each night I set out like this, I can't accomplish what I need to do without inviting the possibility... even the inevitability. Sometimes it's worth it." },

				{ Cue = "/VO/Icarus_0250",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "My pain I can handle fine, who cares? {#Emph}Yours{#Prev}, I don't think I could live with... {#Emph}exist {#Prev}with, you know what I mean. But... {#Emph}argh! {#Prev}I can't believe I'm {#Emph}arguing {#Prev}with you, Meli, I'm happy more than {#Emph}anything {#Prev}right now! But I'm {#Emph}afraid..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4563", Text = "A fear we can face together." },
					},
				},
			},

			IcarusGift09 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_GrowingCloser01",
				PostBlockSpecialInteract = true,
				-- LockedHintId = "Codex_ErisGiftHint01",
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
						HasAll = { "IcarusGift08" },
					},
				},

				{ Cue = "/VO/Melinoe_4564", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "How about one more Ambrosia, as a bit of an experiment, because a substance known for bringing warmth and pleasure seems somehow to bring you misery." },

				{ Cue = "/VO/Icarus_0251",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Oh, excellent, I was just thinking I could use more misery and here we are. You do know why, don't you? We tried all this before, and it didn't work. I really wish it did, but hey." },

				{ Cue = "/VO/Melinoe_4565", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "I'm more experienced now. Sometimes when things don't work, you have to try again. Over, and over, and over, if that's what it takes." },

				{ Cue = "/VO/Icarus_0252",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "Meli, I agree with you... provided that the cost of trying isn't way too high! In your case, well... you've got another arm, there, sure. A couple legs. You're willing to put all those on the line, for me? To make me {#Emph}whole?" },

				{ Cue = "/VO/Melinoe_4566", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Look, I know I can't just permanently bring your body back. But this connection we have... that we've always had... I'm willing to go where it leads. I'd {#Emph}like {#Prev}to go, if you would too." },

				{ Cue = "/VO/Icarus_0253",
					PreLineWait = 0.28,
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I would, of course. I'd follow you into the sun, Meli. Or anywhere you'd rather be." },

				EndFunctionName = "DisplayInfoToast",
				EndFunctionArgs = { WaitTime = 1.3, Duration = 2, Title = "RecipeAdded", Text = "WorldUpgradeReviveIcarus" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4567", Text = "Then I have an idea." },
					},
				},
			},

			-- bond forged
			IcarusGift10 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				HintId = "Codex_GrowingCloser01",
				LockedHintId = "Codex_IcarusUnlockHint02",
				CompletedHintId = "Codex_BondForgedIcarus",
				UnfilledIcon = "EmptyHeartWithDraughtIcon",
				FilledIcon = "FilledHeartWithDraughtIcon",
				PostBlockSpecialInteract = true,
				Cost =
				{
					IcarusPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift09" },
					},
				},

				{ Cue = "/VO/Melinoe_4570", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Don't worry, this isn't more Ambrosia. It's called an Ectoplasmic Draught. Not as potent as the incantation I once tried, but this one works, I think." },

				{ Cue = "/VO/Icarus_0254",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "What are you saying, Meli, wait... this draught can make me {#Emph}whole? {#Prev}Or maybe partially, an arm or something, hey?" },

				{ Cue = "/VO/Melinoe_4571", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It may be able to restore your sense of self as though you lived and breathed. But the effect won't last particularly long, perhaps a night at best. That was the compromise." },

				{ Cue = "/VO/Icarus_0255",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "You're kidding, so... I could be {#Emph}me {#Prev}again... feel the cold wind and the spray of the sea and all that! For just one night. C-Can you make more?" },

				{ Cue = "/VO/Melinoe_4572", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Let's not get ahead of ourselves. These things can carry side effects if you don't take them slow. Swear that you will." },

				{ Cue = "/VO/Icarus_0256",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I swear I'll take it slow using the Ectoplasmic Draught. I've ignored perfectly reasonable guidance to my peril at least once before and I don't intend to do it again." },

				{ Cue = "/VO/Melinoe_4573", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Icarus_01", Icon = "Keepsake_Icarus" },

					Text = "Then please use this whenever you see fit, perhaps on some particularly special night. And treat it as one-of-a-kind." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectTypes = { "NPC_Icarus_01" },
						{ Cue = "/VO/Icarus_0257", Text = "Thank you... thank you so much..." },
					}
				},
			},

			IcarusBathHouse01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				HintId = "Codex_HotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift03" },
					},
					{
						Path = { "GameState", "UseRecord", "AphroditeUpgrade" },
						Comparison = ">=",
						Value = 5,
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					NamedRequirements = { "IcarusUnlockedInHub" },
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_4533", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "By the way have you seen what we did with the springs? Good place to shed any lingering pains if you want to go?" },

				{ Cue = "/VO/Icarus_0187",
					PortraitExitAnimation = "Portrait_Icarus_Default_01_Exit",
					PostLineRemoveContextArt = true,
					Text = "With you? Right now? All right! Though, don't expect the spring-water to be much good for my complexion, hey?" },

				{ Cue = "/VO/Icarus_0192",
					PreLineWait = 0.35,
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Icarus_Bath_01",
					PortraitExitAnimation = "Portrait_Icarus_Bath_01_Exit",
					Text = "...Funny how utterly beyond belief life is sometimes. While I was living I could never have imagined {#Emph}anything {#Prev}like this."
				},
				{ Cue = "/VO/Melinoe_4535", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					PreLineWait = 0.5,
					Text = "It's just a hot spring, Icarus. A purified and heavily enchanted one, but nonetheless. You've been flying over fleets of risen warships... how is this any stranger than that?" },

				{ Cue = "/VO/Icarus_0193",
					Portrait = "Portrait_Icarus_Bath_01",
					PortraitExitAnimation = "Portrait_Icarus_Bath_01_Exit",
					Text = "{#Emph}Heh. {#Prev}It's mostly that I'm here with you. You're so beautiful, Meli. Not that you need us Shades and mortals to know it! Aphrodite herself must have told you, hey?" },

				{ Cue = "/VO/Melinoe_4536", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Oh, stop, Aphrodite has been a steadfast ally. If she was envious of me, I doubt she'd be as forthcoming with all of her most potent blessings as she has been." },

				{ Cue = "/VO/Icarus_0194",
					Portrait = "Portrait_Icarus_Bath_01",
					PortraitExitAnimation = "Portrait_Icarus_Bath_01_Exit",
					Text = "That isn't really what I meant. We mortals... tend to have a certain shame. Our bodies can be so vulnerable, and ugly, sometimes... but not gods and goddesses." },

				{ Cue = "/VO/Melinoe_4537", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I don't see what's to be ashamed of. I've known Shades such as you, and Odysseus... you're close enough to gods!" },

				{ Cue = "/VO/Icarus_0195",

					Portrait = "Portrait_Icarus_Bath_01",
					PortraitExitAnimation = "Portrait_Icarus_Bath_01_Exit",

					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, GlobalVoiceLines = "HotSpringsBathVoiceLines" },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,

					Text = "{#Emph}Hah{#Prev}, well, that's kind of you to say. And you were right about my burdens and this place! I'm really glad we're here." },

				{ Cue = "/VO/Icarus_0196",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "...I only wish we could have stayed longer. Though that was great. Thank you for bringing me along." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4539", Text = "It was nice..." },
					},
				},
			},
			IcarusBathHouse02 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithSaltsIcon",
				FilledIcon = "FilledHeartWithSaltsIcon",
				UseableOffSource = true,
				GiftableOffSource = true,
				DoNotFlipContextArt = true,
				HintId = "Codex_HotSpringsGiftHint",
				LockedHintId = "Codex_LockedActivityHint",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift06", "IcarusBathHouse01", "IcarusAboutMelinoe01" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					NamedRequirements = { "IcarusUnlockedInHub" },
				},
				Cost =
				{
					GiftPointsRare = 1,
				},
				EndWait = 0.5,
				{ Cue = "/VO/Melinoe_4540", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I enjoyed our prior outing at the springs, and thought you might be open to another sometime soon. Perhaps even right now?" },

				{ Cue = "/VO/Icarus_0197",
					PostLineRemoveContextArt = true,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PortraitExitAnimation = "Portrait_Icarus_Pleased_01_Exit",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "{#Emph}Oh! {#Prev}Well, these wings, they need further maintenance but... what am I even saying. They can definitely wait. Let's go?" },

				{ Cue = "/VO/Melinoe_4541", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineFunctionName = "BathHouseStartPresentation",
					NarrativeContextArt = "DialogueBackground_Bathhouse",
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "You're quiet, Icarus. What's on your mind? Besides the further maintenance of the magnificent wings you've built." },

				{ Cue = "/VO/Icarus_0198",
					PreLineWait = 0.5,
					Portrait = "Portrait_Icarus_Bath_01",
					PortraitExitAnimation = "Portrait_Icarus_Bath_01_Exit",
					Text = "{#Emph}Heh{#Prev}, it's just... most of my evenings are substantially less pleasant. I want to make this last. As well as fix the bloody wings! If they were {#Emph}so {#Prev}magnificent, they wouldn't break."
				},
				{ Cue = "/VO/Melinoe_4542", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "I think magnificent things are often fragile things. Though they seem sturdier than you let on! You had to solve the problems that caused the famous wings of Daedalus to fail." },

				{ Cue = "/VO/Icarus_0199",
					Portrait = "Portrait_Icarus_Bath_01",
					PortraitExitAnimation = "Portrait_Icarus_Bath_01_Exit",
					Text = "That failure was mine. The wings my father made were built with feathers and wax, which was all he had to work with at the time. The wax had to stay cool, but {#Emph}I {#Prev}flew off into the blazing sun. Probably should have gone out at night, in retrospect..." },

				{ Cue = "/VO/Melinoe_4543", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Bath_01",
					PortraitExitAnimation = "Portrait_Mel_Bath_01_Exit",
					Text = "Perhaps you didn't have the luxury of choice, since you were captives then. So what happened? The wings melted on you?" },

				{ Cue = "/VO/Icarus_0200",

					Portrait = "Portrait_Icarus_Bath_01",
					PortraitExitAnimation = "Portrait_Icarus_Bath_01_Exit",

					PostLineFunctionName = "BathHouseQuipPresentation",
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 12, GlobalVoiceLines = "HotSpringsBathVoiceLines" },

					EndSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					PostLineRemoveContextArt = true,

					Text = "Well, yes. Using them was such a thrill that I pushed them too hard. So I fell. These new ones use a fiber like the bones of a bird, so they don't split as easily. Though let's not talk about the past, all right? I much prefer the present." },

				{ Cue = "/VO/Icarus_0201",
					PreLineFunctionName = "BathHouseEndPresentation",
					PreLineWait = 0.2,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostBathHouseArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}...Whew! {#Prev}They tell the dead to rest in peace but I've not had a break like that in {#Emph}far {#Prev}too long. Cheers, hey?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.25,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4545", Text = "Cheers!" },
					},
				},
			},

			IcarusBathHouseDecline01 =
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
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_4555", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey if you're not too busy, would you care to join me for a visit to the hot springs for a bit?" },
				{ Cue = "/VO/Icarus_0241",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					PostLineThreadedFunctionName = "GiftPointRareRefundPresentation",
					Text = "You've no idea how much I want to, but I really can't right now... I told Master Odysseus I'd soon be heading out." },
			},

			-- fishing
			IcarusFishing01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				OnGiftTrack = true,
				SkipContextArt = true,
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
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift04" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					NamedRequirements = { "IcarusUnlockedInHub" },
				},
				{ Cue = "/VO/Melinoe_4546", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey if you don't have to fly off just yet, how about a visit to the fishing pier with me? It's nice and quiet over there." },

				{ Cue = "/VO/Icarus_0202",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Icarus_Default_01_Exit",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Sure, that sounds great! Though I should note I've never learned to fish, so fair warning I will not be any good." },

				{ Cue = "/VO/Icarus_0203",
					PreLineWait = 0.35,
					SkipContextArt = true,
					PreLineFunctionName = "FishingPierStartPresentation",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "...Where I was from, fish were a major source of sustenance. It's strange, I... I never really thought that they were living creatures, same as me. Well, not {#Emph}same {#Prev}as me, but you get the idea. I was a kid! What did I know." },

				{ Cue = "/VO/Melinoe_4547", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Everything you mortals eat is living, or once was. I'm glad I have no need of sustenance... I've always found it quite distasteful, the idea of having to consume lives just to prolong one's own." },

				{ Cue = "/VO/Icarus_0204",
					SkipContextArt = true,
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "We mortals are all about having to do distasteful things. That's one of the main differences between us and you, along with us being so easy to kill off. What choice do we have but to try and survive?" },

				{ Cue = "/VO/Melinoe_4548", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "No choice at all, perhaps. Much in nature struggles to survive, from the flower yearning for a bit of light, to you, trying to figure out how to ask me to teach you to fish!" },

				{ Cue = "/VO/Icarus_0205",
					SkipContextArt = true,
					PortraitExitAnimation = "Portrait_Icarus_Default_01_Exit",
					Text = "{#Emph}Haha. {#Prev}Well I understand it's necessary to be silent... so, why don't you provide a demonstration and I'll carefully observe.",
					PostLineFunctionName = "GiftActivityFishing",
					PostLineFunctionArgs = { FishingPointId = 585640 },
					PostLineThreadedFunctionName = "TimePassesPresentation",
					PostLineThreadedFunctionArgs = { TimeTicks = 16, IncludeFishingSFX = true }, },

				{ Cue = "/VO/Icarus_0206",
					PreLineFunctionName = "FishingPierEndPresentation",
					PostLineFunctionName = "ResourceGiftedInEventPresentation",
					PostLineFunctionArgs = { ResourceName = "FishFRare", SoundName = "/Leftovers/SFX/BigFishSplash", GiftWaitTime = 0 },

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostFishingArgs,

					Text = "You know, I really did enjoy that, even just the quiet-waiting part. Thanks for bringing me along." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.34,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_0768", Text = "You're welcome." },
					},
				},
			},
			IcarusFishingDecline01 =
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
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_4556", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I was thinking maybe you could join me by the fishing pier again, if you don't mind?" },
				{ Cue = "/VO/Icarus_0242",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "GiftPointEpicRefundPresentation",
					Text = "As much as I would like that, I can't stick around much longer here tonight. Some other time though, hey?" },
			},

			-- taverna
			IcarusTaverna01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_IcarusUnlockHint01",
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusBathHouse01", "IcarusGift05", "IcarusAboutDaedalus02" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeTaverna" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					NamedRequirements = { "IcarusUnlockedInHub" },
				},
				{ Cue = "/VO/Melinoe_4549", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Hey, ever tried Ambrosia, Icarus? Because if not, you're about to. Given your inclination and availability, of course." },

				{ Cue = "/VO/Icarus_0235",
					PostLineRemoveContextArt = true,
					PortraitExitAnimation = "Portrait_Icarus_Default_01_Exit",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "As a matter of fact, {#Emph}no{#Prev}, I've not tried Ambrosia before, and I've {#Emph}never {#Prev}had the inclination till you asked me just now. You sure it'd be all right...?" },

				{ Cue = "/VO/Icarus_0236",
					SkipContextArt = true,
					PreLineFunctionName = "TavernaStartPresentation",
					PreLineWait = 0.35,
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "...The other Shades are watching us, Meli. They admire you so much, and probably would wish I was dead if I wasn't already." },

				{ Cue = "/VO/Melinoe_4550", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh don't worry. If any of those Shades get too envious, the only attention they'll end up getting is from Nemesis. Why would they even care? I see {#Emph}them {#Prev}more than you." },

				{ Cue = "/VO/Icarus_0237",
					SkipContextArt = true,
					PreLineAnim = "Icarus_Pensive_End",
					Text = "Well, it's just... as mortals many of us could get jealous. Especially when we'd see someone we cared for with somebody else. Hard to explain, but I think it all stems from our instinctively knowing how little time we have." },

				{ Cue = "/VO/Melinoe_4551", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "But you all have eternity now that you're here. Provided Chronos hasn't yet irreparably ruined everything. Though I suppose we gods can also have those types of feelings." },

				{ Cue = "/VO/Icarus_0238",
					SkipContextArt = true,
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "{#Emph}Really? {#Prev}Come on, name {#Emph}one {#Prev}thing that's ever made you envious, Meli. You seem so comfortable the way you are, and with everything you have... I've never seen you want for anything that isn't yours." },

				{ Cue = "/VO/Melinoe_4552", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Then you haven't been paying attention. I'm envious of Headmistress, for one. I'll never be half the witch she is. Nor look nearly as elegant in hats." },

				{ Cue = "/VO/Icarus_0239",
					SkipContextArt = true,
					PreLineWait = 0.35,
					PortraitExitAnimation = "Portrait_Icarus_Default_01_Exit",
					PostLineThreadedFunctionName = "LoungeRevelryPresentation",
					PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", TimeTicks = 20 },

					Text = "All right, I stand corrected! You're envious of the {#Emph}hat {#Prev}of the Witch of the Crossroads. Now {#Emph}can {#Prev}we try the drink already, hey? Could always spare some for the other Shades!" },

				{ Cue = "/VO/Icarus_0240",
					PreLineFunctionName = "TavernaEndPresentation",
					PreLineWait = 0.35,

					PostLineThreadedFunctionName = "InCombatTextEvent",
					PostLineThreadedFunctionArgs = GameData.PostTavernaArgs,

					Emote = "PortraitEmoteSparkly",
					Text = "...Wow. I have never had something like that in my {#Emph}entire {#Prev}life. Or death. The gods just regularly drink this stuff...?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4554", Text = "Some of them anyway!" },
					},
				},
			},

			IcarusTavernaDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusTaverna01" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Melinoe_4557", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					Text = "Got another bottle of Ambrosia we could split at the taverna if you're up for it?" },
				{ Cue = "/VO/Icarus_0243",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "SuperGiftPointRefundPresentation",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "I would genuinely love to, though... we've had reports of a new fleet appearing in the Rift, and I'd best pay them a visit first." },
			},

			IcarusFieldGiftDecline01 =
			{
				PlayOnce = true,
				SkipGiftPresentationPost = true,
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "Hero", "IsDead" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusBathHouse02", "IcarusTaverna01", "IcarusFishing01", "IcarusGift06" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "IcarusAboutFlying02", "IcarusAboutFlying02_B" },
					},
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
				},
				{ Cue = "/VO/Icarus_0394",
					PreLineWait = 0.35,
					PostLineThreadedFunctionName = "SuperGiftPointRefundPresentation",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "How about we try this at the Crossroads sometime, hey? Harder to concentrate here what with all the sunken ships and deathless crewmates and whatnot." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_3638", Text = "I see your point." },
					},
				},

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
							Path = { "PreviousDeathAreaRoom", "Name" },
							IsNone = { "Hub_PreRun" },
						},
						{
							PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" }
						},
						{
							PathFalse = { "CurrentRun", "UsedStoryReset" },
						},
					},
					Cooldowns =
					{
						{ Name = "MelinoeAnyQuipSpeech" },
					},

					{ Cue = "/VO/Melinoe_5161", Text = "Icarus flew off..." },
					{ Cue = "/VO/Melinoe_5162", Text = "No Icarus tonight...", PlayFirst = true },
					{ Cue = "/VO/Melinoe_5163", Text = "{#Emph}Oh{#Prev}, where's Icarus...?",
						GameStateRequirements =
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
							{
								SumPrevRuns = 8,
								Path = { "SpeechRecord", "/VO/Melinoe_5163" },
								CountPathTrue = true,
								Comparison = "<=",
								Value = 0,
							},
						},
					},
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

		UpgradeMenuOpenVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 0.75,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "IcarusPostTrueEnding02" },
					},
				},

				{ Cue = "/VO/MelinoeField_4058", Text = "One night at a time..." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.5,
				PreLineWait = 0.85,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Icarus_01", SubtitleColor = Color.IcarusVoice },
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone =
						{
							"IcarusPostTrueEnding01",
							"IcarusPostTrueEnding01_B",
							"IcarusAboutFlying02",
							"IcarusAboutFlying02_B"
						},
					},
				},

				{ Cue = "/VO/Icarus_0285", Text = "Here's what I've got...", PlayFirst = true },
				{ Cue = "/VO/Icarus_0284", Text = "Take your pick." },
				{ Cue = "/VO/Icarus_0286", Text = "My latest work..." },
				{ Cue = "/VO/Icarus_0287", Text = "Any of these." },
				{ Cue = "/VO/Icarus_0288", Text = "These should work." },
				{ Cue = "/VO/Icarus_0289", Text = "Whichever you want..." },
			},
			{ GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},

		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ChanceToPlay = 0.5,
			SkipCooldownCheckIfNonePlayed = true,
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
				{ Name = "IcarusGotHitRecently", Time = 6 },
				{ Name = "IcarusAnyQuipSpeech", Time = 10 },
			},

			{ Cue = "/VO/Icarus_0279", Text = "Already dead. Sorry.", PlayFirst = true },
			{ Cue = "/VO/Icarus_0278", Text = "Come on, Meli." },
			{ Cue = "/VO/Icarus_0282", Text = "Missed me...!" },
			{ Cue = "/VO/Icarus_0283", Text = "I'm angry too." },
			{ Cue = "/VO/Icarus_0280", Text = "Didn't hurt." },
			{ Cue = "/VO/Icarus_0281", Text = "{#Emph}Didn't hurt...!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "SpeechRecord", "/VO/Icarus_0280" },
					},
				},
			},
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
				{ Cue = "/VO/Icarus_0095", Text = "Bunch 'em up for me, hey?" },
				{ Cue = "/VO/Icarus_0096", Text = "Beginning attack run.", PlayFirst = true },
				{ Cue = "/VO/Icarus_0097", Text = "Engaging!" },
				{ Cue = "/VO/Icarus_0542", Text = "I see 'em there, hold on!" },
				{ Cue = "/VO/Icarus_0543", Text = "Keep 'em busy for me, hey?" },
				{ Cue = "/VO/Icarus_0544", Text = "You call for air support?" },
				{ Cue = "/VO/Icarus_0545", Text = "I'll back you up, Meli!" },
				{ Cue = "/VO/Icarus_0546", Text = "Bombs primed, here we go." },
				{ Cue = "/VO/Icarus_0547", Text = "Thought that was you, hang on!" },
				{ Cue = "/VO/Icarus_0540", Text = "Be right there!" },
				{ Cue = "/VO/Icarus_0536", Text = "Target spotted!" },
				{ Cue = "/VO/Icarus_0491", Text = "It's been too long!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							SumPrevRuns = 4,
							IgnoreCurrentRun = true,
							Path = { "EncountersOccurredCache" },
							TableValuesToCount = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
							Comparison = "<=",
							Value = 0,
						},
					},
				},
				{ Cue = "/VO/Icarus_0492", Text = "Missed you here, Meli!",
					GameStateRequirements =
					{
						{
							SumPrevRuns = 4,
							IgnoreCurrentRun = true,
							Path = { "EncountersOccurredCache" },
							TableValuesToCount = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
							Comparison = "<=",
							Value = 0,
						},
					}
				},
				{ Cue = "/VO/Icarus_0548", Text = "{#Emph}Ooh{#Prev}, it's cold up here!",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P" },
						},
					}
				},
				{ Cue = "/VO/Icarus_0549", Text = "I {#Emph}hate {#Prev}flying through snow!",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "P" },
						},
					}
				},			
			},
			{
				PlayOnce = true,
				PlayOnceContext = "IcarusIntroReactionVO",
				UsePlayerSource = true,
				PreLineWait = 1.3,

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

				{ Cue = "/VO/MelinoeField_2213", Text = "Icarus!", PlayFirst = true },
				{ Cue = "/VO/MelinoeField_2211", Text = "Icarus...!" },
				{ Cue = "/VO/MelinoeField_2212", Text = "He's back...!" },
				{ Cue = "/VO/MelinoeField_2214", Text = "Hi!" },
				{ Cue = "/VO/MelinoeField_2215", Text = "I see you!" },
				{ Cue = "/VO/MelinoeField_2223", Text = "Here, Icarus!" },
				{ Cue = "/VO/MelinoeField_2224", Text = "Right here!" },
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
				{ Cue = "/VO/Icarus_0125", Text = "Rough waters...",
					GameStateRequirements =
					{
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsAny = { "O" },
						},
					},
				},
				{ Cue = "/VO/Icarus_0126", Text = "Sorry to interrupt..." },
				{ Cue = "/VO/Icarus_0127", Text = "That was ugly..." },
				{ Cue = "/VO/Icarus_0128", Text = "Nice night...!" },
				{ Cue = "/VO/Icarus_0129", Text = "That was amazing." },
				{ Cue = "/VO/Icarus_0130", Text = "Not too bad..." },
				{ Cue = "/VO/Icarus_0520", Text = "Takes care of {#Emph}that." },
				{ Cue = "/VO/Icarus_0521", Text = "No problem." },
				{ Cue = "/VO/Icarus_0522", Text = "Nice place." },
				{ Cue = "/VO/Icarus_0523", Text = "Alone at last.",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "IcarusGift09" },
						},
					},
				},
			},
			{
				PreLineWait = 0.1,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.75,
				UsePlayerSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = ">=", Value = 0.2, },
					},
				},

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
				{ Cue = "/VO/Icarus_0528", Text = "See you Meli!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" }
						},
					},
				},
				{ Cue = "/VO/Icarus_0529", Text = "You take care!",
					GameStateRequirements =
					{
						{
							PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" }
						},
					},
				},
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
				{ Cue = "/VO/MelinoeField_2590", Text = "Keep up the good work...!" },
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
		
		Using =
		{
			Sounds = 
			{
				"/Leftovers/SFX/RobeFlutter",
				"/Leftovers/SFX/RobeFlutterInScene",
				"/Leftovers/World Sounds/Caravan Interior/ClothInteract",
				"/Leftovers/World Sounds/Caravan Interior/ClothInteract2",
				"/Leftovers/World Sounds/Caravan Interior/RugInteract",
			},


			Projectile = "IcarusExplosion",
		},
		
	},
}

VariantSetData.NPC_Icarus_01 =
{
	IcarusCombat =
	{
		NonHeroKillCombatText = "PartnerKill",
		RequiredRoomInteraction = true,
		SkipAISetupOnActivate = true,
		ExcludeFromDamageDealtRecord = true,
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
		AIOptions = { "AttackerAI" },
		PostCombatAI = "IcarusPostCombat",
		PostCombatTeleportIfPastDistance = 800,

		WeaponOptions =
		{
			--"IcarusBombardmentLine", "IcarusBombardmentLine2", "IcarusBombardmentLine3",
			"IcarusBombardmentLine", "IcarusBombardmentLine", "IcarusBombardmentLine", -- try to open with line early
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

	-- Icarus (Home Version), Id = 800098
	IcarusHome =
	{
		NarrativeDataName = "NPC_Icarus_01",
		
		ActivateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "FatesEpilogue01" },
			},
			NamedRequirements = { "IcarusUnlockedInHub" },
		},

		RotatorRequirements =
		{
			OrRequirements =
			{
				-- encountered in the field
				{
					{
						Path = { "CurrentRun", "EncountersCompletedCache" },
						HasAny = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
					},
				},
				-- been busy in the underworld
				{
					{
						SumPrevRuns = 3,
						-- IgnoreCurrentRun = true,
						Path = { "BiomesReached", "F" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
				}
			},
			-- not during these events
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasNone = { "FatesEpilogue01" },
			},
			-- shouldn't reappear if re-entering Hub after events with IcarusHubExitPresentation
			{
				PathFalse = { "CurrentRun", "IcarusExitedHub" },
			},
			NamedRequirementsFalse = { "IcarusLeavesHubAfterBecomingCloser", "IcarusLeavesHubAfterTrueEnding" },
		},

		PreBathAnimationName = "Icarus_Salute",
		PreBathOffsetY = 50,
		InteractTextLinePriorities = "HomePriorities",
		InteractTextLineSets =
		{
			-- Home Events
			IcarusHomeFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					--[[
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Odysseus_01", }, Alive = true },
					},
					]]--
					-- NamedRequirements = { "IcarusUnlocked" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0164",
					-- Portrait = "Portrait_Icarus_Unsure_01",
					-- Portrait = "Portrait_Icarus_Pleased_01",
					-- PreLineAnim = "Icarus_Salute",
					-- PreLineAnim = "Icarus_Explaining_Start",
					-- PostLineAnim = "Icarus_Explaining_End",
					-- PreLineAnim = "Icarus_Flustered_Start",
					-- PostLineAnim = "Icarus_Flustered_End",
					-- PreLineAnim = "Icarus_Pensive_Start",
					-- PostLineAnim = "Icarus_Pensive_End",
					-- PreLineAnim = "Icarus_Offer_Start",
					-- PostLineAnim = "Icarus_Offer_End",

					PreLineAnim = "Icarus_Pensive_Start",
					Text = "Didn't think I'd feel this way, though it's good to be back, Meli! Oh, {#Emph}erm{#Prev}, Your Grace. This place feels different, think it's... {#Emph}warmer {#Prev}than it used to be or something, hey?" },
				{ Cue = "/VO/Melinoe_4520", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You found your way back! You're welcome here and safe as ever, Icarus. I trust the wings made the return trip relatively swift and trouble-free?" },
				{ Cue = "/VO/Icarus_0165",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "Well, flying past the city of Ephyra sure beats having to trudge through. I still have to check in with Master Odysseus, though I'll try not be such a stranger around here." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.35,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4521", Text = "Do see to that." },
					},
				},
			},

			IcarusHomeAboutCrossroads01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					-- NamedRequirements = { "IcarusUnlocked" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0166",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "This place has changed so much since I took off. If you told me half this stuff was here, you'd have had a way easier time persuading me to come back." },
				{ Cue = "/VO/Melinoe_4522", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I wanted to see if you'd do it of your own accord. And also, surprise! You still remember the trick to locating the place?" },
				{ Cue = "/VO/Icarus_0167",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Hard to forget it once you know the way. Though, finding a good landing spot, I'm out of practice on that front. I nearly crashed into the cauldron!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.2,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4523", Text = "No, what happened?" },
					},
					{
						PreLineWait = 0.38,
						ObjectTypes = { "NPC_Icarus_01" },
						{ Cue = "/VO/Icarus_0168", Text = "...I crashed into Master Odysseus instead!" },
					}
				},
			},

			-- post-ending alt below
			IcarusHomeAboutCrossroads02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusHomeAboutCrossroads02_B" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0169",
					Text = "So you really do wake up each night back there, entirely refreshed? And with a newfound resolve to achieve your life's ambition, that sort of thing?" },
				{ Cue = "/VO/Melinoe_4524", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You make it sound so automatic. My physical recovery may be mostly second-nature by now, but my motivation certainly is not. You think I never get discouraged?" },
				{ Cue = "/VO/Icarus_0170",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I've {#Emph}never {#Prev}seen you discouraged. Though maybe you just hide it well. What'll you do if you succeed, hey? Pursue some other hopes and dreams?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.2,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4525", Text = "That's not something I've given any thought." },
					},
					{
						PreLineWait = 0.38,
						ObjectTypes = { "NPC_Icarus_01" },
						{ Cue = "/VO/Icarus_0171", Text = "I get it. First things first." },
					}
				},
			},
			IcarusHomeAboutCrossroads02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusHomeAboutCrossroads02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0169",
					Text = "So you really do wake up each night back there, entirely refreshed? And with a newfound resolve to achieve your life's ambition, that sort of thing?" },
				{ Cue = "/VO/Melinoe_4524", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You make it sound so automatic. My physical recovery may be mostly second-nature by now, but my motivation certainly is not. You think I never get discouraged?" },
				{ Cue = "/VO/Icarus_0170_B",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I've {#Emph}never {#Prev}seen you discouraged. Though maybe you just hide it well." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.32,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4870", Text = "A gift I never knew I had!" },
					},
				},
			},

			IcarusHomeAboutCrossroads03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					-- NamedRequirements = { "IcarusUnlocked" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0172",
					Text = "{#Emph}Oh{#Prev}, you're up! I almost missed you, was about to fly on back to Thessaly. Hope you rested well. Sounds like you had quite an eventful night!" },

				{ Cue = "/VO/Melinoe_4526", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "It {#Emph}was {#Prev}productive, yes. Though if you're on assignment, I don't wish to keep you. We'll catch up some other time...! Or were you waiting here for me?" },

				{ Cue = "/VO/Icarus_0173",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Icarus_Unsure_01", WaitTime = 6.5 },
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "{#Emph}No! {#Prev}I mean, it's good to see you, {#Emph}yes{#Prev}, but... I'm not {#Emph}late. {#Prev}I can make up the time during my flight, you know, air currents and the like. So... well, back to it for the both of us then, hey?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4527", Text = "Back to it, yes." },
					},
				},
			},

			IcarusHomeAboutRain01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "NextBiomeStateName" },
						IsAny = { "Rain" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusBecomingCloser01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0458",
					Text = "It never rains like {#Emph}this {#Prev}over the Rift. It's funny, growing up, I'd sometimes hear the sound of rain outside, but never got to feel it even once." },
				{ Cue = "/VO/Melinoe_4861", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Odysseus would say you didn't miss much there, though he probably got rained on more than any mortal that ever lived. I quite like it, myself." },
				{ Cue = "/VO/Icarus_0459",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I do, too. Even got a taste of it thanks to your Ectoplasmic Draught. And even now, I still enjoy the look and sound of it... what it does to your hair and all that." },
				{ Cue = "/VO/Melinoe_4862", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "My hair must look like dying branches, Icarus." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.33,
						ObjectTypes = { "NPC_Icarus_01" },
						{ Cue = "/VO/Icarus_0460", Text = "Not to me." },
					},
				},
			},
			IcarusHomeAboutArtemisSinging01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "AudioState", "AmbientTrackName" },
						IsAny = { "/Music/ArtemisSong_MC", "/Music/IrisEndThemeCrossroads_MC" },
					},
					{
						Path = { "ConfigOptionCache", "MusicVolume" },
						Comparison = ">",
						Value = 0.1,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0461",
					Text = "I never thought the goddess of the hunt would be {#Emph}here {#Prev}in the middle of all this. Figured they'd have her busy sniping targets on Olympus! She sings nice." },
				{ Cue = "/VO/Melinoe_4863", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "She does. Artemis is supposed to be keeping an eye on us, but she helps watch my back. I don't know how I even would have met the other gods if not for her." },
				{ Cue = "/VO/Icarus_0462",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "You're cousins but you're more like sisters, hey? Must be reassuring to have someone like that looking out for you." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4864", Text = "Was that a trace of {#Emph}jealousy?" },
					},
					{
						PreLineWait = 0.33,
						ObjectTypes = { "NPC_Icarus_01" },
						{ Cue = "/VO/Icarus_0463", Text = "More like inadequacy. But it's gone!" },
					},
				},
			},

			IcarusHomeAboutGrace01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift04" },
					},
					{
						Path = { "CurrentRun", "EncountersCompletedCache" },
						HasAny = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
					},
					-- NamedRequirements = { "IcarusUnlocked" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0449",
					Text = "Pleased to see you well again, Your Grace. Don't know about you, but last night was hard-fought for me! Those Chronos warship crews don't seem to tire out." },
				{ Cue = "/VO/Melinoe_4584", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Icarus, I thought I told you that I'm not {#Emph}Your Grace{#Prev}. I may be Princess of the Underworld by birth, but here I serve the Unseen, the same as you." },
				{ Cue = "/VO/Icarus_0450",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "I know, it's just I don't want any special treatment here. Other Shades all seem to be polite with you. And, I {#Emph}like {#Prev}calling you Your Grace! As long as you don't mind." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4585", Text = "Just not too often, then." },
					},
					{
						PreLineWait = 0.25,
						ObjectType = "NPC_Icarus_01",
						{ Cue = "/VO/Icarus_0451", Text = "Yes your— yes." },
					},
				},
			},

			IcarusHomeAboutTools01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgrades", "Cosmetic_IcarusTable01" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0554",
					Text = "That toolset there, is it really for me? Everything there looks so shiny. Where did we even {#Emph}get {#Prev}those from?" },
				{ Cue = "/VO/Melinoe_4868", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Consider it a gift from the Crossroads, Icarus. You shape the bounties of the Earth into wondrous things, so you might as well have the finest equipment." },
				{ Cue = "/VO/Icarus_0555",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I'll have to try them out, thank you so much. I'm quite partial to the worn set I've been using for a while, but those are probably due for a break." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4869", Text = "Aren't we all!" },
					},
				},
			},

			IcarusHomeAboutOdysseusWandering01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					NamedRequirements = { "OdysseusWandering" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0464",
					Text = "Hey, do you know where Master Odysseus could have gone? I was supposed to report in tonight, though I haven't seen him in a little while..." },

				{ Cue = "/VO/Melinoe_4865", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think he had some personal matters that he needed to take care of. I'm uncertain when he'll return. Did your report contain anything urgent?" },

				{ Cue = "/VO/Icarus_0465",
					PreLineAnim = "Icarus_Pensive_Start",
					Text = "No, it's just... I don't know. When he isn't there, I have this worry that he won't come back. He seems a wanderer at heart, and... isn't his own family someplace else?" },

				{ Cue = "/VO/Melinoe_4866", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Depends which family you mean! He isn't bound to the Crossroads any more than you. You may always return as long as you're welcome here, and I think he shall." },

				{ Cue = "/VO/Icarus_0466",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "Like how you visited your family and still returned..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 2,
						{ Cue = "/VO/Melinoe_4867", Text = "Exactly right." },
					},
				},
			},

			-- alt below
			IcarusHomeAboutMoros01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusHomeAboutMoros01_B" }
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Moros_01", }, Alive = true },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0174",
					Portrait = "Portrait_Icarus_Unsure_01",
					Text = "Tall fellow over there by that big tapestry type thing... isn't that {#Emph}Doom? {#Prev}Seems friendlier than I imagined, judging by the way the two of you were getting on." },

				{ Cue = "/VO/Melinoe_4528", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Moros is our guest, and that tapestry beside him holds the will of the Three Fates. His family's in a similar predicament to mine. Would you like to meet him?" },

				{ Cue = "/VO/Icarus_0175",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "Oh, {#Emph}no{#Prev}, we, {#Emph}erm{#Prev}... we've met before. Though I don't think he would remember me. It's for the best! I just didn't expect to see him again... let alone here. I'm glad he's all right!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0061_B", Text = "He is." },
					},
				},
			},
			IcarusHomeAboutMoros01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "IcarusHomeAboutMoros01" }
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Moros_01", }, Alive = true },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0174",
					Portrait = "Portrait_Icarus_Unsure_01",
					Text = "Tall fellow over there by that big tapestry type thing... isn't that {#Emph}Doom? {#Prev}Seems friendlier than I imagined, judging by the way the two of you were getting on." },
				{ Cue = "/VO/Melinoe_4528_B", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Lord Moros is our guest, and that tapestry beside him holds the will of the Three Fates. Would you like to meet him?" },

				{ Cue = "/VO/Icarus_0175",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Unsure_01",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "Oh, {#Emph}no{#Prev}, we, {#Emph}erm{#Prev}... we've met before. Though I don't think he would remember me. It's for the best! I just didn't expect to see him again... let alone here. I'm glad he's all right!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_0061_B", Text = "He is." },
					},
				},
			},

			IcarusHomeAboutMortality01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift09" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0452",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I sometimes think of what it's like being a god. Ever wonder what your life would have been like if you were mortal, hey? You probably would have wound up in Elysium." },

				{ Cue = "/VO/Melinoe_4858", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Proud_01", WaitTime = 4 },

					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Among the greatest heroes of your kind? I'm not so certain about that. If I were born mortal, I suppose... I would have worked at something all my life. Attempted to excel beyond my means and those of anybody else." },

				{ Cue = "/VO/Icarus_0453",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Meli, that's almost as depressing as my life, and I didn't get to choose. Most mortals work only to earn their keep... but it's the pleasures that we want, not the toil." },

				{ Cue = "/VO/Melinoe_4859", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Truly? Yet here you are as a Shade, seeking to outdo your own master-artisan father at his craft, while battling against the Titan's legions. To earn your keep?" },

				{ Cue = "/VO/Icarus_0454",
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "All right I see your point, sorry. That was the mortal impulse to tell others how to live. But we rarely find our own sense of purpose, much less anyone else's. I wonder what you would have excelled at..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.32,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4860", Text = "Arguing, perhaps? As lawyer or a judge." },
					},
					{
						PreLineWait = 0.33,
						ObjectType = "NPC_Icarus_01",
						{ Cue = "/VO/Icarus_0455", Text = "...That's... terrifying." },
					},
				},
			},

			IcarusHomeAboutRelationships01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesChoiceRecord", "IcarusBecomingCloser01", },
						IsAny = { "Choice_IcarusAccept" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0442",
					Text = "It's funny... we mortals go through life searching for that one other soul with whom we want to spend the rest of our nights; a love that lasts forever, but... we're really talking maybe thirty, forty years. Must be so different for the gods." },

				{ Cue = "/VO/Melinoe_4850", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Empathetic_01", WaitTime = 5.3 },

					Text = "To want for all of someone's love... it seems so selfish. Nemesis would surely disapprove. My understanding is we all have varying capacity for different types of love. In fact I think I've quite a bit for you now, Icarus." },

				{ Cue = "/VO/Icarus_0443",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Icarus_Pleased_01",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "You've quite a bit, wait you mean {#Emph}love{#Prev}, for {#Emph}me? {#Prev}Even though there must be others whom you fancy around here, in that primary-type-of-love sort of way. But what if... I have all this love for {#Emph}you{#Prev}, and no one else...?" },

				{ Cue = "/VO/Melinoe_4851", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Then I am very fortunate, though also I think you must have much more to give. And you've eternity to find all those who deserve it. I alone shall have to do for now." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.33,
						ObjectType = "NPC_Icarus_01",
						{ Cue = "/VO/Icarus_0444", Text = "You're more than enough for me, Meli." },
					},
					{
						PreLineWait = 0.32,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4852", Text = "Perhaps." },
					},
				},
			},

			IcarusHomeAboutTyphonDeath01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				-- GiftableOffSource = true,
				-- PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ZeusPalaceAboutTyphonDeath01" }, Max = 6 },
					},
					NamedRequirementsFalse = { "IcarusLeavesHubAfterTrueEnding" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0420",
					Text = "The storm that had been covering the top of Mount Olympus cleared up...! I figured I'd finally get to see Typhon, but {#Emph}no! {#Prev}What happened there?" },
				{ Cue = "/VO/Melinoe_4844", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "The storm is gone because Typhon himself is gone. He seemed to be growing angrier each passing night. It was either him, or my family and their home." },
				{ Cue = "/VO/Icarus_0421",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "You're kidding me! He's gone as in, he's gone? Not hiding, dormant, nothing of the sort? {#Emph}Well! {#Prev}That's {#Emph}great! {#Prev}What are you doing here, though? You ought to be feasting with the rest of the Olympians right now!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.36,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4845", Text = "Need to take care of a few things." },
					},
				},
			},

			IcarusHomePostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- InitialGiftableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "IcarusPostTrueEnding01", "IcarusPostTrueEnding01_B" }
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0422",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "The war with Chronos, it's really {#Emph}over{#Prev}, hey? The energy about this place is different, tension's gone, the other Shades practically bouncing up and down! You {#Emph}did {#Prev}it...!" },
				{ Cue = "/VO/Melinoe_4846", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Perhaps, but... there's still more to be done. Preventative measures to ensure what happened never can occur again." },
				{ Cue = "/VO/Icarus_0423",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					-- Emote = "PortraitEmoteDepressed",
					Text = "Meli, can't you give yourself a break? Your task is finally complete! What are you going to do now, with the whole rest of your existence ahead of you?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4847", Text = "I said there's still more to be done." },
					},
					{
						PreLineWait = 0.25,
						ObjectType = "NPC_Icarus_01",
						{ Cue = "/VO/Icarus_0424", Text = "I didn't mean... sorry."	},
					}
				},
			},
			IcarusHomePostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0427",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "You know, I thought that once Chronos was out and the Underworld King and Queen were back, you'd have to join them in the House of Hades. Be the princess you were always meant to be." },
				{ Cue = "/VO/Melinoe_4848", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I'd like to think I already am that. My father's House is truly something to behold, but {#Emph}this {#Prev}is home, not there. And I'll be seeing my parents and brother frequently enough, I think." },
				{ Cue = "/VO/Icarus_0428",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "Oh, {#Emph}right! {#Prev}How was it meeting Zagreus? He live up to all the hushed tales of his prowess and all that?" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4849", Text = "If I told you, I'd have to slay you." },
					},
					{
						PreLineWait = 0.25,
						ObjectType = "NPC_Icarus_01",
						{ Cue = "/VO/Icarus_0429", Text = "{#Emph}Hah! {#Prev}Well, all right!" },
					}
				},
			},

			IcarusHomePostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0447",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Been hearing Shades say something's changing on Olympus... that the Fates themselves decided that the gods will soon be ruling with a lighter touch? That sounds... {#Emph}different." },

				{ Cue = "/VO/Melinoe_4856", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I think {#Emph}soon {#Prev}there may be relative to gods not mortals, but... what I've heard is much the same. At the dawn of the new age, mortals are to choose their paths themselves." },

				{ Cue = "/VO/Icarus_0448",
					PreLineAnim = "Icarus_Pensive_End",
					Text = "An age where neither the gods nor the Fates are dictating each moment of our lives, or deaths. Hard to imagine. Who would we even blame if things went wrong then, hey?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.34,
						UsePlayerSource = true,
						{ Cue = "/VO/Melinoe_4857", Text = "You'll find someone I'm sure!" },
					},
				},
			},
			IcarusHomePostEpilogue02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "FatesEpilogue01", "HecateBathHouseEpilogue01" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HecateBathHouseEpilogue01" }, Min = 1 },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Melinoe_4853", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Icarus, when did you realize your father wasn't who you thought? Sounds like you grew up always wanting to live up to his idea of you, though at some point you stopped." },

				{ Cue = "/VO/Icarus_0445",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "Well, it was probably when I found him after I died. He looked {#Emph}so {#Prev}disappointed; I genuinely thought he was upset I broke his precious wings. Kept working for him, though." },

				{ Cue = "/VO/Melinoe_4854", UsePlayerSource = true,
					PreLineWait = 0.35,
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "...I see. Headmistress, she was like a mother to me, but... she always went out of her way to tell me she was not. I never really understood why." },

				{ Cue = "/VO/Icarus_0446",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "You love her, I know that. And she put you through a lot, I know that too! If somebody is such a big part of your life for long enough, eventually it gets a bit complicated, hey?" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/Melinoe_4855", Text = "Well, I suppose..." },
					},
				},
			},

			-- relationship
			IcarusBecomingCloser01 =
			{
				PauseMusicPlayerMusic = true,
				PlayOnce = true,
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				GiftableOffSource = true,
				StatusAnimation = "StatusIconWantsAffection",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift10" },
					},
					{
						FunctionName = "RequiredQueuedTextLine",
						FunctionArgs = { IsNone = { "ErisBecomingCloser01" } },
					},
					NamedRequirements = { "NoRecentBecomingCloserEvent" },
					NamedRequirementsFalse = { "NearTrueEnding" },
					--[[
					{
						PathFalse = { "CurrentRun", "TimePassageOccurred" },
						HintId = "Codex_TimePassesGiftUsed",
					},
					]]--
				},

				{ Cue = "/VO/Melinoe_4574", UsePlayerSource = true,
					PreLineWait = 0.35,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Icarus, you look... the Ectoplasmic Draught. You used it, and it worked...! Can I... is it all right if I...?" },

				{ Cue = "/VO/Icarus_0356",
					PreLineWait = 0.35,
					PostLineRemoveContextArt = true,
					Portrait = "Portrait_Icarus_Whole_01",
					PortraitExitAnimation = "Portrait_Icarus_Whole_01_Exit",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "...I was about to ask you the same thing. This is like {#Emph}nothing {#Prev}I've experienced since I was alive! And not even {#Emph}then! {#Prev}I took it all for granted then..." },

				-- SWITCH TO NEW SCENE

				{ Cue = "/VO/Melinoe_4576", UsePlayerSource = true,
					SkipContextArt = true,
					PreLineFunctionName = "GoSomeplaceStartPresentation",
					PreLineFunctionArgs = { Tent = true },
					PreLineWait = 0.35,
					Portrait = "Portrait_Mel_Casual_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What makes tonight so special anyhow? I thought you were going to save the Draught for some sort of once-in-an-eternity occasion." },

				{ Cue = "/VO/Icarus_0357",
					SkipContextArt = true,
					Portrait = "Portrait_Icarus_Whole_01",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I thought about that. And then I thought about how if I could just {#Emph}touch {#Prev}you, that would make for such an occasion for me. And then I realized, I didn't want to wait. I drank the Draught once I knew you were here. It wasn't bad!" },

				{ Cue = "/VO/Melinoe_4577", UsePlayerSource = true,
					SkipContextArt = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You swore you'd take this slow. What if I couldn't speak to you tonight? The Draught would have gone to waste!" },

				{ Cue = "/VO/Icarus_0358",
					SkipContextArt = true,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Icarus_Whole_01",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "You're right, you're right, it's just... you're {#Emph}here{#Prev}, and... I can feel my racing heart. Meli, may I... hold you in my arms?" },

				EndVoiceLines =
				{
					{
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesChoiceRecord", "IcarusBecomingCloser01", },
								IsAny = { "Choice_IcarusDecline" },
							},
						},
						{
							PreLineWait = 1.0,
							PreLineThreadedFunctionName = "IcarusHubExitPresentation",
							{ Cue = "/VO/Melinoe_4579", Text = "Goodbye...", UsePlayerSource = true },
						},
					},
					{
						PreLineWait = 1.0,
						PreLineThreadedFunctionName = "IcarusHubExitPresentation",
						GameStateRequirements =
						{
							{
								Path = { "CurrentRun", "TextLinesChoiceRecord", "IcarusBecomingCloser01", },
								IsAny = { "Choice_IcarusAccept" },
							},
						},
						{ Cue = "/VO/Melinoe_4583", Text = "Fly free and live, Icarus.", UsePlayerSource = true },
					},
				},
				{
					Text = "Choice_IcarusBecomingCloser01",
					Portrait = "Portrait_Icarus_Whole_01",
					SkipContextArt = true,
					IgnoreRawText = true,
					BoxAnimation = "NarrationBubbleRomance",
					BoxExitAnimation = "NarrationBubbleRomanceOut",
					DisableCharacterFadeColorLag = true,
					IsNarration = true,
					IgnoreContinueArrow = true,
					TextOffsetY = 0,
					PreContentSound = "/Leftovers/Menu Sounds/EmoteThoughtful",
					Choices =
					{
						{
							ChoiceText = "Choice_IcarusDecline",
							{ Cue = "/VO/Melinoe_4578",
								SkipContextArt = true,
								UsePlayerSource = true,
								PreLineWait = 1.0,
								Portrait = "Portrait_Mel_Vulnerable_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "...I just don't want to go too far, as we each have before. The side effects could be exacerbated, and... like you, I couldn't bear the thought. I think it may be best if you experienced the cold wind and the spray of the sea while you still can." },

							{ Cue = "/VO/Icarus_0359",
								SkipContextArt = true,
								PreLineWait = 0.35,
								Portrait = "Portrait_Icarus_Whole_01",
								PreLineAnim = "Icarus_Pensive_Start",
								PostLineAnim = "Icarus_Pensive_End",
								Text = "I do want to get to that. And I did get to take you by the hand. I'd stay here forever if I could but I had better make the most of this since it won't last. So bye for now, Meli." },
						},
						{
							ChoiceText = "Choice_IcarusAccept",
							{ Cue = "/VO/Melinoe_4580", UsePlayerSource = true,
								SkipContextArt = true,
								PostLineRemoveContextArt = true,
								PreLineWait = 1.0,
								Portrait = "Portrait_Mel_Pleased_01",
								PortraitExitAnimation = "Portrait_Mel_Pleased_01_Exit",
								PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",

								PostLineFunctionName = "BecomingCloserPresentation",
								PostLineFunctionArgs = { Sound2 = "/EmptyCue", Sound3 = "/EmptyCue", Partner = "Icarus", TimeTicks = 10, ExtraWaitTime = 0.25 },

								Text = "...I'd like for you to do that very much. You may experience strange sensations but I'll be as gentle as I can. Please let me know if you start having discomfort of any kind." },

							-- INTERMISSION PRESENTATION

							{ Cue = "/VO/Melinoe_4581",
								SkipContextArt = true,
								PreLineWait = 0.35,
								UsePlayerSource = true,
								Portrait = "Portrait_Mel_PleasedFlushed_01",
								PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "{#Emph}<Sigh> {#Prev}It's nice, the beating of your heart. And you're still very warm, you know. If not for that, I might take you for dead! You've not moved, not spoken... you all right?" },

							{ Cue = "/VO/Icarus_0361",
								SkipContextArt = true,
								PreLineWait = 0.5,
								Portrait = "Portrait_Icarus_Flushed_01",
								Text = "...This must be what Elysium is like... Meli, I'm {#Emph}far {#Prev}more than all right, I'm — I'm just taking in each moment as I can. What about you? That you're still here I think is a good sign...?" },

							{ Cue = "/VO/Melinoe_4582",
								SkipContextArt = true,
								UsePlayerSource = true,
								Portrait = "Portrait_Mel_PleasedFlushed_01",

								PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Vulnerable_01", WaitTime = 2.75 },

								PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
								PostLineAnim = "MelTalkBrooding01ReturnToIdle", PostLineAnimTarget = "Hero",
								Text = "You may take it as such. But, {#Emph}oh{#Prev}, you're getting colder now, and... the pallor of your skin is starting to change. The Draught is losing its effect. If you hurry, you still could feel that cold wind and the spray of the sea!" },

							{ Cue = "/VO/Icarus_0362",
								SkipContextArt = true,
								PreLineWait = 0.35,
								Portrait = "Portrait_Icarus_Flushed_01",
								PostLineThreadedFunctionName = "InCombatTextEvent",
								PostLineThreadedFunctionArgs = GameData.PostIntermissionArgs,

								Text = "I would much rather stay with you right here... but I don't wish to keep you, and I'll probably regret not taking flight like this while I still can. You're wonderful, Meli." },
						},
					},
				},
			},

			-- partner conversations
			IcarusWithOdysseus01 =
			{
				Partner = "NPC_Odysseus_01",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
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
				TeleportToId = 800386,
				TeleportOffsetX = -140,
				-- TeleportOffsetY = 250,
				AngleTowardTargetId = 557112,
				InteractDistance = 450,

				{ Cue = "/VO/Icarus_0244",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "As far as I can tell, the number of warships headed for Olympus has remained roughly the same night after night. Their mission doesn't seem to be affected in the slightest." },
				{ Cue = "/VO/Odysseus_0436", Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					PreLineAnim = "Odysseus_KnifeToss",
					PreLineAnimTarget = 557112,
					Text = "Their aim is to cut off the waterways and spread the limited attention of Olympus thin. Continue to disrupt them as you can, my lad. Though if the Harpies flock too thick, fall back." },
				{ Cue = "/VO/Icarus_0245",
					PreLineAnim = "Icarus_Salute",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					PostLineThreadedFunctionArgs = { WaitTime = 1.8 },
					Text = "You got it, sir! Those ships are ill-equipped against attackers from the sky, and the Harpies haven't caught up with me yet. All right, I'm off!" },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.38,
						ObjectType = "NPC_Odysseus_01",
						PreLineAnim = "Odysseus_Greet",
						{ Cue = "/VO/Odysseus_0437", Text = "Good hunting out there!" },
					},
				},
			},
			IcarusWithOdysseus02 =
			{
				Partner = "NPC_Odysseus_01",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusGift08", "OdysseusGift08" },
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
				StatusAnimation = false,
				TeleportToId = 800386,
				TeleportOffsetX = -140,
				-- TeleportOffsetY = 250,
				AngleTowardTargetId = 557112,
				InteractDistance = 450,

				{ Cue = "/VO/Odysseus_0705",
					Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					PreLineAnim = "Odysseus_KnifeToss",
					PreLineAnimTarget = 557112,
					PreLineWait = 0.35,
					Text = "...Anyhow, my lad, you're doing fine. You can't always know where you're going, but you {#Emph}can {#Prev}have a sense for whether you're headed in the general direction you desire. And don't be in such a hurry to get there if you can help it." },

				{ Cue = "/VO/Icarus_0467",
					PreLineAnim = "Icarus_Pensive_Start",
					PostLineAnim = "Icarus_Pensive_End",
					Text = "I've not gone anywhere, though, sir. I thought if I could just learn how to fly, I'd finally be able to go wherever I pleased. But the farther away I got, the more I wanted to come back! What was the use? I'm still not sure." },

				{ Cue = "/VO/Odysseus_0706",
					Portrait = "Portrait_Odysseus_Default_01", Speaker = "NPC_Odysseus_01",
					PreLineAnim = "Odysseus_Explaining",
					PreLineAnimTarget = 557112,
					Text = "The use was to find where you belonged. If you never left, you would have always wondered what else was out there for you. You returned with the wisdom of that experience." },

				{ Cue = "/VO/Icarus_0468",
					PreLineAnim = "Icarus_Salute",
					Text = "So the more we wander, the wiser we get, hey? Except I'm speaking to the Great Tactician. I hardly think I've learned more flying about out {#Emph}there {#Prev}than I could have from {#Emph}you." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.3,
						ObjectType = "NPC_Odysseus_01",
						{ Cue = "/VO/Odysseus_0707", Text = "I'll take the wings if you don't want them, lad." },
					},
					{
						PreLineWait = 0.25,
						ObjectType = "NPC_Icarus_01",
						PostLineFunctionName = "IcarusHubExitPresentation",
						{ Cue = "/VO/Icarus_0469", Text = "No chance, sir!" },
					},
				},
			},

			IcarusWithEris01 =
			{
				Partner = "NPC_Eris_01",
				PlayOnce = true,
				UseText = "UseListenNPC",
				UseableOffSource = true,
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				SkipPreEventFunction = true,
				-- StatusAnimation = false,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				TeleportToId = 590426,
				AngleTowardTargetId = 585573,
				InteractDistance = 450,

				{ Cue = "/VO/Icarus_0470",
					PreLineWait = 0.35,
					PreLineAnim = "Icarus_Flustered_Start",
					PostLineAnim = "Icarus_Flustered_End",
					Text = "...I was just, {#Emph}eh{#Prev}, picking up a bit. Didn't mean to bother you, Goddess, {#Emph}erm... {#Prev}Hey! I like your wings! Mine aren't real. Though, I had an earlier pair made with real feathers, more like yours... but not nearly as good." },

				{ Cue = "/VO/Eris_0363", Source = "NPC_Eris_01",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Enemy_Eris_Hub_Scoff", PreLineAnimTarget = 585573,
					Text = "How 'bout next time you see my stuff, you leave it be, all right there, baby bird? Now get out of my face and don't go tripping on your tongue on your way up!" },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.25,
						ObjectType = "NPC_Icarus_01",
						PostLineFunctionName = "IcarusHubExitPresentation",

						{ Cue = "/VO/Icarus_0471", Text = "Sounds good! I'm off. {#Emph}Goodbye!" },
					},
					{
						PreLineWait = 0.35,
						ObjectType = "NPC_Eris_01",
						PostLineFunctionName = "ErisExitPresentation",
						{ Cue = "/VO/Eris_0364", Text = "Bye now!" },
					}
				},
			},

			IcarusWithHecate01 =
			{
				Partner = "NPC_Hecate_01",
				PlayOnce = true,
				UseText = "UseListenNPC",
				PreBlockSpecialInteract = true,
				PostBlockSpecialInteract = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				SkipPreEventFunction = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 6,
					},
				},
				-- StatusAnimation = false,
				BlockDistanceTriggers = true,
				IgnoreSourceEndTextLinesThreadedFunctionName = true,
				UseableOffSource = true,
				TeleportToId = 566613,
				AngleTowardTargetId = 556921,
				InteractDistance = 450,

				{ Cue = "/VO/Icarus_0475",
					PreLineWait = 0.35,
					Text = "...Also, I wanted to give thanks to you, Madam. For taking me in and letting me return; and for entrusting anything to me! Most Shades are not so fortunate." },

				{ Cue = "/VO/Hecate_0877", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					PreLineAnim = "Hecate_Hub_Scoff", PreLineAnimTarget = 556921,
					Text = "{#Emph}Oh{#Prev}, do not grovel, Icarus, lest I cast you out. These are the Crossroads, not Elysium! A Shade's existence here may be comparatively difficult... and few remain for long." },

				{ Cue = "/VO/Icarus_0476",
					PreLineAnim = "Icarus_Explaining_Start",
					PostLineAnim = "Icarus_Explaining_End",
					Text = "I appreciate having the work to do, and being a part of this. Although, sometimes just after taking off, I fear I won't be able to find my way back..." },

				{ Cue = "/VO/Hecate_0878", Portrait = "Portrait_Hec_Default_01", Speaker = "NPC_Hecate_01",
					PreLineAnim = "Hecate_Hub_Affirm", PreLineAnimTarget = 556921,
					Text = "Discard that fear. Those with the need or who remain in our good graces always shall be welcome here and safe." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.25,
						ObjectType = "NPC_Icarus_01",
						PostLineFunctionName = "IcarusHubExitPresentation",

						{ Cue = "/VO/Icarus_0477", Text = "I'm grateful. And, I'll be going! Cheers, Madam!" },
					},
				},
			},

			MorosWithIcarus01 =
			{
				Partner = "NPC_Moros_01",
				AngleTowardTargetId = 743557,
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},
			NemesisWithIcarus01 =
			{
				Partner = "NPC_Nemesis_01",
				AngleTowardTargetId = 743557,
				PlayOnce = true,
				StatusAnimation = false,
				UseableOffSource = true,
				CopyDataFromPartner = true,
			},

			-- repeatable
			IcarusHomeChat01 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0182",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "Nice seeing you again, Meli. I'm taking off, though I'll be sure to keep an eye out for you up there." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat02 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0183",
					Text = "If you decide to head up to the surface tonight, maybe I'll see you, hey?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat03 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0184",
					Text = "Cheers to you all for welcoming me back, and always nice to see {#Emph}you {#Prev}here." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat04 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0185",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "Time to get back into the fight, hey Meli? I'll go on ahead and see what I can do." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat05 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0186",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "At least I'm getting better at my landings and takeoffs here. Want to see?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat06 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0258",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "I had to stop in for additional supplies, and possibly to say hello. And now I'm off!" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat07 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "IcarusHomeFirstMeeting", "IcarusAboutDaedalus02" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0259",
					Text = "Be on the lookout for my Hammers out there, hey? I hope they've been of help." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat08 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0260",
					Text = "I know it's not the time to chat for long, though even just a little like this helps." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat09 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0261",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "Just finished patching up these wings! And now to put them to the test again." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat10 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0262",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "It's funny, I start getting restless whenever I'm not putting these wings to good use." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat11 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0263",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "Wanted to say hello before I took off for the night. Take care then, hey?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat12 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
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
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0264",
					Text = "I knew you'd get there last night, and think you'll make it all the way this time too." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat13 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "BiomesReached" },
						HasAny = { "F" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0265",
					Text = "Maybe I'll see you out there on the Rift tonight, unless you're sticking to the Underworld?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat14 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Odysseus_01", }, Alive = true },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0266",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "Done my debrief with Master Odysseus so I'd best be heading back out there." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat15 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0267",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "Let's see if I can dodge every last branch up there on my way out then, hey?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat16 =
			{
				UseableOffSource = true,
				GiftableOffSource = true,
				PostBlockSpecialInteract = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0482",
					PostLineThreadedFunctionName = "IcarusHubExitPresentation",
					Text = "Always good to see you here, and maybe I'll see you up top tonight too, hey?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat17 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0483",
					Text = "Seems like everything's been going all right over here. Especially by this fountain." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat18 =
			{
				PlayFirst = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						SumPrevRuns = 4,
						Path = { "EncountersOccurredCache" },
						TableValuesToCount = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
						Comparison = "<=",
						Value = 0,
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0484",
					Text = "Was hoping you'd stop by and say hello. See you again out there one of these nights?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat19 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasNone = { "IcarusCombatO", "IcarusCombatO2", "IcarusCombatP", "IcarusCombatP2" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0485",
					Text = "Missed you out there on the Rift last night, though glad to see you here." },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
			IcarusHomeChat20 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusHomeFirstMeeting" },
					},
					{
						PathTrue = { "CurrentRun", "Cleared" },
					},
				},
				OnQueuedFunctionName = "CheckDistanceTriggerThread",
				OnQueuedFunctionArgs = PresetEventArgs.IcarusGreeting,

				{ Cue = "/VO/Icarus_0486",
					Text = "Heard you did great last night, well done, Meli! Off for another go already, then?" },
				EndGlobalVoiceLines = "MiscEndVoiceLines_Icarus",
			},
		},
	},
}

-- Global Icarus Lines
GlobalVoiceLines.IcarusGatherReactionVoiceLines =
{
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Icarus_01",
		-- SkipCooldownCheckIfNonePlayed = true,
		GameStateRequirements =
		{
			{
				PathEmpty = { "RequiredKillEnemies" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},
		Cooldowns =
		{
			{ Name = "IcarusAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/Icarus_0294", Text = "Didn't notice that." },
		{ Cue = "/VO/Icarus_0295", Text = "More reagents?" },
		{ Cue = "/VO/Icarus_0296", Text = "All yours." },
		{ Cue = "/VO/Icarus_0297", Text = "Anything good?" },
		{ Cue = "/VO/Icarus_0537", Text = "I see it!" },
	},
	{
		RandomRemaining = true,
		BreakIfPlayed = true,
		PreLineWait = 0.65,
		SuccessiveChanceToPlay = 0.5,
		SuccessiveChanceToPlayAll = 0.5,
		ObjectType = "NPC_Icarus_01",
		-- SkipCooldownCheckIfNonePlayed = true,
		GameStateRequirements =
		{
			{
				PathNotEmpty = { "RequiredKillEnemies" },
			},
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},
		Cooldowns =
		{
			{ Name = "IcarusAnyQuipSpeech", Time = 10 },
		},

		{ Cue = "/VO/Icarus_0290", Text = "Found something?" },
		{ Cue = "/VO/Icarus_0291", Text = "Got what you need?" },
		{ Cue = "/VO/Icarus_0292", Text = "Loot from the field!" },
		{ Cue = "/VO/Icarus_0293", Text = "Got you covered!" },
	},
}
GlobalVoiceLines.IcarusExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	SuccessiveChanceToPlayAll = 0.25,
	ObjectType = "NPC_Icarus_01",
	Cooldowns =
	{
		{ Name = "IcarusSpokeRecently", Time = 4 },
	},

	{ Cue = "/VO/Icarus_0516", Text = "Off to the Crossroads." },
	{ Cue = "/VO/Icarus_0517", Text = "Found us a smart one!", PlayFirst = true },
	{ Cue = "/VO/Icarus_0518", Text = "A new recruit." },
	{ Cue = "/VO/Icarus_0519", Text = "So {#Emph}that's {#Prev}how you do it." },
}

GlobalVoiceLines.IcarusFishCaughtReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.85,
	Queue = "Interrupt",
	ObjectType = "NPC_Icarus_01",
	AllowTalkOverTextLines = true,
	GameStateRequirements =
	{
		OrRequirements =
		{
			{
				{
					Path = { "CurrentRun", "TextLinesRecord", },
					HasAny = { "IcarusFishing01" },
				},
				{
					PathTrue = { "CurrentRun", "Hero", "IsDead" },
				},
			},
			{
				{
					PathFalse = { "CurrentRun", "Hero", "IsDead" },
				},
			},
		},
	},
	Cooldowns =
	{
		{ Name = "IcarusAnyQuipSpeech", Time = 4 },
	},

	{ Cue = "/VO/Icarus_0220", Text = "Oh {#Emph}wow!" },
	{ Cue = "/VO/Icarus_0221", Text = "Caught!" },
	-- { Cue = "/VO/Icarus_0222", Text = "A bite!" },
	{ Cue = "/VO/Icarus_0223", Text = "What {#Emph}is {#Prev}that thing?" },
	{ Cue = "/VO/Icarus_0224", Text = "{#Emph}Nice {#Prev}one!", PlayFirst = true },
	{ Cue = "/VO/Icarus_0225", Text = "Well done." },
	{ Cue = "/VO/Icarus_0226", Text = "Sure is something..." },
	{ Cue = "/VO/Icarus_0227", Text = "Victory!" },
	{ Cue = "/VO/Icarus_0228", Text = "Success!" },
}

GlobalVoiceLines.IcarusReRollReactionVoiceLines =
{
	BreakIfPlayed = true,
	RandomRemaining = true,
	PreLineWait = 0.5,
	ObjectType = "NPC_Icarus_01",

	{ Cue = "/VO/Artemis_0371", Text = "How about these?", PlayFirst = true },
}

GlobalVoiceLines.IcarusDeathReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 1.25,
	NoTarget = true,
	Source = { LineHistoryName = "NPC_Icarus_01", SubtitleColor = Color.IcarusVoice },

	{ Cue = "/VO/Icarus_0493", Text = "Meli, what happened? Don't go...!", PlayFirst = true },
	{ Cue = "/VO/Icarus_0494", Text = "She's gone? She's gone, she's... {#Emph}augh..." },
	{ Cue = "/VO/Icarus_0556", Text = "{#Emph}Ah {#Prev}damn it, Meli, {#Emph}no! {#Prev}Come back!" },
	{ Cue = "/VO/Icarus_0557", Text = "What happened to you there, where did you go?" },
}

GlobalVoiceLines.MiscEndVoiceLines_Icarus =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		ObjectType = "NPC_Icarus_01",
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "Hero", "IsDead" }
			},
		},

		{ Cue = "/VO/Icarus_0053", Text = "Let me know how it goes!" },
		{ Cue = "/VO/Icarus_0054", Text = "You won't be disappointed.", PlayFirst = true },
		{ Cue = "/VO/Icarus_0055", Text = "Good choice." },
		{ Cue = "/VO/Icarus_0056", Text = "Here you go." },
		{ Cue = "/VO/Icarus_0059", Text = "Careful, OK?" },
		{ Cue = "/VO/Icarus_0060", Text = "How did I know...?" },
		{ Cue = "/VO/Icarus_0109", Text = "All yours." },
		{ Cue = "/VO/Icarus_0110", Text = "Hope it helps." },
		{ Cue = "/VO/Icarus_0111", Text = "{#Emph}Ah{#Prev}, yes." },
		{ Cue = "/VO/Icarus_0526", Text = "You're all set!" },
		{ Cue = "/VO/Icarus_0527", Text = "Good idea." },
		{ Cue = "/VO/Icarus_0541", Text = "Got it!" },
		{ Cue = "/VO/Icarus_0538", Text = "Aye-aye!" },
		{ Cue = "/VO/Icarus_0539", Text = "Yes ma'am!" },
		{ Cue = "/VO/Icarus_0524", Text = "Careful with that.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "CastHazardBoon" },
				},
			},
		},
		{ Cue = "/VO/Icarus_0525", Text = "Watch out with this.", PlayFirst = true,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "CastHazardBoon" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.15,
		AllowTalkOverTextLines = true,

		-- { Cue = "/VO/MelinoeField_0255", Text = "I'm grateful, milady." },
		-- { Cue = "/VO/MelinoeField_0256", Text = "Night protect us...", PlayFirst = true },
	},
	{ GlobalVoiceLines = "ThankingIcarusVoiceLines" },
	-- [4] = { GlobalVoiceLines = "MedeaIncantationLines" },
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Icarus )
OverwriteTableKeys( NPCVariantData, VariantSetData.NPC_Icarus_01 )