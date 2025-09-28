LootSetData.Aphrodite =
{
	-- Aphrodite
	AphroditeUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
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
		EmoteOffsetY = -150,
		EmoteOffsetX = 80,
		SpawnSound = "/SFX/AphroditeBoonLoveChimes",
		PortraitEnterSound = "/SFX/AphroditeBoonLoveChimes",
		UpgradeSelectedSound = "/SFX/AphroditeBoonChoice",

		SpeakerName = "Aphrodite",
		Speaker = "NPC_Aphrodite_01",
		LoadPackages = { "Aphrodite", },
		Portrait = "Portrait_Aphrodite_Default_01",
		WrathPortrait = "Portrait_Aphrodite_Default_01_Wrath",
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

			-- Elemental
			"ElementalDodgeBoon",

			-- Legendary
			"RandomStatusBoon",

			-- Duos
			"SprintEchoBoon",
			"CharmCrowdBoon",
			"AllCloseBoon",
			"MaxHealthDamageBoon",
			"ManaBurstCountBoon",
			"BurnRefreshBoon",
			"SlamManaBurstBoon",
			"BloodManaBurstBoon",
		},

		Consumables = { },

		UpgradeMenuOpenVoiceLines =
		{
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
			{ GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},

		DuoPickupTextLines =
		{
			AphroditeWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SprintEchoBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "CharmCrowdBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "AllCloseBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "ManaBurstCountBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "MaxHealthDamageBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SlamManaBurstBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "BurnRefreshBoon" },
					},
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

			AphroditeWithAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "BloodManaBurstBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0213",
					Text = "I've always been something of a fighter, as Lord Ares here knows. But I keep telling him, the great conquests of love are more thrilling than the great conquests of war!" },
				{ Cue = "/VO/Ares_0165",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AresUpgrade",
					Text = "I do enjoy a good protracted fight, my Lady Aphrodite. To me, conquest is conquest; whether on the battlefield or in the heart, it matters not. And I find all of it quite moving." },
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
					UseRoomContextArt = true,
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "Doubtless this one knows hatred, not just love. {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Aphrodite_0129",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Emote = "PortraitEmoteAffection",
					Text = "Why, {#Emph}hello{#Prev}, gorgeous! {#Emph}You {#Prev}look like you can break some hearts even {#Emph}without {#Prev}my aid! Oh, your brother would be so proud, knowing you're fighting for your kin!" },
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0036",
					Portrait = "Portrait_Aphrodite_Displeased_01",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0037",
					
					Text = "Between us? I have been around {#Emph}quite {#Prev}a bit longer than appearances suggest. The so-called {#Emph}Golden Age {#Prev}that Chronos would restore... it was the dullest time, like you would not {#Emph}believe!" },
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
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift06" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0039",
					
					Text = "You've been {#Emph}so {#Prev}sheltered there, sweetness! Why, mortals, they don't even know your {#Emph}name! {#Prev}Not one temple erected in your {#Emph}honor! {#Prev}Not {#Emph}yet{#Prev}, at least, so you just stick with me!" },
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
			AphroditeAboutLove04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift06" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"MorosBecomingCloser01",
							"ErisBecomingCloser01",
							"NemesisPostCombatBecomingCloser01",
							"IcarusBecomingCloser01",
						},
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0201",
					Emote = "PortraitEmoteAffection",

					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },

					Text = "I can see why you became the star pupil of the Witch of the Crossroads, sweetness... because you've learned much of love in a short time, and with only a {#Emph}bit {#Prev}of guidance! Your heart is certainly in the right place." },
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
					Emote = "PortraitEmoteSurprise",
					Text = "Are you quite certain that it's best to be up here? I heard your kind... that is to say, those of the Underworld, that you're not fit to linger on the surface for too long. Please, {#Emph}don't {#Prev}overextend on our behalf!" },
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
					Text = "Sweetness, why, you seem entirely {#Emph}yourself! {#Prev}Upon the surface here, that is! I thought you couldn't tolerate this place, yet here you are, strutting across the war-torn land as though it's yours by right!" },
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
					Portrait = "Portrait_Aphrodite_Displeased_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutSurface03" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0080",
					Portrait = "Portrait_Aphrodite_Displeased_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0075",
					Portrait = "Portrait_Aphrodite_Displeased_01",
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
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Intro" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0077",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "What shall become of our fair mountain, love? Just recently we felt such tremors as I'd not experienced before. At first I thought it was Poseidon shaking up the earth again, but one look at {#Emph}him{#Prev}, and I knew it wasn't so..." },
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
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"AphroditeAboutHecate01",
							"AphroditeAboutMoros01",
							"AphroditeAboutEris01",
							"AphroditeAboutSirens01",
							"AphroditeAboutNarcissus01",
							"AphroditeUnderworldRunCleared01",
							"AphroditeUnderworldRunCleared02",
							"AphroditeAboutFates01",
						},
						Comparison = ">=",
						Value = 2,
					},
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosFirstMeeting" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0042",
					Text = "A little birdie told me {#Emph}Doom himself {#Prev}showed up where you reside...? While that bodes ill for you, and perhaps for us all... at least he's quite the looker, isn't he?" },
			},
			AphroditeAboutMoros02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesChoiceRecord", "MorosBecomingCloser01", },
						IsAny = { "Choice_MorosAccept" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "MorosBecomingCloser01" }, Min = 2 },
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0223",
					Emote = "PortraitEmoteAffection",
					Text = "I must say, you and Doom have been extraordinarily discreet in whatever you have going on. My little birdies have seen {#Emph}barely {#Prev}a trace of it! But I still have a feeling about you two, and my feelings are {#Emph}never {#Prev}wrong." },
			},

			AphroditeAboutNemesis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "NemesisPostCombatFirstMeeting", "NemesisGift06" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0218",
					Emote = "PortraitEmoteAffection",
					Text = "You've quite a partner in Nemesis, gorgeous! She's big, she's brash, she's everything you're not! I'm relieved you're standing by each other rather than at each other's throats!" },
			},
			AphroditeAboutNemesis02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutNemesis01" },
					},
					{
						Path = { "GameState", "TextLinesChoiceRecord", "NemesisPostCombatBecomingCloser01", },
						IsAny = { "Choice_NemesisAccept" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NemesisPostCombatBecomingCloser01" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0219",
					Emote = "PortraitEmoteAffection",
					Text = "I'm so pleased you and Nemesis settled your differences! {#Emph}Oh {#Prev}no one told me, gorgeous, this is all knowledge I obtain as part of being who I am! And as long as you each be yourselves, I think you'll even out." },
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
			AphroditeAboutArachne02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutCurseQuest01" }
					},
					{
						SumPrevRuns = 2,
						Path = { "TextLinesRecord", "ArachneAboutCurseQuest01" },
						CountPathTrue = true,
						Comparison = "==",
						Value = 0,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0224",
					Portrait = "Portrait_Aphrodite_Default_01",
					
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAffection", WaitTime = 4.0 },

					Text = "It's such a shame about Arachne and Athena. My little birdies told me everything. But there's beauty to be found in {#Emph}every {#Prev}form, even that of a delicate little spider! Perhaps she'll come to accept it as I think {#Emph}you {#Prev}have!" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "HestiaFirstPickUp", "HephaestusFirstPickUp" },
					},
					{
						-- SumPrevRuns = 1 is the same as CurrentRun, SumPrevRuns = 2 is checking PrevRun, etc.
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Artemis_Field_01" },
						IgnoreCurrentRun = true,
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
			AphroditeAboutZagreus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "C_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0208",
					Emote = "PortraitEmoteCheerful",
					Text = "Your little godling brother, I am hearing he's all right! And back to battling out of that hell he calls home, or at least {#Emph}partially {#Prev}until the Underworld's restored. I hope you get to see him again {#Emph}soon!" },
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
						Path = { "GameState", "UseRecord", "NPC_Athena_01" },
						Comparison = "<=",
						Value = 2,
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "AphroditeAboutAthena02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0084",
					
					Text = "You've met many of us now, but not yet proud Athena, I presume? Apparently she's too busy defending our front lines. Take no offense; she's not the goddess of good manners, after all." },
			},
			AphroditeAboutAthena02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Athena_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0192",
					
					Text = "You've paid witness to some of Athena's dramatic entrances on the battlefield. I have to say, she isn't bad in that regard! Probably because she's having so much practice with all of our unwelcome visitors!" },
			},

			AphroditeAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
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
						Path = { "PrevRun", "RoomCountCache" },
						HasAny = { "G_Boss01", "G_Boss02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0121",
					Text = "A little birdie told me you faced the Sirens at the bottom of the sea? I know them and their entrancing song only too well. They must have grown bored of dooming sailors to the deep!" },
			},
			AphroditeAboutSirens02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ScyllaAboutBallad01" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "G_Boss01", "G_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0230",
					Emote = "PortraitEmoteAffection",
					Text = "Those Sirens down where {#Emph}you {#Prev}are sure have been singing their hearts out! Perhaps they've found another wellspring of inspiration besides all the sailors they like so much." },
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
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Narcissus_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "NarcissusFirstMeeting" }, Min = 2 },
					},
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
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Narcissus_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0126",
					Portrait = "Portrait_Aphrodite_Displeased_01",
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
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "ErisFirstMeeting", "ErisFirstMeeting_B", "ErisBossFirstMeeting" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "AphroditeAboutEris02" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ErisFirstMeeting", "ErisFirstMeeting_B", "ErisBossFirstMeeting" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0132",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "A little birdie said that {#Emph}awful Eris {#Prev}has been fluttering about, getting her nose in everybody's business, instead of minding her own! We stopped inviting her to {#Emph}any {#Prev}of our feasts up here even before all this!" },
			},
			AphroditeAboutEris02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesChoiceRecord", "ErisBecomingCloser01", },
						IsAny = { "Choice_ErisAccept" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ErisBecomingCloser01" }, Min = 2 },
					},
					OrRequirements =
					{
						{
							{
								SumPrevRuns = 2,
								Path = { "UseRecord", "NPC_Eris_01" },
								Comparison = ">=",
								Value = 1,
							},
						},
						{
							{
								SumPrevRuns = 2,
								Path = { "RoomsEntered" },
								TableValuesToCount = { "O_Boss01", "O_Boss02" },
								Comparison = ">=",
								Value = 1,
							},
						},
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0220",
					Text = "You {#Emph}like {#Prev}having Strife in your life, {#Emph}hm? {#Prev}The more you fought with Eris, the more I could tell {#Emph}something {#Prev}was going on, and sure enough! She didn't seem your type at all, but that's {#Emph}exactly {#Prev}how it goes!" },
			},
			AphroditeAboutIcarus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Icarus_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "IcarusGift03" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0221",
					Emote = "PortraitEmoteAffection",
					Text = "That dashing young Shade with the fancy wings, is Icarus his name? I almost mistook him for one of my little birdies! He didn't get much chance at love while he drew breath, but it's never too late...!" },
			},
			AphroditeAboutIcarus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesChoiceRecord", "IcarusBecomingCloser01", },
						IsAny = { "Choice_IcarusAccept" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "IcarusBecomingCloser01" }, Min = 2 },
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Moros_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0222",
					Emote = "PortraitEmoteAffection",
					Text = "I am {#Emph}so {#Prev}pleased by what you've done for Icarus! {#Emph}Oh{#Prev}, he's been practically over the {#Emph}moon{#Prev}, and who can blame him? He got to truly {#Emph}feel... {#Prev}most mortals aren't so fortunate, let alone most {#Emph}Shades!" },
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HeraclesFirstMeeting" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0133",
					Text = "So, lumbering old Heracles is storming around down there, massing bodies of the dead in the name of the gods, is he? That one's as moody as a bull, and probably reeks even more. At least we have {#Emph}good {#Prev}help to lean upon!" },
			},

			AphroditeAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0194",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "Though I admit to having some {#Emph}small {#Prev}weakness for the tall, dark, and brooding types, Prometheus has been getting on my {#Emph}nerves. {#Prev}He's defacing our beautiful {#Emph}mountain! {#Prev}Who is he trying to impress?" },
			},
			AphroditeAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutPrometheus01" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0195",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "If Prometheus isn't more careful, he might burn right up from all his {#Emph}smoldering! {#Prev}He keeps saying how he doesn't {#Emph}care {#Prev}for any of us goddesses or gods, but {#Emph}I {#Prev}think he's just playing hard-to-get!" },
			},
			AphroditeAboutPrometheus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeAboutPrometheus02" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0232",
					Text = "How nice for Prometheus that he gets to keep venting his anger out on all of us like it's {#Emph}officially {#Prev}his job. How come he thinks we're all so mean to mortals anyhow? I break some hearts, it's true, but fill so many more!" },
			},

			AphroditeAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "Q_Intro" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0196",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "What are we ever going to do about our poor summit? That ugly Typhon made it all the way up here, and he's been ruining {#Emph}everything. {#Prev}Well we are {#Emph}not {#Prev}going to let him walk all over us." },
			},
			AphroditeAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "Q_Intro" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0197",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "{#Emph}Eugh{#Prev}, that ugly Typhon! Not only is he getting all the attention lately, he's resisted all my {#Emph}charms. {#Prev}That {#Emph}never {#Prev}happens! But all he wants is this mountain, and not in a loving way." },
			},
			AphroditeAboutTyphonW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "EnemyKills", "TyphonHead" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "Q_Story01" }
					},
					{
						Path = { "GameState", "UseRecord", "Q_Story01" },
						Comparison = ">=",
						Value = 2,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0199",
					Emote = "PortraitEmoteAffection",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "You saw our beautiful Palace grounds again! I'm sorry I missed you but no ugly monsters are ever getting in there if {#Emph}I {#Prev}can help it. Although they {#Emph}have {#Prev}been getting pretty close. They {#Emph}just {#Prev}won't take the hint!" },
			},
			AphroditeAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TyphonDefeatedWithStormStop" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0200",
					Emote = "PortraitEmoteAffection",
					-- Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "You really did it, gorgeous! That ugly monster's finally gone! I never could tell if he even {#Emph}had {#Prev}a heart, as there was not a trace of love in him at all, only the worst intentions and desires. So much for {#Emph}those!" },
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "AphroditeAboutHephaestus01" }, Min = 3 },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0061",
					
					Text = "I've heard many a hero claim the next best thing to arms forged by Hephaestus is his blessing! Though I think they'd all rather have mine." },
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
						PathFalse = { "GameState", "UseRecord", "AresUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0085",
					
					Text = "Among all of Lord Zeus' kin, you've still yet to encounter Ares, {#Emph}hm? {#Prev}The god of war has been quite busy, what with everything of late. There are those who question his motives, but not I. I long simply to find out where he is." },
			},
			AphroditeAboutAres02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "AresUpgrade" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "AresFirstPickUp" }, Max = 9 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0193",
					Emote = "PortraitEmoteCheerful",
					Text = "Lord Ares is finally back! Nothing makes a war official like when {#Emph}he {#Prev}shows up. Things haven't always gone our way when we've fought together, but this time just about {#Emph}everybody's {#Prev}here!" },
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0056",
					
					Emote = "PortraitEmoteSparkly",
					Text = "By the Moon, you're {#Emph}breathtaking {#Prev}this eve! The Moon herself {#Emph}did {#Prev}have something to do with it, did she not? I can tell. Your secret's safe with me!" },
			},

			-- other reactions
			AphroditePackageBountyIntro01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyPolyphemus" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0225",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "{#Emph}Eugh{#Prev}, there's something very {#Emph}odd {#Prev}about this night, and {#Emph}certainly {#Prev}that ugly city of {#Emph}Ephyra {#Prev}doesn't help. But between my dear Hephaestus and Lord Ares and myself, I think you'll more than manage to get by." },
			},
			AphroditeAboutPackageBounty01 =
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
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = GameData.LateStartPackagedBounties,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0226",
					Emote = "PortraitEmoteAffection",
					Text = "Sailing can be so romantic, but the mood tonight is {#Emph}definitely {#Prev}off... how did you even {#Emph}get {#Prev}so far so {#Emph}soon? {#Prev}Well even if we're not feeling our best, we can still {#Emph}look {#Prev}our best!" },
			},

			AphroditeAboutRelationship01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"MorosGift08",
							"NemesisGift08",
							"IcarusGift08",
							"ErisGift08",
						},
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"MorosGift07",
							"NemesisGift07",
							"IcarusGift07",
							"ErisGift07",
						},
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"MorosBecomingCloser01",
							"NemesisPostCombatBecomingCloser01",
							"IcarusBecomingCloser01",
							"ErisBecomingCloser01",
						},
						Comparison = "<=",
						Value = 3,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0234",
					Emote = "PortraitEmoteAffection",
					Text = "So many suitors from whom to choose, {#Emph}hm? {#Prev}Well just remember that you needn't choose at all, unless you so desire as do they. Your heart, your relationships. Make of them what you will!" },
			},

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

			AphroditeAboutEros01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "FirstHitHealTrait" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0217",
					Emote = "PortraitEmoteAffection",
					Text = "{#Emph}Mm{#Prev}, you have the Breath of Eros on you, if my senses don't deceive! Isn't it a beautiful thought, knowing Love is one of the most {#Emph}ancient {#Prev}forces in this entire world? Life would be {#Emph}nothing {#Prev}without it!" },
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
					{
						SumPrevRuns = 3,
						Path = { "EnemyKills", "Eris" },
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
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "AphroditeAboutApples01", "AphroditeGift01" },
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

			AphroditeAboutChronosBossW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 3,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0203",
					Portrait = "Portrait_Aphrodite_Displeased_01",		
					Text = "So besides whatever innate satisfaction there may be in beating up that nasty old Titan, is there a grander plan in all of this for what we're going to do? Your little godling brother, is he going to be all right...?" },
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
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
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
						Path = { "PrevRun", "TextLinesRecord", },
						HasAny = GameData.AllBathHouseEvents,
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
						Path = { "PrevRun", "TextLinesRecord", },
						HasAny = GameData.AllBathHouseEvents,
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
						IsAny = { "CatFamiliar", "FrogFamiliar", "RavenFamiliar", "HoundFamiliar", "PolecatFamiliar" },
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
						PathTrue = { "GameState", "TextLinesRecord", "ArachneGift03" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = GameData.AllArachneCostumes,
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
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0054",
					Emote = "PortraitEmoteAffection",					
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
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0055",
					
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteAffection", WaitTime = 10.7 },
					Text = "You know, gorgeous, I like getting my way. And right now I would like for you to cut a bloody little path through every single wretch and traitor that dares get in yours. {#Emph}Please?" },
			},

			AphroditePostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0204",
					Emote = "PortraitEmoteAffection",
					Text = "Gorgeous, you won the {#Emph}war {#Prev}for us! At least I think we won? Perhaps we didn't if these ugly Satyrs and the like are not about to leave yet, but you definitely did do {#Emph}something! Oh {#Prev}this is all too {#Emph}much!" },
			},
			AphroditePostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutOlympus02", "NeoChronosAboutTartarus02" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "I_Boss01", "Q_Boss01", "Q_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0205",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					Text = "That two-timing Chronos is on our side now? Against nasty versions of his older self, and invisible bits of Typhon we shouldn't fear {#Emph}too {#Prev}much but ought to heed. Not the strangest predicament I've been in, but it's {#Emph}close!" },
			},

			AphroditePostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0209",
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Ohh{#Prev}, the Three Fates {#Emph}finally {#Prev}decided to make an appearance, just as we were getting used to not having them around. What grand prophecy do they have in store for us now, {#Emph}hm? {#Prev}Whatever it is, we'll handle it I'm sure!" },
			},
			AphroditePostEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0210",
					Emote = "PortraitEmoteSparkly",
					Text = "If there really is another age that's coming up, then I say bring it on! True love never changes or goes out of style, no matter how much everything else does. Just stick with me and we'll be {#Emph}fine!" },
			},

			AphroditeAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift07" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0235",
					Emote = "PortraitEmoteAffection",
					Text = "The language of love transcends boundaries... we needn't even exchange words to understand each other's feelings and desires. How about we try it for a while, {#Emph}hm?" },
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
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "~=",
						Value = 5,
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "AphroditeGift07" },
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
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "AphroditeUpgrade" },
						Comparison = "<=",
						Value = 0,
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
			AphroditeChat32 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0182",
					Text = "Just remember, our war against ugliness is without end! Now let's fight on!" },
			},
			AphroditeChat33 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0183",
					Emote = "PortraitEmoteAffection",
					Text = "Anything that's worth doing is worth doing with passion! So come on, perk up!" },
			},
			AphroditeChat34 =
			{
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

				{ Cue = "/VO/Aphrodite_0184",
					Text = "Time again for another {#Emph}exciting {#Prev}night on the town! Lead the way, gorgeous!" },
			},
			AphroditeChat35 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0185",
					Text = "We'll make them all go weak in the knees. And everywhere else, just in case." },
			},
			AphroditeChat36 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0186",
					Text = "So much beauty in this world, and if we don't fight to protect it, who shall?" },
			},
			AphroditeChat37 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0187",
					Emote = "PortraitEmoteAffection",
					Text = "I love what I do, especially when I get to take matters into my own hands." },
			},
			AphroditeChat38 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0188",
					Text = "Back to the comfort of the Underworld for the night? We'll pretty it up in no time!" },
			},
			AphroditeChat39 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0189",
					Emote = "PortraitEmoteAffection",
					Text = "You're headed {#Emph}our {#Prev}way again! My heart beats faster at the very thought!" },
			},
			AphroditeChat40 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Aphrodite_0190",
					Text = "Can this night possibly go even better than the last? Let's go find out!" },
			},
		},

		BoughtTextLines =
		{
			AphroditeBlindBox01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFromSource = true,
						PathTrue = { "WasRandomLoot" },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "AphroditeUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0180",
					Emote = "PortraitEmoteAffection",
					Text = "I wanted this to be a surprise, love! Who could possibly ask for a better outcome opening up some plain old bag, only to find {#Emph}me {#Prev}waiting there with outstretched arms?" },
			},
			AphroditeBlindBox02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFromSource = true,
						PathTrue = { "WasRandomLoot" },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "AphroditeUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0181",
					Emote = "PortraitEmoteAffection",
					Text = "Were you expecting someone far less beautiful, or did you somehow know it was {#Emph}me? {#Prev}Perhaps you could hear my heart beating all the way from where {#Emph}you {#Prev}are!" },
			},


			AphroditeLootBought01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "AphroditeUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "AphroditeUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Aphrodite_0137",
					Emote = "PortraitEmoteAffection",
					Text = "{#Emph}Oh{#Prev}, to be an urgent bit of battlefield relief delivered courtesy of the feared Boatman himself, {#Emph}hah! {#Prev}Come on, we all have fantasies, gorgeous!" },
			},
			AphroditeLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "CharonGift04" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "AphroditeUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
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
						IsAny = { "F_PreBoss01", "G_PreBoss01", "H_PreBoss01", "I_PreBoss01", "I_PreBoss02", "N_PreBoss01", "O_PreBoss01", "P_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "AphroditeUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
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
					Portrait = "Portrait_Aphrodite_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Our world can be such an ugly place! Filled with such terrible misunderstandings as can veil the beauty we so often {#Emph}don't appreciate enough." },
			},
			AphroditeRejection02 =
			{
				{ Cue = "/VO/Aphrodite_0151",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Oh, gorgeous. If pride and vanity are truly weaknesses, then I'm about to let myself be very vulnerable with you here..." },
			},
			AphroditeRejection03 =
			{
				{ Cue = "/VO/Aphrodite_0152",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "I truly thought we ladies had a special connection, but then you do such things and make me feel unsure! And just a bit upset." },
			},
			AphroditeRejection04 =
			{
				{ Cue = "/VO/Aphrodite_0153",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "I don't offer you my blessings so you can just save them for later like some sort of snack! You want something else, fine! You can {#Emph}have {#Prev}it." },
			},
			AphroditeRejection05 =
			{
				{ Cue = "/VO/Aphrodite_0154",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Try as I might, I just can't help but feel the sting of being spurned. And I don't like it, not a little bit. So now I have to sting you back!" },
			},
			AphroditeRejection06 =
			{
				{ Cue = "/VO/Aphrodite_0155",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "There may be those who can make peace with being brushed aside, but that's not something {#Emph}I {#Prev}can do, sweetness! No matter how hard I try." },
			},
			AphroditeRejection07 =
			{
				{ Cue = "/VO/Aphrodite_0156",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Oh, don't be such a {#Emph}tease {#Prev}with me! When I bestow my blessings, take them graciously next time. But now...?" },
			},
			AphroditeRejection08 =
			{
				{ Cue = "/VO/Aphrodite_0157",
					Portrait = "Portrait_Aphrodite_Displeased_01",
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
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/Aphrodite_0158",
					Portrait = "Portrait_Aphrodite_Displeased_01",
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
						Path = { "CurrentLootData", "Name" },
						IsAny = { "HephaestusUpgrade" },
					},
				},
				{ Cue = "/VO/Aphrodite_0159",
					Portrait = "Portrait_Aphrodite_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "You {#Emph}could {#Prev}stay out of these infrequent little spats I have with my hard-working Hephaestus. But if you {#Emph}really {#Prev}want to get involved, why, {#Emph}sure!" },
			},

		},

		RejectionVoiceLines =
		{
			[1] = { GlobalVoiceLines = "GodRejectedVoiceLines" },
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0948", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
					Text = "Why, this is {#Emph}wonderful{#Prev}, and also quite impressive you already know our ways! I {#Emph}must {#Prev}return the gesture, so please, take {#Emph}this. {#Prev}I {#Emph}insist!" },
			},
			AphroditeGift02 =
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
						PathTrue = { "GameState", "UseRecord", "AphroditeUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
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
					Text = "Your offering is {#Emph}more {#Prev}than welcome, love! And come to think, it's been entirely too long since someone showered me with praise!" },
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0950", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
					Text = "Oh, sweetness, the honor is {#Emph}all {#Prev}mine! For matters of the heart, the key is openness. So you're well on your way towards the understanding you desire!" },
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1766", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
					Text = "My heart, you're {#Emph}truly {#Prev}something, you know that? You're generous, selective with your words, and {#Emph}gorgeous{#Prev}, too! I don't know whether to be flattered or a little envious!" },
			},
			AphroditeGift05 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1767", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Glorious Aphrodite! You are truly stunning, yet your courage and confidence inspire me still more. I'm humbled to be in your presence, and to be worthy of your favor." },
				{ Cue = "/VO/Aphrodite_0178",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteAffection",
					Text = "I didn't know what to expect from you. A sister-in-arms, at best? And I scarcely know you, save for glimpses from these messages, but despite all that... I've come to think of you as a friend! Someone to talk to. Thank you, love!" },
			},
			AphroditeGift06 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1768", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I've always thought the world beautiful... it's everywhere around us, even in times of strife. And I know that's because of {#Emph}you{#Prev}, Aphrodite. Thank you for helping me perceive it all." },
				{ Cue = "/VO/Aphrodite_0179",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteAffection",
					Text = "From you, this Nectar surely shall be sweeter than the rest! So when the clouds begin to darken overhead, and I feel my hope begin to wane, I'll drink to us. And I shall bounce right back!" },
			},
			-- bond forged
			AphroditeGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_AphroditeGiftHint01",
				CompletedHintId = "Codex_BondForgedAphrodite",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "AphroditeUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "AphroditeAboutLove04", "AphroditeGift06" }
					},
				},
				{ Cue = "/VO/MelinoeField_4347", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Aphrodite, your genuine enthusiasm even in the face of such hardship is so much of what makes you beautiful and inspirational beyond compare. I feel as though Ambrosia such as this symbolizes all the love you have to give." },
				{ Cue = "/VO/Aphrodite_0202",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteAffection",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Aphrodite_01", Icon = "Keepsake_Aphrodite" },

					Text = "{#Emph}Oh{#Prev}, you're {#Emph}so {#Prev}very kind! Though it never gets old. I'm {#Emph}used {#Prev}to everybody fawning over my {#Emph}looks! {#Prev}But if you can see past that, the {#Emph}inner beauty {#Prev}I possess, then you know {#Emph}far {#Prev}more of love and beauty than {#Emph}most." },
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
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "ReplacedTraitSource", },
				},
			},
		},

		RarityUpgradeVoiceLines =
		{
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				Source = { LineHistoryName = "NPC_Aphrodite_01", SubtitleColor = Color.AphroditeVoice },
				Cooldowns =
				{
					{ Name = "BoonRarifiedSpeech", Time = 240 },
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
		},

		FullSuperActivatedVoiceLines =
		{
			Queue = "Interrupt",
			{
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Aphrodite_01", SubtitleColor = Color.AphroditeVoice },
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
								IsNone = { "AphroditeUpgrade" },
							},
						},
						{
							{
								PathTrue = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
							},
						},
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Aphrodite_0099", Text = "They're going to love {#Emph}this!", PlayFirst = true },
				{ Cue = "/VO/Aphrodite_0100", Text = "I'm here for you, gorgeous!" },
				{ Cue = "/VO/Aphrodite_0101", Text = "No heart that cannot break!" },
				{ Cue = "/VO/Aphrodite_0242", Text = "Anything for you, love!" },
				{ Cue = "/VO/Aphrodite_0243", Text = "Feast your eyes on {#Emph}this!", PlayFirst = true },
				{ Cue = "/VO/Aphrodite_0244", Text = "It'll be a thing of beauty!" },
			},
			{
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
						IsAny = { "AphroditeUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Aphrodite_0245", Text = "Anything for {#Emph}you{#Prev}, love!" },
				{ Cue = "/VO/Aphrodite_0246", Text = "Who do you think you {#Emph}are?", PlayFirst = true },
				{ Cue = "/VO/Aphrodite_0247", Text = "Quit playing with my heart!" },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				ObjectTypes = { "Chronos", "Chronos_TyphonFight" },
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.33,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ChronosSpokeRecently", Time = 8 },
				},

				{ Cue = "/VO/Chronos_1263", Text = "I would {#Emph}love {#Prev}for you to {#Emph}leave!", PlayFirst = true },
				{ Cue = "/VO/Chronos_1264", Text = "I am not so {#Emph}easily {#Prev}distracted." },
			},
			{
				PlayOnceFromTableThisRun = true,
				RandomRemaining = true,
				ObjectTypes = { "Zagreus" },
				PreLineWait = 0.35,
				SuccessiveChanceToPlayAll = 0.33,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ZagreusSpokeRecently", Time = 6 },
				},
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "C_Boss01" },
					},
				},

				{ Cue = "/VO/Zagreus_0362", Text = "Lady Aphrodite...!", PlayFirst = true },
				{ Cue = "/VO/Zagreus_0363", Text = "Aphrodite?!" },
			},
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
			TriggerCooldowns = { "AphroditeBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Aphrodite_0102", Text = "Well, well!", PlayFirst = true },
			{ Cue = "/VO/Aphrodite_0103", Text = "{#Emph}Ah, ha-hah!" },
			{ Cue = "/VO/Aphrodite_0110", Text = "I have something for you." },
			{ Cue = "/VO/Aphrodite_0115", Text = "This is for you." },
			{ Cue = "/VO/Aphrodite_0116", Text = "A little gift." },
		},

	},	

}

OverwriteTableKeys( LootData, LootSetData.Aphrodite )