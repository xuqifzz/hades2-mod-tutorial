UnitSetData.NPC_Circe =
{
	-- Circe, Id = TKTK
	NPC_Circe_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Circe_Default_01",
		AnimOffsetZ = 50,
		Groups = { "NPCs" },
		SpeakerName = "Circe",
		SubtitleColor = Color.CirceVoice,
		EmoteOffsetY = -220,
		EmoteOffsetX = 100,

		RequiredRoomInteraction = true,

		ActivateRequirements =
		{
			-- None
		},
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		RepulseOnMeleeInvulnerableHit = 150,
		TurnInPlaceAnimation = "Circe_Turn",
		PreEventFunctionName = "AngleNPCToHero",

		UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,

		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA3",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeCircePig2",
		MenuTitle = "CirceChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Circe",
		Using = { "MetaUpgradeCardFlip", GrannyModel = "Odysseus_Mesh" },
		LoadPackages = { "NPC_Circe_01", "Circe" },
		
		Traits = 
		{
			"CirceShrinkTrait",
			"CirceEnlargeTrait",
			"ArcanaRarityTrait",
			"HealAmplifyTrait",
			"DoubleFamiliarTrait",
			"RemoveShrineTrait",
			"RandomArcanaTrait",
			"CirceSorceryDamageBoon",

			"ExPolymorphBoon",
		},
		FlavorTextIds =
		{
			"CirceChoiceMenu_FlavorText01",
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "CirceGrantsHiddenAspect01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3400", Text = "{#Emph}I see you guarding graves of mortals passed into the black beyond." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "CirceAboutOdysseusKeepsake01" },
					},
				},
				{ Cue = "/VO/Melinoe_0926_C", Text = "I'm sorry..." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "CirceAboutScyllaQuest01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4342", Text = "{#Emph}May your ambitions... drown..." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "CirceAboutScyllaQuestComplete01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4345", Text = "{#Emph}Turning to a Simple Form..." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "CirceAboutCharybdis01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3664", Text = "Oh, no, not at all..." },
			},
			{
				PlayOnce = true,
				BreakIfPlayed = true,
				PreLineWait = 0.9,
				SkipAnim = true,
				UsePlayerSource = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "CirceGrantsFamiliarCostumes01" },
					},
				},
				{ Cue = "/VO/MelinoeField_4532", Text = "{#Emph}Alteration of Familiar Forms..." },
			},
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
			},
		},
		SpecialInteractCooldown = 60,
		InteractVoiceLines =
		{
			{
				PreLineWait = 0.3,
				UsePlayerSource = true,
				RandomRemaining = true,
				PlayOnceThisRun = true,
				SuccessiveChanceToPlayAll = 0.33,
				Cooldowns =
				{
					{ Name = "MelinoeSaluteSpeech", Time = 4 },
				},

				{ Cue = "/VO/MelinoeField_1890", Text = "Peace, Madame Circe.",
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				-- { Cue = "/VO/MelinoeField_1891", Text = "Moonlight conceal you." },
				{ Cue = "/VO/MelinoeField_1892", Text = "Be well, Madame.", PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_1893", Text = "Salutations, Madame.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							PathFromArgs = true,
							Path = { "OriginalSource", },
							HasNone = { "ConversationThisRun", "GiftedThisRun", },
						},
						{
							PathFalse = { "CurrentRun", "Hero", "IsDead" },
						},
					},
				},
				{ Cue = "/VO/Melinoe_1697", Text = "Together we shine." },
				{ Cue = "/VO/Melinoe_0025", Text = "Together we shine." },
			},
			{ GlobalVoiceLines = "SaluteVoiceLines" },
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				ObjectType = "NPC_Circe_01",
				PreLineAnim = "Circe_Salute",
				TriggerCooldowns = { Name = "CirceSpokeRecently" },

				{ Cue = "/VO/Circe_0102", Text = "Together we shine!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1697", "/VO/Melinoe_0025" },
						},
					},
				},
				{ Cue = "/VO/Circe_0103", Text = "Yes, hello!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1893", "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Circe_0104", Text = "And to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1890" },
						},
					},
				},
				{ Cue = "/VO/Circe_0104_B", Text = "And to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1893", "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Circe_0105", Text = "And hail to you.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1890", "/VO/MelinoeField_1893", "/VO/Melinoe_1698", "/VO/Melinoe_1699" },
						},
					},
				},
				{ Cue = "/VO/Circe_0106", Text = "And peace to you.",
					PlayFirst = true,
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1890", },
						},
					},
				},
				{ Cue = "/VO/Circe_0107", Text = "You, too!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/MelinoeField_1892" },
						},
					},
				},
				{ Cue = "/VO/Circe_0108", Text = "Our Lady thus decrees...",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Circe_0109", Text = "And you in kind.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701", "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Circe_0110", Text = "Thank you, poppet.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701" },
						},
					},
				},
				{ Cue = "/VO/Circe_0111", Text = "Never has she not!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Circe_0112", Text = "Hear that, Selene?",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Circe_0113", Text = "Selene never fails!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/Melinoe_1709" },
						},
					},
				},
			}
		},

		InteractTextLineSets =
		{
			CirceFirstMeeting =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GiftableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0002",
					-- PreLineAnim = "Circe_Explaining_Start",
					-- PostLineAnim = "Circe_Explaining_End", 
					-- PreLineAnim = "Circe_Pensive_Start",
					-- PostLineAnim = "Circe_Pensive_End", 
					-- PreLineAnim = "Circe_Salute",
					-- PreLineAnim = "Circe_Greet",

					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Oh{#Prev}, well, isn't this marvelous! How you've {#Emph}grown{#Prev}, little miss! Do you remember Circe the Enchantress still? {#Emph}Ah? {#Prev}Oh, no matter, {#Emph}hahaha. {#Prev}Not the circumstances for small talk! Show me your palms." },
				{ Cue = "/VO/MelinoeField_1756", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of course I remember you, Madame Circe! So this is your famous island! Such a relief to be here rather than another drowned ship. I take it we're not meeting by chance?" },
				{ Cue = "/VO/Circe_0003",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Text = "Wise to our ways as ever! Our Lady Hecate and I decided I had best relocate for a while, and survey events as near the mountain of the gods as possible. Then tonight within my crystals, I saw {#Emph}you! {#Prev}Now, how may we make you better?" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutBackstory01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceGift01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0051",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "You and I are much alike in that Our Lady Hecate discovered us when most we needed someone such as her, poppet. Perchance, her similar affinity for beasts made her take some pity on me then... a witch, amongst the polecats and the pigs!" },
				{ Cue = "/VO/MelinoeField_1981", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Take pity on you, how? That doesn't sound like the Headmistress I know. She has always thought highly of you, and depends on you to be our eyes here at this key juncture." },
				{ Cue = "/VO/Circe_0052",
					PreLineAnim = "Circe_Pensive_End", 
					Text = "I owe her this, and more. When I was a young outcast, practicing an art oft thought to be profane, it was our Lady who discovered me and showed me that my path led not to ruin, but to harmony. It veritably is a long and winding path, but one I shall not stray from anymore." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutMiracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0027",
					Text = "I foresaw within the facets of my crystals that you were headed here again... or {#Emph}through {#Prev}here, I should say. Is there a salve, potion, or poultice that might ease your passage?" },
				{ Cue = "/VO/MelinoeField_1939", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Most certainly, and thank you, Madame Circe. I don't suppose you have anything that renders me invulnerable, or lets me find vast quantities of rare reagents on my way?" },
				{ Cue = "/VO/Circe_0028",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Emote = "PortraitEmoteSurprise",
					Text = "Heavens {#Emph}no{#Prev}, poppet, {#Emph}hah! {#Prev}The greater the effect, the greater the unintended consequence, that much we know is true. {#Emph}Erm{#Prev}, there is a {#Emph}balance {#Prev}to creating miracles! Shall one of these suffice?" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutStudies01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0029",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "How you were {#Emph}always {#Prev}at your studies, little miss! That you are here suggests how much you have achieved. I always wanted you to visit me; you used to say it was {#Emph}impossible!" },
				{ Cue = "/VO/MelinoeField_1940", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It turns out even prophecies of the Three Fates are circumventable. Though, I still have much to learn... or so I keep reminding myself night after night. How about you? You must have perfect mastery over our craft by now!" },
				{ Cue = "/VO/Circe_0030",
					PreLineAnim = "Circe_Pensive_End",
					Text = "Now it's {#Emph}my {#Prev}turn to say something {#Emph}is {#Prev}impossible! I've been practicing enchantment for three quarters of my life, and have yet to ever change the essence of a thing! Only the {#Emph}form. {#Prev}But the pursuit I find is fascinating without end!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutThessaly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0031",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End", 
					Text = "{#Emph}Fie {#Prev}on that never-ending fleet of ghastly sailing-ships, all headed for the mountain of the gods, {#Emph}hah! {#Prev}My little isle sometimes gets {#Emph}right {#Prev}in the way! No hospitality awaits {#Emph}their {#Prev}boorish crews, {#Emph}ahaha! {#Prev}Whilst {#Emph}I {#Prev}replenish my supply of firewood." },
				{ Cue = "/VO/MelinoeField_1941", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must long for the days when your island was more secluded, and had much less unwanted company. I hope I'm not disturbing your peace, Madame!" },
				{ Cue = "/VO/Circe_0032",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Text = "{#Emph}Oh{#Prev}, heavens {#Emph}no! {#Prev}In actuality, it could be rather all too quiet with only the rustle of the vegetation, and the snuffle of my piggies, and the like. I more than welcome your returns!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutHut01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0033",
					Emote = "PortraitEmoteSparkly",
					Text = "Welcome, poppet! Though, forgive me that I've not invited you {#Emph}inside {#Prev}my little hut. Such hospitality I don't extend to anyone, {#Emph}hmhm! {#Prev}And I make no exceptions, not even for you!" },

				{ Cue = "/VO/MelinoeField_1942", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe, that is perfectly all right. There's no need to explain! We all live in seclusion in our own way; what other way is there? With privacy comes peace of mind." },

				{ Cue = "/VO/Circe_0034",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "I'm grateful that you understand. Of late, I share my simple home with beasts but that is all! This Isle of Aiaia is not mine of course; rather, it's my dear companion, and can be {#Emph}yours. {#Prev}So please, help yourself to anything you need whilst here." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutSurfacePenalty01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						--
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0139",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					PreLineWait = 0.35,
					Portrait = "Portrait_Circe_Serious_01",
					Text = "...I had been meaning to inquire, how in all the heavens is it possible you've traveled so far from your home-realm, little miss? I'd understood that you could scarcely breathe this air!" },
				{ Cue = "/VO/MelinoeField_3494", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, you know what we say, Madame: There's an incantation for practically everything. This one in particular felt almost as though I was lifting a curse." },
				{ Cue = "/VO/Circe_0140",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Text = "I see! But all of us perchance are cursed in some odd way; either we learn to live with it, or discover how to overcome it." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutArcana01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = ">=",
						Value = 25,
					},
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 18,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0041",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End", 
					Text = "Our Lady Hecate would sometimes tell me of your progress, and let on that you attuned to the Altar of Ashes at long last, {#Emph}hoho! {#Prev}How marvelous... for the Arcana have so much to offer us." },

				{ Cue = "/VO/MelinoeField_1977", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I couldn't agree more. Through grasping the Arcana, I've discovered strength I never realized I had. To think I used to use our Altar merely to collect my thoughts." },

				{ Cue = "/VO/Circe_0042",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Text = "Collecting one's thoughts is valuable enough! Mine own at least are prone to scattering. As for your innate strength and magickal acuity, perchance we shall discover even more." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutArcana02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "DoorRerollMetaUpgrade" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0141",
					Text = "Within your grasp of the Arcana is a power for which I myself am known. When I was closer to your age, oh how I longed to earn the title of Enchantress! Now here both of us are." },

				{ Cue = "/VO/MelinoeField_3495", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your path always inspired me, Madame. For you did not accept things as they were; you learned to alter outcomes to your benefit. Made some big changes as I understand." },

				{ Cue = "/VO/Circe_0142",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "Seek not {#Emph}my {#Prev}path but {#Emph}yours! {#Prev}At first I sought to change the world, yes? For I quite hated much of what I saw. But through the teachings of Our Lady Hecate, I now seek to better understand... making adjustments here and there, {#Emph}hahaha!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutArcana03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutArcana02" },
					},
					{
						PathTrue = { "GameState", "MetaUpgradeState", "DoorReroll", "Unlocked" },
					},
					{
						Path = { "GameState", "MetaUpgradeState", "DoorReroll", "Level" },
						Comparison = ">=",
						Value = 2,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "CirceAboutArcana02" }, Min = 2 },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/MelinoeField_3496", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Something I've wondered about the Arcana, Madame. You appear to be depicted on one of the Cards... except she has these wrathful eyes. That isn't really {#Emph}you{#Prev}, is it?" },

				{ Cue = "/VO/Circe_0143",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "Who can say, little miss? Of course she isn't {#Emph}me{#Prev}, for I am here, and she is there! The Arcana are mere likenesses, reflecting your {#Emph}own {#Prev}inner strength. Perchance even your eyes..." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutLearning01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = ">=",
						Value = 30,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CirceGift06" }
					}
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0234",
					Emote = "PortraitEmoteCheerful",
					Text = "You always had {#Emph}such talent {#Prev}for our craft! I wondered how it'd change you over time, for the temptations on the path are numerous! But you had the greatest teacher possible!" },

				{ Cue = "/VO/MelinoeField_4524", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress Hecate would say {#Emph}the greatest teacher is out there... {#Prev}referring probably to your isle, Madame Circe. What do you mean by temptations?" },

				{ Cue = "/VO/Circe_0235",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",

					-- heart unlock
					PostLineThreadedFunctionName = "RelationshipAdvancedPresentation",
					PostLineThreadedFunctionArgs = { Delay = 0.25 },

					Text = "I mean {#Emph}power{#Prev}, little miss. Once you can manifest your desires, what's to {#Emph}stop {#Prev}you? Lessons learned the hard way, if at all. You have your left hand there as but one reminder..." },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutTransformation01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusFirstMeeting" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0144",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End", 
					Text = "I oft consider turning you into a bird to ease your journey, but you'd abandon your Night-given weaponry and reagents... you'd arrive upon the mountain of the gods naked, and cold..." },
				{ Cue = "/VO/MelinoeField_3521", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Oh! {#Prev}No thank you, then, Madame. While I sometimes grow envious of my considerable number of flight-capable acquaintances, I'm comfortable making my way on foot." },
				{ Cue = "/VO/Circe_0145",
					Emote = "PortraitEmoteCheerful",
					Text = "That is as clear as crystal to me, little miss! Though, should you {#Emph}ever {#Prev}change your mind and wish to live a little as a beast, do summon me without delay then, yes?" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutTraining01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "ClearedSurfaceRunsCache" },
						Comparison = ">=",
						Value = 2,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0146",
					Text = "For all the rigors of these evenings, little miss, at least your studies must be finally complete! Now you're learning from the {#Emph}greatest teacher of all{#Prev}, as Our Lady Hecate might say." },
				{ Cue = "/VO/MelinoeField_3522", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That's mostly true, Madame, except Headmistress still is prone to testing me herself night after night, just as I'm ready to depart from Erebus. Though not when I head here!" },
				{ Cue = "/VO/Circe_0147",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "I scarce imagine that the trials you face upon the surface are less rigorous than those you face below! And look how far you've come with what you've learned!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0049",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "How lately is the temperament of Our Lady Hecate? Long has it been since last I basked in her wisdom; for I have wisdom of my own, she says! You must have needed her attention more than I..." },
				{ Cue = "/VO/MelinoeField_1980", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe, I... I did not mean to deny you her attention. Although Headmistress has been preoccupied not just with my training, but with leading the Unseen, warding the Crossroads against any harm, readying our plans to take back what's ours. She's counting on us... on you." },
				{ Cue = "/VO/Circe_0050",
					PreLineAnim = "Circe_Pensive_End", 
					Text = "I know, I know... and I apologize that I insinuated any feelings of resentment on my part; for none exist towards you, let alone her! You have my {#Emph}word{#Prev}, poppet. It's just... she was like a mother to me! {#Emph}Oh{#Prev}, how she hated when I told her so, {#Emph}haha!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutSelene01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "SpellTransformTrait" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0045",
					Emote = "PortraitEmoteSparkly",
					Text = "You've one of great Selene's precious blessings on this eve, that I can tell, poppet! Even from afar, the Moon has always kept me company. Her light can be so {#Emph}utterly {#Prev}transformative!" },

				{ Cue = "/VO/MelinoeField_1978", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And may Selene's light ever shine for us, Madame. I'd likely not have found my way to you if not for her. As for her magick... sometimes I wonder if it isn't transforming me, so much as revealing who I really am." },

				{ Cue = "/VO/Circe_0046",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "That may well be so! Who is to say where our true nature lies? A spell of transformation is a spell of revelation; when we change, we become more like {#Emph}ourselves{#Prev}. Not less!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutHermes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0134",
					Text = "You have arrived here swiftly, poppet! And I presume that it was not solely the work of {#Emph}winds {#Prev}and {#Emph}currents {#Prev}and the like. The messenger-god Hermes speeds you onward, yes?" },

				{ Cue = "/VO/MelinoeField_3391", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have his Boon this night. The gods are not so embattled that they cannot aid me in my voyage, and our strength is greatest when we share it. Though, why do you ask?" },

				{ Cue = "/VO/Circe_0135",
					PreLineWait = 0.35,
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End",
					Text = "It's simply that the gods have limited awareness of my whereabouts, and I would keep it thus! No room for many visitors! And the Olympians would {#Emph}surely {#Prev}be aghast to look upon so modest of a place." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutIcarus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "SpawnRecord", "NPC_Icarus_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutEris01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0136",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "I lately hear the beating of so many different wings. The Harpies, soaring to the mountain siege; black-feathered Strife, who roils the currents of the air and sea; and even that boy Icarus, who has been flitting on, unmoored!" },
				{ Cue = "/VO/MelinoeField_3392", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He's trying to help our cause... though I think also enjoying a level of freedom he never had in life, nor as a Shade residing in the Underworld. For now, he can go where he pleases." },
				{ Cue = "/VO/Circe_0137",
					PreLineAnim = "Circe_Pensive_End", 
					Text = "Yet he wishes to be {#Emph}here! {#Prev}That veritably speaks to his commitment. How like his ever-toiling father he turned out to be! Well, may he enjoy the wings of freedom whilst they last!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutChronos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0047",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "What has the world come to, little miss? {#Emph}Uh! {#Prev}Living on my little isle, I must have been the last to learn calamity had spread all from the heavens to beneath the Earth!" },
				{ Cue = "/VO/MelinoeField_1979", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "And Chronos is responsible for all of it. {#Emph}Time {#Prev}apparently wishes to ruin everything eventually, though we are not about to let him have his way. We'll drive his forces from Olympus and unseat him from my father's throne." },
				{ Cue = "/VO/Circe_0048",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Portrait = "Portrait_Circe_Serious_01",
					Text = "{#Emph}Oh{#Prev}, we immortals and our warring ways! What example do we set for {#Emph}mortalkind? {#Prev}But I know certain battles must be fought; and I remain committed to Our Lady Hecate, and you." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutMedea01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Medea_01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0053",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "I have seen neither hide nor hair of that Medea as of late! Her charge was far less pleasant than my own, having to watch over that ghastly town. I worry she's developing bad habits, practicing in such a place!" },
				{ Cue = "/VO/MelinoeField_1982", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've seen Lady Medea recently. She seems rather comfortable in Ephyra, in spite of what's happened there. Though, has she always had such a singular interest in curses and the necromantic arts?" },
				{ Cue = "/VO/Circe_0054",
					PreLineAnim = "Circe_Pensive_End",
					Text = "Since she was old enough to think for herself, yes, {#Emph}heh{#Prev}. To {#Emph}fend {#Prev}for herself, I should say. She may be my niece yet she was always {#Emph}far {#Prev}more interested in our blood's {#Emph}other {#Prev}properties. At least she hasn't put a curse on {#Emph}me, haha. Ah! {#Prev}As far as I can tell!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutScylla01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "G_Boss01", "G_Boss02", },
						Comparison = ">=",
						Value = 10,
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "G_Boss01", "G_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0058",
					Portrait = "Portrait_Circe_Serious_01", 
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Circe_Default_01", WaitTime = 3.65 },

					Text = "All of this sea-water must feel very disconcerting, little miss. For me, though, it feels rather much like home! Even the depths of Oceanus bring a sense of comfort, more than fear!" },

				{ Cue = "/VO/MelinoeField_1985", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm getting used to it. My path into the Underworld requires me to skirt the edge of Oceanus. The water's beautiful, though I could do without the sea-monsters. Particularly Scylla and her Siren friends... perhaps you know of them?" },

				{ Cue = "/VO/Circe_0059",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "Oh, {#Emph}yes! {#Prev}I do indeed. I grew up underneath the sea, and Scylla I remember from my youth. Always yelping about {#Emph}this {#Prev}or {#Emph}that! {#Prev}Was {#Emph}deafening! {#Prev}Perchance why I prefer the silence now." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutScylla02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutScylla01" }
					},
					{
						PathTrue = { "GameState", "CodexEntriesViewed", "Scylla" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "G_Boss01", "G_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0160",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "How is old Scylla lately anyhow? I hadn't heard that she descended to your depths. You said she's banded with some Sirens, yes? For what, to sing their songs?" },
				{ Cue = "/VO/MelinoeField_3526", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, yes. She longs for fame above all else, and to drown things. I've had to put a stop to her performances now more than a few times. The Book of Shadows I possess states she's the victim of a witch's curse... do you know whose?" },
				{ Cue = "/VO/Circe_0161",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Circe_Pensive_End", 
					Text = "Oh, what an interesting Book that one must be! I do not curse, poppet. My practice is about revealing the true nature of a thing. When last I checked, Scylla had made hers clear." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutScyllaQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CirceGift03", "CirceAboutScylla02" }
					},
					{
						Path = { "GameState", "Resources", "MixerGBoss" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "ScreensViewed", "Shrine" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0212",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "I've been thinking, poppet, if that Scylla has been posing problems for you during your descent, perchance I can be of some benefit? But I require something first: a special Pearl." },

				{ Cue = "/VO/MelinoeField_4340", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Truly? I happen to have more than a few Pearls from her here, so take your pick. Although, first tell me more of what you have in mind." },

				{ Cue = "/VO/Circe_0213",
					PreLineAnim = "Circe_Pensive_End",
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "{#Emph}Oh{#Prev}, none of these shall do! One must be taken from her with particular intent, under a dark and fearful night, to drown her ambitions, as a Siren would a sailor...! Can you do that for me?" },

				{ Cue = "/VO/MelinoeField_4341", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Text = "Perhaps, but... what shall become of Scylla if I do? She's hindered me but does provide some entertainment for the Shades of Oceanus at least." },

				{ Cue = "/VO/Circe_0214",
					PreLineAnim = "Circe_Salute", 
					Text = "She shall no longer pose a threat. Whilst the influence of Night is strong, claim one of Scylla's precious Pearls, and declare: {#Emph}May your ambitions drown. {#Prev}Consider it at least?" },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutScyllaQuestComplete01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CirceAboutScyllaQuest01" }
					},
					{
						PathTrue = { "GameState", "Flags", "AcquiredMixerForCirceQuest" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/MelinoeField_4343", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "I have a Pearl here from Scylla, Madame, although not imbued with your intent. You said your practice is about revealing the true nature of things. Hers is already plain." },

				{ Cue = "/VO/Circe_0215",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End",
					Portrait = "Portrait_Circe_Serious_01", 

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteCheerful", Portrait = "Portrait_Circe_Default_01", WaitTime = 7 },

					Text = "Hence the reason I suggested we {#Emph}subdue {#Prev}her. But you've no taste for such enchantments, I see... which means you passed another test, {#Emph}hahaha! {#Prev}Congratulations, poppet!" },

				{ Cue = "/VO/MelinoeField_4344", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01ReturnToIdle", PreLineAnimTarget = "Hero",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}What? {#Prev}Did Headmistress put you up to this? To see if I'd resort to cursing an inconsequential foe merely because I could...?" },

				{ Cue = "/VO/Circe_0216",
					PreLineAnim = "Circe_Salute", 
					Text = "To see if you would blindly do the bidding of an elder merely because you were asked. Our craft is most effective with restraint; a hard lesson we all eventually learn. Of course if Scylla should become a greater threat, {#Emph}hm... {#Prev}do seek me out." },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutOdysseus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceGift02" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0055",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "I wonder, does Our Lady Hecate as yet consort with that Tactician Shade of hers, {#Emph}heh? {#Prev}Not of surpassing stature, prone to talk. {#Emph}Oh{#Prev}, what was his name again...?" },
				{ Cue = "/VO/MelinoeField_1983", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You mean Odysseus? He remains indispensable to our cause. What knowledge I possess of this route and the dangers along it are thanks largely to him. Why do you ask?" },
				{ Cue = "/VO/Circe_0056",
					PreLineAnim = "Circe_Pensive_End", 
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "{#Emph}Oh! {#Prev}No reason at all! It's merely that he was a flighty sort as I recall, quite prone to wandering about! So his continued service is a bit of a surprise. A pleasant one, mind you!" },
				{ Cue = "/VO/MelinoeField_1984", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Did you use to know him? I don't recall you interacting at the Crossroads. Not that I was paying much heed to anything besides my studies then. I was so little last you visited!" },
				{ Cue = "/VO/Circe_0057",
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "Once I relocated this isle, the journey to the Crossroads became {#Emph}much {#Prev}more arduous. As for Odysseus, yes, him I've met before. Him and his pig-headed crew! A different age, poppet, {#Emph}haha! {#Prev}Perchance he's learned a bit since then." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutOdysseusKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BossPreDamageKeepsake" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "CirceAboutOdysseusQuest00", "CirceAboutOdysseusQuest01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0219",
					PreLineThreadedFunctionName = "PlayCharacterAnim",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Circe_Serious_01", 
					PostLineThreadedFunctionName = "MuteSpeaker",
					Text = "What is it that you have there, little miss? {#Emph}Uh, mm{#Prev}, some old accursed Knuckle Bones, it seems... I ask you {#Emph}quickly {#Prev}get them hence! They're interfering with the energy about this place!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutOdysseusQuest00 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "OdysseusLooseEndsQuest02" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BossPreDamageKeepsake" },
					},
					-- back compat for testing
					{
						PathFalse = { "GameState", "TextLinesRecord", "CirceAboutOdysseusQuest01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0220",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "You bring with you ill presence, little miss. I do not welcome it at all! It's those old Knuckle Bones I sense you have, they... they first visited this isle long ago..." },
				{ Cue = "/VO/MelinoeField_4519", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Please, Madame. I got these from Odysseus himself, and they've only served me well. He's asked if you would speak with him through them. I don't know what you have to discuss, but can tell it burdens you both." },
				{ Cue = "/VO/Circe_0221",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Circe_Pensive_End", 
					Portrait = "Portrait_Circe_Serious_01",
					Text = "How strange to be entreated thus! You've far more urgent matters than to be {#Emph}his {#Prev}messenger! He could have voyaged here himself if he had anything of use to say, {#Emph}hoho! {#Prev}But {#Emph}no." },
				{ Cue = "/VO/MelinoeField_4520", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "We need our Great Tactician at his post. Look, if you can sense those Bones at all, then surely you can sense no negative intent. I'm sorry to disturb you nonetheless." },
				{ Cue = "/VO/Circe_0222",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",
					Portrait = "Portrait_Circe_Serious_01",
					PostLineThreadedFunctionName = "MuteSpeaker",
					Text = "Oh it's all right, it's not {#Emph}your {#Prev}fault, poppet. But I am not prepared for conversation with him now. When next you bring those Bones here, though... {#Emph}eugh... {#Prev}perchance I shall." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutOdysseusQuest01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreEventFunction = true,
				GameStateRequirements = 
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutOdysseusQuest00" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BossPreDamageKeepsake" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0223",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "Again those Knuckle Bones. Then very well, I'm an enchantress of my word, poppet. You may invoke our old friend the Tactician Shade; I would hear what he has to say." },

				{ Cue = "/VO/MelinoeField_4357",
					UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",

					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 1.4, PowerWordPresentation = true, PowerWordWaitTime = 4.9 },

					PostLineFunctionName = "SummonOdysseus",
					PostLineFunctionArgs = { SummonTargetIds = { O_Story01 = 772507, }, },
					ExitPortraitImmediately = true,
					PostLineRemoveContextArt = true,
					Text = "Very well, Madame. {#Emph}Heed now my voice, Odysseus; one whom you sought is here!" },

				{ Cue = "/VO/Odysseus_0575",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Default_01",
					Text = "Lady Circe. I shall not take more than a moment of your time. I see you still are taking care of pigs!" },

				{ Cue = "/VO/Circe_0224",
					PreLineAnim = "Circe_Pensive_Start",
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "I've found they're quite obedient. But I take it you're not here for them, Odysseus. The purpose of your visit is...?" },

				{ Cue = "/VO/Odysseus_0576",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "Is there a place where we might briefly talk? The goddess by my side probably can't project me here for long." },

				{ Cue = "/VO/Circe_0225",
					PreLineAnim = "Circe_Pensive_End",
					Text = "Whatever you wish to say, do say it here and now. I distinctly recall we had together decided that no further discussion between us was wise, having reached an impasse, akin to obstacles {#Emph}you {#Prev}met at {#Emph}sea!" },

				{ Cue = "/VO/Odysseus_0577",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Default_01",
					Text = "A recollection I share, but... look, I've never reached an impasse that I couldn't cross, and you yourself have mastered change. Rather than leave our past to rot, I thought perhaps we could... return it to the earth, as you might say." },

				{ Cue = "/VO/Circe_0226",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "That {#Emph}is {#Prev}a precarious position, for neither of us shall apologize and neither shall forget! We've been over this subject at length. I've studied it more than enough!" },

				{ Cue = "/VO/Odysseus_0578",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Thoughtful_01",
					Text = "And I'm done studying it, too, my lady. It was a very different time for both of us, and now... we're close to those whom we both care about. I'd like to move on for their sake if not our own." },

				{ Cue = "/VO/Circe_0227",
					PreLineAnim = "Circe_Greet",
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "We have moved on, or so I thought at least. I harbor no ill will toward you, sailor! I said it when we met, and I am saying it again. We had our moment, but it has no power anymore." },

				{ Cue = "/VO/Odysseus_0579",
					Speaker = "NPC_Odysseus_01",
					Portrait = "Portrait_Odysseus_Default_01",
					PortraitExitAnimation = "Portrait_Odysseus_Default_01_Exit",
					PostLineFunctionName = "UnSummonOdysseus",
					PostLineRemoveContextArt = true,

					Text = "Then let's agree on that. Now you be well, my lady. All I truly wanted to say was, my existence and memories are richer having met... I know myself better. And I'm grateful you are aiding us." },

				{ Cue = "/VO/Circe_0228",
					PreLineWait = 1.3,
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Portrait = "Portrait_Circe_Serious_01", 
					PostLineThreadedFunctionName = "MuteSpeaker",
					Text = "...And there he goes, getting the last word in as always was his wont. Go on, poppet, I've done {#Emph}far {#Prev}too much talking for one night." },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutOdysseusQuest02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutOdysseusQuest01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0229",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Portrait = "Portrait_Circe_Serious_01", 
					Text = "I wished to thank you for when last we spoke. And for delivering Odysseus to me. At first I... felt a great unease, but then, after you left... that sentiment did, too. He is a Shade; perchance he had been haunting me a bit." },

				{ Cue = "/VO/MelinoeField_4358", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "What happens now between you two, Madame? Is there something I can communicate on your behalf?" },

				{ Cue = "/VO/Circe_0230",
					PreLineAnim = "Circe_Pensive_End", 
					Text = "No need. I realize that we were bound to drift apart, for he is {#Emph}not {#Prev}the sort to remain still! But, if a memory of something must {#Emph}linger{#Prev}, a peaceful one is best." },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutEris01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisAboutLoyalty01", "ErisBossAboutRandomness01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "RoomsEntered" },
						SumOf = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 4,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0132",
					Text = "You've seen by now how the black wings of spiteful Strife oft darken up these skies! She overlooks my little isle, though flies {#Emph}perilously {#Prev}close. What is the latest reason for her {#Emph}ire?" },
				{ Cue = "/VO/MelinoeField_3390", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh Eris has seemed {#Emph}happier {#Prev}than usual if anything. At first I believed she was working for Chronos, but I think it's simply that she doesn't like when {#Emph}anyone {#Prev}succeeds. Other than her." },
				{ Cue = "/VO/Circe_0133",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Portrait = "Portrait_Circe_Serious_01",
					Text = "Well that's not a sound mode of thought at all. How I long for a world without Strife... yet I can scarce imagine one. She is a force that mustn't be ignored, but quelled." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "GameState", "TextLinesRecord", "CirceAboutOlympus01" },
							},
						},
						{
							{
								PathTrue = { "GameState", "ReachedTrueEnding" },
							},
						},
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0116",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End", 
					Portrait = "Portrait_Circe_Serious_01",
					Text = "How regrettable to know Prometheus rebels against the gods... surely he must see that his pursuit of vengeance shall not bring him any peace! Is there no {#Emph}reasoning {#Prev}with him?" },
				{ Cue = "/VO/MelinoeField_3380", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He isn't much for talk, but then lately who is? We end up clashing just beneath the summit. Apparently he always knows who's going to be the victor... even if it's me." },
				{ Cue = "/VO/Circe_0117",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Portrait = "Portrait_Circe_Serious_01",
					Text = "{#Emph}Oh{#Prev}, he's foreseen his own defeat before. Can you imagine, poppet? To know of each and every ill awaiting you. I doubt if any punishment he has endured is worse than {#Emph}that." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutPrometheus01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/MelinoeField_3381", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					Text = "Do you believe the Titan of Foresight can truly see into the future, Madame? Prometheus is quite insistent about it. I'd sooner think {#Emph}you {#Prev}had such capability yourself." },
				{ Cue = "/VO/Circe_0118",
					PreLineAnim = "Circe_Pensive_Start",
					Text = "Of that which shall transpire, I can sometimes see brief glimpses, little miss; provided I devote a lot of resources and time. Prometheus, I think, may see the future uncontrollably." },
				{ Cue = "/VO/MelinoeField_3382", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "But if you knew precisely what would happen, could you not simply change it? For example, if I knew we'd have this conversation, I could have avoided the subject..." },
				{ Cue = "/VO/Circe_0119",
					PreLineAnim = "Circe_Pensive_End", 
					Text = "But then your knowledge of the future would be wrong. Such knowledge can be dangerous, besides! Our great ability to harbor hope depends upon not knowing what's to come..." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutTyphon01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutOlympus01" },
					},
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
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0122",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Portrait = "Portrait_Circe_Serious_01",
					Text = "So you have seen the great monstrosity with your own eyes, have you, poppet? Typhon, I mean, of course! Oft have I wondered about his deep connection to the natural world..." },
				{ Cue = "/VO/MelinoeField_3385", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "And what connection would {#Emph}that {#Prev}be? He's a monster, just as you said! A thing that does not belong in our world." },
				{ Cue = "/VO/Circe_0123",
					PreLineAnim = "Circe_Pensive_End", 
					Text = "Yet there he is, where you'll be going soon! Who only knows the limits of our world, and that which it contains...? Veritably not you or I, poppet! {#Emph}All that is here belongs{#Prev}, is what I say." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutTyphonW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceAboutTyphon01" },
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_MiniBoss01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 1,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0124",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End", 
					Text = "That awful storm enveloping the mountain of the gods, why just the other night, it {#Emph}cleared{#Prev}, all brilliant moonlight in its place! I thought perchance you had achieved what you'd set out to do, {#Emph}hah! Oh{#Prev}, but now you're back, and... so's the storm." },
				{ Cue = "/VO/MelinoeField_3386", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Vulnerable_01",
					Text = "It turns out the Father of All Monsters is not particularly easy to dissuade... I don't know who wants his vengeance against Lord Zeus more; Typhon, Prometheus, or Chronos. " },
				{ Cue = "/VO/Circe_0125",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "Our Lady Hecate and you seek vengeance of your own. You've met Charybdis in the Rift here, yes? An all-consuming force! When I imagine vengeance, all I see is that engulfing maw..." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutCharybdis01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "O_MiniBoss01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0148",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End", 
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "{#Emph}Oh{#Prev}, such a mess! I told Our Lady Hecate that relocating this whole isle likely would have certain side effects. But to have inadvertently brought cruel Charybdis here? Not {#Emph}here {#Prev}of course but {#Emph}close!" },

				{ Cue = "/VO/MelinoeField_3523", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelinoeIdleWeaponless", PreLineAnimTarget = "Hero",
					Text = "Now that you mention it, the giant whirlpool with tentacles and teeth {#Emph}did {#Prev}seem a little out of place in this channel." },

				{ Cue = "/VO/Circe_0149",
					Text = "At least she still has no shortage of sailing-ships to crash into her maw! She hasn't troubled you, though, has she, poppet...?" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutOlympus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0114",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "So what is even happening there at the mountain of the gods? Some nights, great plumes of flame appear on the horizon, and storm clouds, {#Emph}terrible {#Prev}as ever I have {#Emph}seen!" },
				{ Cue = "/VO/MelinoeField_3379", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The source of these phenomena is a two-pronged assault on Mount Olympus: the Titan Prometheus and his raiders, and the monster Typhon himself. I'm headed to face them." },
				{ Cue = "/VO/Circe_0115",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Circe_Serious_01",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Text = "Good heavens, you mean face them {#Emph}all{#Prev}, poppet? Although perchance the perils you confront {#Emph}beneath {#Prev}the Earth are even worse! Let me protect you then, as best I can...!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutFamily01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0039",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "I oft forget, we share some kinship, do we not? My father is the shining Sun itself, the Titan Helios. Distant accomplice to the gods! Not close with anyone. But he is... brother to the Lady Demeter, my aunt, who is your grandmother, correct...?" },
				{ Cue = "/VO/MelinoeField_1973", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh Madame Circe, right you are! That makes us cousins once removed, I think. I don't know how any of us can keep all this genealogy straight! In any case, the bond matters more than the blood, does it not?" },
				{ Cue = "/VO/Circe_0040",
					PreLineAnim = "Circe_Pensive_End", 
					Text = "Quite veritably so! Though, you'll forgive me that I've shied from all of it. Amongst family, I was expected to act differently with each and every one. I scarcely understood how to be {#Emph}me! {#Prev}Things are much simpler on this isle here." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutHope01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CirceAboutPrometheus02", "PrometheusAboutMortals03" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "CirceAboutPrometheus02" }, Min = 3 },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/MelinoeField_3383", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Some nights ago you spoke about {#Emph}our great ability to harbor hope{#Prev}. It reminded me of something that Prometheus himself had said, but I dismissed him at the time..." },
				{ Cue = "/VO/Circe_0120",
					Text = "I realize that hope is simply not enough for one who studied with such rigor as you did! Yet even you, I sense, approach each night with openness to it going your way..." },
				{ Cue = "/VO/MelinoeField_3384", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "But I make plans for every possibility, and am prepared to improvise when things inevitably don't unfold the way I want. Preparation and anticipation, not mere hope." },
				{ Cue = "/VO/Circe_0121",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "Call it whatever you prefer. But at the heart of what you describe exists a grain of something more; the source of all that drives us. Like a flame, it must be nurtured, lest it die." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutMoly01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "Resources", "PlantFMoly", },
						Comparison = ">=",
						Value = 15,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0035",
					Emote = "PortraitEmoteDepressed",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Portrait = "Portrait_Circe_Serious_01",
					Text = "Something felt {#Emph}different{#Prev}, just as you arrived. It's {#Emph}Moly{#Prev}, isn't it? And quite a {#Emph}lot{#Prev}, as I perceive! You need no such protection in this place. A miracle it does not interfere with your own craft!" },

				{ Cue = "/VO/MelinoeField_1974", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have been gathering what Moly I can find in Erebus. It has its uses to be sure, though in my purse it doesn't bother me, and remains fresh. You have an aversion to it? And here I thought that every plant and herb had earned your love." },

				{ Cue = "/VO/Circe_0036",
					PreLineAnim = "Circe_Pensive_End", 
					Portrait = "Portrait_Circe_Serious_01",
					Text = "Some earn my caution sooner than my love! Moly has a {#Emph}stifling {#Prev}effect I care for not at all! So much so, that I have learned to negate it. As you have no need of its powers here, it shall do neither of us any harm! Though, do be careful, little miss." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutCrystals01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ScreensViewed", "BountyBoard" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0037",
					Emote = "PortraitEmoteFiredUp",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End", 
					Text = "{#Emph}Ah-ha{#Prev}, I knew you would arrive just now, poppet, {#Emph}haha! {#Prev}No innate gift of foresight required, merely intuition and my crystals hereabouts. Have you incorporated any into {#Emph}your {#Prev}routine?" },
				{ Cue = "/VO/MelinoeField_1976", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well... I've learned to see into our Pitch-Black Stone! I used to think that it was there to help make us unseen, but it has other potent uses, too. Crystals! So full of potential." },
				{ Cue = "/VO/Circe_0038",
					Text = "Mother Gaia's multicolored bounty, {#Emph}oh! {#Prev}I sometimes envy that you live beneath the Earth where crystals and gemstones grow in abundance! How brilliant they all are!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutMagick01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					--
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/MelinoeField_3393", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "By the way, what are those incantations you've been working at night after night, Madame? Fortifying inner strength, concealing the island, nourishing the soil, and so on?" },
				{ Cue = "/VO/Circe_0138",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Text = "Oh, I'm mostly making supper for the piggies over there! I'd ask you dine with us at some point, though such meals are not to everybody's taste; and you have more important matters to resolve!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutKeepsake01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "BossMetaUpgradeKeepsake" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0126",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End", 
					Text = "{#Emph}Ahh{#Prev}, you brought with you my Crystal Figurine! It ought provide a bit of vigor on such dire nights as we have had of late; and catches moonlight rather beautifully, I think!" },
				{ Cue = "/VO/MelinoeField_3387", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It does, thank you, Madame. Where I come from, the beasts and flora are quite different than here. Having a symbol of those differences is valuable to me." },
				{ Cue = "/VO/Circe_0127",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "{#Emph}Oh{#Prev}, beasts and flora make for fine companions, yes? They listen! And they speak with their souls, not with duplicitous words. {#Emph}Ah{#Prev}, though come, let's get you on your way!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutFrogFamiliar01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0128",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End", 
					Text = "You have an Animal Familiar there, poppet! How marvelous to see a beast and {#Emph}you {#Prev}thus bound! Each in kind, a source of safety and support! A cyclic pattern, as {#Emph}so {#Prev}many tend to be!" },
				{ Cue = "/VO/MelinoeField_3388", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe, this is Frinos, my dear friend in whom I always can confide. In all your knowledge of Familiars, is there something you most wish that you'd known early on?" },
				{ Cue = "/VO/Circe_0129",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Text = "{#Emph}Oh{#Prev}, veritably {#Emph}yes! {#Prev}Although you mustn't try to skip through the experience of discovery along the journey you are on. But perchance there is something I might convey..." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutCirceAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				SkipPreNarrativeUnequip = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffClearCastAspect" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0043",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					Text = "How fares my {#Emph}marvelous {#Prev}Descura, little miss? I knew that you were next in line for her, though I still feel a bit emotional to see my favored staff again, {#Emph}hohoho. {#Prev}Our Lady Hecate had to do more than a {#Emph}bit {#Prev}of prodding to make me give her up, {#Emph}hehehoho!" },

				{ Cue = "/VO/MelinoeField_1975", UsePlayerSource = true,
					Text = "I've done my best to wield Descura with respect; to live up to those who possessed the Witch's Staff before me. And it... or rather she has served me well. My presence here is evidence to that. Do you... wish to hold her again?" },

				{ Cue = "/VO/Circe_0044",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Circe_Pensive_End",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "Oh, no, I mustn't! We had our time. Long had she grown heavy in my hands before I passed her on, besides. May she protect you just as fiercely as I know she can!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceGrantsHiddenAspect01 =
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
						HasAll = { "StaffClearCastAspect", "StaffSelfHitAspect" },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAny = { "StaffClearCastAspect5", "StaffSelfHitAspect5" },
					},
					NamedRequirementsFalse =
					{
						-- "StaffHiddenAspectRevealInProgress",
						"DaggerHiddenAspectRevealInProgress",
						"TorchHiddenAspectRevealInProgress",
						"AxeHiddenAspectRevealInProgress",
						"LobHiddenAspectRevealInProgress",
						"SuitHiddenAspectRevealInProgress"
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0150",
					Text = "You have been a worthy mother to Descura, I can tell. Nurtured her appetite with many souls! I therefore wish to share with you a {#Emph}dream {#Prev}I vividly recall..." },
				{ Cue = "/VO/MelinoeField_3398", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "A dream concerning me and the Staff of Dusk, Madame? That seems rather specific. Though dreams do get that way at times..." },
				{ Cue = "/VO/Circe_0151",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End", 
					Text = "In said dream, I saw what first I thought to be a jackal, all surrounded by the dead. The sight of him was marvelous, as words reverberated in my mind: {#Emph}I see you guarding graves of mortals passed into the black beyond." },
				{ Cue = "/VO/MelinoeField_3399", UsePlayerSource = true,
					-- Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}I see you guarding graves of mortals passed into the black beyond. {#Prev}That sounds like it could be a waking-phrase. So if I speak it to Descura by the Silver Pool..." },
				{ Cue = "/VO/Circe_0152",
					Text = "...Then I foresee she shall reveal to you an Aspect of herself! As her former bearer, your connection with me cannot be coincidence! Thus this knowledge ought be yours." },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2.5, Title = "HiddenAspectRevealed", Text = "HiddenAspectRevealed_Staff" },
				},
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutHiddenAspectProgress01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					NamedRequirements = { "StaffHiddenAspectRevealInProgress" },
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0153",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End", 
					Text = "Have you yet spoken with Descura as I suggested, little miss? The words have lingered with me still: {#Emph}I see you guarding graves of mortals passed into the black beyond." },
				{ Cue = "/VO/MelinoeField_3492", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have been hesitant, Madame. What if this is a power for which I'm not sufficiently prepared? If Descura wanted to reveal to me this Aspect, then why the extra step?" },
				{ Cue = "/VO/Circe_0154",
					Text = "Because some knowledge ought be passed along. Our time as bearers of Descura has an end, but our responsibility unto the realm of Night does not." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutHiddenAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffRaiseDeadAspect" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0155",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End", 
					Text = "How marvelous, you bear Descura in the Aspect that I witnessed in my dream! So then the message I relayed did resonate. What can you tell me of her newfound form?" },
				{ Cue = "/VO/MelinoeField_3493", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is the Aspect of a god of the dead... not my father, but a being called Anubis. Distant to us either in place or time, but a protector of the Underworld in his own right. Thank you for leading me to this discovery." },
				{ Cue = "/VO/Circe_0156",
					Text = "Of course, of course, poppet! Anubis, was it then? To think that there are gods of the dead besides your father! But if the Fates charged {#Emph}him {#Prev}with the responsibility, perchance they charged others as well... or shall do so eventually." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceGrantsFamiliarCostumes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				StatusAnimation = "StatusIconWantsToTalkImportant_NPC",
				GameStateRequirements =
				{
					{
						Path = { "GameState", "LifetimeResourcesGained", "FamiliarPoints" },
						Comparison = ">=",
						Value = 20,
					},
					{
						Path = { "GameState", "MaxMetaUpgradeCostCache" },
						Comparison = ">=",
						Value = 30,
					},
					{
						Path = { "GameState", "FamiliarsUnlocked" },
						HasAll = { "FrogFamiliar", "RavenFamiliar", "CatFamiliar", "HoundFamiliar", "PolecatFamiliar" },
					},
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "FamiliarUpgrades" },
								HasAll = GameData.AllFrogFamiliarUpgrades,
							},
						},
						{
							{
								Path = { "GameState", "FamiliarUpgrades" },
								HasAll = GameData.AllRavenFamiliarUpgrades,
							},
						},
						{
							{
								Path = { "GameState", "FamiliarUpgrades" },
								HasAll = GameData.AllCatFamiliarUpgrades,
							},
						},
						{
							{
								Path = { "GameState", "FamiliarUpgrades" },
								HasAll = GameData.AllHoundFamiliarUpgrades,
							},
						},
						{
							{
								Path = { "GameState", "FamiliarUpgrades" },
								HasAll = GameData.AllPolecatFamiliarUpgrades,
							},
						},
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0250",
					Text = "I am impressed with how you've cared for your Familiars, poppet! By the will of Our Lady Hecate, I possess certain knowledge of the subject I now shall yield to you." },
				{ Cue = "/VO/MelinoeField_4531", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Oh, thank you Madame! Which sort of knowledge do you have in mind? You must know beasts better than anyone." },
				{ Cue = "/VO/Circe_0251",
					Emote = "PortraitEmoteSparkly",
					Text = "You'll see, {#Emph}you'll see! {#Prev}This is a favorite of mine, and so it's not my wish to spoil the surprise!" },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2.5, Title = "WorldUpgradeAdded", Text = "WorldUpgradeFamiliarCostumeSystem" },
				},
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceAboutFamiliarCostumes01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFamiliarCostumeSystem" }
					},
					OrRequirements =
					{
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsAny = { "FrogFamiliar" },
							},
							{
								Path = { "GameState", "FamiliarCostumes", "FrogFamiliar" },
								IsNone = { "FamiliarCostume_FrogDefault" },
							},
						},
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsAny = { "RavenFamiliar" },
							},
							{
								Path = { "GameState", "FamiliarCostumes", "RavenFamiliar" },
								IsNone = { "FamiliarCostume_RavenDefault" },
							},
						},
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsAny = { "CatFamiliar" },
							},
							{
								Path = { "GameState", "FamiliarCostumes", "CatFamiliar" },
								IsNone = { "FamiliarCostume_CatDefault" },
							},
						},
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsAny = { "HoundFamiliar" },
							},
							{
								Path = { "GameState", "FamiliarCostumes", "HoundFamiliar" },
								IsNone = { "FamiliarCostume_HoundDefault" },
							},
						},
						{
							{
								Path = { "GameState", "EquippedFamiliar" },
								IsAny = { "PolecatFamiliar" },
							},
							{
								Path = { "GameState", "FamiliarCostumes", "PolecatFamiliar" },
								IsNone = { "FamiliarCostume_PolecatDefault" },
							},
						},
					}
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0252",
					Text = "{#Emph}Ah{#Prev}, I almost didn't recognize that Animal Familiar of yours, which means you've made {#Emph}good {#Prev}use of Alteration of Familiar Forms! {#Emph}Hah! {#Prev}Have your little beasts enjoyed the big change?" },
				{ Cue = "/VO/MelinoeField_4533", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkExplaining01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "They've issued no complaints! Though what changes I've seen only seem to affect their outward appearance. Is that the intended result?" },
				{ Cue = "/VO/Circe_0253",
					Emote = "PortraitEmoteSparkly",
					Text = "Why, yes, of course! It's the Familiar's equivalent to a change of dress or style. Of late, we've little time for such indulgences ourselves, but at least we can pamper our friends!" },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceLowHealth01 =
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
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0130",
					Emote = "PortraitEmoteDepressed",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End", 
					Portrait = "Portrait_Circe_Serious_01",
					Text = "{#Emph}Eugh{#Prev}, what a ghastly aura that you have, if I'm to be candid here, poppet! Such suffering you've already endured this eve; forgive me, but you mustn't stay for long..." },

				{ Cue = "/VO/MelinoeField_3389", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Forgive my wretched state, Madame. The waters have been disagreeable, to say nothing of the vast necropolis I'm forced to navigate. But all this merely is excuse-making..." },

				{ Cue = "/VO/Circe_0131",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "Well let me offer you what aid I may, but heavens, do {#Emph}not {#Prev}wallow anymore! You haven't time enough for it! Worse comes to worst, return to shadow, rest, and then press on." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CircePostTrueEnding01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0240",

					Emote = "PortraitEmoteDepressed",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "Where have you been for all these nights, poppet? So many oddities took place, each {#Emph}stranger {#Prev}than the last! Those ghastly sailing-ships out there {#Emph}all {#Prev}seemed to lose their {#Emph}course{#Prev}, for one. I know not what occurred!" },

				{ Cue = "/VO/MelinoeField_4534", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Chronos is defeated, Madame... and I mean for good! That's likely why his forces have been notably disorganized, although they're not gone, and neither is he. Has Headmistress not communicated this?" },

				{ Cue = "/VO/Circe_0241",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Circe_Serious_01",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Circe_Default_01", WaitTime = 7.8 },

					Text = "Good heavens, why, why, why, why, {#Emph}no!  {#Prev}Unless... well, I can be very isolated here, perchance I missed some message she relayed, I... {#Emph}oh! {#Prev}So then you mean to tell me you're victorious?" },

				{ Cue = "/VO/MelinoeField_4535", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, {#Emph}yes! {#Prev}What now remains is to ensure he'll not rise up against the gods again, ever. He or Typhon." },

				{ Cue = "/VO/Circe_0242",
					Emote = "PortraitEmoteSurprise",
					PreLineAnim = "Circe_Greet",
					Text = "{#Emph}Oh! Ah, oh, my... hah, oh my{#Prev}, this is, {#Emph}oh! {#Prev}I must confer with Our Lady Hecate at once! But first, please, quickly, make your choice!" },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CircePostTrueEnding02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0244",
					Text = "Our Lady Hecate confirmed each detail of what you have achieved, although with {#Emph}far {#Prev}less modesty than you! {#Emph}Oh... {#Prev}such an accomplishment, poppet...!" },

				{ Cue = "/VO/MelinoeField_4536", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you, Madame Circe. If not for your enchantments I might never have gained the summit of Olympus, which was a necessary step. You don't mind if we keep on like this?" },

				{ Cue = "/VO/Circe_0245",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",

					Text = "{#Emph}Oh {#Prev}I would mind if we no longer did! So long as you have more to do, you can veritably count on my contribution!" },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CircePostTrueEnding03 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0246",
					Text = "The weather on Olympus has been better recently, as I oft see it clear! No trace of the monstrosity you faced before." },

				{ Cue = "/VO/MelinoeField_4537", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Traces of Typhon do remain, though they are nearly imperceptible. But they can be destroyed." },

				{ Cue = "/VO/Circe_0247",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End",

					Text = "And you are headed to the mountain to achieve just that. Typhon was not exactly a natural being; that is what distinguishes a monster from a beast! So I shall not lament his passing, nor shall anybody, I expect." },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CircePostEpilogue01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				InitialGiftableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "FatesEpilogue01", "HecateBathHouseEpilogue01" }
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0248",
					Text = "Our Lady Hecate informs me of a marvelous development... you had a brush with the Three Fates? Scarce few are able to lay claim to {#Emph}that, hah! Ooh... {#Prev}did you happen to see their palms?" },

				{ Cue = "/VO/MelinoeField_4538", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Hesitant_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, unfortunately, Madame, as they were rather shrouded in the darkness where I encountered them. What do you make of this new prophecy of theirs...?" },

				{ Cue = "/VO/Circe_0249",
					Emote = "PortraitEmoteFiredUp",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",

					Text = "What, that the times eventually shall {#Emph}change? Hah! {#Prev}I find it to be {#Emph}not {#Prev}their boldest prediction, since you asked! Live long enough, and you shall see that times do {#Emph}not {#Prev}change, so much as turn like a wheel." },

				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},


			-- Repeatable
			CirceChat01 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0005",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",
					Text = "Whilst I could turn you into almost anything, {#Emph}I {#Prev}think you're {#Emph}very nearly perfect {#Prev}as you are!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat02 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0006",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Text = "I bid you make yourself at home, although I know you cannot stay for very long. Your palms?" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat03 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0007",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Oh! {#Prev}I ought to have some sort of salve, potion, or poultice here that suits you very well indeed!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat04 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0008",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Text = "Do remember that we cannot change who we are, poppet. Only {#Emph}what. {#Prev}Now, then: your palms." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat05 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0009",
					Text = "{#Emph}Ohh{#Prev}, how fortuitous that we have met again on an enchanting evening such as this!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat06 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0010",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Text = "My existence here is quite a peaceful one. I highly recommend it once your warring is complete!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat07 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0011",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Text = "There is no need for words whilst on the Isle of Aiaia, little miss. A look from you already says it all!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat08 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0012",
					Text = "I would invite you to stay for tea, yet know you have to hurry on your way. Some other circumstance?" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat09 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0013",
					Emote = "PortraitEmoteCheerful",
					Text = "My piggies all were squealing with delight when I foretold you would be visiting again this eve!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat10 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0014",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Text = "It's not so oft my piggies and I welcome visitors, as this little isle's practically impossible to find!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat11 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0015",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Text = "You are welcome here and safe, little miss! Breathe deeply, and relax your shoulders and your mind..." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat12 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0016",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteCheerful", WaitTime = 6.1 },
					Text = "We cannot change ourselves {#Emph}entirely{#Prev}, poppet, but: We can change our fortunes up a bit! {#Emph}Hahaha, haha!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat13 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0017",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Emote = "PortraitEmoteCheerful",
					Text = "My, but you are turning into such an {#Emph}enchanting young goddess{#Prev}, night upon night!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat14 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0018",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Text = "I'd not change a thing about you, poppet. But I can! We'll make it temporary just in case!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat15 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0019",
					Text = "The mountain of the gods is not so very far beyond! Let's make you ready for that {#Emph}brutal {#Prev}climb!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat16 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0020",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Text = "To live is but to undergo a constant series of small transformations, little miss." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat17 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0021",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteCheerful", WaitTime = 5.8 },
					Text = "Your thoughts and choices make you who you are, but I could make you something {#Emph}more!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat18 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0022",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Text = "We all seek to find our true selves, yet oft the search is long and difficult! So let us go prepared." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat19 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0023",
					PreLineThreadedFunctionArgs = { Name = "Circe_Pensive_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Pensive_End",
					Text = "My little hut is just embarrassingly unpresentable! Not that anyone shall know, other than me." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat20 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0024",
					Text = "Within my crystals I foresaw your voyaging this eve, and am so pleased you took my invitation to return!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat21 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0025",
					Text = "A welcome sight upon a ghastly night! But we shall change it for the better here." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat22 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0026",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Text = "We are by nature not immutable, and to transform ourselves is to become {#Emph}who we are..." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

		},

		GiftTextLineSets =
		{
			CirceGift01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1943", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe, I'm grateful that we had a chance to meet again after all this time. Your kindness to me always meant a lot, and I wanted to give you this small token in return." },
				{ Cue = "/VO/Circe_0060",
					Emote = "PortraitEmoteCheerful",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",
					Text = "{#Emph}Nectar! Ohh, thank you{#Prev}, little miss! I've made attempts to brew my own but never get it right! Though why don't you take {#Emph}this {#Prev}in kind? Think of it as a little island souvenir!" },
			},
			CirceGift02 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
				},
				{ Cue = "/VO/Circe_0061",
					Emote = "PortraitEmoteSurprise",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Text = "Good heavens! More, for {#Emph}me? {#Prev}I'm unaccustomed to receiving gifts here on my little isle. Though I'm pleased to try and get more used to it, {#Emph}ahaha! {#Prev}If you must so {#Emph}insist!" },
				{ Cue = "/VO/MelinoeField_1945", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Insist {#Prev}is a strong word, Madame, but I would like for you to have this, yes. Perhaps it will help you perfect your own recipe... or while away a pleasant night, should one arise." },
			},
			CirceGift03 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
				},
				{ Cue = "/VO/Circe_0157",
					Emote = "PortraitEmoteCheerful",
					Text = "Not all divinities require offerings, you know. Our Olympian relatives... they have come to expect this type of giving, but not I! Do not presume to spoil me!" },
				{ Cue = "/VO/MelinoeField_3524", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Olympus is well-accustomed to receiving offerings from all across the land. Living here on this remote island, I don't think you're at risk of getting quite as used to it as that!" },
			},
			CirceGift04 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
				},
				{ Cue = "/VO/Circe_0158",
					Emote = "PortraitEmoteCheerful",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Text = "{#Emph}Well{#Prev}, this is {#Emph}marvelous! {#Prev}I'm grateful, little miss! Our kind oft lack for company; to have another such as you to visit me from time to time, it's been a welcome turn, despite the ghastly work that is at hand, {#Emph}hahahaha!" },
				{ Cue = "/VO/MelinoeField_3525", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Even if and when all this is over at some point, I still would like if we kept meeting up like this. Your island is a wonderful place, and I truly admire your commitment to our craft." },
			},
			CirceGift05 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
				},
				{ Cue = "/VO/Circe_0231",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Text = "At times I worry that your heart must have grown cold... hardened to all the turmoil. But then, you show me kindness such as this! You have learned much, though this propensity appears to be innate!" },
				{ Cue = "/VO/MelinoeField_4521", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Oh{#Prev}, I... it's just Nectar, which must not be too easy to come by here. They're even lacking for it on Olympus recently! But, I'm grateful that you see in me whatever it is you think is there." },
			},
			CirceGift06 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
					},
				},
				{ Cue = "/VO/Circe_0232",
					PreLineThreadedFunctionArgs = { Name = "Circe_Explaining_Start", WaitTime = 0.5, AngleNPCToHero = true, },
					PostLineAnim = "Circe_Explaining_End",
					Text = "{#Emph}Oh {#Prev}why thank you so much, little miss, {#Emph}again! {#Prev}The Nectar you bring tastes so sweet and yet, my feelings for it are becoming {#Emph}clouded {#Prev}recently... so let this be the last for now...?" },

				{ Cue = "/VO/MelinoeField_4522", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Madame Circe, was it something I did or said? You're left to your own devices on your island here, and so I thought perhaps you might enjoy a bit of an exotic good..." },

				{ Cue = "/VO/Circe_0159",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End",
					Portrait = "Portrait_Circe_Serious_01",
					Text = "And that I do! But I'm reminded, with each bottle, of a life I led filled with great luxuries... most all of which I've left behind. And I shall not go back." },

				{ Cue = "/VO/MelinoeField_4523", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I fully understand. But thank you truly, Madame. For all your wisdom, and for making me your guest." },
			},
			CirceGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_CirceUnlockHint01",
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
						HasAll = { "CirceGift06", "CirceAboutLearning01" },
					},
				},

				{ Cue = "/VO/MelinoeField_4525", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I know you have no want of Nectar at the moment, Madame, but I thought perhaps you might be interested in this? For your enchantments, or even your animal companions." },

				{ Cue = "/VO/Circe_0236",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Oh! {#Prev}Why if it isn't {#Emph}Ambrosia! {#Prev}A precious gift, even a source of marvelous light during these darker evenings! What is occasion for this, for it must have slipped {#Emph}my {#Prev}mind?" },

				{ Cue = "/VO/MelinoeField_4526", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well, seeing as you've taught me more of how to manifest my will... I figure this can become a special occasion through the act itself, can't it?" },

				{ Cue = "/VO/Circe_0237",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 
					Emote = "PortraitEmoteCheerful",
					Text = "It veritably {#Emph}can, thank {#Prev}you! Then, to the fortune of our meetings, here and hence! As to whether I shall keep this or share it with my piggies, I shall have to ponder for a while..." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/MelinoeField_4527", Text = "Please enjoy it!" },
					},
				},
			},
			-- bond forged
			CirceGift08 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				CompletedHintId = "Codex_BondForgedCirce",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "CirceGift07" },
					},
				},

				{ Cue = "/VO/MelinoeField_4528", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "You mentioned that you weren't certain whether to keep the previous Ambrosia or share it with your piggies. Please, allow me to alleviate this impossible dilemma." },

				{ Cue = "/VO/Circe_0238",
					PreLineAnim = "Circe_Explaining_Start",
					PostLineAnim = "Circe_Explaining_End",
					Emote = "PortraitEmoteCheerful",
					Text = "Oh well then {#Emph}this {#Prev}one must be for keeping, naturally! Because last time my piggies {#Emph}definitely {#Prev}had their fill. I never realized Our Lady Hecate taught you to be {#Emph}so generous!" },

				{ Cue = "/VO/MelinoeField_4529", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Empathetic_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Headmistress taught me to protect myself, to stay focused, and much more. But what I know of generosity is certainly in no small part because of you, Madame. There was always more warmth at the Crossroads when you were around." },

				{ Cue = "/VO/Circe_0239",
					PreLineAnim = "Circe_Pensive_Start",
					PostLineAnim = "Circe_Pensive_End", 

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Circe_01", Icon = "Keepsake_Circe" },

					Text = "Well, that is kind of you to say... but I'm not widely known for my warmth, you know. You merely brought it out in me, as you have done again just now! So... thank you very much." },

				EndVoiceLines =
				{
					{
						PreLineWait = 0.4,
						UsePlayerSource = true,
						RequiredMinElapsedTime = 3,
						{ Cue = "/VO/MelinoeField_4530", Text = "You're most welcome." },
					},
				},
			},
		},
		GiftGivenVoiceLines =
		{
			BreakIfPlayed = true,
			PreLineWait = 1.0,
			PlayFromTarget = true,

			{ Cue = "/VO/MelinoeField_1944", Text = "It's beautiful, and quite adorable! Thank you!" },
		},

		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.25,
			ObjectType = "NPC_Circe_01",
			GameStateRequirements =
			{
				{
					PathFromArgs = true,
					Path = { "SourceProjectile", },
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "ShadeMercSpiritball" },
				},
			},
			SkipCooldownCheckIfNonePlayed = true,
			Cooldowns =
			{
				{ Name = "CirceSpokeRecently", Time = 10 },
			},

			{ Cue = "/VO/Circe_0178", Text = "{#Emph}Peace{#Prev}, little miss!" },
			{ Cue = "/VO/Circe_0179", Text = "{#Emph}Oh{#Prev}, come now." },
			{ Cue = "/VO/Circe_0180", Text = "Some other time, perchance?" },
			{ Cue = "/VO/Circe_0181", Text = "Not on these grounds.", PlayFirst = true },
			{ Cue = "/VO/Circe_0182", Text = "Please save your strength." },
			{ Cue = "/VO/Circe_0183", Text = "{#Emph}Relax {#Prev}a little, please." },
		},
	},
}

-- Global Circe Lines
GlobalVoiceLines.CirceGreetingLines =
{
	Queue = "Interrupt",
	{
		{
			RandomRemaining = true,
			ObjectType = "NPC_Circe_01",
			PreLineAnim = "Circe_Greet",
			Cooldowns =
			{
				{ Name = "CirceSpokeRecently", Time = 9 },
			},

			{ Cue = "/VO/Circe_0078", Text = "Is that who I think it is?", PlayFirst = true },
			{ Cue = "/VO/Circe_0079", Text = "{#Emph}Oh! {#Prev}Hullo!" },
			{ Cue = "/VO/Circe_0080", Text = "Oh, you're {#Emph}back!" },
			{ Cue = "/VO/Circe_0081", Text = "Welcome back!" },
			{ Cue = "/VO/Circe_0082", Text = "I knew you would arrive!" },
			{ Cue = "/VO/Circe_0083", Text = "You're {#Emph}just {#Prev}in time!" },
			{ Cue = "/VO/Circe_0085", Text = "{#Emph}Piggies{#Prev}, look who's back!" },
			{ Cue = "/VO/Circe_0086", Text = "How very {#Emph}fortunate!" },
			{ Cue = "/VO/Circe_0087", Text = "Come, don't be shy!" },
			{ Cue = "/VO/Circe_0088", Text = "It's {#Emph}you!" },
			{ Cue = "/VO/Circe_0089", Text = "{#Emph}There {#Prev}you are!" },
			{ Cue = "/VO/Circe_0303", Text = "{#Emph}Ah{#Prev}, welcome!" },
			{ Cue = "/VO/Circe_0305", Text = "We welcome you!" },
			{ Cue = "/VO/Circe_0306", Text = "She's back, piggies!" },
			{ Cue = "/VO/Circe_0307", Text = "Oh hullo again..." },
			{ Cue = "/VO/Circe_0308", Text = "{#Emph}Erm{#Prev}, hullo!" },
			{ Cue = "/VO/Circe_0309", Text = "{#Emph}Erm, oh!" },
			{ Cue = "/VO/Circe_0304", Text = "It's been too long!",
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceGift02" },
					},
					{
						SumPrevRuns = 5,
						IgnoreCurrentRun = true,
						Path = { "RoomsEntered", "O_Story01" },
						Comparison = "<=",
						Value = 0,
					},
				},
			},
			{ Cue = "/VO/Circe_0084", Text = "Little miss!",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CirceGift02" },
					},
				},
			},
		},
		{
			RandomRemaining = true,
			UsePlayerSource = true,
			SuccessiveChanceToPlay = 0.15,
			Cooldowns =
			{
				{ Name = "MelinoeAnyQuipSpeech" },
			},

			{ Cue = "/VO/MelinoeField_1887", Text = "{#Emph}Erm{#Prev}, pardon...!", PlayFirst = true },
			{ Cue = "/VO/MelinoeField_1888", Text = "Madame Circe!" },
			{ Cue = "/VO/MelinoeField_1889", Text = "Hail, Madame." },
		},
	},
}

GlobalVoiceLines.CirceChanting =
{
	{
		PreLineWait = 0.25,
		RandomRemaining = true,
		ObjectType = "NPC_Circe_01",
		SubtitleMinDistance = 3200,

		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "CirceInterrupt" },
			},
		},

		{ Cue = "/VO/Circe_0062", Text = "{#Emph}Fang and feather, tuft of wool, \n {#Emph}Dusky wing and horn of bull," },
		{ Cue = "/VO/Circe_0063", Text = "{#Emph}Little seeds and bigger fronds, \n {#Emph}Stones from rivers, moss from ponds," },
		{ Cue = "/VO/Circe_0064", Text = "{#Emph}Bubble, tea leaves, ocean breeze, \n {#Emph}Briar thorns, and wax of bees," },
		{ Cue = "/VO/Circe_0065", Text = "{#Emph}Gust of wind, and spray of sea, \n	{#Emph}Clump of soil, branch of tree," },

		{ Cue = "/VO/Circe_0066", Text = "{#Emph}Apple pieces, olives, figs, \n {#Emph}Ginger roots and cypress twigs," },
		{ Cue = "/VO/Circe_0067", Text = "{#Emph}Lichen, garlic, bark of pine, \n {#Emph}Dash of oil, drop of wine," },
		{ Cue = "/VO/Circe_0068", Text = "{#Emph}Cap of mushroom, skin of snake, \n {#Emph}Lemon juice and sand of lake," },
		{ Cue = "/VO/Circe_0069", Text = "{#Emph}Coiled vine and peat of fens, \n {#Emph}Sugar beets and egg of hens," },

		{ Cue = "/VO/Circe_0070", Text = "{#Emph}Onyx crystal, Python scale, \n {#Emph}Morning dew, and fingernail," },
		{ Cue = "/VO/Circe_0071", Text = "{#Emph}Silk of spider, tooth of shark, \n {#Emph}Ray of light, and mote of dark," },
		{ Cue = "/VO/Circe_0072", Text = "{#Emph}Heap of soil, chip of stone, \n {#Emph}Harpy feather, knuckle bone," },
		{ Cue = "/VO/Circe_0073", Text = "{#Emph}Cotton-plant and shard of flint, \n {#Emph}Cherry pit and sprig of mint," },

		{ Cue = "/VO/Circe_0291", Text = "{#Emph}Sprig of barley, sheet of ice, \n {#Emph}Moonlight feather, fur of mice," },
		{ Cue = "/VO/Circe_0292", Text = "{#Emph}Golden petals, spider silk, \n {#Emph}Flower pollen, cattle milk," },
		{ Cue = "/VO/Circe_0293", Text = "{#Emph}Chamomile and grain of rice, \n {#Emph}Cinnamon and cube of ice," },

		{ Cue = "/VO/Circe_0294", Text = "{#Emph}Lentil pulses, powdered sage, \n {#Emph}Salt of mountain, ripe of age," },
		{ Cue = "/VO/Circe_0295", Text = "{#Emph}Secret spices, chicken stock, \n {#Emph}Bitter greens and butter block," },
		{ Cue = "/VO/Circe_0296", Text = "{#Emph}Pleasant dreams and sound of bells, \n {#Emph}Sesame and snail shells," },

		{ Cue = "/VO/Circe_0297", Text = "{#Emph}Ocean foam and coral reef, \n {#Emph}Golden dust and myrtle leaf," },
		{ Cue = "/VO/Circe_0298", Text = "{#Emph}Bit of charcoal, rabbit foot, \n {#Emph}Splintered wood with fire-soot," },
		{ Cue = "/VO/Circe_0299", Text = "{#Emph}Clove of garlic, evening-dew, \n {#Emph}Iris flowers, but a few," },
	},
}
GlobalVoiceLines.CirceChantingWrapUp =
{
	{
		PreLineWait = 0.25,
		RandomRemaining = true,
		ObjectType = "NPC_Circe_01",
		-- SubtitleMinDistance = 1200,
		PostLineEvents =
		{
			{
				Threaded = true,
				FunctionName = "WitchPostSpellPresentation",
				Args =
				{
					Animation = "Circe_Casting_End",
				},
			},
		},
		GameStateRequirements = 
		{
			{
				PathFalse = { "CurrentRun", "TriggerRecord", "CirceInterrupt" },
			},
		},

		{ Cue = "/VO/Circe_0074", Text = "{#Emph}Bit of toadstool, claw of cat, \n {#Emph}Heat it, stir it, that is that!" },
		{ Cue = "/VO/Circe_0075", Text = "{#Emph}Hoof of pig, and fur of hound, \n {#Emph}Brew a potion, safe and sound!" },
		{ Cue = "/VO/Circe_0076", Text = "{#Emph}Moly petals, I've a lot! \n {#Emph}Boil, simmer, in my pot!" },
		{ Cue = "/VO/Circe_0077", Text = "{#Emph}Bask in Moonlight, all of you, \n	{#Emph}Till you be this witch's brew!" },
		{ Cue = "/VO/Circe_0300", Text = "{#Emph}Pinch of sugar, sap of oak, \n {#Emph}Stand aside and let it soak!" },
		{ Cue = "/VO/Circe_0301", Text = "{#Emph}Form a circle, think afar, \n {#Emph}Seal the contents in a jar!" },
		{ Cue = "/VO/Circe_0302", Text = "{#Emph}Powdered crystal, orange zest, \n {#Emph}Now my will be manifest!" },	},
}

GlobalVoiceLines.MiscEndVoiceLines_Circe =
{
	GameStateRequirements =
	{
		{
			Path = { "CurrentRun", "TextLinesRecord" },
			HasNone = { "CirceAboutOdysseusQuest01" },
		},
	},
	{
		PreLineWait = 0.45,
		ObjectType = "NPC_Circe_01",
		AllowTalkOverTextLines = true,
		PreLineAnim = "Circe_Salute",
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "TextLinesRecord" },
				HasAny = { "CircePostTrueEnding01" },
			},
		},
		{ Cue = "/VO/Circe_0243", Text = "Now off with you, {#Emph}hmhm!" },
	},
	{
		RandomRemaining = true,
		PreLineWait = 0.45,
		ObjectType = "NPC_Circe_01",
		AllowTalkOverTextLines = true,
		PreLineAnim = "Circe_Bless",
		GameStateRequirements =
		{
			{
				PathFalse = { "CurrentRun", "SpeechRecord", "/VO/Circe_0243" },
			},
		},

		{ Cue = "/VO/Circe_0090", Text = "So mote it be!" },
		{ Cue = "/VO/Circe_0091", Text = "So mote it be." },
		{ Cue = "/VO/Circe_0092", Text = "Then very well!" },
		{ Cue = "/VO/Circe_0093", Text = "Then you shall have it." },
		{ Cue = "/VO/Circe_0094", Text = "Then you shall have it!" },
		{ Cue = "/VO/Circe_0095", Text = "Bless you, poppet." },
		{ Cue = "/VO/Circe_0096", Text = "That is your will!" },
		{ Cue = "/VO/Circe_0097", Text = "Go now with grace." },
		{ Cue = "/VO/Circe_0098", Text = "Isn't it marvelous?" },
		{ Cue = "/VO/Circe_0099", Text = "Be safe!" },
		{ Cue = "/VO/Circe_0100", Text = "It is done!" },
		{ Cue = "/VO/Circe_0101", Text = "Our Lady protect you." },
		{ Cue = "/VO/Circe_0287", Text = "How you've grown!",
			PlayFirst = true,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "CirceEnlargeTrait" },
				},
			},
		},
		{ Cue = "/VO/Circe_0288", Text = "You are all grown up!",
			PlayFirst = true,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "CirceEnlargeTrait" },
				},
			},
		},
		{ Cue = "/VO/Circe_0289", Text = "How darling!",
			PlayFirst = true,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "CirceShrinkTrait" },
				},
			},
		},
		{ Cue = "/VO/Circe_0290", Text = "{#Emph}Ohh {#Prev}look at {#Emph}you!",
			PlayFirst = true,
			PreLineWait = 0.65,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasAny = { "CirceShrinkTrait" },
				},
			},
		},
		{ Cue = "/VO/Circe_0243", Text = "Now off with you, {#Emph}hmhm!",
			GameStateRequirements =
			{
				{
					SumPrevRuns = 8,
					Path = { "SpeechRecord", "/VO/Circe_0243" },
					CountPathTrue = true,
					Comparison = "<=",
					Value = 0,
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.28,
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasAny = { "CirceShrinkTrait", "CirceEnlargeTrait" },
			},
		},

		{ Cue = "/VO/MelinoeField_2049", Text = "Did it work...?", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_2050", Text = "Am I...? Oh." },
		{ Cue = "/VO/MelinoeField_2051", Text = "I feel a little off..." },
		{ Cue = "/VO/MelinoeField_2052", Text = "What have I done..." },
		{ Cue = "/VO/MelinoeField_2053", Text = "Everything looks so big...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "CirceEnlargeTrait" },
				},
			},
		},
		{ Cue = "/VO/MelinoeField_2054", Text = "I'm Titan-sized...",
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "Hero", "TraitDictionary" },
					HasNone = { "CirceShrinkTrait" },
				},
			},
		},
	},
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.65,
		UsePlayerSource = true,
		SuccessiveChanceToPlay = 0.25,
		AllowTalkOverTextLines = true,
		GameStateRequirements =
		{
			{
				Path = { "CurrentRun", "Hero", "TraitDictionary" },
				HasNone = { "CirceShrinkTrait", "CirceEnlargeTrait" },
			},
		},

		{ Cue = "/VO/MelinoeField_1894", Text = "Thank you, Madame.", PlayFirst = true },
		{ Cue = "/VO/MelinoeField_1895", Text = "That's potent..." },
		{ Cue = "/VO/MelinoeField_1896", Text = "{#Emph}Ooh..." },
		{ Cue = "/VO/MelinoeField_1897", Text = "Felt that for sure..." },
	},
	{ GlobalVoiceLines = "ThankingCharacterVoiceLines" },
}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Circe )