LootSetData.Apollo =
{
	-- Apollo
	ApolloUpgrade = 
	{
		InheritFrom = { "BaseLoot", "BaseSoundPackage" },

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
		BoonInfoIcon = "BoonInfoSymbolApolloIcon",
		MenuTitle = "UpgradeChoiceMenu_Title_ApolloUpgrade",
		EchoLastRewardId = "EchoLastRewardBoon_ApolloUpgrade",
		LootRejectedText = "Player_GodDispleased_ApolloUpgrade",
		SuperSacrificeCombatText = "SuperSacrifice_CombatText_ApolloUpgrade",
		Icon = "BoonSymbolApollo",
		EmoteOffsetX = 30,
		EmoteOffsetY = -320,
		DoorIcon = "BoonDropApolloPreview",
		DoorUpgradedIcon = "BoonDropApolloUpgradedPreview",
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
			"ApolloExCastBoon",
			"ApolloCastAreaBoon",
			"DoubleStrikeChanceBoon",
			
			-- Elemental			
			"ElementalRallyBoon",

			-- Legendary
			"DoubleExManaBoon",
			
			-- Duos
			"ApolloSecondStageCastBoon",
			"RaiseDeadBoon",
			"PoseidonSplashSprintBoon",
			"StormSpawnBoon",
			"ManaBurstCountBoon",
			"CoverRegenerationBoon",
			"BlindClearBoon",
			"DoubleSwordBoon",
		},
		Consumables = { },

		SpeakerName = "Apollo",
		Speaker = "NPC_Apollo_01",
		LoadPackages = { "Apollo", },
		Portrait = "Portrait_Apollo_Default_01",
		WrathPortrait = "Portrait_Apollo_Default_01_Wrath",
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
			{ Cue = "/VO/MelinoeField_3124", Text = "Apollo...!" },
		},

		UpgradeMenuOpenVoiceLines =
		{
			{ GlobalVoiceLines = "HeraclesBoonReactionVoiceLines" },
		},

		DuoPickupTextLines =
		{
			ApolloWithZeus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "ApolloSecondStageCastBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "RaiseDeadBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "PoseidonSplashSprintBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "StormSpawnBoon" },
					},
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "ManaBurstCountBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0099",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Apollo_Serious_01",
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
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "BlindClearBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0101",
					Text = "You know, Cousin, one thing you and Hephaestus have in common is you don't seem to get a lot of sun! I often try to coax him from his cave, and while I usually fail, not {#Emph}this {#Prev}time!" },
				{ Cue = "/VO/Hephaestus_0126",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "HephaestusUpgrade",
					Emote = "PortraitEmoteAnger",
					Portrait = "Portrait_Hephaestus_Displeased_01",

					Text = "Come off it, mate, before the witchie catches on to your routine! Now make yourself useful over here, lest I stick this hammer right where {#Emph}you {#Prev}don't get a lot of sun!" },
			},

			ApolloWithHestia01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "CoverRegenerationBoon" },
					},
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

			ApolloWithAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						FunctionName = "RequiredTraitNameInRoom",
						FunctionArgs = { Name = "DoubleSwordBoon" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0169",
					Text = "Ares and I were just chatting about how we seem to get on best when we're on the same side of a war. So, Brother, is this all an elaborate ploy to bring us closer together?" },
				{ Cue = "/VO/Ares_0159",
					PortraitExitWait = 0.35,
					PreLineFunctionName = "BoonInteractPresentation", PreLineWait = 0.5,
					Source = "AresUpgrade",
					Text = "I think it's merely that a proper war brings out the best in all of us; even in you, Apollo, and in me. The rigors of conflict forge unbreakable bonds! And make for powerful blessings." },
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
					UseRoomContextArt = true,
					PostLineRemoveContextArt = true,
					TextColor = Color.DialogueText,
					Text = "Just a spell, it's just another spell. Ten words... {#Emph}In the name of Hades! Olympus, I accept this message!" },
				{ Cue = "/VO/Apollo_0088",
					PortraitExitWait = 1.25,
					NarrativeContextArt = "DialogueBackground_Olympus",
					PreContentSound = "/Leftovers/Menu Sounds/TextReveal2",
					-- Portrait = "Portrait_Apollo_Serious_01",
					-- Portrait = "Portrait_Apollo_Displeased_01",
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0060",
					Portrait = "Portrait_Apollo_Serious_01",
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
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0061",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "{#Emph}Eugh{#Prev}, you seem unwell, Cousin. Either you're pushing yourself too hard, or your foes landed a few too many hits. Perhaps both. Take care, all right?" },
			},
			ApolloLowHealth03 =
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
						Value = 1,
					},
					{
						FunctionName = "RequiredHealthFraction",
						FunctionArgs = { Comparison = "<=", Value = 0.3, },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0234",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "I'm a bit of a physician, sunshine, and my professional opinion is your vital signs are not the best right now. Although perhaps we can still get you back in shape..." },
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
					Text = "Just getting started for the evening, are you, sunshine? Don't know about you, but I've got a good feeling about how this is going to go!" },
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
			ApolloRunStart03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Name", },
						IsAny = { "F_Opening01", "F_Opening02", "F_Opening03", "N_Opening01" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0231",
					Text = "Before you go charging off to battle and glory once more, please, allow me! And may this blessing be of benefit every step of the way tonight." },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0046",
					Portrait = "Portrait_Apollo_Displeased_01",
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
					Portrait = "Portrait_Apollo_Serious_01",
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Portrait = "Portrait_Apollo_Displeased_01",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0025",
					Portrait = "Portrait_Apollo_Displeased_01",
					Text = "I rather hoped old Chronos and his ilk would have seen the light by now, but alas. We'll just have to keep shining it in their faces for a while." },
			},
			ApolloAboutChronosBossW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						-- PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0158",
					Text = "You've struck a solid blow against the Titan's forces, but they've started to regroup. Still, these types of victories must shake them to the core. Let's drive them back!" },
			},
			ApolloAboutChronosBossW02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
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
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 4,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0159",
					Text = "They're saying you got Chronos, didn't you, sunshine? Last night at least, but that's the deathless Titans for you! Never staying down for long. Though you've something in mind for that, my sister says..." },
			},

			ApolloAboutTyphon01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_MiniBoss03" },
					},
					{
						PathFalse = { "GameState", "EnemyKills", "TyphonHead" },
					},
					{
						SumPrevRuns = 6,
						Path = { "RoomsEntered", "Q_MiniBoss03" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0154",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Ever wondered just how gargantuan is Typhon, the Father of All Monsters, truly? Well, you need but pay a visit here and you'll find out! Till then, {#Emph}erm{#Prev}, we'll... just have to fend him off!" },
			},
			ApolloAboutTyphon02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						Path = { "PrevRun", "RoomsEntered" },
						HasAny = { "Q_Boss01", "Q_Boss02" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0160",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Judging by all his vengeful roars, Typhon must hate my father almost as much as Chronos does. But are they truly working together? A monster such as that couldn't possibly be taking orders from a Titan, or anybody." },
			},

			ApolloAboutTyphonW01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
				{ Cue = "/VO/Apollo_0162",
					Text = "I still can't entirely believe you {#Emph}got {#Prev}him, sunshine! Typhon should have taken the combined might of our entire family, and in a way he did, it's just... the rest of us were busy fighting back his swarms. He's really got us stretched thin." },
			},
			ApolloAboutTyphonW02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0161",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "If Typhon keeps coming back, eventually there may be no mountain here left to climb. I know my father and Queen Hera have a plan in case things could not get more dire, but I'm more optimistic for whichever plan you have in mind..." },
			},
			ApolloAboutTyphonW03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 2,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0163",
					Text = "We should be able to hold back Typhon for a while longer, especially now that you've shown us a thing or two about how it's {#Emph}done{#Prev}, sunshine. You're going after Chronos now, aren't you? Well ridding us of {#Emph}him {#Prev}certainly wouldn't hurt." },
			},

			ApolloAboutPalace01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "TyphonDefeatedWithStormStop" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "Q_Story01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0206",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "I know you're not one to complain, but it couldn't have been easy for you being at the Palace here at the break of Dawn... probably much more light than you're used to. We're hardly used to it either now thanks to all of Typhon's storms." },
			},
			ApolloAboutTyphonDeath01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ZeusPalaceAboutTyphonDeath01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0207",
					Portrait = "Portrait_Apollo_Displeased_01",
					Text = "Chronos must have thought nothing could stop him if he unleashed Typhon, but he thought wrong. Let's throw everything we've got at him and finish this, sunshine." },
			},
			ApolloAboutTyphonDeath02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutOlympus01", "NeoChronosAboutOlympus01_B" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0209",
					Text = "So we're now working to prevent even the {#Emph}possibility {#Prev}that Typhon could have overwhelmed us here? And the Titan's forces are somehow part of this new plan. Well, if you're in, {#Emph}I'm {#Prev}in. Should make my evenings more exciting for a bit!" },
			},

			ApolloAboutHecate01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
						SumPrevRuns = 3,
						Path = { "SpawnRecord", "NPC_Artemis_01" },
						Comparison = ">=",
						Value = 1,
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0037",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "I never was particularly close with your father, but I guess neither were you. Always struck me as a gloomy sort, though he did seem to care a lot about his own. He'll get his justice yet." },
			},

			ApolloAboutFates01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0164",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "I didn't think matters could get much more precarious for us, but if the Fates are truly gone, then... their prophecies about the future may not come to pass. They foretold our family's eternal rule over the world... what if they were wrong?" },
			},
			ApolloAboutFates02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "HermesAboutFates01" },
					},
					{
						FunctionName = "RequireRunsSinceTextLines",
						FunctionArgs = { TextLines = { "ApolloPostTrueEnding01" }, Min = 3 },
					},
					NamedRequirementsFalse = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0210",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Even if you managed to make Chronos see the light, the Three Fates are still missing. And we're supposed to believe he doesn't know where they are? This couldn't possibly be what they wanted or foretold..." },
			},

			ApolloAboutOlympus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "G" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0045",
					Text = "We'll keep holding it together on this mountaintop, just as long as you keep holding it together... wherever it is you happen to be! Take care, all right?" },
			},
			ApolloAboutOlympus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "P", "Q" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0177",
					Emote = "PortraitEmoteSurprise",
					Text = "Wait, you're right on Olympus now, sunshine! So close to us, though I am painfully aware the worst is yet to come as you press on. Fortunately, I have the best for you right here!" },
			},
			ApolloAboutOlympus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Intro" },
						Comparison = ">=",
						Value = 1,
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0251",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "I can't believe we've let those Satyrs overrun our mountainside... leave it to Dionysus to try and make friends with them, but I've had no such fortune, believe me." },
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
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "UseRecord", "NPC_Artemis_Field_01" },
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = { "ArtemisAboutApollo01" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "WorldUpgradesAdded", "WorldUpgradeSurfacePenaltyCure" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ApolloAboutSurface02" },
					},
					OrRequirements =
					{
						{
							{
								PathTrue = { "PrevRun", "BiomesReached", "N" },
							},
							{
								PathTrue = { "CurrentRun", "BiomesReached", "F" },
							},
						},
						{
							{
								PathTrue = { "PrevRun", "BiomesReached", "F" },
							},
							{
								PathTrue = { "CurrentRun", "BiomesReached", "N" },
							},
						},
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

			ApolloAboutHiddenAspects01 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary" },
						HasAny = GameData.AllHiddenAspects,
					},
				},
				PlayOnce = true,
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0255",
					Text = "It's often said there's nothing new under the sun, though I've not seen a weapon quite like what you're wielding there! The legendary Arms of Night, Hephaestus says. Impressive stuff!" },
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
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Mortals look to us for guidance and inspiration. They must be {#Emph}horrified {#Prev}by what they're seeing of late! Half of them seem to be against us now. Let's hope it's the {#Emph}other {#Prev}half that's left once all this is over." },
			},
			ApolloAboutMortals02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0240",
					Text = "For such a fearful lot, mortals sure love killing each other! There was this war they had a while back that even had us gods at one another's throats. I tried to settle it with plague and arrows and such, but {#Emph}no! {#Prev}Father wanted it to play out." },
			},

			ApolloAboutHouse01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0241",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "I always wished to see the House of Hades, though your father and mother have a royal guard I {#Emph}may {#Prev}have sent to their realm prematurely. It'd make things rather awkward if we ran into each other there..." },
			},

			ApolloAboutFamily01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0246",
					Portrait = "Portrait_Apollo_Displeased_01",
					Text = "I don't like getting swept up in our family's petty feuds, especially with older generations that apparently have nothing better to do. But you and I couldn't exactly sit this one out, could we?" },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Portrait = "Portrait_Apollo_Serious_01",
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0031",
					Portrait = "Portrait_Apollo_Serious_01",
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloAboutProphecy01" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
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
					Portrait = "Portrait_Apollo_Serious_01",
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
					Portrait = "Portrait_Apollo_Serious_01",
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
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "F" },
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
			ApolloAboutFields01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "H" },
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0244",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "You're in the Mourning Fields. I wonder does the Hyacinth grow there... the flower of a gentle prince, long gone. Once the Underworld reopens, perhaps I could go seek him out." },
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
						PathFalse = { "GameState", "RoomsEntered", "Q_Boss01" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0073",
					Emote = "PortraitEmoteSurprise",
					Text = "My word, you reached the {#Emph}surface{#Prev}, didn't you, sunshine? I thought your birthright meant you couldn't live up here...?" },
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
					Portrait = "Portrait_Apollo_Displeased_01",
					Text = "The surface used to be more pleasant. But ever since the siege, Uncle Poseidon has been going all out with quakes and cataclysms in response. Stirring up the land like it's his mixing bowl." },
			},
			ApolloAboutSurface03 =
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
					{
						PathFalse = { "PrevRun", "Cleared" },
					},
					{
						PathFalse = { "PrevRun", "TextLinesRecord", "ApolloAboutOlympus02" }
					},
					{
						SumPrevRuns = 3,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "N_Opening01" },
						Comparison = ">=",
						Value = 3,
					},
				},
				
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0157",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Cousin, weren't you headed to Olympus last I checked? Must have been waylaid by the Titan's thugs. Well, don't give up! Although I guess you wouldn't be there if you did." },
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
						IsAny = { "O" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0083",
					Text = "How fares your voyage here, sunshine? If only we could whisk you over with more-godlike means, but the skies are as treacherous as the waters... as I suspect you've noticed." },
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
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "RoomSetName" },
						IsAny = { "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0075",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "You must be in the city of Ephyra to the west, a staging ground for our enemies... with the Underworld gates thrown open, Chronos can replenish his forces faster than we can kill them off." },
			},

			ApolloAboutSurfaceThreat01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "RoomsEntered", "Q_Intro" },
					},
					{
						SumPrevRuns = 4,
						Path = { "RoomsEntered" },
						TableValuesToCount = { "O_Boss01", "O_Boss02" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0153",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "{#Emph}Erm{#Prev}, we've got a situation starting to unfold. A big crevasse opened up at the base of the mountain, and something's in there... something big. And it's {#Emph}breathing... {#Prev}suppose it's friendly...?" },
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
			ApolloAboutMusic01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ApolloGift05", "ArtemisHubSingingEndTheme01" },
					},
					{
						SumPrevRuns = 3,
						Path = { "SpawnRecord", "NPC_Artemis_01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0250",
					Text = "Artemis says you're rather musically inclined! Runs in the family, even your parents have an ear for it what with Orpheus as their court musician. He's the best I ever taught!" },
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
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloLegendaryPickUp02" },
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
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
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						FunctionName = "RequiredRarityInRoom",
						FunctionArgs = { AllAtLeastRarity = "Rare", HasAtLeastRarity = "Epic" },
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
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
						PathFalse = { "GameState", "RoomsEntered", "Q_Story01" }
					},
					--[[
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
					]]--
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
						HasNone = GameData.GodAboutGodEvents,
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0081",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "When Artemis first told me about you, I couldn't help but think of Demeter. She couldn't be there for your mother when Chronos struck, but I know she'll do everything she can for you." },
			},
			ApolloAboutHephaestus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
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
				{ Cue = "/VO/Apollo_0229",
					Text = "Hephaestus has been hard at work on our defenses, so I'm pleased you've heard from him. Don't take his surly manner the wrong way! He doesn't get out much, certainly not these days." },
			},
			ApolloAboutAres01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "UseRecord", "AresUpgrade" }
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0171",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Between us, I have never seen Ares so pleased as he has been recently. And I can probably imagine why. This war that we've been waging... it's a real piece of work, even for him." },
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
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0082",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "You got there faster than expected, which might mean you got a bit of a boost from Hermes! He's swift for sure, though I can never get a straight answer out of him about anything..." },
			},
			ApolloAboutDionysus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "CurrentRun", "ActiveBounty" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Dionysus_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "CurrentRun", "TextLinesRecord" },
						HasNone = GameData.GodAboutGodEvents,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0230",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "You can count on most of us, but I can't speak for Dionysus; don't even know where he is! I like a feast as much as anybody at the proper time, but the god of wine thinks the proper time is {#Emph}all {#Prev}the time." },
			},

			-- ApolloAboutArtemis01 intentionally omitted
			ApolloAboutArtemis02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 2,
						Path = { "UseRecord", "NPC_Artemis_Field_01" },
						CountPathTrue = true,
						Comparison = ">=",
						Value = 1,
					},
					{
						Path = { "GameState", "CompletedRunsCache" },
						Comparison = "<=",
						Value = 20,
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
					{
						PathFalse = { "CurrentRun", "UseRecord", "NPC_Athena_01" },
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
					Portrait = "Portrait_Apollo_Displeased_01",
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
					Portrait = "Portrait_Apollo_Displeased_01",
					Text = "We've confirmed sightings of that {#Emph}Eris {#Prev}buzzing about. She's from your realm not ours, so you may be more privy to how come she's showed up uninvited! Though, that tends to be her style. Somebody needs to shoo her away, already..." },
			},
			ApolloAboutPrometheus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathFalse = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "P_Boss01" },
					},
				},

				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0152",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Prometheus himself, leading the assault against us... one of our sole allies amongst Titankind, become a bitter foe. All because of how we treated him! Or because... he knows which side shall be victorious when all is said and done..." },
			},
			ApolloAboutPrometheus02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0211",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Didn't think we'd let Prometheus continue his assault like this. Some partnership we've formed, all so you can re-create the path you took to Typhon, to then face the monster's remnants on the summit as before...?" },
			},
			ApolloAboutPrometheus03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						SumPrevRuns = 2,
						Path = { "RoomsEntered", "P_Boss01" },
						Comparison = ">=",
						Value = 1,
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0216",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "If Prometheus truly had the foresight that everything would happen as it did... why bar your path and fight so fiercely, only to be defeated again and again...? Unless the dawning of a new age wouldn't come about in any other way..." },
			},

			-- other reactions
			ApolloAboutPackageBounty01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "CurrentRun", "ActiveBounty" },
						IsAny = { "PackageBountyStarter" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0172",
					Emote = "PortraitEmoteDepressed",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Don't know what it is exactly but something about this night made me flash back to when first you contacted me in those very woods. Well, either strange forces are at work or just my imagination, right?" },
			},
			ApolloAboutPackageBounty02 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "ActiveBounty" },
								IsAny = { "PackageBountyHazard" }
							},
						},
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Name" },
								IsAny = { "N_PreHub01" },
							},
						},
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0173",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "You're just outside of the Ephyra gates, aren't you? That city is beyond salvation; I know they used to worship your mother and father there, but still... if it were up to me alone, I'd sweep the place away and start anew." },
			},
			ApolloAboutPackageBounty03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "ActiveBountyAttempts" },
						Comparison = ">=",
						Value = 3,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0174",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "There's something exceedingly odd about tonight. Haven't we already had an evening just like this, down to the smallest detail? Your magick at work perhaps... as long as it isn't Chronos." },
			},
			ApolloAboutShrine01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "Apollo" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 12,
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

				{ Cue = "/VO/Apollo_0175",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Such a dark and oppressive night this is shaping up to be... even if I could illuminate all your foes waiting in ambush, I'm not sure you'd want to see them. Be very careful out there..." },
			},

			ApolloAboutRelationship01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "GameState", "EnemyKills", "Chronos" },
						Comparison = ">=",
						Value = 4,
					},
					{
						Path = { "GameState", "EnemyKills", "TyphonHead" },
						Comparison = ">=",
						Value = 3,
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift06" },
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Story01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0167",
					-- heart unlock
					PostLineFunctionName = "RelationshipAdvancedPresentation",
					PostLineFunctionArgs = { Delay = 0.5 },
					Text = "When I first reached out to you many nights ago, I figured, {#Emph}hey, another cousin! I like those! {#Prev}But the truth is I never expected you to make as great a difference as you have. My hope is I've done my part to make it possible." },
			},

			ApolloAboutMomusAspect01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "CurrentRun", "Hero", "TraitDictionary", "StaffSelfHitAspect" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },

				{ Cue = "/VO/Apollo_0223",
					Emote = "PortraitEmoteSurprise",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "What is that fancy staff you've got, with a serpent coiled at the top? How strange, it's... reminiscent of a vision that I've had... about a masterwork that can do no harm..." },
			},

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
				{ Cue = "/VO/Apollo_0176",
					Text = "See, sunshine? Whenever you head out with the Harmonic Photon that you got from me, I won't be far behind. And you'll get a warm fuzzy feeling for good measure!" },
			},
			ApolloAboutKeepsake02 =
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
					{
						Path = { "CurrentRun", "Hero", "TraitDictionary", "ForceApolloBoonKeepsake", 1, "Rarity" },
						IsAny = { "Epic", "Heroic" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0222",
					Text = "That Photon I gave you has seen plenty of good use by now, hasn't it? I know you don't always need a light in the darkness like so many others, so I'm pleased it could help." },
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
						HasAll = { "WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponLob", "WeaponSuit" },
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
					Portrait = "Portrait_Apollo_Serious_01",
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
			ApolloPostGift05 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift07" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0252",
					Text = "For all the Boons we've offered, you've given us quite the blessing in exchange. Olympus has powerful allies... well, you and Heracles, at least! But you have this spark so many others don't." },
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
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift04" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Reprieve01", "F_Shop01", "F_Boss01", "F_Boss02", "G_Shop01", "G_PreBoss01", "H_Shop01", "H_PreBoss01", "N_Opening01", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0247",
					Text = "I caught merely a glimpse, though that was poetry in motion the way you handled yourself against that lot. Talent runs in the family! Some of us just wound up with a bigger share." },
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
						IsNone = { "F_Opening01", "F_Opening02", "F_Opening03", "F_Reprieve01", "F_Shop01", "F_Boss01", "F_Boss02", "G_Shop01", "G_PreBoss01", "H_Bridge01", "H_PreBoss01", "N_Opening01", "N_Shop01", "N_PreBoss01", "O_Shop01", "O_PreBoss01" },
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
						PathTrue = { "PrevRun", "RoomsEntered", "I_Boss01" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0041",
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
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "The other evening, we lost contact with you in the deepest level of the Underworld. Soon after, though, our enemies flew into disarray, at least for a while. Your doing wasn't it? Fine work!" },
			},
			ApolloUnderworldRunCleared03 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
					{
						PathTrue = { "PrevRun", "EnemyKills", "Chronos" }
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0213",
					Text = "You found a harmful trace of Chronos, now a trace of Typhon's next? Glad there's no real sign of them from where {#Emph}we {#Prev}sit... besides their scattered forces and the devastation that they caused, but that can be cleared up!" },
			},

			ApolloAboutHelios01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "N" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0224",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "It's complicated who owns what up here. You know Helios the Sun? He's back to tramping across the sky in his chariot like nothing's changed, but he'd be lost without {#Emph}my {#Prev}light! {#Emph}Eugh{#Prev}, Titans. What can you do?" },
			},
			ApolloAboutZagreus01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0214",
					Text = "So pleased you finally got to meet your brother by the way! Me, I have {#Emph}more {#Prev}than enough of those, but if you grew up as an only child, you could probably use one. And it's never too late to make up for lost time." },
			},

			ApolloPostTrueEnding01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0208",
					Text = "It was a joy and honor to accompany you to the Crossroads on Selene's silver chariot, Cousin. The ballad Artemis and I performed... that's the first we jointly composed. We don't always get along but you inspired us." },
			},
			ApolloAboutUnderworld01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAny = { "NeoChronosAboutTartarus01", "NeoChronosAboutTartarus01_B" }
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
					NamedRequirementsFalse = { "StandardPackageBountyActive" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0212",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Even though your mother and father are back, you can't just stroll down to the bottom of the Underworld, can you? Finding remnants of Chronos means re-creating the conditions in which you faced him before, something like that...?" },
			},

			ApolloPostEpilogue01 =
			{
				PlayOnce = true,
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					NamedRequirements = { "ReachedEpilogue" },
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0215",
					Text = "The Fates are back, all three of them, sunshine! Such a relief to feel their prophecies again. They even now foretell the dawning of a new and different age. Plenty of time to prepare... though let's make the most of it, right?" },
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
					{
						PathFalse = { "CurrentRun", "BiomesReached", "P" },
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
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
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
			ApolloChat21 =
			{
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
				{ Cue = "/VO/Apollo_0257",
					Text = "My light normally can't reach the depths of the Underworld, but you can change all that!" },
			},
			ApolloChat22 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0258",
					Text = "We're all in this together till the end, sunshine! Whenever {#Emph}that {#Prev}is going to be, right?" },
			},
			ApolloChat23 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0259",
					Text = "I don't like getting swept up in family affairs, but I couldn't exactly sit {#Emph}this {#Prev}one out." },
			},
			ApolloChat24 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0260",
					Text = "As god of prophecies, I'm certain that we're going to succeed." },
			},
			ApolloChat25 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "TextLinesRecord", "ApolloGift04" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0261",
					Text = "Talent runs in the family! Some of us just wound up with a bigger share." },
			},
			ApolloChat26 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "GameState", "ReachedTrueEnding" },
					},
					{
						PathTrue = { "CurrentRun", "BiomesReached", "F" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0262",
					Text = "Look at you, strutting through that Underworld as though you own the place!" },
			},
			ApolloChat27 =
			{
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
				{ Cue = "/VO/Apollo_0263",
					Text = "Don't know how you managed all this time without so much as a ray of light down there." },
			},
			ApolloChat28 =
			{
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
				{ Cue = "/VO/Apollo_0264",
					Text = "What sort of light can I provide for you today?" },
			},
			ApolloChat29 =
			{
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
				{ Cue = "/VO/Apollo_0265",
					Text = "Don't know about you, but I've got a good feeling about how this is going to go!" },
			},
			ApolloChat30 =
			{
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
				{ Cue = "/VO/Apollo_0266",
					Text = "You were a little easier to spot with twin torches in hand!" },
			},
			ApolloChat31 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						Path = { "GameState", "SpentShrinePointsCache" },
						Comparison = ">=",
						Value = 10,
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0267",
					Portrait = "Portrait_Apollo_Serious_01",
					Text = "Such a dark and oppressive night this is shaping up to be..." },
			},
			ApolloChat32 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0268",
					Text = "Before you go charging off to battle and glory once more, please, allow me!" },
			},
			ApolloChat33 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0269",
					Text = "May this blessing be of benefit every step of the way tonight." },
			},
			ApolloChat34 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0270",
					Text = "For all the Boons we've offered, you've given us quite the blessing in exchange." },
			},
			ApolloChat35 =
			{
				GameStateRequirements =
				{
					{
						PathFalse = { "CurrentRun", "UseRecord", "ApolloUpgrade" }
					},
					{
						PathTrue = { "PrevRun", "Cleared" },
					},
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0271",
					Text = "I like being the god of many things... so many passions, and all the time in the world!" },
			},

		},

		BoughtTextLines =
		{
			ApolloBlindBox01 =
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
						Path = { "UseRecord", "ApolloUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0225",
					Emote = "PortraitEmoteCheerful",
					Text = "Perhaps you knew this Boon was going to be mine, for how can my light be contained, even in a heavy parcel? It must have been glowing a {#Emph}little {#Prev}at least, right?" },
			},
			ApolloBlindBox02 =
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
						Path = { "UseRecord", "ApolloUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0226",
					Emote = "PortraitEmoteCheerful",
					Text = "Normally my light makes it easy to spot whoever needs a blessing or a smiting, but you always seem to be in shadow! Fortunately, Charon seems to know how to get a hold of you!" },
			},
			ApolloLootBought01 =
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
						Path = { "UseRecord", "ApolloUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
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
					{
						FunctionName = "RequiredAlive",
						FunctionArgs = { Units = { "NPC_Charon_01" }, },
					},
					{
						SumPrevRooms = 6,
						Path = { "UseRecord", "ApolloUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0063",
					Text = "We have to reach you however we can, and Charon's been more than keen to oblige. Bit of an odd fellow, but then, aren't we all?" },
			},
			ApolloLootBought03 =
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
						Path = { "UseRecord", "ApolloUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0227",
					Text = "That Boatman's something of a coin collector, isn't he? Well, once we're finished with old Chronos, all those Gold Crowns of his will be extremely rare collector's items!" },
			},
			ApolloLootBought04 =
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
						Path = { "UseRecord", "ApolloUpgrade" },
						Comparison = "<=",
						Value = 0,
					},
					
				},
				PreEventFunctionName = "BoonInteractPresentation", PreEventFunctionArgs = { PickupWait = 1.0, },
				{ Cue = "/VO/Apollo_0228",
					Text = "We started working with Charon back when we had to figure out a system to transport all the mortal dead down to your father's realm. Must be more pleasant hauling messages from us!" },
			},
		},

		RejectionTextLines =
		{
			ApolloRejection01 =
			{
				{ Cue = "/VO/Apollo_0064",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "You wound me, Cousin. After everything we've been through together, you'd brush me off so easily?" },
			},
			ApolloRejection02 =
			{
				{ Cue = "/VO/Apollo_0065",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "{#Emph}Augh! {#Prev}Now really isn't the time for petty squabbles, but I'm afraid you leave me with no choice..." },
			},
			ApolloRejection03 =
			{
				{ Cue = "/VO/Apollo_0103",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Emote = "PortraitEmoteSurprise",
					Text = "Not your first choice?! Perhaps you haven't heard, so I'll enlighten you: My generosity is not unlimited." },
			},
			ApolloRejection04 =
			{
				{ Cue = "/VO/Apollo_0104",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "I have few weak points, but my pride is one. You got me where it hurts, so now I've got to get you back." },
			},
			ApolloRejection05 =
			{
				{ Cue = "/VO/Apollo_0105",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Was it something I said or did? Or perhaps you don't respect my power. Even when it's turned against you thus?" },
			},
			ApolloRejection06 =
			{
				{ Cue = "/VO/Apollo_0106",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "I go out of my way to offer you my strength, and you refuse? That's not something any self-respecting god can abide." },
			},
			ApolloRejection07 =
			{
				{ Cue = "/VO/Apollo_0107",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Come on, sunshine, why the snub? You should know that when my feelings get hurt, it's never the only thing." },
			},
			ApolloRejection08 =
			{
				{ Cue = "/VO/Apollo_0108",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "I have a reputation to live up to. I can't just let you brush me off like some pathetic commoner with nothing but a prayer!" },
			},
			ApolloRejection09 =
			{
				{ Cue = "/VO/Apollo_0109",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Perhaps someday we'll all be able to resolve our differences more sensibly. But we're the gods, and we're a family, damn it!" },
			},
			ApolloRejection10 =
			{
				{ Cue = "/VO/Apollo_0110",
					Portrait = "Portrait_Apollo_Displeased_01",
					PreLineFunctionName = "BoonInteractPresentation",
					PreLineFunctionArgs = PresetEventArgs.RejectionBoonInteract,
					PreLineWait = 1.0,
					Text = "Beneath this sunny disposition, I have something of a vengeful streak, Cousin. Though I know actions speak louder than words." },
			},

		},

		RejectionVoiceLines =
		{
			[1] = { GlobalVoiceLines = "GodRejectedVoiceLines" },
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
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
				UnfilledIcon = "EmptyHeartWithProphecyIcon",
				FilledIcon = "FilledHeartWithProphecyIcon",
				Cost =
				{
					GiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/Melinoe_0503", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1760", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
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
			ApolloGift05 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1761", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "My glorious cousin! It was you who first reached out to me of all those on Olympus. I've come this far because of you, and no matter what happens, I'll never forget the kindness you showed me." },
				{ Cue = "/VO/Apollo_0165",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "Come on, the pleasure is mine! It's not all sunshine on Olympus recently. But then I hear from you, and I'm left feeling everything will be all right. Don't quite know how that happened, but I'm very grateful that we met." },
			},
			ApolloGift06 =
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
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
				},
				{ Cue = "/VO/MelinoeField_1762", UsePlayerSource = true,
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Dear Cousin, you must have Nectar in no short supply. But I know that the depth of the sentiment is what distinguishes one bottle from the next. So please accept this one; it should be good." },
				{ Cue = "/VO/Apollo_0166",
					PortraitExitWait = 1.0,
					NarrativeContextArt = "DialogueBackground_Olympus",
					Text = "I'm an Olympian; I'm used to glad-handers and sycophants. Everybody wants our favor, right? And I can smile and nod better than anyone, even Father. Yet with you... well, if only we had more chances to talk than trade in courtesies..." },
			},
			-- bond forged
			ApolloGift07 =
			{
				PlayOnce = true,
				OnGiftTrack = true,
				LockedHintId = "Codex_ApolloGiftHint01",
				CompletedHintId = "Codex_BondForgedApollo",
				UnfilledIcon = "EmptyHeartWithAmbrosiaIcon",
				FilledIcon = "FilledHeartWithAmbrosiaIcon",
				Cost =
				{
					SuperGiftPoints = 1,
				},
				GameStateRequirements =
				{
					{
						PathTrue = { "GameState", "UseRecord", "ApolloUpgrade" },
					},
					{
						Path = { "CurrentRun", "CurrentRoom", "Name" },
						IsNone = { "H_Bridge01" },
					},
					{
						Path = { "GameState", "TextLinesRecord" },
						HasAll = { "ApolloAboutRelationship01", "ApolloGift06" }
					},
					{
						PathTrue = { "GameState", "RoomsEntered", "Q_Story01" },
					},
				},
				{ Cue = "/VO/MelinoeField_3827", UsePlayerSource = true,
					Portrait = "Portrait_Mel_Proud_01",
					PreLineAnim = "MelTalkExplaining01", PreLineAnimTarget = "Hero",
					PostLineAnim = "MelinoeIdleWeaponless", PostLineAnimTarget = "Hero",
					PostLineFunctionName = "BoonInteractPresentation",
					PostLineFunctionArgs = { SkipAnim = true },
					PostLineRemoveContextArt = true,
					Text = "Lord Apollo, my cousin, my friend! This Ambrosia reminds me of the moment I first saw your father's palace and heard your wondrous song. Thank you for letting me see our world in a new light, and for always believing in me." },
				{ Cue = "/VO/Apollo_0168",
					PortraitExitWait = 1.0,
					Emote = "PortraitEmoteSparkly",
					NarrativeContextArt = "DialogueBackground_Olympus",

					PostLineThreadedFunctionName = "MaxedRelationshipPresentation",
					PostLineThreadedFunctionArgs = { Text = "NPC_Apollo_01", Icon = "Keepsake_Apollo" },

					Text = "Believing in you couldn't have been easier, Lady Melinoë, even without this Ambrosia dancing with moon beams from the Crossroads. I feel truly blessed to have met you, and that my sister found you when she did. You're the greatest boon our family has received in a long, long time." },
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
				Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },
				GameStateRequirements =
				{
					OrRequirements =
					{
						{
							{
								Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
								IsNone = { "ApolloUpgrade" },
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
				{ Cue = "/VO/Apollo_0145", Text = "We'll shine so bright it hurts!" },
				{ Cue = "/VO/Apollo_0146", Text = "No hiding from {#Emph}this {#Prev}light!" },
				-- { Cue = "/VO/Apollo_0147", Text = "Then let's enlighten them!" },
				{ Cue = "/VO/Apollo_0148", Text = "Time for a dazzling display!" },
				{ Cue = "/VO/Apollo_0217", Text = "The light of the sun!", PlayFirst = true },
				{ Cue = "/VO/Apollo_0218", Text = "Music to my ears!" },
			},
			{
				RandomRemaining = true,
				GameStateRequirements =
				{
					{
						Path = { "CurrentRun", "CurrentRoom", "Encounter", "SpurnedGodName" },
						IsAny = { "ApolloUpgrade" },
					},
					{
						PathFalse = { "CurrentRun", "CurrentRoom", "Encounter", "Completed" },
					},
					NamedRequirements = { "FullSuperVoiceLinesEligible" },
				},

				{ Cue = "/VO/Apollo_0219", Text = "Oh {#Emph}now {#Prev}you want my aid?", PlayFirst = true },
				{ Cue = "/VO/Apollo_0220", Text = "Well I don't see why not!" },
				{ Cue = "/VO/Apollo_0221", Text = "We're being cheeky now!" },
			},
			{
				RandomRemaining = true,
				ObjectTypes = { "NPC_Artemis_Field_01" },
				PreLineWait = 0.35,
				SuccessiveChanceToPlay = 0.5,
				SkipCooldownCheckIfNonePlayed = true,
				Cooldowns =
				{
					{ Name = "ArtemisAnyQuipSpeech", Time = 6 },
				},

				{ Cue = "/VO/Artemis_0464", Text = "Hey little brother!" },
				{ Cue = "/VO/Artemis_0465", Text = "Apollo?!", PlayFirst = true },
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

				{ Cue = "/VO/Chronos_1261", Text = "Far too much blasted light..." },
				{ Cue = "/VO/Chronos_1262", Text = "The light of the {#Emph}sun?!" },
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

				{ Cue = "/VO/Zagreus_0360", Text = "It's Apollo...!", PlayFirst = true },
				{ Cue = "/VO/Zagreus_0361", Text = "Hi Apollo...!" },
			},

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
			{ GlobalVoiceLines = "ZagreusRarifyVoiceLines" },
			{
				RandomRemaining = true,
				BreakIfPlayed = true,
				PreLineWait = 0.3,
				Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },
				Cooldowns =
				{
					{ Name = "BoonRarifiedSpeech", Time = 240 },
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
		},

		BlindBoxOpenedVoiceLines =
		{
			RandomRemaining = true,
			BreakIfPlayed = true,
			PreLineWait = 0.3,
			Source = { LineHistoryName = "NPC_Apollo_01", SubtitleColor = Color.ApolloVoice },
			TriggerCooldowns = { "ApolloBoonTakenSpeech", "MelinoeBoonTakenSpeech" },

			{ Cue = "/VO/Apollo_0119", Text = "Hello, sunshine!" },
			{ Cue = "/VO/Apollo_0120", Text = "Hello, Cousin!" },
			{ Cue = "/VO/Apollo_0121", Text = "Guess who, sunshine?" },
			{ Cue = "/VO/Apollo_0122", Text = "Greetings from Olympus!" },
			{ Cue = "/VO/Apollo_0123", Text = "At your service!" },
			{ Cue = "/VO/Apollo_0124", Text = "Surprise, surprise!" },
		},

	},

	Using = { Animation = "ApolloAoEStrikeRapid", },
}

OverwriteTableKeys( LootData, LootSetData.Apollo )