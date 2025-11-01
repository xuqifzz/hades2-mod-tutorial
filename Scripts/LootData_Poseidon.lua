LootSetData.Poseidon =
{
	-- Poseidon
	PoseidonUpgrade =
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		GameStateRequirements =
		{
			--
		},
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		Weight = 10,
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
		EmoteOffsetY = -280,
		EmoteOffsetX = -45,
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

			-- Elemental
			"ElementalHealthBoon",

			-- Legendary
			"AmplifyConeBoon",

			-- Duos
			"LightningVulnerabilityBoon",
			"MoneyDamageBoon",
			"GoodStuffBoon",
			"PoseidonSplashSprintBoon",
			"AllCloseBoon",
			"SteamBoon",
			"MassiveCastBoon",
			"DoubleSplashBoon",
		},
		Consumables = { },

		SpeakerName = "Poseidon",
		Speaker = "NPC_Poseidon_01",
		LoadPackages = { "Poseidon", },
		Portrait = "Portrait_Poseidon_Default_01",
		WrathPortrait = "Portrait_Poseidon_Default_01_Wrath",
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
			TriggerCooldowns = { "MelinoeAnyQuipSpeech" },
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
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
		},

		DuoPickupTextLines =
		{
			PoseidonWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "LightningVulnerabilityBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "LightningVulnerabilityBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "MoneyDamageBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "PoseidonSplashSprintBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "GoodStuffBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "AllCloseBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0269",
					Text = "When battle rages all around, there's little time for love, little room for beauty! Yet Aphrodite here, she never loses heart! It's almost precious how she strives with all her might, brandishing that decorative spear of hers!" },
				{ Cue = "/VO/Aphrodite_0145",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Emote = "PortraitEmoteAffection",
					Text = "Well, good Lord Poseidon, I'm pleased to know how I {#Emph}inspire {#Prev}you. Though perhaps you ought pay more attention to our {#Emph}foes {#Prev}than to what {#Emph}I {#Prev}do with my spear, so we can turn this battle in our favor, finally!" },
			},

			PoseidonWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "MassiveCastBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "SteamBoon" },
					},
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
			PoseidonWithAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "DoubleSplashBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0353",
					Text = "He may not always make for the most {#Emph}pleasant {#Prev}company, but times of {#Emph}peace {#Prev}don't always last, and my good nephew Ares here is excellent to have around for {#Emph}that! {#Prev}Now don't be shy, Ares! Come greet my niece would you?" },
				{ Cue = "/VO/Ares_0082",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AresUpgrade",
					Text = "My kin and I are already acquainted, Lord Uncle. Though she may not be overly familiar yet with what we can achieve when we combine your influence over the raging sea with what I do." },
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
					UseRoomContextArt = true,
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0038",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0039",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
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
			PoseidonUnderworldStartStreak01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "ClearedUnderworldRunsCache" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "H" },
					},
					{
						SumPrevRuns = 4,
						Path = { "BiomesReached", "F" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 4,
					},
					{
						SumPrevRuns = 4,
						Path = { "ActiveBounty" },
						CountPathTrue = true,
						Comparison = "<=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0375",
					Emote = "PortraitEmoteFiredUp",					
					Text = "You've been so focused on setting the Underworld right that I am hesitant to bring it up, Niece, {#Emph}but! {#Prev}Your contributions on the surface would be also welcome here, at any point!" },
			},
			PoseidonSurfaceStartStreak01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "ClearedSurfaceRunsCache" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
					},
					{
						SumPrevRuns = 4,
						Path = { "BiomesReached", "N" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 4,
					},
					{
						SumPrevRuns = 4,
						Path = { "ActiveBounty" },
						CountPathTrue = true,
						Comparison = "<=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0376",
					Emote = "PortraitEmoteFiredUp",
					Text = "So many of the Titan's legions you have wiped from the face of the earth, my niece! But more must gather in your father's Underworld! Do give them my {#Emph}blessings {#Prev}one of these nights, if you catch my drift!" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					-- redundant with the following event
					{
						PathFalse = { "GameState", "TextLinesRecord", "PoseidonAboutHades03" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutChronos02" }, Min = 3 },
					},
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
					Text = "Your father Hades and I didn't always get along. My crusty elder brother, I called him! Water under the bridge now. {#Emph}Ah{#Prev}, how I miss his dour cheerlessness, my niece!" },
			},
			PoseidonAboutHades03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
			PoseidonAboutHadesReturn01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Hades_Field_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0424",
					Emote = "PortraitEmoteFiredUp",
					Text = "How fares my crusty elder brother, is his home redecoration going well? Hades and I, we never used to talk too much since he moved underneath the earth! But now's the time for us to change all that!" },
			},

			-- mutually exclusive variant below
			PoseidonAboutFindingHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHades01", "HermesAboutHecate01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PoseidonAboutFindingHades01_B" },
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Story01" },
						Comparison = ">=",
						Value = 4,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "HecateAboutHades01", }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0298",
					Emote = "PortraitEmoteFiredUp",
					Text = "We heard the news that you found old Hades, Niece! The {#Emph}most-excellent {#Prev}news, I should say! Except the part that he is bound in Tartarus, that isn't excellent at all. {#Emph}We'll get you out of this, Brother!" },
			},
			PoseidonAboutFindingHades01_B =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HecateAboutHades01", "HermesAboutHecate01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "PoseidonAboutFindingHades01" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Story01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "I_Story01" },
						Comparison = "<",
						Value = 4,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0303",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "My crusty elder brother, you found him? In one piece?! I feared Hades would end up much like Chronos did once we were through with him way back. But Chronos simply chained him up in Tartarus? That's rather twisted actually..." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0044",
					
					Text = "You would have liked your brother, little Niece! Just about everybody did! He showered me with praise just like a mortal would. A little awkward, yes, but {#Emph}quite endearing{#Prev}, too!" },
			},
			PoseidonAboutZagreus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "C_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0429",
					Emote = "PortraitEmoteFiredUp",
					Text = "It's good to have your brother back, my niece! How he would scurry through your father's Underworld, like a rat fleeing a sinking ship! But now that ship is bound to be {#Emph}repaired! And {#Prev}it'll be a fine ship after all is said and done!" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0012",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
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
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutChronos02" }, Min = 2 },
					},
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutChronos02" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0015",
					Portrait = "Portrait_Poseidon_Displeased_01",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutChronos02" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0017",
					Portrait = "Portrait_Poseidon_Displeased_01",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutChronos02" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0032",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "As soon as Chronos attacked, why, we retaliated! A cataclysm like you've never seen! Ripped half this land apart. Left all the Titan's armies high and dry!" },
			},
			PoseidonAboutChronosPlan01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0364",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Old Chronos warrants every bit of justice you dispensed and more, my niece! I was already angry with him after everything he'd done, and that was {#Emph}prior {#Prev}to my realizing that he'd unleashed terrifying Typhon on us all!" },
			},
			PoseidonAboutNeoChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0427",
					Text = "As much I do welcome this now-gentler Father Chronos, who seems less desirous to see our home destroyed, I still am wary of that old coot! He's been cooperative, though...!" },
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
					Portrait = "Portrait_Poseidon_Displeased_01",
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
						Path = { "GameState", "UseRecord" },
						HasNone = { "NPC_Athena_01", "AresUpgrade" },
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "HephaestusFirstPickUp" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathFalse = { "GameState", "RoomsEntered", "P_Boss01" },
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
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Wait, how is it that you live and breathe out here? I thought your father's line was doomed to linger underneath the earth, something like that? Ah, how the times have changed!" },
			},
			PoseidonAboutSurface04 =
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
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = "<=",
						Value = 3,
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0312",
					Text = "You're getting closer to the snowy peaks that we call home! The biting chill is all part of our natural defenses, courtesy of Elder Goddess Demeter! We even have wondrous Automatons holding our foes at bay. You'll be {#Emph}amazed!" },
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
					-- Portrait = "Portrait_Poseidon_Displeased_01",
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
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Those watery horrors you face... I just want you to know, they're not my fault! I don't abide such monsters in my realm. And so they sneak inside the Underworld to take their rancor out on you!" },
			},
			PoseidonAboutOceanus04 =
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
				{ Cue = "/VO/Poseidon_0404",
					Emote = "PortraitEmoteFiredUp",
					Text = "All that trudging through the Oceanus waters must have made you strong and {#Emph}swift{#Prev}, my niece! Now that's aquatic exercise for you! What better way to stay in {#Emph}perfect {#Prev}shape?" },
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
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 3,
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
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "When next you sail across the Rift, know this: I shall do my utmost to ensure a water-current speeds you mightily along! Though how to do it without benefiting the opposing ships...?" },
			},
			PoseidonAboutThessaly05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0425",
					Text = "I promised I would close that Rift of Thessaly right up as soon as our war ended, {#Emph}but! {#Prev}Apparently we need for everything to be the way it was in order for your sorcery to work. Sounds like a promise I shall have to break!" },
			},

			PoseidonAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "Q" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0309",
					Emote = "PortraitEmoteSurprise",
					Text = "What, my niece, you're here?! I'd come down and welcome you myself, except our mountain home is crawling with invaders as you've probably observed! So we are at the summit... like a bunch of turtles hiding in their shells!" },
			},
			PoseidonAboutOlympus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "P" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0310",
					Emote = "PortraitEmoteFiredUp",
					Text = "You've seen it: Our mountain's like a cross between a luxurious palace and an impregnable fortress! The so-called {#Emph}legions of Chronos {#Prev}won't be getting through {#Emph}these {#Prev}walls!" },
			},
			PoseidonAboutOlympus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "P_Intro" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0311",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Olympus, gutted like a {#Emph}fish! {#Prev}Used to be all sorts of Nymphs and such that had a standing invitation here to make themselves at home! Surely they'll return once the dust settles a bit!" },
			},
			PoseidonAboutOlympus04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0405",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "These {#Emph}bothersome {#Prev}Satyrs, befouling our fair mountain! We've shored up our defenses against them, but by the time we clean up all the mess, they're {#Emph}back!" },
			},
			PoseidonAboutOlympus05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0426",
					Emote = "PortraitEmoteFiredUp",
					Text = "Even with Chronos having gone all soft, the battle on Olympus clearly isn't over yet! But we've shored up our defenses and are keeping all the remnant forces of Prometheus at bay! It's almost like a little {#Emph}ecosystem {#Prev}here!" },
			},

			PoseidonAboutFortress01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "Q" },
					},
					{
						PathFalse = { "CurrentRun", "BiomesReached", "Q" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0363",
					Text = "How did you like our fortress at this mountain's peak? It once stood proud and alabaster white before sinister Typhon corrupted it with all his grime and brood! But it's a sturdy structure and held fast so far!" },
			},

			PoseidonAboutAutomatons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "P" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutSurface04" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0313",
					Text = "About the wondrous Automatons that I described before... I ought have also mentioned that they currently cannot distinguish friend from foe! Hephaestus probably is working on that detail, but until then, best to give them a wide berth!" },
			},
			PoseidonAboutAutomatons02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "PrevRun", "EnemyKills" },
						HasAny = { "SentryBot", "AutomatonBeamer", "AutomatonEnforcer", "Talos" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0314",
					Emote = "PortraitEmoteFiredUp",
					Text = "Our powerful Automaton defenses that Hephaestus has been busy churning out are excellent at killing anything that moves! So don't take their behavior as a personal affront! We weren't counting on you getting all the way up here!" },
			},
			PoseidonAboutAutomatons03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "P" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutAutomatons02" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutAutomatons02" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0315",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "How disrespectful that our own Automatons would treat you like our common foe! Unfortunately they don't understand the meaning of respect at all! Last time I told them {#Emph}don't you dare attack my niece{#Prev}, they attacked {#Emph}me!" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
			PoseidonUnderworldRunCleared03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0428",
					Text = "When we first met, I promised terrible revenge for what had happened to your kin! And I think what we've done would qualify! So what if Chronos wasn't {#Emph}permanently slain? {#Prev}Neither was old Hades, after all!" },
			},

			PoseidonSurfaceRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
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
				{ Cue = "/VO/Poseidon_0358",
					Emote = "PortraitEmoteFiredUp",
					Text = "Oh, thank you, Niece! For we've defeated Typhon with your aid! Although {#Emph}defeated {#Prev}is a bit of a strong word, for it appears we merely knocked him down. Most likely made him angrier. {#Emph}Do {#Prev}make your way back when you can!" },
			},
			PoseidonSurfaceRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonSurfaceRunCleared01" }
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0359",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "What shall it take to put horrendous Typhon down for good?! He can't be reasoned with, recuperates his strength night after night, and has us cornered like a sturgeon in a net! But unlike {#Emph}fish{#Prev}, we can fight tirelessly back!" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
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
					-- borderline
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Emote = "PortraitEmoteFiredUp",
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
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0296",
					Text = "Returned for now to more-familiar depths, I see! Well, don't feel bad... the surface-world is not for everyone! Although the risen dead increasingly {#Emph}pretend {#Prev}it is for them!" },
			},
			PoseidonWinStreak01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						SumPrevRuns = 4,
						IgnoreCurrentRun = true,
						Path = { "Cleared" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 3,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0374",
					Emote = "PortraitEmoteFiredUp",
					Text = "Night after night, victory after victory, {#Emph}haha! {#Prev}You're making all of this look rather {#Emph}easy{#Prev}, Niece! Well then, sail on! And may my blessing make things easier still!" },
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
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
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
						Path = { "PrevRun", "RoomCountCache" },
						HasAny = { "N_Boss01", "N_Boss02" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutPolyphemus01" }, Min = 2 },
					},
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
			PoseidonAboutPolyphemus04 =
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
						SumPrevRuns = 3,
						Path = { "EnemyKills", "Polyphemus" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0377",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "You must not think too much of Cyclopes if Polyphemus is the only one you've met! They were our mighty allies once, you know! A shame what all has happened to their kind!" },
			},
			PoseidonAboutPolyphemus05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PolyphemusAboutNobody03", "PoseidonAboutPolyphemus02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutPolyphemus02" }, Min = 4 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0378",
					Emote = "PortraitEmoteFiredUp",
					Text = "To think I once felt pity for that Polyphemus, Niece! A Cyclops losing his good eye to a mere mortal voyager? Oh how I {#Emph}boiled {#Prev}over it back then, seeking the vengeance he was not going to find! But {#Emph}this {#Prev}is how he repays me?" },
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
					Emote = "PortraitEmoteFiredUp",
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
						SumPrevRuns = 3,
						Path = { "EnemyKills", "Scylla" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0259",
					Text = "I like to keep up with current events, and I hear you gave that loud-mouth Scylla and her Siren hangers-on quite the performance of your own! Too bad their godlike nature means they can't be killed! But they can certainly be shamed!" },
			},
			PoseidonAboutCharybdis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_MiniBoss01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0432",
					Emote = "PortraitEmoteFiredUp",
					Text = "Vast is my knowledge of the sea, and even {#Emph}still {#Prev}it has its many mysteries! For instance, how can such a horrifying monster as Charybdis come from such a wondrous place? {#Emph}And {#Prev}what's it doing in my {#Emph}Rift? {#Prev}Besides gorging itself!" },
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
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "O_Boss01", "O_Boss02" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0291",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Most of you Underworld gods are more than welcome on Olympus here, when we are not at war; but not {#Emph}Eris! {#Prev}Her antics ruined one too many feasts! And now she flaps about our borders, mocking us and making matters {#Emph}worse!" },
			},

			PoseidonAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0308",
					Text = "What I would like to know, my niece, is many things, such as: Just {#Emph}how {#Prev}did devious Prometheus slip from his bonds? {#Emph}Ah{#Prev}, these Titans! We can't seem to get rid of them for good. But we can douse the flames they stole at least!" },
			},
			PoseidonAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Prometheus" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0371",
					Emote = "PortraitEmoteFiredUp",
					Text = "That scoundrel Prometheus got a proper {#Emph}punishment {#Prev}from you last night, Athena says! We've been unable to subdue him, as he's sneaky like the forces he commands! But now you've drawn him out!" },
			},

			PoseidonAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Intro" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasNone = { "Q_MiniBoss03" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0369",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Some sort of {#Emph}dangerous phenomenon {#Prev}is taking place here on the summit, Niece! We dare not get too close to it as yet... so if you've heard the others speculate about its origin, those are mere unsubstantiated {#Emph}rumors{#Prev}, nothing more!" },
			},
			PoseidonAboutSurfaceThreat02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutSurfaceThreat01" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Intro" },
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0370",
					Emote = "PortraitEmoteFiredUp",
					Text = "The others say we face enormous {#Emph}Typhon {#Prev}as a threat, but I've seen no such thing! Of course I've lately not seen much of anything due to the cataclysmic storm up here! Though I {#Emph}am {#Prev}hearing a lot of low guttural roars!" },
			},

			PoseidonAboutSurfaceHelp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasNone = { "ZeusPalaceMeeting03", "ZeusPalaceMeeting03_A", "ZeusPalaceMeeting03_B" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZagreusPastMeeting04_2" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0433",
					Emote = "PortraitEmoteFiredUp",
					Text = "Whatever you have done to rile up old Chronos, he's taking it out on {#Emph}us! {#Prev}At least his forces on this mountain are! But fear not, for I have called for reinforcements! Several times!" },
			},

			PoseidonAboutPalace01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0380",
					Text = "My brother Zeus, he says you made it all the way up to our Palace, Niece! And sent the monster Typhon howling to the earth! Forgive my absence, all too many water-bodies to defend...!" },
			},
			PoseidonAboutPalace02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0423",
					Emote = "PortraitEmoteFiredUp",
					Text = "Terrible Typhon left his imprint on this mountainside, of that you can be sure! Even our Palace buckled under his immeasurable weight! But in the end, our Palace stands! Not he." },
			},

			PoseidonAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0355",
					Emote = "PortraitEmoteFiredUp",
					Text = "Did you see the {#Emph}size {#Prev}of that terrible Typhon, my niece?! It has been so long since last we fought that I daresay he's grown still larger in the intervening time! And {#Emph}sneakier {#Prev}as well! All of that shaking here... it was from {#Emph}him!" },
			},
			PoseidonAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
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
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0356",
					Emote = "PortraitEmoteFiredUp",
					Text = "Much like old Chronos, we have vanquished awful Typhon once before! Your Lord Uncle, he struck the final blow himself, a bolt of lightning right between the eyes! The two {#Emph}main {#Prev}eyes at least! He has so many of those eyes..." },
			},
			PoseidonAboutTyphon03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutTyphon01" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0357",
					Text = "You may be wondering what wisdom we can share in how to deal with horrid Typhon, since we battled him before. You'll have to ask Athena about that! Or perhaps Zeus. I played a more supporting role during that clash is all!" },
			},
			PoseidonAboutTyphon04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalacePostTrueEnding01" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0430",
					Emote = "PortraitEmoteFiredUp",
					Text = "The quaking on Olympus finally ceased! One of many benefits to awful Typhon being cast away! Apparently you have to face him somewhere still? At least some hallucinated revenant of him? Well I'm glad {#Emph}I {#Prev}don't!" },
			},
			PoseidonAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceAboutTyphonDeath01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0381",
					Emote = "PortraitEmoteFiredUp",
					Text = "You somehow did it, Niece, Typhon is {#Emph}gone! {#Prev}There is no longer any trace of him up here! So now to do the same to {#Emph}Chronos{#Prev}, then? Go on, let's give him everything we've got!" },
			},
			PoseidonAboutTyphonL01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0360",
					Emote = "PortraitEmoteFiredUp",
					Text = "At least you made the awful Typhon's life more difficult last night, my niece! He almost crushed you like a {#Emph}shellfish{#Prev}, didn't he? But you created just enough annoyance that we pushed him back after you ran away! Or whatever you did!" },
			},
			PoseidonAboutTyphonL02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutTyphonL01" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0361",
					Emote = "PortraitEmoteFiredUp",
					Text = "You were most brave to face gigantic Typhon as you did! And fortunate to have escaped, because I could have sworn he {#Emph}flattened {#Prev}you! We'll hold him off as long as possible, but if you're not too busy, we still need all hands on deck!" },
			},
			PoseidonAboutTyphonL03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
					{
						PathFalse = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0362",
					Emote = "PortraitEmoteSurprise",
					Text = "Where are you {#Emph}going{#Prev}, little niece?! The opposite direction of terrifying Typhon, that's how it appears to {#Emph}me! {#Prev}Which, come to think, seems like a reasonable course! But we assuredly could use your aid up here!" },
			},

			PoseidonAboutLittleHades01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "PoseidonGift05", "PoseidonAboutZagreus01" },
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0043",
					Text = "Your brother, Niece, I used to call him little Hades... I, I think that fits you, {#Emph}too! {#Prev}Especially since {#Emph}he's {#Prev}gone! It should be clear whom I'm referring to, right, little Hades?" },
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
			PoseidonAboutCatFamiliar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0304",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "What is that creature with you there, a {#Emph}cat? {#Prev}You should know something about cats, Niece: They hate water! And yet those {#Emph}fools {#Prev}require it to live! Perhaps that cat knows better, though, if it has the sense to follow you through {#Emph}hell!" },
			},
			PoseidonAboutCatFamiliar02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsAny = { "CatFamiliar" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutCatFamiliar01" },
					},
					{
						Path = { "GameState", "FishingSuccessesFamiliar" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "CurrentRun", "FishingSuccessesFamiliar" }
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonAboutCatFamiliar01" }, Min = 2 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0305",
					Text = "I take back all the horrid things I said regarding cats! For yours is an excellent fisherman. Fisher-{#Emph}cat? {#Prev}The point is I'd not known such creatures could appreciate the sea... which means {#Emph}they {#Prev}can be appreciated by {#Emph}me!" },
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
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasNone = { "AxePerfectCriticalAspect", "AxeRallyAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0297",
					Emote = "PortraitEmoteFiredUp",
					Text = "I must say that's a most-substantial labrys that you wield! The Moonstone Axe, Hephaestus says? Well nothing bests a trusty trident! The tongs of this little fork of mine have wrenched free many a blade!" },
			},

			PoseidonAboutSuit01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponSuit" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "PoseidonAboutAutomatons01", "PoseidonAboutAutomatons02", "PoseidonAboutAutomatons03" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0318",
					Text = "Though I have wielded virtually every type of weapon in my day, I have never seen such armaments as you now use, to quite spectacular effect! You'll be an even match for our Automatons with {#Emph}that!" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Intro" },
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
						PathFalse = { "CurrentRun", "BiomesReached", "G" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift04" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0084",
					Portrait = "Portrait_Poseidon_Displeased_01",

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
					Portrait = "Portrait_Poseidon_Displeased_01",
					
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
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0179",
					Emote = "PortraitEmoteSurprise",
					Text = "Why, you possess a Rod of Fishing there! What lingering doubts I had of you just vaporized. What are we even fighting for, if not the right to fish whensoever we desire?" },
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
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod", },
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
						Path = { "GameState", "FishCaught" },
						HasAny = { "FishFLegendary" },
					},
					]]--
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0262",					
					Text = "You've something freshly caught thanks to that Rod of Fishing, I can tell! I don't permit just {#Emph}anybody {#Prev}to dredge up my denizens of the deep! Yet it's almost as though they wish to hop right out of there for you!" },
			},
			PoseidonAboutFishing04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" },
					},
					{
						Path = { "GameState", "FishingSuccessesManual" },
						Comparison = ">=",
						Value = 8,
					},
					{
						PathNotEmpty = { "CurrentRun", "CurrentRoom", "FishingPointChoices" },
					},
					{
						Path = { "GameState", "EquippedFamiliar" },
						IsNone = { "CatFamiliar" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift03" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0319",
					Text = "Well, hurry up and take my Boon, for there's an opportunity to use your trusty Rod of Fishing right nearby! I sense such things down in the very fiber of my being, and shall observe your catch-attempts with keen interest!" },
			},
			PoseidonAboutFishingUpgrade01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod2", },
					},
					{
						Path = { "CurrentRun", "FishingSuccessesManual" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0398",
					Emote = "PortraitEmoteFiredUp",
					Text = "Now {#Emph}that {#Prev}is quite the handsome Rod of Fishing you possess, my niece! Premium materials, delicate proportions, sturdy grip; a {#Emph}masterwork! {#Prev}If I were a fish myself, I'd desire to be caught by nothing less!" },
			},			
			PoseidonAboutManyFish01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "FishCaught" },
						UseLength = true,
						Comparison = ">=",
						Value = 25,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0400",
					Emote = "PortraitEmoteSurprise",
					Text = "Why, you have caught practically all the water denizens under the sun, and underneath the earth! At least all the ones in all the regions that you normally traverse! That is perhaps your greatest feat thus far...!" },
			},
			PoseidonAboutLegendaryFish01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 1,
					},
					{
						SumPrevRuns = 3,
						Path = { "ResourcesGained", "FishPLegendary" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0372",
					Emote = "PortraitEmoteFiredUp",
					Text = "You caught a Starsailor here on our mountaintop, did you? And of none-too-modest size! Oh, I know every fish within my seas! And other smaller bodies of water as well!" },
			},
			PoseidonAboutLegendaryFish02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "Q_Intro" },
						Comparison = ">=",
						Value = 1,
					},
					{
						SumPrevRuns = 3,
						Path = { "ResourcesGained", "FishQLegendary" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0399",
					Emote = "PortraitEmoteFiredUp",
					Text = "You caught one of those ugly Chimaerids from the heart of Typhon's endless storm! A true {#Emph}abomination{#Prev}, not a true {#Emph}fish! {#Prev}But it has enough fishlike parts that we shall let it slide!" },
			},

			PoseidonAboutRareFish01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" },
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered", "Q_Intro" },
						Comparison = ">=",
						Value = 1,
					},
					{
						SumPrevRuns = 3,
						Path = { "ResourcesGained", "FishQRare" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0373",
					Text = "The Stormgullets and such within the stagnant pools here on the mountain's summit, Niece... I am surprised your Rod of Fishing does not snap retrieving them, such is their monstrous strength!" },
			},

			PoseidonAboutFishingQuest01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "WeaponsUnlocked", "ToolFishingRod" },
					},
					{
						Path = { "GameState", "FishingSuccessesManual" },
						Comparison = ">=",
						Value = 8,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift03" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0396",
					Text = "You've some experience with witchery, fine! But you have much to learn about the fishing arts! That you have demonstrated interest is the first step toward mastery; catching a huge variety of water denizens is the {#Emph}next!" },
			},
			PoseidonAboutFishingQuest02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PoseidonAboutFishingQuest01" },
					},
					{
						Path = { "GameState", "QuestStatus", "QuestCatchFish" },
						IsAny = { "CashedOut" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0397",
					Emote = "PortraitEmoteFiredUp",

					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },

					Text = "That you set aside such ample time to fish has not been lost on {#Emph}me{#Prev}, my niece! And you caught more types of water denizens than I can {#Emph}easily {#Prev}count! You already have my finest blessings; you now also have my deep respect." },
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
						HasAny = { "ForcePoseidonBoonKeepsake" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0256",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ah, haha! {#Prev}I see the tide's come in! Well, my niece... what do you say we sweep clean through those cheerless woods of yours as might a cataclysmic flood?" },
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
						HasAny = { "ForcePoseidonBoonKeepsake" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0264",
					Emote = "PortraitEmoteFiredUp",
					Text = "I know well that impressive glimmer of the Vivid Sea that I bestowed to you, my niece! Not all my seas are quite as clear and blue; you have yourself a sample of the very best!" },
			},
			PoseidonAboutKeepsake03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "ForcePoseidonBoonKeepsake" },
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "ForcePoseidonBoonKeepsake", 1, "Rarity" },
						IsAny = { "Epic", "Heroic" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0403",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Ah{#Prev}, there's the unmistakable refracting gleam of that Vivid Sea of mine, or I should say of {#Emph}yours! {#Prev}How it has flourished traveling with you! Your respect for my waters has not gone unnoticed here by me!" },
			},
			PoseidonAboutZeusKeepsake01 =
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
					{
						SumPrevRuns = 4,
						Path = { "TraitCache", "ForceZeusBoonKeepsake" },
						Comparison = ">=",
						Value = 3,
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = { "ForceZeusBoonKeepsake" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0401",
					Emote = "PortraitEmoteFiredUp",
					Text = "I couldn't help but notice how you seem to keep taking that Cloud Bangle with you from my brother Zeus! He is a very {#Emph}busy {#Prev}god, you understand, while I may aid you readily if you but use the Vivid Sea instead!" },
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
						IsAny = GameData.LateStartPackagedBounties,
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0255",
					Emote = "PortraitEmoteSurprise",
					Text = "Why, little Niece, you sailed down there faster than the trimmest mortal ship! Well then, what say we scour clean this little corner of the sea!" },
			},
			PoseidonAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 4,
					},
					{
						PathTrue = { "GameState", "ActiveShrineBounty" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0367",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Eugh{#Prev}, what is it about this night, my niece? Our foes all seem to have redoubled their efforts! Even {#Emph}retripled {#Prev}in some cases I daresay! As long as it's all due to your strange Underworld practices, according to our little Artemis!" },
			},
			PoseidonAboutShrine02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 20,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.AboutShrineEvents,
					},
				},			

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0368",
					Emote = "PortraitEmoteDepressed",
					Text = "Oh, what a horrifying night this is, as though our very nightmares walk the earth, or swim across the sea! Our foes are taken with such frenzy that this couldn't possibly be {#Emph}your {#Prev}doing, unless you've lost your senses like the rest?" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
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
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0081",
					
					Text = "So many of our enemies once feared us gods, but turned their backs on us! I'd say a show of overwhelming force ought to remind them who's the captain of the ship, however, no?" },
			},
			PoseidonAboutBoons01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "TraitsTaken" },
						HasAll =
						{
							"PoseidonWeaponBoon",
							"PoseidonSpecialBoon",
							"PoseidonCastBoon",
							"PoseidonSprintBoon",
							"PoseidonManaBoon",
							"PoseidonExCastBoon",
							"OmegaPoseidonProjectileBoon",
							"EncounterStartOffenseBuffBoon",
							"RoomRewardBonusBoon",
							"FocusDamageShaveBoon",
							"DoubleRewardBoon",
							"PoseidonStatusBoon",
							"ElementalHealthBoon", -- Elemental
							"AmplifyConeBoon", -- Legendary
						},
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0379",
					Emote = "PortraitEmoteFiredUp",
					Text = "You have discovered by now all my many Boons! I'm always thinking about more, of course! Used to have lots of different ones if you must know! But times have changed, and Brother Zeus says we must concentrate!" },
			},

			PoseidonLegacyBoonIntro01 =
			{
				PlayOnce = true,
				ForcedUpgradeOptions =
				{
					{
						Type = "Trait",
						ItemName = "RoomRewardBonusBoon",
						Rarity = "Common",
					},
					{
						Type = "Trait",
						ItemName = "EncounterStartOffenseBuffBoon",
						Rarity = "Common",
					},
					{
						Type = "Trait",
						ItemName = "DoubleRewardBoon",
						Rarity = "Common",
					},
				},
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0406",
					Emote = "PortraitEmoteFiredUp",
					Text = "Perhaps some of the newfangled Boons we've offered haven't always swept you off your feet, but we {#Emph}do {#Prev}still have certain {#Emph}older {#Prev}blessings closer to ones your brother used to get! Why here's a few right now!" },
			},

			PoseidonPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0382",
					Emote = "PortraitEmoteFiredUp",
					Text = "Chronos surrendered to us, Niece! You must have heard, you helped {#Emph}deliver {#Prev}him! Yet there remains some mess that must be cleaned? I could not follow what he rambled on about, but if you simply need my Boons, then {#Emph}here!" },
			},
			PoseidonPostTrueEnding02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonPostTrueEnding02" }, Min = 3 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0383",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "What is this about having to confront Chronos in other times? And even Typhon {#Emph}too?! {#Prev}I'll not pretend to understand, but if this is the cost of peace, I'll pay my share without a second thought!" },
			},

			PoseidonPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0421",
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "An age of mortals is to come? Not if I open up a few more rifts, it won't! {#Emph}Hah! {#Prev}The earth itself could swallow all of those ungrateful little louts, if the seas don't do it first!" },
			},
			PoseidonPostEpilogue02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "PoseidonPostEpilogue01" }, Min = 3 },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0422",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "I was upset when first I heard the Fates decided they would change things up on us! Have my brothers and I not ruled our realms with strength and gusto? But no use in fighting prophecy... though I may still complain!" },
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						PathFalse = { "GameState", "TextLinesRecord", "ZeusPalaceFirstMeeting" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0070",
					
					Emote = "PortraitEmoteSparkly",
					Text = "{#Emph}Ah{#Prev}, you seem lovelier than ever, Niece! As though the splendorous Aphrodite herself bestowed to you her gifts! She did so, didn't she, the scamp!" },
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0174",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Poseidon_Displeased_01",
					
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
						HasNone = GameData.GodAboutGodEvents,
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
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ArtemisFirstMeeting" }, Min = 2 },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ArtemisFirstMeeting" }, Max = 8 },
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
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0210",
					Emote = "PortraitEmoteSurprise",
					Text = "{#Emph}Whaa—! {#Prev}So precisely did you dispatch your foes that I near mistook you for independent Artemis, my niece! I've no idea where {#Emph}that {#Prev}rascal is!" },
			},

			PoseidonAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						SumPrevRuns = 3,
						Path = { "UseRecord", "NPC_Athena_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "AthenaFirstMeeting" }, Max = 8 },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0317",
					Text = "Wise Athena noted that the two of you have finally met! It ought have been the lot of us gathered here to welcome you with open arms, not just a bit of curt formality from that one! Not the warmest welcoming committee, is she?" },
			},

			PoseidonAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Dionysus_01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0316",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "It ought to be all-hands-on-deck here when we have the Titan's armies battering our gates! But wine-loving Dionysus, he so desires {#Emph}peace{#Prev}, yet refuses to {#Emph}fight {#Prev}for it! Oh I'd drown his sorrows myself if I but knew where he went!" },
			},

			PoseidonAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "AresUpgrade" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "AresFirstPickUp" }, Max = 8 },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0351",
					Emote = "PortraitEmoteFiredUp",
					Text = "At last, you've met militant {#Emph}Ares{#Prev}, little niece! Sometimes I think that {#Emph}he's {#Prev}to blame for everything, in all his warring ways! But then if not for him we'd have more difficulty fighting back. So I consider it a wash!" },
			},
			PoseidonAboutAres02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonAboutAres01" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0352",
					Emote = "PortraitEmoteSurprise",
					Text = "Is that the so-called blessing of my nephew Ares that you have already, or are you simply in the mood for some unmitigated wrath? Well don't forget the seas can be quite moody, too!" },
			},

			-- about other characters
			PoseidonAboutNemesis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "EncountersOccurredCache", "NemesisCombatG" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
					{
						PathTrue = { "CurrentRun", "SpawnRecord", "NPC_Nemesis_01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Nemesis_01" }, Alive = false },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0320",
					Text = "A goddess of considerable stature sometimes storms down through those depths, my niece! A friend of yours perhaps? For she bears fearsome Stygius, a blade that's served our family well! No match for this {#Emph}trident{#Prev}, of course!" },
			},

			PoseidonAboutHeracles01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatP", "HeraclesCombatP2" },
					},
					{
						SumPrevRuns = 2,
						Path = { "SpawnRecord", "NPC_Heracles_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Heracles_01" }, Alive = false },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0321",
					Emote = "PortraitEmoteSparkly",
					Text = "We {#Emph}do {#Prev}appreciate your intervention, though we've others pitching in! Such as stout-shouldered Heracles, you've seen him lately, yes? Even upon our snowy mountain here! I like you better, but he's {#Emph}good{#Prev}, I'll give him that!" },
			},

			PoseidonAboutIcarus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "EncountersOccurredCache" },
						HasAny = { "IcarusCombatP", "IcarusCombatP2" },
					},
					{
						SumPrevRuns = 2,
						Path = { "SpawnRecord", "NPC_Icarus_01" },
						Comparison = ">=",
						Value = 1,
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Icarus_01" }, Alive = false },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0322",
					Text = "We've powerful defenses on the ground, but face attackers from the skies as well! Harpies, Dracons, {#Emph}more! {#Prev}Also this little winged mortal fellow buzzing all about! Brother Zeus near-bolted him before we realized that he was on {#Emph}our {#Prev}side!" },
			},

			PoseidonAboutSayingLittle01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift07" },
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0431",
					Text = "My brother Zeus recently turned to me and said, {#Emph}Poseidon? There are times you talk too much! {#Prev}To which I said, {#Emph}you take that back! {#Prev}To which he said, {#Emph}no I shall not. {#Prev}To which I said, {#Emph}then fine! How about I talk less starting now?" },
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
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0005",
					
					Text = "That blasted Titan thinks he's got us, but we'll show him he's all wet, won't we, my niece?" },
			},
			PoseidonChat04 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Look, we could use all the help we can get. And we can't be choosy when there's none-too-many fish in the sea!" },
			},
			PoseidonChat06 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0008",
					
					Text = "I owe your father for his generosity. But since he's gone, I'll pay {#Emph}you {#Prev}back instead!" },
			},
			PoseidonChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
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
						PathFalse = { "PrevRun", "BiomesReached", "N" },
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
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G", "O" },
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
			PoseidonChat32 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0407",
					Text = "Don't let the pressure get to you as you dive down into those depths once more!" },
			},
			PoseidonChat33 =
			{
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
				{ Cue = "/VO/Poseidon_0408",
					Text = "Most of my land and sea is far more beauteous than {#Emph}that {#Prev}embattled stretch!" },
			},
			PoseidonChat34 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0409",
					Text = "I bid smooth sailing to you, Niece, and awful shipwrecks to our many foes!" },
			},
			PoseidonChat35 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "P", "Q" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0410",
					Text = "Much cleaning up to do both in your father's realm and mine, and I have {#Emph}just {#Prev}the thing!" },
			},
			PoseidonChat36 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0411",
					Text = "May you see {#Emph}this {#Prev}voyage to the destination you desire as with the night before!" },
			},
			PoseidonChat37 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 10,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0412",
					Text = "The seas themselves tremble on fearsome nights as this, but you take heart!" },
			},
			PoseidonChat38 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0413",
					Text = "Again you have embarked towards our shores, so here's a little wind in your sails!" },
			},
			PoseidonChat39 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0414",
					Text = "I daresay our enemies shall not be getting off the hook anytime soon!" },
			},
			PoseidonChat40 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G", "O" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonGift07" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0415",
					Text = "My heart swells with pride seeing you navigate troubled waters with such ease!" },
			},
			PoseidonChat41 =
			{
				PlayFirst = true,
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
				{ Cue = "/VO/Poseidon_0416",
					Text = "I take no responsibility at all for those fishlike monstrosities you have to face down there!" },
			},
			PoseidonChat42 =
			{
				PlayFirst = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G", "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0417",
					Text = "The waters may become a little rough but you have found your sea-legs, right, my niece?" },
			},
			PoseidonChat43 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0418",
					Text = "As you embark on your fateful voyage yet again, my niece, know that I am with you, in {#Emph}Boon form!" },
			},
			PoseidonChat44 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0419",
					Text = "You go sock that Typhon in the eye for me tonight would you? In {#Emph}all {#Prev}his foul eyes!" },
			},
			PoseidonChat45 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "PoseidonUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0420",
					Text = "We've navigated through rough waters many times! And it never seems to get any easier!" },
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
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "PoseidonUpgrade" },
						Comparison = "<=",
						Value = 0,
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
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "PoseidonUpgrade" },
						Comparison = "<=",
						Value = 0,
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "PoseidonUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
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
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "PoseidonUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "PoseidonLootBought01" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "G" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "PoseidonUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
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
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "PoseidonUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Poseidon_0190",
					Text = "I trust your Boatman there appreciates that the smooth sailing he's experienced in his mercantile routes is no coincidence at all?" },
			},
			PoseidonLootBought05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsAny = { "O_Shop01", "O_PreBoss01" },
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "PoseidonUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0365",
					Text = "Now that's a trim ship, with the Underworld Boatman at the helm! Perhaps I ought not call him Underworld Boatman anymore, for he's become a proper captain now! I'll have to keep the currents clear for him!" },
			},
			PoseidonLootBought06 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "P_Shop01", "P_PreBoss01" },
					},
					--[[
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					]]--
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "PoseidonUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Poseidon_0366",
					Text = "That Underworld Boatman, he can't sail to this mountaintop! Unless he fashions for himself a craft that sails on air, he shall be relegated to my waters! But how then did he get his goods up here...?" },
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
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "{#Emph}Augh! {#Prev}You have wounded me, my niece! Not physically, of course, but {#Emph}mentally! {#Prev}Such wounds as heal only with {#Emph}revenge!" },
			},
			PoseidonRejection02 =
			{
				{ Cue = "/VO/Poseidon_0192",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Sailors know the sea can be a moody mistress indeed, and you know why, my little niece? Because {#Emph}I {#Prev}can be a moody {#Emph}mister!" },
			},
			PoseidonRejection03 =
			{
				{ Cue = "/VO/Poseidon_0193",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "You reject my blessing, Niece? Well then I'll just have to offer it to whomever else drifts by. Perhaps {#Emph}they'll {#Prev}appreciate it!" },
			},
			PoseidonRejection04 =
			{
				{ Cue = "/VO/Poseidon_0194",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Friendly bit of advice, you turn your back on the sea, you're going to regret it. And the sea in this case is {#Emph}myself!" },
			},
			PoseidonRejection05 =
			{
				{ Cue = "/VO/Poseidon_0275",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "There you go again, brushing me aside like a bit of seaweed clinging to your leg! Is that what you take me for, Niece?!" },
			},
			PoseidonRejection06 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"PoseidonRejection01",
							"PoseidonRejection02",
							"PoseidonRejection03",
							"PoseidonRejection04",
							"PoseidonRejection05",
							"PoseidonRejection07",
							"PoseidonRejection08",
							"PoseidonRejection09",
							"PoseidonRejection10",
							"PoseidonRejection11",
							"PoseidonRejection12",
						},
						Comparison = ">=",
						Value = 2,
					},
				},
				{ Cue = "/VO/Poseidon_0276",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "I {#Emph}see{#Prev}, you want my blessing {#Emph}still{#Prev}, except a little {#Emph}less {#Prev}than that one you just {#Emph}took! {#Prev}And you want it after a very rousing {#Emph}fight!" },
			},
			PoseidonRejection07 =
			{
				{ Cue = "/VO/Poseidon_0277",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "You are swimming in dangerous waters with such antics, Niece. If you so wish to see what lurks in these depths, {#Emph}fine!" },
			},
			PoseidonRejection08 =
			{
				GameStateRequirements =
				{
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"PoseidonRejection01",
							"PoseidonRejection02",
							"PoseidonRejection03",
							"PoseidonRejection04",
							"PoseidonRejection05",
							"PoseidonRejection06",
							"PoseidonRejection07",
							"PoseidonRejection09",
							"PoseidonRejection10",
							"PoseidonRejection11",
							"PoseidonRejection12",
						},
						Comparison = ">=",
						Value = 4,
					},
				},
				{ Cue = "/VO/Poseidon_0278",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Oh come {#Emph}on{#Prev}, little niece, it's like you pick against me every single time! It cannot possibly be worth it to incur my wrath!" },
			},
			PoseidonRejection09 =
			{
				{ Cue = "/VO/Poseidon_0279",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "I'd not have made that choice if I were you, but then, if I were {#Emph}you {#Prev}I wouldn't still be {#Emph}me{#Prev}, so... {#Emph}augh{#Prev}, you get my drift!" },
			},
			PoseidonRejection10 =
			{
				{ Cue = "/VO/Poseidon_0280",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Emote = "PortraitEmoteFiredUp",
					Portrait = "Portrait_Poseidon_Displeased_01",
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
					Portrait = "Portrait_Poseidon_Displeased_01",
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
					Portrait = "Portrait_Poseidon_Displeased_01",
					Text = "Ladies first, is that the way of it, young Niece? I'm sure Queen Hera is most pleased with you, but I, for one, am not!" },
			},

		},

		RejectionVoiceLines =
		{
			[1] = { GlobalVoiceLines = "GodRejectedVoiceLines" },
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
					{
						Path = { "GameState", "TextLinesRecord" },
						CountOf =
						{
							"PoseidonMakeUp01",
							"PoseidonMakeUp02",
							"PoseidonMakeUp03",
							"PoseidonMakeUp04",
							"PoseidonMakeUp05",
							"PoseidonMakeUp06",
							"PoseidonMakeUp07",
							"PoseidonMakeUp08",
							"PoseidonMakeUp10",
							"PoseidonMakeUp11",
							"PoseidonMakeUp12",
						},
						Comparison = ">=",
						Value = 5,
					},
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0505", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I heard so much about you, Uncle, but you're not just very strong, you're generous as well. I am grateful, and would give you this." },
				{ Cue = "/VO/Poseidon_0066",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteSurprise",
					Text = "Oh, little Niece, how {#Emph}thoughtful{#Prev}, but {#Emph}deeply {#Prev}unnecessary! Yet now {#Emph}I'm {#Prev}feeling generous, so here! This one's for you!" },
			},
			PoseidonGift02 =
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
						PathTrue = { "GameState", "UseRecord", "PoseidonUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0504", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1764", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1765", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
			PoseidonGift05 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3724", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Poseidon! So many mortals know you as the Earth-Shaker, for the land and sea alike bend to your will. But I'm so deeply fortunate to know you as my uncle. I won't forget your kindness and spirit." },
				{ Cue = "/VO/Poseidon_0301",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "You needn't waste your Nectar on me, Niece! Not like I can drink it all the way from here. Perhaps that's just how it is with offerings! Mortals, they leave us strips of fresh-cooked meat, and things like that...! What was I on about?" },
			},
			PoseidonGift06 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3725", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I heard the tales of my father's brothers long before we met, Uncle. And you're as mighty and courageous as they say! But I also feel as though you have been looking out for me. Thank you for making me feel welcome and safe." },
				{ Cue = "/VO/Poseidon_0302",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Such a voyage we have had, haven't we, Niece? And you're not even in my same vicinity! Just how it is with relatives. They're with you even when they're not! Know that I'm with you, too, and always making certain that the coast is clear! At least after you find one of my Boons..." },
			},
			-- bond forged
			PoseidonGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_PoseidonGiftHint01",
				CompletedHintId = "Codex_BondForgedPoseidon",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "PoseidonUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "PoseidonGift06", "PoseidonAboutFishingQuest02" },
					},
				},
				{ Cue = "/VO/MelinoeField_3826", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Dear Uncle Poseidon, this offering of sweet Ambrosia is for you! My father must have been so fortunate to have grown up with such a big-hearted and caring brother. May all your seas and land soon know tranquility again!" },
				{ Cue = "/VO/Poseidon_0402",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Poseidon_01", Icon = "Keepsake_Poseidon" },

					Emote = "PortraitEmoteSurprise",
					Text = "However did you find such an extravagance amid our tempestuous times, Niece?! All I expected you to do is furiously fight but you have done much more! I move the earth itself; yet you move {#Emph}me." },
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
			UsePlayerSource = true,
			GameStateRequirements =
			{
				{
					PathTrue = { "CurrentRun", "CurrentRoom", "ReplacedTraitSource", },
				},
			},

		},

		FullSuperActivatedVoiceLines =
		{
			Queue = "Interrupt",
			{
				RandomRemaining = true,
				Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
								IsNone = { "PoseidonUpgrade" },
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

				{ Cue = "/VO/Poseidon_0384", Text = "The tide's come in!" },
				{ Cue = "/VO/Poseidon_0385", Text = "At once, my niece!" },
				{ Cue = "/VO/Poseidon_0386", Text = "You called, my niece?!" },
				{ Cue = "/VO/Poseidon_0387", Text = "Here's some water-power, Niece!" },
				{ Cue = "/VO/Poseidon_0388", Text = "Get ready to get {#Emph}wet!" },
				{ Cue = "/VO/Poseidon_0389", Text = "Here comes the {#Emph}wave!" },
				{ Cue = "/VO/Poseidon_0390", Text = "Your uncle's here, my niece!" },
				{ Cue = "/VO/Poseidon_0391", Text = "Let's clean up this mess!" },
			},
			{
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
						IsAny = { "PoseidonUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Poseidon_0393", Text = "Oh {#Emph}now {#Prev}you seek my aid?!", PlayFirst = true },
				{ Cue = "/VO/Poseidon_0392", Text = "Well I {#Emph}never!" },
				{ Cue = "/VO/Poseidon_0394", Text = "Whose side am I {#Emph}on?!" },
				{ Cue = "/VO/Poseidon_0395", Text = "How {#Emph}rude {#Prev}of you to ask!" },
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

				{ Cue = "/VO/Chronos_1257", Text = "That seafaring {#Emph}brat..." },
				{ Cue = "/VO/Chronos_1258", Text = "That water-loving {#Emph}scamp..." },
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

				{ Cue = "/VO/Zagreus_0356", Text = "Uncle Poseidon!" },
				{ Cue = "/VO/Zagreus_0357", Text = "Uncle, it's {#Emph}me!", PlayFirst = true },
			},
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
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
				Cooldowns =
				{
					{ Name = "BoonRarifiedSpeech", Time = 240 },
				},

				{ Cue = "/VO/Poseidon_0231", Text = "You got it!" },
				{ Cue = "/VO/Poseidon_0232", Text = "Oh, very well!", PlayFirst = true },
				{ Cue = "/VO/Poseidon_0233", Text = "Why, certainly!" },
				{ Cue = "/VO/Poseidon_0234", Text = "{#Emph}Ahh{#Prev}, why not!!" },
				{ Cue = "/VO/Poseidon_0235", Text = "{#Emph}Hahaha! {#Prev}Sure!" },
				{ Cue = "/VO/Poseidon_0236", Text = "All right...!" },
				{ Cue = "/VO/Poseidon_0229", Text = "Aye-aye!!" },
				{ Cue = "/VO/Poseidon_0230", Text = "{#Emph}Of course!" },
			},
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
			TriggerCooldowns = { "PoseidonBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

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
		Using = { "PoseidonEncounterStartBuffBack", },
	},	

}

