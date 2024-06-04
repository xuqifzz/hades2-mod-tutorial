LootSetData.Aphrodite =
{
	-- Aphrodite
	AphroditeUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		OffersElementalTrait = {"Air", "Water"},
		GameStateRequirements =
		{
			{
				Path = { "GameState", "UseRecord" },
				HasAny = { "PoseidonUpgrade", "DemeterUpgrade" }
			},
		},
		UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		GodLoot = true,
		Weight = 10,
		SurfaceShopText = "AphroditeUpgrade_Store",
		SurfaceShopIcon = "BoonInfoSymbolAphroditeIcon",
		BoonInfoIcon = "BoonInfoSymbolAphroditeIcon",
		MenuTitle = "UpgradeChoiceMenu_Title_AphroditeUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_AphroditeUpgrade",
		LootRejectedText = "Player_GodDispleased_AphroditeUpgrade",
		Icon = "BoonSymbolAphrodite",
		DoorIcon = "BoonDropAphroditePreview",
		DoorUpgradedIcon = "BoonDropAphroditeUpgradedPreview",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_AphroditeUpgrade",
		Color = { 255, 192, 203, 255 },
		LightingColor = {255, 111, 202, 255},
		LootColor = {255, 50, 240, 255},
		SubtitleColor = Color.AphroditeVoice,
		SpawnSound = "/SFX/AphroditeBoonLoveChimes",
		PortraitEnterSound = "/SFX/AphroditeBoonLoveChimes",
		UpgradeSelectedSound = "/SFX/AphroditeBoonChoice",

		SpeakerName = "Aphrodite",
		Speaker = "NPC_Aphrodite_01",
		Portrait = "Portrait_Aphrodite_Default_01",
		WrathPortrait = "Portrait_Aphrodite_Wrath_01",
		OverlayAnim = "AphroditeOverlay",
		Gender = "Female",
		FlavorTextIds =
		{
			"AphroditeUpgrade_FlavorText01",
			"AphroditeUpgrade_FlavorText02",
			"AphroditeUpgrade_FlavorText03",
		},

		FirstSpawnVoiceLines =
		{
			PreLineWait = 0.7,
			GameStateRequirements =
			{
				{
					Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
					IsNone = { "H" },
				},
			},
			{ Cue = "/VO/Melinoe_0641", Text = "The heart sigil..." },
		},

		OnSpawnVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PlayOnceFromTableThisRun = true,
			PreLineWait = 0.85,
			SuccessiveChanceToPlay = 0.25,
			GameStateRequirements =
			{
				NamedRequirements = { "OlympianOnSpawnVoiceLinesAllowed" },
			},
			
			{ Cue = "/VO/Melinoe_1476", Text = "Aphrodite...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1477", Text = "She's back." },
			{ Cue = "/VO/Melinoe_0641", Text = "The heart sigil..." },
		},
	
		PriorityUpgrades = { "AphroditeWeaponBoon", "AphroditeSpecialBoon", "AphroditeCastBoon","AphroditeSprintBoon", "AphroditeManaBoon" },
		WeaponUpgrades =
		{
			"AphroditeWeaponBoon",
			"AphroditeSpecialBoon",
			"AphroditeCastBoon",
			"AphroditeSprintBoon",
			"AphroditeManaBoon",
		},
		Traits =
		{
			"HighHealthOffenseBoon",
			"HealthRewardBonusBoon",
			"DoorHealToFullBoon",
			"WeakPotencyBoon",
			"WeakVulnerabilityBoon",
			"ManaBurstBoon",
			"FocusRawDamageBoon",

			-- Legendary
			"CharmCrowdBoon",

			-- Elemental
			"ElementalDodgeBoon",
			
			-- Duos
			"SprintEchoBoon",
			"MaximumShareBoon",
			"AllCloseBoon",
			"MaxHealthDamageBoon",
			"ManaBurstCountBoon",
			"ShadeMercFireballBoon",
			"FirstHitHealBoon",
		},

		Consumables = { },

		UpgradeMenuOpenVoiceLines =
		{
			[1] = GlobalVoiceLines.HeraclesBoonReactionVoiceLines,
			[2] = GlobalVoiceLines.FoundRareBoonVoiceLines,
		},

		DuoPickupTextLines =
		{
			AphroditeWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "SprintEchoBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0140",
					Emote = "PortraitEmoteAffection",
					Text = "Love binds us all together, and inspires us to feats we never could accomplish on our own! And don't just take {#Emph}my {#Prev}word for it, gorgeous. Your {#Emph}wise {#Prev}and {#Emph}even-handed {#Prev}uncle... he knows all about spreading the love around!" },
				{ Cue = "/VO/Zeus_0160",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Text = "You're most correct, dear Aphrodite, for my rule is based on love of family and of mortalkind as well. What are we fighting for, if not a way of life in which our passions are the driving force?" },
			},

			AphroditeWithHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "MaximumShareBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0142",
					Emote = "PortraitEmoteAffection",
					Text = "Be on your {#Emph}best {#Prev}behavior now, gorgeous! For I present to you our most resplendent Queen. No stranger to the ways of war, or to extinguishing the wretchedness that festers in the hearts of the wicked! Behold, {#Emph}our Lady Hera!" },
				{ Cue = "/VO/Hera_0110",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "I think we're past the need for such pomp, Aphrodite. But then, more goddesses ought better understand the need to keep appearances even in troubled times... {#Emph}especially {#Prev}in troubled times." },
			},

			AphroditeWithPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "AllCloseBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0144",
					Text = "I used to think your Lord Uncle Poseidon was a rude and useless oaf... but, after having seen his fighting prowess in this war firsthand, I've come to realize how wrong I was! He isn't useless in the least!" },
				{ Cue = "/VO/Poseidon_0270",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "Why thank you, Aphrodite! For I know how challenging it is for you to fathom the totality of my strength, as let's face it, you're not exactly the goddess of wisdom! {#Emph}Nor am I! {#Prev}And we have other common ground, in the {#Emph}beauty of the sea!" },
			},

			AphroditeWithApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "ManaBurstCountBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0094",
					Emote = "PortraitEmoteAffection",
					Text = "There's so much beauty on Olympus, love! Take {#Emph}me{#Prev}, for instance, or bright Apollo, {#Emph}hm? {#Prev}Your cousin, is he not? I daresay I see a hint of resemblance!" },
				{ Cue = "/VO/Apollo_0100",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ApolloUpgrade",
					Emote = "PortraitEmoteCheerful",
					Text = "Now that you mention it, Lady Aphrodite, these flaxen locks of mine are a little bit akin to the pale luster of my cousin's flowing mane. There must be so much beauty in her realm, as well!" },
			},

			AphroditeWithDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "MaxHealthDamageBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0148",
					Text = "You and your Granny Demeter, you must have {#Emph}so {#Prev}much catching up to do! Perhaps you even have the power to un-freeze that disapproving scowl I oft fear is {#Emph}permanently {#Prev}set, though... I can see she wishes to address you now herself!" },
				{ Cue = "/VO/Demeter_0106",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "DemeterUpgrade",
					Text = "Please pay no heed to Aphrodite, flower. She's more concerned about the contours of my face than doing anything of use. But on the count that we've much catching up to do, she's right..." },
			},

			AphroditeWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "FirstHitHealBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0092",
					Text = "It pains me to admit there are occasions when love is not the answer, and a bit of sharpened metal can much sooner do the trick. In such matters, my Hephaestus can be of assistance, can't you, dear?" },
				{ Cue = "/VO/Hephaestus_0130",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Text = "For you, Aph? {#Emph}Anytime. {#Prev}And as for witchie here, {#Emph}most {#Prev}of the time! Now come {#Emph}on. {#Prev}Even when the situation calls for sharpened metal, you know how to get the point across!" },
			},

			AphroditeWithHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "ShadeMercFireballBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0146",
					Text = "The fleeting quality of beauty is what makes us {#Emph}long {#Prev}for it! But even for those whose {#Emph}outer {#Prev}beauty has abandoned them, there's oft an {#Emph}inner {#Prev}beauty that burns bright! Don't you agree, dear Hestia?" },
				{ Cue = "/VO/Hestia_0156",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Text = "Careful with that line of reasoning there, Aphrodite. You don't have much inner beauty to speak of, and your {#Emph}outer {#Prev}beauty I can melt off in a {#Emph}snap. {#Prev}And growing all those lustrous tresses back would take a while, by my reckoning..." },
			},

		},

		InteractTextLineSets =
		{
			AphroditeFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/Melinoe_0642", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 2.8, PowerWordPresentation = true, PowerWordWaitTime = 4.2 },
					-- PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					NarrativeContextArt = "DialogueBackground_Erebus",
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "Doubtless this one knows hatred, not just love. {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Aphrodite_0129",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Emote = "PortraitEmoteAffection",
					Text = "Why, {#Emph}hello{#Prev}, gorgeous! You look like you can break some hearts even {#Emph}without {#Prev}my aid! Oh, your brother would be so proud, knowing you're fighting for your kin!" },
			},

			-- low health
			AphroditeLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.3,
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0048",
					
					Emote = "PortraitEmoteSurprise",
					Text = "Oh no, you poor, poor thing, what happened on your way? There must be something I can do about your pitiable state!" },
			},
			AphroditeLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.3,
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0049",
					
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Mm{#Prev}, you look as though you've had an altogether miserable night. Been there, gorgeous; I merely hide it well!" },
			},
			AphroditeLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.3,
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0050",
					
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Ah{#Prev}, beautiful, you're {#Emph}hurt! {#Prev}How unforgivable. Whoever dared, I trust you ended their existence painfully!" },
			},
			AphroditeLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 0,
					},
					RequiredMaxHealthFraction = 0.3,
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0051",
					
					Emote = "PortraitEmoteSurprise",
					Text = "You're {#Emph}wounded{#Prev}, love! If only I had reached you earlier. Though don't despair! Your heart yet beats, doesn't it?" },
			},

			-- run starts
			AphroditeRunStart01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0052",
					
					Emote = "PortraitEmoteAffection",
					Text = "Hello, hello to you again, gorgeous! I just couldn't wait to see you any longer, so I thought I'd join you this time from the very start. You ready for me, {#Emph}hm?" },
			},
			AphroditeRunStart02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0053",
					
					Text = "My intuition told me you were just about to set off on another of your big important assignments, and I desired to be the first to see you off and give to you my very best!" },
			},
			AphroditeRunStart03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0176",					
					Emote = "PortraitEmoteCheerful",
					Text = "The night is young, and we've a war to win, gorgeous! I thought I might accompany you from the moment you set forth. How about it?" },
			},
			AphroditeRunStart04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0177",
					Text = "Hold it right there, sweetness! You're not about to head into the dark of night without my aid, to help keep you {#Emph}warm and tingly{#Prev}, and our foes {#Emph}dead and buried!" },
			},

			-- story events
			AphroditeAboutPassions01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0034",
					
					Text = "Would that we all could chase our passions without consequence! But we gods, sometimes we get a bit ahead of ourselves, and wind up in the most compromising positions..." },
			},
			AphroditeAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0035",
					
					Text = "This family's not so good at letting go, is it? After aeons of prosperity, all that we've built together threatens to come crashing down, all because of a {#Emph}little {#Prev}bad blood! {#Emph}Hmph!" },
			},

			AphroditeAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0036",
					
					Text = "We goddesses always get swept up in these family affairs through no fault of our own. {#Emph}I {#Prev}had no prior qualm with Chronos, yet here I am now, well at war with him!" },
			},
			AphroditeAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0037",
					
					Text = "Between us? I have been around quite a bit longer than appearances suggest. The so-called {#Emph}Golden Age {#Prev}that Chronos would restore... it was the dullest time, like you would not {#Emph}believe!" },
			},

			AphroditeAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0039",
					
					Text = "You've been {#Emph}so {#Prev}sheltered there, sweetness! Why, mortals, they don't even know your {#Emph}name! {#Prev} Not one temple erected in your {#Emph}honor! {#Prev}Not {#Emph}yet{#Prev}, at least, so you just stick with me!" },
			},

			AphroditeAboutLove01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0046",
					
					Emote = "PortraitEmoteAffection",
					Text = "Have you somebody {#Emph}special {#Prev}in your life? The star pupil of the Witch of the Crossroads must be {#Emph}so {#Prev}terribly busy, why, perhaps the answer is no. So far ahead in some respects, so far behind in others..." },
			},
			AphroditeAboutLove02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutLove01", },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0047",
					
					Text = "Trust me, if you're uncertain that you've ever been in love, you haven't been. It's like a thrill that washes over you, then lingers pleasantly, long afterward. May you find it again and again!" },
			},
			AphroditeAboutLove03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0122",
					
					Text = "You fight with the ferocity of one whose love is on the line! Yet that is not what's driving you, is it. No, you've found a wellspring of motivation in something else! What could it {#Emph}be?" },
			},

			AphroditeAboutBoons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0123",
					
					Text = "True love may be eternal, although passions tend to fizzle out. So it is with all the blessings we bestow! As love requires nourishment, so must our faith in you be reinforced, like so!" },
			},

			AphroditeAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0071",
					
					Emote = "PortraitEmoteSparkly",
					Text = "Look at you, beneath the shining moonlight! {#Emph}Welcome{#Prev}, gorgeous, to the lovely surface of our world! Please, stay as long as you like! Or as long as you can. Of late, it's been a little rough..." },
			},
			AphroditeAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "AphroditeAboutSurface03" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0072",
					
					Text = "Are you quite certain that it's best to be up here? I heard your kind... that is to say, those of the Underworld, that you're not fit to linger on the surface for too long. Please, don't overextend on our behalf!" },
			},
			AphroditeAboutSurface03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0073",
					
					Emote = "PortraitEmoteSparkly",
					Text = "Sweetness, why, you seem entirely yourself! Upon the surface here, that is! I thought you couldn't tolerate this place, yet here you are, strutting across the war-torn land as though it's yours by right!" },
			},
			AphroditeAboutSurface04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0083",
					
					Text = "Shame that the cursed city of Ephyra is your first exposure to the splendors of the surface, love. It stood in tribute to your mother and your father, until Chronos had his way! I still grow angry when I think on it." },
			},

			AphroditeAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutSurface03", },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0080",
					
					Text = "I'd urge you visit us, though since we're under siege and all, perhaps it isn't worth the trip. Olympus sure takes on a different feel when you're {#Emph}stuck{#Prev}. We've cut back on the feasting and the frolicking a lot. Oh, how I miss those days..." },
			},
			AphroditeAboutOlympus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "P_Intro" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0081",
					Text = "How wonderful, you've seen our mountain now firsthand! Though what a mortifying time to receive guests; we've been preoccupied receiving enemies!" },
			},
			AphroditeAboutOlympus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0082",
					
					Text = "Someday I'm certain you'll discover that Olympus is a truly splendid place. All the pleasures that this world can offer abound! And, as I live and breathe, it's not as cold as it's made out to be." },
			},

			AphroditeAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0074",
					
					Emote = "PortraitEmoteSurprise",
					Text = "Oh, gorgeous, I can barely see you anymore! And what a shame that is for {#Emph}me{#Prev}. Although, where are you, anyway? Caught somewhere underneath the sea itself?! Your father's realm is very vast indeed." },
			},
			AphroditeAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0135",
					Text = "{#Emph}Ahh{#Prev}, you've reached the rift that {#Emph}thoughtful {#Prev}Lord Poseidon slashed across our pretty countryside... enabling our foes to mass against us even {#Emph}faster {#Prev}than they could on foot! Just, hurry over, {#Emph}hm?" },
			},

			AphroditeAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0075",
					
					Text = "A little birdie told me something's happened to the Fates... they're not around to complicate our lives? No wonder my days have become so {#Emph}predictable! {#Prev}Though if Chronos truly is behind this, then perhaps we ought to be concerned..." },
			},

			AphroditeAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					-- @ update with real requirements
					{
						PathTrue = { "GameState", "RoomCountCache", "O_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0077",
					Text = "What shall become of our fair mountain, love? Just recently we felt such tremors as I'd not experienced before. At first I thought it was Poseidon shaking up the earth again, but one look at him, and I knew it wasn't so..." },
			},

			AphroditeAboutUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "H" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0124",
					Text = "It can't be pleasant, crawling through the Underworld's underbelly night after night. But, there's beauty to be found in all things! Well, {#Emph}most {#Prev}things. Down where you are, no guarantees." },
			},

			AphroditeAboutBirdies01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift01", },
					},
					RequiredMinAnyTextLines = { TextLines = { "AphroditeAboutHecate01", "AphroditeAboutMoros01", "AphroditeAboutEris01", "AphroditeAboutSirens01", "AphroditeAboutNarcissus01", "AphroditeUnderworldRunCleared01", "AphroditeUnderworldRunCleared02", "AphroditeAboutFates01" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0127",
					Text = "{#Emph}Oh{#Prev}, I know {#Emph}more {#Prev}and {#Emph}more {#Prev}about you, love. My little birdies tell me {#Emph}everything! {#Prev}They're {#Emph}everywhere{#Prev}, and like nothing better than to keep me well-apprised. {#Emph}They're {#Prev}happy when {#Emph}I'm {#Prev}happy, and I'm happy being in the know!" },
			},
			AphroditeAboutWar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0128",
					Text = "I must say, wars are not without their moments of excitement! It's been too long since I took to the field, bedazzling my foes in all my glory as I ran them through, filling their final moments with beauty and {#Emph}agony! {#Prev}Although, wars also really make a mess of things..." },
			},

			-- about characters / about other characters
			AphroditeAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0040",
					
					Text = "You have your father's fierceness, don't you, love? Not that I ever knew him all too well! Or heard too many tales about him, come to think... he was never the communicative type." },
			},

			AphroditeAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0041",
					
					Emote = "PortraitEmoteAffection",					
					Text = "So {#Emph}you're {#Prev}the star student of great Hecate! A little birdie told me she'd been training up a real prodigy. Imagine my surprise when it turned out to be the missing Princess of the Underworld! How positively {#Emph}scandalous!" },
			},

			AphroditeAboutMoros01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Moros_01", },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "MorosFirstMeeting" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0042",
					Text = "A little birdie told me {#Emph}Doom himself {#Prev}showed up where you reside...? While that bodes ill for you, and perhaps for us all... at least he's quite the looker, isn't he?" },
			},

			AphroditeAboutArachne01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Arachne_01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0086",
					
					Text = "You dwell in Erebus, don't you, sweetness? Last I had heard, the silk-weaver Arachne dwells down there. Such fineries she made, but never showed her face up here again after she and Athena had a little spat!" },
			},

			AphroditeAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "HestiaFirstPickUp", "HephaestusFirstPickUp" },
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0043",
					Text = "You've met {#Emph}so {#Prev}many on this mountaintop, yet come to think, I've not seen hide nor hair of late of little Artemis! I'd hate to think the goddess of the hunt's too busy stalking some old woodland beast to join us in our time of need?" },
			},

			AphroditeAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0044",
					
					Text = "Your brother, he was always such a sweetheart, love! Then out of the blue one day, he stopped accepting all my messages! Had I done something to offend? Imagine my relief when I much later learned that Chronos was to blame!" },
			},
			AphroditeAboutZagreus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0045",
					
					Emote = "PortraitEmoteDepressed",
					Text = "I wonder what exactly Chronos did to cut your brother off, and all your family. Perhaps he {#Emph}bound them! {#Prev}In any case, don't worry overmuch. They're gods! They're probably all right." },
			},

			AphroditeAboutHephaestusRelationship01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "AphroditeGift02", "HephaestusGift02" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0076",
					
					Text = "You've met Hephaestus, heard the tales, no doubt. Well, he has a beautiful heart. Surely not just I can see that? Of all my many suitors, he alone has been content to let me be." },
			},

			AphroditeAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "HestiaFirstPickUp", "HephaestusFirstPickUp" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0084",
					
					Text = "You've met many of us now, but not yet proud Athena, I presume? Apparently she's too busy defending our front lines. Take no offense; she's not the goddess of good manners, after all." },
			},
			AphroditeAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "HestiaFirstPickUp", "HephaestusFirstPickUp" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0085",
					
					Text = "Among all of Lord Zeus' kin, you've still yet to encounter Ares, {#Emph}hm? {#Prev}The god of war has been quite busy, what with everything of late. There are those who question his motives, but not I. I long simply to find out where he is." },
			},
			AphroditeAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "HeraFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "HestiaFirstPickUp", "HephaestusFirstPickUp" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0089",
					
					Text = "One thing's for certain, there's been {#Emph}far {#Prev}too little feasting on Olympus as of late! Poor Dionysus hasn't been himself. Normally he'd be among the first to welcome you!" },
			},

			AphroditeAboutSirens01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "G_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0121",
					Text = "A little birdie told me you faced the Sirens at the bottom of the sea? I know them and their entrancing song only too well. They must have grown bored of dooming sailors to the deep!" },
			},

			AphroditeAboutNarcissus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Narcissus_01" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Narcissus_01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "NarcissusFirstMeeting" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0125",
					Text = "A little birdie told me you have met none other than the beautiful Narcissus, haven't you? You must think he's a shining example of all I stand for... well, he's not! Because the greatest love is {#Emph}shared{#Prev}, not hoarded for oneself." },
			},
			AphroditeAboutNarcissus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutNarcissus01" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Narcissus_01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0126",
					Text = "I hope for your sake you avoid that no-good Narcissus. His suitors {#Emph}begged {#Prev}me to do something about his love of his own reflection, but who am I to break up such a harmonious relationship? As far as I'm concerned, he finally met his match!" },
			},

			AphroditeAboutPersephone01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0131",
					Text = "You know, gorgeous, you're fortunate you got your mother's best! Of course your {#Emph}father {#Prev}always had a certain something, too. Why come to think of it, you're living proof of that!" },
			},

			AphroditeAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Eris_01", },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "ErisFirstMeeting" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0132",
					Text = "A little birdie said that {#Emph}awful Eris {#Prev}has been fluttering about, getting her nose in everybody's business, instead of minding her own! We stopped inviting her to {#Emph}any {#Prev}of our feasts up here even before all this!" },
			},

			AphroditeAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Heracles_01", },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HeraclesFirstMeeting" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0133",
					Text = "So, lumbering old Heracles is storming around down there, massing bodies of the dead in the name of the gods, is he? That one's as moody as a bull, and probably reeks even more. At least we have {#Emph}good {#Prev}help to lean upon!" },
			},

			-- about other gods
			AphroditeAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0058",
					
					Text = "Lord Zeus already sought you out, {#Emph}hm? {#Prev}Family or no, if he's offered you his blessing, he's expecting something in return. He's loath to ask for favors is all." },
			},
			AphroditeAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0062",
					
					Text = "You've been acquainted with Queen Hera, I can see! She and I work together frequently and have an understanding that we share. Fair goddesses must stick together, after all." },
			},
			AphroditeAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0059",
					
					Text = "I heard Poseidon boasting he'd already blessed you with his might. Now, just in case one could still be left wanting even after all {#Emph}that{#Prev}, here." },
			},
			AphroditeAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0057",
					
					Text = "Bright Apollo's been in touch already, {#Emph}hm? {#Prev}How quick to lend fair goddesses a hand. Though, nowhere to be found back when your brother needed aid!" },
			},
			AphroditeAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0063",
					
					Text = "So fiery old Hestia has taken to you, {#Emph}hm? {#Prev}You should be very proud, for typically she can't be bothered. And she cannot be impressed." },
			},
			AphroditeAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0064",
					
					Text = "I'm so relieved you and your frosty grandmother have had an opportunity to meet! If nothing else, perhaps now Demeter shall tone it back a smidgen with the rest of us?" },
			},
			AphroditeAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0060",
					
					Text = "Already met with my strong-armed Hephaestus, {#Emph}hm? {#Prev}The sordid things said of the two of us, they roll right off his back! Would that {#Emph}my {#Prev}skin were half as thick as {#Emph}his{#Prev}..." },
			},
			AphroditeAboutHephaestus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutHephaestus01", },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					MinRunsSinceAnyTextLines = { TextLines = { "AphroditeAboutHephaestus01" }, Count = 3 },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0061",
					
					Text = "I've heard many a hero claim the next best thing to arms forged by Hephaestus is his blessing! Though I think they'd all rather have mine." },
			},

			AphroditeAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0065",
					
					Text = "More oft than not of late, swift Hermes has been nowhere to be found. Not here, at least, but... perhaps somewhere down in {#Emph}your {#Prev}realm, {#Emph}hm?" },
			},

			AphroditeAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0056",
					
					Emote = "PortraitEmoteSparkly",
					Text = "By the Moon, you're {#Emph}breathtaking {#Prev}this eve! The Moon herself {#Emph}did {#Prev}have something to do with it, did she not? I can tell. Your secret's safe with me!" },
			},

			-- other reactions
			AphroditeAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceAphroditeBoonKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0130",
					Emote = "PortraitEmoteAffection",
					Text = "Oh, you bear my Beautiful Mirror! You'll always look gorgeous in it, but its real power is to help me quickly seek you out. And bestow on you the very best I can!" },
			},
			AphroditeAboutApples01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "Resources", "MixerOBoss" },
						Comparison = ">=",
						Value = 1,
					},					
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0078",
					Emote = "PortraitEmoteAffection",
					Text = "My, isn't that the glimmer of a Golden Apple on you, love? I knew you had good taste. Their uses are more plentiful than you can imagine! Brew the most delicious Nectar, distract beautiful rivals, initiate great wars, you name it!" },
			},

			AphroditeAboutNectar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutApples01" },
					},
					NamedRequirements = { "AlchemyUnlocked" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0079",
					
					Emote = "PortraitEmoteCheerful",
					Text = "You know, I mentioned Golden Apples could be turned to Nectar, though not {#Emph}how! {#Prev}I'll have to send the recipe along. All it takes is a boiling pot, some aromatic spices to your taste, and just the right words. You'll get it, you're a witch!" },
				{
					PostLineThreadedFunctionName = "DisplayInfoToast",
					PostLineFunctionArgs = { Duration = 2, Title = "RecipeAdded", Text = "WorldUpgradeNectar", VoiceLines = HeroVoiceLines.CauldronSpellLearnedVoiceLines },
				},

			},
			AphroditeAboutNectar02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeNectar" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0097",
					
					Text = "So did you try my Nectar recipe, sweetness? I'm certain it'll win over just about anybody in {#Emph}your {#Prev}capable hands. No need to let me know how it goes, I have my ways of finding out!" },
			},

			AphroditeAboutEosAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "TorchSprintRecallAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0174",
					Emote = "PortraitEmoteSurprise",
					Text = "Now what is that fabulous set of {#Emph}flames {#Prev}you're wielding there? It's as though they shine with the first light of morning; I'd not have thought they'd fit your style, but you're {#Emph}really {#Prev}pulling it off!" },
			},

			AphroditeUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0087",
					
					Text = "It's been so long, love, why, I felt a little thrill of {#Emph}fright! {#Prev}But then a little birdie told me you'd gone far down in those depths, even to some success? I'll be excited to hear all the juicy bits!" },
			},
			AphroditeUnderworldRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0134",
					Emote = "PortraitEmoteAffection",
					Text = "You really got him, didn't you, gorgeous? A little birdie told me {#Emph}everything{#Prev}, how you fought all the way into those rancid depths, and took that Chronos {#Emph}down! {#Prev}Though, he's already back and angrier than ever, isn't he...?" },
			},
			AphroditeSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					-- @ update based on last boss chamber
					{
						PathTrue = { "PrevRun", "RoomCountCache", "O_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0088",
					Text = "Last time, you made a real difference here, you know! I shouldn't be surprised, and yet, a single goddess doing so much work? You're quite the inspiration, love! And {#Emph}terrifying{#Prev}, too!" },
			},

			AphroditeAboutBathHouse01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAny = { "DoraBathHouse01", "HecateBathHouse01", "OdysseusBathHouse01", "MorosBathHouse01" },
					},
					{
						Path = { "PrevRun", "TextLinesRecord" },
						HasNone = { "HecateBathHouseDecline01",
							"OdysseusBathHouseDecline01",
							"NemesisBathHouseDecline01",
							"ErisBathHouseDecline01",
						},
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0090",
					
					Emote = "PortraitEmoteAffection",
					Text = "You are as fresh as rain this eve, gorgeous! Paid a recent visit to the springs, {#Emph}hm? {#Prev}There's nothing like a good hot bath, {#Emph}especially {#Prev}when in good company." },
			},
			AphroditeAboutBathHouse02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutBathHouse01", },
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAny = { "DoraBathHouse02", "HecateBathHouse02", "OdysseusBathHouse02", "MorosBathHouse02" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0091",
					
					Emote = "PortraitEmoteAffection",
					Text = "{#Emph}Ohh{#Prev}, you must have visited the springs once more! It's that refreshing glow about you, love. I wonder with whom you've been bathing! I'm sure a little birdie shall inform me soon enough." },
			},

			AphroditeAboutFamiliars01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar", "FrogFamiliar", "RavenFamiliar" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0096",
					
					Emote = "PortraitEmoteAffection",
					Text = "My, is that some sort of adorable little animal you have with you, gorgeous? Your worshipers come in all shapes and sizes, then! I mostly stick to bewitching gods and mortals, myself." },
			},
			AphroditeAboutOutfits01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift01" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "ArmorGainKeepsake", "VitalityCostume", "ManaCostume", "AgilityCostume", "CastDamageCostume", "IncomeCostume", "HighArmorCostume" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0175",
					Emote = "PortraitEmoteAffection",
					Text = "What is it you have {#Emph}on{#Prev}, gorgeous? Some lovely silken garb, made by Arachne lest my eyes deceive! You and the little spider must have {#Emph}really {#Prev}hit it off!" },
			},

			-- legendary
			AphroditeLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0054",
					
					Text = "Passion strikes at the unlikeliest of times, spurring us past the limits that we know! Pray welcome it as I, and go with all my blessings, from the bottom of my heart!" },
			},
			AphroditeLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0055",
					
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAffection", WaitTime = 10.7 },
					Text = "You know, gorgeous, I like getting my way. And right now I would like for you to cut a bloody little path through every single wretch and traitor that dares get in yours. {#Emph}Please?" },
			},

			-- repeatable lines
			AphroditeChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0003",
					
					Emote = "PortraitEmoteCheerful",
					Text = "How lovely running into {#Emph}you {#Prev}again, gorgeous!" },
			},
			AphroditeChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0004",
					
					Emote = "PortraitEmoteAffection",
					Text = "Why, you look positively {#Emph}stunning {#Prev}in all that silver light!" },
			},
			AphroditeChat03 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0005",
					
					Text = "Between us goddesses, may you kill {#Emph}everybody {#Prev}standing in your way!" },
			},
			AphroditeChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0006",
					
					Emote = "PortraitEmoteCheerful",
					Text = "As long as you have love in your heart, you'll probably be fine!" },
			},
			AphroditeChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0007",
					
					Text = "Such a beautiful night for such an ugly job you have to do!" },
			},
			AphroditeChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0008",
					
					Text = "Even in bad times, we can find {#Emph}something {#Prev}to love!" },
			},
			AphroditeChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0009",
					
					Text = "Life would be so very dull if not for our personal problems, {#Emph}hm?" },
			},
			AphroditeChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0010",
					
					Emote = "PortraitEmoteAffection",
					Text = "Oh, if only {#Emph}looks {#Prev}could kill, gorgeous!" },
			},
			AphroditeChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0011",
					
					Emote = "PortraitEmoteCheerful",
					Text = "{#Emph}So {#Prev}good running into you again, sweetness!" },
			},
			AphroditeChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0012",
					
					Emote = "PortraitEmoteAffection",
					Text = "I do {#Emph}so {#Prev}love these nightly outings that we share!" },
			},
			AphroditeChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0013",
					
					Emote = "PortraitEmoteDepressed",
					Text = "So much fighting and bloodshed, all on our family's account!" },
			},
			AphroditeChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0014",
					
					Text = "There must be {#Emph}something {#Prev}I can do to help, isn't there, love?" },
			},
			AphroditeChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0015",
					
					Text = "The more distracted you can make them, the easier they are to kill!" },
			},
			AphroditeChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0016",
					
					Emote = "PortraitEmoteAffection",
					Text = "{#Emph}Ohh{#Prev}, how I've longed for your arrival, beautiful!" },
			},
			AphroditeChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0017",
					
					Emote = "PortraitEmoteCheerful",
					Text = "We're just two lovely goddesses together having a night out!" },
			},
			AphroditeChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0017",
					
					Emote = "PortraitEmoteAffection",
					Text = "We're just two lovely goddesses together having a night out!" },
			},
			AphroditeChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0018",
					
					Text = "Try as they might, don't {#Emph}ever {#Prev}let them get to you, sweetness." },
			},
			AphroditeChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0019",
					
					Emote = "PortraitEmoteCheerful",
					Text = "I found you once again, gorgeous! Oh, this is {#Emph}always {#Prev}fun!" },
			},
			AphroditeChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0020",
					
					Emote = "PortraitEmoteCheerful",
					Text = "You're {#Emph}beautiful {#Prev}such as it is. Though, {#Emph}I {#Prev}can still be of some benefit, I'm sure!" },
			},
			AphroditeChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0021",
					
					Text = "Whoever's on {#Emph}your {#Prev}bad side, love, they're on {#Emph}mine {#Prev}as well." },
			},
			AphroditeChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0022",
					
					Text = "You witches can be {#Emph}such {#Prev}elusive sorts, though I know {#Emph}just {#Prev}where to find you!" },
			},
			AphroditeChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0023",
					
					Text = "At this rate, you'll end up breaking more hearts than {#Emph}me!" },
			},
			AphroditeChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0024",
					
					Text = "{#Emph}Mm{#Prev}, you witches get to have {#Emph}all {#Prev}the fun, don't you?" },
			},
			AphroditeChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0025",
					
					Emote = "PortraitEmoteDepressed",
					Text = "Please spare a thought for me, cooped up as ever on this mountaintop..." },
			},
			AphroditeChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0026",
					
					Text = "{#Emph}Finally! {#Prev}I was beginning to think you stood me up, gorgeous!" },
			},
			AphroditeChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0027",
					
					Emote = "PortraitEmoteAffection",
					Text = "Oh I've been longing for this ever since our last such little date!" },
			},
			AphroditeChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0028",
					
					Emote = "PortraitEmoteAffection",
					Text = "Have I got {#Emph}just {#Prev}the thing for you this time, sweetness!" },
			},
			AphroditeChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0029",
					
					Emote = "PortraitEmoteCheerful",
					Text = "Why {#Emph}hello{#Prev}, beautiful! And may my sweetest blessing be with you." },
			},
			AphroditeChat28 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0030",
					
					Text = "Wherever you may go, there's always {#Emph}drama {#Prev}waiting for you, isn't there?" },
			},
			AphroditeChat29 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0031",
					
					Emote = "PortraitEmoteAffection",
					Text = "May my blessings lift you like sweet nothings whispered in your ear." },
			},
			AphroditeChat30 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0032",
					
					Emote = "PortraitEmoteAffection",
					Text = "I had the strongest urge to see you once again, and here you are, at last!" },
			},
			AphroditeChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0033",
					
					Emote = "PortraitEmoteAffection",
					Text = "We're in this together, sweetness, and don't you forget it, {#Emph}hm?" },
			},

		},

		BoughtTextLines =
		{
			AphroditeLootBought01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0136",
					Text = "Your Boatman there has such an {#Emph}ugly {#Prev}job, having to smuggle little blessings such as these into the {#Emph}worst {#Prev}of places... but we make it worth his while, don't you worry about that." },
			},
			AphroditeLootBought02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0137",
					Text = "{#Emph}Oh{#Prev}, to be an urgent bit of battlefield relief delivered courtesy of the feared Boatman himself, {#Emph}hah! {#Prev}Come on, we all have fantasies, gorgeous!" },
			},
			AphroditeLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift01" },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0138",
					Text = "You have a real understanding with that Boatman, haven't you? He's such a solitary soul. Rugged... tall... powerfully built. {#Emph}Hm!" },
			},
			AphroditeLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "F_PreBoss01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "N_PreBoss01", "O_PreBoss01", "P_PreBoss01" },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0139",
					Text = "Trusty Charon reached you after all, and just in time to face the gravest threats along your path. So may my blessing bring you victory!" },
			},
		},

		RejectionTextLines =
		{
			AphroditeRejection01 =
			{
				{ Cue = "/VO/Aphrodite_0150",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Our world can be such an ugly place! Filled with such terrible misunderstandings as can veil the beauty we so often {#Emph}don't appreciate enough." },
			},
			AphroditeRejection02 =
			{
				{ Cue = "/VO/Aphrodite_0151",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Oh, gorgeous. If pride and vanity are truly weaknesses, then I'm about to let myself be very vulnerable with you here..." },
			},
			AphroditeRejection03 =
			{
				{ Cue = "/VO/Aphrodite_0152",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I truly thought we ladies had a special connection, but then you do such things and make me feel unsure! And just a bit upset." },
			},
			AphroditeRejection04 =
			{
				{ Cue = "/VO/Aphrodite_0153",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I don't offer you my blessings so you can just save them for later like some sort of snack! You want something else, fine! You can {#Emph}have {#Prev}it." },
			},
			AphroditeRejection05 =
			{
				{ Cue = "/VO/Aphrodite_0154",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Try as I might, I just can't help but feel the sting of being spurned. And I don't like it, not a little bit. So now I have to sting you back!" },
			},
			AphroditeRejection06 =
			{
				{ Cue = "/VO/Aphrodite_0155",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "There may be those who can make peace with being brushed aside, but that's not something {#Emph}I {#Prev}can do, sweetness! No matter how hard I try." },
			},
			AphroditeRejection07 =
			{
				{ Cue = "/VO/Aphrodite_0156",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Oh, don't be such a {#Emph}tease {#Prev}with me! When I bestow my blessings, take them graciously next time. But now...?" },
			},
			AphroditeRejection08 =
			{
				{ Cue = "/VO/Aphrodite_0157",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Sometimes I think we shouldn't force you to play favorites, but we shouldn't do a lot of things, I'm sure! Such as get angry with {#Emph}you!" },
			},
			AphroditeRejection09 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RejectedLootData", "Name" },
						IsAny = { "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/Aphrodite_0158",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You'd side with dear Hephaestus over {#Emph}me? {#Prev}There must be some mistake, sweetness! Which means there too must be some sort of {#Emph}punishment..." },
			},
			AphroditeRejection10 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RejectedLootData", "Name" },
						IsAny = { "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/Aphrodite_0159",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You {#Emph}could {#Prev}stay out of these infrequent little spats I have with my hard-working Hephaestus. But if you {#Emph}really {#Prev}want to get involved, why, {#Emph}sure!" },
			},

		},

		RejectionVoiceLines =
		{
			[1] = GlobalVoiceLines.GodRejectedVoiceLines,
		},

		MakeUpTextLines =
		{
			AphroditeMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0160",
					Text = "Our emotions ran a {#Emph}little {#Prev}hot there, didn't they... I still can feel {#Emph}my {#Prev}heart racing, and if I'm not mistaken, {#Emph}yours {#Prev}might have been, too!" },
			},
			AphroditeMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0161",
					Emote = "PortraitEmoteAffection",
					Text = "Oh, let's make up, what do you say, gorgeous? With everything that has been going on of late, I think we've all been a little bit on edge!" },
			},
			AphroditeMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0162",
					Text = "You know, I'm reminded one thing that unites us even in the worst of times is that we all have a {#Emph}bit {#Prev}of a temper around here!" },
			},
			AphroditeMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0163",
					Text = "It's no secret that I'm prone to fits of passion, and I'd not have it any other way. But you {#Emph}could {#Prev}have it differently next time!" },
			},
			AphroditeMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0164",
					Text = "Now I'll admit, that was a fight {#Emph}I {#Prev}started, love. Though, each time our passions run high, I think our relationship only grows richer for it!" },
			},
			AphroditeMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0165",
					Text = "{#Emph}Whew! {#Prev}Now, don't we feel better? We mustn't keep our feelings bottled up, even if it means having ourselves the occasional little outburst." },
			},
			AphroditeMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0166",
					Text = "Now let's just simmer down and still the beating of our hearts! I am not angry anymore, though still a bit annoyed..." },
			},
			AphroditeMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0167",
					Text = "{#Emph}Hm{#Prev}, well, if there's ever a good reason to forgo my blessing, much less for the sake of my jealous kin, I've yet to hear of it!" },
			},
		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			AphroditeGift01 =
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
						PathTrue = { "GameState", "UseRecord", "AphroditeUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0948", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Great Aphrodite! You must get more offerings than all the other gods and goddesses combined. Though, this one comes from me!" },
				{ Cue = "/VO/Aphrodite_0066",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteAffection",
					Text = "Why, this is wonderful, and also quite impressive you already know our ways! I must return the gesture, so please take this; I insist!" },
			},
			AphroditeGift02 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- UnfilledIcon = "EmptyHeartWithGiftIcon",
				-- FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "AphroditeUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0949", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "You make me want to doubt myself less frequently, Lady Aphrodite. You wouldn't mind another offering, would you?" },
				{ Cue = "/VO/Aphrodite_0067",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteAffection",
					Text = "Your offering is more than welcome, love! And come to think, it's been entirely too long since someone showered me with praise!" },
			},
			AphroditeGift03 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- UnfilledIcon = "EmptyHeartWithGiftIcon",
				-- FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "AphroditeUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0950", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I know so little still of matters of the heart. There's surely so much I could learn from you, Lady Aphrodite. I'm honored to have met." },
				{ Cue = "/VO/Aphrodite_0068",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteAffection",
					Text = "Oh, sweetness, the honor is all mine! For matters of the heart, the key is openness. So you're well on your way towards the understanding you desire!" },
			},
			AphroditeGift04 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				-- UnfilledIcon = "EmptyHeartWithGiftIcon",
				-- FilledIcon = "FilledHeartWithGiftIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "AphroditeUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1766", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Your favor means so much to me, Lady Aphrodite. If only I could return it somehow! Even during the most difficult of times, you bring me strength and hope." },
				{ Cue = "/VO/Aphrodite_0069",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteAffection",
					Text = "My heart, you're truly something, you know that? You're generous, selective with your words, and gorgeous, too! I don't know whether to be flattered or a little envious!" },
			},

			-- placeholder
			AphroditeGiftTemp =
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

			{ Cue = "/VO/Melinoe_1738", Text = "I can't say no to such a lovely gift." },
		},

		SwapUpgradePickedVoiceLines =
		{
			BreakIfPlayed = true,
			RandomRemaining = true,
			PreLineWait = 1.05,
			SuccessiveChanceToPlay = 0.33,
			RequiresLastUpgradeSwapped = true,
			UsePlayerSource = true,

		},

		RarityUpgradeVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Aphrodite_01", SubtitleColor = Color.AphroditeVoice },
			Cooldowns =
			{
				{ Name = "BoonRarifiedSpeech", Time = 60 },
			},

			{ Cue = "/VO/Aphrodite_0105", Text = "Mm-{#Emph}hmm!" },
			{ Cue = "/VO/Aphrodite_0106", Text = "My pleasure." },
			{ Cue = "/VO/Aphrodite_0109", Text = "Follow your heart." },
			{ Cue = "/VO/Aphrodite_0168", Text = "Done!" },
			{ Cue = "/VO/Aphrodite_0169", Text = "Sure!" },
			{ Cue = "/VO/Aphrodite_0170", Text = "Of course!" },
			{ Cue = "/VO/Aphrodite_0171", Text = "Here!" },
			{ Cue = "/VO/Aphrodite_0172", Text = "Anything for you!" },
			{ Cue = "/VO/Aphrodite_0173", Text = "Certainly!", PlayFirst = true },
		},

		DeathTauntVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.25,
			NoTarget = true,
			Source = { LineHistoryName = "NPC_Aphrodite_01", SubtitleColor = Color.AphroditeVoice },

			{ Cue = "/VO/Aphrodite_0119", Text = "I've more than enough wrath to go around." },
			{ Cue = "/VO/Aphrodite_0120", Text = "Do not provoke love's opposite from me.", PlayOnce = true },
			{ Cue = "/VO/Aphrodite_0118", Text = "Don't trifle with my heart." },
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Aphrodite_01", SubtitleColor = Color.AphroditeVoice },
			TriggerCooldowns = { "AphroditeBoonTakenSpeech" },

			{ Cue = "/VO/Aphrodite_0102", Text = "Well, well!", PlayFirst = true },
			{ Cue = "/VO/Aphrodite_0103", Text = "{#Emph}Ah, ha-hah!" },
			{ Cue = "/VO/Aphrodite_0110", Text = "I have something for you." },
			{ Cue = "/VO/Aphrodite_0115", Text = "This is for you." },
			{ Cue = "/VO/Aphrodite_0116", Text = "A little gift." },
		},

	},	

}

OverwriteTableKeys( LootData, LootSetData.Aphrodite )