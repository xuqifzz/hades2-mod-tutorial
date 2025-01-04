UnitSetData.NPC_Dionysus =
{
	-- Dionysus, Id = TKTK
	NPC_Dionysus_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		
		OnUsedFunctionName = "UseLoot",
		OnUsedFunctionArgs = { SkipInteractAnim = true, SkipSound = true, ResetUseText = true, PackageName = "NPC_Dionysus_01" },

		Portrait = "Portrait_Dionysus_Default_01",
		AnimOffsetZ = 50,
		Groups = { "NPCs" },
		SpeakerName = "Dionysus",
		SubtitleColor = Color.DionysusVoice,
		EmoteOffsetY = -320,
		EmoteOffsetX = -30,
		TreatAsGodLootByShops = true,
		RequiredRoomInteraction = true,

		ActivateRequirements =
		{
			-- None
		},
		InvincibubbleScale = 1.5,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		RepulseOnMeleeInvulnerableHit = 5,
		-- TurnInPlaceAnimation = "Dionysus_Turn",

		UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		NarrativeContextArt = "DialogueBackground_Olympus_Silent",
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},
		NarrativeContextArtFlippable = false,

		MenuTitle = "UpgradeChoiceMenu_Dionysus",
		UpgradeScreenOpenFunctionName = "DionysusChoiceScreenPresentation",
		UpgradeScreenOpenSound = "/SFX/DionysusBoonWineLaugh",
		UpgradeSelectedSound = "/SFX/DionysusBoonChoice",
		PackageName = "NPC_Dionysus_01",
		Icon = "BoonSymbolDionysusIcon",
		LightingColor = {200, 0, 255, 255},
		Traits = 
		{
			"CastLobBoon",
			"HiddenMaxHealthBoon",
			"FirstHangoverBoon",
			"CombatEncounterHealBoon",
			-- "RandomDuoBoon",
			"PowerDrinkBoon",
			"FogDamageBonusBoon",
		},
		FlavorTextIds =
		{
			"DionysusUpgrade_FlavorText01",
			"DionysusUpgrade_FlavorText02",
			"DionysusUpgrade_FlavorText03",
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.85,
				UsePlayerSource = true,
				SkipAnim = true,
				AllowTalkOverTextLines = true,

				{ Cue = "/VO/MelinoeField_2392", Text = "I already have plans this evening, sorry...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "DionysusAboutFeast03" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2400", Text = "He's great, I'm sure...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "DionysusAboutZagreus02" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2897", Text = "...I'm going to have to pass.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "DionysusLowHealth01" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2900", Text = "...Yeah.",
					PreLineWait = 0.9,
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "DionysusAboutAutomatons01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_0601", Text = "No, I... {#Emph}ugh.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "DionysusAboutPrometheus01" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1308", Text = "We'll see.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "TextLinesRecord", "DionysusAboutPrometheus02" },
						},
					},
				},
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Dionysus_01", SubtitleColor = Color.DionysusVoice },
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					--
				},
				
				{ Cue = "/VO/Dionysus_0084", Text = "Get a load of these.", PlayFirst = true },
				{ Cue = "/VO/Dionysus_0075", Text = "Let's see here..." },
				{ Cue = "/VO/Dionysus_0076", Text = "What have we got..." },
				{ Cue = "/VO/Dionysus_0077", Text = "Got just the thing..." },
				{ Cue = "/VO/Dionysus_0078", Text = "Got what you need..." },
				{ Cue = "/VO/Dionysus_0079", Text = "Any of these?" },
				{ Cue = "/VO/Dionysus_0080", Text = "How 'bout one of these?" },
				{ Cue = "/VO/Dionysus_0081", Text = "Our specials this eve." },
				{ Cue = "/VO/Dionysus_0082", Text = "What do you feel like?" },
				{ Cue = "/VO/Dionysus_0083", Text = "One of these?" },
			},
			[2] = { GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Dionysus_01" },
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
				PlayOnceThisRun = true,
				SuccessiveChanceToPlayAll = 0.25,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_2576_B", Text = "You're a most-gracious host." },
				{ Cue = "/VO/MelinoeField_2577", Text = "Happy feasting, my lord." },
			},
			[2] = { GlobalVoiceLines = "SaluteVoiceLines" },
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Dionysus_01",
				PreLineAnim = "Dionysus_Blessing",
				-- PreLineAnim = "Dionysus_Shrug",
				-- PreLineAnim = "Dionysus_Greeting",

				{ Cue = "/VO/Dionysus_0123", Text = "Heeey.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Dionysus_0124", Text = "Heeey!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Dionysus_0125", Text = "What is up?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Dionysus_0126", Text = "Cheers!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703", "/VO/MelinoeField_2576", "/VO/MelinoeField_2577", },
						},
					},
				},
				{ Cue = "/VO/Dionysus_0127", Text = "Oh I'm not going anywhere.",
					PreLineAnim = "Dionysus_Shrug",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Dionysus_0128", Text = "Absolutely.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/MelinoeField_2576" },
						},
					},
				},
				{ Cue = "/VO/Dionysus_0129", Text = "You are something else.",
					PreLineAnim = "Dionysus_Shrug",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Dionysus_0132", Text = "...What was that?", PreLineAnim = "Dionysus_Idle" },
				{ Cue = "/VO/Dionysus_0130", Text = "You're pretty cool." },
				{ Cue = "/VO/Dionysus_0131", Text = "Yeah!!" },
			}
		},

		InteractTextLineSets =
		{
			DionysusFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0002",
					-- PreLineAnim = "Dionysus_Greeting",
					-- PreLineAnim = "Dionysus_Eager",
					-- PreLineAnim = "Dionysus_Shrug",
					-- PreLineAnim = "Dionysus_Blessing",
					-- PreLineAnim = "Dionysus_Laugh",
					-- PreLineAnim = "Dionysus_Surprise",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Eager",
					Text = "Now who is {#Emph}this{#Prev}, what sort of Nymph do we have here? Not from the waters nor the woods, but wait wait {#Emph}wait! {#Prev}Those {#Emph}eyes! {#Prev}Zag, man, is that {#Emph}you?! {#Prev}You've {#Emph}changed! {#Prev}I like it!" },
				{ Cue = "/VO/MelinoeField_2386", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Dionysus, I presume? I'm Melinoë, sister to Zagreus. I've come to the mountain's aid at the family's behest! But, what is the meaning of this festivity? Aren't you at war?" },
				{ Cue = "/VO/Dionysus_0003",
					PreLineAnim = "Dionysus_Shrug",
					Text = "{#Emph}Ohhh, Mel{#Prev}, right, the others mentioned you. {#Emph}Erm{#Prev}, listen baby, I'm into {#Emph}lots {#Prev}of different things, but war just isn't one of them. What's the use, we gods can't die! But we can {#Emph}live!" },
				{ Cue = "/VO/MelinoeField_2387", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your mountain is under siege. Chronos took my side of the family, and soon he may take yours!" },
				{ Cue = "/VO/Dionysus_0004",
					Text = "All the more reason to raise a cup while we still can, yeah? {#Emph}Heh. {#Prev}Though I get it! Not your thing. But why not have a little pick-me-up for the road ahead?" },
			},

			DionysusAboutFeast01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0143",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Eager",
					Text = "Heeey, look who decided to reconsider coming to our little gathering! Welcome back, Mel baby, now go on, you grab yourself a cup and mingle with the crowd!" },
				{ Cue = "/VO/MelinoeField_2388", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "As tempting as that sounds, Lord Dionysus, unfortunately I don't think I can. There are various perils beyond, and your fellow Olympians can only do so much to hold them off." },
				{ Cue = "/VO/Dionysus_0144",
					PreLineAnim = "Dionysus_Shrug",
					Text = "And I feel bad for them, really! Almighty gods with limitless power having to fend for themselves. Good thing I can drown my sorrows here, and guess what? So can you!" },
			},

			DionysusAboutFeast02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0145",
					PreLineAnim = "Dionysus_Shrug",
					Text = "You really are just passing through? Look at all these temptations in every form! The liquid kind, the sumptuous kind, {#Emph}mm! {#Prev}But you're unmoved and undeterred?" },
				{ Cue = "/VO/MelinoeField_2389", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Look, I... would truly love to stay. Enjoy a beverage and a bite, speak with all these doubtless-interesting guests. But I can't. Don't you understand? Your mountain is burning!" },
				{ Cue = "/VO/Dionysus_0146",
					PreLineAnim = "Dionysus_Laugh",
					Text = "Well if it's burning, baby, let it burn, I say! But I don't want to argue anymore, I mean, it's just another form of fighting, yeah? So you go do your thing, and I'll do mine!" },
			},
			DionysusAboutFeast03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2391", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lord Dionysus, just how long have you been feasting, anyhow? Here in this spot, I mean. Night after night, you're going at it like there's no tomorrow." },
				{ Cue = "/VO/Dionysus_0149",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Mel baby, just call me Dionysus if you please, the Lord thing doesn't suit me, yeah? As for how long we've carried on like this, I've no idea! A while probably. Might be a new record! {#Emph}Heh. {#Prev}Sure you don't want to join?" },
			},
			DionysusAboutFeast04 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2393", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What if you couldn't feast any longer? Imagine something so dire that it forced you to put a stop to this way of life. Brought ruin to everything you hold dear!" },
				{ Cue = "/VO/Dionysus_0150",
					PreLineAnim = "Dionysus_Shrug",
					Text = "I know what you're trying to do, baby, and it isn't going to work. I've tuned out {#Emph}every {#Prev}bit of negativity, including yours! And since I'm a good host, I'm {#Emph}still {#Prev}going to give you {#Emph}this." },
			},
			DionysusAboutFeast05 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2394", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "What's the occasion for the feasting, anyway? I fail to see what cause there is to celebrate right now." },
				{ Cue = "/VO/Dionysus_0151",
					PreLineAnim = "Dionysus_Eager",
					Text = "Don't you get it, baby? Every moment that we live and breathe is more than cause enough! Maybe you're into feeling bad, I don't know, but me? I'm into feeling {#Emph}good!" },
			},

			DionysusLowHealth01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				-- PreEventFunctionName = "AngleNPCToHero",
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "DionysusGift01" }
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Story01" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0157",
					Emote = "PortraitEmoteDepressed",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Mel baby, you look like hell if you don't mind me saying, I mean what did you fall down the mountainside on your way here? Care to wash up?" },
				{ Cue = "/VO/MelinoeField_2896", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Please pardon my disheveled state. I had to cross a doomed city of the risen dead, infiltrate an enemy armada, and climb halfway to the Palace of Zeus to get here." },
				{ Cue = "/VO/Dionysus_0158",
					Text = "No excuses! Now either get out of that positively ripe dress you've got on and make like all my other guests, or move along! We enforce a strict code of attire." },
			},

			DionysusAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "SkipEncounterKeepsake" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0170",
					Emote = "PortraitEmoteDepressed",
					Text = "That Fig Leaf that you're carrying... it's from my {#Emph}private wardrobe! {#Prev}So how come you have it and not me? What, did I just hand it over as a gift?" },
				{ Cue = "/VO/MelinoeField_2901", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You did exactly that, yes. I offered you a bottle of Nectar, and you gave me this Leaf in exchange. Don't you recall?" },
				{ Cue = "/VO/Dionysus_0171",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Don't I recall... {#Emph}erm{#Prev}, sometimes! But not always, not so much of late! Well if past-me thought he should give you such a thing, he must have had a real good feeling for you, yeah?" },
			},
			DionysusAboutFrogFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0172",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Dionysus_Surprise",
					Text = "What's that with you, some sort of {#Emph}frog? {#Prev}Well sure, since frogs and me, we go way back! The only rule is there's no swimming in the spring or guests might get a little {#Emph}eugh!" },
				{ Cue = "/VO/MelinoeField_2911", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's Frinos, and don't worry, not that you ever do. He won't disturb the peace, and avoids most others anyway. Thank you for permitting him here... and me, for that matter." },
				{ Cue = "/VO/Dionysus_0173",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Oh absolutely, it's the sort of feast where if you can get in at all, it means you're probably all right! Your frog there too, long as he doesn't sing! He doesn't sing, does he...?" },
			},

			DionysusAboutAutomatons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DionysusGift01" }
					},
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_MiniBoss01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2898", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you run into any trouble with all the Automatons supposedly defending your domain? They attack me indiscriminately from your foes." },
				{ Cue = "/VO/Dionysus_0193",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Maybe they think you're too uptight! Come on Mel baby, you don't need to worry about us! I've got my special ways, which not even the works of Lord Hephaestus can resist." },
				{ Cue = "/VO/MelinoeField_2899", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your special ways... so then you know a means to bypass their threat detection. Can you show me how?" },
				{ Cue = "/VO/Dionysus_0194",
					PreLineAnim = "Dionysus_Laugh",
					Text = "Oh I can show you {#Emph}lots {#Prev}of things. Those clankers you're still on about, they're just like family! Sure, they fight sometimes, but they mean well. Just stay out of their way, yeah?" },
			},

			DionysusAboutSprings01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeBathHouse" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "DoraBathHouse01", "HecateBathHouse01", "OdysseusBathHouse01", "MorosBathHous01", "NemesisBathHouse01", "ErisBathHouse01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0159",
					Emote = "PortraitEmoteCheerful",
					Text = "Sure you don't want to join us for a soak in the spring? It's cold out, yeah, but not in there! Forge of Hephaestus pumping in {#Emph}just {#Prev}the right amount of heat!" },
				{ Cue = "/VO/MelinoeField_2907", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We have a spring like this where I reside! It's very comfortable... except, I really shouldn't bathe right now. For a variety of reasons." },
				{ Cue = "/VO/Dionysus_0160",
					PreLineAnim = "Dionysus_Eager",
					Emote = "PortraitEmoteSparkly",
					Text = "And yet you keep on showing up! Come {#Emph}on {#Prev}Mel baby, you want in, no need to be shy, we're friends here, {#Emph}all {#Prev}of us! Some {#Emph}more {#Prev}than friends even! {#Emph}Heh! {#Prev}All in due time I guess?" },
			},

			DionysusAboutTravels01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2908", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "My headmistress was a wanderer like you. She taught me something of your journeys and travails. You've crossed the world... met many different beings! Yet you'd rather be here, like this?" },
				{ Cue = "/VO/Dionysus_0161",
					PreLineAnim = "Dionysus_Laugh",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Haha, oh {#Prev}absolutely, {#Emph}yes! {#Prev}I mean just look around you, {#Emph}everybody's {#Prev}beautiful, the weather's perfect, and we're fully stocked! What, you think I'd rather be out for a stroll?" },
				{ Cue = "/VO/MelinoeField_2909", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, I... merely thought a life of travel might have made your disposition somewhat different! I don't know... more introspective? More solitary, perhaps." },
				{ Cue = "/VO/Dionysus_0162",
					Emote = "PortraitEmoteSparkly",
					PreLineAnim = "Dionysus_Shrug",
					Text = "You're still young, baby! If you'd seen all I'd seen then you'd appreciate the finer things the same as me. No forcing it! You'll get there, maybe once all of this is over with!" },
			},

			DionysusAboutSatyrs01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2910", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I must admit I'm unaccustomed to seeing Satyrs that make no attempt to skewer me on sight. Old friends of yours?" },
				{ Cue = "/VO/Dionysus_0163",
					PreLineAnim = "Dionysus_Shrug",
					Emote = "PortraitEmoteSparkly",
					Text = "Oh yeah, all these old goats and I, we go {#Emph}way {#Prev}back! Proper Satyrs that love a proper good time. As for everything else, they just don't pay it any mind. And neither do I!" },
			},

			DionysusAboutMortals01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0174",
					PreLineAnim = "Dionysus_Shrug",
					Text = "You're not from around here, so how fare the mortals as of late? You've surely seen a few of them along your path. It's been a little while since I heard from them!" },
				{ Cue = "/VO/MelinoeField_2912", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They've been better! Most probably are praying to our family for peace, since Chronos flung open the Underworld's gates, leaving the dead to roam the land." },
				{ Cue = "/VO/Dionysus_0175",
					PreLineAnim = "Dionysus_Laugh",
					Emote = "PortraitEmoteSparkly",
					Text = "Which means that mortals get to spend more time with long-lost relatives of theirs! Come on, stay {#Emph}positive{#Prev}, Mel baby! That's how mortals get by! It'll be all right!" },
			},

			DionysusAboutOlympians01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0147",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Not told my Dad about this little gathering of ours, have you? Because we wouldn't want to have to pack it up and find some other secret spot. It's perfect here!" },
				{ Cue = "/VO/MelinoeField_2390", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I think Lord Zeus has far more urgent matters to consider than your never-ending feast, which I daresay would be even better if the legions of Chronos weren't about. The rest of the Olympians don't even know that this is going on?" },
				{ Cue = "/VO/Dionysus_0148",
					PreLineAnim = "Dionysus_Laugh",
					Text = "Right you are, baby! For this is an {#Emph}exclusive {#Prev}gathering only for guests I know are going to be cool. Which can't explain how you keep stumbling upon it, but hey! Details, right?" },
			},

			DionysusAboutZagreus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						-- @ update with additional requirements
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0154",
					PreLineAnim = "Dionysus_Blessing",
					Text = "What did you say happened to Zag, everything good with him still, yeah? You ought to bring him next you come this way, oh he'd be {#Emph}into {#Prev}it!" },
				{ Cue = "/VO/MelinoeField_2398", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I previously mentioned Chronos, our Titan grandfather who's relentlessly attacking this mountain, holds the members of my immediate family captive; Zagreus included. So he can't make it to the feast right now." },
				{ Cue = "/VO/Dionysus_0155",
					PreLineAnim = "Dionysus_Shrug",
					Text = "{#Emph}Ah {#Prev}that's too bad, though maybe later, yeah? I've always felt a bond with him, a real connection, so if you see the Zag man, let him know he's welcome to my feast here {#Emph}anytime!" },
			},
			DionysusAboutZagreus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						-- @ update with additional requirements
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2399", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Sounds as though you and my brother Zagreus were fairly close. What was he like? Seeing as I have no real memory of him, since Chronos took him back when I was very small." },
				{ Cue = "/VO/Dionysus_0156",
					PreLineAnim = "Dionysus_Shrug",
					Text = "You know I haven't heard from him in quite a while, yeah? {#Emph}Erm{#Prev}, come to think of it, we never really talked too much, although I sent him lots of Boons! How is he anyway?" },
			},

			DionysusAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" }
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2902", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you had any run-ins with Prometheus? Since Chronos wouldn't dare show his face on this mountain, he must have sent this lackey of his to keep all of Olympus occupied." },
				{ Cue = "/VO/Dionysus_0164",
					PreLineWait = 0.1,
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Dionysus_Surprise",
					Text = "{#Emph}Prometheus{#Prev}, he's {#Emph}back?! {#Prev}I must be out of the loop. Thought he was still strapped to some mountainside, getting his innards gnawed at by an Eagle, something nasty of the sort!" },
				{ Cue = "/VO/MelinoeField_2903", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That did supposedly occur. But he is definitely back, personally leading the vanguard trying to tear Olympus apart. If he prevails... no more feasting." },
				{ Cue = "/VO/Dionysus_0165",
					PreLineAnim = "Dionysus_Laugh",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Hahahaha{#Prev}, come on, baby, it can't be {#Emph}all {#Prev}that bad! What's he going to do, cook our food with the flame he took from Dad? Tell you what, next time you see him, tell him to stop by!" },
			},
			DionysusAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "DionysusAboutPrometheus01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0166",
					Text = "So did you have a chat with old Prometheus on my behalf or what? I'd go on over and invite him here myself, but I'm the host, {#Emph}heh! {#Prev}It wouldn't do for me to slip away, would it?" },
				{ Cue = "/VO/MelinoeField_2904", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of all the things for you to vividly recall. You truly wanted me to direct one of our most bitter foes {#Emph}here{#Prev}, to a feast not even your closest family members know about?" },
				{ Cue = "/VO/Dionysus_0167",
					PreLineAnim = "Dionysus_Shrug",
					Text = "I mean... {#Emph}yeah, heh! {#Prev}We gods can be so stubborn and stuck up, waving our weapons at each other when we ought to wave an olive branch instead! Now you go tell that hothead that we're saving him a spot!" },
			},
			DionysusAboutPrometheus03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PrometheusAboutDionysus02" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/MelinoeField_2905", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I felt quite foolish, but did ask Prometheus on your behalf if he'd attend this feast. He already knew what I was going to say, being the Titan of Foresight and all. He sensed no ill motive... and took it for a fiendish trap for that very reason." },
				{ Cue = "/VO/Dionysus_0168",
					Text = "And he's supposed to be one of the wiser ones? What made you all so {#Emph}cynical{#Prev}, baby? You don't trust anyone or any{#Emph}thing! {#Prev}No wonder everything is all screwed up out there!" },
				{ Cue = "/VO/MelinoeField_2906", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkFlustered01", PreLineAnimTarget = "Hero",
					Text = "So you {#Emph}do {#Prev}know things are dire! I thought you weren't paying any attention, burying your head in the sand and tuning out whatever you've no wish to hear." },
				{ Cue = "/VO/Dionysus_0169",
					PreLineAnim = "Dionysus_Shrug",
					Text = "You got it half right. See, I don't like to worry about the things I can't control! {#Emph}Wine{#Prev}, I can control. The quality of this feast, I {#Emph}can {#Prev}control! But all the in-fighting? {#Emph}Heh. {#Prev}Plenty of other gods who specialize in {#Emph}that." },
			},

			-- Repeatable
			DionysusChat01 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0006",
					PreLineAnim = "Dionysus_Eager",
					Text = "Things are happening all over but this is the only happening place on {#Emph}this {#Prev}mountain, baby." },
			},
			DionysusChat02 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0007",
					PreLineAnim = "Dionysus_Eager",
					Text = "Just one drink isn't going to hurt! It's going to do the {#Emph}opposite{#Prev}, you'll see!" },
			},
			DionysusChat03 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0008",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Can't stay and hang out, you got places to go, people to see, I get it, baby!" },
			},
			DionysusChat04 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0009",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Laugh",
					Text = "You look like you're having a night! And wouldn't you know it, so am {#Emph}I!" },
			},
			DionysusChat05 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0010",
					PreLineAnim = "Dionysus_Laugh",
					Text = "Been going for a while here, baby, and we plan to {#Emph}keep {#Prev}going till all this is over!" },
			},
			DionysusChat06 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0011",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Eager",
					Text = "Come on now, relax and have a drink, {#Emph}mingle {#Prev}a bit, this is a {#Emph}feast{#Prev}, you know!" },
			},
			DionysusChat07 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0012",
					Text = "Remember, don't go telling Dad about this little gathering of ours, all right?" },
			},
			DionysusChat08 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0013",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Shrug",
					Text = "You're always welcome here but not your worries, baby, you leave those behind!" },
			},
			DionysusChat09 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0014",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Eager",
					Text = "Hey, pull yourself together, baby, we're just getting started!" },
			},
			DionysusChat10 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0015",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Eager",
					Text = "Sure you don't want to take a quick dip in the spring? It'll warm you right up!" },
			},
			DionysusChat11 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0016",
					PreLineAnim = "Dionysus_Shrug",
					Text = "This mountain isn't going anywhere, and neither are we!" },
			},
			DionysusChat12 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0017",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Come all this way and can't even hang out, that's just not right, baby!" },
			},
			DionysusChat13 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0018",
					PreLineAnim = "Dionysus_Laugh",
					Text = "If you're sick of all the fighting, I've got {#Emph}just {#Prev}the thing for you!" },
			},
			DionysusChat14 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0019",
					PreLineAnim = "Dionysus_Shrug",
					Text = "The water's nice and warm, but if you don't want to take a dip, it's cool!" },
			},
			DionysusChat15 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0020",
					PreLineAnim = "Dionysus_Shrug",
					Text = "I'd ask you tell the fam I told them cheers but that might get a little awkward, yeah?" },
			},
			DionysusChat16 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0021",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Dionysus_Eager",
					Text = "Leave your worries at the gate and have yourself a cup of something, {#Emph}here!" },
			},
			DionysusChat17 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0022",
					PreLineAnim = "Dionysus_Eager",
					Text = "Know that all of us are with you {#Emph}all {#Prev}the way, so cheers to your success!" },
			},
			DionysusChat18 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0023",
					PreLineAnim = "Dionysus_Eager",
					Text = "Take it from me, there is {#Emph}never {#Prev}a bad time for a good feast!" },
			},
			DionysusChat19 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Story01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0024",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Dionysus_Surprise",
					Text = "Wait wait wait weren't you just here? It's all a blur for me!" },
			},
			DionysusChat20 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0025",
					PreLineAnim = "Dionysus_Shrug",
					Text = "No use fighting the inevitable when you're thirsty, yeah?" },
			},
			DionysusChat21 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0026",
					PreLineAnim = "Dionysus_Eager",
					Text = "Take a load off, relax, have a drink and all that! The night's still young!" },
			},
			DionysusChat22 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0027",
					PreLineAnim = "Dionysus_Eager",
					Text = "Well don't just stand there, eat! Drink! Whatever you fancy!" },
			},
			DionysusChat23 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase" },
						Comparison = "~=",
						Value = 5,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0028",
					PreLineAnim = "Dionysus_Laugh",
					Text = "The moon is shining, the water's warm, the Nectar's flowing, what is not to like?" },
			},
			DionysusChat24 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0029",
					PreLineAnim = "Dionysus_Shrug",
					Text = "You keep on showing up but never stick around, quit {#Emph}teasing {#Prev}us, baby!" },
			},
			DionysusChat25 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<", Value = 0.5, },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0030",
					PreLineAnim = "Dionysus_Shrug",
					Text = "Hey Mel baby, you're bringing down the mood a bit looking like that, you get me, yeah?" },
			},
			DionysusChat26 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "PrevRun", "RoomsEntered", "P_Story01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.DionysusFeasting,

				{ Cue = "/VO/Dionysus_0031",
					PreLineAnim = "Dionysus_Eager",
					Text = "Oh you missed a {#Emph}real {#Prev}good time last night... or might have been the night before..." },
			},

		},

		GiftTextLineSets =
		{
			DionysusGift01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Dionysus_01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2395", UsePlayerSource = true,
					PreLineWait = 0.3,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I... don't wish to be just some ungrateful guest. I know you have your customs here, and I have studied them. So, please! For all your cheer and generosity!" },
				{ Cue = "/VO/Dionysus_0152",
					Emote = "PortraitEmoteSparkly",
					PreLineAnim = "Dionysus_Surprise",
					Text = "Whoa, this is Nectar, it's the real thing, we could use every drop that we can get! Then here is something for my most distinguished guests, of which I have decided {#Emph}you are one!" },
			},
			DionysusGift02 =
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
						-- not needed due to NarrativeData priorities
						-- PathTrue = { "GameState", "TextLinesRecord", "DionysusGift01" },
					},
				},
				{ Cue = "/VO/Dionysus_0153",
					Emote = "PortraitEmoteSparkly",
					PreLineAnim = "Dionysus_Laugh",
					Text = "Hey, {#Emph}nice{#Prev}, more Nectar always good to have around in case the wine runs out, not that it ever does or ever will! Now, what exactly do we toast to next?" },
				{ Cue = "/VO/MelinoeField_2397", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "To emerging from peril unscathed? Or whatever you decide. I know maintaining high morale is paramount, especially with the mountain under siege." },
				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						ObjectType = "NPC_Dionysus_01",
						PreLineAnim = "Dionysus_Greeting",
						{ Cue = "/VO/Dionysus_0085", Text = "Cheers!" },
					},
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						{ Cue = "/VO/MelinoeField_0067", Text = "Cheers." },
					}
				},

			},
			DionysusGift03 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "DionysusGift02" },
					},
				},
				{ Cue = "/VO/Dionysus_0176",
					Emote = "PortraitEmoteSparkly",
					PreLineAnim = "Dionysus_Eager",
					Text = "Hey, sure, I'll take that Nectar off your hands! As this here's {#Emph}just {#Prev}the place to put it to its proper use. But don't you get all sad and sappy with me, you're at a {#Emph}feast{#Prev}, not at a wake!" },
				{ Cue = "/VO/MelinoeField_2913", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I must admit, I'm unable to cast aside my fears and worries quite like you, Dionysus. It's little wonder mortals make so many offerings in your name... as now do I." },
			},
			DionysusGift04 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "DionysusGift03" },
					},
				},
				{ Cue = "/VO/Dionysus_0177",
					Emote = "PortraitEmoteSparkly",
					Text = "Now that's the spirit, giving back to the community, I {#Emph}like {#Prev}it, yeah? After all, you know I can't make cheer and revelry for everyone all by myself, don't you? Though between us, I still can make an {#Emph}awful {#Prev}lot." },
				{ Cue = "/VO/MelinoeField_2914", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Such cheer and revelry that you've created, seemingly out of thin air... and during such a time. Well, if this truly is to be a never-ending feast, then you'll need plenty of supplies!" },
			},

			-- placeholder
			DionysusGiftTemp =
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

			{ Cue = "/VO/MelinoeField_2396", Text = "I'm most grateful... and wish I could stay for the festivities." },
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Dionysus_01",
			ChanceToPlay = 0.5,
			PreLineAnim = "Dionysus_Surprise",
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
				{ Name = "DionysusGotHitRecently", Time = 6 },
			},
			TriggerCooldowns = { Name = "DionysusSpokeRecently" },

			{ Cue = "/VO/Dionysus_0061", Text = "Come on!" },
			{ Cue = "/VO/Dionysus_0062", Text = "Oh come off it." },
			{ Cue = "/VO/Dionysus_0063", Text = "I almost spilled this!" },
			{ Cue = "/VO/Dionysus_0064", Text = "Hey now." },
			{ Cue = "/VO/Dionysus_0065", Text = "Take it {#Emph}easy!" },
			{ Cue = "/VO/Dionysus_0066", Text = "Easy does it." },
			{ Cue = "/VO/Dionysus_0067", Text = "{#Emph}Yeah{#Prev}, let loose!" },
			{ Cue = "/VO/Dionysus_0068", Text = "Just relax." },
			{ Cue = "/VO/Dionysus_0069", Text = "No you don't!" },
			{ Cue = "/VO/Dionysus_0070", Text = "Whoa, baby.", PlayFirst = true },
			{ Cue = "/VO/Dionysus_0072", Text = "Ease up a bit?" },
			{ Cue = "/VO/Dionysus_0073", Text = "Do we have to escort you out?" },
			{ Cue = "/VO/Dionysus_0074", Text = "That isn't cool." },
		},

	},
}

