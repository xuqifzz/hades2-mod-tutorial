LootSetData.Apollo =
{
	-- Apollo
	ApolloUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },
		
		OffersElementalTrait = {"Fire", "Water" },
		GameStateRequirements =
		{
			--
		},		
		UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
		CanReceiveGift = true,
		AlwaysShowDefaultUseText = true,
		GodLoot = true,
		Weight = 10,
		SurfaceShopIcon = "BoonInfoSymbolApolloIcon",
		BoonInfoIcon = "BoonInfoSymbolApolloIcon",
		MenuTitle = "UpgradeChoiceMenu_Title_ApolloUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_ApolloUpgrade",
		LootRejectedText = "Player_GodDispleased_ApolloUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_ApolloUpgrade",
		Icon = "BoonSymbolApollo",
		DoorIcon = "BoonDropApolloPreview",
		DoorUpgradedIcon = "BoonDropApolloUpgradedPreview",
		SurfaceShopText = "ApolloUpgrade_Store",
		Color = { 250, 250, 215, 255 },
		LightingColor = {1.0, 0.91, 0.54, 1.0},
		LootColor = {255, 128, 32, 255},
		SubtitleColor = Color.ApolloVoice,
		ColorGrade = "ZeusLightning",
		LootRejectionAnimation = "BoonDissipateA_Zeus",
		SpawnSound = "/SFX/ApolloBoonHarpPoof",
		PortraitEnterSound = "/SFX/ApolloBoonHarpPoof",
		UpgradeSelectedSound = "/SFX/ApolloBoonChoice",

		PriorityUpgrades = { "ApolloWeaponBoon", "ApolloSpecialBoon", "ApolloCastBoon", "ApolloSprintBoon", "ApolloManaBoon" },
		WeaponUpgrades =
		{
			"ApolloWeaponBoon",
			"ApolloSpecialBoon",
			"ApolloCastBoon",
			"ApolloSprintBoon",
			"ApolloManaBoon",
		},
		Traits =
		{
			"ApolloRetaliateBoon",
			"PerfectDamageBonusBoon",
			"BlindChanceBoon",
			"ApolloBlindBoon",
			"ApolloMissStrikeBoon",
			"ApolloCastAreaBoon",
			"DoubleStrikeChanceBoon",

			-- Legendary
			"DoubleExManaBoon",
			
			-- Elemental			
			"ElementalRallyBoon",
			
			-- Duos
			"ApolloSecondStageCastBoon",
			"RaiseDeadBoon",
			"PoseidonSplashSprintBoon",
			"CastRampBoon",
			"ManaBurstCountBoon",
			"CoverRegenerationBoon",
			"MassiveAoEIncrease",
		},
		Consumables = { },

		SpeakerName = "Apollo",
		Speaker = "NPC_Apollo_01",
		Portrait = "Portrait_Apollo_Default_01",
		WrathPortrait = "Portrait_Apollo_Wrath_01",
		OverlayAnim = "ApolloOverlay",
		Gender = "Male",
		FlavorTextIds =
		{
			"ApolloUpgrade_FlavorText01",
			"ApolloUpgrade_FlavorText02",
			"ApolloUpgrade_FlavorText03",
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
			{ Cue = "/VO/Melinoe_0168", Text = "It's him..." },
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

			{ Cue = "/VO/Melinoe_0228", Text = "That light..." },
			{ Cue = "/VO/Melinoe_0229", Text = "He's here..." },
			{ Cue = "/VO/Melinoe_1470", Text = "Cousin..." },
			{ Cue = "/VO/Melinoe_1471", Text = "Apollo...", PlayFirst = true },
			{ Cue = "/VO/Melinoe_0168", Text = "It's him..." },
		},

		UpgradeMenuOpenVoiceLines =
		{
			[1] = GlobalVoiceLines.HeraclesBoonReactionVoiceLines,
		},

		DuoPickupTextLines =
		{
			ApolloWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "ApolloSecondStageCastBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0089",
					Text = "{#Emph}Erm{#Prev}, greetings, honored Cousin! I'm here now with none other than the bringer of thunder and lightning, magnanimous King of Olympus, your great Lord Uncle and my illustrious father, Zeus!" },
				{ Cue = "/VO/Zeus_0100",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "ZeusUpgrade",
					Text = "Oh, {#Emph}haha{#Prev}, my niece and I are well past such a level of formality, my son! Though while we have the pleasure of her company, what say we show her how we put the {#Emph}light {#Prev}into {#Emph}lightning?" },
			},

			ApolloWithHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "RaiseDeadBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0093",
					Text = "I know you were expecting me, sunshine, but my {#Emph}glorious {#Prev}stepmother the Queen would like a word! This instant... so I'd better step aside, all right?" },
				{ Cue = "/VO/Hera_0104",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HeraUpgrade",
					Text = "You see, my dear? There are yet those upon Olympus who show their Queen the proper deference. Seek not to earn the love of your subjects; make them a bit afraid, instead." },
			},

			ApolloWithPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "PoseidonSplashSprintBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0091",
					Text = "Cousin, our uncle and I were just debating what to do about mortals who turned their backs on us... I think a year or so of plague should settle up the score! But, Lord Poseidon here thinks it's more important to {#Emph}go big..." },
				{ Cue = "/VO/Poseidon_0042",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "PoseidonUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "Why would you {#Emph}not {#Prev}go big, given the choice, my delicate nephew? I'll shake the earth so strongly it shall swallow all those nasty mortals up, and deliver them straight down into the arms of your comely cousin there!" },
			},

			ApolloWithDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "CastRampBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0097",
					Text = "All of us here want you to succeed, Cousin, though none so much as Lady Demeter... I'm reminded that you are her grandchild, after all. {#Emph}Erm{#Prev}, wait, she wants to speak to you herself!" },
				{ Cue = "/VO/Demeter_0104",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "DemeterUpgrade",
					Text = "Thank you for your advocacy services, Apollo. Should I have need of them again, I shall apprise you. For now, my granddaughter requires our abilities, not honeyed words." },
			},

			ApolloWithAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "ManaBurstCountBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0099",
					Emote = "PortraitEmoteDepressed",
					Text = "I, {#Emph}erm{#Prev}, lost my train of thought, Cousin, for Aphrodite here, she doesn't seem to understand the meaning of a {#Emph}private conversation. {#Prev}Lady, would you care to join us, then?" },
				{ Cue = "/VO/Aphrodite_0095",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AphroditeUpgrade",
					Emote = "PortraitEmoteAffection",
					Text = "Oh, dear Apollo, {#Emph}yes{#Prev}, I {#Emph}always {#Prev}care to join your conversations, {#Emph}especially {#Prev}the private ones! And is there any who could blame me? Love and sunshine go together, after all!" },
			},

			ApolloWithHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "MassiveAoEIncrease",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0101",
					Text = "You know, Cousin, one thing you and Hephaestus have in common is you don't seem to get a lot of sun! I often try to coax him from his cave, and while I usually fail, not {#Emph}this {#Prev}time!" },
				{ Cue = "/VO/Hephaestus_0126",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Emote = "PortraitEmoteAnger",
					Text = "Come off it, mate, before the witchie catches on to your routine! Now make yourself useful over here, lest I stick this hammer right where {#Emph}you {#Prev}don't get a lot of sun!" },
			},

			ApolloWithHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					HasTraitNameInRoom = "CoverRegenerationBoon",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0095",
					Text = "Great Hestia has joined us here, Cousin! Returned from all her journeys 'cross the world, to lend her wisdom in our time of need. Where glows her hearth-flame, you shall also find my light. And together, we can, {#Emph}oh—!" },
				{ Cue = "/VO/Hestia_0152",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HestiaUpgrade",
					Emote = "PortraitEmoteFiredUp",
					Text = "{#Emph}Oh {#Prev}shut it, Golden Boy, we don't have time for pageantry! Instead, how about we show your wee cousin there how we can light up the night? Won't do for her to wander in the dark!" },
			},

		},

		InteractTextLineSets =
		{
			ApolloFirstPickUp =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsNone = { "TestAllThings", },
					},
				},
				{ Cue = "/VO/Melinoe_0630", UsePlayerSource = true,
					PreLineThreadedFunctionName = "PlayEmoteAnimFromSource", PreLineThreadedFunctionArgs = { Emote = "None", Portrait = "Portrait_Mel_Intense_01", WaitTime = 4.9, PowerWordPresentation = true, PowerWordWaitTime = 6.35 },
					--PostLineAnim = "MelinoeInteractEquip", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					BoxAnimation = "DialogueSpeechBubble",
					BoxExitAnimation = "DialogueSpeechBubbleOut",
					NarrativeContextArt = "DialogueBackground_Erebus",
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "Just a spell, it's just another spell. Ten words.... {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Apollo_0088",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					Text = "Greetings from Olympus and well met, there, sunshine! Look, we can't get to the Titan, but if you truly mean to stop him, then the least I can do is light your way down." },
			},

			-- low health
			ApolloLowHealth01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0060",					
					Text = "You seem a bit out of sorts, sunshine. I'm supposed to be the god of healing, though even I can't aid you all that much in your present state. But let me see what I can do." },
			},
			ApolloLowHealth02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0061",					
					Text = "{#Emph}Eugh{#Prev}, you seem unwell, Cousin. Either you're pushing yourself too hard, or your foes landed a few too many hits. Perhaps both. Take care, all right?" },
			},

			-- run starts
			ApolloRunStart01 =
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
				{ Cue = "/VO/Apollo_0054",
					Text = "Just getting started for the evening, are you, sunshine? Don't know about you but I've got a good feeling about how this is going to go." },
			},
			ApolloRunStart02 =
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
				{ Cue = "/VO/Apollo_0055",
					Text = "The night is young, and I found you already. You don't suppose some of my sister's tracking skill is starting to rub off on me, do you?" },
			},

			-- story events
			ApolloAboutTitanWar01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0023",
					Text = "Do bide your time, sunshine. The Titan thinks he has us pinned, but we have the situation here under control! Just locked in a bit of a stalemate is all." },
			},
			ApolloAboutTitanWar02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0046",
					Emote = "PortraitEmoteDepressed",
					Text = "{#Emph}Augh{#Prev}, this blasted war. Leaves little time for music or for poetry or any of life's joys. Though, it's brought the family closer together, I guess!" },
			},

			ApolloAboutChronos01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0026",
					Text = "That Chronos is up to something, but not even Athena knows what. His assaults on Olympus always fail, even if they've kept us occupied. What's his next move...?" },
			},
			ApolloAboutChronos02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ChronosNightmare01" },
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "DemeterFirstPickUp", "HestiaFirstPickUp", "AphroditeFirstPickUp" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0024",
					Text = "To think we'd wage war against our own grandfather. Not that we should give Chronos that sort of credit. He's a disgrace to our line; a hateful Titan, not a god. Not family." },
			},
			ApolloAboutChronos03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0025",
					Text = "I rather hoped old Chronos and his ilk would have seen the light by now, but alas. We'll just have to keep shining it in their faces for a while." },
			},

			ApolloAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0035",
					Text = "You trained under Hecate, the Witch of the Crossroads? She's well respected here, though we've not seen her in a while, of course. I often speak ill of Titans lately but I'm reminded that they're not all bad." },
			},
			ApolloAboutSilverSisters01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloAboutHecate01", },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Artemis_Field_01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0036",
					Text = "My sister Artemis once also trained with Hecate, you know! Trained in {#Emph}what{#Prev}, however, I have no idea. I still remember how they'd howl at night like a pack of wolves, {#Emph}heh{#Prev}. Bit unnerving, honestly!" },
			},

			ApolloAboutHades01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0037",
					Text = "I never was particularly close with your father, but I guess neither were you. Always struck me as a gloomy sort, though he did seem to care a lot about his own. He'll get his justice yet." },
			},

			ApolloAboutOlympus01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0045",
					Text = "We'll keep holding it together on this mountaintop, just as long as you keep holding it together... wherever it is you happen to be! Take care, all right?" },
			},

			ApolloAboutHardTimes01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0051",
					Text = "Our world's been through worse times than {#Emph}this, {#Prev}Cousin! So I am told at least, I've not seen anything this bad. Still, it's nothing we can't handle, right?" },
			},

			ApolloAboutMelinoe01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0084",
					Text = "When Artemis first told me your tale, I figured it was just one of her pranks. Taking on the Titan yourself, {#Emph}come on. {#Prev}But it {#Emph}did {#Prev}sound like something a vengeful child of Hades might attempt..." },
			},

			ApolloAboutRouteChoice01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ApolloAboutSurface02" },
					},
					{
						PathTrue = { "PrevRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0085",	
					Text = "So you get to pick your poison between going after Chronos in the Underworld, or coming to our rescue here! Truth is there's been some dispute as to which is the brighter idea. But, you must know what you're doing better than we." },
			},

			ApolloAboutWitchcraft01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0047",
					Text = "So you're a witch, are you? Interesting craft. Your magick-making words possess a certain rhythm and power. Poetry is much the same! Except its magick affects only the heart." },
			},

			ApolloAboutMortals01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0044",
					Text = "Mortals look to us for guidance and inspiration. They must be {#Emph}horrified {#Prev}by what they're seeing of late! Half of them seem to be against us now. Let's hope it's the {#Emph}other {#Prev}half that's left once all this is over." },
			},

			ApolloAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0027",
					Text = "I don't like getting swept up in family affairs. Much better things to do, you know? But I couldn't exactly sit this one out. Nor you I guess." },
			},
			ApolloAboutFamily02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "HestiaFirstPickUp", "AphroditeFirstPickUp" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "HeraFirstPickUp", "HeraFirstPickUpAlt" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0028",
					Text = "No wonder Chronos hates us, right? Admittedly we've got some prickly personalities here, but for all our quirks, we're family; and we stick together. Something Titans wouldn't understand." },
			},

			ApolloAboutProphecy01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0031",
					Text = "Bit embarrassed to admit that I'm the god of prophecy, among everything else. I ought to have seen this Titan business coming! But I didn't... and old Chronos caught us out." },
			},
			ApolloAboutProphecy02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0032",
					Text = "As god of prophecies, I'm certain that we're going to succeed. Exactly how, though, I can't say for sure. That's prophecies for you! Blasted frustrating things most of the time." },
			},

			ApolloAboutLight01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0049",
					Emote = "PortraitEmoteSparkly",
					Text = "What sort of light can I provide for you today? I've got hard light, soft light, blinding light, last thing a mortal ever sees light... you name it!" },
			},
			ApolloAboutLight02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0050",
					Emote = "PortraitEmoteSparkly",
					Text = "You ever wonder what light really is, Cousin? Can't grasp it in your hand, doesn't weigh a thing, yet it's all around us! A real mystery... I'm waiting for the mortals to figure it out!" },
			},
			ApolloAboutLight03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0042",
					Text = "You're more of a night person, aren't you, sunshine? Accustomed to the dark. Me, I'm more the broad daylight type, but hey, to each their own." },
			},
			ApolloAboutLight04 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0043",
					Text = "Don't know how you managed all this time without so much as a ray of light down there. Different worlds, I guess, but sometimes good things happen when such worlds collide." },
			},

			ApolloAboutCrossroads01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0029",
					Text = "So you were born and raised in some secluded grove down there? No luxuries, mortal worshipers... so much living to catch up on once this ugly matter is resolved." },
			},
			ApolloAboutErebus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0048",
					Text = "Wonder what there is to do for leisure down in Erebus, when one isn't rigorously training to vanquish hateful Titans and such. There must be something..." },
			},
			ApolloAboutOceanus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0072",
					Emote = "PortraitEmoteSurprise",
					Text = "Where in blazes are you now, sunshine? It's like you're at the bottom of the sea. Wherever it is, it's awful dark, and as you know, I've always got the cure for that." },
			},
			ApolloAboutSurface01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0073",
					Emote = "PortraitEmoteSparkly",
					Text = "My word, you reached the surface, didn't you, sunshine? I thought your birthright meant you couldn't live up here! You're just full of surprises. So, headed this way? Let me help." },
			},
			ApolloAboutSurface02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0074",
					Text = "The surface used to be more pleasant. But ever since the siege, Uncle Poseidon has been going all out with quakes and cataclysms in response. Stirring up the land like it's his mixing bowl." },
			},
			ApolloAboutEphyra01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0083",
					Text = "How fares your voyage here, sunshine? If only we could whisk you over with more-godlike means, but the skies are as treacherous as the waters... as I suspect you've noticed." },
			},
			ApolloAboutThessaly01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0072",
					Emote = "PortraitEmoteSurprise",
					Text = "Where in blazes are you now, sunshine? It's like you're at the bottom of the sea. Wherever it is, it's awful dark, and as you know, I've always got the cure for that." },
			},

			ApolloAboutPassions01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0030",
					Text = "I like being the god of many things. There's light, and poetry, music, healing... so many passions, and all the time in the world. Why settle for just blacksmithing or what-have-you?" },
			},

			-- legendary
			ApolloLegendaryPickUp01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0052",
					Text = "All right, sunshine... what do you say we cut the song and dance and set you up with something positively brilliant this time. See here!" },
			},
			ApolloLegendaryPickUp02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					ValuableUpgradeInRoom = {
						AllAtLeastRarity = "Rare",
						HasAtLeastRarity = "Epic",
						},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0053",
					Text = "There's no one god of vengeance on Olympus, because we all share that responsibility at times. Go on, take back what's yours." },
			},

			-- about other gods
			ApolloAboutZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0076",
					Text = "My father Zeus already got to you, did he? {#Emph}Blessed {#Prev}you, I should say! He's a god of many inclinations. But when our rule is threatened, or even insulted, no one fights back more fiercely." },
			},
			ApolloAboutPoseidon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0077",
					Text = "Beneath our uncle Poseidon's affable veneer is a ferocity I've learned to carefully avoid. If he's backed you with his ocean-strength, you're better off. Go make the most of it!" },
			},
			ApolloAboutAphrodite01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AphroditeUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodVoiceLines,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0078",
					Text = "Word of advice about good Lady Aphrodite? Don't get distracted. She speaks of love and beauty, though she's no stranger to conflict. Perhaps my power can offset her own." },
			},
			ApolloAboutHera01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0079",
					Text = "{#Emph}Ah{#Prev}, you've met my stepmother, have you? I'm fortunate to feel loved, but Hera, well, I'm not her favorite. Long as no one leads her to believe you're Zeus's child, you will be just fine." },
			},
			ApolloAboutHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0080",
					Text = "Hey you got old Hestia to crawl out of the woodwork! She normally wants nothing to do with any of us, though this business with Chronos got her all worked up. Well, good!" },
			},
			ApolloAboutDemeter01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0081",
					Text = "When Artemis first told me about you, I couldn't help but think of Demeter. She couldn't be there for your mother when Chronos struck, but I know she'll do everything she can for you." },
			},
			ApolloAboutHermes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0082",
					Text = "You got there faster than expected, which might mean you got a bit of a boost from Hermes! He's swift for sure, though I can never get a straight answer out of him about anything..." },
			},
			--[[
			ApolloAboutSelene01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				-- { Cue = "",
				--	Text = "You seem fairer than ever, Cousin... awash in moonlight. Selene's handiwork? Always so busy galloping across the sky, that one. Well, make you easier to spot." },
			},
			]]--
			ApolloAboutArtemis01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ApolloAboutMelinoe01" },
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0087",
					Text = "Artemis always calls me little brother, when we're {#Emph}twins! {#Prev}At least she never comes home empty-handed from her hunts. Just recently she found a family relative and ally, poised to strike behind enemy lines! You are {#Emph}quite {#Prev}the prize." },
			},
			ApolloAboutArtemis02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "UseRecord", "NPC_Artemis_Field_01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0034",
					Text = "If Artemis was terse or impolite with you, don't take it personally, please. It's how she is with everyone. Always been the solitary sort, and we never know where she is when we need her." },
			},
			ApolloAboutAthena01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord", },
						HasAll = { "ZeusFirstPickUp", "PoseidonFirstPickUp", "HestiaFirstPickUp", "DemeterFirstPickUp", "AphroditeFirstPickUp" },
					},
					{
						Path = { "GameState", "UseRecord", "ApolloUpgrade" },
						Comparison = ">=",
						Value = 5,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0038",
					Text = "My half-sister Athena knew your brother well, and sends her regards. She's preoccupied with our defense, leading our front-line forces and all that! She regrets that she can't aid you thus." },
			},
			ApolloAboutPolyphemus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "N_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "N_PreBoss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0150",
					Text = "The sightless Cyclops Polyphemus bars your passage, does he now? Don't know what good my light will do against the likes of {#Emph}him{#Prev}, though perhaps I can help get you there in one piece." },
			},
			ApolloAboutEris01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "O_Boss01" },
					},
					{
						PathFalse = { "CurrentRun", "RoomsEntered", "O_PreBoss01" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0151",
					Text = "We've confirmed sightings of that {#Emph}Eris {#Prev}buzzing about. She's from your realm not ours, so you may be more privy to how come she's showed up uninvited! Though, that tends to be her style. Somebody needs to shoo her away, already..." },
			},

			-- other reactions
			ApolloAboutKeepsake01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "ForceApolloBoonKeepsake" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0086",
					Text = "See, sunshine? Hope can work wonders when it's part of a good plan. For when you bear the Purest Hope I gave to you, I won't be far behind. And the warm fuzzy feeling's not bad!" },
			},
			ApolloAboutTorch01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "Weapons", "WeaponTorch" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0155",
					Text = "You were a little easier to spot with twin torches in hand... though yours don't seem to cast the customary kind of light! Truly the more I learn of you, the more questions I have!" },
			},
			ApolloAboutBows01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01", },
					},
					{
						Path = { "GameState", "WeaponsUnlocked" },
						HasAll = { "WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponLob" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0156",
					Text = "Couldn't help but notice there's no {#Emph}bow {#Prev}in your arsenal! Artemis and I, we figure why sully our hands when we can settle any ugly business from afar... although your magick may suffice!" },
			},

			ApolloPostGift01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0069",
					Text = "How did there come to be so much deceit in this world, Cousin? Believe me, we've needed a god of truth around here sometimes. Happy to do it and hope it catches on." },
			},
			ApolloPostGift02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift01" },
					},
					{
						Path = { "GameState", "UseRecord", "ApolloUpgrade" },
						Comparison = ">=",
						Value = 10,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0070",
					Text = "Hope you don't mind I call you sunshine, by the way! I mean it when I say it. I know you come from underneath the earth, but there's this brilliance about you. Your mother's side I guess." },
			},
			ApolloPostGift03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift02" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "HeraUpgrade" },
					},					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0071",
					Text = "There anybody special in your life? A princess like yourself must have suitors of all sorts. I've had my share, though I'm not the marrying type, and besides, I don't think Hera would oblige..." },
			},

			ApolloAboutTalent01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Reprieve01", "F_Shop01", "F_Boss01", "G_Shop01", "G_PreBoss01", "H_Shop01", "H_PreBoss01", "N_Opening01", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0039",
					Text = "{#Emph}Ah{#Prev}, 'twas poetry in motion, the way you handled yourself back there! Talent runs in the family! Some of us just got the lion's share." },
			},
			ApolloAboutFoes01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Reprieve01", "F_Shop01", "F_Boss01", "G_Shop01", "G_PreBoss01", "H_Bridge01", "H_PreBoss01", "N_Opening01", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0040",
					Text = "Well, sunshine, it's just the two of us again, now that you slaughtered every... what exactly do you call those? Well, no matter, here!" },
			},
			ApolloUnderworldRunCleared01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0045",
					Text = "Look at you, strutting through that Underworld as though you own the place! Although perhaps you do? Not sure how it works with the succession plans down there." },
			},
			ApolloUnderworldRunCleared02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" }
					},
					{
						PathTrue = { "PrevRun", "RoomCountCache", "I_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0149",
					Text = "The other evening, we lost contact with you in the deepest level of the Underworld. Soon after, though, our enemies flew into disarray, at least for a while. Your doing wasn't it? Fine work!" },
			},

			-- repeatable lines
			ApolloChat01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0003",
					Text = "Let's show them a dazzling display they won't soon forget." },
			},
			ApolloChat02 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0004",
					Text = "Won't take but a moment here and you'll be positively radiant, you'll see." },
			},
			ApolloChat03 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0005",
					Text = "I'd rather we handled all this in the light of day, but whatever works!" },
			},
			ApolloChat04 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0006",
					Text = "Brighter days are ahead, just have to get through this rough patch." },
			},
			ApolloChat05 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0007",
					Text = "What can we do but try and make these dark days a bit brighter, Cousin?" },
			},
			ApolloChat06 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0008",
					Text = "You're going to put on a brilliant performance tonight, Cousin." },
			},
			ApolloChat07 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0009",
					Text = "Peace will come again eventually, but for now, we have a reputation to uphold." },
			},
			ApolloChat08 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0010",
					Text = "From all of us upon Olympus, we are grateful for your ongoing support." },
			},
			ApolloChat09 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0011",
					Text = "Must be something I can do to brighten up your evening there a bit?" },
			},
			ApolloChat10 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0012",
					Text = "Go on, sunshine, and may my light help guide you where you need to be." },
			},
			ApolloChat11 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloPoem01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0013",
					Text = "Can't have a nice day out in the sun, well here's the next best thing!" },
			},
			ApolloChat12 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloPoem01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0014",
					Text = "You're brilliant without my light, though here's a little just in case." },
			},
			ApolloChat13 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloPoem01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0015",
					Text = "Much as I'd rather offer poetry and music, right now these shall have to do." },
			},
			ApolloChat14 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloPoem01", },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0016",
					Text = "Where there's light, there's hope, sunshine, so get set for some of each!" },
			},
			ApolloChat15 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0017",
					Text = "Oh, this is going to be a sensational night, I can already tell!" },
			},
			ApolloChat16 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0018",
					Text = "Your foes won't so much as touch you once we dazzle them a bit." },
			},
			ApolloChat17 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0019",
					Text = "I'd cast a plague upon our enemies but think you'll do the trick." },
			},
			ApolloChat18 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0020",
					Text = "Tread lightly down there, and remember, we're with you all the way." },
			},
			ApolloChat19 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0021",
					Text = "Remember, don't go heading down into the dark without a light." },
			},
			ApolloChat20 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0022",
					Text = "I confess I'm rather enjoying this particular song and dance." },
			},
		},

		BoughtTextLines =
		{
			ApolloLootBought01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0062",
					Text = "It's fortunate the Underworld Boatman's still plying his trade even during a downturn such as this! I trust his prices have gotten better, at least? Or, perhaps worse..." },
			},
			ApolloLootBought02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					IsObjectTypeAlive = "NPC_Charon_01",
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0063",
					Text = "We have to reach you however we can, and Charon's been more than keen to oblige. Bit of an odd fellow, but then, aren't we all?" },
			},
		},

		RejectionTextLines =
		{
			ApolloRejection01 =
			{
				{ Cue = "/VO/Apollo_0064",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "You wound me, Cousin. After everything we've been through together, you'd brush me off so easily?" },
			},
			ApolloRejection02 =
			{
				{ Cue = "/VO/Apollo_0065",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "{#Emph}Augh! {#Prev}Now really isn't the time for petty squabbles, but I'm afraid you leave me with no choice..." },
			},
			ApolloRejection03 =
			{
				{ Cue = "/VO/Apollo_0103",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Emote = "PortraitEmoteSurprise",
					Text = "Not your first choice?! Perhaps you haven't heard, so I'll enlighten you: My generosity is not unlimited." },
			},
			ApolloRejection04 =
			{
				{ Cue = "/VO/Apollo_0104",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I have few weak points, but my pride is one. You got me where it hurts, so now I've got to get you back." },
			},
			ApolloRejection05 =
			{
				{ Cue = "/VO/Apollo_0105",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Was it something I said or did? Or perhaps you don't respect my power. Even when it's turned against you thus?" },
			},
			ApolloRejection06 =
			{
				{ Cue = "/VO/Apollo_0106",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I go out of my way to offer you my strength, and you refuse? That's not something any self-respecting god can abide." },
			},
			ApolloRejection07 =
			{
				{ Cue = "/VO/Apollo_0107",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Come on, sunshine, why the snub? You should know that when my feelings get hurt, it's never the only thing." },
			},
			ApolloRejection08 =
			{
				{ Cue = "/VO/Apollo_0108",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "I have a reputation to live up to. I can't just let you brush me off like some pathetic commoner with nothing but a prayer!" },
			},
			ApolloRejection09 =
			{
				{ Cue = "/VO/Apollo_0109",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Perhaps someday we'll all be able to resolve our differences more sensibly. But we're the gods, and we're a family, damn it!" },
			},
			ApolloRejection10 =
			{
				{ Cue = "/VO/Apollo_0110",
				PreLineFunctionName = "BoonInteractPresentation",
				PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
				PreLineWait = 1.0,
					Text = "Beneath this sunny disposition, I have something of a vengeful streak, Cousin. Though I know actions speak louder than words." },
			},

		},

		RejectionVoiceLines =
		{
			[1] = GlobalVoiceLines.GodRejectedVoiceLines,
		},

		MakeUpTextLines =
		{
			ApolloMakeUp01 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0066",
					Text = "Oh, enough of this. Let's turn our combined might back in the same direction, and move on." },
			},
			ApolloMakeUp02 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0067",
					Text = "That got a bit ugly, didn't it? How about we both stay focused on the task at hand." },
			},
			ApolloMakeUp03 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0111",
					Text = "Forgive my little outburst there, would you? Just a bit of bad temper. Runs in the family." },
			},
			ApolloMakeUp04 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0112",
					Text = "A momentary flash of anger was all! We gods are easily hurt, for a bunch of immortals." },
			},
			ApolloMakeUp05 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0113",
					Text = "You were just messing with me back there, right? I normally can take a prank just fine, but we've all been a bit on edge." },
			},
			ApolloMakeUp06 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0114",
					Text = "No use keeping anger bottled up. We're gods! We control everything but our emotions, right?" },
			},
			ApolloMakeUp07 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0115",
					Text = "Relationships grow stronger through adversity. So ours must have grown a little stronger there!" },
			},
			ApolloMakeUp08 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0116",
					Text = "{#Emph}Erm{#Prev}, sorry about that, sunshine. When my wrath flares up, probably best to not be anywhere in the vicinity." },
			},
			ApolloMakeUp09 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0117",
					Text = "Well, so much for that lot! May my blessing serve you better than them. You earned it!" },
			},
			ApolloMakeUp10 =
			{
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0118",
					Text = "I let frustrations get the best of me, but that entertaining spectacle shook me out of it!" },
			},

		},

		GiftTextLineSets =
		{
			-- gives gift in exchange
			ApolloGift01 =
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
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0502", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Cousin Apollo! I am grateful for all your warmth, benevolence, and aid! Please, accept this gift!" },
				{ Cue = "/VO/Apollo_0056",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "An offering, for me? What a delightful surprise, and I haven't had a lot of those of late. Know what, I've something for you, too!" },
			},
			ApolloGift02 =
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
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
				},
				{ Cue = "/VO/Melinoe_0503", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "I wonder, does this bottle's brilliant sheen come from the god of light, himself? Perhaps to him it should return, right now!" },
				{ Cue = "/VO/Apollo_0057",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteCheerful",
					Text = "Such a thoughtful gift! It's gracious of you to think of me like this, and during such a time. Though there's no need to go out of your way!" },
			},
			ApolloGift03 =
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
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1759", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Brilliant Apollo, your many talents must be the envy of all the land, and I am honored that you're sharing them with me. Here, this is for you!" },
				{ Cue = "/VO/Apollo_0058",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Emote = "PortraitEmoteCheerful",
					Text = "Come now, you truly shouldn't have. Such flattery's entirely unnecessary, I assure you! Although it's perfectly welcome!" },
			},
			ApolloGift04 =
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
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
				},
				{ Cue = "/VO/MelinoeField_1760", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "They say this Nectar shines as brightly as the sun, Cousin. May it live up to such a promise, especially now that it's yours! I'm beyond fortunate to have you as a friend." },
				{ Cue = "/VO/Apollo_0059",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Oh, you're too kind. You didn't have to get me {#Emph}this! {#Prev}I never knew you Underworld gods were so damn courteous. You know our customs better than {#Emph}we {#Prev}do!" },
			},

			-- placeholder
			ApolloGiftTemp =
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

			{ Cue = "/VO/Melinoe_1734", Text = "Thank you for this, Cousin!" },
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
			Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },

			{ Cue = "/VO/Apollo_0139", Text = "Mess with me, and it's lights out, sunshine." },
			{ Cue = "/VO/Apollo_0140", Text = "Need I remind you, I'm not always as nice as I look." },
			{ Cue = "/VO/Apollo_0141", Text = "Best not push the bounds of our relationship too far." },
			{ Cue = "/VO/Apollo_0142", Text = "I'm no less prone to wrath than any of us, Cousin." },
			{ Cue = "/VO/Apollo_0143", Text = "We Olympians can't all be the best; because it's my job." },
			{ Cue = "/VO/Apollo_0144", Text = "You left me little choice but the old show of force." },
		},

		RarityUpgradeVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },
			Cooldowns =
			{
				{ Name = "BoonRarifiedSpeech", Time = 60 },
			},

			{ Cue = "/VO/Apollo_0131", Text = "Naturally!" },
			{ Cue = "/VO/Apollo_0132", Text = "For certain!" },
			{ Cue = "/VO/Apollo_0133", Text = "There!" },
			{ Cue = "/VO/Apollo_0134", Text = "You got it!" },
			{ Cue = "/VO/Apollo_0135", Text = "For you!" },
			{ Cue = "/VO/Apollo_0136", Text = "Right!" },
			{ Cue = "/VO/Apollo_0137", Text = "Sure thing!" },
			{ Cue = "/VO/Apollo_0138", Text = "Brilliant!" },
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },
			TriggerCooldowns = { "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Apollo_0119", Text = "Hello, sunshine!" },
			{ Cue = "/VO/Apollo_0120", Text = "Hello, Cousin!" },
			{ Cue = "/VO/Apollo_0121", Text = "Guess who, sunshine?" },
			{ Cue = "/VO/Apollo_0122", Text = "Greetings from Olympus!" },
			{ Cue = "/VO/Apollo_0123", Text = "At your service!" },
			{ Cue = "/VO/Apollo_0124", Text = "Surprise, surprise!" },
		},

	},

}

OverwriteTableKeys( LootData, LootSetData.Apollo )