OverwriteTableKeys( LootData, LootSetData.Poseidon )

-- Global Poseidon Lines
GlobalVoiceLines.PoseidonDoubleRewardReactionLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.25,
		Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
		GameStateRequirements =
		{
			--
		},
		{ Cue = "/VO/Poseidon_0202", Text = "{#Emph}Hahaha{#Prev}, yes!", PlayFirst = true },
		{ Cue = "/VO/Poseidon_0242", Text = "Yes, {#Emph}haha!", PlayFirst = true },
		{ Cue = "/VO/Poseidon_0343", Text = "Have {#Emph}another!" },
		{ Cue = "/VO/Poseidon_0344", Text = "How about {#Emph}two!" },
		{ Cue = "/VO/Poseidon_0345", Text = "And {#Emph}another!" },
		{ Cue = "/VO/Poseidon_0346", Text = "{#Emph}One {#Prev}more!" },
	},
}
GlobalVoiceLines.PoseidonRoomRewardBonusReactionLines =
{
	{
		BreakIfPlayed = true,
		RandomRemaining = true,
		PreLineWait = 0.15,
		Source = { LineHistoryName = "NPC_Poseidon_01", SubtitleColor = Color.PoseidonVoice },
		GameStateRequirements =
		{
			--
		},
		TriggerCooldowns = { "MelinoeAnyQuipSpeech" },

		{ Cue = "/VO/Poseidon_0347", Text = "My {#Emph}bounty!" },
		{ Cue = "/VO/Poseidon_0348", Text = "{#Emph}Behold!", PlayFirst = true },
		{ Cue = "/VO/Poseidon_0349", Text = "All for you!" },
		{ Cue = "/VO/Poseidon_0350", Text = "Treasure from the {#Emph}sea!" },
	},
}