-- Global Dionysus Lines
GlobalVoiceLines.DionysusGreetingLines =
{
	Queue = "Interrupt",
	{
		{
			RandomRemaining = true,
			ObjectType = "NPC_Dionysus_01",
			PreLineAnim = "Dionysus_Greeting",
			Cooldowns =
			{
				{ Name = "DionysusSpokeRecently", Time = 9 },
			},

			{ Cue = "/VO/Dionysus_0044", Text = "Whoa...!", PreLineAnim = "Dionysus_Surprise" },
			{ Cue = "/VO/Dionysus_0045", Text = "{#Emph}Wha-hoh...!", PreLineAnim = "Dionysus_Surprise" },
			{ Cue = "/VO/Dionysus_0046", Text = "Why {#Emph}hello.", PlayFirst = true },
			{ Cue = "/VO/Dionysus_0047", Text = "Why {#Emph}hello!" },
			{ Cue = "/VO/Dionysus_0048", Text = "Welcome!" },
			{ Cue = "/VO/Dionysus_0049", Text = "{#Emph}Heeey!" },
			{ Cue = "/VO/Dionysus_0050", Text = "{#Emph}Heeey." },
			{ Cue = "/VO/Dionysus_0051", Text = "Oh, Mel, hey!" },
			{ Cue = "/VO/Dionysus_0052", Text = "Huh?", PreLineAnim = "Dionysus_Surprise" },
			{ Cue = "/VO/Dionysus_0053", Text = "Wha? {#Emph}Oh!", PreLineAnim = "Dionysus_Surprise" },
			{ Cue = "/VO/Dionysus_0054", Text = "Look everyone!" },
			{ Cue = "/VO/Dionysus_0055", Text = "You made it!" },
			{ Cue = "/VO/Dionysus_0056", Text = "Hey help yourself!" },
			{ Cue = "/VO/Dionysus_0057", Text = "Back for more!" },
			{ Cue = "/VO/Dionysus_0058", Text = "Hey good-looking." },
			{ Cue = "/VO/Dionysus_0059", Text = "Look who's here!" },
			{ Cue = "/VO/Dionysus_0060", Text = "What is up?" },
		},
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.2,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			-- { Cue = "/VO/MelinoeField_1887", Text = "{#Emph}Erm{#Prev}, pardon...!", PlayFirst = true },
		},
	},
}

