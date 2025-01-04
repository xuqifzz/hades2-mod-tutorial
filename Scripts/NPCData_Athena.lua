UnitSetData.NPC_Athena =
{
	NPC_Athena_01 =
	{
		InheritFrom = { "NPC_Neutral", "NPC_Giftable" },
		
		OnUsedFunctionName = "AthenaUse",
		OnUsedFunctionArgs = { SkipInteractAnim = true, SkipSound = true, PackageName = "NPC_Athena_01" },
		
		RarityRollOrder = {"Common", "Rare", "Epic", "Heroic" },
		Portrait = "Portrait_Athena_Default_01",
		-- AnimOffsetZ = 0,
		Groups = { "NPCs" },
		SpeakerName = "Athena",
		SubtitleColor = Color.AthenaVoice,

		TreatAsGodLootByShops = true,
		RequiredRoomInteraction = true,
		SkipAISetupOnActivate = true,

		BlockFieldsEncounterStart = true,

		PreferredSpawnPoint = "EnemyPoint",
		LightingColor = {101, 101, 159, 255},
		ActivateRequirements =
		{
			-- None
		},

		SetupEvents =
		{
			{
				FunctionName = "GenericPresentation",
				Args = { CreateAnimation = "OlympusColdBreathEmitter", },
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
			},
		},

		InvincibubbleScale = 1.2,
		AlwaysShowInvulnerabubbleOnInvulnerableHit = true,
		TurnInPlaceAnimation = "Athena_Turn",

		BoxAnimation = "DialogueSpeechBubbleLight",
		BoxExitAnimation = "DialogueSpeechBubbleLightOut",
		NarrativeTextColor = Color.DialogueTextLight,
		-- NarrativeContextArt = "DialogueBackground_Olympus",
		NameplateSpeakerNameColor = Color.DialogueSpeakerNameOlympian,
		NameplateDescriptionColor = {145, 45, 90, 255},
		NarrativeContextArtFlippable = false,

		MenuTitle = "UpgradeChoiceMenu_Athena",
		SpawnSound = "/SFX/AthenaWrathHolyShield",
		UpgradeScreenOpenSound = "/SFX/AthenaWrathHolyShield",
		UpgradeSelectedSound = "/SFX/AthenaBoonChoice",
		PackageName = "NPC_Athena_01",
		Icon = "BoonSymbolAthenaIcon",

		Traits = { 
			"InvulnerabilityDashBoon", 
			"RetaliateInvulnerabilityBoon", 
			"FocusLastStandBoon", 
			"DeathDefianceRefillBoon", 
			"AthenaProjectileBoon",
			"InvulnerabilityCastBoon",
		},
		FlavorTextIds =
		{
			"AthenaUpgrade_FlavorText01",
			"AthenaUpgrade_FlavorText02",
			"AthenaUpgrade_FlavorText03",
		},

		UpgradeMenuOpenVoiceLines =
		{
			{
				BreakIfPlayed = true,
				PreLineWait = 0.75,
				UsePlayerSource = true,
				SkipAnim = true,
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "TextLinesRecord", "AthenaAboutArachne01" }
					}
				},

				{ Cue = "/VO/MelinoeField_2439", Text = "But..." },
			},
			{
				BreakIfPlayed = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.25,
				PreLineWait = 1.0,
				SkipAnim = true,
				Source = { LineHistoryName = "NPC_Athena_01", SubtitleColor = Color.AthenaVoice },
				AllowTalkOverTextLines = true,
				GameStateRequirements =
				{
					--
				},
			
				{ Cue = "/VO/Athena_0077", Text = "Behold my power." },
				{ Cue = "/VO/Athena_0078", Text = "Behold." },
				{ Cue = "/VO/Athena_0079", Text = "My Aegis is yours." },
				{ Cue = "/VO/Athena_0080", Text = "Now choose." },
				{ Cue = "/VO/Athena_0081", Text = "Your choice?" },
				{ Cue = "/VO/Athena_0082", Text = "What suits your strategy?" },
				{ Cue = "/VO/Athena_0083", Text = "How may I assist?" },
				{ Cue = "/VO/Athena_0084", Text = "What shall it be?" },
				{ Cue = "/VO/Athena_0085", Text = "Consider this." },
				{ Cue = "/VO/Athena_0086", Text = "My blessings." },
			},
			[2] = { GlobalVoiceLines = "FoundRareBoonVoiceLines" },
		},

		EncounterStartVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.85,

				{ Cue = "/VO/Athena_0036", Text = "The fury of Olympus!", PlayFirst = true },
				{ Cue = "/VO/Athena_0037", Text = "Deliverance!" },
				{ Cue = "/VO/Athena_0038", Text = "In the name of Zeus!" },
				{ Cue = "/VO/Athena_0039", Text = "In the name of Zeus...!" },
				{ Cue = "/VO/Athena_0040", Text = "For Olympus!" },
				{ Cue = "/VO/Athena_0041", Text = "Begone from here!" },
				{ Cue = "/VO/Athena_0042", Text = "Foolish mistake...!" },
				{ Cue = "/VO/Athena_0043", Text = "This one is mine!" },
				{ Cue = "/VO/Athena_0044", Text = "This is over!" },
				{ Cue = "/VO/Athena_0045", Text = "This is over!" },
				{ Cue = "/VO/Athena_0046", Text = "Olympus smite you!" },
				{ Cue = "/VO/Athena_0047", Text = "More of this rabble?" },
				{ Cue = "/VO/Athena_0048", Text = "That's quite enough!" },
				{ Cue = "/VO/Athena_0049", Text = "Hold fast, Cousin!" },
				{ Cue = "/VO/Athena_0050", Text = "Enough of this lot!" },
			},
		},
		EncounterEndVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 1.65,

				{ Cue = "/VO/Athena_0051", Text = "That's settled." },
				{ Cue = "/VO/Athena_0052", Text = "Well met!", PlayFirst = true },
				{ Cue = "/VO/Athena_0053", Text = "Hail." },
				{ Cue = "/VO/Athena_0054", Text = "Cousin." },
				{ Cue = "/VO/Athena_0055", Text = "Melinoë." },
				{ Cue = "/VO/Athena_0056", Text = "Welcome back." },
				{ Cue = "/VO/Athena_0057", Text = "There you are." },
				{ Cue = "/VO/Athena_0058", Text = "Are you all right?" },
				{ Cue = "/VO/Athena_0059", Text = "{#Emph}<Sigh>" },
				{ Cue = "/VO/Athena_0060", Text = "{#Emph}Hmph." },
				{ Cue = "/VO/Athena_0061", Text = "Well fought." },
				{ Cue = "/VO/Athena_0062", Text = "Short work." },
				{ Cue = "/VO/Athena_0063", Text = "Beg pardon." },
				{ Cue = "/VO/Athena_0064", Text = "Filthy creatures." },
				{ Cue = "/VO/Athena_0065", Text = "We need to talk." },
				{ Cue = "/VO/Athena_0066", Text = "At last." },
			},
			{
				UsePlayerSource = true,
				BreakIfPlayed = true,
				PlayOnce = true,
				PlayOnceContext = "AthenaFirstSummoningVO",
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AthenaEncounterKeepsake" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsNone = { "P" },
					},
				},
				{ Cue = "/VO/MelinoeField_2810", Text = "You're here!" },
			},
			{
				UsePlayerSource = true,
				RandomRemaining = true,
				SuccessiveChanceToPlay = 0.5,
				SuccessiveChanceToPlayAll = 0.33,
				PreLineWait = 0.35,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Athena_01" },
					},
				},

				{ Cue = "/VO/MelinoeField_2568", Text = "Lady Athena...!", PlayFirst = true, },
				{ Cue = "/VO/MelinoeField_2811", Text = "Lady Athena!" },
				{ Cue = "/VO/MelinoeField_2569", Text = "Excellent timing." },
				{ Cue = "/VO/MelinoeField_2808", Text = "It's her..." },
				{ Cue = "/VO/MelinoeField_2809", Text = "Sorry to bother you...",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AthenaEncounterKeepsake" },
						},
					},
				},
				{ Cue = "/VO/MelinoeField_2810", Text = "You're here!",
					GameStateRequirements =
					{
						{
							PathFalse = { "PrevRun", "SpeechRecord", "/VO/MelinoeField_2810" },
						},
						{
							Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
							IsNone = { "P" },
						},
					},
				},
			},

		},

		SpecialInteractFunctionName = "SpecialInteractSalute",
		SpecialInteractGameStateRequirements =
		{
			{
				PathTrue = { "GameState", "UseRecord", "NPC_Athena_01" },
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

				{ Cue = "/VO/MelinoeField_2572", Text = "You honor me, my lady." },
				{ Cue = "/VO/MelinoeField_2573", Text = "Glory to Olympus!", PlayFirst = true },
			},
			[2] = { GlobalVoiceLines = "SaluteVoiceLines" },
			[3] =
			{
				RandomRemaining = true,
				PreLineWait = 0.4,
				ObjectType = "NPC_Athena_01",
				PreLineAnim = "Athena_Salute",

				{ Cue = "/VO/Athena_0125", Text = "Salutations.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/MelinoeField_2572" },
						},
					},
				},
				{ Cue = "/VO/Athena_0126", Text = "Well met!",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1698", "/VO/Melinoe_1699", "/VO/MelinoeField_2572" },
						},
					},
				},
				{ Cue = "/VO/Athena_0127", Text = "Death, or worse.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1700" },
						},
					},
				},
				{ Cue = "/VO/Athena_0128", Text = "Proper guidance.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1701" },
						},
					},
				},
				{ Cue = "/VO/Athena_0129", Text = "I plot my own course.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1703" },
						},
					},
				},
				{ Cue = "/VO/Athena_0130", Text = "I give the guidance here.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1705" },
						},
					},
				},
				{ Cue = "/VO/Athena_0131", Text = "If you insist.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1709" },
						},
					},
				},
				{ Cue = "/VO/Athena_0132", Text = "And deliver our enemies.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705" },
						},
					},
				},
				{ Cue = "/VO/Athena_0133", Text = "We know the way.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/MelinoeField_2573" },
						},
					},
				},
				{ Cue = "/VO/Athena_0134", Text = "To victory.",
					GameStateRequirements =
					{
						{
							Path = { "LastLinePlayed" },
							IsAny = { "/VO/Melinoe_1704", "/VO/Melinoe_1705", "/VO/MelinoeField_2573" },
						},
					},
				},
			}
		},

		InteractTextLineSets =
		{
			AthenaFirstMeeting =
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

				{ Cue = "/VO/Athena_0002",
					-- PreLineAnim = "Athena_Salute",
					-- PreLineAnim = "Athena_Blessing",
					-- PreLineAnim = "Athena_Brooding",
					-- PreLineAnim = "Athena_Proud_Start",
					-- PostLineAnim = "Athena_Proud_End",
					PreLineAnim = "Athena_Proud_Start",
					Text = "The noble Princess of the Dead, at last! I am your cousin Athena, and proud to welcome you to Olympus. Yet I could be prouder, as this wasn't always such a miserable place." },
				{ Cue = "/VO/MelinoeField_2401", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Intense_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Hail, Lady Athena, and well met! Please call me Melinoë. Now where can I direct my wrath, that we may liberate your mountain stronghold and see its glory all restored?" },
				{ Cue = "/VO/Athena_0003",
					PreLineAnim = "Athena_Proud_End",
					Text = "Well met indeed, Melinoë. The wretched Titan's armies have infiltrated our most sacred grounds. On them, your wrath may be well-spent; especially as you rise toward the summit, where most of our family now takes refuge." },
				{ Cue = "/VO/MelinoeField_2402", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The Palace of Zeus. And what of you, why aren't the others out here fighting by your side?" },
				{ Cue = "/VO/Athena_0004",
					-- PreLineAnim = "Athena_Brooding",
					Text = "Because that is precisely what our strategy requires, for they aided your arrival, did they not? Now, let us go our separate ways, and may my blessing aid in your ascent." },
			},

			AthenaAboutPrometheus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},

				{ Cue = "/VO/Athena_0158",
					PreLineAnim = "Athena_Proud_Start",
					Text = "Beware ahead. The Titan Prometheus is able to elude me, knowing that I'm focused on his vanguard forces. But he'll have no choice but to confront you if you press on." },
				{ Cue = "/VO/MelinoeField_2403", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "He's the Titan of Foresight. He knows exactly what we're planning, doesn't he? And can retaliate accordingly." },
				{ Cue = "/VO/Athena_0159",
					PreLineAnim = "Athena_Proud_End",
					Text = "He knows what is to come to some extent, yes. But he can only see outcomes, not read minds. And just because he knows you're coming doesn't mean he can stop you." },
			},
			AthenaAboutPrometheus02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaAboutPrometheus01" }
					},
					{
						Path = { "GameState", "RoomsEntered", "P_Boss01", },
						Comparison = ">=",
						Value = 4,
					},
				},

				{ Cue = "/VO/MelinoeField_2405", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Have you confronted Prometheus before? You mentioned he's been able to elude you. Perhaps he knows he'd stand no chance against you if you fought." },
				{ Cue = "/VO/Athena_0162",
					Text = "I knew Prometheus prior to all this. I suppose our tendencies toward matters of the mind connected us. You know that he stole the gift of fire for mortalkind. Well... he also gave them reason, from me. Some of them, anyway." },
				{ Cue = "/VO/MelinoeField_2406", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I shudder to think what mortals must have been like before they had any reason. Although perhaps Prometheus ought to have kept some reason for himself." },
				{ Cue = "/VO/Athena_0163",
					PreLineAnim = "Athena_Brooding",
					Text = "Perhaps he thinks he did, or has as much as he requires. Unfortunately, reason tends to be in lesser abundance than most would dare to admit." },
			},

			AthenaAboutPrometheusL01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Boss01" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaAboutPrometheus01" },
					},
					{
						Path = { "GameState", "LastBossHealthBarRecord", "Prometheus" },
						Comparison = ">",
						Value = 0,
					},
				},

				{ Cue = "/VO/Athena_0160",
					Text = "Even if you're thwarted by the Titan Prometheus, it is a benefit to our war effort. For if he's having to confront you, then he's unable to cause his mayhem elsewhere." },
				{ Cue = "/VO/MelinoeField_2404", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "That is of little consolation to me, Lady Athena. This is not his first crime against Olympus and our family; thus his punishment is to be even more severe." },
				{ Cue = "/VO/Athena_0161",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Do not concern yourself with that. His prior punishment inspired this still-greater transgression, rather than remorse for his past deeds. For the moment, our strategy merely requires that he not stand in our way." },
			},

			AthenaAboutZeus01 =
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
						PathTrue = { "GameState", "TextLinesRecord", "AthenaGift01" }
					},
					-- @ update with additional requirements
				},

				{ Cue = "/VO/Athena_0166",
					Text = "You should know, my father your Lord Uncle Zeus is somewhat skeptical of your ability to turn the outcome of the war here in our favor. He believes we should be able to fend for ourselves; and I don't disagree." },
				{ Cue = "/VO/MelinoeField_2408", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lady Athena, are we supposed to stand united as a family or aren't we? This isn't the time to be prideful." },
				{ Cue = "/VO/Athena_0167",
					PreLineAnim = "Athena_Brooding",
					Text = "With that, I don't disagree either. Nevertheless, our family seems incapable of standing united for long. If we could... this war never would have started." },
			},
			AthenaAboutHera01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "UseRecord", "HeraUpgrade" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "HeraGift04", "AthenaGift03" },
					},
				},

				{ Cue = "/VO/Athena_0235",
					PreLineAnim = "Athena_Proud_Start",
					Text = "My Stepmother Queen Hera's favor isn't easily earned. You should know it's she who first desired your assistance here. You have more than her Boon, but her faith; fragile as it is." },
				{ Cue = "/VO/MelinoeField_2446", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "And I am grateful for it, but... do you happen to know why? I don't know what Her Majesty the Queen could have seen in me, especially since we'd never even met." },
				{ Cue = "/VO/Athena_0236",
					PreLineAnim = "Athena_Proud_End",
					Text = "Perhaps it's that you represent a different course of action than the one we'd previously decided on, which came directly from my father your Lord Uncle Zeus. None of us like to be wrong about anything, but... we like victory more." },
			},

			AthenaAboutDionysus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "P_Story01" },
					},
				},

				{ Cue = "/VO/Athena_0198",
					Text = "I must say, Cousin... I've not seen such unity from our family in some time. Almost everybody stands together now against our foes. Though Dionysus, probably he's lying somewhere in a stupor." },
				{ Cue = "/VO/MelinoeField_2431", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If Lord Dionysus hasn't taken up arms against the forces of Chronos, surely he has his reasons..." },
				{ Cue = "/VO/Athena_0199",
					PreLineAnim = "Athena_Brooding",
					Text = "Oh, he does. Why should he callus his hands, when he could laze about feasting? He's fortunate I've more important matters to consider than locating him." },
			},

			AthenaAboutAres01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "ErisAboutSurface01" }
					},
					-- @ update with additional requirements
				},

				{ Cue = "/VO/Athena_0200",
					Text = "My half-brother Ares must be having the time of his life, wherever he resides. He relishes a good protracted war... why would he work with us to put an end to it?" },
				{ Cue = "/VO/MelinoeField_2432", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Do you suspect betrayal? If Ares isn't here, and the war rages... perhaps he's stoking the conflict on the other side." },
				{ Cue = "/VO/Athena_0201",
					PreLineAnim = "Athena_Proud_Start",
					Text = "The thought has certainly occurred to me, except... our enemy is no more interested in a war that lasts forever than we are. Whereas Ares wants only for the war to perpetuate, not for a victor to emerge." },
				{ Cue = "/VO/MelinoeField_2433", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "You know who else wants that is Eris. She's mentioned Ares before. You don't suppose they're working together?" },
				{ Cue = "/VO/Athena_0202",
					PreLineAnim = "Athena_Proud_End",
					Text = "From what I know of Strife, she's not prone to alliances. Yet, I cannot rule out the possibility. She's been impeding you along your route... perhaps she'll let slip some detail." },
			},

			AthenaAboutHeracles01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "EncountersOccurredCache" },
						HasAny = { "HeraclesCombatN", "HeraclesCombatN2", "HeraclesCombatO", "HeraclesCombatO2", "HeraclesCombatP", "HeraclesCombatP2" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaGift01" }
					},
				},

				{ Cue = "/VO/Athena_0231",
					Text = "You have perhaps encountered mighty Heracles along your route. He has surpassing strength and capability, but do report to me any suspicious actions on his part." },
				{ Cue = "/VO/MelinoeField_2445", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I have encountered him, and seen him lay to waste droves of our foes, though he's not been keen on conversation. Which sorts of suspicious actions do you mean?" },
				{ Cue = "/VO/Athena_0232",
					Text = "Consorting with our foes, defying our will, anything of that sort. I have no real reason not to trust him, yet... I've come to trust you more." },
			},

			AthenaAboutSelene01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "WeaponsFiredRecord" },
						HasAny = {
						 	"WeaponSpellLaser",
						 	"WeaponSpellPolymorph",
						 	"WeaponSpellSummon", 
						 	"WeaponSpellTimeSlow",
						 	"WeaponSpellPotion",
						 	"WeaponSpellMeteor",
						 	"WeaponSpellTransform",
						 	"WeaponSpellLeap",
						},
					},
				},

				{ Cue = "/VO/Athena_0207",
					PreLineAnim = "Athena_Proud_Start",
					Text = "The Moon herself assists you, that I know. We often underestimate her here, believing all she does is faintly light the sky. But I know there is more to her than that." },
				{ Cue = "/VO/MelinoeField_2436", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Selene may be a Titaness but she's an ally to us through and through. She upholds Night's will, as do I." },
				{ Cue = "/VO/Athena_0208",
					PreLineAnim = "Athena_Proud_End",
					Text = "Nyx's will is none of my concern, Cousin. But apparently it's yours, and Nyx has likewise been an ally to Olympus in the past. If you trust Selene's involvement, that is enough." },
			},

			-- alt below
			AthenaAboutCirce01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "AthenaAboutCirce01_B" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceEnlargeTrait" },
					},
				},

				{ Cue = "/VO/Athena_0215",
					PreLineAnim = "Athena_Brooding",
					Text = "There's some strange spell at work on you, for you seem different than before. Much... more substantial. Whether a blessing or a curse, I can't immediately say." },
				{ Cue = "/VO/MelinoeField_2442", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's a blessing, or at least I think it is. The craft of Madame Circe the Enchantress, whom I encountered on my voyage here." },
				{ Cue = "/VO/Athena_0217",
					Text = "Oh, her I do recall. She once created quite the predicament for a mortal seafarer whom I intended to protect, no one I think you'd know. I'd watch myself with her." },
			},
			AthenaAboutCirce01_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathFalse = { "GameState", "TextLinesRecord", "AthenaAboutCirce01" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceShrinkTrait" },
					},
				},

				{ Cue = "/VO/Athena_0216",
					PreLineAnim = "Athena_Brooding",
					Text = "There's some strange spell at work on you, for you seem different than before. Have you... shrunk down, Cousin? Whether a blessing or a curse, I can't immediately say." },
				{ Cue = "/VO/MelinoeField_2442", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's a blessing, or at least I think it is. The craft of Madame Circe the Enchantress, whom I encountered on my voyage here." },
				{ Cue = "/VO/Athena_0217",
					Text = "Oh, her I do recall. She once created quite the predicament for a mortal seafarer whom I intended to protect, no one I think you'd know. I'd watch myself with her." },
			},
			-- identical alt w/ different requirements below
			AthenaAboutCirce02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaAboutCirce01" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "AthenaAboutCirce02_B" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceShrinkTrait" },
					},
				},

				{ Cue = "/VO/Athena_0218",
					Text = "You appear different than before. Another one of the enchantress Circe's unconventional blessings, then. Are you certain that she's aiding you, not... ridiculing you?" },
				{ Cue = "/VO/MelinoeField_2443", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe would never use her transformation magick for ridicule. This is a powerful incantation... merely with certain side effects." },
				{ Cue = "/VO/Athena_0219",
					Text = "Never use her magick for ridicule? That doesn't sound much like the Circe I recall. Perhaps she's learned to behave herself, though I am not convinced..." },
			},
			AthenaAboutCirce02_B =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaAboutCirce01_B" },
					},
					{
						PathFalse = { "GameState", "TextLinesRecord", "AthenaAboutCirce02" },
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "CirceEnlargeTrait" },
					},
				},

				{ Cue = "/VO/Athena_0218",
					Text = "You appear different than before. Another one of the enchantress Circe's unconventional blessings, then. Are you certain that she's aiding you, not... ridiculing you?" },
				{ Cue = "/VO/MelinoeField_2443", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Madame Circe would never use her transformation magick for ridicule. This is a powerful incantation... merely with certain side effects." },
				{ Cue = "/VO/Athena_0219",
					Text = "Never use her magick for ridicule? That doesn't sound much like the Circe I recall. Perhaps she's learned to behave herself, though I am not convinced..." },
			},

			AthenaAboutArachne01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					-- @ update with additional requirements
					-- it is not yet your time, little spider
					{
						PathTrue = { "GameState", "TextLinesRecord", "ArachneAboutCurse02" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ArachneGift06", "AthenaGift04", "ArachneAboutCurse02" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				{ Cue = "/VO/MelinoeField_2437", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lady Athena, by your leave... we have a mutual acquaintance I would ask about, because... well... do you recall the weaver Arachne?" },
				{ Cue = "/VO/Athena_0209",
					PreLineAnim = "Athena_Proud_Start",
					Text = "I seldom forget anything, Cousin. Especially not insolent mortals who see themselves as equals to the gods. Though she is not exactly mortal anymore. What of her?" },
				{ Cue = "/VO/MelinoeField_2438", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Well... she lives down in Erebus now, near where I reside, and... she's so wretched about her appearance, which I understand is from a curse you wrought... doubtless entirely deserved, but... have mercy on her, Lady Athena. Please." },
				{ Cue = "/VO/Athena_0210",
					PreLineAnim = "Athena_Proud_End",
					Text = "So many mortals grovel to me all the time. But goddesses? And on behalf of mortals far too prideful to grovel for themselves? Cousin, do not waste my time with this." },
			},
			AthenaAboutArachne02 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaAboutArachne01" },
					},
				},

				{ Cue = "/VO/Athena_0211",
					Text = "The mortal woman called Arachne. Have you any idea what she did? She fancied herself the greatest weaver in the world; superior even to me, if not the Fates themselves. Is it not our obligation, then, to remind mortals of their place?" },
				{ Cue = "/VO/MelinoeField_2440", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Vulnerable_01",
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "I... can't say I rightly know the answer to that, Lady Athena. Nor would I ever question your decision about her! I only ask if the term of her punishment could be less than eternal. She's humbled, and she's learned from her mistakes." },
				{ Cue = "/VO/Athena_0212",
					PreLineWait = 0.35,
					Text = "Has she, now? In my experience mortals can be {#Emph}very {#Prev}slow to learn. And she was not punished as a lesson to {#Emph}her{#Prev}, but as a lesson to {#Emph}everyone else. {#Prev}I do not go back on my decisions, Melinoë. For I don't make them lightly." },
			},

			AthenaAboutMortals01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaAboutArachne02" },
					},
				},
				{ Cue = "/VO/Athena_0213",
					Text = "You got me thinking about mortalkind of late. I, too, have taken a personal interest in mortals and their plights. Many times. Especially in those who rise above their station. And I wish to honor their worship of the other gods and me." },
				{ Cue = "/VO/MelinoeField_2441", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelTalkPensive01ReturnToIdle", PostLineAnimTarget = "Hero",
					Text = "Yet you said before that it's our obligation to remind them of their place... that they are ultimately powerless against us." },
				{ Cue = "/VO/Athena_0214",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Yes, for they outnumber us greatly, and many grow resourceful and independent. Some do not think they need us, but they do. Both in life and in death, as your father would attest. Best not become {#Emph}too {#Prev}attached to any of them." },
			},

			AthenaAboutOlympians01 =
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
						Path = { "GameState", "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 5,
					},
					{
						Path = { "GameState", "UseRecord", "NPC_Athena_01" },
						Comparison = ">=",
						Value = 4,
					},
					-- @ update with additional requirements
				},

				{ Cue = "/VO/MelinoeField_2414", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It almost looks as though you're having to contend with the invaders on your own, Lady Athena. There's a lot of mountain to cover, with too few allies..." },
				{ Cue = "/VO/Athena_0178",
					PreLineAnim = "Athena_Proud_Start",
					Text = "Well, we have {#Emph}you{#Prev}, Cousin. As for our {#Emph}other {#Prev}allies... we as a family are loath to beg assistance, or for anything. To all our followers and compatriots, our message has been clear: We have this matter well under control." },
				{ Cue = "/VO/MelinoeField_2415", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Is that the truth of it, or merely posturing, if you'll pardon my bluntness? You are clearly being overrun." },
				{ Cue = "/VO/Athena_0179",
					PreLineAnim = "Athena_Proud_End",
					Text = "On the contrary, our Automatons have quite effectively held many of our enemies at bay. And you and I can make a significant difference as well, if we don't dally." },
			},

			AthenaAboutChronosBossW01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
				},

				{ Cue = "/VO/Athena_0164",
					PreLineAnim = "Athena_Proud_Start",
					Text = "Cousin, is it true that you reached the heart of your father's Underworld and vanquished the Titan Chronos there? His forces unexpectedly fell back, and I dared not trust my intuition as to why." },
				{ Cue = "/VO/MelinoeField_2407", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I did prevail against him recently, yes. One night we shall dispose of him entirely, but for now, small victories shall have to suffice." },
				{ Cue = "/VO/Athena_0165",
					PreLineAnim = "Athena_Proud_End",
					Text = "Imperative victories are not small victories. Yet I fully understand the impulse never to grow complacent, and always to fight on." },
			},

			AthenaAboutTalos01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "RoomsEntered", "P_MiniBoss01" },
					},
				},

				{ Cue = "/VO/Athena_0170",
					Text = "I must apologize about your confrontation with the particularly large and dangerous Automaton called Talos. It detects traces of the Underworld on you, and, well..." },
				{ Cue = "/VO/MelinoeField_2410", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It's a magnificent creation, and Lord Hephaestus should be proud... though, the methods by which his Automatons detect threats could probably use a comprehensive rework." },
				{ Cue = "/VO/Athena_0171",
					PreLineAnim = "Athena_Brooding",
					Text = "I shall be certain to relay the suggestion. Unfortunately Lord Hephaestus prioritized a self-repairing system in Talos over threat-detection, so it may continue to be an issue for now." },
			},

			AthenaAboutAutomatons01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "Spawns" },
						HasAny = { "SentryBot", "SentryBot_Elite", "AutomatonBeamer", "AutomatonBeamer_Elite", "AutomatonEnforcer", "AutomatonEnforcer_Elite" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},

				{ Cue = "/VO/Athena_0168",
					Text = "I'm yet to be convinced that these Automatons we use in our defense are as dependable as can be. I've told Hephaestus I won't tolerate their quirks; nor should you." },
				{ Cue = "/VO/MelinoeField_2409", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "They are remarkable, but seem unable to fully distinguish your allies from your enemies. Perhaps Hephaestus can make improvements to their design." },
				{ Cue = "/VO/Athena_0169",
					PreLineAnim = "Athena_Brooding",
					Text = "Yes, that's on a long list of requests we have for him. We'll have to decommission and repurpose any existing models for that effort anyhow... so if you destroy some here and there, it's for the best." },
			},

			AthenaAboutZagreus01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					-- @ update with additional requirements
				},

				{ Cue = "/VO/Athena_0185",
					Text = "How strange it is to meet you face-to-face. Your brother Zagreus I spoke to many times, though by Boon all but once. You must know he had his struggles at home. Now it seems your side of the family is repaying us for back then." },
				{ Cue = "/VO/MelinoeField_2424", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If there's a debt to be repaid then I am unaware, Lady Athena. I'm here because our family is in peril, my side and yours." },
				{ Cue = "/VO/Athena_0186",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Of course, and it wasn't my intent to suggest otherwise. I'm merely reflecting on the change of circumstance. Well then, one Boon deserves another." },
			},

			AthenaAboutPersephone01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					-- @ update with additional requirements
					{
						-- PathTrue = { "GameState", "TextLinesRecord", "AthenaGift01" }
					},
				},

				{ Cue = "/VO/Athena_0187",
					Text = "After we settled certain troubles with your brother's situation at home, your mother Persephone, she would regularly return to Olympus for part of each year. I should have trusted my instincts when one day she failed to show..." },
				{ Cue = "/VO/MelinoeField_2425", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Presumably when Chronos struck. Wouldn't her sudden disappearance have been cause for considerable alarm?" },
				{ Cue = "/VO/Athena_0188",
					Text = "You'd think. However, we knew your mother was with child, and our conclusion was that your new family wanted privacy. So we waited patiently, not realizing it as Chronos gained his foothold. A grave miscalculation on my part..." },
				{ Cue = "/VO/MelinoeField_2426", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Your father and mine first fought and vanquished Chronos long before either of us was born. You couldn't have expected the Titan Lord to suddenly return." },
				{ Cue = "/VO/Athena_0189",
					Text = "Yet if I'm to be the strategist upon Olympus then I have to consider each possibility, however unlikely, that can threaten our peace. At any rate, a lesson harshly learned..." },
			},

			AthenaAboutHecate01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					-- @ update with additional requirements
				},

				{ Cue = "/VO/Athena_0192",
					Text = "So Artemis discovered you within the mists of Erebus, under the tutelage of Hecate? Quite the tale. Would you care to elaborate?" },
				{ Cue = "/VO/MelinoeField_2428", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "All I can say is Headmistress Hecate was under strict orders never to reveal me to anyone outside her inner circle. Not until our opportunity to strike at Chronos presented itself." },
				{ Cue = "/VO/Athena_0193",
					Text = "Very well. I was never under the delusion that our side of the family and yours kept no secrets from each other. Likely it's for the best. But, my position does require a certain thoroughness and curiosity, you understand." },
			},

			AthenaAboutFates01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" }
					},
				},

				{ Cue = "/VO/Athena_0190",
					Text = "The Three Fates themselves are gone, Hermes has said. Our situation grows that much more desperate, then. And yet... I never could depend on outside influence in my success; I trust you take no offense." },
				{ Cue = "/VO/MelinoeField_2427", UsePlayerSource = true,
					PreLineAnim = "MelTalkBrooding01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "No, I understand what you mean. Chronos feared some sort of Fated prophecy would do him in again, like when our fathers overthrew his rule. But if the Fates no longer are setting the course of what transpires... then we shall." },
				{ Cue = "/VO/Athena_0191",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "We shall. For the goal of any strategy is to leave as little as possible to chance. We count only on those who prove themselves dependable, and above all, ourselves." },
			},

			AthenaAboutCurse01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
					-- @ update with additional requirements
				},

				{ Cue = "/VO/Athena_0196",
					Text = "My understanding was that your brother suffered from a certain ailment that inhibited his vitality if ever he attempted to venture out of the Underworld. Yet you apparently have no such limitation?" },
				{ Cue = "/VO/MelinoeField_2430", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I merely found the means to slow the effect, but I can feel it encroaching even now. If our foes aren't able to drive me to retreat, my ailment eventually shall." },
				{ Cue = "/VO/Athena_0197",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "What can I say? You hide your troubles well, Melinoë. So yours is a race against time in more ways than one. I won't delay you any further then." },
			},

			AthenaAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "AthenaEncounterKeepsake" },
					},
				},

				{ Cue = "/VO/Athena_0203",
					Text = "You bear the Amulet I gave to you. May it protect you and strike fear into the hearts of your enemies, whenever I am not around to do the same." },
				{ Cue = "/VO/MelinoeField_2434", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Thank you, Lady Athena. The creature engraved on this... it's a Gorgon, isn't it? A guardian of some sort?" },
				{ Cue = "/VO/Athena_0204",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Oh, not exactly, no. More of a cautionary reminder about what happens when we gods are openly defied. Don't lose your head out there, Cousin." },
			},

			AthenaAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 16,
					},
				},

				{ Cue = "/VO/Athena_0205",
					Text = "This night is darker than so many others of late, and our foes appear emboldened. Some new trick of Chronos, or... perhaps merely my imagination from fighting for so long." },
				{ Cue = "/VO/MelinoeField_2435", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It isn't your imagination but the will of Night herself, Lady Athena. And though the effect may seem to our detriment for now, we shall grow stronger for it, I assure you." },
				{ Cue = "/VO/Athena_0206",
					Text = "Such assurances mean little to me typically, Cousin. But you know more about the darkness than do I. If this truly is the will of Night and not the work of our enemy, then good." },
			},

			AthenaAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
					-- @ update with additional requirements
				},

				{ Cue = "/VO/Athena_0172",
					Text = "Have you felt the growing tremors during your approach, Cousin? I don't care for them at all. Lord Uncle Poseidon at first acted as though they were his doing, but not even he seems to know the source..." },
				{ Cue = "/VO/MelinoeField_2411", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "In the Underworld, we experience tremors all the time, for the Earth is all around us, living and breathing. But I'm surprised such shaking could be felt all the way up here..." },
				{ Cue = "/VO/Athena_0173",
					Text = "Living and breathing, you say.... Our enemy is behind this, I am certain of it." },
			},

			AthenaAboutWeapons01 =
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

				{ Cue = "/VO/Athena_0220",
					Text = "You bear the Arms of Night. I suspected it when we first met but now my doubt is gone. Should the Underworld be imperiled, those weapons are to be the last resort, fine. But they seem well outside their jurisdiction here." },
				{ Cue = "/VO/MelinoeField_2444", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "The peril that the Underworld faces evidently spread even to this mountain. For my part, the Nocturnal Arms have proven equally dependable above the surface and below." },
				{ Cue = "/VO/Athena_0221",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Make certain that you keep their power well in check, as well as their hunger. I much prefer my weapons not to have intentions of their own, but can't deny their potency." },
			},

			AthenaAboutTimePassing01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						SumPrevRuns = 6,
						Path = { "SpawnRecord", "NPC_Athena_01" },
						Comparison = "<=",
						Value = 0,
					},
				},

				{ Cue = "/VO/Athena_0174",
					Text = "You are a welcome sight, Melinoë, for it has been some nights since last we met upon the battlefield like this. How fares the war beneath the Earth?" },
				{ Cue = "/VO/MelinoeField_2412", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "It rages on. Night after night the Titan's legions regroup, while he asserts that he cannot be stopped. But I am working on disproving that. And what news here?" },
				{ Cue = "/VO/Athena_0175",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "The mountain stands, as you can see, and that is what matters. Perhaps your presence and a corresponding shift in strategy shall lead us to the breakthrough that we need." },
			},


			AthenaAboutHobbies01 =
			{
				PlayOnce = true,
				UseableOffSource = true,
				PreEventFunctionName = "AngleNPCToHero",
				GameStateRequirements =
				{
					-- @ update with additional requirements
					-- @ require for Arachne
					{
						PathTrue = { "GameState", "TextLinesRecord", "AthenaGift03" }
					},
				},

				{ Cue = "/VO/Athena_0194",
					Text = "All of this warfare leaves us time for little else. I used to weave, you know! Great tapestries and more. May I have opportunity to take it up again once all this is behind us. And you, what else has occupied your time?" },
				{ Cue = "/VO/MelinoeField_2429", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I, well... I like to spar! Improving my acuity and strength. And practicing my craft. Matters of magick, the living, and the dead. How they're connected." },
				{ Cue = "/VO/Athena_0195",
					PreLineAnim = "Athena_Brooding",
					Text = "I'm familiar with witchcraft, yes. Though, that all sounds like preparation for the matter you're now seeking to resolve! But I do realize it's not the time for flights of fancy, or even the discussion thereof." },
			},

			AthenaLowHealth01 =
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
						Path = { "CurrentRun", "Hero", "LastStands", },
						UseLength = true,
						Comparison = "<=",
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.4, },
					},
				},

				{ Cue = "/VO/Athena_0176",
					Text = "You're injured, Cousin... though I shouldn't be so surprised. It is a grueling climb to reach this point, and you traversed the Rift of Thessaly as well. Are you all right?" },
				{ Cue = "/VO/MelinoeField_2413", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "I can press on in this state, Lady Athena. Though whether I've the strength to surpass Prometheus, let alone what awaits beyond... that I can't guarantee." },
				{ Cue = "/VO/Athena_0177",
					Text = "In war there are no guarantees save bloodshed, as Ares surely would attest, wherever he may be rejoicing. Now let's get you back to proper fighting shape." },
			},

			-- Repeatable
			AthenaChat01 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0006",
					Text = "I shall ensure this area remains secure for now; make your advance!" },
			},
			AthenaChat02 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0007",
					Text = "Continue your ascent, as I shall keep what passes for the Titan's armies occupied." },
			},
			AthenaChat03 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I", "N", "O", "P" },
					},
				},
				{ Cue = "/VO/Athena_0008",
					Text = "They never seem to learn, do they? But neither do they ever seem to stop." },
			},
			AthenaChat04 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P" },
					},
				},
				{ Cue = "/VO/Athena_0009",
					Text = "I trust that our defenses have not proven too much of a hindrance to you here." },
			},
			AthenaChat05 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0010",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "When our family stands united, there's no hardship that we cannot overcome." },
			},
			AthenaChat06 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				{ Cue = "/VO/Athena_0011",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "I've wrath to spare for all those you shall confront on your way to the summit." },
			},
			AthenaChat07 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				{ Cue = "/VO/Athena_0012",
					Text = "Make haste toward the Palace, Cousin, and my blessing be with you." },
			},
			AthenaChat08 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0013",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Another victory is within reach; go take it, and I'll cover you as you proceed." },
			},
			AthenaChat09 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0014",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Battle rages all around us still, Melinoë. Then let us finish what our enemies began." },
			},
			AthenaChat10 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0015",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "This mountain stronghold of ours shall never fall, try as the Titan might." },
			},
			AthenaChat11 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0016",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Climb forth, Cousin, and may your foothold never falter on the way." },
			},
			AthenaChat12 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				{ Cue = "/VO/Athena_0017",
					Text = "Go quickly but with care; my father and the rest await you at the summit." },
			},
			AthenaChat13 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0018",
					Text = "I'm grateful that you're back, so that the next stage of our plan can now unfold." },
			},
			AthenaChat14 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0019",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "You're all the reinforcements we require, and I'm ever-grateful that you're here." },
			},
			AthenaChat15 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0020",
					Text = "Would that we could fight together, yet we accomplish more going our separate ways." },
			},
			AthenaChat16 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0021",
					Text = "Our foes swarm at us like insects, and we shall deal with them as such." },
			},
			AthenaChat17 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0022",
					Text = "I knew that I could count on you to be here tonight precisely at this time." },
			},
			AthenaChat18 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0023",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Many such victories are still to come before our war is finally ended." },
			},
			AthenaChat19 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0024",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "It is not enough merely to vanquish our enemies; let us make an example of them." },
			},
			AthenaChat20 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0025",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "The peak of Olympus awaits; go, and I'll ensure you need not watch your back." },
			},
			AthenaChat21 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				{ Cue = "/VO/Athena_0026",
					Text = "I know you've scores to settle in the Underworld, so thank you for being here." },
			},
			AthenaChat22 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "BiomesReached" },
						HasAny = { "I", "P" },
					},
				},
				{ Cue = "/VO/Athena_0027",
					Text = "Your skill alone has brought you to this point, although perhaps I may assist." },
			},
			AthenaChat23 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0028",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Let our enemies rue the moment they deigned to stand against we gods." },
			},
			AthenaChat24 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "GameState", "GamePhase", },
						Comparison = "~=",
						Value = 5,
					},
				},
				{ Cue = "/VO/Athena_0029",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "It is as though the Moon herself directed me to your position here tonight." },
			},
			AthenaChat25 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0030",
					Text = "Our family has endured for aeons; this shall pass, as does all else." },
			},
			AthenaChat26 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0031",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "All those who dare oppose us or our rightful rule shall be given no quarter." },
			},
			AthenaChat27 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				{ Cue = "/VO/Athena_0032",
					Text = "Proceed immediately to the Palace and I'll cover you, Melinoë." },
			},
			AthenaChat28 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0033",
					Text = "What use is a good strategy without the necessary skill to see it through?" },
			},
			AthenaChat29 =
			{
				UseableOffSource = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "I", "O", "P" },
					},
				},
				{ Cue = "/VO/Athena_0034",
					Text = "The Titan's forces know nothing of fear, but I trust that they can still be taught." },
			},
			AthenaChat30 =
			{
				UseableOffSource = true,
				{ Cue = "/VO/Athena_0035",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "May the Boon I now bestow provide a difference in the battles yet to come." },
			},

		},

		GiftTextLineSets =
		{
			AthenaGift01 =
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
						PathTrue = { "GameState", "UseRecord", "NPC_Athena_01" },
					},
				},
				{ Cue = "/VO/MelinoeField_2416", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "Lady Athena, while we have a moment, I wish to offer you this Nectar as a token of my gratitude. If I'd only known that we would meet here, perhaps I'd have arrived even sooner." },
				{ Cue = "/VO/Athena_0180",
					PreLineAnim = "Athena_Proud_Start",
					PostLineAnim = "Athena_Proud_End",
					Text = "Nonsense, for I'm certain that you made your journey here as quickly as you could. Well, I of course accept your offering, though shall be saving it for when our victory's achieved. This, however, you may be able to use sooner..." },

			},
			AthenaGift02 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "AthenaGift01" },
					},
				},
				{ Cue = "/VO/Athena_0181",
					Text = "{#Emph}Huh. {#Prev}Try as I might to consider each possibility, partaking of Nectar in the midst of this conflict that we're in is quite unthinkable. Still, it's something to look forward to." },
				{ Cue = "/VO/MelinoeField_2418", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If it's something to look forward to, then it's a greater gift than I thought. The idea of a sip of Nectar while at peace... it does sound good." },
			},
			AthenaGift03 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "AthenaGift02" },
					},
				},
				{ Cue = "/VO/Athena_0182",
					PreLineAnim = "Athena_Brooding",
					Text = "Your gesture is unnecessary. Warring mortals often make me offerings in hopes that I might guide them to victory. But you and I have a shared purpose, so I require no such incentives in our case." },
				{ Cue = "/VO/MelinoeField_2419", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "This is no incentive, merely a way of saying thank you. For accepting me, and recognizing what potential I may have to aid our family in a time of need." },
			},
			AthenaGift04 =
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
						-- PathTrue = { "GameState", "TextLinesRecord", "AthenaGift03" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "P" },
					},
				},
				{ Cue = "/VO/Athena_0183",
					Text = "You honor me, and have my thanks. This Nectar, it's been to the Underworld and back... along with you. It'll take on a particularly complex flavor, I should think." },
				{ Cue = "/VO/MelinoeField_2420", UsePlayerSource = true,
					PreLineAnim = "MelTalkPensive01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					Text = "If this bottle indeed traveled to the ends of the earth before returning home, then it's all the more suited to someone of your wisdom and experience. May you enjoy it once you lay down your arms." },
			},

			-- placeholder
			AthenaGiftTemp =
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

			{ Cue = "/VO/MelinoeField_2417", Text = "You honor me with such a gift, Goddess." },
		},

		RepulseOnMeleeInvulnerableHit = 150,
		OnHitVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			ChanceToPlay = 0.5,
			PreLineWait = 0.25,
			ObjectType = "NPC_Athena_01",
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
				{ Name = "AthenaHitSpeechPlayedRecently", Time = 10 },
			},
			TriggerCooldowns = { Name = "AthenaSpokeRecently" },

			{ Cue = "/VO/Athena_0067", Text = "Conserve your strength.", PlayFirst = true },
			{ Cue = "/VO/Athena_0068", Text = "I'll not spar here." },
			{ Cue = "/VO/Athena_0069", Text = "I haven't the time." },
			{ Cue = "/VO/Athena_0070", Text = "Stand down." },
			{ Cue = "/VO/Athena_0071", Text = "How humorous." },
			{ Cue = "/VO/Athena_0072", Text = "Steady, Cousin." },
			{ Cue = "/VO/Athena_0073", Text = "Yes?" },
			{ Cue = "/VO/Athena_0074", Text = "When you're ready..." },
			{ Cue = "/VO/Athena_0075", Text = "Come now." },
			{ Cue = "/VO/Athena_0076", Text = "The Underworld idea of a jest?" },
		},

		ExitVoiceLines =
		{
			{
				RandomRemaining = true,
				PreLineWait = 0.25,
				SuccessiveChanceToPlayAll = 0.8,
				ObjectType = "NPC_Athena_01",

				{ Cue = "/VO/Athena_0103", Text = "Let us be off." },
				{ Cue = "/VO/Athena_0104", Text = "Fight on, Cousin!" },
				{ Cue = "/VO/Athena_0105", Text = "To the next battle." },
				{ Cue = "/VO/Athena_0106", Text = "Onward, then!" },
				{ Cue = "/VO/Athena_0107", Text = "To greater victory." },
				{ Cue = "/VO/Athena_0108", Text = "Now farewell." },
				{ Cue = "/VO/Athena_0109", Text = "Back into the fray.", PlayFirst = true },
				{ Cue = "/VO/Athena_0110", Text = "The enemy awaits." },
				{ Cue = "/VO/Athena_0111", Text = "Our family's counting on us." },
				{ Cue = "/VO/Athena_0112", Text = "No mercy out there." },
				{ Cue = "/VO/Athena_0113", Text = "Beware out there." },
				{ Cue = "/VO/Athena_0114", Text = "Now I must go." },
				{ Cue = "/VO/Athena_0117", Text = "May you again prevail." },
				{ Cue = "/VO/Athena_0118", Text = "To your continued success." },
				{ Cue = "/VO/Athena_0115", Text = "Prometheus awaits.",
					GameStateRequirements =
					{
						{
							PathTrue = { "CurrentRun", "BiomesReached", "P" },
						},
						{
							PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
						},
					},
				},

			},
		},

	},

}

OverwriteTableKeys( EnemyData, UnitSetData.NPC_Athena )