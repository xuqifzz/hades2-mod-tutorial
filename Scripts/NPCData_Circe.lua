UnitSetData.NPC_Circe =
{
	-- Circe, Id = TKTK
	NPC_Circe_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },

		Portrait = "Portrait_Circe_Default_01",
		AnimOffsetZ = 250,
		Groups = { "NPCs" },
		SpeakerName = "Circe",
		SubtitleColor = Color.CirceVoice,

		RequiredRoomInteraction = true,

		ActivateRequirements =
		{
			-- None
		},
		InvincibubbleScale = 1.0,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		RepulseOnMeleeInvulnerableHit = 5,

		UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,

		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
		UpgradeSelectedSound = "/SFX/TitanBloodDropSFX",
		MenuTitle = "CirceChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Circe",
		
		Traits = 
		{
			"CirceShrinkTrait",
			"CirceEnlargeTrait",
			"ArcanaRarityTrait",
			"HealAmplifyTrait",
			"DoubleFamiliarTrait",
			"RemoveShrineTrait",
			"RandomArcanaTrait",
		},
		FlavorTextIds =
		{
			"CirceChoiceMenu_FlavorText01",
		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				-- PathTrue = { "GameState", "UseRecord", "NPC_Circe_01" },
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
			[2] = GlobalVoiceLines.SaluteVoiceLines,
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Circe_01",

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
							IsAny = { "/VO/Melinoe_2785" },
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
				GameStateRequirements =
				{
					{
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0002",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Oh{#Prev}, well, isn't this marvelous! How you've {#Emph}grown{#Prev}, little miss! Do you remember Circe the Enchantress still? {#Emph}Ah? {#Prev}Oh, no matter, {#Emph}hahaha. {#Prev}Not the circumstances for small talk! Show me your palms." },
				{ Cue = "/VO/MelinoeField_1756", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Of course I remember you, Madame Circe! So this is your famous island! Such a relief to be here rather than another drowned ship. I take it we're not meeting by chance?" },
				{ Cue = "/VO/Circe_0003",
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
					Text = "You and I are much alike in that our Lady Hecate discovered us when most we needed someone such as her, poppet. Perchance, her similar affinity for beasts made her take some pity on me then... a witch, amongst the polecats and the pigs!" },
				{ Cue = "/VO/MelinoeField_1981", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Take pity on you, how? That doesn't sound like the Headmistress I know. She has always thought highly of you, and depends on you to be our eyes here at this key juncture." },
				{ Cue = "/VO/Circe_0052",
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
					Text = "How you were {#Emph}always {#Prev}at your studies, little miss! That you are here suggests how much you have achieved. I always wanted you to visit me; you used to say it was {#Emph}impossible!" },
				{ Cue = "/VO/MelinoeField_1940", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It turns out even prophecies of the Three Fates are circumventable. Though, I still have much to learn... or so I keep reminding myself night after night. How about you? You must have perfect mastery over our craft by now!" },
				{ Cue = "/VO/Circe_0030",
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
					Text = "{#Emph}Fie {#Prev}on that never-ending fleet of ghastly sailing-ships, all headed for the mountain of the gods, {#Emph}hah! {#Prev}My little isle sometimes gets {#Emph}right {#Prev}in the way! No hospitality awaits their boorish crews, {#Emph}ahaha! {#Prev}Whilst {#Emph}I {#Prev}replenish my supply of firewood." },
				{ Cue = "/VO/MelinoeField_1941", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You must long for the days when your island was more secluded, and had much less unwanted company. I hope I'm not disturbing your peace, Madame!" },
				{ Cue = "/VO/Circe_0032",
					Emote = "PortraitEmoteSurprise",
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
					Text = "Welcome, poppet! Though forgive me that I've not invited you {#Emph}inside {#Prev}my little hut. Such hospitality I don't extend to anyone, {#Emph}hmhm! {#Prev}And I make no exceptions, not even for you!" },
				{ Cue = "/VO/MelinoeField_1942", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe, that is perfectly all right, and there's no need to explain. We all live in seclusion in our own way. What other way is there? With privacy comes peace of mind." },
				{ Cue = "/VO/Circe_0034",
					Text = "I'm grateful that you understand. Of late, I share my simple home with beasts but that is all! This Isle of Aiaia is not mine of course; rather, it's my dear companion, and can be {#Emph}yours. {#Prev}So please, help yourself to anything you need whilst here." },
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
						Value = 20,
					},
					{
						Path = { "GameState", "MetaUpgradeUnlockedCountCache" },
						Comparison = ">=",
						Value = 12,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0041",
					Text = "Our Lady Hecate would sometimes tell me of your progress, and let on that you attuned to the Altar of Ashes at long last, {#Emph}hoho! {#Prev}How marvelous... for the Arcana have so much to offer us." },
				{ Cue = "/VO/MelinoeField_1977", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I couldn't agree more. Through grasping the Arcana, I've discovered strength I never realized I had. To think I used to use our Altar merely to collect my thoughts." },
				{ Cue = "/VO/Circe_0042",
					Text = "Collecting one's thoughts is valuable enough! Mine own at least are prone to scattering. As for your innate strength and magickal acuity, perchance we shall discover even more." },
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
					Text = "How lately is the temperament of our Lady Hecate? Long has it been since last I basked in her wisdom; for I have wisdom of my own, she says! You must have needed her attention more than I..." },
				{ Cue = "/VO/MelinoeField_1980", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe, I... I did not mean to deny you her attention. Although Headmistress has been preoccupied not just with my training, but with leading the Unseen, warding the Crossroads against any harm, readying our plans to take back what's ours. She's counting on us... on you." },
				{ Cue = "/VO/Circe_0050",
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
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And may Selene's light ever shine for us, Madame. I'd likely not have found my way to you if not for her. As for her magick... sometimes I wonder if it isn't transforming me, so much as revealing who I really am." },
				{ Cue = "/VO/Circe_0046",
					Text = "That may well be so! Who is to say where our true nature lies? A spell of transformation is a spell of revelation; when we change, we become more like {#Emph}ourselves{#Prev}. Not less!" },
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
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0047",
					Text = "What has the world come to, little miss? {#Emph}Uh! {#Prev}Living on my little isle, I must have been the last to learn calamity had spread all from the heavens to beneath the earth!" },
				{ Cue = "/VO/MelinoeField_1979", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Portrait = "Portrait_Mel_Intense_01",
					Text = "And Chronos is responsible for all of it. {#Emph}Time {#Prev}apparently wishes to ruin everything eventually, though we are not about to let him have his way. We'll drive his forces from Olympus and unseat him from my father's throne." },
				{ Cue = "/VO/Circe_0048",
					Text = "{#Emph}Oh{#Prev}, we immortals and our warring ways! What example do we set for {#Emph}mortalkind? {#Prev}But I know certain battles must be fought; and I remain committed to our Lady Hecate, and you." },
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
					Text = "I have seen neither hide nor hair of that Medea as of late! Her charge was far less pleasant than my own, having to watch over that ghastly town. I worry she's developing bad habits, practicing in such a place!" },
				{ Cue = "/VO/MelinoeField_1982", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I've seen Lady Medea recently. She seems rather comfortable in Ephyra, in spite of what's happened there. Though, has she always had such a singular interest in curses and the necromantic arts?" },
				{ Cue = "/VO/Circe_0054",
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
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Medea_01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "G_Boss01", },
						Comparison = ">=",
						Value = 10,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0058",
					Text = "All of this sea-water must feel very disconcerting, little miss. For me, though, it feels rather much like home! Even the depths of Oceanus bring a sense of comfort, more than fear!" },
				{ Cue = "/VO/MelinoeField_1985", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I'm getting used to it. My path into the Underworld requires me to skirt the edge of Oceanus. The water's beautiful, though I could do without the sea-monsters. Particularly Scylla and her Siren friends... perhaps you know of them?" },
				{ Cue = "/VO/Circe_0059",
					Text = "Oh, {#Emph}yes! {#Prev}I do indeed. I grew up underneath the sea, and Scylla I remember from my youth. Always yelping about {#Emph}this {#Prev}or {#Emph}that! {#Prev}Was {#Emph}deafening! {#Prev}Perchance why I prefer the silence now." },
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
					Text = "I wonder, does our Lady Hecate as yet consort with that Tactician Shade of hers, {#Emph}heh? {#Prev}Swarthy in his mortal days, not of surpassing stature, prone to talk. {#Emph}Oh{#Prev}, what was his name again?" },
				{ Cue = "/VO/MelinoeField_1983", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You mean Odysseus? He remains indispensable to our cause. What knowledge I possess of this route and the dangers along it are thanks largely to him. Why do you ask?" },
				{ Cue = "/VO/Circe_0056",
					Text = "{#Emph}Oh! {#Prev}No reason at all! It's merely that he was a flighty sort as I recall, quite prone to wandering about! So his continued service is a bit of a surprise. A pleasant one, mind you!" },
				{ Cue = "/VO/MelinoeField_1984", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Did you use to know him? I don't recall you interacting at the Crossroads. Not that I was paying much heed to anything besides my studies then. I was so little last you visited!" },
				{ Cue = "/VO/Circe_0057",
					Text = "Once I relocated this isle, the journey to the Crossroads became {#Emph}much {#Prev}more arduous. As for Odysseus, yes, him I have met before. Him and his pig-headed crew. A different age, poppet! Perchance he's learned a bit since then." },
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
					Text = "I oft forget, we share some kinship, do we not? My father is the shining Sun itself, the Titan Helios. Distant accomplice to the gods! Not close with anyone. But he is... brother to the Lady Demeter, my aunt, who is your grandmother, correct...?" },
				{ Cue = "/VO/MelinoeField_1973", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Pleased_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Oh Madame Circe, right you are! That makes us cousins once removed, I think. I don't know how any of us can keep all this genealogy straight! In any case, the bond matters more than the blood, does it not?" },
				{ Cue = "/VO/Circe_0040",
					Text = "Quite veritably so! Though, you'll forgive me that I've shied from all of it. Amongst family, I was expected to act differently with each and every one. I scarcely understood how to be {#Emph}me! {#Prev}Things are much simpler on this isle here." },
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
						Value = 25,
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0035",
					Text = "Something felt {#Emph}different{#Prev}, just as you arrived. It's {#Emph}Moly{#Prev}, isn't it? And quite a {#Emph}lot{#Prev}, as I perceive! You need no such protection in this place. A miracle it does not interfere with your own craft!" },
				{ Cue = "/VO/MelinoeField_1974", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have been gathering what Moly I can find in Erebus. It has its uses to be sure, though in my purse it doesn't bother me, and remains fresh. You have an aversion to it? And here I thought that every plant and herb had earned your love." },
				{ Cue = "/VO/Circe_0036",
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
					Text = "{#Emph}Ah-ha{#Prev}, I knew you would arrive just now, poppet, {#Emph}haha! {#Prev}No innate gift of foresight required, merely intuition and my crystals hereabouts. Have you incorporated any into {#Emph}your {#Prev}routine?" },
				{ Cue = "/VO/MelinoeField_1976", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Well... I've learned to see into our Pitch-Black Stone! I used to think that it was there to help make us unseen, but it has other potent uses, too. Crystals! So full of potential." },
				{ Cue = "/VO/Circe_0038",
					Text = "Mother Gaia's multicolored bounty, {#Emph}oh! {#Prev}I sometimes envy that you live beneath the Earth where crystals and gemstones grow in abundance! Each has its special properties suggested by a single touch, {#Emph}oh-hohoh! {#Prev}How brilliant they all are!" },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},

			CirceAboutCirceAspect01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "affClearCastAspect" },
					},
				},
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChanting,

				{ Cue = "/VO/Circe_0043",
					Text = "How fares my {#Emph}marvelous {#Prev}Descura, little miss? I knew that you were next in line for her, though I still feel a bit emotional to see my favored staff again, {#Emph}hohoho. {#Prev}Our Lady Hecate had to do more than a {#Emph}bit {#Prev}of prodding to make me give her up, {#Emph}hehehoho!" },
				{ Cue = "/VO/MelinoeField_1975", UsePlayerSource = true,
					PreLineAnim = "MelinoeEquip", PreLineAnimTarget = "Hero",
					Text = "I've done my best to wield Descura with respect; to live up to those who possessed the Witch's Staff before me. And it... or rather she has served me well. My presence here is evidence to that. Do you... wish to hold her again?" },
				{ Cue = "/VO/Circe_0044",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh, no, I mustn't! We had our time. Long had she grown heavy in my hands before I passed her on, besides. May she protect you just as fiercely as I know she can!" },
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
					Text = "We all seek to find our true selves, yet the search is often long and difficult! So, let us go prepared." },
				PrePortraitExitFunctionName = "CirceBlessingChoice",
				PrePortraitExitFunctionArgs = PresetEventArgs.CirceBlessingChoices,
			},
			CirceChat19 =
			{
				UseableOffSource = true,
				OnQueuedThreadedFunctionName = "AmbientChatting",
				OnQueuedFunctionArgs = PresetEventArgs.CirceChantingRepeatable,

				{ Cue = "/VO/Circe_0023",
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
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe, I'm grateful that we had a chance to meet again after all this time. Your kindness to me always meant a lot, and I wanted to give you this small token in return." },
				{ Cue = "/VO/Circe_0060",
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}Nectar! Ohh, thank you{#Prev}, little miss! I've made attempts to brew my own but never get it right! Though why don't you take {#Emph}this {#Prev}in kind? Think of it as a little island souvenir!" },
			},
			CirceGift02 =
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
				{ Cue = "/VO/Circe_0061",
					Emote = "PortraitEmoteSurprise",
					Text = "Good heavens! More, for {#Emph}me? {#Prev}I'm unaccustomed to receiving gifts here on my little isle. Though I'm pleased to try and get more used to it, {#Emph}ahaha! {#Prev}If you must so {#Emph}insist!" },
				{ Cue = "/VO/MelinoeField_1945", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "{#Emph}Insist {#Prev}is a strong word, Madame, but I would like for you to have this, yes. Perhaps it will help you perfect your own recipe... or while away a pleasant night, should one arise." },
			},

			-- placeholder
			CirceGiftTemp =
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

			{ Cue = "/VO/MelinoeField_1944", Text = "It's beautiful, and quite adorable! Thank you!" },
		},

		RepulseOnMeleeInvulnerableHit = 150,
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
					IsNone = { "FrogFamiliarLand", "CatFamiliarPounce", "RavenFamiliarMelee" },
				},
			},
			TriggerCooldowns = { Name = "CirceSpokeRecently" },

		},
	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Circe )