GlobalVoiceLines.DionysusFeastingLines =
{
	{
		PreLineWait = 0.35,
		RandomRemaining = true,
		ObjectType = "NPC_Dionysus_01",
		-- SubtitleMinDistance = 1200,
		SuccessiveChanceToPlayAll = 0.85,
		PreLineAnim = "Dionysus_Laugh",
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "DionysusInterrupt" },
			},
		},

		{ Cue = "/VO/Dionysus_0032", Text = "{#Emph}Hahaha, yeah! {#Prev}Come, everybody, let's have another round!" },
		{ Cue = "/VO/Dionysus_0033", Text = "...So I would like to propose {#Emph}another {#Prev}toast. To all of you! {#Emph}Cheers!!" },
		{ Cue = "/VO/Dionysus_0034", Text = "...So I would like to propose {#Emph}another {#Prev}toast? To feasting! {#Emph}Cheers!!",
			GameStateRequirements =
			{
				{
					PathTrue = { "GameState", "SpeechRecord", "/VO/Dionysus_0033" }
				},
			},
		},
		{ Cue = "/VO/Dionysus_0035", Text = "Now come, my friends, drink up, like there's no tomorrow!" },
		{ Cue = "/VO/Dionysus_0036", Text = "...another round, you say? Well I don't see why not! {#Emph}Ah, haha!" },
		{ Cue = "/VO/Dionysus_0037", Text = "Don't anybody worry about a thing, we've got it all under control!" },
		{ Cue = "/VO/Dionysus_0038", Text = "Enjoying that one, yeah? Well we've got plenty more, just let me know!" },
		{ Cue = "/VO/Dionysus_0039", Text = "Looking good, mate! Yeah, the water's fine! How's the drink, you need another yet, or what?" },
		{ Cue = "/VO/Dionysus_0040", Text = "Oh don't you know it, mate! This here is where the {#Emph}real {#Prev}action on the mountain is!" },
		{ Cue = "/VO/Dionysus_0041", Text = "Drink! Drink! Drink! Drink! Drink! Drink! Drink! {#Emph}Hehe, yeah!" },
		{ Cue = "/VO/Dionysus_0042", Text = "So you know what I say? I say, Dad... {#Emph}hah. {#Prev}I say Dad, what if I just don't want to? And he says, {#Emph}Then get out of my sight! {#Prev}So I say, {#Emph}Outta sight? All right! Hahahaha!" },
		{ Cue = "/VO/Dionysus_0043", PlayFirst = true, Text = "So I say, can't we just, you know, invite him over to a feast and hash things out over a cup of wine, yeah? And {#Emph}they {#Prev}all look at {#Emph}me {#Prev}like I'm completely daft, {#Emph}hahaha, hahahaha." },
		{ Cue = "/VO/Dionysus_0213", Text = "Hey look man let's {#Emph}not {#Prev}talk about that sort of thing in here, let's just {#Emph}relax! {#Prev}No need to get all down about that stuff!" },
		{ Cue = "/VO/Dionysus_0214", Text = "I ever tell you lot about the time I traveled east, across the seas? There's quite an island over there, good people too. You ever been to other parts or what?" },
		{ Cue = "/VO/Dionysus_0215", Text = "How many times do I have to say it, let's not talk about our mothers, this is polite company we're keeping! That's a {#Emph}naughty {#Prev}subject for a different sort of feast, you know?" },
		{ Cue = "/VO/Dionysus_0216", Text = "I mean {#Emph}really{#Prev}, what's to fear from Titans, are they gonna rip me up limb from limb? Well I can't die man, I'll just put myself together... and then have another drink!" },
		{ Cue = "/VO/Dionysus_0217", Text = "{#Emph}Hahahahaha, naughty{#Prev}, now be quiet everyone, I think that's her again, be on your best behavior yeah?" },
		{ Cue = "/VO/Dionysus_0218", Text = "So I say, can't we just, wait... have I not already told this one before? You'll tell me if I did? Or if you don't remember, that's cool! Neither do I, {#Emph}haha. {#Prev}What were we on about?",
			GameStateRequirements =
			{
				{
					Path = { "GameState", "RoomsEntered", "P_Story01" },
					Comparison = ">=",
					Value = 6,
				},
			}
		},
	},
}

