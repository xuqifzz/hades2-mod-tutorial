LootSetData.Poseidon =
{
	-- Poseidon
	PoseidonUpgrade =
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		OffersElementalTrait = {"Water"},
		GameStateRequirements =
		{
			--
		},
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		Weight = 10,
		SurfaceShopText = "PoseidonUpgrade_Store",
		SurfaceShopIcon = "BoonInfoSymbolPoseidonIcon",
		Icon = "BoonSymbolPoseidon",
		BoonInfoIcon = "BoonInfoSymbolPoseidonIcon",
		DoorIcon = "BoonDropPoseidonPreview",
		DoorUpgradedIcon = "BoonDropPoseidonUpgradedPreview",
		MenuTitle = "UpgradeChoiceMenu_Title_PoseidonUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_PoseidonUpgrade",
		LootRejectedText = "Player_GodDispleased_PoseidonUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_PoseidonUpgrade",
		Color = { 0, 191, 255, 255 },
		LightingColor = {12, 199, 255, 255},
		LootColor = {0, 200, 255, 255},
		SubtitleColor = Color.PoseidonVoice,
		LootRejectionAnimation = "BoonDissipateA_Poseidon",
		SpawnSound = "/SFX/PoseidonBoonWaveCrash",
		PortraitEnterSound = "/SFX/PoseidonBoonWaveCrash",
		UpgradeSelectedSound = "/SFX/PoseidonBoonChoice",

		PriorityUpgrades = { "PoseidonWeaponBoon", "PoseidonSpecialBoon", "PoseidonCastBoon", "PoseidonSprintBoon", "PoseidonManaBoon" },
		WeaponUpgrades =
		{
			"PoseidonWeaponBoon",
			"PoseidonSpecialBoon",
			"PoseidonCastBoon",
			"PoseidonSprintBoon",
			"PoseidonManaBoon",
		},
		Traits =
		{
			"EncounterStartOffenseBuffBoon",
			"RoomRewardBonusBoon",
			"FocusDamageShaveBoon",
			"DoubleRewardBoon",
			"PoseidonStatusBoon",
			"PoseidonExCastBoon",
			"OmegaPoseidonProjectileBoon",

			-- Legendary
			"AmplifyConeBoon",

			-- Elemental
			"ElementalHealthBoon",

			-- Duos
			"LightningVulnerabilityBoon",
			"MoneyDamageBoon",
			"GoodStuffBoon",
			"PoseidonSplashSprintBoon",
			"AllCloseBoon",
			"SteamBoon",
			"MassiveCastBoon",
		},
		Consumables = { },

		SpeakerName = "Poseidon",
		Speaker = "NPC_Poseidon_01",
		Portrait = "Portrait_Poseidon_Default_01",
		WrathPortrait = "Portrait_Poseidon_Wrath_01",
		OverlayAnim = "PoseidonOverlay",
		Gender = "Male",

		FlavorTextIds =
		{
			"PoseidonUpgrade_FlavorText01",
			"PoseidonUpgrade_FlavorText02",
			"PoseidonUpgrade_FlavorText03",
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
			{ Cue = "/VO/Melinoe_0633", Text = "The trident sigil..." },
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

			{ Cue = "/VO/Melinoe_1474", Text = "It's Poseidon...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_1475", Text = "He's back..." },
			{ Cue = "/VO/Melinoe_0633", Text = "The trident sigil..." },
		},

		UpgradeMenuOpenVoiceLines =
		{
			[1] = GlobalVoiceLines.HeraclesBoonReactionVoiceLines,
		},

		DuoPickupTextLines =
		{
			PoseidonWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "LightningVulnerabilityBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0082",
					Text = "Our combined might was once {#Emph}more {#Prev}than enough to vanquish Chronos, little Niece! Although it also took the wisdom of my noble brother, Zeus, who formed our plan! We've quite the plan this time as well, don't we, Brother?!" },
				{ Cue = "/VO/Zeus_0087",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Text = "Oh, Poseidon, always raring to go. A good plan needn't be discussed out in the open. For now, young Melinoë? We offer you that combined might of ours! Please complicate things for our foes, would you?" },
			},
			PoseidonWithZeus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "LightningVulnerabilityBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0265",
					Text = "The only greater strength than that belonging to Lord Zeus, my niece, is his combined with mine! Lightning can surge across my waters even faster than it ravages the land! And now, my kingly brother and I grant our terrifying might to you!" },
				{ Cue = "/VO/Zeus_0156",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Text = "We {#Emph}lend {#Prev}our terrifying might to you, that is, Melinoë. For our family is a partnership, and we give as well as take. Now go and use our united strength to take back what's ours!" },
			},

			PoseidonWithHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "MoneyDamageBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0267",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ahoy{#Prev}, my little niece, I'm here with the spectacular Queen Hera, fairest wife of my distinguished brother, and all that! Shame I have never found myself a perfect mate as she! {#Emph}You{#Prev}'d bless us if I did, wouldn't you, Hera?" },
				{ Cue = "/VO/Hera_0102",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "{#Emph}Oh{#Prev}, I'll assuredly bless you {#Emph}and {#Prev}your beloved mate whomever they may be, Poseidon. Perhaps when all of this is over, you may resume your search in earnest! But until such time, get your mind out of the gutter." },
			},

			PoseidonWithApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "PoseidonSplashSprintBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0041",
					Text = "Have you yet come to know golden Apollo, Niece? He's so well known and loved among the mortals that he had no choice but to involve himself in our most recent family affair! Bending to mortal pressure like a bow, {#Emph}hah!" },
				{ Cue = "/VO/Apollo_0092",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ApolloUpgrade",
					Text = "Oh, come now, Uncle, I don't yield to pressure quite so easily. I just knew this situation would be more than you could handle on your own! We're not just family, we're a team, aren't we?" },
			},

			PoseidonWithDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "GoodStuffBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0186",
					Text = "{#Emph}Ah{#Prev}, my niece, you ought to know that Elder Goddess Demeter and I, we may jeer and jest at one another, but it's never out of spite! Isn't that right, dear foster-sister?" },
				{ Cue = "/VO/Demeter_0072",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "DemeterUpgrade",
					Text = "Oh, Poseidon! You needn't lie to young Melinoë like that. It sends a terrible impression, and may make her hold you in as much contempt as do I! But let's cooperate for now, why not?" },
			},

			PoseidonWithAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "AllCloseBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0269",
					Text = "When battle rages all around, there's little time for love, little room for beauty! Yet Aphrodite here, she never loses heart! It's almost precious how she strives with all her might, brandishing that decorative spear of hers!" },
				{ Cue = "/VO/Aphrodite_0145",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Emote = "PortraitEmoteAffection",
					Text = "Well, good Lord Poseidon, I'm pleased to know how I inspire you. Though perhaps you ought pay more attention to our {#Emph}foes {#Prev}than to what I do with my spear, so we can turn this battle in our favor, finally!" },
			},

			PoseidonWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "MassiveCastBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0271",
					Emote = "PortraitEmoteSparkly",
					Text = "My niece, we all must tirelessly work to counteract the harm Chronos has wrought! Some even more tirelessly than the rest! Take, for instance, my nephew Hephaestus here! I told him he could have a word if he got back to hammering after!" },
				{ Cue = "/VO/Hephaestus_0124",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Text = "See how generous our Lord Poseidon is? {#Emph}Everybody {#Prev}needs a decent uncle, I say! Let me know should you ever find one. Now... {#Emph}we {#Prev}here best get back to hammering things out." },
			},

			PoseidonWithHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "SteamBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0273",
					Text = "I have known Hestia practically since the cataclysmic day that I was born! Although when things are normal we avoid each other at all costs, she's like an old, wise sister to me at this point, and I am glad she's here! {#Emph}Right {#Prev}here!" },
				{ Cue = "/VO/Hestia_0150",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "You {#Emph}best {#Prev}be glad I'm here, you lug! Lest I leave all of you again to fend for your own damn selves. You won't be putting Chronos back into the ground without me, anyhow! That goes for you, too, hot stuff." },
			},

		},

		InteractTextLineSets =
		{
			PoseidonFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/Melinoe_0634", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 4.1, PowerWordPresentation = true, PowerWordWaitTime = 5.4 },
					--PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					NarrativeContextArt = "DialogueBackground_Erebus",
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "You're one of my father's brothers, aren't you? Then, help him! {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Poseidon_0212",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Emote = "PortraitEmoteSurprise",
					Text = "My long-lost niece, {#Emph}you live! {#Prev}We thought you met the same fate as your father! And your mother, {#Emph}and {#Prev}your brother, {#Emph}augh! {#Prev}Well how about we turn the tide, and exact terrible revenge for poor old Hades and his kin?!" },
			},

			-- low health
			PoseidonLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
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

				{ Cue = "/VO/Poseidon_0038",
					Emote = "PortraitEmoteFiredUp",
					Text = "Why, Niece, you're bleeding everywhere! I can't keep watch over your every move, you know! You must be careful, at least until you have some of my might!" },
			},
			PoseidonLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
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

				{ Cue = "/VO/Poseidon_0039",
					
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ah{#Prev}, little Niece, you're {#Emph}hurt! {#Prev}But pain builds character, now, does it not? And you are shaping up to be quite a character in all this!" },
			},
			PoseidonLowHealth03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
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
				{ Cue = "/VO/Poseidon_0073",
					Text = "Your injuries shall make you stronger, Niece! Not right away, you're clearly in bad shape right now, but you shall {#Emph}grow {#Prev}from this, I'm sure!" },
			},
			PoseidonLowHealth04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
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

				{ Cue = "/VO/Poseidon_0074",
					
					Text = "{#Emph}Augh{#Prev}, you must have hit rough waters from the looks of it, but there's good news: {#Emph}I'm {#Prev}here!" },
			},

			-- run starts
			PoseidonRunStart01 =
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
				{ Cue = "/VO/Poseidon_0175",
					
					Text = "I had this feeling you were just about to set forth on another of your fateful escapades! Figured you could use a surge of strength!" },
			},
			PoseidonRunStart02 =
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
				{ Cue = "/VO/Poseidon_0176",
					
					Text = "A long and treacherous journey begins with a single step, my niece! Or if you're swimming, with a single {#Emph}stroke! {#Prev}Would that swimming were an option, I could aid you even more!" },
			},
			PoseidonRunStart03 =
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
				{ Cue = "/VO/Poseidon_0177",
					
					Text = "As you set forth, I bid you do as does the shark, my niece! Surely you know the shark? A hunting-fish that swiftly surges ever-forward, in relentless pursuit of its prey!" },
			},
			PoseidonRunStart04 =
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
				{ Cue = "/VO/Poseidon_0178",
					
					Text = "Let me be first among my kin this eve to bid you a safe voyage through the dark! Not that it's going to be safe, but that's my sentiment, nevertheless!" },
			},
			-- story events
			PoseidonAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					-- redundant with the following event
					{
						PathFalse = { "GameState", "TextLinesRecord", "PoseidonAboutHades03" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "PoseidonAboutChronos02" }, Count = 3 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0016",
					
					Text = "We never used to have much contact with your father. So when Hades ceased communicating with Olympus, we figured he was back to his old ways! Turns out that old sneak Chronos got him! There was nothing we could do!" },
			},
			PoseidonAboutHades02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0018",
					
					Text = "Your father Hades and I didn't always get along. My crusty older brother, I called him! Water under the bridge now! {#Emph}Ah{#Prev}, how I miss his dour cheerlessness, my niece!" },
			},
			PoseidonAboutHades03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					-- redundant with the following event
					{
						PathFalse = { "GameState", "TextLinesRecord", "PoseidonAboutHades01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0211",
					
					Text = "I scarce recall when last we spoke with your grim father, Niece! He never was the most sociable sort! When we stopped hearing from him, we figured he was simply in one of his {#Emph}moods{#Prev}, not in the clutches of Chronos!" },
			},
			PoseidonAboutFindingHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					-- @ update with additional requirements
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHades01" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Story01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "HecateAboutHades01", }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0298",
					Emote = "PortraitEmoteFiredUp",
					Text = "We heard the news you found old Hades, Niece! The {#Emph}most-excellent {#Prev}news, I should say! Except the part that he is bound in Tartarus, that isn't excellent at all. {#Emph}We'll get you out of this, Brother!" },
			},

			PoseidonAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0044",
					
					Text = "You would have liked your brother, little Niece! Just about everybody did! He showered me with praise just like a mortal would. A little awkward, yes, but {#Emph}quite endearing{#Prev}, too!" },
			},

			PoseidonAboutMelinoe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0019",
					
					Emote = "PortraitEmoteFiredUp",
					Text = "So you were raised in some dark hidden recess of the Underworld, something like that, my niece? Raised to find and vanquish the usurper of your father's throne? {#Emph}Haha{#Prev}, that's rich!" },
			},
			PoseidonAboutMelinoe02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0025",
					
					Text = "My niece, you needn't be a witch to see your family is in dire straits right now. You needn't be a witch at all, if you ask me! I'd choose another way of life if I were you!" },
			},

			PoseidonAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0013",
					
					Text = "When first I heard our last, best hope for stopping Chronos was the secondborn of Hades and his Queen, I said: wait, {#Emph}who? {#Prev}So then they had a {#Emph}girl! {#Prev}The Titan must have struck your father's House right after you were born!" },
			},
			PoseidonAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0012",
					Emote = "PortraitEmoteDepressed",
					
					Text = "That wily old Titan, Chronos! I won't sink to calling him my father! We had it out with him before, a while back. Thought we had settled it for good! {#Emph}Ah{#Prev}, but we were young and foolish then!" },
			},
			PoseidonAboutChronos03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Chronos_01" },
						Comparison = ">=",
						Value = 4,
					},
					MinRunsSinceAnyTextLines = { TextLines = { "PoseidonAboutChronos02" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0014",
					
					Text = "It once took {#Emph}six {#Prev}of us to bring the Titan Chronos down! Myself, your father, Brother Zeus, his lovely Hera, Demeter, and Hestia as well! We'd mighty weapons for the job and everything!" },
			},
			PoseidonAboutChronos04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					MinRunsSinceAnyTextLines = { TextLines = { "PoseidonAboutChronos02" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0015",
					
					Text = "Old Chronos never had even a drop of love for me, or any of his children, Niece. Imagine, hating your own offspring! And not just {#Emph}some {#Prev}of them, but {#Emph}all!" },
			},
			PoseidonAboutChronos05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					MinRunsSinceAnyTextLines = { TextLines = { "PoseidonAboutChronos02" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0017",
					
					Text = "Once wily Chronos took your father's House, he mustered forces to besiege us here! We can't see anything down in that Underworld, so he plain caught us out! But still, we held him off!" },
			},
			PoseidonAboutChronos06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					MinRunsSinceAnyTextLines = { TextLines = { "PoseidonAboutChronos02" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0032",
					
					Text = "As soon as Chronos attacked, why, we retaliated! A cataclysm like you've never seen! Ripped half this land apart. Left all the Titan's armies high and dry!" },
			},
			PoseidonAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0184",
					
					Emote = "PortraitEmoteFiredUp",
					Text = "What's all this flotsam about Chronos abducting the Three Fates? {#Emph}Impossible! {#Prev}A ploy to take us off our guard! Don't go believing everything you hear, my niece!" },
			},

			PoseidonAboutFamily01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "HermesFirstPickUp", "HephaestusFirstPickUp" },
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0065",
					
					Text = "Our family's scattered to the winds a bit, my niece! You've heard from those of us upon this mountaintop, but Zeus sent several of his children to take care of things down closer to the base! They're probably just fine!" },
			},
			PoseidonAboutFamily02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0208",
					Text = "I know it can be difficult, but now we all must stand together, Niece! An uncommon family with a common goal! A crashing wave to wash away these troubled times!" },
			},

			PoseidonDevotionIntro01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					NamedRequirements = { "DevotionTestUnlocked" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0223",
					Text = "Ask {#Emph}any {#Prev}god upon Olympus whether we think you ought to join in our defense here, or take the fight to Chronos in your father's realm, and you'll get a {#Emph}range of views! {#Prev}A range of {#Emph}highly civil {#Prev}views, which we don't fight about {#Emph}at all!" },
			},
			PoseidonAboutInFighting01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonDevotionIntro01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0224",
					Text = "Remember how I said that we don't ever fight with one another on Olympus, little Niece? Well, that might have been a slight exaggeration on my part. But I stand with Hera on this one! We think your efforts are best spent up here!" },
			},

			PoseidonAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0031",
					Emote = "PortraitEmoteFiredUp",
					Text = "You made it to the surface, little niece! Too bad we couldn't scour the place before you got here, though! We're right in the middle of a big shake-up!" },
			},
			PoseidonAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0086",
					
					Text = "All that you look upon, both land and sea, that's {#Emph}my {#Prev}domain, you know! Long as you don't look up toward the heavens. That's the territory of your uncle Zeus! Though, I got the {#Emph}better {#Prev}share, I think!" },
			},
			PoseidonAboutSurface03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PoseidonAboutSurface01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0181",
					Emote = "PortraitEmoteSurprise",

					Text = "Wait, how is it that you live and breathe out here? I thought your father's line was doomed to linger underneath the earth, something like that? Ah, how the times have changed!" },
			},

			PoseidonAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0036",
					Emote = "PortraitEmoteSurprise",
					Text = "Where are you, Niece, the bottom of the sea?! Or very close to it! Must be even darker than what you're accustomed to. And the {#Emph}terrible {#Prev}pressure! Not even {#Emph}I {#Prev}can stand it for too long! So how can {#Emph}you?" },
			},
			PoseidonAboutOceanus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutOceanus01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0037",
					Emote = "PortraitEmoteSurprise",
					Text = "Your father never told me that his realm had all those twisting passageways right next to my domain! A {#Emph}drainage system {#Prev}of some sort, is it? Pouring right into my waters? Oh, I'd have words for Hades about {#Emph}this!" },
			},
			PoseidonAboutOceanus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutOceanus01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "G_Shop01", "G_Reprieve01", "G_PreBoss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0263",
					Text = "Those watery horrors you face... I just want you to know, they're not my fault! I don't abide such monsters in my realm. And so they sneak inside the Underworld to take their rancor out on you!" },
			},
			PoseidonAboutFields01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0258",
					Emote = "PortraitEmoteSurprise",
					Text = "Where on our green Earth do you reside {#Emph}now{#Prev}, Niece? It near resembles some of Demeter's rolling fields of grain! Who knew old Hades had a pasture growing in the Underworld, if but a rather dismal-looking one, near as I can tell!" },
			},

			PoseidonAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0087",
					
					Text = "Welcome to my boundless terrifying seas, my niece! Unfortunately teeming with invaders now. Got my hands full dealing with {#Emph}them{#Prev}, if you must know! But see if you can break through their blockade!" },
			},
			PoseidonAboutThessaly02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutThessaly01", },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0088",
					Text = "Right on that very spot once stood a massive army headed for our mountain, Niece! So I just split the earth right under them, {#Emph}haha! {#Prev}So now we have a massive {#Emph}navy {#Prev}to contend with, and contend we shall!" },
			},
			PoseidonAboutThessaly03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "O_Intro" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0299",
					Emote = "PortraitEmoteFiredUp",
					Text = "You braved the waters in the Rift of Thessaly! A nautical experience not for the faint of heart, fraught as it is with deathless ships hell-bent on your family's destruction! May you have smoother sailing there next time!" },
			},
			PoseidonAboutThessaly04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "O_Intro" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0300",
					Text = "When next you sail across the Rift, know this: I shall do my utmost to ensure a water-current speeds you mightily along! Though how to do it without benefitting the opposing ships...?" },
			},

			PoseidonUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0260",
					Emote = "PortraitEmoteSurprise",
					Text = "Did you do it, Niece?! Strange things have happened since the other night; {#Emph}good {#Prev}things, if you are not one of our enemies! We think perhaps you cut old Chronos down to size! But he just grows right back, as I recall!" },
			},
			PoseidonUnderworldRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonUnderworldRunCleared01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0261",
					Text = "We've all been counting on you, little Niece, but {#Emph}still! {#Prev}I'd not expected you could take on Chronos and prevail! I thought at best you'd keep him busy for a while. You must be very strong, like {#Emph}me!" },
			},
			PoseidonSurfaceRunStartPostUnderworldL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "ActiveBounty" }
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0294",
					Text = "Grown frustrated trying to take down Chronos, Niece? I know the feeling all too well! But now you're here upon the surface, where Olympus reigns supreme! At least for now!" },
			},
			PoseidonSurfaceRunStartPostUnderworldW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0295",
					Text = "Now that you've given Chronos something to really think about, you're headed back our way? First, an Underworld victory, and next perhaps one {#Emph}here!" },
			},
			PoseidonUnderworldRunStartPostSurfaceL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "O_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "ActiveBounty" }
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0296",
					Text = "Returned for now to more-familiar depths, I see! Well, don't feel bad; the surface-world is not for everyone! Although the risen dead increasingly {#Emph}pretend {#Prev}it is for them!" },
			},

			PoseidonAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0221",
					
					Text = "The Cyclops Polyphemus bars your passage to the channel cutting through the countryside?! That spoilsport! Once played a little jape to make him think he was my son, and he's been sore about it since!" },
			},
			PoseidonAboutPolyphemus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutPolyphemus01" },
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "N_Boss01" },
					},
					MinRunsSinceAnyTextLines = { TextLines = { "PoseidonAboutPolyphemus01" }, Count = 2 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0222",
					Text = "To think that {#Emph}anybody {#Prev}could have thought I sired such a monstrous scamp as Polyphemus! Still, I used to look out for him. Not like he could look out for himself with just one eye, {#Emph}hahaha!" },
			},
			PoseidonAboutPolyphemus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutPolyphemus01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "N_PostBoss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0089",
					Text = "If you got past Polyphemus before, you can do it again, can't you, my niece? Once you make it past the docks, it's a straight shot down the channel to Olympus! Treacherous waters, yes, but I can help you navigate, I'm sure!" },
			},

			PoseidonAboutScylla01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "G_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0183",
					Text = "Word has reached me that you clashed with Scylla and her Siren followers! So {#Emph}that's {#Prev}where they ended up! They once were the torment of many a sailor, till I took care of {#Emph}them!" },
			},
			PoseidonAboutScylla02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutScylla01" },
					},
					{
						Path = { "GameState", "EnemyKills", "Scylla" },
						Comparison = ">=",
						Value = 2,
					},
					{
						Path = { "PrevRun", "EnemyKills", "Scylla" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0259",
					Text = "I like to keep up with current events, and I hear you gave that loud-mouth Scylla and her Siren hangers-on quite the performance of your own! Too bad their godlike nature means they can't be killed! But they can certainly be shamed!" },
			},

			PoseidonAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "O_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0291",
					Emote = "PortraitEmoteFiredUp",
					Text = "Most of you Underworld gods are more than welcome on Olympus here, when we are not at war; but not {#Emph}Eris! {#Prev}Her antics ruined one too many feasts! And now she flaps about our borders, mocking us and making matters {#Emph}worse!" },
			},

			PoseidonAboutLittleHades01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "PoseidonGift01", "PoseidonAboutZagreus01" },
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0043",
					
					Text = "Your brother, Niece, I used to call him little Hades... I, I think that fits you, {#Emph}too! {#Prev}Especially since he's gone! It should be clear whom I'm referring to, right, little Hades?" },
			},

			PoseidonAboutFrogFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "FrogFamiliar" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0182",
					
					Text = "One thing about me, Niece, is I've a keen eye for amphibians; and that one with you there is a fine specimen indeed! Mislikes briny waters, but no beast is perfect!" },
			},

			PoseidonAboutAxe01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponAxe" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HephaestusAboutAxe01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0297",
					Emote = "PortraitEmoteFiredUp",
					Text = "I must say that's a most-substantial labrys that you wield! The Moonstone Axe, Hephaestus says? Well nothing bests a trusty trident! The tongs of this little fork of mine have wrenched free many a blade!" },
			},

			PoseidonAboutWater01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0062",
					
					Text = "Water's a fascinating substance, Niece! Cuts through the tallest mountains with sufficient time, and yet mortals need to drink the stuff to live! You're multitalented as well, aren't you?" },
			},

			PoseidonAboutRain01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},					
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "WetState" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0214",
					Text = "Is that a bit of rainfall in your whereabouts? {#Emph}Ah{#Prev}, you should see old Demeter and Zeus fight over who's responsible! I merely watch and laugh, for either way, it's more water for me!" },
			},

			PoseidonAboutDams01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0063",
					
					Text = "You know what dams are, Niece? Ramshackle structures mortals use to hold my waters back! But when I'm angry, {#Emph}bwaah{#Prev}, my water crashes through! Be like that water, don't hold back, all right?" },
			},
			PoseidonAboutLuxuries01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0064",
					
					Text = "A shame you had to grow up in the middle of nowhere, my niece! We gods require certain luxuries. Even your stodgy old father liked his gems and such! But you got by with nothing of the sort!" },
			},

			PoseidonAboutSwimming01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0022",
					Emote = "PortraitEmoteFiredUp",
					
					Text = "I wonder, my good Niece, are you prepared to sink? Or are you prepared to swim? {#Emph}Swim{#Prev}, I say! Swim like our very livelihoods depend on it!" },
			},
			PoseidonAboutStalemate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0023",
					Emote = "PortraitEmoteFiredUp",
					
					Text = "Ahoy, my magick-using niece, for it is I! We have the Titan in a stalemate, so you take all the time you need bailing us out!" },
			},
			PoseidonAboutTrading01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0024",
					Emote = "PortraitEmoteFiredUp",
					
					Text = "Here, my niece, what say we make a trade? My bountiful blessing in exchange for your fierce battle-skills! How fair a trade is that?!" },
			},
			PoseidonAboutStalemate02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0026",
					
					Text = "We're positively {#Emph}drowning {#Prev}in the Titan's wretched forces, Niece! But we are {#Emph}gods! {#Prev}We've might enough to hold them off I think!" },
			},
			PoseidonAboutStorms01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0027",
					
					Text = "No telling when a storm's about to hit up here, my niece! Not even a big dangerous one such as this! You'd think I could have seen it coming, but you'd be wrong!" },
			},
			PoseidonAboutStalemate03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "H" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0028",
					
					Text = "I trust your battles are proceeding well down there? As for our battles here, why, they are going swimmingly I'd say! We barely need your help!" },
			},
			PoseidonAboutVengeance01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "H" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0029",
					
					Text = "How you must thirst for vengeance, Niece! I know the feeling only all too well! {#Emph}Vengeance! {#Prev}As cold and dark as the bottom of the sea!" },
			},
			PoseidonAboutPressure01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0030",
					
					Text = "Within my oceans, Niece, the deeper you go, the fiercer the pressure! It's almost like you're in too deep yourself!" },
			},

			PoseidonAboutChoices01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0084",
					
					Text = "As gods, we {#Emph}all {#Prev}must make hard choices, Niece. Just earlier, I was unable to decide between causing a massive earthquake or a deadly tidal wave! Ended up doing both, but you catch my meaning, right?" },
			},
			PoseidonAboutDisasters01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0085",
					
					Text = "Much as I'd hate to see the world's surface devastated in the wake of our great war, I'm prepared to do whatever it takes! Even if it means causing much of that devastation myself!" },
			},

			PoseidonAboutFishing01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "EquippedToolName" },
						IsAny = { "ToolFishingRod", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0179",
					Emote = "PortraitEmoteSurprise",
					Text = "Why, you possess a rod of fishing there! What lingering doubts I had of you just vaporized. What are we even fighting for, if not the right to fish whensoever we desire?" },
			},
			PoseidonAboutFishing02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeFishingPoint" },
					},
					{
						Path = { "GameState", "EquippedToolName" },
						IsAny = { "ToolFishingRod", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0180",
					
					Text = "You know, Niece, the Cocytus River flowing through those musty woods of yours is quite the fishing-spot! You'd be doing all those river denizens a favor getting them out of there!" },
			},
			PoseidonAboutFishing03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "FishingSuccessesManual" },
						Comparison = ">=",
						Value = 1,
					},
					--[[ alternative fishing styles
					{
						Path = { "CurrentRun", "FishingSuccesses" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "FishingSuccessesFamiliar" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "FishingFails" },
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "FishCauhgt" },
						HasAny = { "FishFLegendary" },
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0262",					
					Text = "You've something freshly caught thanks to that Rod of Fishing, I can tell! I don't permit just {#Emph}anybody {#Prev}to dredge up my denizens of the deep! Yet it's almost as though they wish to hop right out of there for you!" },
			},

			PoseidonAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "ForcePoseidonBoonTrait" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0256",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ah, haha! {#Prev}I see the tide's come in! Well, my niece... what do you say we sweep clean through those cheerless woods of yours as might a cataclymic flood?" },
			},
			PoseidonAboutKeepsake02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "ForcePoseidonBoonTrait" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0264",
					Emote = "PortraitEmoteFiredUp",
					Text = "I know well that impressive glimmer of the Vivid Sea that I bestowed to you, my niece! Not all my seas are quite as vivid-blue; you have yourself a sample of the very best!" },
			},

			-- misc contexts
			PoseidonAboutPackageBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyOceanus" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0257",
					Emote = "PortraitEmoteSurprise",
					Text = "I don't know what you did, exactly, Niece, but you have summoned me, and I am here! In spirit, anyway, and with such Boons as ought to practically ensure your victory!" },
			},
			PoseidonAboutPackageBounty02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyPoseidon" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0255",
					Emote = "PortraitEmoteSurprise",
					Text = "Why, little Niece, you sailed down there faster than the trimmest mortal ship! Well then, what say we scour clean this little corner of the sea!" },
			},

			-- legendary
			PoseidonLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0080",
					
					Text = "No point in holding back even a smidge when we're in such a serious predicament, is there? So here, some of my raw unbridled power ought to {#Emph}tide {#Prev}you over, I should think!" },
			},
			PoseidonLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0081",
					
					Text = "So many of our enemies once feared us gods, but turned their backs on us! I'd say a show of overwhelming force ought to remind them who's the captain of the ship, however, no?" },
			},

			PoseidonLegacyBoonIntro01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = ">=",
						Value = 5,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0220",
					Text = "As you embark on your fateful voyage yet again, my niece, I have something for you! The newfangled Boons we offer haven't always swept you off your feet; but we have older, sometimes {#Emph}stronger {#Prev}blessings, too!" },
			},

			-- about other gods
			PoseidonAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "ZeusUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					--[[
					{
						Path = { "GameState", "TextLinesRecord", },
						-- HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "AthenaFirstPickUp", "AphroditeFirstPickUp", "AresFirstPickUp", "ArtemisFirstPickUp", "DionysusFirstPickUp" },
					},
					{
						Path = { "CurrentRun", "LootTypeHistory", },
						-- HasAll = { "SkellyChat01", "SkellyChat02", },
					},
					]]--

				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0040",
					Text = "I see that my great brother Zeus already blessed you with his incomparable strength! Well, perhaps not {#Emph}incomparable. {#Prev}Here! Have some of {#Emph}mine{#Prev}, and you can weigh the benefits!" },
			},
			PoseidonAboutHera01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0071",
					
					Emote = "PortraitEmoteSparkly",
					Text = "You're favored by Queen Hera, little Niece! That's her blessing, all right! High honor to have gotten it, especially for one who to my knowledge is unwed! She never favors {#Emph}me!" },
			},
			PoseidonAboutApollo01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
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

				{ Cue = "/VO/Poseidon_0020",
					
					Text = "You've met the brilliant Apollo, have you, Niece? He's near as popular with mortals as am I! Perhaps among his many talents he can help you get us out of this!" },
			},
			PoseidonAboutAphrodite01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0070",
					
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Ah{#Prev}, you seem lovelier than ever, Niece! As though the splendrous Aphrodite herself bestowed to you her gifts! She did so, didn't she, the scamp!" },
			},
			PoseidonAboutHestia01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HestiaUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0072",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Oh-hoh{#Prev}, I haven't seen old Hestia this energized in ages, Niece! And now her fiery ability is yours! As to whoever said that fire and water don't mix, I'm here to prove them wrong!" },
			},
			PoseidonAboutDemeter01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "DemeterUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0171",
					
					Text = "{#Emph}Ah{#Prev}, you've earned the frosty blessing of {#Emph}Elder Goddess Demeter{#Prev}, as I like to call her! To which she threatens to freeze my oceans! To which I apologize profusely, and we move on!" },
			},
			PoseidonAboutHephaestus01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0173",
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "PortraitEmoteFiredUp", DoShake = true, WaitTime = 10.0 },
					Text = "Why, even from this vantage point, I see that silver of yours gleaming like the abalone shell! The mark of talented Hephaestus, isn't it? At least his {#Emph}handiwork {#Prev}looks good, {#Emph}hahahah ha-hah!" },
			},
			PoseidonAboutHephaestus02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HephaestusUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0172",
					
					Text = "Niece, you ever get a ringing in your ears? Well I do, and not from the water pressure, but from hearing good Hephaestus go {#Emph}a-clang, a-clang, a-clang! {#Prev}Why it's enough to drive me {#Emph}mad!" },
			},
			PoseidonAboutHermes01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "HermesUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0174",
					Emote = "PortraitEmoteSurprise",
					
					Text = "{#Emph}Whoa{#Prev}, my niece, you seem possessed of an uncanny haste! Such swiftness as to be the envy of that rascal Hermes, who as per usual is nowhere to be found. Some messenger {#Emph}he {#Prev}is!" },
			},
			PoseidonAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "SpellDrop" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					--[[
					{
						Path = { "GameState", "TextLinesRecord", },
						-- HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "AthenaFirstPickUp", "AphroditeFirstPickUp", "AresFirstPickUp", "ArtemisFirstPickUp", "DionysusFirstPickUp" },
					},
					{
						Path = { "CurrentRun", "LootTypeHistory", },
						-- HasAll = { "SkellyChat01", "SkellyChat02", },
					},
					]]--

				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0021",
					
					Text = "You're shining like the Moon herself, my niece! Selene's aid, is it? Here I thought all she did was drive her pretty steeds over my ocean waves! She's dipping into other hobbies, then!" },
			},

			PoseidonAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01", },
					},
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "ArtemisFirstMeeting", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0209",
					Text = "Apollo said you met your flighty cousin Artemis! Now that's some tracking skill, I must admit! She's gone so often, figured she was merely lollygagging with her woodland friends again!" },
			},
			PoseidonAboutArtemis02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
					--[[ @purposely omitted
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0210",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Whaa--! {#Prev}So precisely did you dispatch your foes that I near mistook you for independent Artemis, my niece! I've no idea where {#Emph}that {#Prev}rascal is!" },
			},

			-- repeatable lines
			PoseidonChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0003",
					Emote = "PortraitEmoteFiredUp",
					
					Text = "My winsome niece, it is I! And I bring bounties to you from the seas themselves!" },
			},
			PoseidonChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0004",
					
					Text = "The greatest acts of vengeance don't come easily, my niece! So take heart, and also {#Emph}this!" },
			},
			PoseidonChat03 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0005",
					
					Text = "That blasted Titan thinks he's got us, but we'll show him he's all wet, won't we, my niece?" },
			},
			PoseidonChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0006",
					
					Text = "Remind that good-for-nothing Titan that Olympus is in charge, would you, my niece?" },
			},
			PoseidonChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0007",
					
					Text = "Look, we could use all the help we can get. And we can't be choosy when there's none-too-many fish in the sea!" },
			},
			PoseidonChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0008",
					
					Text = "I owe your father for his generosity. But since he's gone, I'll pay {#Emph}you {#Prev}back instead!" },
			},
			-- @ verify requirements
			PoseidonChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomCountCache", "P_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0009",
					
					Text = "Go show those Titans who's in charge, all right? If you catch my meaning, {#Emph}hahahaha!" },
			},
			PoseidonChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0010",
					
					Text = "The seas aren't going anywhere, and neither are we, right, my niece?" },
			},
			PoseidonChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0011",
					
					Text = "{#Emph}Hoh{#Prev}, my little niece, your greatest uncle's here! Here to make sure you really make a {#Emph}splash!" },
			},
			PoseidonChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0045",
					
					Text = "A storm is brewing, Niece. Big one, this time, why, even bigger than the last! Prepare!" },
			},
			PoseidonChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0046",
					
					Text = "Flow forth, my niece, and overwhelm all those who stand against us, would you there?" },
			},
			PoseidonChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0047",
					
					Text = "My waves can slam into the land with massive force, especially when I give them a little push!" },
			},
			PoseidonChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutLittleHades01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0048",
					
					Text = "We're in the middle of a war here, little Hades, so we'll chitchat later! Now, we fight!" },
			},
			PoseidonChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0049",
					
					Text = "All right, Niece, I've little patience left to spare right now, but that's good news for you!" },
			},
			PoseidonChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "PrevRun", "RoomCountCache", "Name", "N_Opening01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0050",
					
					Text = "You're here upon my surface, aren't you? Why, welcome back, and pardon all the mess!" },
			},
			PoseidonChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0051",
					
					Text = "Come on, Niece, let's go batter down our enemies like ships within a storm!" },
			},
			PoseidonChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0052",
					
					Text = "The tides are turning, can't you feel it, Niece? I can, of course, but surely you can, too!" },
			},
			PoseidonChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0053",
					
					Text = "High tide has come again, my niece! Which is my little way of saying, {#Emph}here we go!" },
			},
			PoseidonChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0054",
					
					Text = "No holding back this time, you hear me down there, Niece! Now let's get {#Emph}shaking!" },
			},
			PoseidonChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0055",
					
					Text = "You have the power of the seas right at your beck and call!" },
			},
			PoseidonChat21 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0056",
					
					Text = "The untold bounties of the sea are yours! Well, one of them, at least!" },
			},
			PoseidonChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0057",
					
					Text = "If only your father could see you now! Fortunately, I still sort of can!" },
			},
			PoseidonChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0058",
					
					Text = "The strength of earth and sea is yours again, if you can handle it, my niece!" },
			},
			PoseidonChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0059",
					
					Text = "I'll never stop fighting for you! Not until the fighting stops! Perhaps not even then!" },
			},
			PoseidonChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0060",
					
					Text = "You remind me of crusty old Hades more and more! In a good way!" },
			},
			PoseidonChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0061",
					
					Text = "One sudden surge of awesome might, coming right up!" },
			},
			PoseidonChat27 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0075",
					
					Text = "Arise, my niece! As would a fierce sea-creature of some sort! One blessed by {#Emph}me!" },
			},
			PoseidonChat28 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0076",
					
					Text = "Nothing beats doling out terrible consequences to our enemies, now, does it, Niece?" },
			},
			PoseidonChat29 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0077",
					
					Text = "Many great battles have been fought upon my seas, but they'll all pale in comparison to {#Emph}this!" },
			},
			PoseidonChat30 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0078",
					
					Text = "Come, Niece, let us crash upon our enemies as great waves upon a shore!" },
			},
			PoseidonChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0079",
					
					Text = "Even the mortals know the sea is bountiful, yet also capable of deadly force!" },
			},

		},

		BoughtTextLines =
		{
			PoseidonBlindBox01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFromSource = true,
						PathTrue = { "WasRandomLoot" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0292",
					Text = "Hoy, for it is I {#Emph}again{#Prev}, good Niece! Although presumably you must have known, as likely all the unmarked packaging concealing this Boon was soaked all the way through!" },
			},
			PoseidonBlindBox02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFromSource = true,
						PathTrue = { "WasRandomLoot" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0293",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Surprise! {#Prev}You are the fortunate recipient of my almighty Boon! Which means the legions of Chronos are in for an even {#Emph}bigger {#Prev}surprise... and not the {#Emph}good {#Prev}kind!" },
			},

			PoseidonLootBought01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0187",
					Text = "That old Underworld Boatman yet eludes the grasp of Chronos, does he? Turned to a life of the piratical smuggler in these dark times, {#Emph}augh!" },
			},
			PoseidonLootBought02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonLootBought01", },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0188",
					Text = "I fail to see why coin need change hands for a blessing from your uncle, though come to think, such blessings are most valuable indeed!" },
			},
			PoseidonLootBought03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonLootBought01", },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "G" },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0189",
					Emote = "PortraitEmoteFiredUp",
					Text = "Whatever Gold you paid ought to be at the bottom of the sea! Who does that Chronos think he is, showering mortals with shiny metals?" },
			},
			PoseidonLootBought04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonLootBought01", },
					},
					IsObjectTypeAlive = "NPC_Charon_01",
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0190",
					Text = "I trust your Boatman there appreciates that the smooth sailing he's experienced in his mercantile routes is no coincidence at all?" },
			},

		},

		RejectionTextLines =
		{
			PoseidonRejection01 =
			{
				{ Cue = "/VO/Poseidon_0191",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Augh! {#Prev}You have wounded me, my niece! Not physically, of course, but {#Emph}mentally! {#Prev}Such wounds as heal only with {#Emph}revenge!" },
			},
			PoseidonRejection02 =
			{
				{ Cue = "/VO/Poseidon_0192",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Sailors know the sea can be a moody mistress indeed, and you know why, my little niece? Because {#Emph}I {#Prev}can be a moody {#Emph}mister!" },
			},
			PoseidonRejection03 =
			{
				{ Cue = "/VO/Poseidon_0193",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Emote = "PortraitEmoteSurprise",
					Text = "You reject my blessing, Niece? Well then I'll just have to offer it to whomever else drifts by. Perhaps {#Emph}they'll {#Prev}appreciate it!" },
			},
			PoseidonRejection04 =
			{
				{ Cue = "/VO/Poseidon_0194",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Friendly bit of advice, you turn your back on the sea, you're going to regret it. And the sea in this case is {#Emph}myself!" },
			},
			PoseidonRejection05 =
			{
				{ Cue = "/VO/Poseidon_0275",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "There you go again, brushing me aside like a bit of seaweed clinging to your leg! Is that what you take me for, Niece?!" },
			},
			PoseidonRejection06 =
			{
				GameStateRequirements =
				{
					RequiredMinAnyTextLines = { TextLines = { "PoseidonRejection01", "PoseidonRejection02", "PoseidonRejection03", "PoseidonRejection04", "PoseidonRejection05", "PoseidonRejection07", "PoseidonRejection08", "PoseidonRejection09", "PoseidonRejection10", "PoseidonRejection11", "PoseidonRejection12" }, Count = 2 },
				},
				{ Cue = "/VO/Poseidon_0276",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Text = "I see, you want my blessing still, except a little less than that one you just took! And you want it after a very rousing fight!" },
			},
			PoseidonRejection07 =
			{
				{ Cue = "/VO/Poseidon_0277",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You are swimming in dangerous waters with such antics, Niece. If you so wish to see what lurks in these depths, {#Emph}fine!" },
			},
			PoseidonRejection08 =
			{
				GameStateRequirements =
				{
					RequiredMinAnyTextLines = { TextLines = { "PoseidonRejection01", "PoseidonRejection02", "PoseidonRejection03", "PoseidonRejection04", "PoseidonRejection05", "PoseidonRejection06", "PoseidonRejection07", "PoseidonRejection09", "PoseidonRejection10", "PoseidonRejection11", "PoseidonRejection12" }, Count = 4 },
				},
				{ Cue = "/VO/Poseidon_0278",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh come {#Emph}on{#Prev}, little niece, it's like you pick against me every single time! It cannot possibly be worth it to incur my wrath!" },
			},
			PoseidonRejection09 =
			{
				{ Cue = "/VO/Poseidon_0279",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I'd not have made that choice if I were you, but then, if I were {#Emph}you {#Prev}I wouldn't still be {#Emph}me{#Prev}, so... {#Emph}augh{#Prev}, you get my drift!" },
			},
			PoseidonRejection10 =
			{
				{ Cue = "/VO/Poseidon_0280",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Text = "So, my many different potent blessings just aren't good enough for you? Is that what you would like me to believe?!" },
			},
			PoseidonRejection11 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "LastReward", "Name" },
						IsAny = { "ZeusUpgrade" },
					},
				},
				{ Cue = "/VO/Poseidon_0281",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Text = "Now, strictly speaking, Niece, you chose correctly in deferring to my brother Zeus. But I must still save face!" },
			},
			PoseidonRejection12 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "LastReward", "Name" },
						IsAny = { "HeraUpgrade" },
					},
				},
				{ Cue = "/VO/Poseidon_0282",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Ladies first, is that the way of it, young Niece? I'm sure Queen Hera is most pleased with you, but I, for one, am not!" },
			},

		},

		RejectionVoiceLines =
		{
			[1] = GlobalVoiceLines.GodRejectedVoiceLines,
		},

		MakeUpTextLines =
		{
			PoseidonMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0195",
					Text = "Fear not, Niece, all my anger's washed away as quickly as it swelled. That's emotions for you! The seas themselves are simpler to control!" },
			},
			PoseidonMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0196",
					Text = "I got a little heated there I think, but I've cooled off! No lasting harm, though to be fair, my blessing here won't last too long either!" },
			},
			PoseidonMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0197",
					Text = "All right, that's enough splashing around, I think! My wrath has ebbed back into the sea that is wherever my wrath is stored!" },
			},
			PoseidonMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0198",
					Text = "{#Emph}Eh! {#Prev}Had so much vengeance on the mind, I let you have a little taste back there. Fear not! Only our enemies shall be getting the full course!" },
			},
			PoseidonMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0283",
					Text = "I shall count this one as an honest mistake on your part, for I can fathom no other explanation for what transpired here!" },
			},
			PoseidonMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0284",
					Emote = "PortraitEmoteFiredUp",
					Text = "Now {#Emph}that {#Prev}is how I like to settle a dispute! Using whichever impressionable creatures are around to make my dissatisfaction known!" },
			},
			PoseidonMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0285",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Augh! {#Prev}There I go, fighting my kin again, when I ought turn my wrath against our common enemy, who is our kin as well!" },
			},
			PoseidonMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0286",
					Emote = "PortraitEmoteFiredUp",
					Text = "Why, you just wiped the {#Emph}floor {#Prev}with all of those has-beens! And just like that, my fury's ebbed away as well!" },
			},
			PoseidonMakeUp09 =
			{
				GameStateRequirements =
				{
					RequiredMinAnyTextLines = { TextLines = { "PoseidonMakeUp01", "PoseidonMakeUp02", "PoseidonMakeUp03", "PoseidonMakeUp04", "PoseidonMakeUp05", "PoseidonMakeUp06", "PoseidonMakeUp07", "PoseidonMakeUp08", "PoseidonMakeUp10", "PoseidonMakeUp11", "PoseidonMakeUp12" }, Count = 5 },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0287",
					Text = "All right, Niece, I'll let you off with a warning just this once. Or however many times it's been! I've really no idea..." },
			},
			PoseidonMakeUp10 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0288",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Oh-hoh{#Prev}, this little fishie can bite back! Perhaps I shouldn't be rewarding you for this! But I just cannot help myself!" },
			},
			PoseidonMakeUp11 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0289",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Augh{#Prev}, all is forgiven, Niece, no need to fret! I was just testing your resolve, and evidently, you have plenty of it still!" },
			},
			PoseidonMakeUp12 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0290",
					Emote = "PortraitEmoteFiredUp",
					Text = "Why are we dallying when we have bigger fish to fry? Oh right, because you picked a fight with me! Though does this mean I lost...?" },
			},
		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			PoseidonGift01 =
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
						PathTrue = { "GameState", "UseRecord", "PoseidonUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0505", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I heard so much about you, Uncle, but you're not just very strong, you're generous as well. I am grateful, and would give you this." },
				{ Cue = "/VO/Poseidon_0066",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Oh, little Niece, how {#Emph}thoughtful{#Prev}, but {#Emph}deeply {#Prev}unnecessary! Yet now {#Emph}I'm {#Prev}feeling generous, so here! This one's for you!" },
			},
			PoseidonGift02 =
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
						PathTrue = { "GameState", "UseRecord", "PoseidonUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0504", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Uncle Poseidon, it is an honor to have earned your blessing. Especially for all the battles still to come." },
				{ Cue = "/VO/Poseidon_0067",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Hah{#Prev}, well I am left to wonder who it was that taught you such good manners, Niece? You're like a proper little lady, I'm impressed!" },
			},
			PoseidonGift03 =
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
						PathTrue = { "GameState", "UseRecord", "PoseidonUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1764", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "A little something to soothe the senses, Uncle Poseidon! I know it's hardly the occasion now, but isn't there always some cause to celebrate?" },
				{ Cue = "/VO/Poseidon_0068",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "You praise your uncle, and your uncle, why, he thinks it's really great! {#Emph}I {#Prev}think it's great, that is! That you would think of gifts in times like these!" },
			},
			PoseidonGift04 =
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
						PathTrue = { "GameState", "UseRecord", "PoseidonUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1765", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "This one's for you, Uncle! May you shake all our foes from the land, and your seas swallow them, that they rue the day they rose against us!" },
				{ Cue = "/VO/Poseidon_0069",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Of all the many sacrifices I have been receiving as of late, and there have been a lot, yours have been the very best of all, my niece!" },
			},

			-- placeholder
			PoseidonGiftTemp =
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

			{ Cue = "/VO/Melinoe_1735", Text = "Well this is quite a catch." },
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

		DeathTauntVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 1.25,
			NoTarget = true,
			Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },

			{ Cue = "/VO/Poseidon_0206", Text = "You mess with the sea, you get sunk. Remember that!", PlayFirst = true },
			{ Cue = "/VO/Poseidon_0207", Text = "{#Emph}Augh{#Prev}, blasted temper of mine! Seems I lost it again!" },
			{ Cue = "/VO/Poseidon_0251", Text = "You sailed right into the rocks like a young fool." },
			{ Cue = "/VO/Poseidon_0252", Text = "I am not easy to offend, yet here we are!" },
			{ Cue = "/VO/Poseidon_0253", Text = "You make me angry, I won't let you off the hook!" },
			{ Cue = "/VO/Poseidon_0254", Text = "Enough of this, we've bigger fish to fry!" },
		},

		RarityUpgradeVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
			Cooldowns =
			{
				{ Name = "BoonRarifiedSpeech", Time = 60 },
			},

			{ Cue = "/VO/Poseidon_0231", Text = "You got it!" },
			{ Cue = "/VO/Poseidon_0232", Text = "Oh, very well!", PlayFirst = true },
			{ Cue = "/VO/Poseidon_0233", Text = "Why, certainly!" },
			{ Cue = "/VO/Poseidon_0234", Text = "{#Emph}Ahh{#Prev}, why not!!" },
			{ Cue = "/VO/Poseidon_0235", Text = "{#Emph}Hahaha! {#Prev}Sure!" },
			{ Cue = "/VO/Poseidon_0236", Text = "All right...!" },
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
			TriggerCooldowns = { "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Poseidon_0215", Text = "Hoy there my niece!" },
			{ Cue = "/VO/Poseidon_0216", Text = "Good tidings to you, Niece!" },
			{ Cue = "/VO/Poseidon_0217", Text = "Such is the smuggler's life!" },
			{ Cue = "/VO/Poseidon_0218", Text = "Ah there you are!" },
			{ Cue = "/VO/Poseidon_0219", Text = "You found me, {#Emph}hahaha!" },
			{ Cue = "/VO/Poseidon_0225", Text = "It is I, {#Emph}haha!" },
			{ Cue = "/VO/Poseidon_0226", Text = "Hoy there!" },
			{ Cue = "/VO/Poseidon_0227", Text = "Good tidings!" },
			{ Cue = "/VO/Poseidon_0228", Text = "What-ho?!" },
		},
	},	

}

OverwriteTableKeys( LootData, LootSetData.Poseidon )