GlobalVoiceLines.DionysusGatherReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	ObjectType = "NPC_Dionysus_01",
	Cooldowns =
	{
		{ Name = "DionysusSpokeRecently", Time = 4 },
	},

	{ Cue = "/VO/Dionysus_0133", Text = "What's that you got?" },
	{ Cue = "/VO/Dionysus_0136", Text = "Keep it, it's all yours!" },
	{ Cue = "/VO/Dionysus_0137", Text = "{#Emph}Everybody {#Prev}gets a gift!" },
	{ Cue = "/VO/Dionysus_0138", Text = "Hang onto that!" },
	{ Cue = "/VO/Dionysus_0139", Text = "Nice!" },
	{ Cue = "/VO/Dionysus_0140", Text = "Hey good for you!" },
	{ Cue = "/VO/Dionysus_0141", Text = "Right {#Emph}on!" },
	{ Cue = "/VO/Dionysus_0142", Text = "Dig it!" },
}
GlobalVoiceLines.DionysusExorcismReactionVoiceLines =
{
	RandomRemaining = true,
	BreakIfPlayed = true,
	PreLineWait = 0.65,
	SuccessiveChanceToPlay = 0.5,
	SuccessiveChanceToPlayAll = 0.25,
	ObjectType = "NPC_Dionysus_01",
	Cooldowns =
	{
		{ Name = "DionysusSpokeRecently", Time = 4 },
	},

	{ Cue = "/VO/Dionysus_0207", Text = "Don't think that one had an official invite anyhow..." },
	{ Cue = "/VO/Dionysus_0208", Text = "Hey that was {#Emph}my {#Prev}groupie!", PlayFirst = true },
	{ Cue = "/VO/Dionysus_0209", Text = "Go get your own devoted following!" },
	{ Cue = "/VO/Dionysus_0211", Text = "{#Emph}Eugh{#Prev}, that one was a bit dour anyway..." },
	{ Cue = "/VO/Dionysus_0212", Text = "No hassling my guests, all right?" },
	{ Cue = "/VO/Dionysus_0139", Text = "Nice!" },
	{ Cue = "/VO/Dionysus_0140", Text = "Hey good for you!" },
	{ Cue = "/VO/Dionysus_0141", Text = "Right {#Emph}on!" },
	{ Cue = "/VO/Dionysus_0142", Text = "Dig it!" },
}

GlobalVoiceLines.MiscEndVoiceLines_Dionysus =
{
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		ObjectType = "NPC_Dionysus_01",
		AllowTalkOverTextLines = true,

		--
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.25,
		AllowTalkOverTextLines = true,

		--
	},
	[3] = { GlobalVoiceLines = "ThankingCharacterVoiceLines" },
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Dionysus )